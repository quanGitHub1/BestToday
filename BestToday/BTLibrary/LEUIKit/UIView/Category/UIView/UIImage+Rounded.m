//
//  UIImage+Rounded.m
//  Finance
//
//  Created by 周洪静 on 2017/4/17.
//  Copyright © 2017年 luluzhi. All rights reserved.
//

#import "UIImage+Rounded.h"

@implementation UIImage (Rounded)


+ (UIImage*)image:(UIImage*)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);//size为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}
- (UIImage *)circleImage

{
    
    // NO代表透明
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 获得上下文
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    
    CGContextClip(ctx);
    
    // 将图片画上去
    
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    
    UIGraphicsEndImageContext();
    
    return image;
    
}


- (UIImage *)imageWithRoundingCorners:(UIRectCorner)rectCornerType
                         cornerRadius:(CGFloat)cornerRadius
                                 size:(CGSize)size {
    CGFloat scale = [UIScreen mainScreen].scale;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    
    CGRect bounds = CGRectMake(0, 0, size.width, size.height);
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:rectCornerType cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    [path addClip];
    
    
    [self drawInRect:bounds];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
