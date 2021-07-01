//
//  SearchHistoryCell.h
//  国通合众BIDemo
//
//  Created by 李荣建 on 2016/10/28.
//  Copyright © 2016年 李荣建. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchHistoryCell;

@protocol SearchHistoryCellDelegate <NSObject>

@optional

- (void)showMenu:(SearchHistoryCell *)cell;


@end
@interface SearchHistoryCell : UITableViewCell
@property (nonatomic, assign) id delegate;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *deleteBt;

@end
