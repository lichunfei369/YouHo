//
//  YMHttpsEngine.m
//  yuanmeng
//
//  Created by 楚小亓 on 16/9/20.
//  Copyright © 2016年 楚小亓. All rights reserved.
//

#import "YMHttpsEngine.h"

@implementation YMHttpsEngine

+ (void)get:(NSString *)URLString completionHandler:(YMFetchResultCompletionHandler)completionHandler{
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completionHandler(YES,nil,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandler(NO,nil,error);
    }];
}

+ (void)post:(NSString *)URLString
  parameters:(id)parameters
timeoutInterval:(NSNumber *)timeoutInterval
completionHandler:(YMFetchResultCompletionHandler)completionHandler{
   
//    NSMutableDictionary *params = [self getRequestParams:parameters];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:30];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

   
    }];
}
/**
 *  post from请求
 *
 *  @param URLString  地址
 *  @param parameters 参数
 *  @param success    成功block
 *  @param failure    失败block
 */
+ (void)post:(NSString *)URLString
  parameters:(id)parameters
completionHandler:(YMFetchResultCompletionHandler)completionHandler
{
//    parameters = [YMHttpsEngine dictionaryToJson:parameters];
////
////    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    NSError *err;
//    NSData *data = [parameters dataUsingEncoding:NSUTF8StringEncoding];
//    
//    
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
//                                                        options:NSJSONReadingMutableContainers
//                                                          error:&err];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
    
        completionHandler(YES,nil,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
           
        completionHandler(NO,error,operation);
        
    }];
}


+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


/**
 *  post muti-part请求
 *
 *  @param URLString  地址
 *  @param parameters 参数
 *  @param block      muti-part
 *  @param success    成功block
 *  @param failure    失败block
 */
+ (void)post:(NSString *)URLString
  parameters:(id)parameters
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
completionHandler:(YMFetchResultCompletionHandler)completionHandler
{
 
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];

    
//    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:block success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completionHandler(YES,nil,responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandler(NO,error,operation);
    }];
    
}



@end
