//
//  ShopCenterCell.m
//  LCFDeerShop
//
//  Created by 李春菲 on 17/1/12.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "ShopCenterCell.h"

@implementation ShopCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.contentView.backgroundColor = [UIColor whiteColor];
   
    
    
}

@end
