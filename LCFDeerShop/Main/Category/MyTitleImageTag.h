//
//  MyTitleImageTag.h
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/25.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTitleImageTag : NSObject

@property   (copy,nonatomic)    NSString            *   title;

@property   (retain,nonatomic)  UIImage             *   image;

@property   (retain,nonatomic)  UIViewController    *   controller;

@property   (assign,nonatomic)  NSInteger           *   tag;

+(instancetype)titleIconWith:(NSString *)title image:(UIImage *)image controller:(UIViewController *)controller tag:(NSInteger)tag;


@end
