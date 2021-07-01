//
//  ZZAESUtil.h
//  test
//
//  Created by lichunfei on 16/5/18.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZAESUtil : NSObject

#pragma mark - AES加密
//将string转成带密码的data
+ (NSString *)encryptAESData:(NSString *)string app_key:(NSString *)key;

//将带密码的data转成string
+ (NSString *)decryptAESData:(NSData *)data app_key:(NSString *)key;

#pragma mark - base64
+ (NSData *)decodeBase64String:(NSString *)string;

@end
