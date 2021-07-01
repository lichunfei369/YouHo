//
//  LCFResponse.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/21.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "LCFResponse.h"

@implementation LCFResponse

-(id)initWithData:(id)responseData{
    
    if (self = [super init]) {
        if (![[responseData objectForKey:@"errorMsg"] isEqual:[NSNull null]]) {
            self.errorMsg = [responseData objectForKey:@"errorMsg"];
        }
        if (![[responseData objectForKey:@"errorCode"] isEqual:[NSNull null]]) {
            self.errorCode = [responseData objectForKey:@"errorCode"];
        }
        
        
    }
    return self;
}
@end
