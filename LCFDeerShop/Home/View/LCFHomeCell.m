//
//  LCFHomeCell.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/21.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "LCFHomeCell.h"

@interface LCFHomeCell()
@property   (nonatomic,retain) UIView  * shop_view;
@end

@implementation LCFHomeCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    [self setUpView];
}

-(void)setUpView{
    
    [self.contentView addSubview:self.shop_Image];
    [self.contentView addSubview:self.shop_label];
    [self.contentView addSubview:self.shop_view];
}
- (UIImageView *)shop_Image{
    
    if (!_shop_Image) {
        
        _shop_Image = [[UIImageView alloc]init];
        
        
    }
    _shop_Image.frame = CGRectMake(0, 5, self.bounds.size.width, self.bounds.size.height - 5);
    
    
    return _shop_Image;
    
    
    
}
- (UIView *)shop_view{
    
    if (!_shop_view) {
        
        _shop_view = [[UIView alloc]init];
        _shop_view.backgroundColor = [UIColor blackColor];
        
        _shop_view.alpha = 0;  //设置透明度
        
        
    }
    _shop_view.frame = CGRectMake(0, 5, self.bounds.size.width, self.bounds.size.height - 5);
    
    return _shop_view;
}
- (UILabel *)shop_label{
    if (!_shop_label) {
        
        _shop_label = [[UILabel alloc]init];
        _shop_label.font = [UIFont systemFontOfSize:24.];
        _shop_label.textColor = [UIColor whiteColor];
        _shop_label.textAlignment = NSTextAlignmentCenter;
    }
    _shop_label.frame = CGRectMake(0, 70, LCF_SCREEN_WIDTH, 20);
    
    return _shop_label;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
