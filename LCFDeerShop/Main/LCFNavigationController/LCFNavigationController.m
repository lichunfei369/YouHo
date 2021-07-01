//
//  LCFNavigationController.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/18.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "LCFNavigationController.h"
#import "UIBarButtonItem+Extension.h"
@interface LCFNavigationController ()

@end

@implementation LCFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
}

//-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    
//    if (self.viewControllers.count > 0) { //如果现在push的不是栈底控制器(最先push进来的那个控制器)
//        viewController.hidesBottomBarWhenPushed = YES;
//        //设置导航按钮
//        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem
//                                                           itemWithImageName:@"1481634799_left" highImageName:@"1481634799_left" target:self action:(@selector(back))];
//    }
//    [super pushViewController:viewController animated:YES];
//}
//
//-(void)back{
//    
//    [self popViewControllerAnimated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
