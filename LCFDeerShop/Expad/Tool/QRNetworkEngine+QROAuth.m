//
//  QRNetworkEngine+QROAuth.m
//  TestProject
//
//  Created by lixinchao on 16/7/20.
//  Copyright © 2016年 duoshu. All rights reserved.
//



#import "QRNetworkEngine+QROAuth.h"
#import "NSString+SGAdditions.h"

@implementation QRNetworkEngine (QROAuth)

/**
                            ---------------------------- 说明  -------------------
 method:   为接口名称.
 app_key:  分配给用户的APPKey
 session:  用户登录授权成功后，获取到的授权信息。当此API的标签上注明：“需要授权”，则此参数必传；“不需要授权”，则此参数不需要传；“可选授权”，则此参数为可选。
 sign :      API输入参数签名结果，签名算法介绍
 v:      为版本号
 format:     响应格式。默认为xml格式，可选值：xml，json。
 
 */
+ (void)requestDataAPI:(NSString *)apiPath method:(HttpMethod)method   params:(NSDictionary *)params onSuccess:(NetworkSuccessBlock)successBlock onFailure:(NetworkFailureBlock)failureBlock
{
    NSMutableDictionary *mutParams = [[NSMutableDictionary alloc] initWithDictionary:params];
    
    //时间戳str
    NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
    NSString *timestampStr = [NSString stringWithFormat:@"%d",(int)timestamp];
    
    [mutParams setObject:apiPath forKey:@"method"];
    [mutParams setObject:kAPPKey forKey:@"app_key"];
    [mutParams setObject:timestampStr forKey:@"timestamp"];
    [mutParams setObject:@"json" forKey:@"format"];
    [mutParams setObject:@"1.0" forKey:@"v"];
    
    //判断条件,bety[]类型除掉
    NSArray *keys = [mutParams allKeys];
    NSMutableDictionary *midDic = [[NSMutableDictionary alloc] initWithDictionary:mutParams];
    
    for (NSString *keyStr in keys)
    {
        if([keyStr isEqualToString:@"file_byte"])
        {
            [midDic removeObjectForKey:keyStr];
        }
    }
    
    [mutParams setObject:[self getSignatureParams:midDic] forKey:@"sign"];//sign签名
    

    NSLog(@"最后的字典数据为:%@",mutParams);
    
    NetworkSuccessBlock theSuccessBlock = ^(id data)
    {
        successBlock(data);
    };
    NetworkFailureBlock theFailureBlock = ^(NSError *error) {
        NSLog(@"失败信息____%@",error);
        failureBlock(error);
    };
    [QRNetworkEngine requestDataAPI:@"" method:method params:mutParams customHeaderField:nil onSuccess:theSuccessBlock onFailure:theFailureBlock];
}




#pragma mark - Private Methods
+ (NSString *)getSignatureParams:(NSMutableDictionary*)MuDic
{
    
    NSArray *keys = [MuDic allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
            return [obj1 compare:obj2 options: NSNumericSearch];
        }];
    
    NSString *MyCommpareStr = @"" ;//拼接的string
    for (NSString *categoryId in sortedArray)
    {
        MyCommpareStr = [MyCommpareStr stringByAppendingFormat:@"%@%@",categoryId,[MuDic objectForKey:categoryId]];
    }
    MyCommpareStr = [kSecret stringByAppendingString:MyCommpareStr];
    return [MyCommpareStr MD5];
}



@end



