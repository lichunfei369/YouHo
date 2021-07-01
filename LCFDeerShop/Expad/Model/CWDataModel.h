//
//  Created by LiZhengxing on 11/29/12.
//  Copyright (c) 2012 com.cwn. All rights reserved.
//

/*
  该类来自SMModelObject
 */

/*
 继承CWDataModel的类拥有如下功能:
 1. 实现了NSCoding，可以直接序列化。
 2. 实现了NSCopying，可以直接copy。
 3. 实现了NSFastEnumeration, 可以直接使用for语法。
 4. 实现了isEqual和hash，可以直接比较
 5. 直接从json object赋值
 */

/*
  注意：
  1. 关于NSFastEnumeration, 可以像NSDictionary那样直接访问keys
  for (NSString* key in model) {
  }
 */
#import <Foundation/Foundation.h>

@interface CWDataModel : NSObject <NSCoding, NSCopying, NSFastEnumeration>

/**
 * parse all data to self
 *
 * keyMap 针对需要过滤名称的key
 */
- (void)setModelFromDictionary:(NSDictionary *)dict keyMap:(NSDictionary *)keyMap;

/**
 * get all keys
 */
- (NSArray*)allKeys;

@end
