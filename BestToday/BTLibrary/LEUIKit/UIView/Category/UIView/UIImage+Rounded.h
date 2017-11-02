//
//  UIImage+Rounded.h
//  Finance
//
//  Created by 周洪静 on 2017/4/17.
//  Copyright © 2017年 luluzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Rounded)

/**
 缩放图片

 @param image image
 @param size 尺寸
 @return 图片
 */
+ (UIImage*)image:(UIImage*)image scaleToSize:(CGSize)size;
/**
 圆形图片

 @return image
 */
- (UIImage *)circleImage;




/**
 自定义圆角图片

 @param rectCornerType 圆角位置
 @param cornerRadius 角度
 @param size 大小
 @return image
 */
- (UIImage *)imageWithRoundingCorners:(UIRectCorner)rectCornerType
                         cornerRadius:(CGFloat)cornerRadius
                                 size:(CGSize)size;
@end
