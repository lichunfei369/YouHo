//
//  ZZBaseParam.h
//  ZZNetworkRequest
//
//  Created by lichunfei on 16/4/6.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZBaseParam : NSObject

@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSString *app_key;
@property (nonatomic, strong) NSString *session;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *format;
@property (nonatomic, strong) NSString *v;
@property (nonatomic, strong) NSString *sign;

+ (instancetype)param;
+ (NSString *)encryptionSignWithParam:(ZZBaseParam *)param secret:(NSString *)secret;

@end
