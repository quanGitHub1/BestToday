//
//  MLTNormalBadgeView.h
//  AMCustomer
//
//  Created by fuyao on 16/9/6.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

/**
 *  显示数字型badgeView
 */

#import <UIKit/UIKit.h>
#import "MLTBadgeView.h"

@interface MLTNormalBadgeView : MLTBadgeView

/**
 *  创建一个数字样式的 badgeview，大小已经固定
 *
 *  @param backgroundColor 背景色
 *  @param fontColor       字体颜色
 *
 *  @return badgeview
 */
- (id)initWithBackgroundColor:(UIColor *)backgroundColor fontColor:(UIColor *)fontColor;


@end
