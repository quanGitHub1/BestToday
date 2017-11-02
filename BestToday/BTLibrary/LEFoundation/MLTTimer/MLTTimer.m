//
//  MLTTimer.m
//  AMCustomer
//
//  Created by WangFaquan on 16/9/1.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#import "MLTTimer.h"

@implementation MLTTimerTarget

- (void)fire:(NSTimer *)timer{
    
    if (self.target) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.selector withObject:timer.userInfo afterDelay:0.0f];
    } else {
#pragma clang diagnostic pop
        [self.timer invalidate];
    }
}

@end

@implementation MLTTimer


+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                     target:(id)aTarget
                                   selector:(SEL)aSelector
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats{
    MLTTimerTarget *timerTarget = [[MLTTimerTarget alloc] init];
    timerTarget.target = aTarget;
    timerTarget.selector = aSelector;
    timerTarget.timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                         target:timerTarget
                                                       selector:@selector(fire:)
                                                       userInfo:userInfo
                                                        repeats:repeats];
    return timerTarget.timer;

}


+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(MLTTimerHandler)block
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats{
    
    NSMutableArray *userInfoArray = [NSMutableArray arrayWithObject:[block copy]];
    
    if (userInfo != nil){
        [userInfoArray addObject:userInfo];
    }
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(timerBlockInvoke:)
                                       userInfo:[userInfoArray copy]
                                        repeats:repeats];
}



+ (void)timerBlockInvoke:(NSArray *)userInfo{
    MLTTimerHandler block = userInfo[0];
    id info = nil;
    if (userInfo.count == 2){
        info = userInfo[1];
    }
    
    if (block){
        block(info);
    }
}

@end
