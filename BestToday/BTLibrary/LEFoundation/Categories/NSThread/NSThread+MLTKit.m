//
//  NSThread+MLTKit.m
//  AMCustomer
//
//  Created by 恺撒 on 16/9/2.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#import "NSThread+MLTKit.h"

@implementation NSThread (MLTKit)

+ (void)mlt_runInMain:(void (^)(void))block {
    if (block) {
        if ([NSThread isMainThread]) {
            block();
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                block();
            });
        }
    }
}

+ (void)mlt_runInBackground:(void (^)(void))block {
    if (block) {
        if (![NSThread isMainThread]) {
            block();
        } else {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                block();
            });
        }
    }
}

@end
