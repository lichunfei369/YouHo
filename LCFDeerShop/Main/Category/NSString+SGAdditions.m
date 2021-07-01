//
//  NSString+SGAdditions.m
//  Travel99
//
//  Created by 宋迪 on 15/11/18.
//  Copyright © 2015年 SG. All rights reserved.
//

#import "NSString+SGAdditions.h"
#import <CommonCrypto/CommonDigest.h>
#import "UIScreen+SGAdditions.h"

@implementation NSString (SGAdditions)
+ (NSString *)searchInString:(NSString *)string charStart:(char)charStart charEnd:(char)charEnd
{
    int start = 0, end = 0;
    
    for(int i = 0; i < [string length]; i++)
    {
        if([string characterAtIndex:i] == charStart && start == 0)
        {
            start = i+1;
            i += 1;
            continue;
        }
        if([string characterAtIndex:i] == charEnd)
        {
            end = i;
            break;
        }
    }
    
    end -= start;
    
    if (end < 0) end = 0;
    
    return [[string substringFromIndex:start] substringToIndex:end];
}

- (NSString *)searchCharStart:(char)start charEnd:(char)end
{
    return [NSString searchInString:self charStart:start charEnd:end];
}

- (NSInteger)indexOfCharacter:(char)character
{
    for(NSUInteger i = 0; i < [self length]; i++)
    {
        if([self characterAtIndex:i] == character)
        {
            return i;
        }
    }
    
    return -1;
}

- (NSString *)substringFromCharacter:(char)character
{
    NSInteger index = [self indexOfCharacter:character];
    if(index != -1)
        return [self substringFromIndex:index];
    else
        return @"";
}

- (NSString *)substringToCharacter:(char)character
{
    NSInteger index = [self indexOfCharacter:character];
    if(index != -1)
        return [self substringToIndex:index];
    else
        return @"";
}

- (NSString *)MD5
{
    if(self == nil || [self length] == 0)
        return nil;
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for(i=0;i<CC_MD5_DIGEST_LENGTH;i++)
    {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

- (NSString *)SHA1
{
    if(self == nil || [self length] == 0)
        return nil;
    
    unsigned char digest[CC_SHA1_DIGEST_LENGTH], i;
    CC_SHA1([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for(i=0;i<CC_SHA1_DIGEST_LENGTH;i++)
    {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

- (NSString *)SHA256
{
    if(self == nil || [self length] == 0)
        return nil;
    
    unsigned char digest[CC_SHA256_DIGEST_LENGTH], i;
    CC_SHA256([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for(i=0;i<CC_SHA256_DIGEST_LENGTH;i++)
    {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

- (NSString *)SHA512
{
    if(self == nil || [self length] == 0)
        return nil;
    
    unsigned char digest[CC_SHA512_DIGEST_LENGTH], i;
    CC_SHA512([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for(i=0;i<CC_SHA512_DIGEST_LENGTH;i++)
    {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

- (BOOL)hasString:(NSString *)substring
{
    return [self hasString:substring caseSensitive:YES];
}

- (BOOL)hasString:(NSString *)substring caseSensitive:(BOOL)caseSensitive
{
    if(caseSensitive)
        return [self rangeOfString:substring].location != NSNotFound;
    else
        return [self.lowercaseString rangeOfString:substring.lowercaseString].location != NSNotFound;
}

- (BOOL)isEmail
{
    return [NSString isEmail:self];
}

+ (BOOL)isEmail:(NSString *)email
{
    NSString *emailRegEx = @"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[email lowercaseString]];
}

+ (NSString *)convertToUTF8Entities:(NSString *)string
{
    return [[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[string
                                             stringByReplacingOccurrencesOfString:@"%27" withString:@"'"]
                                            stringByReplacingOccurrencesOfString:[@"%e2%80%99" capitalizedString] withString:@"’"]
                                           stringByReplacingOccurrencesOfString:[@"%2d" capitalizedString] withString:@"-"]
                                          stringByReplacingOccurrencesOfString:[@"%c2%ab" capitalizedString] withString:@"«"]
                                         stringByReplacingOccurrencesOfString:[@"%c2%bb" capitalizedString] withString:@"»"]
                                        stringByReplacingOccurrencesOfString:[@"%c3%80" capitalizedString] withString:@"À"]
                                       stringByReplacingOccurrencesOfString:[@"%c3%82" capitalizedString] withString:@"Â"]
                                      stringByReplacingOccurrencesOfString:[@"%c3%84" capitalizedString] withString:@"Ä"]
                                     stringByReplacingOccurrencesOfString:[@"%c3%86" capitalizedString] withString:@"Æ"]
                                    stringByReplacingOccurrencesOfString:[@"%c3%87" capitalizedString] withString:@"Ç"]
                                   stringByReplacingOccurrencesOfString:[@"%c3%88" capitalizedString] withString:@"È"]
                                  stringByReplacingOccurrencesOfString:[@"%c3%89" capitalizedString] withString:@"É"]
                                 stringByReplacingOccurrencesOfString:[@"%c3%8a" capitalizedString] withString:@"Ê"]
                                stringByReplacingOccurrencesOfString:[@"%c3%8b" capitalizedString] withString:@"Ë"]
                               stringByReplacingOccurrencesOfString:[@"%c3%8f" capitalizedString] withString:@"Ï"]
                              stringByReplacingOccurrencesOfString:[@"%c3%91" capitalizedString] withString:@"Ñ"]
                             stringByReplacingOccurrencesOfString:[@"%c3%94" capitalizedString] withString:@"Ô"]
                            stringByReplacingOccurrencesOfString:[@"%c3%96" capitalizedString] withString:@"Ö"]
                           stringByReplacingOccurrencesOfString:[@"%c3%9b" capitalizedString] withString:@"Û"]
                          stringByReplacingOccurrencesOfString:[@"%c3%9c" capitalizedString] withString:@"Ü"]
                         stringByReplacingOccurrencesOfString:[@"%c3%a0" capitalizedString] withString:@"à"]
                        stringByReplacingOccurrencesOfString:[@"%c3%a2" capitalizedString] withString:@"â"]
                       stringByReplacingOccurrencesOfString:[@"%c3%a4" capitalizedString] withString:@"ä"]
                      stringByReplacingOccurrencesOfString:[@"%c3%a6" capitalizedString] withString:@"æ"]
                     stringByReplacingOccurrencesOfString:[@"%c3%a7" capitalizedString] withString:@"ç"]
                    stringByReplacingOccurrencesOfString:[@"%c3%a8" capitalizedString] withString:@"è"]
                   stringByReplacingOccurrencesOfString:[@"%c3%a9" capitalizedString] withString:@"é"]
                  stringByReplacingOccurrencesOfString:[@"%c3%af" capitalizedString] withString:@"ï"]
                 stringByReplacingOccurrencesOfString:[@"%c3%b4" capitalizedString] withString:@"ô"]
                stringByReplacingOccurrencesOfString:[@"%c3%b6" capitalizedString] withString:@"ö"]
               stringByReplacingOccurrencesOfString:[@"%c3%bb" capitalizedString] withString:@"û"]
              stringByReplacingOccurrencesOfString:[@"%c3%bc" capitalizedString] withString:@"ü"]
             stringByReplacingOccurrencesOfString:[@"%c3%bf" capitalizedString] withString:@"ÿ"]
            stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
}

+ (NSString *)encodeToBase64:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)encodeToBase64
{
    return [NSString encodeToBase64:self];
}

+ (NSString *)decodeBase64:(NSString *)string
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)decodeBase64
{
    return [NSString decodeBase64:self];
}

- (NSString *)sentenceCapitalizedString
{
    if(![self length])
    {
        return @"";
    }
    NSString *uppercase = [[self substringToIndex:1] uppercaseString];
    NSString *lowercase = [[self substringFromIndex:1] lowercaseString];
    
    return [uppercase stringByAppendingString:lowercase];
}

- (NSString *)dateFromTimestamp
{
    NSString *year = [self substringToIndex:4];
    NSString *month = [[self substringFromIndex:5] substringToIndex:2];
    NSString *day = [[self substringFromIndex:8] substringToIndex:2];
    NSString *hours = [[self substringFromIndex:11] substringToIndex:2];
    NSString *minutes = [[self substringFromIndex:14] substringToIndex:2];
    
    return [NSString stringWithFormat:@"%@/%@/%@ %@:%@", day, month, year, hours, minutes];
}

- (NSString *)urlEncode
{
    return [self URLEncode];
}

- (NSString *)URLEncode
{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
}

- (NSString *)removeExtraSpaces
{
    NSString *squashed = [self stringByReplacingOccurrencesOfString:@"[ ]+" withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
    return [squashed stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)stringByReplacingWithRegex:(NSString *)regexString withString:(NSString *)replacement
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:nil];
    return [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:@""];
}

- (NSString *)HEXToString
{
    NSMutableString * newString = [NSMutableString string];
    NSArray * components = [self componentsSeparatedByString:@" "];
    for(NSString * component in components)
    {
        int value = 0;
        sscanf([component cStringUsingEncoding:NSASCIIStringEncoding], "%x", &value);
        [newString appendFormat:@"%c", (char)value];
    }
    return newString;
}

- (NSString *)stringToHEX
{
    NSUInteger len = [self length];
    unichar *chars = malloc(len * sizeof(unichar));
    [self getCharacters:chars];
    
    NSMutableString *hexString = [[NSMutableString alloc] init];
    
    for(NSUInteger i = 0; i < len; i++ )
    {
        [hexString appendFormat:@"%02x", chars[i]];
    }
    free(chars);
    
    return hexString;
}

- (id)stringToObject{
    if (!self || (NSNull *)self == [NSNull null] || [self isEqual:@""]) {
        return nil;
    }
    id object = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    return object;
}

+ (CGSize)contentHeightWithText:(NSString*)text withFont:(UIFont*)font withWidth:(CGFloat)width{
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    CGSize size =[text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:tdic
                                    context:nil].size;
    size=CGSizeMake(size.width, size.height+adapt750(10));
    return size;
}

+ (CGSize)contentWidthWithText:(NSString*)text withFont:(UIFont*)font withHeight:(CGFloat)height{
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    CGSize size =[text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:tdic
                                    context:nil].size;
    return size;
}

+(BOOL)isBlankString:(NSString*)str
{
    if (str == nil || str == NULL
        || [str isKindOfClass:[NSNull class]]
        || [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0
        || [str isEqualToString:@"(null)"]
        || [str isEqualToString:@"<null>"]
        || [str isEqualToString:@"null"])
    {
        return YES;
    }
    
    return NO;
}

+(NSString*)pinYinString:(NSString*)str
{
    NSMutableString *ms = [[NSMutableString alloc] initWithString:str];
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
        NSLog(@"Pingying: %@", ms); // wǒ shì zhōng guó rén
    }
    
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
        NSLog(@"Pingying: %@", ms); // wo shi zhong guo ren
    }
    
    return [ms lowercaseString];
}

+ (NSString*)stringWithInt:(NSInteger)intNumber{
    if (intNumber <= 0) {
        return @"";
    }
    return IntegerString(intNumber);
}

+ (NSString*)convertUrlString:(NSString*)str{
    return (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)str, NULL,(CFStringRef) @"!*'();:@&=+$,%#[]", kCFStringEncodingUTF8));
}

+(BOOL)isValidatePhone:(NSString *)email
{
    NSString * CU = @"^1\\d{10}$";
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    if ([regextestcu evaluateWithObject:email] == YES){
        return YES;}else{
            return NO;
        }
}

+ (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
+ (NSInteger)isValidateText:(NSString *)text {
    
    int strlength = 0;
    
    char* p = (char*)[text cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[text lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

//返回非空的文字
+(NSString *)StringNotNULLStr:(NSString*)str
{
    if (StringIsNullOrEmpty(str))
    {
        return @"";
    }
    else
        return str;

}

//获取文字宽度
+(CGSize)StringLength:(NSString *)str withSizeFloat:(UIFont*)font withSizeHeight:(CGFloat)SizeHeight
{
    CGSize titleSize = [[self StringNotNULLStr:str] sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, SizeHeight)];
    return titleSize;
}
+(CGRect)heightForString:(NSString*)str Size:(CGSize)size Font:(UIFont*)font Lines:(int)lines
{
    if (StringIsNullOrEmpty(str)) {
        return CGRectMake(0, 0, 0, 0);
    }
    static UILabel *lbtext;
    if (lbtext==nil) {
        lbtext    = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    }else{
        lbtext.frame=CGRectMake(0, 0, size.width, size.height);
    }
    lbtext.font=font;
    lbtext.text=str;
    lbtext.numberOfLines=lines;
    CGRect rect= [lbtext textRectForBounds:lbtext.frame limitedToNumberOfLines:lines];
    if(rect.size.height<0)
        rect.size.height=0;
    if (rect.size.width<0) {
        rect.size.width=0;
    }
    lbtext.font=font;
    lbtext.text=str;
    lbtext.numberOfLines=lines;
    
    return rect;
    
}

+(CGRect)heightForString:(NSString*)str Size:(CGSize)size Font:(UIFont*)font Lines:(int)lines LineSpacing:(CGFloat)LineSpacing
{
    if (StringIsNullOrEmpty(str)) {
        return CGRectMake(0, 0, 0, 0);
    }
    static UILabel *lbtext;
    if (lbtext==nil) {
        lbtext    = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    }else{
        lbtext.frame=CGRectMake(0, 0, size.width, size.height);
    }
    lbtext.numberOfLines = lines;
    lbtext.attributedText = [NSString heightForString:str
                                                 Font:font
                                          LineSpacing:LineSpacing];
    [lbtext sizeToFit];
//    lbtext.sgHeight = lbtext.sgHeight+LineSpacing;
    
    return lbtext.frame;
}
+(NSMutableAttributedString *)heightForString:(NSString *)str Font:(UIFont*)font LineSpacing:(CGFloat)LineSpacing
{
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:LineSpacing];
    
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attStr.length)];
    [attStr addAttributes:@{NSFontAttributeName: font} range:NSMakeRange(0, attStr.length)];
    return attStr;
}
+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
//+(BOOL) isValidateCode:(NSString *)code{
//    NSString *emailRegex = @"[1-9]\d{5}";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:code];
//}
@end
