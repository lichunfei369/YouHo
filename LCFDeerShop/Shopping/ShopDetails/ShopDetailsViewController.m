//
//  ShopDetailsViewController.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/25.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "ShopDetailsViewController.h"
#import "shopDetailsHeadView.h"
#import "ChoseView.h"
@interface ShopDetailsViewController ()<UIScrollViewDelegate,shopDetailsHeadViewDelegate>
@property   (retain,nonatomic) shopDetailsHeadView  *   shopdetailsview;
@property   (retain,nonatomic)  UIScrollView        *   detailsScrollView;
@end

@implementation ShopDetailsViewController


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewWillAppear:(BOOL)animated{
        [super viewWillAppear:animated];
        [self.navigationController setNavigationBarHidden:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//     self.navigationController.navigationBar.hidden = NO;
    
    
    
    [self setUpWithHeadView];
    
    [self setUpWithTableView];
    

}

 /*头部view*/
- (void)setUpWithHeadView{
    
    [self.view addSubview:self.shopdetailsview];
    [self.shopdetailsview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.and.trailing.equalTo(self.view);
        make.height.mas_equalTo(LCF_SCREEN_WIDTH / 1.5);
        
    }];
    
    self.shopdetailsview.delegate = self;
}
/* 中间商品详情 */
- (void)setUpWithTableView{
    
    UIScrollView * scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, LCF_SCREEN_WIDTH / 1.5, LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT)];
    scrollview.contentSize = CGSizeMake(LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT *1.5);
    scrollview.backgroundColor = [UIColor whiteColor];
    scrollview.delegate = self;
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.directionalLockEnabled = YES;
    [self.view addSubview:scrollview];
    self.detailsScrollView = scrollview;
   

   
    
    UILabel * label  = [[UILabel alloc] init];
    label.text = @"商品详情";
    label.font = [UIFont fontWithName:@"Arial-BoldMT" size:19.];
    [self.detailsScrollView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailsScrollView.mas_bottom).offset(30);
        make.leading.mas_equalTo(self.detailsScrollView).offset(28);
        make.width.mas_equalTo(LCF_SCREEN_WIDTH / 2.3);
        make.height.mas_equalTo(@20);
    }];
    
    UILabel * labelText = [[UILabel alloc] init];
    labelText.numberOfLines = 0;
    labelText.text = @"型号:  0021\n尺码: XL\n订单号: 002120325784638x";
    labelText.textAlignment = NSTextAlignmentNatural;
    labelText.font = XNFont(12.);
    [self.detailsScrollView addSubview:labelText];
    [labelText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(27);
        make.leading.mas_equalTo(self.detailsScrollView).offset(28);
        make.width.mas_equalTo(LCF_SCREEN_WIDTH / 1.7);
        make.height.mas_equalTo(@100);
        
    }];
    
    UIImageView * image_icon = [[UIImageView alloc] init];
    image_icon.image = [UIImage imageNamed:@"detais_image"];
    
    [self.detailsScrollView addSubview:image_icon];
    [image_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(labelText.mas_bottom).offset(20);
        make.leading.mas_equalTo(20);
        make.width.mas_equalTo(LCF_SCREEN_WIDTH / 1.2);
        make.height.mas_equalTo(300);
        
    }];
    
    UILabel * brief_introduction = [[UILabel alloc] init];
    brief_introduction.text = @"Get into the scene.";
    brief_introduction.font = [UIFont fontWithName:@"Arial-BoldMT" size:19.];
    [self.detailsScrollView addSubview:brief_introduction];
    [brief_introduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(image_icon.mas_bottom).offset(20);
        make.leading.mas_equalTo(label);
        make.width.mas_equalTo(LCF_SCREEN_WIDTH / 2);
        make.height.mas_equalTo(@20);
    }];
    
    
}

- (shopDetailsHeadView *)shopdetailsview {
    if (!_shopdetailsview) {
        _shopdetailsview = [[shopDetailsHeadView alloc]init];
    }
    return _shopdetailsview;
    
}

#pragma mark  shopDetailsHeadViewDelegate

-(void)setWithShopDetailsClicketDelegate{
    
    NSLog(@"点击购买BUY");
}

-(void)setWithShopDetailsClicketDelegateLoginButton:(UIButton *)sender{
    
    NSLog(@"%@",sender);
}

-(void)setPopWothSharManager {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
