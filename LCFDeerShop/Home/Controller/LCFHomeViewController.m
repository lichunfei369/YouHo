//
//  LCFHomeViewController.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/18.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "LCFHomeViewController.h"
#import "LCFBannerView.h"
#import "LCFHomeCell.h"
#import "MYSearchBar.h"
#import "SearchViewController.h"
#import "toptableview.h"

#import "TGLTableViewController.h"
#import "TGLGuillotineMenu.h"
#import "GirlViewController.h"

#import "WebViewController.h"
#import "ShopCollectionViewCell.h"
#import "StrollCollectionViewCell.h"

#import "RefreshHeader.h"
#import "LXDScanCodeController.h"
#import <AVFoundation/AVFoundation.h>
@interface LCFHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,LCFBannerViewDelegate,TGLGuillotineMenuDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,LXDScanCodeControllerDelegate,UISearchBarDelegate>

{
        NSMutableArray  *   dataSoureArray;
}
@property   (nonatomic,retain)  UIScrollView    *   scrollView;//背景滑动

@property   (nonatomic,retain)  UITableView     *   tableView;//用来展示3D滑动效果

@property   (nonatomic ,retain) UIButton        *   oldUserBtn;

@property   (nonatomic,retain)  UICollectionView  *   collectionview;

@property   (nonatomic ,retain) NSMutableArray    *   DataArray; //图片数据源



@end

@implementation LCFHomeViewController

static NSString  * const  homecell = @"ID";

#pragma mark -  数据源

- (void)plistPathWithShareUrl {
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"FocusURL" ofType:@"plist"];
    NSString *Resource = [[NSBundle mainBundle] pathForResource:@"Resources" ofType:@"plist"];
    self.DataArray = [NSMutableArray arrayWithCapacity:0];
    self.DataArray = [[NSMutableArray alloc] initWithContentsOfFile:Resource];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customsearchBar];
    
    self.navigationController.
    self.navigationItem.title = @"Marl";
    
    UIScrollView * scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT - 44)];
    scrollview.backgroundColor = [UIColor whiteColor];
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.delegate = self;
    [self.view addSubview:scrollview];
    self.scrollView = scrollview;
    
    [self setupUI];
    [self addnavigaItem];
    [self plistPathWithShareUrl];
    //下拉刷新
    [self upRefresh];

    
}
-(void)customsearchBar{
    UISearchBar *_searchBar = [[UISearchBar alloc] init];
    _searchBar.placeholder = @"  搜索";
    _searchBar.delegate = self;
     _searchBar.tintColor = [UIColor whiteColor];
    [_searchBar setImage:[UIImage imageNamed:@"searchIcon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    UIView *searchBarSub = _searchBar.subviews[0];
    // 去除UISearchbar视图里的UISearchBarBackground之后，UISearchbar的背景也就透明了，同时也可以自定义颜色等 遍历所有searchbar中的view ios 7.1以上  和7.0一下是连个方法 需要判断一下版本方法
    
    for (UIView * subview in searchBarSub.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            [subview setBackgroundColor:YM_RGBA(247., 247., 270, 1.)];
            
        }
        
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
        }
    }
    //       [titleView addSubview:_searchBar];
    //Set to titleView
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = _searchBar;

}
#pragma mark - searchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    return NO;
}
-(void)upRefresh{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    RefreshHeader *header = [RefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = NO;
    
    // 隐藏状态
    header.stateLabel.hidden = YES;
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.scrollView.mj_header = header;
}
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    // 1.添加假数据
    WEAKSELF(ws);
    
    // 2.模拟1秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
//        [self.tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [ws.scrollView.mj_header endRefreshing];
    });
}

//添加item
-(void)addnavigaItem{
    
    UIButton * lefItemBt = [UIButton buttonWithType:UIButtonTypeCustom];
    lefItemBt.frame = CGRectMake(0, 0, 20, 20);
    [lefItemBt addTarget:self action:@selector(actionlefItemBt) forControlEvents:UIControlEventTouchUpInside];
    [lefItemBt setImage:[UIImage imageNamed:@"1481635968_menu"] forState:UIControlStateNormal];
    [lefItemBt setImage:[UIImage imageNamed:@"1481635968_menu"] forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lefItemBt];
    
    
    UIButton * rightItemBt  = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItemBt.frame = CGRectMake(0, 0, 20, 20);
    [rightItemBt setImage:[UIImage imageNamed:@"barcode"] forState:UIControlStateNormal];
    [rightItemBt setImage:[UIImage imageNamed:@"barcode"] forState:UIControlStateHighlighted];
    [rightItemBt addTarget:self action:@selector(actionrigt) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItemBt];
    
}


//右边item点击
-(void)actionrigt{
    
//    [self.scanView removeFromSuperview];
    LXDScanCodeController * scanCodeController = [LXDScanCodeController scanCodeController];
    scanCodeController.scanDelegate = self;
    [self.navigationController pushViewController: scanCodeController animated: YES];
}
#pragma mark - LXDScanCodeControllerDelegate
- (void)scanCodeController:(LXDScanCodeController *)scanCodeController codeInfo:(NSString *)codeInfo
{
    NSURL * url = [NSURL URLWithString: codeInfo];
    if ([[UIApplication sharedApplication] canOpenURL: url]) {
        [[UIApplication sharedApplication] openURL: url];
        
    } else {
     UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"警告" message: [NSString stringWithFormat: @"%@:%@", @"无法解析的二维码", codeInfo] delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
        [alertView show];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;
    
    
}
//左边item 按钮
-(void)actionlefItemBt{
   
   
}

-(void)setupUI{
    
    NSArray * array = @[@"http://img11.static.yhbimg.com/yhb-img01/2016/12/06/15/01b870be3d50627929d31986497c98a87d.jpg?imageView2/2/w/1150/h/450/q/90",@"http://img10.static.yhbimg.com/yhb-img01/2016/12/06/15/01965081f80bdb0300c2f1e74250077465.jpg?imageView2/2/w/1150/h/450/q/90",@"http://img10.static.yhbimg.com/yhb-img01/2016/12/08/14/01f37e928ca86eb8e47836ddf01bd9b1b9.jpg?imageView2/2/w/1150/h/450/q/90",@"http://img11.static.yhbimg.com/yhb-img01/2016/12/14/11/01702ba24941a2aaa37890ce217ffba443.jpg?imageView2/2/w/1150/h/450/q/90",@"http://img10.static.yhbimg.com/yhb-img01/2016/12/14/11/01c89ce55aab4152343084d7d1becf53e1.jpg?imageView2/2/w/1150/h/450/q/90",@"http://img10.static.yhbimg.com/yhb-img01/2016/12/15/14/013758525828ce4823dd443a03d0ccc2f0.jpg?imageView2/2/w/1150/h/450/q/90",@"http://img10.static.yhbimg.com/yhb-img01/2016/12/14/11/01c89ce55aab4152343084d7d1becf53e1.jpg?imageView2/2/w/1150/h/450/q/90",@"http://img10.static.yhbimg.com/yhb-img01/2016/12/14/16/0166168db0d545ee84c6e6aa881ca25084.jpg?imageView2/2/w/1150/h/450/q/90"];
    
    LCFBannerView * bannerview = [[LCFBannerView alloc] initWithFrame:CGRectMake(0, 0, LCF_SCREEN_WIDTH, LCF_SCREEN_WIDTH /2.08 + 10) arraySource:[NSMutableArray arrayWithArray:array]];
    //服从代理
    bannerview.delegate = self;
    [self.scrollView addSubview:bannerview];
     /**** 活动入口******/
    
    NSArray * image_icon = @[@"001",@"002",@"003",@"004",@"005"];
    NSArray * label_icon = @[@"新品到这",@"潮流优选",@"冬著严选",@"明星原创",@"全部分类"];
    NSArray * image_icon1 = @[@"006",@"007",@"008",@"009",@"010"];
    NSArray * label_icon1 = @[@"人气搭配",@"领卷中心",@"全球购",@"限定发售",@"折扣全区"];
    for (int i = 0; i < 5; i++) {
        UIButton * oldUserBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        oldUserBtn.layer.cornerRadius = 15;
        oldUserBtn.clipsToBounds  = TRUE;
//        oldUserBtn.layer.borderWidth = 0.5;
        [oldUserBtn addTarget:self action:@selector(ClickOlduserbtone:) forControlEvents:UIControlEventTouchUpInside];
        [oldUserBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", image_icon[i]]] forState:UIControlStateNormal];
        oldUserBtn.tag = 100 +i;
        
        oldUserBtn.frame = CGRectMake( self.scrollView.bounds.origin.x +10 +  i * 80 ,bannerview.frame.size.height + 15, 40,40 );
        
        [oldUserBtn addTarget:self action:@selector(ClickOlduserbtone:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:oldUserBtn];
        self.oldUserBtn =  oldUserBtn;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(self.scrollView.bounds.origin.x + 5 + i * 80, bannerview.frame.size.height + 60, 60, 20)];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont AvenirLightWithFontSize:12];
        
        label.text = [NSString stringWithFormat:@"%@",label_icon[i]];
        
        [self.scrollView addSubview:label];
        
        
    }
    for (int i = 0; i < 5; i++) {
        UIButton * oldUserBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        oldUserBtn.layer.cornerRadius = 15;
        oldUserBtn.clipsToBounds  = TRUE;
//        oldUserBtn.layer.borderWidth = 0.5;
        [oldUserBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", image_icon1[i]]] forState:UIControlStateNormal];
        oldUserBtn.tag = 100 +i;
        oldUserBtn.frame = CGRectMake( self.scrollView.bounds.origin.x +10 +  i * 80 ,bannerview.frame.size.height + 100, 40,40 );
        [self.scrollView addSubview:oldUserBtn];
        self.oldUserBtn =  oldUserBtn;
        
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(self.scrollView.bounds.origin.x + 5 + i * 80, bannerview.frame.size.height + 150, 60, 20)];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont AvenirLightWithFontSize:12];
        
        label.text = [NSString stringWithFormat:@"%@",label_icon1[i]];
        
        [self.scrollView addSubview:label];
        
    }
  
    

    UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(self.scrollView.bounds.origin.x, _oldUserBtn.frame.size.height + _oldUserBtn.frame.origin.y +40, LCF_SCREEN_WIDTH, 50);
    /* 设置button边框 */
    [bt.layer setMasksToBounds:YES];
    [bt.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
    bt.layer.borderWidth = 0.5;
    //边框宽度
    [bt.layer setBorderWidth:1.0];
    bt.titleLabel.textAlignment = NSTextAlignmentCenter;
    [bt setTitle:@"🌶 关于谨防诈骗重要提示" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(ClickwebView:) forControlEvents:UIControlEventTouchUpInside];
    [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.scrollView addSubview:bt];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, bt.frame.size.height + bt.frame.origin.y +10, LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT *4) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    /* 自使用高度*/
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    collectionView.showsVerticalScrollIndicator = NO;//不显示滑动条
    collectionView.alwaysBounceVertical = YES;//内容不超过collectionView时也可以滑动
    /* 注册头部   和 注册cell*/
    [collectionView registerClass:[ShopCollectionViewCell class] forCellWithReuseIdentifier:@"shopcell"];
    [collectionView registerClass:[StrollCollectionViewCell class] forCellWithReuseIdentifier:@"Stroll"];
    
    
    _collectionview = collectionView;
    
    [self.scrollView addSubview:self.collectionview];
       self.scrollView.contentSize = CGSizeMake(0, self.collectionview.frame.origin.y + (LCF_SCREEN_WIDTH * 4) );
    
    
    UIButton * bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
    bt1.frame = CGRectMake(self.collectionview.center.x - 40,self.collectionview.frame.origin.y + (LCF_SCREEN_WIDTH * 4) -40, LCF_SCREEN_WIDTH / 3 , 30);
    /* 设置button边框 */
    [bt1.layer setMasksToBounds:YES];
    [bt1.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
    bt1.layer.borderWidth = 0.5;
//    bt1.backgroundColor = [UIColor blackColor];
    //边框宽度
    [bt1.layer setBorderWidth:1.0];
    bt1.titleLabel.textAlignment = NSTextAlignmentLeft;
    [bt1 setTitle:@"查看更多" forState:UIControlStateNormal];
    [bt1 addTarget:self action:@selector(ClickwebViewmore:) forControlEvents:UIControlEventTouchUpInside];
    [bt1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.scrollView addSubview:bt1];

}


/* 活动圆形点击事件*/
- (void)ClickOlduserbtone:(UIButton *)sender {
    
  
    sender =  (UIButton *)[self.scrollView viewWithTag:sender.tag];
    switch (sender.tag) {
        case 100:
          
            [self setWithPush];
            break;
        case 101:
         
            break;
            
        default:
            break;
    }
    
}

/* 加载webview*/
-(void)ClickwebView:(UIButton *)sender {
    
    WebViewController  * webVC = [[WebViewController alloc] init];
    webVC.requestBody = WebURL;
    [self.navigationController pushViewController:webVC animated:YES];
    
    
}

- (void) ClickwebViewmore:(UIButton *)sender {
    WebViewController * moreweb = [[WebViewController alloc] init];
    moreweb.requestBody = @"http://list.yohobuy.com/new?gender=2,3&order=s_t_desc";
    moreweb.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:moreweb animated:YES];
   
}
//跳转界面
- (void)setWithPush {
    TGLTableViewController  *vc01   = [[TGLTableViewController alloc] init];
    GirlViewController      * vc02  =  [[GirlViewController alloc] init];
    NSArray *vcArray        = [[NSArray alloc] initWithObjects:vc01,vc02, nil];
    NSArray *titlesArray  = [[NSArray alloc] initWithObjects:@"男装", @"女装",nil];
    NSArray *imagesArray    = [[NSArray alloc] initWithObjects:@"ic_profile", @"ic_feed", @"ic_activity", @"ic_settings",@"ic_activity" ,nil];
    
    TGLGuillotineMenu *menuVC = [[TGLGuillotineMenu alloc] initWithViewControllers:vcArray MenuTitles:titlesArray andImagesTitles:imagesArray];
    menuVC.delegate = self;
    menuVC.hidesBottomBarWhenPushed= YES;
    [self.navigationController pushViewController:menuVC animated:YES];
}



#pragma mark -- UICollectionViewDataSource
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    if (section == 0) {
        return 1;
    }
    
    return self.DataArray.count;
//    return 1;
    
}
//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        StrollCollectionViewCell  * stroll = [collectionView dequeueReusableCellWithReuseIdentifier:@"Stroll" forIndexPath:indexPath];
        [stroll.footImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img11.static.yhbimg.com/yhb-img01/2016/12/21/11/01063ea18bf119903453c11d359587a0c2.jpg?imageView2/2/w/1150/h/450/q/90"]];
        return stroll;
    }
    
      ShopCollectionViewCell * shopcell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shopcell" forIndexPath:indexPath];
      
    [shopcell.shopimage sd_setImageWithURL:[NSURL URLWithString:[self.DataArray valueForKey:@"background"][indexPath.row]]];
    shopcell.titile.text = [self.DataArray valueForKey:@"title"][indexPath.row];
    shopcell.price.text = [self.DataArray valueForKey:@"detail"][indexPath.row];
    return shopcell;
    
  
    
}
//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    if (section == 0) {
        return  UIEdgeInsetsMake(5, 0, 5, 0);
    }
        return UIEdgeInsetsMake(0, 20, 0, 20);
  
    
    
}
//竖向间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 3.f;
}
//横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (!section) {
        return 0.;
    }
    return 8.f;
}

//设置每个item大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return (CGSize){LCF_SCREEN_WIDTH,150};
    }
    return (CGSize){LCF_SCREEN_WIDTH /2.5 + 10,250};

   
}

- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout colorForSectionAtIndex:(NSInteger)section{
    
    return  YM_RGBA(240.,242.,245,1.) ;  //背景色;
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        WebViewController * web = [[WebViewController alloc] init];
        web.hidesBottomBarWhenPushed = YES;
        web.requestBody = @"http://list.yohobuy.com/?msort=1&misort=18,20&gender=1,3";
        web.navigationController.navigationBar.hidden = YES;
        [self.navigationController pushViewController:web animated:YES];
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
