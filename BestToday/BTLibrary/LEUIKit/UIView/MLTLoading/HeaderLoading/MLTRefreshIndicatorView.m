//
//  MLTRefreshIndicatorView.m
//  MLTLoading
//
//  Created by jinzi on 16/10/14.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "MLTRefreshIndicatorView.h"

static const CGFloat kMLTRefreshHeaderIndicatorViewDefaultSize = 30.0f;

@interface MLTRefreshIndicatorView () {
    
    CAShapeLayer *_backLayer;
    CAShapeLayer *_frontLayer;
    CAShapeLayer *_animationContainerLayer;
    CAShapeLayer *_animationLayer;
}

@property (nonatomic) UIColor *tintBackColor;
@property (nonatomic) UIColor *tintFontColor;
@property (nonatomic) CGFloat size;

@end

@implementation MLTRefreshIndicatorView

- (id)initWithTintFontColor:(UIColor *)tintFrontColor tintBackColor:(UIColor *)tintBackColor size:(CGFloat)size {
    self = [super init];
    if (self) {
        
        _size = size;
        if (_size == 0) {
            
            _size = kMLTRefreshHeaderIndicatorViewDefaultSize;
        }
        self.frame = CGRectMake(0, 0, _size, _size);
        
        _tintFontColor = tintFrontColor;
        if (!_tintFontColor) {
            
            _tintFontColor = HEX(@"cea351");
        }
        
        _tintBackColor = tintBackColor;
        if (!_tintBackColor) {
            
            _tintBackColor = HEX(@"efe1c7");
        }
        
        [self setupLayer];
    }
    return self;
}

#pragma mark - private methods

- (void)setupLayer {
    
    double rectSize = _size / sqrt(2.f);
    _backLayer = [CAShapeLayer layer];
    UIBezierPath *rectBackPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, rectSize, rectSize) cornerRadius:_size / 10.f];
    _backLayer.path = rectBackPath.CGPath;
    _backLayer.strokeColor = _tintBackColor.CGColor;
    _backLayer.fillColor = [[UIColor whiteColor] CGColor];
    _backLayer.strokeStart = 0;
    _backLayer.strokeEnd = 1;
    _backLayer.lineWidth = 2.0f;
    _backLayer.frame = CGRectMake(0, 0, rectSize, rectSize);
    _backLayer.position = CGPointMake(_size / 2.f, _size / 2.f);
    _backLayer.transform = CATransform3DMakeRotation(45 *M_PI / 180.0, 0, 0, 1);
    [self.layer addSublayer:_backLayer];
    
    _frontLayer = [CAShapeLayer layer];
    UIBezierPath *rectFrontPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, rectSize, rectSize) cornerRadius:rectSize / 10.f];
    _frontLayer.path = rectFrontPath.CGPath;
    _frontLayer.strokeColor = _tintFontColor.CGColor;
    _frontLayer.fillColor = [[UIColor whiteColor] CGColor];
    _frontLayer.strokeStart = 0;
    _frontLayer.strokeEnd = 0;
    _frontLayer.lineWidth = 2.0f;
    _frontLayer.frame = CGRectMake(0, 0, rectSize, rectSize);
    _frontLayer.position = CGPointMake(rectSize / 2.f, rectSize / 2.f);
    [_backLayer addSublayer:_frontLayer];
    
    _animationContainerLayer = [CAShapeLayer layer];
    UIBezierPath *rectAnimationContainerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, rectSize, rectSize) cornerRadius:rectSize / 10.f];
    _animationContainerLayer.path = rectAnimationContainerPath.CGPath;
    _animationContainerLayer.fillColor = [[UIColor whiteColor] CGColor];
    _animationContainerLayer.frame = CGRectMake(0, 0, rectSize, rectSize);
    _animationContainerLayer.position = CGPointMake(_size / 2.f, _size / 2.f);
    _animationContainerLayer.transform = CATransform3DMakeRotation(45 *M_PI / 180.0, 0, 0, 1);
    [self.layer addSublayer:_animationContainerLayer];
    
    _animationLayer = [CAShapeLayer layer];
    UIBezierPath *rectAnimationPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, rectSize, rectSize) cornerRadius:rectSize / 10.f];
    _animationLayer.path = rectAnimationPath.CGPath;
    _animationLayer.strokeColor = _tintFontColor.CGColor;
    _animationLayer.fillColor = [[UIColor whiteColor] CGColor];
    _animationLayer.strokeStart = 0;
    _animationLayer.strokeEnd = 1;
    _animationLayer.lineWidth = 1.0f;
    _animationLayer.frame = CGRectMake(0, 0, rectSize, rectSize);
    _animationLayer.position = CGPointMake(rectSize / 2.f, rectSize / 2.f);
    _animationLayer.hidden = YES;
    [_animationContainerLayer addSublayer:_animationLayer];
    
}

- (void)startAnimating {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.repeatCount = HUGE;
    animation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
    animation.toValue = [NSNumber numberWithFloat:2 * M_PI]; // 终止角度
    animation.duration = 1.0;
    [_animationLayer addAnimation:animation forKey:@"Rotation"];
    
    _animationLayer.hidden = NO;
    _backLayer.hidden = YES;
}

- (void)stopAnimating {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        _animationLayer.hidden = YES;
        _backLayer.hidden = NO;
        [self setProgress:0];
        
        [_animationContainerLayer removeAllAnimations];
    });
}

#pragma mark - setter

- (void)setProgress:(CGFloat)progress {
    
    _frontLayer.strokeEnd = progress;
}

@end
