//
//  MLTTabBarController.h
//  AMCustomer
//
//  Created by wangfaquan on 16/9/6.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

/**
 *  自定义TabBarController, 灵活实现各类效果
 */

#import <UIKit/UIKit.h>
#import "MLTTabBar.h"
#import "MLTTabBarItem.h"
#import "MLTViewControllerProtocol.h"
#import "MLTTabBarControllerProtocol.h"

extern CGFloat const MLTTabbarHeight;

#pragma mark - delegate

/**
 *  MLTTabBarControllerDelegate
 */
@protocol MLTTabBarControllerDelegate <NSObject>

@optional
/**
 *  是否能选中制定的 viewcontroller
 *
 *  @param tabBarController tabbarcontroller
 *  @param viewController   将要选中的 viewcontroller
 *  @param index            将要选中的 viewcontroller 在 tabbar 中的索引
 *
 */
- (BOOL)tabBarController:(MLTTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController atIndex:(NSInteger)index;

/**
 *  选中 tabbarcontroller 中某个 viewcontroller 时调用
 *
 *  @param tabBarController tabbarcontroller
 *  @param viewController   选中的 viewcontroller
 *  @param index            选中的 viewcontroller 在 tabbar 中的索引
 */
- (void)tabBarController:(MLTTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController atIndex:(NSInteger)index;

@end

#pragma mark - custom TabBarController

/**
 *  自定义的 TabBarController
 */
@interface MLTTabBarController : UIViewController <MLTTabBarDelegate, MLTViewControllerProtocol>

/**
 *  文字颜色
 */
@property (nonatomic, strong) UIColor *titleColor;

/**
 *  被选中时的文字颜色
 */
@property (nonatomic, strong) UIColor *selectedTitleColor;

/**
 *  tabbar
 */
@property(nonatomic, strong) MLTTabBar *mltTabBar;

/**
 *  tabbarcontroller 中的 viewcontroller
 */
@property(nonatomic, strong, readonly) NSArray *viewControllers;

/**
 *  当前选中的 viewcontroller
 */
@property(nonatomic, strong, readonly) UIViewController<MLTViewControllerProtocol> *selectedViewController;

/**
 *  当前选中的 index
 */
@property(nonatomic, assign, readonly) NSInteger selectIndex;

/**
 *  delegate
 */
@property(nonatomic, weak) id<MLTTabBarControllerDelegate> mltTabBarControllerDelegate;

/**
 *  初始化 tabbarcontroller
 *
 *  @param viewControllers tabbarcontroller 中的 viewcontroller
 *
 */
- (id)initWithViewControllers:(NSArray *)viewControllers;

/**
 *  初始化 tabbarcontroller
 *
 *  @param viewControllers tabbarcontroller 中的 viewcontroller
 *  @param selectedIndex 默认tabbar的选中index为哪个
 *
 */
- (id)initWithViewControllers:(NSArray *)viewControllers selectedIndex:(NSInteger)selectedIndex;


/**
 *  选中某个 tab
 *
 *  @param index 索引
 */
- (void)selectAtIndex:(NSInteger)index;

@end
