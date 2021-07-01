//
//  MyTopHeadView.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/29.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "MyTopHeadView.h"

@implementation MyTopHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.topHead_image];
        [self addSubview:self.headGuidance];
        [_headGuidance addSubview:self.collect_shop];
        [_headGuidance addSubview:self.collect_Brand];
        [_headGuidance addSubview:self.collect_Records];
        [self addSubview:self.heard_icon];
    }
    
    return self;
    
}

-(void)layoutSubviews{
    
    
    [super layoutSubviews];

    [self.topHead_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(LCF_SCREEN_WIDTH );
        make.height.mas_equalTo(self.bounds.size.height);
    }];
    
    [self.headGuidance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo (self);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(LCF_SCREEN_WIDTH);
        make.height.mas_equalTo(@40);
    }];
    
    [self.collect_shop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headGuidance);
        make.leading.equalTo(self.headGuidance).offset(37.5);
    }];
    
    [self.collect_Brand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo (self.headGuidance);
        make.centerX.equalTo(self.headGuidance);
    }];
    
    [self.collect_Records mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headGuidance);
        make.trailing.equalTo(self.headGuidance).offset(-37.5);
    }];
    
    [self.heard_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(+60);
        make.width.height.equalTo(@(50));
        make.centerX.equalTo(self);
    }];
    
    
}

- (UIView *)headGuidance {
    
    if (!_headGuidance) {
        _headGuidance = [[UIView alloc] init];
        _headGuidance.backgroundColor = [UIColor blackColor];
    }
    return _headGuidance;
}

- (UIImageView *)topHead_image{
    
    if (!_topHead_image) {
        
        _topHead_image = [[UIImageView alloc]init];
        [_topHead_image setImage:[UIImage imageNamed:@"background-4"]];
        
    }
    return _topHead_image;
}

- (UIButton *)collect_shop {
    
    if (!_collect_shop) {
        _collect_shop = [UIButton buttonWithType:UIButtonTypeCustom];
//        _collect_shop.text = @"通知";
        [_collect_shop setTitle:@"通知" forState:UIControlStateNormal];
        [_collect_shop addTarget:self action:@selector(Clickinform) forControlEvents:UIControlEventTouchUpInside];
        [_collect_shop setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _collect_shop.titleLabel.font = [UIFont AvenirWithFontSize:9];
    }
    return _collect_shop;
}

- (UILabel *)collect_Brand {
    
    if (!_collect_Brand) {
        _collect_Brand = [[UILabel alloc] init];
        _collect_Brand.text = @"";
        _collect_Brand.textColor = [UIColor whiteColor];
        _collect_Brand.font = [UIFont AvenirWithFontSize:9];
    }
    return _collect_Brand;
}
- (UIButton *)collect_Records {
    
    if (!_collect_Records) {
        _collect_Records = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collect_Records setTitle:@"设置" forState:UIControlStateNormal];
        [_collect_Records addTarget:self action:@selector(Clicksetting) forControlEvents:UIControlEventTouchUpInside];
        [_collect_Records setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _collect_Records.titleLabel.font = [UIFont AvenirWithFontSize:9];
    }
    return _collect_Records;
}

- (UIButton *)heard_icon {
    
    if (!_heard_icon) {
        _heard_icon = [UIButton buttonWithType:UIButtonTypeCustom];
        _heard_icon.layer.cornerRadius = 25;
        _heard_icon.clipsToBounds = TRUE;
        [_heard_icon addTarget:self action:@selector(Clickheard_icon:) forControlEvents:UIControlEventTouchUpInside];
        [_heard_icon setImage:[UIImage imageNamed:@"detais_image"] forState:UIControlStateNormal];
    }
     return  _heard_icon;
    
}

- (void)Clickheard_icon:(UIButton *)sender{
    
    if ([self.delegation  performSelector:@selector(setHeardShareManagerWithPush:) withObject:sender]) {
        [self.delegation  respondsToSelector:@selector(setHeardShareManagerWithPush:)];
    }
}

- (void)Clickinform {
    
    if (_inform) {
        _inform();
    }
}

- (void)Clicksetting {
    
    if (_setting) {
        _setting();
    }
}

@end
