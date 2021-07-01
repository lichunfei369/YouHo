//
//  QuickViewController.m
//  LCFDeerShop
//
//  Created by 李春菲 on 17/1/3.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "QuickViewController.h"
#import "OLImage.h"
#import "OLImageView.h"
@interface QuickViewController ()

@end

@implementation QuickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"快速注册";
    UIButton * lefItemBt = [UIButton buttonWithType:UIButtonTypeCustom];
    lefItemBt.frame = CGRectMake(0, 0, 20, 20);
    [lefItemBt addTarget:self action:@selector(ClickPop:) forControlEvents:UIControlEventTouchUpInside];
    [lefItemBt setImage:[UIImage imageNamed:@"1481634799_left"] forState:UIControlStateNormal];
    [lefItemBt setImage:[UIImage imageNamed:@"1481634799_left"] forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lefItemBt];
    
//    OLImageView * animationImage = [[OLImageView alloc] initWithImage:[OLImage imageNamed:@"01-black-cat_800x600_v1.gif"]];
//    [animationImage setFrame:CGRectMake(0, 0, LCF_SCREEN_WIDTH, LCF_SCREEN_HEIGHT / 2)];
//    
//    [self.view addSubview:animationImage];
    
    
    
    
}

//pop

-(void)ClickPop:(UIButton *)sender{
    
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
