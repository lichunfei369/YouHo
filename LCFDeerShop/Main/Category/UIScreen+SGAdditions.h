//
//  UIScreen+SGAdditions.h
//  Travel99
//
//  Created by 宋迪 on 15/11/19.
//  Copyright © 2015年 SG. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_SIZE                 [[UIScreen mainScreen] bounds].size
#define SCREEN_HEIGHT               SCREEN_SIZE.height
#define SCREEN_WIDTH                SCREEN_SIZE.width
#define SCREEN_HEIGHT_OF_IPHONE5    568
#define adapt750(num)               [UIScreen numberFrom750:(num)]
#define adapt375(num)               [UIScreen numberFrom375:(num)]
#define adaptWidth750(num)          [UIScreen numberFromWidth750:(num)]
#define adaptWidth375(num)          [UIScreen numberFromWidth375:(num)]
#define adaptHeight1334(num)        [UIScreen numberFromHeight1334:(num)]
#define adaptHeight667(num)         [UIScreen numberFromHeight667:(num)]


@interface UIScreen (SGAdditions)

+ (BOOL)isRetina;

+ (BOOL)isRetinaHD;

- (CGSize)fixedScreenSize;

+ (float)numberFrom750:(float)number;
+ (float)numberFrom375:(float)number;
//宽度自适应
+ (float)numberFromWidth750:(float)number;
+ (float)numberFromWidth375:(float)number;
//高度自适应
+ (float)numberFromHeight1334:(float)number;
+ (float)numberFromHeight667:(float)number;

@end
