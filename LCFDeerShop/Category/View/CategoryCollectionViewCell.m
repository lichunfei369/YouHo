//
//  CategoryCollectionViewCell.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/26.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "CategoryCollectionViewCell.h"

@implementation CategoryCollectionViewCell



- (void)layoutSubviews {
    self.contentView.backgroundColor = [UIColor whiteColor];
    [super layoutSubviews];
    [self.contentView addSubview:self.title_image];
    [self.title_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(self.contentView.frame.size.width));
        make.height.equalTo(@(self.contentView.frame.size.height - 20));
        make.centerX.equalTo(self.contentView);
        make.leading.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.collection_label];
    [self.collection_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.title_image);
        make.top.equalTo(self.title_image.mas_bottom).offset(5);
    }];
}

- (UIImageView *)title_image {
    
    if (!_title_image) {
        _title_image = [[UIImageView alloc] init];
        
    }
    return   _title_image;
}

- (UILabel *)collection_label {
    
    if (!_collection_label) {
        _collection_label = [[UILabel alloc] init];
        _collection_label.textAlignment = NSTextAlignmentCenter;
        _collection_label.font = [UIFont AmericanTypewriterBoldFontSize:12];
        
    }
    return  _collection_label;
}


@end
