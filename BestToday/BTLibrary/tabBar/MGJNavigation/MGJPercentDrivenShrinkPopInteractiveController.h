//
//  MGJPercentDrivenShrinkPopInteractiveController.h
//  Pods
//
//  Created by Snow on 2016/11/9.
//
//

#import <UIKit/UIKit.h>

@protocol MGJPercentDrivenShrinkPopInteractiveControllerProtocol <NSObject>


/**
 是否响应滑动响应进度的手势

 @param gestureRecognizer 滑动控制进度
 @return 是否响应BOOL
 */
- (BOOL)shrinkPopPanGestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;

@end

@interface MGJPercentDrivenShrinkPopInteractiveController : UIPercentDrivenInteractiveTransition

/** 交互控制手势 */
@property (nonatomic, readonly, strong) UIPanGestureRecognizer *shrinkPopPanRecognizer;
/** 交互决定的ViewController */
@property (nonatomic, weak) UIViewController *popViewController;

/** 事件回调代理 */
@property (nonatomic, weak) id<MGJPercentDrivenShrinkPopInteractiveControllerProtocol> delegate;


/**
 初始化方法

 @param interactionView 需要添加交互控制手势的View
 @return 实例
 */
- (instancetype)initWithInteractionView:(UIView *)interactionView;

@end
