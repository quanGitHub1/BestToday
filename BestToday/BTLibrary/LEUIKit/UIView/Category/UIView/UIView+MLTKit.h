//
//  UIView+MLTKit.h
//  AMCustomer
//
//  Created by fuyao on 16/9/1.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MLTKit)

#pragma mark -

/**
 *  获取视图所在控制器
 */
- (UIViewController *)mlt_viewController;

/**
 *  从xib加载视图, tableViewCell不建议使用!!!
 */
+ (instancetype)mlt_loadFromXib;

#pragma mark - Frame

/**
 * frame.origin.x = left
 */
@property (nonatomic, assign) CGFloat left;

/**
 * frame.origin.y = top
 */
@property (nonatomic, assign) CGFloat top;

/**
 * frame.origin.x = right - frame.size.width
 */
@property (nonatomic, assign) CGFloat right;

/**
 * frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic, assign) CGFloat bottom;

/**
 * frame.size.width = width
 */
@property (nonatomic, assign) CGFloat width;

/**
 * frame.size.height = height
 */
@property (nonatomic, assign) CGFloat height;

/**
 * center.x = centerX
 */
@property (nonatomic, assign) CGFloat centerX;

/**
 * center.y = centerY
 */
@property (nonatomic, assign) CGFloat centerY;

/**
 * frame.origin
 */
@property (nonatomic, assign) CGPoint origin;

/**
 * frame.size
 */
@property (nonatomic, assign) CGSize size;

#pragma mark - View Features

/**
 *  取消阴影
 */
- (void)mlt_hideShadow;

/**
 *  左右晃动
 */
- (void)mlt_makeMeShake;

/**
 *  设置阴影
 *
 *  @param color   阴影颜色
 *  @param offset  阴影偏移量
 *  @param radius  阴影半径
 *  @param opacity 阴影透明度
 */
- (void)mlt_addShadowWithColor:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity;

/**
 *  设置圆角和边框
 *
 *  @param radius 半径
 *  @param width  边框宽度
 *  @param color  边框颜色
 */
- (void)mlt_setCornerWithRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color;

/**
 *  设置边框
 *
 *  @param width  边框宽度
 *  @param color  边框颜色
 */
- (void)mlt_setBorderWidth:(CGFloat)width borderColor:(UIColor *)color;

/**
 * 设置圆角
 */
- (void)mlt_setCornerWithRadius:(CGFloat)radius;

/**
 * 设置默认的圆角,radius=2.0
 */
- (void)mlt_makeDefultRoundCorner;

/**
 * 设置圆形
 */
- (void)mlt_makeRound;

/**
 *  设置默认椭圆
 */
- (void)mlt_makeEllipse;

/**
 *  移除所有子控件
 */
- (void)mlt_removeAllSubviews;


/**
 tap 事件的辅助函数

 @param target  target description
 @param handler handler description

 @return return value description
 */
-(UITapGestureRecognizer *) mlt_whenTapWithTarget:(id )target handler:(SEL )handler;
//-(UITapGestureRecognizer *) whenTapWithTarget:(id )target handler:(SEL )handler;

@end
