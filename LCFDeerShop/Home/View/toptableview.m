//
//  toptableview.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/20.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "toptableview.h"
#import "TopViewCell.h"
static NSInteger maxOption = 3;//默认最大3行
static CGFloat arrow_H = 8;//箭头高
static CGFloat arrow_W = 15;//箭头宽
@interface toptableview()<UITableViewDelegate,UITableViewDataSource> {
    ///向下或者向上展开超出屏幕时偏移的距离
    CGFloat _start_offSetY;
    CGFloat _start_offSetX;
    
    //箭头顶点坐标
   
    CGPoint arrow1;
    CGPoint arrow2;
    CGPoint arrow3;
    CAShapeLayer *arrow_layer;
    
    //cell行高
    CGFloat cell_height;
    
    //显示时的行数
    CGFloat end_Line;
    
    //弹出之后的宽高
    CGFloat viewHeight;
    CGFloat viewWidth;
    
}


@end

@implementation toptableview


#pragma mark - 初始化
- (instancetype)initOptionView {
    if (self = [super initWithFrame:CGRectMake(0, 64, 300, 300) style:UITableViewStylePlain]) {
        self.delegate = self;
        self.dataSource = self;
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self initSetting];
    }
    return self;
}
#pragma mark - 默认设置
- (void)initSetting {
    _maxLine = maxOption;
    cell_height = 40.f;
    _cornerRadius = 5;
    self.backColor = [UIColor whiteColor];
//    _coverColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3];
    _edgeInsets = UIEdgeInsetsZero;
}
//背景颜色
- (void)setBackColor:(UIColor *)backColor {
    _backColor = backColor;
    self.backgroundColor = _backColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

#pragma mark - 动画
- (void)animation_show {
    [self zoomOrOn];
    [UIView animateWithDuration:.3 animations:^{
        self.cover.alpha = .3;
        self.showView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}
#pragma mark - showView
- (UIView *)showView {
    if (!_showView) {
        _showView = [[UIView alloc] init];
        _showView.backgroundColor = [UIColor clearColor];
    }
    return _showView;
}


- (void)dismiss {
    [UIView animateWithDuration:.3 animations:^{
        [self zoomOrOn];
        self.cover.alpha = 0;
    } completion:^(BOOL finished) {
        self.showView.transform= CGAffineTransformIdentity;
        [self.showView removeFromSuperview];
        [self.cover removeFromSuperview];
    }];
}

#pragma mark - 是缩放或者展开
- (void)zoomOrOn {
    if (_vhShow) {
        if (_diretionType==MLMOptionSelectViewBottom || _diretionType==MLMOptionSelectViewTop) {
            self.showView.transform = CGAffineTransformMakeScale(1, 0.001);
        } else {
            self.showView.transform = CGAffineTransformMakeScale(0.001, 1);
        }
    } else {
        self.showView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _rowNumber?_rowNumber():0;;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_cell) {
        UITableViewCell *cell = _cell(indexPath);
        cell.contentView.backgroundColor = _backColor;
        cell.backgroundColor = _backColor;
        cell.selectionStyle = 0;
        return cell;
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _optionCellHeight?_optionCellHeight():cell_height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.selectedOption) {
        self.selectedOption(indexPath);
    }
}
#pragma mark - table_edit
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return _canEdit;
}
#pragma mark - 显示多少行
- (CGFloat)showLine {
    NSInteger row = _rowNumber?_rowNumber():0;
    NSInteger line = MIN(row, _maxLine);
    return line;
}

#pragma mark - 删除之后改变frame
- (void)changgeFrame {
    if ([self showLine] == 0) {
        [self dismiss];
    }
    if (end_Line <= [self showLine]) {
        return;
    }
    CGFloat less = MIN(1, end_Line - [self showLine]) * cell_height;
    viewHeight -= less;
    self.height -= less;
    self.showView.height = viewHeight;
   
}


- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof(self) weakSelf = self;
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (self.removeOption) {
            self.removeOption(indexPath);
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [weakSelf changgeFrame];
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction];
}


@end
