//
//  MLTTabBarItem.h
//  AMCustomer
//
//  Created by wangfaquan on 16/9/6.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLTBadgeView.h"


@class MLTTabBarItem;
@protocol MLTTabBarItemDelegate <NSObject>

@optional
/**
 *  item 被选中时调用
 */
- (void)tabBarItemdidSelected:(MLTTabBarItem *)item;

@end

@interface MLTTabBarItem : UIControl

@property(nonatomic, weak) id<MLTTabBarItemDelegate> delegate;
@property(nonatomic, strong) MLTBadgeView *badgeView;
@property(nonatomic, assign) UIEdgeInsets imageInset;

/**
 *  初始化 tabbaritem
 *
 *  @param title              标题
 *  @param titleColor         标题颜色
 *  @param selectedTitleColor 选中的标题颜色
 *  @param icon               icon
 *  @param selectedIcon       选中的icon
 *
 */
- (id)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor icon:(UIImage *)icon selectedIcon:(UIImage *)selectedIcon;

/**
 *  设置 icon，默认 isExtended 为 NO
 *
 *  @param image icon 图片
 */
- (void)setIcon:(UIImage *)image;

/**
 *  根据 isExtended 设置 icon 图片以及是否有扩展效果
 *
 *  @param image        icon 图片
 */
- (void)setIcon:(UIImage *)image enableExtend:(BOOL)isExtended;

/**
 *  设置 selectIcon，默认 isExtended 为 NO
 *
 *  @param selectedIcon 选中的 icon 图片
 */
- (void)setSelectedIcon:(UIImage *)selectedIcon;

/**
 *  根据 isExtended 设置 selectIcon 图片以及是否有扩展效果
 *
 *  @param selectedIcon 选中的 icon 图片
 */
- (void)setSelectedIcon:(UIImage *)selectedIcon enableExtend:(BOOL)isExtended;

/**
 *  设置title
 *
 *  @param title 标题
 */
-(void)setTitle:(NSString*)title;

/**
 *  获取 title
 *
 */
- (NSString *)title;

/**
 *  设置 selectedTextColor
 *
 */
-(void)setSelectedTextColor:(UIColor *) selectedTitleColor;

/**
 * 设置 title 颜色
 **/
- (void)setTextColor:(UIColor*)textColor;

/**
 * 重新设置 tabbarItem
 **/
- (void)resetItemWithTitle:(NSString*)title
                     color:(UIColor*)color
             selectedColor:(UIColor*)selectedColor
                      icon:(UIImage*)icon
              selectedIcon:(UIImage*)selectedIcon;

@end
