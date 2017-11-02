//
//  MGJNavigationControllerPushZoomInAnimation.h
//  Pods
//
//  Created by 李杰 on 2016/11/2.
//
//

#import <Foundation/Foundation.h>
#import "MGJNavigationControllerZoomInAnimationProtocol.h"
#import <UIKit/UIKit.h>
@interface MGJNavigationControllerPushZoomInAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) UIView *fromView;
@property (nonatomic, strong) UIImage *animationImage;
@property (nonatomic, copy) NSArray<UIView *> *fromViews;
@property (nonatomic, copy) NSArray<UIView *> *toViews;
@property (nonatomic, assign) CGRect finalFrame;
@end
