//
//  NSArray+MLTKit.h
//  AMCustomer
//
//  Created by 恺撒 on 16/9/2.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (MLTKit)

#pragma mark --- Safe

- (id)mlt_safeObjectAtIndex:(NSInteger)index;

- (NSUInteger)mlt_safeIndexOfObject:(id)anObject;

- (NSArray *)mlt_safeSubArrayWithRange:(NSRange)range;

#pragma mark --- JSON

- (NSString *)mlt_toJSONString;

+ (NSArray *)mlt_arrayFromJSONString:(NSString *)json;

@end
