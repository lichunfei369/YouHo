//
//  LCFMyViewController.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/18.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "LCFMyViewController.h"
#import "LoginViewController.h"
#import "LCFTaBarViewController.h"
#import "YMUtils.h"
#import "MyTitleImageTag.h"
#import "MyTopHeadView.h"
#import "UIView+PS.h"

#import "MyCollectionCell.h"
#import "FootCollectionViewCell.h"
#import "StrollCollectionViewCell.h"
#import "SecendCollectionViewCell.h"
#import "IniformViewController.h"
#import "SettingViewController.h"
#import "ShopCollectionViewCell.h"

#import "ShopDetailsViewController.h"

#import "PersonnaViewController.h"
@interface LCFMyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,MyTopHeadViewDelegation,PersonnaViewControllerDelegate>

/**
 标记跳转登陆页面
 */
@property   (nonatomic,assign)  BOOL        loginTag;

/**
 头部view
 */
@property   (nonatomic,retain)  MyTopHeadView     *   tophead;

@property   (nonatomic,retain)  UICollectionView  *   collectionview;

@property   (nonatomic ,retain) UIButton          *   heardGroud;

@property   (nonatomic ,retain) NSMutableArray    *   DataArray;

@end

@implementation LCFMyViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置nagation  颜色
    
    self.navigationController.navigationBar.barTintColor = YM_RGBA(100, 31., 35.,1.);
    self.navigationItem.title = @"My";
    self.view.backgroundColor = YM_RGBA(240.,242.,245,1.) ;
    [self.view addSubview:self.collectionview];
    
    
    // 判断登陆时机
//    if (![YMUtils loginParam]) {
//        if (self.loginTag) {
//            LCFTaBarViewController * tabbarC = (LCFTaBarViewController *)self.tabBarController;
//            self.tabBarController.selectedIndex = tabbarC.lastSelecteIndex;
//            self.tabBarController.tabBar.hidden = NO;
//            self.loginTag = NO;
//        }
//    }
//    if (![YMUtils loginParam]) {
//        if (!self.loginTag) {
//            LoginViewController * login = [[LoginViewController alloc]init];
//            login.title = @"Login ";
//            self.tabBarController.tabBar.hidden = YES;
//            login.hidesBottomBarWhenPushed= YES;
//            [self.navigationController pushViewController:login animated:NO];
//            self.hidesBottomBarWhenPushed = NO;
//            self.loginTag = YES;
//        }
//    }
   
    
    UIBarButtonItem * leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"information_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(ClickleftBarButtonItem:)];
    leftBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStylePlain target:self action:@selector(ClickrightButtonItem:)];
    rightBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
    [self plistPathWithShareUrl];
    
    
}


//滑动显示导航栏
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    //scrollView已经有拖拽手势，直接拿到scrollView的拖拽手势
//    UIPanGestureRecognizer *pan = scrollView.panGestureRecognizer;
//    //获取到拖拽的速度 >0 向下拖动 <0 向上拖动
//    CGFloat velocity = [pan velocityInView:scrollView].y;
//    
//    if (velocity <- 5) {
//        //向上拖动，显示导航栏
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//    }else if (velocity > 5) {
//        //向下拖动，隐藏导航栏
//        
//       [self.navigationController setNavigationBarHidden:YES animated:YES];
//    }else if(velocity == 0){
//        //停止拖拽
//       [self.navigationController setNavigationBarHidden:YES animated:YES];
//    }
//}

#pragma mark ----------------      UICollectionView

- (UICollectionView *)collectionview {
    
    if (!_collectionview) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT) collectionViewLayout:layout];
        collectionView.backgroundColor = YM_RGBA(240.,240.,240,1.) ;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        /* 自使用高度*/
        collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        collectionView.showsVerticalScrollIndicator = NO;//不显示滑动条
        collectionView.alwaysBounceVertical = YES;//内容不超过collectionView时也可以滑动
        /* 注册头部   和 注册cell*/
        [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerID"];
        
        [collectionView registerClass:[MyCollectionCell class] forCellWithReuseIdentifier:@"mycell"];
        [collectionView registerClass:[MyCollectionCell class] forCellWithReuseIdentifier:@"myassets"];
        [collectionView registerClass:[FootCollectionViewCell class] forCellWithReuseIdentifier:@"Footcell"];
        [collectionView registerClass:[FootCollectionViewCell class] forCellWithReuseIdentifier:@"cellfoot"];
        [collectionView registerClass:[StrollCollectionViewCell class] forCellWithReuseIdentifier:@"Stroll"];
        [collectionView registerClass:[SecendCollectionViewCell class] forCellWithReuseIdentifier:@"secendCell"];
        [collectionView registerClass:[ShopCollectionViewCell class] forCellWithReuseIdentifier:@"shopcell"];
        
        
        
        
        _collectionview = collectionView;
    }
    return _collectionview;
}

/* 头像信息设置 */
- (void)setHeardShareManagerWithPush:(UIButton *)sender {
    
    PersonnaViewController * person = [[PersonnaViewController alloc] init];
    person.delegate = self;
    
    person.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:person animated:YES];
}

- (void) heardWithSharMagerImage:(UIImageView *)image {
    
//    _tophead.heard_icon.image = image.image;
    
    [_tophead.heard_icon setImage:image.image forState:UIControlStateNormal];
}

#pragma mark --------------------    数据源

- (void)plistPathWithShareUrl {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Resources" ofType:@"plist"];
    self.DataArray = [NSMutableArray arrayWithCapacity:0];
    self.DataArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
}




#pragma mark       ----------------- 头部头像设置  
-(MyTopHeadView *)tophead{
    
    if (!_tophead) {
        _tophead = [[MyTopHeadView alloc]init];
        _tophead.delegation = self;
        _tophead.userInteractionEnabled = YES;
        _tophead.frame = CGRectMake(0, 0, LCF_SCREEN_WIDTH, 220);
    }
    
    //通知
    __weak LCFMyViewController *weakSelf = self;
    _tophead.inform = ^(){
       
        IniformViewController * iniforVC = [[IniformViewController alloc] init];
        iniforVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:iniforVC animated:YES];
        
    };
    //设置
    _tophead.setting = ^ () {
        SettingViewController * setting = [[SettingViewController alloc] init];
        setting.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:setting animated:YES];
    };
    
    return _tophead;
}


#pragma  mark- 设置偏移量Frame
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    
//    CGFloat offset_Y = scrollView.contentOffset.y;
//    
//    //    NSLog(@"上下偏移量 OffsetY:%f ->",offset_Y);
//    
//    //1.处理图片放大
//    CGFloat imageH = self.tophead.headGuidance.size.height;
//    CGFloat imageW = LCF_SCREEN_WIDTH;
//    
//    //下拉
//    if (offset_Y < 0)
//    {
//        CGFloat totalOffset = imageH + ABS(offset_Y);
//        CGFloat f = totalOffset / imageH;
//        
//        //如果想下拉固定头部视图不动，y和h 是要等比都设置。如不需要则y可为0
//        self.tophead.topHead_image.frame = CGRectMake(-(imageW * f - imageW) * 0.5, offset_Y, imageW * f, totalOffset);
//    }
//    else
//    {
//        self.tophead.topHead_image.frame = self.tophead.bounds;
//    }
//    
//}


-(UIButton *)heardGroud {
    
    if (!_heardGroud) {
        _heardGroud = [UIButton buttonWithType:UIButtonTypeCustom];
        _heardGroud.layer.cornerRadius = 50;
        [_heardGroud setImage:[UIImage imageNamed:@"head_image"] forState:UIControlStateNormal];
        _heardGroud.backgroundColor = [UIColor whiteColor];
        _heardGroud.clipsToBounds = TRUE;//去除边界
    }
    
    return _heardGroud;
}


#pragma mark -- ------------------------   UICollectionViewDataSource
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 5;
}
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 6;
    }else if (section == 1){
        return 5;
    }else if (section == 2){
        return 2;
    }else if (section == 3){
        return 1;
    }
    
    return self.DataArray.count;
    
}
//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.item == 0) {
        MyCollectionCell * allOrderCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mycell" forIndexPath:indexPath];
            /*cell颜色
                            allOrderCell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
             */
            
            
             allOrderCell.orderLabel.text = @"我的订单";
             allOrderCell.allOderLabel.text = @"查看全部订单";
 
            return allOrderCell;
        
    }else{
 
    FootCollectionViewCell * footCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Footcell" forIndexPath:indexPath];
    switch (indexPath.item) {
        case 1:
            
            footCell.title_icon.image = [UIImage imageNamed:@"panpay_icon"];
            footCell.titleLabel.text = @"待付款";
           
            break;
        case 2:
         
            footCell.title_icon.image = [UIImage imageNamed:@"deliverGoods"];
            footCell.titleLabel.text = @"待发款";
            
            break;
        case 3:
            footCell.title_icon.image = [UIImage imageNamed:@"Receipt_of_ goods"];
            footCell.titleLabel.text = @"待收款";
    
            break;
        case 4:
            footCell.title_icon.image = [UIImage imageNamed:@"Sun"];
            footCell.titleLabel.text = @"待晒单";
            
            break;
        case 5:
            footCell.title_icon.image = [UIImage imageNamed:@"Return_goods"];
            footCell.titleLabel.text = @"退/换货";
            
            break;
        default:
            break;
            
        }
         return footCell;
        }
    }else if (indexPath.section == 1){
        if (indexPath.item == 0) {
            MyCollectionCell * myAssets = [collectionView dequeueReusableCellWithReuseIdentifier:@"myassets" forIndexPath:indexPath];
            myAssets.orderLabel.text = @"我的资产";
            
            
                return myAssets;
        
        }else{
        
        FootCollectionViewCell * zichan = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellfoot" forIndexPath:indexPath];
        
        switch (indexPath.item) {
            case 1:
                
                zichan.title_icon.image = [UIImage imageNamed:@"youhuiquan"];
                zichan.titleLabel.text = @"优惠券";
                
                break;
            case 2:
                
                zichan.title_icon.image = [UIImage imageNamed:@"monry"];
                zichan.titleLabel.text = @"有货币";
                
                break;
            case 3:
                zichan.title_icon.image = [UIImage imageNamed:@"xiangou"];
                zichan.titleLabel.text = @"限购码";
                
                break;
            case 4:
                zichan.title_icon.image = [UIImage imageNamed:@"fuwufankui"];
                zichan.titleLabel.text = @"服务反馈";
                
                break;
            
            default:
                break;

        }

        return zichan;
        }
        
    }else if (indexPath.section == 2){
        SecendCollectionViewCell * secendCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"secendCell" forIndexPath:indexPath];
        switch (indexPath.item) {
            case 0:
                secendCell.stroll.text = @"我的逛";
                secendCell.titleImage.image = [UIImage imageNamed:@"heart"];
                break;
            case 1:
                secendCell.stroll.text = @"我的晒单";
                secendCell.titleImage.image = [UIImage imageNamed:@"Sun"];
                break;
            default:
                break;
        }
       
       
        return secendCell;
    }else if (indexPath.section == 3){
        
        StrollCollectionViewCell  * stroll = [collectionView dequeueReusableCellWithReuseIdentifier:@"Stroll" forIndexPath:indexPath];
        [stroll.footImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img10.static.yhbimg.com/yhb-img01/2016/12/16/10/017bac439101a4aaa752c939b3c63fd726.jpg?imageView2/2/w/378/h/248/q/90"]];
         return stroll;
    }
    
    ShopCollectionViewCell * shopcell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shopcell" forIndexPath:indexPath];
    [shopcell.shopimage sd_setImageWithURL:[NSURL URLWithString:[self.DataArray valueForKey:@"background"][indexPath.row]]];
    shopcell.titile.text = [self.DataArray valueForKey:@"title"][indexPath.row];
    shopcell.price.text = [self.DataArray valueForKey:@"detail"][indexPath.row];
    
    return shopcell;
    
    
    
   
    
}


#pragma mark    --------------------  UICollectionViewFlowLayout


-( UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView * headerView = nil;
    if (indexPath.section == 0) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerID" forIndexPath:indexPath];//根据id取出注册的头部view
            if (headerView == nil) {
                headerView = [[UICollectionReusableView alloc] init];
            }
            [headerView addSubview:self.tophead];
            
            
        }
    }
    
    return headerView;
}

//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
  
    if (section == 4) {
    return UIEdgeInsetsMake(0, 20, 0, 20);
    }
    
    return UIEdgeInsetsMake(0, 0, 5, 0);
    
}
//竖向间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 5.f;
}
//横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (!section) {
        return 0.;
    }
    return 8.f;
} //设置头部大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
   
    if (section) {
        return (CGSize){0,0};
    }
    //返回头像高度
    return (CGSize){LCF_SCREEN_WIDTH,220};
}
//设置每个item大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.item) {
            return (CGSize){LCF_SCREEN_WIDTH / 5 - .1,(LCF_SCREEN_WIDTH / 5)};
        }else{
            return (CGSize){LCF_SCREEN_WIDTH,35};
        }
        
    }else if (indexPath.section == 1){
        if (indexPath.item) {
            return (CGSize){LCF_SCREEN_WIDTH / 4.5 - .55,(LCF_SCREEN_WIDTH / 4.5)};
        }else{
            return (CGSize){LCF_SCREEN_WIDTH,35};
        }
        
    }else if (indexPath.section == 2){
        
    return (CGSize){LCF_SCREEN_WIDTH,35};
    }
    
    else if (indexPath.section == 3){
        
        return (CGSize){LCF_SCREEN_WIDTH,150};
    }
    return (CGSize){LCF_SCREEN_WIDTH /2.5 + 10,200};
}

- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout colorForSectionAtIndex:(NSInteger)section{
    
    return  YM_RGBA(240.,242.,245,1.) ;  //背景色;
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    
    if (indexPath.section == 4) {
        ShopDetailsViewController * shop = [[ShopDetailsViewController alloc] init];
        shop.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:shop animated:YES];
    }
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
