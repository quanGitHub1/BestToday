//
//  NSMutableArray+MLTKit.h
//  AMCustomer
//
//  Created by 恺撒 on 16/9/2.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (MLTKit)

#pragma mark --- Safe

- (void)mlt_safeAddObject:(id)anObject;

- (void)mlt_safeInsertObject:(id)object atIndex:(NSUInteger)index;

- (void)mlt_safeInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexs;

- (void)mlt_safeRemoveObjectAtIndex:(NSUInteger)index;

- (void)mlt_safeRemoveObjectsInRange:(NSRange)range;

@end
