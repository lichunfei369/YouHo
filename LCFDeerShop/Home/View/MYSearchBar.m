//
//  MYSearchBar.m
//  Light
//
//  Created by 李春菲 on 16/9/16.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "MYSearchBar.h"

@interface MYSearchBar () <UISearchBarDelegate>

@end
@implementation MYSearchBar


+(MYSearchBar *)searchBarWithPlaceholder:(NSString *)placeholder{
    
    MYSearchBar * Searchbar = [[MYSearchBar alloc]init];
    Searchbar.delegate = Searchbar;
    Searchbar.placeholder = placeholder;
    Searchbar.tintColor = [UIColor whiteColor];
    [Searchbar setImage:[UIImage imageNamed:@"searchIcon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];

    UIView *searchBarSub = Searchbar.subviews[0];
   // 去除UISearchbar视图里的UISearchBarBackground之后，UISearchbar的背景也就透明了，同时也可以自定义颜色等 遍历所有searchbar中的view ios 7.1以上  和7.0一下是连个方法 需要判断一下版本方法
    
    for (UIView * subview in searchBarSub.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            [subview setBackgroundColor:YM_RGBA(247., 247., 270, 1.)];
            
        }
        
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
        }
    }
    
    return Searchbar;
}


-(BOOL) searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    !self.searchBarShouldBeginEditingBlock ? : self.searchBarShouldBeginEditingBlock ();

    return   NO;
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    !self.searchBarTextDidChangedBlock ? : self.searchBarTextDidChangedBlock();
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    !self.searchBarDidSearchBlock ? : self.searchBarDidSearchBlock();
}


@end
