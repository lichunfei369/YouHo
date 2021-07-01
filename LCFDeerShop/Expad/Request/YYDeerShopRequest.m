//
//  YYDeerShopRequest.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/8.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "YYDeerShopRequest.h"

@implementation YYDeerShopRequest


#pragma mark-----------  自己封装网络请求模式

/*
*     ---------------------------- 说明  -------------------
                  自己封装一套网络请求接口模式   上面是POST  下面试GET请求 (GET请求需要拼接域名地址) POST(直接传一个字段);
 */

+ (void)registerWithDic:(NSDictionary *)dic{
    
    [YMHttpsEngine post:API_URL parameters:dic completionHandler:^(BOOL success, NSError *error, id result) {
        
//        
//                //转成JSON串显示
//                if ([result isKindOfClass:[NSData class]]) {
//                    result = [NSJSONSerialization JSONObjectWithData:result options:kNilOptions error:nil];
//                }
//                if (success) {
//        
//                    completionHandler(YES,nil,result);
//                }else{
//                    completionHandler(NO,nil,result);
//        
//        
//                }

    }];
}

+ (void)GetWithShareManagerCategoryTitleImage:(YMFetchResultCompletionHandler)completionHandler {
    NSString * str = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/item_categories/tree"];
    
    [YMHttpsEngine get:str completionHandler:^(BOOL success, NSError *error, id result) {
    

        if (success) {
            
            /* 转成JSON串显示  */
            if ([result isKindOfClass:[NSData class]]) {
                result = [NSJSONSerialization JSONObjectWithData:result options:kNilOptions error:nil];
            }
            /* 判断成功字段  这个字段是和后台约定好的*/
            if ([result[@"message"]isEqualToString:@"OK"]) {
                //            NSLog(@"%@",result[@"errorMsg"]);
                completionHandler(YES,error,result);
                
            }else{
                //            NSLog(@"%@",result);
                completionHandler(NO,error,result[@"errorMsg"]);
                
            }
            
            
        }else{
            completionHandler(NO,error,@"网络错误");
            
        }

        
    }];
    
}

#pragma mark---------------------   其他封装模式  这个是针对  公司有公参数和预定判断模式 封装请求()

/*
 *     ---------------------------- 说明  -------------------
                    method:   为接口名称.
                    app_key:  分配给用户的APPKey
                    session:  用户登录授权成功后，获取到的授权信息。当此API的标签上注明：“需要授权”，则此参数必传；“不需要授权”，则此参数不需要传；“可选授权”，则此参数为可选。
                    sign :      API输入参数签名结果，签名算法介绍
                      v:      为版本号
                    format:     响应格式。默认为xml格式，可选值：xml，json。
 
 */
/**
 热门推荐
 */
+ (void)getHotRecommendWithmoduleid:(NSString*)goodsname onSuccess:(NetworkSuccessBlock)successBlock onFailure:(NetworkFailureBlock)failureBlock
{
    
    // 说明 :  moduleid  num  moduleflag 请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"moduleid" : [NSNumber numberWithInt:moduleid],@"num" : [NSNumber numberWithInt:num],@"moduleflag" : moduleflag}];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"goodsname" : goodsname}];
    
    NetworkSuccessBlock theSuccessBlock = ^(id data)
    {
        successBlock(data);
    };
    
    NetworkFailureBlock theFailureBlock = ^(NSError *error)
    {
        failureBlock(error);
    };
    
    
    [QRNetworkEngine requestDataAPI:kSERVER_SUBURL_getHotRecommendDetails method:POST params:params onSuccess:theSuccessBlock onFailure:theFailureBlock];
}

@end
