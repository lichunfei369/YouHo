//
//  WebViewController.h
//  LCFDeerShop
//
//  Created by 李春菲 on 16/12/21.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "LCFViewController.h"

@interface WebViewController : LCFViewController
@property   (nonatomic ,copy) NSURL * requestUrl;
@property   (nonatomic ,copy) NSString * requestBody;

@end
