//
//  YMHttpsEngine.h
//  yuanmeng
//
//  Created by 楚小亓 on 16/9/20.
//  Copyright © 2016年 楚小亓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

typedef void (^YMFetchResultCompletionHandler)(BOOL success, NSError *error, id result);

@interface YMHttpsEngine : NSObject




/**
 *  post from请求
 *
 *  @param URLString  地址
 *  @param parameters 参数
 *  @param completionHandler
 */
+ (void)post:(NSString *)URLString
  parameters:(id)parameters
completionHandler:(YMFetchResultCompletionHandler)completionHandler;

/**
 *  post from请求
 *
 *  @param URLString  地址
 *  @param parameters 参数
 *  @param timeoutInterval   超时时间
 *  @param completionHandler
 */
+ (void)post:(NSString *)URLString
  parameters:(id)parameters
timeoutInterval:(NSNumber *)timeoutInterval
completionHandler:(YMFetchResultCompletionHandler)completionHandler;

/**
 *  post muti-part请求
 *
 *  @param URLString  地址
 *  @param parameters 参数
 *  @param block      muti-part
 *  @param completionHandler
 */
+ (void)post:(NSString *)URLString
  parameters:(id)parameters
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
completionHandler:(YMFetchResultCompletionHandler)completionHandler;

/**
 *  get 请求
 *
 *  @param URLString         地址
 *  @param completionHandler
 */
+ (void)get:(NSString *)URLString
completionHandler:(YMFetchResultCompletionHandler)completionHandler;



@end
