//
//  UIColor+AM.h
//  AMCustomer
//
//  Created by wangxijin on 15/3/21.
//  Copyright (c) 2015年 capplay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(AMColor)

/**
*  使用16进制构造颜色。
*
*  @param hexString 16进制字符串，如“#ababab”
*  @param alpha     透明度
*/
+ (UIColor *) colorWithHexString: (NSString *)hexString
                           alpha:(float)alpha;

+ (UIColor *) colorWithHexString: (NSString *)hexString;

+ (UIColor *)randomColor;
@end