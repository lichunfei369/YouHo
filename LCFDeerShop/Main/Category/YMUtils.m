//
//  YMUtils.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/21.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "YMUtils.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
static YMUtils * shareUtils;
#define  kFike [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"loginParam.data"]

@implementation YMUtils

+(instancetype)shareUtils{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareUtils = [[self alloc] init];
    });
    return shareUtils;
}
+(void)saveLoginParam:(LCFUserResponse *)loginParam{
    
   [NSKeyedArchiver archiveRootObject:loginParam toFile:kFike];
}

//取模型
+(LCFUserResponse *)loginParam{
    
    // 加载模型
    id loginParam = [NSKeyedUnarchiver unarchiveObjectWithFile:kFike];
    return loginParam;
}

+(void)CheckAddressBookAuthorization:(void (^)(bool isAuthorized))block
{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    
    if (authStatus != kABAuthorizationStatusAuthorized)
    {
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
                                                 {
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         if (error)
                                                         {
                                                             NSLog(@"Error: %@", (__bridge NSError *)error);
                                                         }
                                                         else if (!granted)
                                                         {
                                                             
                                                             block(NO);
                                                         }
                                                         else
                                                         {
                                                             block(YES);
                                                         }
                                                     });
                                                 });
    }
    else
    {
        block(YES);
    }
    
}



@end
