//
//  Created by LiZhengxing on 11/29/12.
//  Copyright (c) 2012 com.cwn. All rights reserved.
//

#import "CWDataModel.h"
#import <objc/runtime.h>

// Holds metadata
static NSMutableDictionary *keyNames = nil; // key names for all subclass of ModelObject

@implementation CWDataModel

#pragma mark - init

// Before this class is first accessed, we'll need to build up our associated metadata, basically
// just a list of all our property names so we can quickly enumerate through them for various methods.
+ (void)initialize {

	if (nil == keyNames) {
        keyNames = [NSMutableDictionary new];
    }

	NSMutableArray *names = [NSMutableArray new];

    //需要保存从ModelObject往下的所有父子关系中keys
    //比如News继承至ModelObject，VideoNews继承至News，则VideoNews中必须保存News中的所有keys
	for (Class cls = self; cls != [CWDataModel class]; cls = [cls superclass]) {
		unsigned int varCount;
		Ivar *vars = class_copyIvarList(cls, &varCount);
		
		for (unsigned int i = 0; i < varCount; i++) {
			Ivar var = vars[i];
			NSString *name = [[NSString alloc] initWithUTF8String:ivar_getName(var)];
			[names addObject:name];
			
            name = nil;
		}

		free(vars);
	}
	//集合修改
	[keyNames setObject:names forKey:(id)self];
	names = nil;
}

- (NSArray*)allKeys {
	return [keyNames objectForKey:[self class]];
}

- (NSString *)capitalizedString:(NSString *)string {
    if (!HMJIsEmpty(string)) {
        return [string stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[string substringToIndex:1] uppercaseString]];
    }
    return nil;
}


- (CWDataModel *)createObjectFromKey:(NSString *)key keyMap:(NSDictionary *)keyMap {
    NSString *newKey = [keyMap objectForKey:key];

    if ([NSNull null] == (NSNull*)newKey) {
        key = nil;
    } else if (nil != newKey){
        key = newKey;
    }

    if (nil != key) {
        NSString* capitalizedClassName = [self capitalizedString:key];
        CWDataModel * object = (CWDataModel *)[[NSClassFromString(capitalizedClassName) alloc] init];
        NSAssert(object != nil, @"create object failed");
        return object;
    } else {
        return nil;
    }
}

- (void)setModelFromDictionary:(NSDictionary *)dict keyMap:(NSDictionary *)keyMap {
    for (NSString *key in [self allKeys]) {

        id value = [dict objectForKey:key];

        if ([value isKindOfClass:[NSArray class]]) {
            if ([(NSArray *)value count] > 0) {
                id subValue = [(NSArray *)value objectAtIndex:0];
                
                // 不允许数组嵌套数组
                if ([subValue isKindOfClass:[NSArray class]]) {
                    NSAssert(FALSE, @"you can't insert array into array");
                    
                    // 如果是dictionary就生成相应的model
                } else if ([subValue isKindOfClass:[NSDictionary class]]) {
                    NSMutableArray *array = [NSMutableArray array];
                    for (NSDictionary *subDict in (NSArray *)value) {
                        CWDataModel * object = [self createObjectFromKey:key keyMap:keyMap];
                        [object setModelFromDictionary:subDict keyMap:keyMap];
                        [array addObject:object];
                    }
                    [self setValue:array forKey:key];
                    
                    //如果是内置类型就直接赋值
                } else {
                    [self setValue:value forKey:key];
                }
            }
        } else if ([value isKindOfClass:[NSDictionary class]]) {
            CWDataModel * object = [self createObjectFromKey:key keyMap:keyMap];
            [object setModelFromDictionary:value keyMap:keyMap];
            [self setValue:object forKey:key];
        } else {
            if (nil != value && [NSNull null] != value) {
                [self setValue:value forKey:key];
            }
        }
    }
}

#pragma mark - NSCoder

// NSCoder implementation, for unarchiving
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
		for (NSString *name in [self allKeys])
			[self setValue:[aDecoder decodeObjectForKey:name] forKey:name];
	}
	return self;
}

// NSCoder implementation, for archiving
- (void)encodeWithCoder:(NSCoder *)aCoder {

	for (NSString *name in [self allKeys]) {
        id object = [self valueForKey:name];
        if ([object conformsToProtocol:@protocol(NSCoding)]) {
            [aCoder encodeObject:[self valueForKey:name] forKey:name];
        }
    }
}

#pragma mark - copy

// NSCopying implementation
- (id)copyWithZone:(NSZone *)zone {
	
	id copied = [[[self class] alloc] init];
	
	for (NSString *name in [self allKeys])
		[copied setValue:[self valueForKey:name] forKey:name];
	
	return copied;
}

#pragma mark - fast enumeration

// We implement the NSFastEnumeration protocol to behave like an NSDictionary - the enumerated values are our property (key) names.

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len;
{
	return [[self allKeys] countByEnumeratingWithState:state objects:buffer count:len];
}


#pragma mark - equal

// Override isEqual to compare model objects by value instead of just by pointer.
- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    }
	if ([other isKindOfClass:[self class]]) {
		for (NSString *name in [self allKeys]) {
			id a = [self valueForKey:name];
			id b = [other valueForKey:name];
			
			// extra check so a == b == nil is considered equal
            // 否则的话a==nil的情况下，无论b是否nil，[a isEqual:b] == nil
			if ((a || b) && ![a isEqual:b]) {
                return NO;
            }
		}
		return YES;
	} else {
        return NO;
    }
}

// Must override hash as well, this is taken directly from RMModelObject, basically
// classes with the same layout return the same number.
- (NSUInteger)hash {
	return (NSUInteger)[self allKeys];

}

#pragma mark - description

- (void)writeLineBreakToString:(NSMutableString *)string withTabs:(NSUInteger)tabCount {
	[string appendString:@"\n"];
	for (int i=0;i<tabCount;i++) [string appendString:@"\t"];
}

// Prints description in a nicely-formatted and indented manner.
- (void)writeToDescription:(NSMutableString *)description withIndent:(NSUInteger)indent {
	
	[description appendFormat:@"<%@ %p", NSStringFromClass([self class]), self];
	
	for (NSString *name in [self allKeys]) {
		
		[self writeLineBreakToString:description withTabs:indent];
		
		id object = [self valueForKey:name];
		
		if ([object isKindOfClass:[CWDataModel class]]) {
			[object writeToDescription:description withIndent:indent+1];
		}
		else if ([object isKindOfClass:[NSArray class]]) {
			
			[description appendFormat:@"%@ =", name];
			
			for (id child in object) {
				[self writeLineBreakToString:description withTabs:indent+1];
				
				if ([child isKindOfClass:[CWDataModel class]])
					[child writeToDescription:description withIndent:indent+2];
				else
					[description appendString:[child description]];
			}
		}
		else if ([object isKindOfClass:[NSDictionary class]]) {
			
			[description appendFormat:@"%@ =", name];
			
			for (id key in object) {
				[self writeLineBreakToString:description withTabs:indent];
                [description appendFormat:@"\t%@ = ",key];

				id child = [object objectForKey:key];
				
				if ([child isKindOfClass:[CWDataModel class]])
					[child writeToDescription:description withIndent:indent+2];
				else
					[description appendString:[child description]];
			}
		}
		else {
			[description appendFormat:@"%@ = %@", name, object];
		}
	}
		
	[description appendString:@">"];
}

// Override description for helpful debugging.
- (NSString*)description {
	NSMutableString *description = [NSMutableString string];
	[self writeToDescription:description withIndent:1];

	return description;
}

@end
