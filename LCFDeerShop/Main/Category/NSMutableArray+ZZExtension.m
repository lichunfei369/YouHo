//
//  NSMutableArray+ZZExtension.m
//  FormaldehydeDetectingMouse
//
//  Created by 李春菲 on 16/5/13.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "NSMutableArray+ZZExtension.h"

@implementation NSMutableArray (ZZExtension)

+ (void)clearAllWithMutableArray:(NSMutableArray *)mutableArray
{
    if (mutableArray.count != 0) {
        [mutableArray removeAllObjects];
    }
}

@end
