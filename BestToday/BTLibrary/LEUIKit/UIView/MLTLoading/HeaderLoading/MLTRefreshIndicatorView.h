//
//  MLTRefreshIndicatorView.h
//  MLTLoading
//
//  Created by jinzi on 16/10/14.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLTRefreshIndicatorView : UIView

- (id)initWithTintFontColor:(UIColor *)tintFrontColor tintBackColor:(UIColor *)tintBackColor size:(CGFloat)size;

@property (nonatomic) CGFloat progress;

- (void)startAnimating;

- (void)stopAnimating;

@end
