//
//  NSString+SGAdditions.h
//  Travel99
//
//  Created by 宋迪 on 15/11/18.
//  Copyright © 2015年 SG. All rights reserved.
//

#import <Foundation/Foundation.h>

#define StringNotNullAndEmpty(str) (str!=nil && ![str isEqualToString:@""] && ![str isEqualToString:@"null"])
#define isBlankString(str) [NSString isBlankString:(str)]
#define IntegerString(num)     [[NSNumber numberWithInteger:(num)] stringValue]
#define DoubleString(num)      [[NSNumber numberWithDouble:(num)] stringValue]
#define StringFormat(format, ...) [NSString stringWithFormat:format, __VA_ARGS__]
#define LocalizedStringFormat(format, ...) [NSString stringWithFormat:NSLocalizedString(format, @""), __VA_ARGS__]
//判断字符串是否为空或者为空字符串
#define StringIsNullOrEmpty(str) (str==nil||[str isEqualToString:@""])

@interface NSString (SGAdditions)

//返回非空的文字  不处理空格,只处理NULL
+(NSString *)StringNotNULLStr:(NSString*)str;
//获取文字宽度
+(CGSize)StringLength:(NSString *)str withSizeFloat:(UIFont*)font withSizeHeight:(CGFloat)SizeHeight;

+ (NSString *)searchInString:(NSString *)string
                   charStart:(char)start
                     charEnd:(char)end;

- (NSString *)searchCharStart:(char)start
                      charEnd:(char)end;

- (NSInteger)indexOfCharacter:(char)character;

- (NSString *)substringFromCharacter:(char)character;

- (NSString *)substringToCharacter:(char)character;

- (NSString *)MD5;

- (NSString *)SHA1;

- (NSString *)SHA256;

- (NSString *)SHA512;

- (BOOL)hasString:(NSString *)substring;

- (BOOL)hasString:(NSString *)substring caseSensitive:(BOOL)caseSensitive;

- (BOOL)isEmail;

+ (BOOL)isEmail:(NSString *)email;

+ (NSString *)convertToUTF8Entities:(NSString *)string;

+ (NSString *)encodeToBase64:(NSString *)string;

- (NSString *)encodeToBase64;

+ (NSString *)decodeBase64:(NSString *)string;

- (NSString *)decodeBase64;

- (NSString *)sentenceCapitalizedString;

- (NSString *)dateFromTimestamp;

- (NSString *)urlEncode DEPRECATED_MSG_ATTRIBUTE("Use -URLEncode");

- (NSString *)URLEncode;

- (NSString *)removeExtraSpaces;

- (NSString *)stringByReplacingWithRegex:(NSString *)regexString withString:(NSString *)replacement;

- (NSString *)HEXToString;

- (NSString *)stringToHEX;

- (id)stringToObject;

+ (CGSize)contentHeightWithText:(NSString*)text withFont:(UIFont*)font withWidth:(CGFloat)width;
+ (CGSize)contentWidthWithText:(NSString*)text withFont:(UIFont*)font withHeight:(CGFloat)height;

+ (BOOL)isBlankString:(NSString*)str;

+ (NSString*)pinYinString:(NSString*)str;

+ (NSString*)stringWithInt:(NSInteger)intNumber;

+ (NSString*)convertUrlString:(NSString*)str;
//判断手机号
+ (BOOL)isValidatePhone:(NSString *)email;
//判断纯数字
+ (BOOL)isPureInt:(NSString *)string;
//计算字符个数
+ (NSInteger)isValidateText:(NSString *)text;
//计算字体高度，行间距
+(CGRect)heightForString:(NSString*)str Size:(CGSize)size Font:(UIFont*)font Lines:(int)lines;
+(CGRect)heightForString:(NSString*)str Size:(CGSize)size Font:(UIFont*)font Lines:(int)lines LineSpacing:(CGFloat)LineSpacing;
//返回行间距字符串
+(NSMutableAttributedString *)heightForString:(NSString *)str Font:(UIFont*)font LineSpacing:(CGFloat)LineSpacing;
//邮箱验证
+(BOOL)isValidateEmail:(NSString *)email;
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
@end
