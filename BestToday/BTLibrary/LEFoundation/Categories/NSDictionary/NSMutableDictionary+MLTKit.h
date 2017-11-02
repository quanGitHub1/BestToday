//
//  NSMutableDictionary+MLTKit.h
//  AMCustomer
//
//  Created by 恺撒 on 16/9/2.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (MLTKit)

#pragma mark --- Safe

- (void)mlt_safeSetObject:(id)anObject forKey:(id)aKey;

- (void)mlt_setIntValue:(int)value forKey:(id)aKey;

- (void)mlt_setDoubleValue:(double)value forKey:(id)aKey;

- (void)mlt_setStringValueForKey:(NSString *)string forKey:(id)aKey;

@end
