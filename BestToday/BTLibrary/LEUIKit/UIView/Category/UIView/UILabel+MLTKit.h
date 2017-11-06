//
//  UILabel+MLTKit.h
//  AMCustomer
//
//  Created by fuyao on 16/9/5.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (MLTKit)

/**
 *  通过各种属性创建label
 *
 *  @param text            文字
 *  @param color           文字颜色
 *  @param align           对齐方式
 *  @param font            字体大小
 *  @param backgroundColor 背景颜色
 *  @param frame           frame
 *
 *  @return label
 */
+ (UILabel *)mlt_labelWithText:(NSString *)text
                     color:(UIColor *)color
                     align:(NSTextAlignment)align
                      font:(UIFont *)font
                   bkColor:(UIColor *)backgroundColor
                     frame:(CGRect)frame;

/**
 *  设置label文字的属性
 *
 *  @param string    文字
 *  @param lineSpace 行间距
 *  @param color     文字颜色
 */
- (void)mlt_labelTextWithString:(NSString *)string LineSpace:(CGFloat)lineSpace textColor:(UIColor *)color;

/**
 *  设置label文字属性
 *
 *  @param string    文字
 *  @param lineSpace 行间距
 *  @param color     文字颜色
 *  @param range     文字颜色范围
 */
- (void)mlt_labelTextWithString:(NSString *)string LineSpace:(CGFloat)lineSpace textColor:(UIColor *)color colorRange:(NSRange)range;

#pragma mark - Frame

/**
 *  内建高度,请确保已经设置宽度
 */
- (CGFloat)mlt_flexibleHeight;

/**
 *  内建宽度,请确保已经设置高度
 */
- (CGFloat)mlt_flexibleWidth;

/**
 *  获取文本size,请确保label frame已经设置
 */
- (CGSize)mlt_contentSize;

/**
 *  根据宽度自适应 size
 *  算出的宽度<width, 则等于实际宽度
 *  算出的宽度>width, 则等于width
 *  @param width 宽度
 */
- (void)mlt_adjustSizeWithWidth:(CGFloat)width;

#pragma mark - Action

/**
 *  增加点击事件
 *
 *  @param target   事件处理者
 *  @param selector 响应事件
 */
- (void)mlt_addTarget:(id)target action:(SEL)selector;


#pragma mark -- 删除线 ---

/**
 添加删除线函数
 
 @param color  删除线颜色，默认黑色
 @param range  range
 @param height 线高度
 */
- (void)mlt_addStrikethroughWithColor:(UIColor *)color;
- (void)mlt_addStrikethroughWithColor:(UIColor *)color range:(NSRange )range;
- (void)mlt_addStrikethroughWithColor:(UIColor *)color range:(NSRange )range height:(CGFloat )height;

#pragma mark -- 下划线 ---

/**
 添加下划线

 @param color  颜色，默认黑色
 @param range  range
 @param height heigth
 */
- (void)mlt_addSUnderlineWithColor:(UIColor *)color;
- (void)mlt_addSUnderlineWithColor:(UIColor *)color range:(NSRange )range;
- (void)mlt_addSUnderlineWithColor:(UIColor *)color range:(NSRange )range style:(NSInteger )style;
- (void)mlt_addSUnderlineWithColor:(UIColor *)color range:(NSRange )range style:(NSInteger )style spacing:(CGFloat )spacing;

@end
