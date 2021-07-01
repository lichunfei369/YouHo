//
//  FootCollectionViewCell.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/16.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "FootCollectionViewCell.h"

@implementation FootCollectionViewCell

- (void)layoutSubviews {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    [super layoutSubviews];
    [self.contentView addSubview:self.title_icon];
    [self.contentView addSubview:self.titleLabel];
}


- (UIImageView *)title_icon {
    
    if (!_title_icon) {
        _title_icon = [[UIImageView alloc] init];
        
    }
    _title_icon.frame = CGRectMake(self.contentView.bounds.origin.x + 33, self.contentView.bounds.origin.y +16, LCF_SCREEN_WIDTH / 15.3, 25);
    
    return _title_icon;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = XNFont(10);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    _titleLabel.frame = CGRectMake(self.title_icon.frame.origin.x-2, self.title_icon.frame.origin.y + 35, LCF_SCREEN_WIDTH / 7.2, 12);
    return _titleLabel;
}

@end
