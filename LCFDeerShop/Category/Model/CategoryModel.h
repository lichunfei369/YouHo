//
//  CategoryModel.h
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/27.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "CWDataModel.h"

@interface CategoryModel : CWDataModel

@property   (nonatomic ,retain)     NSString * icon_url;

@property   (nonatomic ,retain)     NSString * name;

@property   (nonatomic ,retain)     NSString * ID;
@property (nonatomic,retain) NSString *subcategories;

-(id)initWithData:(id)responseData;
@end
