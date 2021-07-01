//
//  ProductDetailsWebViewController.h
//  LCFDeerShop
//
//  Created by 李春菲 on 17/1/13.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "WebViewController.h"

@interface ProductDetailsWebViewController : LCFViewController
@property (nonatomic, copy) NSString    *productId;
@property (nonatomic, copy) NSURL *requestUrl;
@property (nonatomic, copy) NSString *requestBody;
@end
