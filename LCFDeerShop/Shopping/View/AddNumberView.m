//
//  AddNumberView.m
//  LCFDeerShop
//
//  Created by 李春菲 on 17/1/10.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "AddNumberView.h"

@implementation AddNumberView

-(instancetype)initWithFrame:(CGRect)frame{
    
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self createSubViews];
    }
    return self;
}
-(void)createSubViews{
    
    self.SubtractBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.SubtractBtn.frame = CGRectMake(0,0, 26, 22);
    [self.SubtractBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.SubtractBtn.tag = 11;
    [self.SubtractBtn setImage:IMAGENAMED(@"jian_icon") forState:UIControlStateNormal];
    
    [self addSubview:self.SubtractBtn];
    
    UIImageView *numberBg = [[UIImageView alloc]initWithFrame:CGRectMake(self.SubtractBtn.right-4, self.SubtractBtn.top, 50,22)];
    numberBg.image = IMAGENAMED(@"numbe_bg_icon");
    
    [self addSubview:numberBg];
    
    
    self.numberLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, numberBg.width, numberBg.height)];
    self.numberLab.text = @"1";
    self.numberLab.textAlignment = NSTextAlignmentCenter;
    self.numberLab.textColor = [UIColor darkGrayColor];
    self.numberLab.font = XNFont(12);
    [numberBg addSubview:self.numberLab];
    
    
    
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(numberBg.right-5,self.SubtractBtn.top, 26, 22);
    self.addBtn.tag = 12;
    [self.addBtn setImage:IMAGENAMED(@"add_icon") forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addBtn];
    
    
}
/* 代理传值  传中间加个label字符串 */
-(void)setNumberString:(NSString *)numberString{
    
    
    _numberString = numberString;
    
    self.numberLab.text = numberString;
}

- (void)awakeFromNib {
    
    
    
    
}


/* 购物车减号方法 */
- (void)deleteBtnAction:(UIButton *)sender {
    
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(deleteBtnAction:addNumberView:)]){
        
        [self.delegate deleteBtnAction:sender addNumberView:self];
    }
    
    
}
/* 购物车加号方法 */
- (void)addBtnAction:(UIButton *)sender {
    
   
    if(self.delegate && [self.delegate respondsToSelector:@selector(addBtnAction:addNumberView:)]){
        
        [self.delegate addBtnAction:sender addNumberView:self];
    }
    
}

@end
