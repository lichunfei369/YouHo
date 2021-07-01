//
//  ShoppingModel.m
//  LCFDeerShop
//
//  Created by 李春菲 on 17/1/10.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "ShoppingModel.h"

@implementation ShoppingModel

-(instancetype)initWithShopDict:(NSDictionary *)dict{
    
    self.imageName = dict[@"imageurl"];
    self.goodsTitle = dict[@"wname"];
    self.goodsPrice = dict[@"jdPrice"];
    self.goodsNum = [dict[@"totalCount"]intValue];
    self.goodsType = dict[@"diffMobilePrice"];
    self.oldPrice = dict[@"catid"];
    
    self.selectState = [dict[@"selectState"]boolValue];
//    self.jdPrice = dict[@"jdPrice"];
//    self.imageurl = dict[@"imageurl"];
//    self.wname = dict[@"wname"];
    return self;
}


@end
