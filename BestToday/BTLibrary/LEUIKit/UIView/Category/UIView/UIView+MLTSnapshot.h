//
//  UIView+MLTSnapshot.h
//  AMCustomer
//
//  Created by fuyao on 16/9/1.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

/**
 *  截图相关
 */

#import <UIKit/UIKit.h>

@interface UIView (MLTSnapshot)

/**
 *  截取一个矩形范围内的图片
 */
- (UIImage *)mlt_shortcutImageWithRect:(CGRect)rect;

// 下面四种实现原理类似,均为截取视图,把视图转化为图片

- (UIImage *)mlt_snapshot;

- (UIImage *)mlt_snapshotAfterScreenUpdates:(BOOL)afterUpdates;

/**
 *  简单把视图转化为图片
 */
- (UIImage *)mlt_convertToImage;

/**
 *  文字比例若超过半屏,使用下面该方法,得到的图片不模糊
 */
- (UIImage *)mlt_snapshotImage;

@end
