//
//  MyTopHeadView.h
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/29.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyTopHeadViewDelegation <NSObject>

@optional

- (void)setHeardShareManagerWithPush:(UIButton *)sender;

@end

typedef void(^informBlock)();

typedef void(^SettingBlock)();

@interface MyTopHeadView : UIView
@property       (retain,nonatomic)      UIImageView *   topHead_image;

@property       (retain,nonatomic)      UIButton    *   heard_icon;

@property       (retain,nonatomic)      UIView      *   headGuidance;

@property       (retain,nonatomic)      UIButton     *   collect_shop;

@property       (retain,nonatomic)      UILabel     *   collect_Brand;

@property       (retain,nonatomic)      UIButton     *   collect_Records;

@property       (copy,nonatomic)        informBlock   inform;

@property       (copy,nonatomic)        SettingBlock  setting;

@property       (nonatomic ,weak)       id <MyTopHeadViewDelegation>delegation;

@end
