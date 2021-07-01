//
//  LCFViewController.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/18.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "LCFViewController.h"

@interface LCFViewController ()

@end

@implementation LCFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    self.view.backgroundColor = [UIColor whiteColor];
    
  
    self.navBar = self.navigationController.navigationBar;
//    [navBar setTranslucent:YES];
    self.navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    [self.navBar setBackgroundImage:[UIImage imageNamed:@"patternNav"] forBarMetrics:UIBarMetricsDefault];
    [self.navBar setShadowImage:[[UIImage alloc] init]];
    [self setupBottomButton];
    
    //判断如果控制器大于1就自动添加上返回按钮
    if ([self.navigationController.viewControllers count] >1 ) {
          UIButton * lefItemBt = [UIButton buttonWithType:UIButtonTypeCustom];
                lefItemBt.frame = CGRectMake(0, 0, 20, 20);
                [lefItemBt addTarget:self action:@selector(actionlefItemBt) forControlEvents:UIControlEventTouchUpInside];
                [lefItemBt setImage:[UIImage imageNamed:@"1481634799_left"] forState:UIControlStateNormal];
                [lefItemBt setImage:[UIImage imageNamed:@"1481634799_left"] forState:UIControlStateHighlighted];
                self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lefItemBt];
    }
 

}

-(void)actionlefItemBt {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)WebViewBackgroud {
    
 
    
}

- (void)setupBottomButton{
    
    UIView *btnBGView = [[UIView alloc]initWithFrame:CGRectMake(0, LCF_SCREEN_HEIGHT - 123, LCF_SCREEN_WIDTH, 57)];
    btnBGView.backgroundColor = [UIColor whiteColor];
    UIButton *botton = [UIButton buttonWithType:UIButtonTypeCustom];
    botton.frame = CGRectMake(LCF_SCREEN_WIDTH / 2.5, 10, 100, 40);
    botton.titleLabel.font = XNFont(18.);
    botton.layer.cornerRadius = 2.;
    botton.layer.masksToBounds = YES;
    botton.clipsToBounds = YES;
    [btnBGView addSubview:botton];
    
 
    
    self.bottomButton = botton;
    
    self.bottomBtnBGView = btnBGView;
    
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
