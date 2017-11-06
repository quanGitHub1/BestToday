//
//  UIColor+MLTKit.h
//  AMCustomer
//
//  Created by fuyao on 16/9/5.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MLTKit)

/**
 *  根据 hex 字符串创建颜色
 */
+ (UIColor *)mlt_colorWithHexString:(NSString *)hexString;

/**
 *  根据 hex 字符串创建颜色
 */
+ (UIColor *)mlt_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

/**
 *  根据 hex 创建颜色
 */
+ (UIColor *)mlt_colorWithHex:(int)hex alpha:(CGFloat)alpha;

/**
 *  随机色(一般用于调试)
 */
+ (UIColor *)mlt_randomColor;

@end
