//
//  MyTitleImageTag.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/25.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "MyTitleImageTag.h"

@implementation MyTitleImageTag


+(instancetype)titleIconWith:(NSString *)title image:(UIImage *)image controller:(UIViewController *)controller tag:(NSInteger)tag{
    
    MyTitleImageTag * titleIcon = [[MyTitleImageTag alloc] init];
    
    titleIcon.title = title;
    titleIcon.image = image;
    titleIcon.controller = controller;
    titleIcon.tag = &(tag);
    
    return titleIcon;
}
@end
