//
//  CategoryTableViewCell.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/26.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "CategoryTableViewCell.h"

@implementation CategoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)layoutSubviews {
    self.contentView.backgroundColor = [UIColor whiteColor];
    [super layoutSubviews];
    [self.contentView addSubview:self.title_label];
    [self.title_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
    }];
}

- (UILabel *)title_label {
    
    if (!_title_label) {
        _title_label = [[UILabel alloc] init];
        _title_label.textAlignment = NSTextAlignmentCenter;
        _title_label.font = [UIFont AmericanTypewriterBoldFontSize:14];
        
    }
    return  _title_label;
}

@end
