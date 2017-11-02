//
//  MGJPercentDrivenShrinkPopInteractiveController.m
//  Pods
//
//  Created by Snow on 2016/11/9.
//
//

#import "MGJPercentDrivenShrinkPopInteractiveController.h"
#import "MGJNavigationController.h"

@interface MGJPercentDrivenShrinkPopInteractiveController () <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIView *interactionView;

@property (nonatomic, weak) UIView *currentWindow;

@property (nonatomic, assign) PageTransitionAnimation *originalAnimationType;

@end

@implementation MGJPercentDrivenShrinkPopInteractiveController

- (instancetype)initWithInteractionView:(UIView *)interactionView
{
    self = [super init];
    if (self) {
        self.interactionView = interactionView;
        [self setupSelf];
    }
    return self;
}

- (void)setupSelf
{
    _currentWindow = [[MGJNavigationController currentNavigationController].view window];
    
    _shrinkPopPanRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleEdgePanGesture:)];
    _shrinkPopPanRecognizer.delegate = self;
    if (_interactionView) {
        [_interactionView addGestureRecognizer:_shrinkPopPanRecognizer];
    }
}

- (void)setPopViewController:(UIViewController *)popViewController
{
    _originalAnimationType = popViewController.animation;
    if (popViewController && [popViewController isKindOfClass:[UIViewController class]]) {
        _popViewController = popViewController;
        UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer = [self screenEdgePanGestureRecognizer];
        if (screenEdgePanGestureRecognizer) {
            [_shrinkPopPanRecognizer requireGestureRecognizerToFail: screenEdgePanGestureRecognizer];
        }
    }
}

- (UIScreenEdgePanGestureRecognizer *)screenEdgePanGestureRecognizer
{
    UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer = nil;
    if (self.popViewController.navigationController.view.gestureRecognizers.count > 0) {
        for (UIGestureRecognizer *recognizer in self.popViewController.navigationController.view.gestureRecognizers) {
            if ([recognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
                screenEdgePanGestureRecognizer = (UIScreenEdgePanGestureRecognizer *)recognizer;
                break;
            }
        }
    }
    return screenEdgePanGestureRecognizer;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(shrinkPopPanGestureRecognizerShouldBegin:)]) {
        return [self.delegate shrinkPopPanGestureRecognizerShouldBegin:gestureRecognizer];
    }else {
        return NO;
    }
}

- (void)handleEdgePanGesture:(UIPanGestureRecognizer *)pan
{
    CGPoint transPoint = [pan translationInView:_currentWindow];
    CGFloat interactiveTransitionScale = ABS(transPoint.y)/_currentWindow.frame.size.height;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            [[MGJNavigationController currentNavigationController] popViewControllerAnimated:YES];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (transPoint.y < 0) {
                return;
            }
            if (interactiveTransitionScale > 0.99) {
                interactiveTransitionScale = 0.99;
            }else if(interactiveTransitionScale < 0) {
                interactiveTransitionScale = 0;
            }
            [self updateInteractiveTransition:interactiveTransitionScale];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if (transPoint.y > 0 && interactiveTransitionScale > 0.4f) {
                [self.interactionView removeGestureRecognizer:_shrinkPopPanRecognizer];
                [self finishInteractiveTransition];
            }else {
                [self cancelInteractiveTransition];
                self.popViewController.animation = self.originalAnimationType;
            }
            break;
        }
        default:
            break;
    }
}

@end
