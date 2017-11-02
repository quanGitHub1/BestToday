//
//  MLTIndicatorView.m
//  MLTLoading
//
//  Created by jinzi on 16/10/13.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "MLTIndicatorView.h"
#import "MLTDotRhombusPulseAnimation.h"

static const CGFloat kMLTIndicatorDefaultSize = 30.0f;

@implementation MLTIndicatorView

- (id)initWithTintColor:(UIColor *)tintColor size:(CGFloat)size {
    self = [super init];
    if (self) {
        
        _size = size;
        if (_size == 0) {
            
            _size = kMLTIndicatorDefaultSize;
        }
        
        _tintColor = tintColor;
        if (!_tintColor) {
            
//            _tintColor = HEX(@"c09034");
            _tintColor = HEX(@"c09034");
        }
    }
    return self;
}

#pragma mark - private methods

- (void)setupAnimation {
    
    self.layer.sublayers = nil;
    
    MLTDotRhombusPulseAnimation *animation = [MLTDotRhombusPulseAnimation new];
    [animation setupAnimationInLayer:self.layer withSize:CGSizeMake(_size, _size) tintColor:_tintColor];
    self.layer.speed = 0.0f;
}

- (void)startAnimating {
    
    if (!self.layer.sublayers) {
        
        [self setupAnimation];
    }
    self.layer.speed = 1.0f;
    _animating = YES;
}

- (void)stopAnimating {
    
    self.layer.speed = 0.0f;
    _animating = NO;
}

#pragma mark - setter


- (void)setSize:(CGFloat)size {
    
    if (_size != size) {
        
        _size = size;
        [self setupAnimation];
    }
}

- (void)setTintColor:(UIColor *)tintColor {
    
    if (![_tintColor isEqual:tintColor]) {
        
        _tintColor = tintColor;
        for (CALayer *sublayer in self.layer.sublayers) {
            
            sublayer.backgroundColor = tintColor.CGColor;
        }
    }
}


@end
