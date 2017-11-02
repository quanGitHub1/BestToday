//
//  MGJNavigationControllerPushZoomInAnimation.m
//  Pods
//
//  Created by 李杰 on 2016/11/2.
//
//

#import "MGJNavigationControllerPushZoomInAnimation.h"

@interface MGJNavigationControllerPushZoomInAnimation ()

@end

@implementation MGJNavigationControllerPushZoomInAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}

- (void)animationEnded:(BOOL)transitionCompleted {
    
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIViewController <MGJNavigationZoomInAnimationFromVCProtocol> *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController <MGJNavigationZoomInAnimationToVCProtocol> *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //如果fromVC toVC 是MGJTabBarController,取出当前的VC
    if ([fromVC isKindOfClass:NSClassFromString(@"MGJTabBarController")]) {
        fromVC = [fromVC performSelector:@selector(selectedViewController)];
    }
    if ([toVC isKindOfClass:NSClassFromString(@"MGJTabBarController")]) {
        toVC = [toVC performSelector:@selector(selectedViewController)];
    }
    
    if ([fromVC respondsToSelector:@selector(fromViewOfZoomInAnimation)]) {
        self.fromView = [fromVC fromViewOfZoomInAnimation];
    }
    if ([fromVC respondsToSelector:@selector(animationImageOfZoomInAnimation)]) {
        self.animationImage = [fromVC animationImageOfZoomInAnimation];
    }
    if ([fromVC respondsToSelector:@selector(fromViewsOfZoomInAnimation)]) {
        self.fromViews = [fromVC fromViewsOfZoomInAnimation];
    }
    
    UIImageView *mainView = [[UIImageView alloc] initWithImage:self.animationImage];
    mainView.frame = [containerView convertRect:self.fromView.frame fromView:self.fromView.superview];
    mainView.contentMode = UIViewContentModeScaleAspectFill;
    mainView.clipsToBounds = YES;
    mainView.backgroundColor = [UIColor colorWithRed:239.f/255.f green:239.f/255.f blue:239.f/255.f alpha:1];
    self.fromView.hidden = YES;
    
    if ([toVC respondsToSelector:@selector(toViewsOfZoomInAnimation)]) {
        self.toViews = [toVC toViewsOfZoomInAnimation];
    }
    if ([toVC respondsToSelector:@selector(toAnimationFrameOfZoomInAnimation)]) {
        self.finalFrame = [toVC toAnimationFrameOfZoomInAnimation];
    }
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0.f;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:mainView];
    [self.fromViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = [containerView convertRect:obj.frame fromView:obj.superview];
        obj.alpha = 1.f;
        [containerView addSubview:obj];
    }];
    [self.toViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = [containerView convertRect:obj.frame fromView:obj.superview];
        obj.alpha = 0.f;
        [containerView addSubview:obj];
    }];
    
    if ([fromVC respondsToSelector:@selector(fromAnimationBegin)]) {
        [fromVC fromAnimationBegin];
    }
    if ([toVC respondsToSelector:@selector(toAnimationBegin)]) {
        [toVC toAnimationBegin];
    }
    
    [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionCurveEaseIn animations:^{
        [containerView layoutIfNeeded];
        fromVC.view.alpha = 0.f;
        toVC.view.alpha = 1.0;
        mainView.frame = self.finalFrame;
        
        [self.fromViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.alpha = 0.f;
        }];
        [self.toViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.alpha = 1.f;
        }];
    } completion:^(BOOL finished) {
        self.fromView.hidden = NO;
        fromVC.view.alpha = 1.0;
        if ([fromVC respondsToSelector:@selector(fromAnimationMoveEnded)]) {
            [fromVC fromAnimationMoveEnded];
        }
        if ([toVC respondsToSelector:@selector(toAnimationMoveEnded)]) {
            [toVC toAnimationMoveEnded];
        }
        [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
            mainView.alpha = 0;
        } completion:^(BOOL finished) {
            [mainView removeFromSuperview];
            [self.fromViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.alpha = 1.0;
            }];
            //通知VC动画结束
            if ([fromVC respondsToSelector:@selector(fromAnimationEnded)]) {
                [fromVC fromAnimationEnded];
            }
            if ([toVC respondsToSelector:@selector(toAnimationEnded)]) {
                [toVC toAnimationEnded];
            }
            //告诉系统动画结束
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }];
}

+ (UIImage *) imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0f);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshotImage;
}

@end
