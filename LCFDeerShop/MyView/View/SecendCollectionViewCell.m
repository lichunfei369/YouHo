//
//  SecendCollectionViewCell.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/16.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "SecendCollectionViewCell.h"

@implementation SecendCollectionViewCell

- (void)layoutSubviews{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    [super layoutSubviews];
    [self.contentView addSubview:self.stroll];
    [self.contentView addSubview:self.titleImage];
    
    
}

- (UILabel *)stroll {
    
    if (!_stroll) {
        _stroll = [[UILabel alloc] init];
        _stroll.font = XNFont(15);
    }
    _stroll.frame = CGRectMake(self.titleImage.frame.size.width + 30, self.contentView.frame.origin.y +10, LCF_SCREEN_WIDTH / 3, 16);
    return _stroll;
    
}

-(UIImageView *)titleImage {
    if (!_titleImage) {
        _titleImage = [[UIImageView alloc] init];
    }
    _titleImage.frame = CGRectMake(self.contentView.frame.origin.x +10, self.contentView.frame.origin.y +10, 20, 20);
   return _titleImage;
}

@end
