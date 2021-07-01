//
//  MYSearchBar.h
//  Light
//
//  Created by 李春菲 on 16/9/16.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYSearchBar : UISearchBar
@property (nonatomic,copy) void (^searchBarShouldBeginEditingBlock) (); //点击block回调
@property (nonatomic,copy) void (^searchBarTextDidChangedBlock)     (); //编辑回调
@property (nonatomic,copy) void (^searchBarDidSearchBlock)          (); //编辑回调

+(MYSearchBar *)searchBarWithPlaceholder:(NSString *)placeholder;

@end
