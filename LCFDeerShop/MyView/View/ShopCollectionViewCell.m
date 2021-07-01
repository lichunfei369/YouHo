//
//  ShopCollectionViewCell.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/19.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "ShopCollectionViewCell.h"

@implementation ShopCollectionViewCell


- (void)layoutSubviews {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    [super layoutSubviews];
    [self.contentView addSubview:self.shopimage];
    [self.contentView addSubview:self.titile];
    [self.contentView addSubview:self.price];
    
}


- (UIImageView * )shopimage {
    
    if (!_shopimage) {
        _shopimage = [[UIImageView alloc] init];
    }
    _shopimage.frame = CGRectMake(self.contentView.bounds.origin.x, self.contentView.bounds.origin.x, self.contentView.frame.size.width, self.contentView.frame.size.height - 90);
    return _shopimage;
}

- (UILabel *)titile {
    
    if (!_titile) {
        _titile = [[UILabel alloc] init];
        _titile.textAlignment = NSTextAlignmentCenter;
        _titile.numberOfLines = 0;
        _titile.font = [UIFont AmericanTypewriterBoldFontSize:14];
        
    }
    _titile.frame = CGRectMake(self.contentView.bounds.origin.x, self.shopimage.frame.size.height + 10 , self.contentView.frame.size.width, 40);
    return  _titile;
}
- (UILabel *)price {
    
    if (!_price) {
        _price = [[UILabel alloc] init];
        _price.textAlignment = NSTextAlignmentCenter;
        _price.font = [UIFont AvenirWithFontSize:12];
    }
    _price.frame = CGRectMake(self.contentView.bounds.origin.x, self.titile.frame.size.height +self.titile.frame.origin.y +10, self.contentView.frame.size.width, 20);
    return _price;
}
@end
