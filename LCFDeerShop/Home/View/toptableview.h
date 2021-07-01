//
//  toptableview.h
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/20.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark - 设置需要的属性
///弹出方向,左右上下的区别，只有在上下或者左右都显示不下时，优先考虑的方向
typedef enum : NSUInteger {
    MLMOptionSelectViewBottom,//下
    MLMOptionSelectViewTop,//上
    MLMOptionSelectViewLeft,//左
    MLMOptionSelectViewRight//右
} MLMOptionSelectViewDirection;


typedef void(^ActionBack)(NSIndexPath*);

@interface toptableview : UITableView



/**
 **   设置  UITableviewcell  block回调方法
 */
@property   (nonatomic ,copy) UITableViewCell * (^cell)(NSIndexPath *);

/**
        设置分区数量
 */
 @property (nonatomic, copy) NSInteger(^rowNumber)() ;

/**
 设置cell高度
 */
@property   (nonatomic ,copy) float (^optionCellHeight)();


/**
 最大显示行数，默认大于3行显示3行
 */
@property (nonatomic, assign) CGFloat maxLine;


/**
 初始化

 @return initOptionView
 */


- (instancetype)initOptionView;

///圆角大小,默认5
@property (nonatomic, assign) CGFloat cornerRadius;

///背景颜色
@property (nonatomic, strong) UIColor *backColor;

///显示时，距离四周的间距，具体对齐方式，可以自行根据需求设置
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

///是否可以删除,YES时请在删除回调中删除对应数据
@property (nonatomic, assign) BOOL canEdit;
///删除回调
@property (nonatomic, copy) ActionBack removeOption;
///单击回调
@property (nonatomic, copy) ActionBack selectedOption;
///弹出朝向
@property (nonatomic, assign) MLMOptionSelectViewDirection diretionType;
///缩放 NO 竖直或水平展开 YES
@property (nonatomic, assign) BOOL vhShow;

///view
@property (nonatomic, strong) UIView *showView;
///背景层
@property (nonatomic, strong) UIView *cover;
///箭头顶点的位置和动画开始位置
@property (nonatomic, assign) CGFloat arrow_offset;//(0 - 1之间)
@end
