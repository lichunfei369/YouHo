//
//  ShopCenterController.m
//  LCFDeerShop
//
//  Created by 李春菲 on 17/1/12.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "ShopCenterController.h"
#import "LCFBannerView.h"
#import "ShopCenterCell.h"
#import "ShopCenterView.h"
#import "ChoseView.h"
@interface ShopCenterController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,LCFBannerViewDelegate>

@property   (nonatomic, retain)     UITableView     *  tableview;

@property   (nonatomic ,retain)      LCFBannerView * banner;

@property   (nonatomic ,retain)     ShopCenterView * footview;

@property   (nonatomic ,retain)     UIScrollView   * scrollview;

@end

@implementation ShopCenterController

static   NSString  * const TableviewCell =  @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBarButtonitem];
    
    UIScrollView * scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT - 4)];
    scrollview.delegate = self;
    scrollview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollview];
    self.scrollview = scrollview;
    
     [self setBannerView];

   
    
}

-(void)goShoping {
    
    
    
    
}

- (ShopCenterView *)footview {
    
    if (!_footview) {
        _footview = [[ShopCenterView alloc]initWithFrame:CGRectMake(0, 0, LCF_SCREEN_WIDTH, 44)];
     
        
    }
    return _footview;
}


- (void)setBarButtonitem {
    UIButton * lefItemBt = [UIButton buttonWithType:UIButtonTypeCustom];
    lefItemBt.frame = CGRectMake(0, 0, 20, 20);
    [lefItemBt addTarget:self action:@selector(actionlefItemBt) forControlEvents:UIControlEventTouchUpInside];
    [lefItemBt setImage:[UIImage imageNamed:@"1481634799_left"] forState:UIControlStateNormal];
    [lefItemBt setImage:[UIImage imageNamed:@"1481634799_left"] forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lefItemBt];
    
}


- (UITableView *)tableview {
    
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, self.banner.bottom,LCF_SCREEN_WIDTH , LCF_SCREEN_HEIGHT *2-44) style:UITableViewStylePlain];
        _tableview.scrollEnabled = NO;//关闭tableview的滑动
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    
    return _tableview;
}



- (void)setBannerView {
    
    NSArray * array = @[@"http://s7.mogucdn.com/p2/170108/1i8_71kedlj76fb62b87clfdc0kc1ld5b_896x447.jpg"];
    
   self.banner = [[LCFBannerView alloc] initWithFrame:CGRectMake(0, 0, LCF_SCREEN_WIDTH, LCF_SCREEN_WIDTH / 1.5 ) arraySource:[NSMutableArray arrayWithArray:array]];
    self.banner.delegate = self;
    [self.scrollview addSubview:self.banner];
    
    [self.scrollview addSubview:self.tableview];
    
    self.scrollview.contentSize = CGSizeMake(0, LCF_SCREEN_HEIGHT * 2);
    self.tableview.tableFooterView = self.footview;
    
    
}




#pragma  mark --------    TableviewDataSoure         


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopCenterCell * cell = [tableView dequeueReusableCellWithIdentifier:TableviewCell];
    if (!cell) {
        cell = [[ShopCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableviewCell];
    }
    
    return cell;
    
}

-(void)actionlefItemBt {
    
    [self.navigationController popViewControllerAnimated:YES];
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
