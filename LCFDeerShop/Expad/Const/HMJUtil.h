//
//  HMJUtil.h
//  HMJHome
//
//  Created by shaowenxia on 14-4-14.
//  Copyright (c) 2014年 shaowenxia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#ifndef RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
//#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGBACOLOR(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#endif

//视图添加
#define ADD_VIEW(x) [self addSubview:x]
#define ADD_SELF_VIEW(x) [self.view addSubview:x]

//颜色设置
#define BG_COLOR    0xf3f3f3
#define THEME_COLOR 0x2b7bd4
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//尺寸设置
#define iPhoneWidth  [UIScreen mainScreen].bounds.size.width
#define iPhoneHeight [UIScreen mainScreen].bounds.size.height
#define iPhone5Height 568
#define iPhoneNavHeight 44
#define iPhoneTabHeight 48
#define KeyBordHeight 252

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iphone4 (self.view.window.frame.size.height == 480 ? YES : NO)

//#define AppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]

//安全释放内存
#define SAFE_RELEASE(x) [x release];x=nil

#define TimeOff    1
#define StartValue 60

#define HXPASSWORD @"111111"
#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"

//全局通知

static inline BOOL HMJIsEmpty(id thing) {
    return thing == nil ||
    ([thing isEqual:[NSNull null]]) ||
    ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0) ||
    ([thing respondsToSelector:@selector(count)]  && [(NSArray *)thing count] == 0);
}

@interface HMJUtil : NSObject

+ (UIImage *)imageFormFile:(NSString *)name;
+ (UIImage *)imageFormFile:(NSString *)name type:(NSString *)type;

//本地缓存 目录创建
+ (NSString*)createCacheDirectoryWithName:(NSString*)name;
+ (NSString *)createPicCacheDirectoryWithName:(NSString *)name;
+ (NSString*)createIconCacheDirectory;
+ (NSString*)createArchiverCacheDirectory;
+ (NSString*)createTextCacheDirectory;

+ (void)saveWithFilename:(NSString*)filename data:(NSData*)data;
+ (NSData*)loadWithFilename:(NSString*)filename;

+ (UIColor *)colorWithHexString: (NSString *) stringToConvert;
//检查网络
+(BOOL)isNetworkOK;
//密码加密
//+(NSString *)encrypt:(NSString *)password;
//验证用户名格式
+(BOOL)isUserNameString:(NSString *)str;
//验证密码长度是否6位－20位
+(BOOL)checkPasswordLength:(NSString *)str;
//验证手机号码格式
+ (BOOL)isPhoneNumberString:(NSString *)str;
//验证身份证号
+ (BOOL)isIdentityString:(NSString *)str;
//验证正整数
+ (BOOL)isPositiveNumber:(NSString *)str;
//验证邮箱格式
+(BOOL)isEmailFormatString:(NSString *)str;
//md5 base64密码加密
//+ (NSString *)md5_base64:(NSString*)_string;

//获取A到Z
+ (NSArray*)lettersForSectionsWithHot:(BOOL)hot;

+(NSTimeInterval) convertUNIXFromDate:(NSDate *)aDate;

+(BOOL)isDateExpired:(NSTimeInterval)interval;

+(NSDate *)convertDateFromString:(NSString*)aDate;

+(NSDate *)convertDateFromStringOnlyTime:(NSString*)aDate;

+(NSString *)compareCurrentTime:(NSString*)compareDate;

+ (id)paramHashWithMD5:(id)parameter withEncodeParameter:(NSString *)encodeParameter;

+(NSMutableDictionary *)generateHashWithMD5:(NSMutableDictionary *)parameter withEncodeParameter:(NSString *)encodeParameter;

@end
