//
//  shopDetailsHeadView.h
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/25.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol shopDetailsHeadViewDelegate <NSObject>

@optional

-(void)setWithShopDetailsClicketDelegate;

-(void)setWithShopDetailsClicketDelegateLoginButton:(UIButton *)sender;

-(void)setPopWothSharManager;

@end

@interface shopDetailsHeadView : UIView
@property   (retain,nonatomic)  UIView      *   shopDetailsHead_view;
@property   (retain,nonatomic)  UILabel     *   titile;
@property   (retain,nonatomic)  UILabel     *   NewPrice;
@property   (retain,nonatomic)  UILabel     *   NewPricetow;
@property   (retain,nonatomic)  UILabel     *   URL;
@property   (retain,nonatomic)  UIButton    *   icon_bt;
@property   (retain,nonatomic)  UIButton    *   buy;
@property   (retain,nonatomic)  UILabel     *   picture;
@property   (retain,nonatomic)  UILabel     *   Time;
@property   (retain,nonatomic)  UIButton    *   Triplicities_bt;
@property   (retain,nonatomic)  UIButton    *   popController;


@property   (weak,nonatomic)    id  <shopDetailsHeadViewDelegate> delegate;

@end
