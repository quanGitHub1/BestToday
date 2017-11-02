//
//  MLTIndicatorView.h
//  MLTLoading
//
//  Created by jinzi on 16/10/13.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLTIndicatorView : UIView

- (id)initWithTintColor:(UIColor *)tintColor size:(CGFloat)size;

@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic) CGFloat size;

@property (nonatomic, readonly) BOOL animating;

- (void)startAnimating;

- (void)stopAnimating;

@end
