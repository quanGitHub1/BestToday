//
//  MLTUISkeletonModule.m
//  AMCustomer
//
//  Created by wangfaquan on 16/9/7.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "MLTUISkeletonModule.h"
#import "MLTTabBarController.h"
#import "MLTTabBarManager.h"
#import "MGJNavigationController.h"
#import "AMTTabbarIconManager.h"
// will delete
#import "BTMeViewController.h"
#import "BTDiscoverViewController.h"
#import "BTPhotoViewController.h"
#import "BTCollectionViewController.h"

#import "BTViewController.h"
#import "BTHomePageViewController.h"

@interface MLTUISkeletonModule() <MLTTabBarControllerDelegate>


@end

@implementation MLTUISkeletonModule

+ (void)load {

}

+ (instancetype)shareInstance {
    static MLTUISkeletonModule *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MLTUISkeletonModule alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // do something
        [self setupBasicSkeleton];

    }
    return self;
}

- (void)setupBasicSkeleton {
    //四个tab页控制器
    
    
    BTHomePageViewController *HomepageViewController = [[BTHomePageViewController alloc] init];
    
    BTDiscoverViewController *diCcoverViewController = [[BTDiscoverViewController alloc] init];
    
    BTPhotoViewController *photoViewController = [[BTPhotoViewController alloc] init];
    
    BTCollectionViewController *collectionViewController= [[BTCollectionViewController alloc] init];
    
    BTMeViewController *meViewController = [[BTMeViewController alloc] init];
    
    NSArray *viewControllers = @[HomepageViewController,diCcoverViewController,photoViewController,collectionViewController, meViewController];
    

    //tabBar控制器
    MLTTabBarController *tabBarController = [[MLTTabBarController alloc] initWithViewControllers:viewControllers selectedIndex:0];
    tabBarController.mltTabBarControllerDelegate = self;
    
    //导航栏控制器
    MGJNavigationController *navigationController = [[MGJNavigationController alloc] initWithRootViewController:tabBarController];
    
    UIWindow *window = AppWindow;
    
    window.backgroundColor = [UIColor whiteColor];
    
    if (window == nil) {
        
        [UIApplication sharedApplication].delegate.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    
    [UIApplication sharedApplication].delegate.window.rootViewController = navigationController;
    
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    
}

#pragma mark -  MLTTabBarControllerDelegate

- (BOOL)tabBarController:(MLTTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController atIndex:(NSInteger)index {
        return YES;
}

- (void)tabBarController:(MLTTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController atIndex:(NSInteger)index {
    
//    ((MLTViewController *)viewController).requestURLForAnalytics = [NSString stringWithFormat:@"amcustomerurl://tab?index=%ld",(long)index];
}

@end
