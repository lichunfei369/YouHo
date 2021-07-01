//
//  ShopCenterView.m
//  LCFDeerShop
//
//  Created by 李春菲 on 17/1/12.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "ShopCenterView.h"

@implementation ShopCenterView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setView];
        
    }
    return self;
}

- (void)setView {
    
    self.backgroundColor = [UIColor redColor];
    
}
@end
