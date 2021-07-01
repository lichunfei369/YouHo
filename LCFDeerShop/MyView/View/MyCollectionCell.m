//
//  MyCollectionCell.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/15.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "MyCollectionCell.h"

@implementation MyCollectionCell


-(void)layoutSubviews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    [super layoutSubviews];
    [self.contentView addSubview:self.orderLabel];
    [self.contentView addSubview:self.allOderLabel];
    [self.contentView addSubview:self.rightImage_icon];
}

-(UILabel *)orderLabel{
    if (!_orderLabel) {
        _orderLabel = [[UILabel alloc] init];
       
        _orderLabel.font = [UIFont AmericanTypewriterBoldFontSize:15.];
    }
    _orderLabel.frame = CGRectMake(self.contentView.bounds.origin.x + 10, self.contentView.bounds.origin.y + 5, LCF_SCREEN_WIDTH / 6, 21);
    return _orderLabel;
}


-(UILabel *)allOderLabel {
    
    if (!_allOderLabel) {
        _allOderLabel = [[UILabel alloc] init];
       
        _allOderLabel.font = XNFont(13);
    
    }
    _allOderLabel.frame = CGRectMake(LCF_SCREEN_WIDTH - (LCF_SCREEN_WIDTH  / 4.5) - 20, self.contentView.bounds.origin.y + 5, LCF_SCREEN_WIDTH  / 4.5, 21);
    return    _allOderLabel;
}
@end
