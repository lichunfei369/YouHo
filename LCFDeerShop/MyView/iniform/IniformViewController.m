//
//  IniformViewController.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/19.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "IniformViewController.h"
#define YMBGCOLOR            YM_RGBA(240.,242.,245,1.)   //背景色
@interface IniformViewController ()

@end

@implementation IniformViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"通知";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, LCF_SCREEN_HEIGHT, 100)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 35, 20)];
    label.backgroundColor = YM_RGBA(83., 162., 255., 1.);
    label.text = @"通知";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = XNFont(12.);
    label.layer.cornerRadius = 2.;
    label.layer.masksToBounds = YES;
    label.clipsToBounds = YES;
    [bgView addSubview:label];
    
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(30, 30, LCF_SCREEN_HEIGHT - 60, 20)];
    label2.textColor = [UIColor blackColor];
    label2.text = @"您的换货审核已通过";
    label2.font = XNFont(14.);
    [bgView addSubview:label2];
    
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(30, 60, LCF_SCREEN_HEIGHT - 60, 20)];
    label3.textColor = [UIColor blackColor];
    label3.text = @"10月30日";
    label3.alpha = .5;
    label3.font = XNFont(12.);
    [bgView addSubview:label3];
    
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(30, 95, LCF_SCREEN_HEIGHT - 30, 0.5)];
    label4.backgroundColor = YM_RGBA(215., 215., 215., 1.);
    [bgView addSubview:label4];
    
    
//    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(30, 110, LCF_SCREEN_HEIGHT - 60, 20)];
//    label5.font = XNFont(13.);
//    label5.textColor = YM_RGBA(16., 16., 16., 1.);
//    label5.text = @"去看看进度";
//    [bgView addSubview:label5];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"arrow_right_icon"] forState:UIControlStateNormal];
    button.frame = CGRectMake(LCF_SCREEN_HEIGHT - 40, 110, 15, 15);
//    [button addTarget:self action:@selector(lookAtProgress) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button];
}

-(void)actionlefItemBt {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
