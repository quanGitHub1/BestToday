//
//  MLTLoadingView.m
//  AMCustomer
//
//  Created by aimei on 16/9/5.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "MLTLoadingView.h"
#import "MLTIndicatorView.h"

#define kImageViewWidth 72/2.f
#define kImageViewHeight 72/2.f

@interface MLTGirlLoadingView : UIView
@property (nonatomic, strong) MLTIndicatorView *indicatorView;

@end

@implementation MLTGirlLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _indicatorView = [[MLTIndicatorView alloc] initWithTintColor:nil size:0];
        _indicatorView.frame = CGRectMake(0, 0, kImageViewWidth, kImageViewHeight);
        _indicatorView.center = self.center;
        [self addSubview:_indicatorView];
    }
    return self;
}

- (void)startRefreshAnimating
{
    
    [_indicatorView startAnimating];
}

- (void)stopRefreshAnimating
{
    
    [_indicatorView stopAnimating];
}


@end

@implementation MLTLoadingView
{
    MLTGirlLoadingView *_circleView;
}

#pragma mark - Public

+ (MLTLoadingView *)showInView:(UIView *)view animated:(BOOL)animated {
    return [self showInView:view animated:animated backgoundColor:nil];
}

+ (MLTLoadingView *)showInView:(UIView *)view animated:(BOOL)animated backgoundColor:(UIColor *)color {
    MLTLoadingView *loadingView = nil;
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[self class]]) {
            loadingView = (MLTLoadingView *)subview;
            break;
        }
    }
    
    if (!loadingView) {
        loadingView = [[MLTLoadingView alloc] initWithView:view];
        loadingView.alpha = 0.0f;
        [view addSubview:loadingView];
        [loadingView show:animated color:color];
    }
    
    return loadingView;
}

+ (BOOL)hideActivityIndicatorForView:(UIView *)view animated:(BOOL)animated {
    
    MLTLoadingView *loadingView = [MLTLoadingView findLoadingViewForView:view];
    if (loadingView != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [loadingView hide:animated];
        });
        return YES;
    }
    return NO;
}

#pragma mark - Private

+ (MLTLoadingView *)findLoadingViewForView:(UIView *)view
{
    MLTLoadingView *loadingView = nil;
    NSArray *subviews = view.subviews;
    Class aiClass = [MLTLoadingView class];
    NSInteger count = 1;
    for (UIView *aView in subviews) {
        if ([aView isKindOfClass:aiClass]) {
            if (count > 1) {
                [aView removeFromSuperview];
            }
            else{
                loadingView = (MLTLoadingView *)aView;
            }
            count ++;
        }
    }
    return loadingView;
}

#pragma mark - Init

- (id)initWithView:(UIView *)view {
    NSAssert(view, @"View must not be nil.");
    MLTLoadingView *me = [self initWithFrame:CGRectMake(0, 0, view.width, view.height)];
    if ([view isKindOfClass:[UIWindow class]]) {
        
        //		[self setTransformForCurrentOrientation:NO];
    } else if ([view isKindOfClass:[UIScrollView class]]) {
        __weak UIScrollView *scrollView = (UIScrollView *)view;
        me.top = scrollView.contentOffset.y + scrollView.contentInset.top;
        scrollView.scrollEnabled = NO;
    }
    return me;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 创建动画视图
        _circleView = [[MLTGirlLoadingView alloc] initWithFrame:frame];
        _circleView.center = CGPointMake(self.width/2.0f, self.height/2.0f);
        
        [self addSubview:_circleView];
        
    }
    return self;
}

#pragma mark - show & hide method
- (void)show:(BOOL)animated color:(UIColor *)color {
    
    if (animated) {
        [_circleView startRefreshAnimating];
    }
    
    [UIView animateWithDuration:0.07f
                     animations:^{
                         self.alpha = 1.0f;
                         self.backgroundColor = color ? : [UIColor colorWithHexString:@"#202020" alpha:0.2];
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)hide:(BOOL)animated {
    
    if (animated) {
        [UIView animateWithDuration:0.07f
                         animations:^{
                             self.alpha = 0.0f;
                         } completion:^(BOOL finished) {
                             [_circleView stopRefreshAnimating];
                             if ([self.superview isKindOfClass:[UIScrollView class]]) {
                                 __weak UIScrollView *scrollView = (UIScrollView *)self.superview;
                                 scrollView.scrollEnabled = YES;
                             }
                             [self removeFromSuperview];
                         }];
    }else {
        [_circleView stopRefreshAnimating];
        [_circleView.layer removeAllAnimations];
        [self removeFromSuperview];
    }
}


@end
