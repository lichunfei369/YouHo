//
//  LCFCategoryViewController.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/18.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "LCFCategoryViewController.h"
#import "YYDeerShopRequest.h"
#import "CategoryCollectionViewCell.h"
#import "CategoryTableViewCell.h"
#import "CategoryModel.h"
#import "CategoryListingController.h"
@interface LCFCategoryViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

{
    NSArray * dataArr;
    NSArray * myData;
    NSMutableArray * item;
    
}

@property (nonatomic, strong) UICollectionView *rightCollectionView;

@property (nonatomic ,assign) NSInteger selectedIndex;

@property (nonatomic ,retain) UITableView      *tableview;
@property (nonatomic,strong) NSMutableArray *collectionViewItem;


@end

@implementation LCFCategoryViewController

-(NSMutableArray *)collectionViewItem
{
    if (_collectionViewItem == nil) {
        _collectionViewItem = [NSMutableArray array];
    }
    return _collectionViewItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self RequestSetDataClassification];
    
     [self CreatRightCollectionView];
//    dataArr = [NSArray array];
//    myData = [NSArray array];
//    dataArr = [[NSArray alloc]initWithObjects:@"推荐分类", @"潮流女装",@"品牌男装",@"酒水饮料",@"家用电器",@"手机数码",@"电脑办公",@"图书",@"居家生活",@"运动户外",@"玩具乐器",@"钟表珠宝",@"食品生鲜",@"奢侈礼品",@"汽车用品",@"生活旅行",nil];
//    myData = [[NSArray alloc]initWithObjects:@"笔记本",@"休闲裤",@"牛仔裤",@"手机",@"净化器",@"火锅",@"OPPO",@"面膜",@"漱口水",@"测试",@"测试1", nil];
//    
    
    item = [NSMutableArray arrayWithCapacity:0];
}
- (void)RequestSetDataClassification {
    
    __weak typeof (self) weakSelf = self;
    [YYDeerShopRequest GetWithShareManagerCategoryTitleImage:^(BOOL success, NSError *error, id result) {
        if (success) {
//            NSLog(@"%@",result[@"data"][@"categories"]);
                /* 解析JSON数据 */
            [weakSelf setWithCategoryRequest:result[@"data"][@"categories"]];
            /* 解析collectioin数据 */
            NSArray *subcategories = [result[@"data"][@"categories"][0] valueForKey:@"subcategories"];
            for (NSDictionary * dic in subcategories) {
                CategoryModel * model = [[CategoryModel alloc] initWithData:dic];
                [self.collectionViewItem addObject:model];
            }
        }else{
            
        }
        //请求完成之后一定刷新列表.
        [self.rightCollectionView reloadData];
        [self.tableview reloadData];
    }];
    
}
- (void)setWithCategoryRequest:(NSArray *)categoryArr {
    
    [NSMutableArray clearAllWithMutableArray:item];
    
    for (NSDictionary * dic in categoryArr) {
        CategoryModel * model = [[CategoryModel alloc] initWithData:dic];
        [item addObject:model];
    }
}


-(void)CreatRightCollectionView
{
    UICollectionViewFlowLayout *flowayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowayout.minimumInteritemSpacing = 0.f;
    flowayout.minimumLineSpacing = 0.5f;
    
    _rightCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(100, 0, self.view.frame.size.width-100, self.view.frame.size.height) collectionViewLayout:flowayout];
    /* 自使用高度*/
    _rightCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    [_rightCollectionView registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:@"RightCollectionViewCell"];
    
    [_rightCollectionView setBackgroundColor:[UIColor clearColor]];
    
    
    _rightCollectionView.delegate = self;
    _rightCollectionView.dataSource = self;
    
    [self.view addSubview:_rightCollectionView];
    
    UITableView * tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.tabBarController.tabBar.frame) - CGRectGetHeight(self.navigationController.navigationBar.frame)) style:UITableViewStylePlain];
    tableview.showsVerticalScrollIndicator =NO;
    [tableview sizeThatFits:CGSizeMake(CGRectGetWidth(tableview.bounds), CGFLOAT_MAX)];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    self.tableview = tableview;
    UIView * view = [[UIView alloc] init];
    self.tableview.tableFooterView = view;
//    self.tableview.tableFooterView = [self footerViewForSection:0];
    
    
}

//- (nullable UITableViewHeaderFooterView *)footerViewForSection:(NSInteger)section
//{
//    UITableViewHeaderFooterView *footerView  = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.superview.width, 80)];
//    //    footerView.textLabel.text =@"没有了" ;
////    [footerView setValue:footerLabel forKey:@"contentView"];
//    return footerView;
//}
#pragma mark                  UITableDataSource  TableViewDegation 

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return item.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CategoryModel * model = item[indexPath.row];
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell)
    {
        cell = [[CategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.title_label.text = model.name;
//    cell.selectionStyle = 1;//设置Cell选中效果
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    [_rightCollectionView scrollRectToVisible:CGRectMake(0, 0, self.rightCollectionView.frame.size.width, self.rightCollectionView.frame.size.height) animated:YES];
    
    
    _selectedIndex = indexPath.row;
    [self.collectionViewItem removeAllObjects];
    NSArray *subcategories = [item[indexPath.row] valueForKey:@"subcategories"];
    for (NSDictionary * dic in subcategories) {
        CategoryModel * model = [[CategoryModel alloc] initWithData:dic];
        [self.collectionViewItem addObject:model];
    }
    [_rightCollectionView reloadData];
    
}

#pragma mark                CollectionView的代理方法

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _collectionViewItem.count;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CategoryModel * model = _collectionViewItem[indexPath.row];
    
    
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RightCollectionViewCell" forIndexPath:indexPath];
    //根据左边点击的indepath更新右边内容;
    switch (_selectedIndex)
    {
        case 0:
             [cell.title_image sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
            break;
        case 1:
            [cell.title_image sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
            break;
        case 2:
             [cell.title_image sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
            break;
        case 3:
             [cell.title_image sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
            break;
        default:
            break;
    }

    cell.collection_label.text = model.name;
    [cell.title_image sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
    
    return cell;
    
    
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0, 5, 0, 10);
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 120);
    
    
}

//竖向间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 3.f;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryListingController * categorylist = [[CategoryListingController alloc] init];
    categorylist.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:categorylist animated:YES];
    
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
