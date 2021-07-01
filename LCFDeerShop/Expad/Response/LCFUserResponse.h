//
//  LCFUserResponse.h
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/21.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "LCFResponse.h"

@interface LCFUserResponse : LCFResponse
@property   (nonatomic,strong)  NSString * accountId;       //类目ID
@property   (nonatomic,strong)  NSString * accountCode;
@property   (nonatomic,strong)  NSString * pwd;             //密码
@property   (nonatomic,strong)  NSString * accountType;     //类目类型
@property   (nonatomic,strong)  NSString * userId;          //用户ID
@property   (nonatomic,strong)  NSString * status;
@property   (nonatomic,strong)  NSString * shopId;          //商品ID
@property   (nonatomic,strong)  NSString * disabledDate;
@property   (nonatomic,strong)  NSString * userName;      //用户名
@property   (nonatomic,strong)  NSString * tel;          //电话
@property   (nonatomic,strong)  NSString * address;      //地址
@property   (nonatomic,strong)  NSString * sex;         //性别
@property   (nonatomic,strong)  NSString * point;
@property   (nonatomic,strong)  NSString * userStatus;
@property   (nonatomic,strong)  NSString * tel2;
@property   (nonatomic,strong)  NSString * token;
@end
