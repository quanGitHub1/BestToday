//
//  MGJNavigationControllerPopShrinkOutAnimation.m
//  Pods
//
//  Created by Snow on 2016/11/3.
//
//

#import "MGJNavigationControllerPopShrinkOutAnimation.h"

@interface MGJNavigationControllerPopShrinkOutAnimation ()



@end

@implementation MGJNavigationControllerPopShrinkOutAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    UIViewController<MGJNavigationControllerShrinkOutAnimationFromVCProtocol> *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    
    // 动画开始之前调用
    if ([fromVC respondsToSelector:@selector(fromAnimationBeginOfShrinkOutAnimation)]) {
        [fromVC fromAnimationBeginOfShrinkOutAnimation];
    }
    
    // 获得需要变淡的View
    NSArray<UIView *> *fadeViews = nil;
    if ([fromVC respondsToSelector:@selector(fadeViewsOfShrinkOutAnimation)]) {
        fadeViews = [[fromVC fadeViewsOfShrinkOutAnimation] copy];
    }
    
    // 获得缩放比例 如果取不到的默认大小
    CGFloat viewScale = 0.4f;
    if ([fromVC respondsToSelector:@selector(shrinkToScaleOfShrinkOutAnimation)]) {
        viewScale = [fromVC shrinkToScaleOfShrinkOutAnimation];
    }
    
    CGFloat fromViewWidth = fromVC.view.frame.size.width;
    CGFloat fromViewHeight = fromVC.view.frame.size.height;
    
    CGFloat toViewHeight = toVC.view.frame.size.height;
    
    // 获得缩放比例 如果取不到的默认大小
    CGFloat smallViewShowScale = fromViewWidth/fromViewHeight;
    if ([fromVC respondsToSelector:@selector(smallViewShowScaleOfShrinkOutAnimation)]) {
        smallViewShowScale = [fromVC smallViewShowScaleOfShrinkOutAnimation];
    }
    
    CGFloat fromEndTransformY = (fromViewHeight*(1 - viewScale*smallViewShowScale));
    
    fromVC.view.layer.anchorPoint = CGPointMake(1, 0);
    fromVC.view.layer.position = CGPointMake(fromViewWidth, 0);
    
    CGAffineTransform beginFromVCTransform = fromVC.view.transform;
    // 这里踩到一个坑 transfrom如果不合起来在复原的时候 会导致View的transfrom无法复原
    CGAffineTransform endFromVCTransform = CGAffineTransformTranslate(beginFromVCTransform, 0, fromEndTransformY);
    endFromVCTransform = CGAffineTransformScale(endFromVCTransform, viewScale, viewScale);
    
    [UIView animateWithDuration:1.0f animations:^{
        fromVC.view.transform = endFromVCTransform;
        for (UIView *fadeView in fadeViews) {
            fadeView.alpha = 0.0f;
        }
    } completion:^(BOOL finished) {
        // 告诉系统动画结束
        BOOL transitionWasCancelled = transitionContext.transitionWasCancelled;
        if (transitionWasCancelled) {
            fromVC.view.transform = beginFromVCTransform;
            // 动画取消
            if ([fromVC respondsToSelector:@selector(fromAnimationCancelledOfShrinkOutAnimation)]) {
                [fromVC fromAnimationCancelledOfShrinkOutAnimation];
            }
        }else {
            // 动画结束
            if ([fromVC respondsToSelector:@selector(fromAnimationEndedOfShrinkOutAnimation)]) {
                [fromVC fromAnimationEndedOfShrinkOutAnimation];
            }
        }
        [transitionContext completeTransition:!transitionWasCancelled];
    }];
}

- (void)animationEnded:(BOOL) transitionCompleted
{
    
}

@end
