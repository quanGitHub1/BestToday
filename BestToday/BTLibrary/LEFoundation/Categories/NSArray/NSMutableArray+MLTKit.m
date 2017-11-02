//
//  NSMutableArray+MLTKit.m
//  AMCustomer
//
//  Created by 恺撒 on 16/9/2.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#import "NSMutableArray+MLTKit.h"

@implementation NSMutableArray (MLTKit)

#pragma mark --- Safe

- (void)mlt_safeAddObject:(id)anObject {
    if (anObject) {
        [self addObject:anObject];
    }
}

- (void)mlt_safeInsertObject:(id)object atIndex:(NSUInteger)index {
    if (object == nil) {
        return;
    } else if (index > self.count) {
        return;
    } else {
        [self insertObject:object atIndex:index];
    }
}

- (void)mlt_safeInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexs {
    NSUInteger firstIndex = indexs.firstIndex;
    if (indexs == nil) {
        return;
    } else if (indexs.count!=objects.count || firstIndex>objects.count) {
        return;
    } else {
        [self insertObjects:objects atIndexes:indexs];
    }
}

- (void)mlt_safeRemoveObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return;
    } else {
        [self removeObjectAtIndex:index];
    }
}

- (void)mlt_safeRemoveObjectsInRange:(NSRange)range {
    NSUInteger location = range.location;
    NSUInteger length = range.length;
    if (location + length > self.count) {
        return;
    } else {
        [self removeObjectsInRange:range];
    }
}

@end
