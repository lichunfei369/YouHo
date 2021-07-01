//
//  CategoryModel.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/27.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"id":@"ID"};
}

//序列化列表数据

-(id)initWithData:(id)responseData{
 
    if (self = [super init]) {
        
        if (![[responseData objectForKey:@"icon_url"] isEqual:[NSNull null]]) {
            
            self.icon_url = [responseData objectForKey:@"icon_url"];
        }
        if (![[responseData objectForKey:@"name"] isEqual:[NSNull null]]) {
            
            self.name = [responseData objectForKey:@"name"];
        }
        if (![[responseData objectForKey:@"id"] isEqual:[NSNull null]]) {
            
            self.ID = [responseData objectForKey:@"id"];
        }
        if (![[responseData objectForKey:@"subcategories"] isEqual:[NSNull null]]) {
            
            self.subcategories = [responseData objectForKey:@"subcategories"];
        }
       
    }
    
    return self;
    
}

@end
