//
//  MLTTabBar.h
//  AMCustomer
//
//  Created by wangfaquan on 16/9/6.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

/**
 *  自定义TabBar
 */

#import <UIKit/UIKit.h>
#import "MLTTabBarItem.h"

/**
 *  MLTTabBarDelegate
 */
@class MLTTabBar;
@protocol MLTTabBarDelegate <NSObject>
@optional

/**
 *  选中了某个 item
 *
 *  @param tabBar tabbar
 *  @param index  索引
 */
- (void)tabBar:(MLTTabBar *)tabBar didSelectItemAtIndex:(NSUInteger)index;

/**
 *  是否能选中某个 item
 *
 *  @param tabBar tabbar
 *  @param index  索引
 *
 */
- (BOOL)tabBar:(MLTTabBar *)tabBar shouldSelectItemAtIndex:(NSUInteger)index;

@end


@interface MLTTabBar : UIView<MLTTabBarItemDelegate>

/**
 *  tabbardelegate
 */
@property (nonatomic, weak) id<MLTTabBarDelegate> delegate;

/**
 *  当前选中 item 的索引
 */
@property (nonatomic, assign, readonly) NSUInteger selectedIndex;

/**
 *   items
 */
@property(nonatomic, strong) NSMutableArray *items;

/**
 *  是否开启毛玻璃背景；
 *  注意即便开启 iOS8以下也无效;
 *  即便开启，如果调用MGJTabBar的setBackgroundImage方法（无关先后顺序），当image不为nil 此属性失效；反过来属性有效
 */
@property (nonatomic, assign) BOOL blurNeedOpen;

#pragma mark - Method

/**
 *  创建 tabbar
 *
 *  @param frame    frame
 *  @param items    items 数组
 *  @param delegate delegate
 *  @param selectedIndex 设置默认选中的tab为哪个
 *
 */
- (id)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id<MLTTabBarDelegate>)delegate selectedIndex:(NSUInteger)selectedIndex;

/**
 *  创建 tabbar
 *
 *  @param frame    frame
 *  @param items    items 数组
 *  @param delegate delegate
 *
 */
- (id)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id<MLTTabBarDelegate>)delegate;

/**
 *  设置背景
 *
 *  @param backgroundImage 背景图
 */
- (void)setBackgroundImage:(UIImage *)backgroundImage;


/**
 *  选中某个 item
 *
 *  @param index 索引
 */
- (void)selectItemAtIndex:(NSInteger)index;

/**
 *  设置指定 item 的 badge
 *
 *  @param badge badge 数字
 *  @param index item 索引
 */
- (void)setBadge:(NSInteger)badge atIndex:(NSInteger)index;

@end
