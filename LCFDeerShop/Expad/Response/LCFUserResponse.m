//
//  LCFUserResponse.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/21.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "LCFUserResponse.h"

@implementation LCFUserResponse

//序列化
-(id)initWithData:(id)responseData{
    if (self = [super init])
    {
        if (![[responseData objectForKey:@"accountId"] isEqual:[NSNull null]])
        {
            self.accountId = [responseData objectForKey:@"accountId"];
        }
        if (![[responseData objectForKey:@"accountCode"] isEqual:[NSNull null]])
        {
            self.accountCode = [responseData objectForKey:@"accountCode"];
        }
        if (![[responseData objectForKey:@"pwd"] isEqual:[NSNull null]])
        {
            self.pwd = [responseData objectForKey:@"pwd"];
        }
        if (![[responseData objectForKey:@"accountType"] isEqual:[NSNull null]])
        {
            self.accountType = [responseData objectForKey:@"accountType"];
        }
        if (![[responseData objectForKey:@"userId"] isEqual:[NSNull null]])
        {
            self.userId = [responseData objectForKey:@"userId"];
        }
        if (![[responseData objectForKey:@"status"] isEqual:[NSNull null]])
        {
            self.status = [responseData objectForKey:@"status"];
        }
        if (![[responseData objectForKey:@"shopId"] isEqual:[NSNull null]])
        {
            self.shopId = [responseData objectForKey:@"shopId"];
        }
        if (![[responseData objectForKey:@"disabledDate"] isEqual:[NSNull null]])
        {
            self.disabledDate = [responseData objectForKey:@"disabledDate"];
        }
        if (![[responseData objectForKey:@"userName"] isEqual:[NSNull null]])
        {
            self.userName = [responseData objectForKey:@"userName"];
        }
        if (![[responseData objectForKey:@"tel"] isEqual:[NSNull null]])
        {
            self.tel = [responseData objectForKey:@"tel"];
        }
        if (![[responseData objectForKey:@"address"] isEqual:[NSNull null]])
        {
            self.address = [responseData objectForKey:@"address"];
        }
        if (![[responseData objectForKey:@"sex"] isEqual:[NSNull null]])
        {
            self.sex = [responseData objectForKey:@"sex"];
        }
        if (![[responseData objectForKey:@"point"] isEqual:[NSNull null]])
        {
            self.point = [responseData objectForKey:@"point"];
        }
        if (![[responseData objectForKey:@"userStatus"] isEqual:[NSNull null]])
        {
            self.userStatus = [responseData objectForKey:@"userStatus"];
        }
        if (![[responseData objectForKey:@"tel2"] isEqual:[NSNull null]])
        {
            self.tel2 = [responseData objectForKey:@"tel2"];
        }
        if (![[responseData objectForKey:@"token"] isEqual:[NSNull null]])
        {
            self.token = [responseData objectForKey:@"token"];
        }
        
    }
    return self;
}

@end
