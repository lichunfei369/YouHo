//
//  FMDBDataBase.h
//  国通合众BIDemo
//
//  Created by 李荣建 on 2016/11/3.
//  Copyright © 2016年 李荣建. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface FMDBDataBase : NSObject
+ (FMDatabase *)sharedManager;
@end
