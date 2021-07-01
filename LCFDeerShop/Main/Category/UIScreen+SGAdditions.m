//
//  UIScreen+SGAdditions.m
//  Travel99
//
//  Created by 宋迪 on 15/11/19.
//  Copyright © 2015年 SG. All rights reserved.
//

#import "UIScreen+SGAdditions.h"

@implementation UIScreen (SGAdditions)

+ (BOOL)isRetina
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0 || [UIScreen mainScreen].scale == 3.0))
        return YES;
    else
        return NO;
}

+ (BOOL)isRetinaHD
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 3.0))
        return YES;
    else
        return NO;
}

- (CGSize)fixedScreenSize
{
    CGSize screenSize = self.bounds.size;
    
    if((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
    {
        return CGSizeMake(screenSize.height, screenSize.width);
    }
    
    return screenSize;
}

+(float)numberFrom750:(float)number
{
    return number * SCREEN_WIDTH / 750.0f;
}
+ (float)numberFrom375:(float)number{
    return number * SCREEN_WIDTH / 375.0f;
}


//宽度自适应
+ (float)numberFromWidth750:(float)number
{
    return number * SCREEN_WIDTH / 750.0f;
}
+ (float)numberFromWidth375:(float)number
{
    return number * SCREEN_WIDTH / 375.0f;
}
//高度自适应
+ (float)numberFromHeight1334:(float)number
{
    return number * SCREEN_HEIGHT / 1134.0f;
}
+ (float)numberFromHeight667:(float)number
{
    return number * SCREEN_HEIGHT / 667.0f;
}
@end
