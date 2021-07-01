//
//  LCFShoppingViewController.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/18.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "LCFShoppingViewController.h"
#import "ShopDetailsViewController.h"
#import "ShoppingCarCell.h"
#import "ShoppingModel.h"
#import "ShopCenterController.h"
#import "ProductDetailsWebViewController.h"
#import "SettlementController.h"
@interface LCFShoppingViewController ()<UITableViewDataSource,UITableViewDelegate,ShoppingCarCellDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;// 数据源

@property (nonatomic,strong) UIButton *selectAllBtn;//全选按钮

@property (nonatomic,strong) UIButton *jieSuanBtn;//结算按钮

@property (nonatomic,strong) UILabel *totalMoneyLab;//总金额

@property(nonatomic,assign) float allPrice;

@end

@implementation LCFShoppingViewController


/* 这里要判断有没有加入的购物车货物  如果有 显示出货物  如果没有显示 去逛一逛的界面  */

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    /* 判断数据是否为空 如果是空那么就显示逛一逛界面 如果不是就显示当前界面 */
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.view addSubview:self.shopCart];
    self.title = @"购物车";
    
    self.dataArray = [[NSMutableArray alloc]init];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.allPrice = 0.00;
    
    [self createSubViews];
    [self initData];
    
}

/**
 * 初始化假数据
 */

-(void)initData{
    
//    for (int i = 0; i<10; i++)
//    {
//        NSMutableDictionary *infoDict = [[NSMutableDictionary alloc]init];
//        [infoDict setValue:@"detais_image.png" forKey:@"imageName"];
//        [infoDict setValue:@"钻石耳机" forKey:@"goodsTitle"];
//        [infoDict setValue:@"男士耳机" forKey:@"goodsType"];
//        [infoDict setValue:@"500.00" forKey:@"goodsPrice"];
//        [infoDict setValue:[NSNumber numberWithBool:NO] forKey:@"selectState"];
//        [infoDict setValue:[NSNumber numberWithInt:1] forKey:@"goodsNum"];
//        
//        ShoppingModel *goodsModel = [[ShoppingModel alloc]initWithShopDict:infoDict];
//        
//        [self.dataArray addObject:goodsModel];
//    }
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"product" ofType:@"json"];
    NSData *data=[NSData dataWithContentsOfFile:jsonPath];
    NSError *error;
    id jsonObject=[NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingAllowFragments
                                                    error:&error];
//    NSDictionary *productDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"product" ofType:@"json"]];
//    NSMutableArray<ShoppingModel *> *goodsModel = @[].mutableCopy;
    NSArray *productArr = [jsonObject valueForKey:@"wareInfo"];
   

    for (NSDictionary *goodsModelDic in productArr) {
        ShoppingModel *goodModel = [[ShoppingModel alloc] initWithShopDict:goodsModelDic];
        [self.dataArray addObject:goodModel];
    }
//    self.flights = flights.mutableCopy;
    


    
}

-(void)createSubViews{
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0 , LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT-160) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    self.selectAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectAllBtn.frame = CGRectMake(10,self.tableView.bottom+(50-20)/2.0, 60, 20);
    [self.selectAllBtn setImage:IMAGENAMED(@"check_n") forState:UIControlStateNormal];
    [self.selectAllBtn setImage:IMAGENAMED(@"check_p") forState:UIControlStateSelected];
    [self.selectAllBtn addTarget:self action:@selector(selectAllaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    [self.selectAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.selectAllBtn.titleLabel.font = XNFont(15.0);
    self.selectAllBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [self.view addSubview:self.selectAllBtn];
    
  
    self.totalMoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(self.selectAllBtn.right+10, self.selectAllBtn.top, LCF_SCREEN_WIDTH-self.selectAllBtn.right-30-GetWidth(184),20)];
    
    self.totalMoneyLab.textAlignment = NSTextAlignmentCenter;
    self.totalMoneyLab.font = XNFont(13.0);
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总金额:￥%.2f元",self.allPrice]];
    [str addAttribute:NSFontAttributeName value:XNFont(17) range:NSMakeRange(4,str.length-4)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,str.length-4)];
    self.totalMoneyLab.attributedText = str;
    
    
    [self.view addSubview:self.totalMoneyLab];

    
    self.jieSuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.jieSuanBtn.frame = CGRectMake(LCF_SCREEN_WIDTH-GetWidth(184)-10,self.tableView.bottom+(50-GetHeight(74))/2.0,GetWidth(184), GetHeight(74));
    [self.jieSuanBtn setBackgroundColor:RGBACOLOR(0, 189, 155, 1)];
    [self.jieSuanBtn addTarget:self action:@selector(jieSuanAction) forControlEvents:UIControlEventTouchUpInside];
    self.jieSuanBtn.layer.masksToBounds = YES;
    self.jieSuanBtn.layer.cornerRadius = GetHeight(74)/2.0;
    [self.jieSuanBtn setTitle:@"结算" forState:UIControlStateNormal];
    
    [self.jieSuanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.jieSuanBtn.titleLabel.font = XNFont(15.0);
    self.jieSuanBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [self.view addSubview:self.jieSuanBtn];
//
    
    
}
//结算
-(void)jieSuanAction{
    
    SettlementController * settlement = [[SettlementController alloc] init];
    [self.navigationController pushViewController:settlement animated:YES];
    
    
}
//全选
-(void)selectAllaction:(UIButton *)sender{
    
    
    sender.tag = !sender.tag;
    if (sender.tag)
    {
        sender.selected = YES;
    }else{
        sender.selected = NO;
        
    }
    //改变单元格选中状态
    for (int i=0; i<self.dataArray.count;i++)
    {
        ShoppingModel *model = self.dataArray[i];
        model.selectState = sender.tag;
    }
    
    [self CalculationPrice];
    
    [self.tableView reloadData];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellStr = @"ShopCarCell";
    
    ShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    
    if(!cell){
        
        cell = [[ShoppingCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        
        
    }
   
    cell.delegate = self;
    cell.shoppingModel = self.dataArray[indexPath.row];
    __weak LCFShoppingViewController *weakSelf = self;
    cell.selectHandle = ^(){
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
        [weakSelf CalculationPrice];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    return 110;
}

//按钮显示的内容
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return @"删除";
    
}
//这里就是点击删除执行的方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.dataArray removeObjectAtIndex:indexPath.row];
    
//    ShoppingCarCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self CalculationPrice];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    
    
    
}

//单元格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    
    
    /* 原本打算自己写这个SKU界面但是一般公司这个界面会做H5交互 所以换成H5交互界面 */
    
//    ShopCenterController * shopCenter = [[ShopCenterController alloc]init];
//    /* 这句隐藏TabBar底部 */
//    shopCenter.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:shopCenter animated:YES];
    
    
    ProductDetailsWebViewController *webVC = [[ProductDetailsWebViewController alloc]init];
    webVC.title = @"商品详情";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}


#pragma mark -- 实现加减按钮点击代理事件
/**
 * 实现加减按钮点击代理事件
 *
 * @param cell 当前单元格
 * @param flag 按钮标识，11 为减按钮，12为加按钮
 */



-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    switch (flag) {
        case 11:
        {
            //做减法
            //先获取到当期行数据源内容，改变数据源内容，刷新表格
            ShoppingModel *model = self.dataArray[index.row];
            if (model.goodsNum > 1)
            {
                model.goodsNum --;
            }
        }
            break;
        case 12:
        {
            //做加法
            ShoppingModel *model = self.dataArray[index.row];
            model.goodsNum ++;
        }
            break;
        default:
            break;
    }
    //刷新表格
    [self.tableView reloadData];
    //计算总价
    [self CalculationPrice];
}
//计算价格
-(void)CalculationPrice
{
    //遍历整个数据源，然后判断如果是选中的商品，就计算价格(单价 * 商品数量)
    for ( int i =0; i<self.dataArray.count;i++)
    {
        ShoppingModel *model = self.dataArray[i];
        if (model.selectState)
        {
            self.allPrice = self.allPrice + model.goodsNum *[model.goodsPrice floatValue];
        }
    }
    //给总价赋值
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总金额:￥%.2f元",self.allPrice]];
    [str addAttribute:NSFontAttributeName value:XNFont(17) range:NSMakeRange(4,str.length-4)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,str.length-4)];
    self.totalMoneyLab.attributedText = str;

    self.allPrice = 0.0;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
