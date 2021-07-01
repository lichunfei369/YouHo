//
//  RefreshHeader.m
//  LCFDeerShop
//
//  Created by 李荣建 on 2016/12/22.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "RefreshHeader.h"

@interface RefreshHeader ()
@property(nonatomic,strong)UIImageView *animatedView;
@property(nonatomic,strong)UIImageView *backgroundImageView1;
@property(nonatomic,strong)UIImageView *backgroundImageView2;

@end
@implementation RefreshHeader

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];

    // 设置普通状态的动画图片
//    NSMutableArray *idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=60; i++) {
//    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
//    [idleImages addObject:image];
//    }
//    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=3; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
//        [refreshingImages addObject:image];
//    }
//    [self setImages:refreshingImages forState:MJRefreshStatePulling];
//    
//    // 设置正在刷新状态的动画图片
//    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    self.backgroundImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, LCF_SCREEN_WIDTH, CGRectGetHeight(self.frame))];
    //    self.animatedView.center = self.center;
    self.backgroundImageView1.centerY = self.centerY;
    self.backgroundImageView1.image = [UIImage imageNamed:@"sky"];
    [self addSubview:self.backgroundImageView1];
    self.backgroundImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, LCF_SCREEN_WIDTH, CGRectGetHeight(self.frame))];
    //    self.animatedView.center = self.center;
    self.backgroundImageView2.centerY = self.centerY;
    self.backgroundImageView2.image = [UIImage imageNamed:@"buildings"];
    [self addSubview:self.backgroundImageView2];
    self.animatedView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 0, 30, 30)];
    //    self.animatedView.center = self.center;
//    self.animatedView.centerY = self.centerY;
    [self.backgroundImageView2 addSubview:self.animatedView];
    self.animatedView.image = [UIImage imageNamed:@"sun@2x的副本"];
//    CABasicAnimation* rotationAnimation = nil;
//    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
//    rotationAnimation.duration = 1.5;
//    rotationAnimation.cumulative = YES;
//    rotationAnimation.repeatCount = 99999999999999999;
////    NSLog(@"%f  %f",self.frame.size.width,self.frame.size.height);
//    [self.animatedView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    NSMutableArray *animateArray = [NSMutableArray arrayWithCapacity:10];
    
    for (int i=1; i<5; i++) {
    
        [animateArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"sun@2x的副本"]]];

}

    self.animatedView.animationDuration = 1.5f;
    
    self.animatedView.animationImages = animateArray;
    
    self.animatedView.animationRepeatCount = 0;
    
    [self.animatedView startAnimating];
}
@end
