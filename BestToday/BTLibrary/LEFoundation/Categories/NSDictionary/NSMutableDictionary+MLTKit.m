//
//  NSMutableDictionary+MLTKit.m
//  AMCustomer
//
//  Created by 恺撒 on 16/9/2.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#import "NSMutableDictionary+MLTKit.h"
//#import "MLTMacros.h"

@implementation NSMutableDictionary (MLTKit)

#pragma mark --- Safe

- (void)mlt_safeSetObject:(id)anObject forKey:(id)aKey {
    if (!isValidKey(aKey)) {
        return;
    }
    if ([aKey isKindOfClass:[NSString class]]) {
        [self setValue:anObject forKey:aKey];
    }
    else {
        if (anObject != nil) {
            [self setObject:anObject forKey:aKey];
        }
        else {
            [self removeObjectForKey:aKey];
        }
    }
}

- (void)mlt_setIntValue:(int)value forKey:(id)aKey{
    [self mlt_safeSetObject:[[NSNumber numberWithInt:value] stringValue] forKey:aKey];
}

- (void)mlt_setDoubleValue:(double)value forKey:(id)aKey{
    [self mlt_safeSetObject:[[NSNumber numberWithDouble:value] stringValue] forKey:aKey];
}

- (void)mlt_setStringValueForKey:(NSString *)string forKey:(id)aKey{
    [self mlt_safeSetObject:string forKey:aKey];
}

@end
