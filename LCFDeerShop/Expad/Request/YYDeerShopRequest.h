//
//  YYDeerShopRequest.h
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/8.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMHttpsEngine.h"
#import "QRNetworkEngine.h"
#import "QRNetworkEngine+QROAuth.h"
@interface YYDeerShopRequest : NSObject


+ (void)registerWithDic:(NSDictionary *)dic;
//获取分类列表
+ (void)GetWithShareManagerCategoryTitleImage:(YMFetchResultCompletionHandler)completionHandler;

/**
 热门推荐
 */
+ (void)getHotRecommendWithmoduleid:(NSString*)goodsname onSuccess:(NetworkSuccessBlock)successBlock onFailure:(NetworkFailureBlock)failureBlock;
@end
