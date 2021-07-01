//
//  SearchHistoryCell.m
//  国通合众BIDemo
//
//  Created by 李荣建 on 2016/10/28.
//  Copyright © 2016年 李荣建. All rights reserved.
//

#import "SearchHistoryCell.h"
@interface SearchHistoryCell ()

@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *leftImageView;

@end

@implementation SearchHistoryCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
        WEAKSELF(ws);
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(ws);
            make.left.equalTo(ws).offset(30);
        }];
        
        self.deleteBt = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.deleteBt setImage:[UIImage imageNamed:@"delete"] forState:(UIControlStateNormal)];
        [self addSubview:_deleteBt];
        [_deleteBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_titleLabel);
            make.right.equalTo(ws).offset(-20);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        self.deleteBt.hidden = YES;
        //增加长按手势
        UILongPressGestureRecognizer *longPressGR = [[ UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        longPressGR.minimumPressDuration = 0.7;
        [self addGestureRecognizer:longPressGR];
    }
    return self;
}
//-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
//    if(action == @selector(delete:))
//    {
//        return YES;
//    }
//    else
//    {
//        return [super canPerformAction:action withSender:sender];  
//    }  
//}

-(void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
    if([self isHighlighted])
    {
        [[self delegate] performSelector:@selector(showMenu:) withObject:self];
    }
    
}
@end
