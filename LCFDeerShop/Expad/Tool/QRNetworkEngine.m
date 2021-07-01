//
//  QRNetworkEngine.m
//  TestProject
//
//  Created by 李春菲 on 17/1/11.
//  Copyright © 2017年 duoshu. All rights reserved.
//

#import "QRNetworkEngine.h"
//#import "QRStatusStore.h"

static NSString *baseUrlKey = @"debug_base_url";

@implementation QRNetworkEngine

+ (void)internetReachableWithblock:(NetworkReachabilityBlock)reachabilityBlock
{
    NSURL *baseURL = [NSURL URLWithString:@"http://www.baidu.com/"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    __block AFHTTPRequestOperationManager *blockManager = manager;
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                reachabilityBlock(WWAN);
                [blockManager.reachabilityManager stopMonitoring];
                [operationQueue setSuspended:YES];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                reachabilityBlock(WIFI);
                [blockManager.reachabilityManager stopMonitoring];
                [operationQueue setSuspended:YES];
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
            default:
                reachabilityBlock(NONE);
                [operationQueue setSuspended:YES];
                [blockManager.reachabilityManager stopMonitoring];
                break;
        }
    }];
    
    [manager.reachabilityManager startMonitoring];
}

+ (void)configueNewRequestHeader
{
//    UIWebView *theWebV = [[UIWebView alloc] initWithFrame:CGRectZero];
//    
//    NSString *userAgent = [theWebV stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
//    NSString *appIdentifer = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
//    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
//    NSString *theUserAgent = userAgent;
//    NSRange SJBRange = [userAgent rangeOfString:[NSString stringWithFormat:@" %@ %@", kSJB_APPID, appIdentifer]];
//    
//    if (SJBRange.location == NSNotFound) {
//        theUserAgent = [NSString stringWithFormat:@"%@/%@ %@ %@", userAgent, version, kSJB_APPID, appIdentifer];
//    }
//    
//    NSDictionary *dictionary = @{@"UserAgent": theUserAgent};
//    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

//+ (void)setBaseURL:(NSString *)baseUrl
//{
//    if ([@"1" isEqualToString:QRDEBUG])
//    {
//        if (baseUrl && baseUrl.length > 0) {
//            [QRStatusStore saveSomething:baseUrl forKey:baseUrlKey];
//            return;
//        }
//        [QRStatusStore saveSomething:QRHOST_Dev forKey:baseUrlKey];
//    }
//    else
//    {
//        [QRStatusStore removeSomethingWithKey:baseUrlKey];
//    }
//}

//+ (NSString *)baseUrl
//{
////    if ([@"1" isEqualToString:QRDEBUG]) {
////        
////        if ([QRStatusStore somethingWithKey:baseUrlKey]) {
////            return [QRStatusStore somethingWithKey:baseUrlKey];
////        }
////        
////        [QRStatusStore saveSomething:QRHOST_Dev forKey:baseUrlKey];
////        return [QRStatusStore somethingWithKey:baseUrlKey];
////    }
////    
////    return QRHOST_Pro;
//    
//    return QRHOST_Dev;
//}

+ (void)requestDataAPI:(NSString *)apiPath method:(HttpMethod)method params:(NSDictionary *)params customHeaderField:(NSDictionary *)customHeaderFields onSuccess:(NetworkSuccessBlock)successBlock onFailure:(NetworkFailureBlock)failureBlock
{
//    NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", [self baseUrl]]];
//    NSString *baseUrlStr = [NSString stringWithFormat:@"http://%@", [self baseUrl]];
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    
    if (customHeaderFields) {
        [customHeaderFields enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
            [manager.requestSerializer setValue:object forHTTPHeaderField:key];
        }];
    }
    
    void (^theAFHTTPRequestOperationSuccess)(AFHTTPRequestOperation *operation, id responseObject) = ^void(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"\nAPI:%@ \nParams:%@ \nJSON: %@", operation.request.URL.absoluteString, params, responseObject);
        successBlock(responseObject);
    };
    
    void (^theAFHTTPRequestOperationFailure)(AFHTTPRequestOperation *operation, NSError *error) = ^void(AFHTTPRequestOperation *operation, NSError *error) {
        if (operation.response.statusCode >= 400 && operation.response.statusCode < 500){
            id errResp = operation.responseObject;
            NSLog(@"Error %ld: %@", (long)operation.response.statusCode, error);
            if (errResp)
            {
                successBlock(errResp);
            } else {
                if (error.domain && [error.domain rangeOfString:@"com"].length > 0) {
                    NSError *err = [NSError errorWithDomain:@"网络连接错误" code:100000 userInfo:nil];
                    failureBlock(err);
                } else {
                    failureBlock(error);
                }
            }
        } else {
            NSLog(@"Error %ld: %@", (long)operation.response.statusCode, error);
            
            NSError *err = [NSError errorWithDomain:@"请检查您的网络连接" code:100000 userInfo:nil];
            failureBlock(err);
        }
    };
    
    switch (method) {
        case GET:
            [manager GET:kSERVER_HEADERURL parameters:params success:theAFHTTPRequestOperationSuccess failure:theAFHTTPRequestOperationFailure];
            break;
        case POST:
            [manager POST:kSERVER_HEADERURL parameters:params success:theAFHTTPRequestOperationSuccess failure:theAFHTTPRequestOperationFailure];
            break;
        case PUT:
            [manager PUT:kSERVER_HEADERURL parameters:params success:theAFHTTPRequestOperationSuccess failure:theAFHTTPRequestOperationFailure];
            break;
        case DELETE:
            [manager DELETE:kSERVER_HEADERURL parameters:params success:theAFHTTPRequestOperationSuccess failure:theAFHTTPRequestOperationFailure];
            break;
        case HEAD:
            [manager HEAD:kSERVER_HEADERURL parameters:params success:^(AFHTTPRequestOperation *operation){} failure:theAFHTTPRequestOperationFailure];
            break;
        case PATCH:
            [manager PATCH:kSERVER_HEADERURL parameters:params success:theAFHTTPRequestOperationSuccess failure:theAFHTTPRequestOperationFailure];
            break;
        case POSTMUTIPART:
        {
            NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:params];
            
            for (NSString *keyStr in [params allKeys])
            {
                if([keyStr isEqualToString:@"file_byte"])
                {
                    [mutableDic removeObjectForKey:keyStr];
                }
            }
            
//            for (NSString *key in [params allKeys])
//            {
//                if ([key isEqualToString:@"block"] || [key isEqualToString:@"param"]) {
//                    continue;
//                }
//                
//                [mutableDic setObject:[params objectForKey:key] forKey:key];
//            }
            NSLog(@"传送实际的数据为:%@",mutableDic);
            NSLog(@"传送file_byte的数据为:%@",params[@"file_byte"]);
            
            [manager POST:kSERVER_HEADERURL parameters:mutableDic constructingBodyWithBlock:params[@"file_byte"] success:theAFHTTPRequestOperationSuccess failure:theAFHTTPRequestOperationFailure];
        }
            
            break;
        default:
            break;
    }
}

@end
