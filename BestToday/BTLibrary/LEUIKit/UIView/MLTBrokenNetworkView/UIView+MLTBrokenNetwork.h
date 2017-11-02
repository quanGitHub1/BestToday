//
//  UIView+MLTBrokenNetwork.h
//  AMCustomer
//
//  Created by 恺撒 on 2016/10/28.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLTBrokenNetworkView.h"

/*
 *  10.28  添加断网提示view的方法
 */

@interface UIView (MLTBrokenNetwork)

/*
 * 默认铺满整个view
 */

- (void)showBrokenNetworkViewWithClickedHandler:(clickedHandler)handler;

/*
 * 自定义frame
 */

- (void)showBrokenNetworkViewInFrame:(CGRect)frame clickedHandler:(clickedHandler)handler;

@end
