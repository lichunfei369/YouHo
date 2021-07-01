//
//  UIColor+MYColor.h
//  Category
//
//  Created by 李春菲 on 16/9/26.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MYColor)
/** 十六进制字符串颜色 **/

+(UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat )alpha;

@end
