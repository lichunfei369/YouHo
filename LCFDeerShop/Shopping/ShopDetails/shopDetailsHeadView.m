//
//  shopDetailsHeadView.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/25.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "shopDetailsHeadView.h"

@implementation shopDetailsHeadView

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame]; //先调用父类initWith方法
    
    if (self) {
        
    
        
        //自定义该子类方法
        [self  addSubview:self.shopDetailsHead_view];
        [self.shopDetailsHead_view addSubview:self.titile];
        [self.shopDetailsHead_view addSubview:self.NewPrice];
        [self.shopDetailsHead_view addSubview:self.NewPricetow];
        [self.shopDetailsHead_view addSubview:self.URL];
        [self.shopDetailsHead_view addSubview:self.Triplicities_bt];
        [self.shopDetailsHead_view addSubview:self.buy];
        [self.shopDetailsHead_view addSubview:self.picture];
        [self.shopDetailsHead_view addSubview:self.Time];
        [self.shopDetailsHead_view addSubview:self.popController];
    
        
        
        /* 黑色背景view */
        [self.shopDetailsHead_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self).offset(0);
//            make.width.mas_equalTo(self.mas_height).multipliedBy(3);
            make.height.equalTo(self);
        }];
          /* 大的标题 */
        [self.titile mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
            make.leading.equalTo(self).offset(30);
            make.width.mas_equalTo(@(LCF_SCREEN_WIDTH / 3));
            make.height.mas_equalTo(@30);
        }];
        /* New York */
        [self.NewPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self).offset(-10);
            make.top.equalTo(self).offset(20);
            
        }];
        /* 下面灰色字体 */
        [self.NewPricetow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self).offset(-10);
            make.top.equalTo(self.NewPrice.mas_bottom).offset(2);
        }];
        /* 网址 */
        [self.URL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.titile);
            make.top.mas_equalTo(self.titile.mas_bottom).offset(40);
        }];
        /* 购买 */
        [self.buy mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self.NewPrice);
            make.top.mas_equalTo(self.NewPrice.mas_bottom).offset(40);
            make.width.mas_equalTo(@120);
            make.height.mas_equalTo(@50);
        }];
        /* 24 of 120 */
        [self.picture mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self.NewPricetow);
            make.top.mas_equalTo(self.buy.mas_bottom).offset(30);
            make.width.mas_equalTo(@100);
            make.height.mas_equalTo(@20);
        }];
        
        /* 10 days,3h left*/
        [self.Time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self.NewPricetow);
            make.top.mas_equalTo(self.picture.mas_bottom).offset(5);
        }];
      
    }
    
    
    return self;
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSArray * login_image = @[@"login_1",@"login_2",@"login_3"];
    for (int i = 0; i < 3; i++) {
        UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",login_image[i]]] forState:UIControlStateNormal];
        bt.frame = CGRectMake(LCF_SCREEN_WIDTH / 12 + i * 30, self.frame.size.height -120, 14,14);
        [bt addTarget:self action:@selector(actionTargebt:) forControlEvents:UIControlEventTouchUpInside];
        [self.shopDetailsHead_view addSubview:bt];
        self.Triplicities_bt = bt;
    }
    
}

- (UIView *)shopDetailsHead_view {
    
    if (!_shopDetailsHead_view) {
        _shopDetailsHead_view = [[UIView alloc]init];
        _shopDetailsHead_view.backgroundColor = YM_RGBA(18., 18., 18., 1);
    }
    return _shopDetailsHead_view;
}

-(UILabel *)titile{
    
    if (!_titile) {
        _titile = [[UILabel alloc] init];
        _titile.text = @"B & O T R U E 360\nC R E E N";
        _titile.textColor = [UIColor whiteColor];
        _titile.font = [UIFont AmericanTypewriterBoldFontSize:15.];
        _titile.adjustsFontSizeToFitWidth = YES;
        _titile.numberOfLines= 0;
    }
    return _titile;
}
-(UILabel *)NewPrice{
    
    if (!_NewPrice) {
        _NewPrice = [[UILabel alloc]init];
        _NewPrice.text = @"型号";
        _NewPrice.textColor  = [UIColor whiteColor];
        _NewPrice.font = [UIFont HelveticaNeueBoldFontSize:12.];
    }
    
    return _NewPrice;
}

-(UILabel *)NewPricetow{
    
    if (!_NewPricetow) {
        _NewPricetow = [[UILabel alloc]init];
        _NewPricetow.text = @"品牌: KY245";
        _NewPricetow.textColor = YM_RGBA(216., 216., 216, 1.);
        _NewPricetow.font = [UIFont HeitiSCWithFontSize:10.];
    }
    return _NewPricetow;
    
}

-(UILabel *)URL{
    
    if (!_URL) {
        _URL = [[UILabel alloc]init];
        _URL.text = @"品牌网址:beoplay.com";
        _URL.textColor = [UIColor whiteColor];
        _URL.font = [UIFont AmericanTypewriterBoldFontSize:10.];
    }
    return _URL;
}

-(UIButton *)buy{
    
        if (!_buy) {
            _buy = [UIButton buttonWithType:UIButtonTypeCustom];
            _buy.backgroundColor = [UIColor whiteColor];
            [_buy setTitle:@"BUY" forState:UIControlStateNormal];
            [_buy addTarget:self action:@selector(actionClicketBuy:) forControlEvents:UIControlEventTouchUpInside];
            [_buy setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }

    return _buy;
}
-(UILabel *)picture{
    if (!_picture) {
        _picture = [[UILabel alloc] init];
        _picture.text = @"¥299.00";
        _picture.font = [UIFont AmericanTypewriterBoldFontSize:10.];
        _picture.textColor = [UIColor whiteColor];
        _picture.textAlignment = NSTextAlignmentRight;
    }
    return _picture;
    
}
-(UILabel *)Time{
    
    if (!_Time) {
        _Time = [[UILabel alloc]init];
        _Time.text = @"日期:10 days,3h left";
        _Time.font = [UIFont AmericanTypewriterBoldFontSize:9.];
        _Time.textColor = [UIColor whiteColor];
    }
    return  _Time;
}

-(UIButton *)popController {
    
    if (!_popController) {
        _popController = [UIButton buttonWithType:UIButtonTypeCustom];
        [_popController setTitle:@"返回" forState:UIControlStateNormal];
        _popController.titleLabel.font = [UIFont AmericanTypewriterBoldFontSize:12];
        [_popController addTarget:self action:@selector(Clickpop) forControlEvents:UIControlEventTouchUpInside];
//        _popController.textColor = [UIColor whiteColor];
    }
    _popController.frame = CGRectMake(LCF_SCREEN_WIDTH - 40, self.Time.frame.size.height + self.Time.frame.origin.y +200, 40, 40);
    return _popController;
}

-(void)actionClicketBuy:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(setWithShopDetailsClicketDelegate)]) {
        [self.delegate performSelector:@selector(setWithShopDetailsClicketDelegate)];
    }
}

-(void)actionTargebt:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(setWithShopDetailsClicketDelegateLoginButton:)]) {
        [self.delegate performSelector:@selector(setWithShopDetailsClicketDelegateLoginButton:) withObject:sender];
    }
}
- (void)Clickpop{
    
    if ([self.delegate respondsToSelector:@selector(setPopWothSharManager)]) {
        [self.delegate performSelector:@selector(setPopWothSharManager)];
    }
}

@end
