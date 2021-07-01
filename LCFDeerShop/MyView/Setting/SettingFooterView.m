//
//  SettingFooterView.m
//  LCFDeerShop
//
//  Created by 李春菲 on 17/1/4.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "SettingFooterView.h"
#define XCFThemeColor RGB(249, 103, 80)        // TabBar选中颜色
@implementation SettingFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor redColor];
        
        self.signUpButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        if (_clipsToBounds) self.signUpButton.layer.cornerRadius = 5;
        self.signUpButton.backgroundColor = [UIColor whiteColor];
        self.signUpButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.signUpButton setTitle:@"提交" forState:UIControlStateNormal];
        [self.signUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.signUpButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
            
        
        

        [self addSubview:_signUpButton];
        [_signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
            make.left.equalTo(self).offset(10);
            make.size.mas_equalTo(CGSizeMake(LCF_SCREEN_WIDTH-20, 35));
        }];
        
        _versionLabel = [[UILabel alloc] init];
        _versionLabel.font = [UIFont systemFontOfSize:14];
        _versionLabel.text = @"版本号";
        [self addSubview:_versionLabel];
        [_versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.signUpButton.mas_bottom).offset(10);
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                                  title:(NSString *)title
                         titleLabelFont:(UIFont *)font
                             titleColor:(UIColor *)titleColor
                                 target:(id)target
                                 action:(SEL)action
                          clipsToBounds:(BOOL)clipsToBounds {
    
    UIButton *button = [[UIButton alloc] init];
    if (clipsToBounds) button.layer.cornerRadius = 5;
    //    button.clipsToBounds = clipsToBounds;
    button.backgroundColor = backgroundColor;
    button.titleLabel.font = font;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (void)signUp {
    
}



@end
