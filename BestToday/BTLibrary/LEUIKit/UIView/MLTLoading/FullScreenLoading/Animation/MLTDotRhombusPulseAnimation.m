//
//  MLTDot RhombusPulseAnimation.m
//  MLTLoading
//
//  Created by jinzi on 16/10/13.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "MLTDotRhombusPulseAnimation.h"

@implementation MLTDotRhombusPulseAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    
    CGFloat beginTime = CACurrentMediaTime();
    CGFloat duration = 1.44;
    NSArray *timeOffsets = @[@0, @0.18, @0.36, @0.54, @0.72, @0.9, @1.08, @1.26];
    CAMediaTimingFunction *timingFunctionLinear = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    CGFloat circleSize = 8;
    CGFloat offsetX = 3;
    CGFloat itemWidth = layer.bounds.size.width/4;
    NSArray *xArray = @[@(itemWidth * 2),@(itemWidth * 3 + offsetX),@(itemWidth * 4),@(itemWidth * 3 + offsetX),@(itemWidth * 2),@(itemWidth - offsetX),@(0),@(itemWidth - offsetX)];
    NSArray *yArray = @[@(0),@(itemWidth - offsetX),@(itemWidth * 2),@(itemWidth * 3 + offsetX),@(itemWidth * 4),@(itemWidth * 3 + offsetX),@(itemWidth * 2),@(itemWidth - offsetX)];
    
    // Scale animation
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.keyTimes = @[@0.0f,@0.8f,@1.0f];
    scaleAnimation.values = @[@1.0f,@0.2f,@1.0f];
    scaleAnimation.duration = duration;
    // Animation
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    
    opacityAnimation.keyTimes = @[@0.0f,@0.8f,@1.0f];
    opacityAnimation.values = @[@1.0f,@0.4f,@1.0f];
    opacityAnimation.duration = duration;
    // Animation
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.duration = duration;
    animation.animations = @[scaleAnimation, opacityAnimation];
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    animation.timingFunction = timingFunctionLinear;
    
    // Draw circle
    for (int j = 0; j < xArray.count; j++) {
        CALayer *circle = [self createCirleWith:circleSize color:tintColor];
        CGFloat x = [xArray[j] floatValue];
        CGFloat y = [yArray[j] floatValue];
        circle.frame = CGRectMake(x, y, circleSize, circleSize);
        animation.beginTime = beginTime + [timeOffsets[j] floatValue];
        [circle addAnimation:animation forKey:@"animation"];
        [layer addSublayer:circle];
    }
}

- (CALayer *)createCirleWith:(CGFloat)size color:(UIColor *)color {
    
    CAShapeLayer *circle = [CAShapeLayer layer];
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size, size) cornerRadius:size / 2];
    
    circle.fillColor = color.CGColor;
    circle.path = circlePath.CGPath;
    
    return circle;
}

@end
