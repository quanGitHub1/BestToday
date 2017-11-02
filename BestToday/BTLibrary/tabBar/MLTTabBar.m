//
//  MLTTabBar.m
//  AMCustomer
//
//  Created by wangfaquan on 16/9/6.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "MLTTabBar.h"
//#import "MLTMacros.h"
//#import "MLTUIMacros.h"
#import <UIKit/UIKit.h>

@interface MLTTabBar()
@property(nonatomic, assign) NSUInteger selectedIndex;
@property(nonatomic, strong) UIView *barPanel;
@property(nonatomic, strong) UIImageView *barPanelBackGroundView;
@property(nonatomic, strong) UIImage *barPanelBackGroundImage;
@property(nonatomic, strong) UIView *topLine;
@end

@implementation MLTTabBar

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id<MLTTabBarDelegate>)delegate {
    self = [self initWithFrame:frame items:items delegate:delegate selectedIndex:0];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id<MLTTabBarDelegate>)delegate selectedIndex:(NSUInteger)selectedIndex {
    self = [super initWithFrame:frame];
    if (self) {
        self.selectedIndex = selectedIndex;
        self.delegate = delegate;
        self.items = [items copy];
        [self shareInit];
    }
    return self;
}

- (void)shareInit
{
    /// bar panel
    self.barPanel = [[UIView alloc]initWithFrame:self.bounds];
    self.barPanel.backgroundColor = [UIColor clearColor];
    self.barPanel.userInteractionEnabled = YES;
    [self addSubview:self.barPanel];
    
    //描边
    self.topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1 / [UIScreen mainScreen].scale)];
    self.topLine.backgroundColor = RGB(197,197,197);
    [self.barPanel addSubview:self.topLine];
    [self.barPanel bringSubviewToFront:self.topLine];
    
    [self addItems];
//    self.ptpModuleName = @"_tabfoot";
    
    [self effectRefresh];
}

- (void)setBlurNeedOpen:(BOOL)blurNeedOpen
{
    _blurNeedOpen = blurNeedOpen;
    [self effectRefresh];
}

- (void)effectRefresh
{
    if (self.barPanelBackGroundView) {
        [self.barPanelBackGroundView removeFromSuperview];
        self.barPanelBackGroundView = nil;
    }
    
    if (_blurNeedOpen&&!self.barPanelBackGroundImage) {
        if (IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
            effectView.frame = self.bounds;
            effectView.tintColor = [UIColor whiteColor];
            self.barPanelBackGroundView = effectView;
            [self insertSubview:self.barPanelBackGroundView belowSubview:self.barPanel];
            return;
        }
    }
    
    self.barPanelBackGroundView = [[UIImageView alloc]initWithFrame:self.bounds];
    self.barPanelBackGroundView.contentMode = UIViewContentModeScaleToFill;
    self.barPanelBackGroundView.backgroundColor = [UIColor whiteColor];
    self.barPanelBackGroundView.image = self.barPanelBackGroundImage;
    [self insertSubview:self.barPanelBackGroundView belowSubview:self.barPanel];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    self.barPanelBackGroundImage = backgroundImage;
    [self effectRefresh];
}

- (void)selectItemAtIndex:(NSInteger)index
{
    if (index < self.items.count) {
        [self tabBarItemdidSelected:self.items[index]];
    }
}

- (void)setBadge:(NSInteger)badge atIndex:(NSInteger)index
{
    MLTTabBarItem *item = self.items[index];
    [item.badgeView setBadgeNum:badge];
}

#pragma -mark
#pragma -mark reload data

- (void)addItems
{
    NSUInteger barNum = self.items.count;
    
    CGFloat width = (self.width) / barNum;
    CGFloat xOffset = 0.0f;
    
    for (int i = 0; i < barNum; i++) {
        MLTTabBarItem *item = self.items[i];
        item.width = width;
        item.height = self.height;
        item.left = xOffset;
        item.delegate = self;
        if (i == self.selectedIndex) {
            item.selected = YES;
        }
        item.tag = -i;
        xOffset += width;
        
        [self.barPanel addSubview:item];
    }
}

#pragma -mark
#pragma -mark tabbar item delegate
- (void)tabBarItemdidSelected:(MLTTabBarItem *)item{
    
    NSUInteger index = -item.tag;
    
    if (index >= [self.items count]) {
        return;
    }
    
    if (self.selectedIndex != index) {
        
        BOOL shouldSelect = YES;
        if ([self.delegate respondsToSelector:@selector(tabBar:shouldSelectItemAtIndex:)]) {
            shouldSelect = [self.delegate tabBar:self shouldSelectItemAtIndex:index];
        }
        
        if (!shouldSelect) {
            return;
        }
        
        MLTTabBarItem* old = [self.items objectAtIndex:self.selectedIndex];
        if (old) {
            old.selected = NO;
        }
    }
    
    self.selectedIndex = index;
    item.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItemAtIndex:)]) {
        [self.delegate tabBar:self didSelectItemAtIndex:index];
    }
}

@end
