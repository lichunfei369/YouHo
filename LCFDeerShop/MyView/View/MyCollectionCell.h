//
//  MyCollectionCell.h
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/15.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionCell : UICollectionViewCell

/**
 我的订单
 */
@property   (nonatomic ,retain) UILabel     *orderLabel;


/**
 我的全部订单
 */
@property   (nonatomic ,retain) UILabel     *allOderLabel;


/**
 右侧箭头
 */
@property   (nonatomic ,retain) UIImageView *rightImage_icon;

@end
