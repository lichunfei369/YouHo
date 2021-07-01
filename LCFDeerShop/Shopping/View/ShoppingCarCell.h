//
//  ShoppingCarCell.h
//  LCFDeerShop
//
//  Created by 李春菲 on 17/1/10.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingModel.h"
#import "AddNumberView.h"
#import "LineLabel.h"

@protocol ShoppingCarCellDelegate

-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag;

- (void)tapImageWithSharManager:(UITableViewCell *)sender;

@end

typedef void(^TapImageBLOCK)();

@interface ShoppingCarCell : UITableViewCell<AddNumberViewDelegate>

@property (nonatomic,strong) UIImageView *checkImg;

@property (nonatomic,strong) UIImageView *shopImageView;

@property (nonatomic,strong) UILabel *shopNameLab; //商品标题

@property (nonatomic,strong) UILabel *priceLab;

@property (nonatomic,strong) LineLabel *oldPriceLab;//原价


@property (nonatomic,strong) UILabel *shopTypeLab;//商品型号

@property (nonatomic,strong) UIButton *jianBtn;//减数量按钮

@property (nonatomic,strong) UIButton *addBtn;//加数量按钮

@property (nonatomic,strong) UILabel *numberLab;//显示数量

@property (nonatomic,strong) ShoppingModel *shoppingModel;

@property (assign,nonatomic) BOOL selectState;//选中状态

@property (nonatomic,assign) id<ShoppingCarCellDelegate>delegate;

@property (copy, nonatomic) TapImageBLOCK selectHandle;

@property (nonatomic,strong) AddNumberView *addNumberView;
@end


