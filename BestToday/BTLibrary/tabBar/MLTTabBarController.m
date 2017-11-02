//
//  MLTTabBarController.m
//  AMCustomer
//
//  Created by wangfaquan on 16/9/6.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "MLTTabBarController.h"
#import "MLTTabBarManager.h"

CGFloat const MLTTabbarHeight = 49;

@interface MLTTabBarController ()
@property(nonatomic, strong) NSArray *viewControllers;
@property(nonatomic, strong) UIViewController<MLTViewControllerProtocol> *selectedViewController;
@property(nonatomic, assign) NSInteger selectIndex;
@end

@implementation MLTTabBarController
@synthesize defaultFrame = _defaultFrame;
@synthesize mltTabBarItem = _mltTabBarItem;
@synthesize mltTabBarController = _mltTabBarController;

- (id)initWithViewControllers:(NSArray *)viewControllers {
    self = [self initWithViewControllers:viewControllers selectedIndex:0];
    if (self) {
    }
    return self;
}

- (id)initWithViewControllers:(NSArray *)viewControllers selectedIndex:(NSInteger)selectedIndex {
    self = [super init];
    if (self) {
        
        self.selectIndex = selectedIndex;
        self.viewControllers = viewControllers;
        self.automaticallyAdjustsScrollViewInsets = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarFrameDidChanged) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *itemsArray = [NSMutableArray array];
    for (UIViewController<MLTViewControllerProtocol> *viewController in self.viewControllers) {
        [viewController setDefaultFrame:CGRectMake(0, 0, self.view.width, self.view.height - MLTTabbarHeight)];
        MLTTabBarItem *tabBarItem = viewController.mltTabBarItem;
        if (!tabBarItem) {
            tabBarItem = [[MLTTabBarItem alloc] initWithTitle:viewController.title titleColor:self.titleColor selectedTitleColor:self.selectedTitleColor icon:nil selectedIcon:nil];
            viewController.mltTabBarItem = tabBarItem;
        }
        [itemsArray addObject:tabBarItem];
        [self addChildViewController:viewController];
        viewController.mltTabBarController = self;
    }
    
    self.selectedViewController = self.viewControllers[self.selectIndex];
    [self.view addSubview:[self.viewControllers[self.selectIndex] view]];
    
    self.mltTabBar = [[MLTTabBar alloc] initWithFrame:CGRectMake(0, self.view.height - MLTTabbarHeight, self.view.width, MLTTabbarHeight) items:itemsArray delegate:self selectedIndex:self.selectIndex];
    [self.view addSubview:self.mltTabBar];
    
    [[MLTTabBarManager shareInstance] setTabBarController:self];
    
}

- (void)selectAtIndex:(NSInteger)index {
    if (index > self.viewControllers.count - 1) {
        return;
    }
    [self.mltTabBar selectItemAtIndex:index];
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.selectedViewController;
}

#pragma mark - MLTTabBarDelegate

- (BOOL)tabBar:(MLTTabBar *)tabBar shouldSelectItemAtIndex:(NSUInteger)index
{
    BOOL shouldSelect = YES;
    if ([self.mltTabBarControllerDelegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:atIndex:)]) {
        shouldSelect = [self.mltTabBarControllerDelegate tabBarController:self shouldSelectViewController:self.viewControllers[index] atIndex:index];
    }
    
    return shouldSelect;
}

- (void)tabBar:(MLTTabBar *)tabBar didSelectItemAtIndex:(NSUInteger)index
{
    if (self.selectIndex == index) {
        self.selectedViewController.view.frame = CGRectMake(0, 0, self.view.width, self.view.height - MLTTabbarHeight);
        if ([self.selectedViewController respondsToSelector:@selector(didSelectedInTabBarControllerWhenAppeared)])
        {
            [self.selectedViewController performSelector:@selector(didSelectedInTabBarControllerWhenAppeared) withObject:nil];
        }
    }
    else
    {
        [self.selectedViewController.view removeFromSuperview];
        
        self.selectIndex = index;
        self.selectedViewController = self.viewControllers[self.selectIndex];
        
        [self.view insertSubview:self.selectedViewController.view belowSubview:self.mltTabBar];
        
        if ([self.mltTabBarControllerDelegate respondsToSelector:@selector(tabBarController:didSelectViewController:atIndex:)]) {
            [self.mltTabBarControllerDelegate tabBarController:self didSelectViewController:self.selectedViewController atIndex:self.selectIndex];
        }
        
        if ([self.selectedViewController respondsToSelector:@selector(didSelectedInTabBarController)])
        {
            [self.selectedViewController performSelector:@selector(didSelectedInTabBarController) withObject:nil];
        }
        [self.selectedViewController setNeedsStatusBarAppearanceUpdate];
        
    }
}

- (void)statusBarFrameDidChanged
{
    self.mltTabBar.bottom = self.view.height - ([self.view convertPoint:CGPointMake(0, self.view.height) toView:nil].y - [UIApplication sharedApplication].keyWindow.size.height);
}

////#pragma mark - 系统
////竖屏
//-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskLandscapeRight;
//}
//
////是否自动旋转,返回YES可以自动旋转
//- (BOOL)shouldAutorotate {
//    return NO;
//}
//
////这个是返回优先方向
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
//}

#pragma mark - Synthsize Setter/Getter
- (void)setDefaultFrame:(CGRect)defaultFrame {
    _defaultFrame = defaultFrame;
}

- (void)setMltTabBarItem:(MLTTabBarItem *)mltTabBarItem {
    _mltTabBarItem = mltTabBarItem;
}

- (void)setMltTabBarController:(MLTTabBarController *)mltTabBarController {
    _mltTabBarController = mltTabBarController;
}

- (CGRect)defaultFrame {
    return _defaultFrame;
}

- (MLTTabBarItem *)mltTabBarItem {
    return _mltTabBarItem;
}

- (MLTTabBarController *)mltTabBarController {
    return _mltTabBarController;
}

@end
