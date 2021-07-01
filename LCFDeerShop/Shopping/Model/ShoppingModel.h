//
//  ShoppingModel.h
//  LCFDeerShop
//
//  Created by 李春菲 on 17/1/10.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingModel : NSObject

@property(copy,nonatomic) NSString *imageName;//商品图片
@property(copy,nonatomic) NSString *goodsTitle;//商品标题
@property(copy,nonatomic) NSString *goodsType;//商品类型
@property(copy,nonatomic) NSString *goodsPrice;//商品单价
@property(assign,nonatomic) BOOL selectState;//是否选中状态
@property(assign,nonatomic) int goodsNum;//商品个数
@property(nonatomic,copy) NSString *oldPrice;
//@property(nonatomic,copy) NSString *jdPrice;
//@property(nonatomic,copy) NSString *wname;//商品名称

/* model 序列化方法 */
-(instancetype)initWithShopDict:(NSDictionary *)dict;

@end
