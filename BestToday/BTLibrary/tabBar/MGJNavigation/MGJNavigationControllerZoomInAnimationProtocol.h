//
//  MGJNavigationAnimationProtocol.h
//  Pods
//
//  Created by 李杰 on 2016/11/2.
//
//

#import <UIKit/UIKit.h>
/**
 转场 fromVC 需要实现的协议
 */
@protocol MGJNavigationZoomInAnimationFromVCProtocol <NSObject>
@required

/**
 fromVC 提供动画的图片
 
 @return image
 */
- (UIImage *)animationImageOfZoomInAnimation;

/**
 fromVC  提供动画的视图

 @return view
 */
- (UIView *)fromViewOfZoomInAnimation;
@optional
/**
 fromVC 提供盖在图上的view
 
 @return view 数组
 */
- (NSArray<UIView *>*)fromViewsOfZoomInAnimation;
/**
 通知fromVC转场动画开始
 */
- (void)fromAnimationBegin;

/**
 通知fromVC移动结束
 */
- (void)fromAnimationMoveEnded;
/**
 通知fromVC转场动画结束
 */
- (void)fromAnimationEnded;
@end



/**
 转场 toVC 需要实现的协议
 */
@protocol MGJNavigationZoomInAnimationToVCProtocol <NSObject>
@required

/**
 toVC 提供做动画的view
 
 @return view
 */
- (CGRect)toAnimationFrameOfZoomInAnimation;
@optional
/**
 toVC 提供盖在图上的view
 
 @return view 数组
 */
- (NSArray<UIView *>*)toViewsOfZoomInAnimation;

/**
 通知toVC转场动画开始
 */
- (void)toAnimationBegin;
/**
 通知toVC转场动画结束
 */
- (void)toAnimationEnded;

/**
 通知toVC移动到位了
 */
- (void)toAnimationMoveEnded;
@end
