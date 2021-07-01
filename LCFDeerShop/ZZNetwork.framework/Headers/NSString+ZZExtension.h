//
//  NSString+ZZExtension.h
//  ZZNetworkRequest
//
//  Created by lichunfei on 16/4/6.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZZExtension)

+ (NSString *)md5HexDigest:(NSString*)input;
+ (NSString *)md532BitUpper:(NSString *)input;
+ (NSString *)getNowTime;
+ (NSString *)getNowTimeStr;
+ (NSString *)hexStringWithString:(NSString *)string;
+ (NSData *)hexToBytesWithString:(NSString *)string;

@end
