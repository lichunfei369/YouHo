//
//  RequestLoginParam.h
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/13.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestLoginParam : ZZBaseParam
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *ip;

+(instancetype)param;

@end
