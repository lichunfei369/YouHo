//
//  ZZBaseTool.h
//  ZZNetworkRequest
//
//  Created by lichunfei on 16/4/6.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZBaseTool : NSObject

+ (void)getWithUrl:(NSString *)url param:(id)param success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

+ (void)postWithUrl:(NSString *)url param:(id)param success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

+ (void)postImageWithUrl:(NSString *)url param:(id)param imageData:(NSData *)imageData fileName:(NSString *)fileName success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

@end
