//
//  UIView+MLTAnimation.m
//  AMCustomer
//
//  Created by fuyao on 16/9/2.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "UIView+MLTAnimation.h"

@implementation UIView (MLTAnimation)

- (void)mlt_animationToFullScreenWithDuration:(NSTimeInterval)duration completion:(UIViewAnimationCompletionHandler)completion {
    [self mlt_animationToFrame:[UIScreen mainScreen].bounds withDuration:duration completion:completion];
}

- (void)mlt_animationToFrame:(CGRect)frame withDuration:(NSTimeInterval)duration completion:(UIViewAnimationCompletionHandler)completion {
    [self mlt_animationToFrame:frame alpha:self.alpha withDuration:duration options:0 completion:completion];
}

- (void)mlt_animationToFrame:(CGRect)frame alpha:(CGFloat)alpha withDuration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(UIViewAnimationCompletionHandler)completionHandler {
    if (!(duration > 0) || alpha < 0.0f || alpha > 1.0f) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:duration delay:0.0 options:options animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.frame = frame;
        strongSelf.alpha = alpha;
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (completionHandler) {
            completionHandler(strongSelf, finished);
        }
    }];
}

@end
