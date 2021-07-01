//
//  YMUtils.h
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/21.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCFUserResponse.h"
@interface YMUtils : NSObject


+(instancetype)shareUtils;
//存储模具
+(void)saveLoginParam:(LCFUserResponse *)loginParam;
//取模具
+(LCFUserResponse *)loginParam;
//本地通讯录
+(void)CheckAddressBookAuthorization:(void (^)(bool isAuthorized))block;

@end
