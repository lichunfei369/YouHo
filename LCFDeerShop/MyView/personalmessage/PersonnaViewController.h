//
//  PersonnaViewController.h
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/23.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "LCFViewController.h"

@protocol PersonnaViewControllerDelegate <NSObject>

@optional

- (void)heardWithSharMagerImage:(UIImageView *)image;


@end

@interface PersonnaViewController : LCFViewController
@property   (nonatomic ,weak )  id          <PersonnaViewControllerDelegate>delegate;
@end
