//
//  LEViewController.h
//  LEFinanceNewsIphone
//
//  Created by wangfaquan on 17/5/9.
//  Copyright © 2017年 wangfaquan. All rights reserved.
//

#import "BTViewController.h"
#import "MLTTabBarController.h"
#import "UIView+MLTBrokenNetwork.h"
#import "MGJNavigationBar.h"

@interface BTViewController : UIViewController <MLTViewControllerProtocol>

/**
 *  导航栏
 */
@property (nonatomic) MGJNavigationBar *navigationBar;

/**
 当前vc是在tabbar显示，还是在navigation栈中显示，有些界面可能在好几个地方显示
 */
@property (nonatomic, readonly ) BOOL isShowInTabBar;

/**
 是否显示导航底部分割线，默认显示
 */
@property (nonatomic ) BOOL isShowNavSeparatorLine;

/**
 *  返回按钮点击
 */
- (void)backButtonTapped;

/**
 *  10.29  显示断网提示页
 *  默认铺满整个view除导航栏的位置 example: CGRectMake(0, self.navigationBar.height, self.view.width, self.view.height - self.navigationBar.height);
 */
- (void)showBrokenNetworkViewWithClickedHandler:(clickedHandler)handler;

/**
 *  10.27  显示断网提示页
 *  frame: 自定义位置
 */
- (void)showBrokenNetworkViewInFrame:(CGRect)frame clickHandler:(clickedHandler)handler;

@end
