//
//  CategoryMenuViewController.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/26.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "CategoryMenuViewController.h"
#import "JSDropDownMenu.h"
@interface CategoryMenuViewController ()<JSDropDownMenuDelegate,JSDropDownMenuDataSource>{
    
    NSMutableArray * _dataone;
    NSMutableArray * _datatwo;
    NSMutableArray * _datathree;
    
    NSInteger _currentDataoneIndex;
    NSInteger _currentDataTwoIndex;
    NSInteger _currentDataThreeIndex;
}


@end

@implementation CategoryMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        [self topClassMenu];
}

- (void)topClassMenu {
    NSArray * food = @[@"潮流女装",@"时尚羽绒",@"轻薄羽绒",@"中长款羽绒",@"针织裙",@"毛呢大衣",@"温暖棉服",@"针织衫"];
    NSArray * travel = @[@"品牌男装",@"时尚羽绒",@"保暖棉服",@"修身夹克",@"牛仔裤",@"休闲裤",@"西裤",@"精品衬衫",@"毛呢大衣"];
    
    _dataone = [NSMutableArray arrayWithObjects:@{@"title":@"潮流女装",@"data":food},@{@"title":@"精品男装",@"data":travel}, nil];
    _datatwo = [NSMutableArray arrayWithObjects:@"只能排序",@"离我最近",@"评价最高",@"最新发布",@"人气最高",@"价格最低",@"价格最高", nil];
    _datathree = [NSMutableArray arrayWithObjects:@"不限人数",@"单人餐",@"双人餐",@"3~4人餐", nil];
    JSDropDownMenu * menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:45];
    menu.indicatorColor = YM_RGBA(175., 175., 175., 1.);
    menu.separatorColor = YM_RGBA(210., 210., 210., 1.);
    menu.textColor = [UIColor blackColor];
    
    menu.dataSource = self;
    menu.delegate = self;
    [self.view addSubview:menu];
    
    
}

-(NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu{
    
    return 3;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    if (column == 2) {
        return YES;
    }
    return NO;
    
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    if (column == 0) {
        return YES;
    }
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    if (column == 0) {
        return 0.3;
    }
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column ==0) {
        return _currentDataoneIndex;
    }
    if (column == 1) {
        return _currentDataTwoIndex;
    }
    return 0;
}

-(NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    if (column == 0) {
        if (leftOrRight == 0) {
            return _dataone.count;
        }else{
            NSDictionary * menuDic = [_dataone objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] count];
        }
    }else if (column == 1){
        return _datatwo.count;
        
    }else if (column == 2){
        
        return _datathree.count;
    }
    return 0;
}
-(NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    switch (column) {
        case 0:
            return [[_dataone[0] objectForKey:@"data"] objectAtIndex:0];
            break;
        case 1:
            return _datatwo[0];
        case 2:
            return _datathree[0];
            
        default:
            return  nil;
            break;
    }
}

-(NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath{
    
    if (indexPath.column == 0) {
        
        if (indexPath.leftOrRight == 0) {
            NSDictionary *menuDic = [_dataone objectAtIndex:indexPath.row];
            return [menuDic objectForKey:@"title"];
        }else{
            
            NSInteger leftRow = indexPath.leftRow;
            NSDictionary * menuDic = [_dataone objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
        }
    }else if (indexPath.column == 1){
        
        return _datatwo[indexPath.row];
    }else{
        
        return _datathree[indexPath.row];
    }
    
    
    
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        
        if(indexPath.leftOrRight==0){
            
            _currentDataoneIndex = indexPath.row;
            
            return;
        }
        
    } else if(indexPath.column == 1){
        
        _currentDataTwoIndex = indexPath.row;
        
    } else{
        
        _currentDataThreeIndex = indexPath.row;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
