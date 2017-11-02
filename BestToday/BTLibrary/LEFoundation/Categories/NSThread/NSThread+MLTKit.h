//
//  NSThread+MLTKit.h
//  AMCustomer
//
//  Created by 恺撒 on 16/9/2.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSThread (MLTKit)

+ (void)mlt_runInMain:(void (^)(void))block;

+ (void)mlt_runInBackground:(void (^)(void))block;

@end
