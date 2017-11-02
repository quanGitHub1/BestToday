//
//  MLTTabBarControllerProtocal.h
//  AMCustomer
//
//  Created by fuyao on 16/9/8.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

/**
 *  控制器根据自身需求实现该协议
 */

#import <Foundation/Foundation.h>

@protocol MLTTabBarControllerProtocol <NSObject>

@optional
/**
 *  当 viewcontroller 被选中时调用，必须是切换的情况下
 */
- (void)didSelectedInTabBarController;

/**
 *  是否能选中
 *
 *  @return
 */
- (BOOL)shoudSelectedInTabBarController;

/**
 *  点击时，当前 viewcontroller 已经是选中的情况下调用
 */
- (void)didSelectedInTabBarControllerWhenAppeared;


@end
