//
//  MLTTimer.h
//  AMCustomer
//
//  Created by WangFaquan on 16/9/1.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
         
    NSTimer 定时器的封装
    主要是解决 NSTimer 被强引用的问题
    平时用 NStimer 时self被 NSTimer 强引用然而用 __weak 有时不管用，这里的思路就是造个假的 target 给 NSTimer
    target 的主要作用类似一个中间的代理人，它做的工作就是接下了 NSTimer 的强引用
 
 */

@interface MLTTimerTarget : NSObject

@property (nonatomic, weak,   readwrite) id target;
@property (nonatomic, assign, readwrite) SEL selector;
@property (nonatomic, weak,   readwrite) NSTimer* timer;

@end


typedef void (^MLTTimerHandler)(id userInfo);


@interface MLTTimer : NSObject


/**
 *  定时器的创建
 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                     block:(MLTTimerHandler)block
                                  userInfo:(id)userInfo
                                   repeats:(BOOL)repeats;


+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                    target:(id)aTarget
                                  selector:(SEL)aSelector
                                  userInfo:(id)userInfo
                                   repeats:(BOOL)repeats;


@end
