//
//  TopViewCell.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/20.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "TopViewCell.h"

@implementation TopViewCell

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
    self.contentView.backgroundColor = [UIColor blackColor];
}

@end
