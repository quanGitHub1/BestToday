//
//  UIView+MLTAnimation.h
//  AMCustomer
//
//  Created by fuyao on 16/9/2.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIViewAnimationCompletionHandler)(UIView *view, BOOL finished);

@interface UIView (MLTAnimation)

/**
 *  视图动态转化为全屏
 *
 *  @param duration   动画执行时间
 *  @param completion 动画执行完毕回调
 */
- (void)mlt_animationToFullScreenWithDuration:(NSTimeInterval)duration completion:(UIViewAnimationCompletionHandler)completion;

/**
 *  视图动态转化为指定frame
 *
 *  @param frame      目标frame
 *  @param duration   动画执行时间
 *  @param completion 动画执行完毕回调
 */
- (void)mlt_animationToFrame:(CGRect)frame withDuration:(NSTimeInterval)duration completion:(UIViewAnimationCompletionHandler)completion;

/**
 *  视图动态转化为指定frame
 *
 *  @param frame             目标 frame
 *  @param alpha             目标透明度
 *  @param duration          动画执行时间
 *  @param options           动画执行选项
 *  @param completionHandler 动画执行完毕回调
 */
- (void)mlt_animationToFrame:(CGRect)frame alpha:(CGFloat)alpha withDuration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(UIViewAnimationCompletionHandler)completionHandler;

@end
