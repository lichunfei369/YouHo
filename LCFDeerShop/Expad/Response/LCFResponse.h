//
//  LCFResponse.h
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/21.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "CWDataModel.h"

@interface LCFResponse : CWDataModel
@property   (nonatomic,copy)    NSString        *       errorCode;
@property   (nonatomic,copy)    NSString        *       errorMsg;

-(id)initWithData:(id)responseData;
@end
