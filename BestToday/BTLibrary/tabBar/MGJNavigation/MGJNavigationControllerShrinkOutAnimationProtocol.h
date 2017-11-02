//
//  MGJNavigationControllerShrinkOutAnimationProtocol.h
//  Pods
//
//  Created by Snow on 2016/11/3.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MGJNavigationControllerShrinkOutAnimationFromVCProtocol <NSObject>

@required

/**
 fromVC 提供变到最小的View尺寸
 
 @return 最小时候的尺寸
 */
- (CGFloat)shrinkToScaleOfShrinkOutAnimation;

/**
 fromVC 提供变到最小的View需要漏出的比例
 
 @return 需要漏出的比例
 */
- (CGFloat)smallViewShowScaleOfShrinkOutAnimation;

/**
 fromVC 提供逐渐变淡的View
 
 @return View
 */
- (NSArray<UIView *> *)fadeViewsOfShrinkOutAnimation;

/**
 通知fromVC转场动画开始
 */
- (void)fromAnimationBeginOfShrinkOutAnimation;

/**
 通知fromVC转场动画终止
 */
- (void)fromAnimationCancelledOfShrinkOutAnimation;

/**
 通知fromVC转场动画结束
 */
- (void)fromAnimationEndedOfShrinkOutAnimation;

@end
