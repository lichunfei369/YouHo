//
//  QRNetworkEngine+QROAuth.h
//  TestProject
//
//  Created by lixinchao on 16/7/20.
//  Copyright © 2016年 duoshu. All rights reserved.
//

#import "QRNetworkEngine.h"

@interface QRNetworkEngine (QROAuth)

#define kQR_ErrCode_NoRelatedResources                 10001
#define kQR_ErrCode_VerificationFaild                  10004
#define kQR_ErrCode_SaveSuccess                        10010
#define kQR_ErrCode_SaveFaild                          10011
#define kQR_ErrCode_UploadError                        10013
#define kQR_ErrCode_MustBeFieldLose                    10014
#define kQR_ErrCode_IllegalUser                        11001
#define kQR_ErrCode_UsernamePwdError                   11002
#define kQR_ErrCode_DataAlreadyExist                   12001


+ (void)requestDataAPI:(NSString *)apiPath method:(HttpMethod)method params:(NSDictionary *)params onSuccess:(NetworkSuccessBlock)successBlock onFailure:(NetworkFailureBlock)failureBlock;

@end
