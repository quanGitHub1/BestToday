//
//  UIButton+MLTKit.m
//  AMCustomer
//
//  Created by fuyao on 16/9/5.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "UIButton+MLTKit.h"
//#import "MLTUIMacros.h"

@implementation UIButton (MLTKit)

+ (UIButton *)mlt_buttonWithImageNamed:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *btn;
    
    if (image != nil) {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = (CGRect){CGPointZero,image.size};
        [btn setImage:image forState:UIControlStateNormal];
    }
    return btn;
}

#pragma mark - Navigation Button

+ (UIButton *)mlt_leftBarButtonWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [barButton setTitleColor:RGB(66, 66, 66) forState:UIControlStateNormal];
    barButton.titleLabel.font = FONT(16.f);
    barButton.frame = CGRectMake(0.0f, 0.0f, 44, 44);
    barButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [barButton setImage:image forState:UIControlStateNormal];
    [barButton setImage:highlightedImage forState:UIControlStateHighlighted];
    [barButton addTarget:target action:action forControlEvents:controlEvents];
    [barButton setExclusiveTouch:YES];
    return barButton;
}

+ (UIButton *)mlt_rightBarButtonWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [barButton setTitleColor:RGB(66, 66, 66) forState:UIControlStateNormal];
    barButton.titleLabel.font = FONT(16.f);
    barButton.frame = CGRectMake(0.0f, 0.0f, 44, 44);
    barButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [barButton setImage:image forState:UIControlStateNormal];
    [barButton setImage:highlightedImage forState:UIControlStateHighlighted];
    [barButton addTarget:target action:action forControlEvents:controlEvents];
    [barButton setExclusiveTouch:YES];
    return barButton;
}

#pragma mark - Normal Button Adjust Image

+ (UIButton *)mlt_buttonWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
   return [self mlt_buttonWithTitle:nil image:image highlightedImage:highlightedImage backgroundImage:nil highlightedBackgroundImage:nil target:target action:action forControlEvents:controlEvents];
}

+ (UIButton *)mlt_buttonWithBackgroundImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    return [self mlt_buttonWithTitle:nil image:nil highlightedImage:nil backgroundImage:image highlightedBackgroundImage:highlightedImage target:target action:action forControlEvents:controlEvents];
}

//终极方法
+ (UIButton *)mlt_buttonWithTitle:(NSString *)title image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage backgroundImage:(UIImage *)backgroundImage highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size = CGSizeZero;
    if (backgroundImage) {
        size = backgroundImage.size;
    }else {
        size = image.size;
    }
    
    button.frame = CGRectMake(0.0f, 0.0f, size.width > 44.0f ? size.width : 44.0f, size.height > 44.0f ? size.height : 44.0f);
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:controlEvents];
    [button setExclusiveTouch:YES];
    return button;
}

#pragma mark - Normal Button Adjust Title/Image Edge

+ (UIButton *)mlt_buttonWithTitle:(NSString *)title image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIFont *titleFont = [UIFont boldSystemFontOfSize:14.0f];
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName : titleFont}];
    
    button.frame = CGRectMake(0.0f, 0.0f, titleSize.width + 24, image.size.height +20);
    button.titleLabel.font = titleFont;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:RGB(241.0f, 122.0f, 167.0f) forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:controlEvents];
    [button setExclusiveTouch:YES];
    return button;
}

+ (UIButton *)mlt_buttonWithImage:(NSString *)image imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets title:(NSString *)title titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets font:(UIFont *)font target:(id)target action:(SEL)action frame:(CGRect)frame {
    
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.backgroundColor = [UIColor clearColor];
    
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    button.imageEdgeInsets = imageEdgeInsets;
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = font;
    button.titleEdgeInsets = titleEdgeInsets;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setExclusiveTouch:YES];
    return button;
}

@end
