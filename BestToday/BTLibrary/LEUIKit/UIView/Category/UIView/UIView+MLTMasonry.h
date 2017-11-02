//
//  UIView+MLTMasonry.h
//  AMCustomer
//
//  Created by fuyao on 16/9/1.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface UIView (MLTMasonry)

/**
 *  水平布局等宽视图
 *
 *  @param views 视图数组
 */
- (void)mlt_distributeSpacingHorizontallyWith:(NSArray *)views;

/**
 *  垂直布局等宽视图
 *
 *  @param views 视图数组
 */
- (void)mlt_distributeSpacingVerticallyWith:(NSArray *)views;

@end
