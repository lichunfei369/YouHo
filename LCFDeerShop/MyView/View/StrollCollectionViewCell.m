//
//  StrollCollectionViewCell.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/16.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "StrollCollectionViewCell.h"

@implementation StrollCollectionViewCell


-(void)layoutSubviews {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    [super layoutSubviews];
    [self.contentView addSubview:self.footImageView];
    
}

- (UIImageView *)footImageView {
    if (!_footImageView) {
        _footImageView = [[UIImageView alloc] init];
        
    }
    _footImageView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
   return  _footImageView;
    
}
@end
