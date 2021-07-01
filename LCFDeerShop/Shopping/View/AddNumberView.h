//
//  AddNumberView.h
//  LCFDeerShop
//
//  Created by 李春菲 on 17/1/10.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddNumberViewDelegate;


@interface AddNumberView : UIView

@property   (strong ,nonatomic) UIButton * addBtn;
@property   (strong ,nonatomic) UIButton * SubtractBtn;
@property (strong, nonatomic) UILabel *numberLab;

@property (nonatomic,copy) NSString *numberString;

@property (nonatomic,assign) id<AddNumberViewDelegate> delegate;

@end

@protocol AddNumberViewDelegate <NSObject>

@optional


- (void)deleteBtnAction:(UIButton *)sender addNumberView:(AddNumberView *)view;

- (void)addBtnAction:(UIButton *)sender addNumberView:(AddNumberView *)view;



@end

