//
//  MLTViewControllerProtocol.h
//  AMCustomer
//
//  Created by fuyao on 16/9/8.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

/**
 *  声明关于tabBar的属性,便于解耦.tabBar上的控制器必须实现该协议
 *  注意:需要在遵守该协议类中使用@synthesize合成setter/getter方法
 */

#import <Foundation/Foundation.h>

@class MLTTabBarItem;
@class MLTTabBarController;
@protocol MLTViewControllerProtocol <NSObject>

/**
 *  当前 ViewController 的 view 的 frame
 */
@property (nonatomic, assign) CGRect defaultFrame;

/**
 * 在 MLTTabBarController 中使用的 TabBarItem
 */
@property (nonatomic, strong) MLTTabBarItem *mltTabBarItem;

/**
 *  当前 viewcontroller 所在的 MLTTabBarController 的引用。如果为 nil，表示不在 MLTTabBarController 中。
 */
@property (nonatomic, weak) MLTTabBarController *mltTabBarController;

@end
