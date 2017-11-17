//
//  MLTTabBarManager.m
//  AMCustomer
//
//  Created by wangfaquan on 16/9/7.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "MLTTabBarManager.h"
#import "MLTViewControllerProtocol.h"

@interface MLTTabBarManager()

@property (nonatomic, strong) NSArray *tabBarTitles;
@property (nonatomic, strong) NSArray *tabBarNormalIcons;
@property (nonatomic, strong) NSArray *tabBarSelectedIcons;

@end


@implementation MLTTabBarManager

+ (instancetype)shareInstance {
    static MLTTabBarManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MLTTabBarManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //do something
//        self.tabBarTitles = @[@"首页", @"发现", @"拍照", @"关注", @"我的"];
        self.tabBarNormalIcons = @[@"tabbar_Home", @"tabbar_Search", @"tabbar_Add", @"tabbar_info",@"tabbar_mine"];
        
        self.tabBarSelectedIcons = @[@"tabbar_Homeselect", @"tabbar_Searchselect", @"tabbar_Addselect", @"tabbar_infoSelect",@"tabbar_mine_select"];
        
    }
    return self;
}

- (void)setTabBarController:(MLTTabBarController *)tabBarController {
    
    _tabBarController = tabBarController;
    
    [self setTabBarItem];
}

- (void)setTabBarItem {
    
    [self.tabBarController.viewControllers enumerateObjectsUsingBlock:^(UIViewController<MLTViewControllerProtocol> *vc, NSUInteger index, BOOL * _Nonnull stop) {
        UIImage *imageNormal = [UIImage imageNamed:self.tabBarNormalIcons[index]];
        UIImage *imageSelected = [UIImage imageNamed:self.tabBarSelectedIcons[index]];
        [vc.mltTabBarItem setIcon:imageNormal enableExtend:NO];
        [vc.mltTabBarItem setSelectedIcon:imageSelected enableExtend:NO];
        [vc.mltTabBarItem setTitle:self.tabBarTitles[index]];
        [vc.mltTabBarItem setTextColor:HEX(@"333333")];
        [vc.mltTabBarItem setSelectedTextColor:HEX(@"006BBD")];
    }];
}

@end
