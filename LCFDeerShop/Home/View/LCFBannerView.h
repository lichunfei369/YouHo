//
//  LCFBannerView.h
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/18.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LCFBannerViewDelegate <NSObject>

@optional
-(void)clickBannerView:(NSNumber *)page;


@end

@interface LCFBannerView : UIView
@property   (nonatomic,assign)  NSTimeInterval  autoScrollTime;//轮播时差 默认3秒
@property   (nonatomic,assign)  BOOL    isAutoBanner;//是否自动轮播  默认 = YES
@property   (nonatomic,assign)  id  <LCFBannerViewDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame arraySource:(NSMutableArray *)arraySource;

@end
