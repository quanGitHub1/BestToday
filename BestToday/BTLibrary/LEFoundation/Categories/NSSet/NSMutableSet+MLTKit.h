//
//  NSMutableSet+MLTKit.h
//  AMCustomer
//
//  Created by 恺撒 on 16/9/5.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableSet (MLTKit)

#pragma mark --- Safe

- (void)mlt_safeAddObject:(id)anObject;

@end
