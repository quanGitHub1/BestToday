//
//  UIButton+MLTKit.h
//  AMCustomer
//
//  Created by fuyao on 16/9/5.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MLTKit)

/**
 *  根据图片生成button,
 *  状态:normoal, 大小:imageSize
 *
 *  @param imageName 图片名字
 *
 *  @return button
 */
+ (UIButton *)mlt_buttonWithImageNamed:(NSString *)imageName;

#pragma mark - Navigation Button

/**
 *  生成导航栏左侧按钮
 *
 *  @param image            image
 *  @param highlightedImage highlightedImage
 *  @param target           target
 *  @param action           action
 *  @param controlEvents    UIControlEvents
 *
 *  @return button
 */
+ (UIButton *)mlt_leftBarButtonWithImage:(UIImage*)image highlightedImage:(UIImage*)highlightedImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 *  生成导航栏右侧按钮
 *
 *  @param image            image
 *  @param highlightedImage highlightedImage
 *  @param target           target
 *  @param action           action
 *  @param controlEvents    UIControlEvents
 *
 *  @return button
 */
+ (UIButton *)mlt_rightBarButtonWithImage:(UIImage*)image highlightedImage:(UIImage*)highlightedImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

#pragma mark - Normal Button Adjust Image

/**
 *  生成按钮，大小为图片大小，如果大小不足 44 * 44 ，则补全到 44 * 44
 *
 *  @param image            image
 *  @param highlightedImage highlightedImage
 *  @param target           target
 *  @param action           action
 *  @param controlEvents    controlEvents
 *
 *  @return button
 */
+ (UIButton *)mlt_buttonWithImage:(UIImage*)image highlightedImage:(UIImage*)highlightedImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 *  生成按钮，大小为背景图片大小，如果大小不足 44 * 44 ，则补全到 44 * 44
 *
 *  @param image            image
 *  @param highlightedImage highlightedImage
 *  @param target           target
 *  @param action           action
 *  @param controlEvents    controlEvents
 *
 *  @return button
 */
+ (UIButton *)mlt_buttonWithBackgroundImage:(UIImage*)image highlightedImage:(UIImage*)highlightedImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 *  生成按钮 先根据 backgroundImage 确定大小，没有的时候根据 image 确定大小。如果大小不足 44 * 44 ，则补全到 44 * 44
 *
 *  @param title                      标题
 *  @param image                      image
 *  @param highlightedImage           highlightedImage
 *  @param backgroundImage            backgroundImage
 *  @param highlightedBackgroundImage highlightedBackgroundImage
 *  @param target                     target
 *  @param action                     action
 *  @param controlEvents              controlEvents
 *
 *  @return button
 */
+ (UIButton *)mlt_buttonWithTitle:(NSString *)title image:(UIImage*)image highlightedImage:(UIImage*)highlightedImage backgroundImage:(UIImage *)backgroundImage highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

#pragma mark - Normal Button Adjust Title/Image Edge

/**
 *  创建 button, 宽度根据 title 设置, 高度为图片高度
 *
 *  @param title            文字
 *  @param image            图片
 *  @param highlightedImage 高亮图片
 *  @param target           响应者
 *  @param action           响应事件
 *  @param controlEvents    响应选项
 *
 *  @return button
 */
+ (UIButton *)mlt_buttonWithTitle:(NSString *)title image:(UIImage*)image highlightedImage:(UIImage*)highlightedImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 *  根据图片和文字创建 button, 设置边距
 *
 *  @param image           图片名字
 *  @param imageEdgeInsets 图片内边距
 *  @param title           文字
 *  @param titleEdgeInsets 文字内边距
 *  @param font            字体
 *  @param target          响应者
 *  @param action          响应事件
 *  @param frame           frame
 *
 *  @return button
 */
+ (UIButton *)mlt_buttonWithImage:(NSString *)image imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets title:(NSString *)title titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets font:(UIFont *)font target:(id)target action:(SEL)action frame:(CGRect)frame;

@end
