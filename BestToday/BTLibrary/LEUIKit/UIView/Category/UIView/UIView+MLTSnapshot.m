//
//  UIView+MLTSnapshot.m
//  AMCustomer
//
//  Created by fuyao on 16/9/1.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "UIView+MLTSnapshot.h"

@implementation UIView (MLTSnapshot)

- (UIImage *)mlt_snapshot {
    return [self mlt_snapshotAfterScreenUpdates:NO];
}

- (UIImage *)mlt_snapshotAfterScreenUpdates:(BOOL)afterUpdates {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterUpdates];
    } else {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}

- (UIImage *)mlt_convertToImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)mlt_snapshotImage {
    //字体比例至少半屏情况下，不模糊
    CGFloat scale = [UIScreen mainScreen].bounds.size.width / 2 / self.bounds.size.width;
    scale = MAX(scale, 1);
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, scale * [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer drawInContext:context];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshotImage;
}

- (UIImage *)mlt_shortcutImageWithRect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 1.0);
    [self drawViewHierarchyInRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) afterScreenUpdates:NO];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *resultImage = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(img.CGImage, rect)];
    return resultImage;
}

@end
