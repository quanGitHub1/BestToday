//
//  AMTTabbarIconManager.m
//  AMCustomer
//
//  Created by wangxijin on 16/6/29.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#import "AMTTabbarIconManager.h"
#import "MLTTabBarManager.h"
#import "MLTViewControllerProtocol.h"

#define kNormalCommendKey    @"NomalTaoShiJieTabImage"
#define kSelectedCommendKey  @"SelectedTaoShiJieTabImage"
#define kBundleImage(name) ([NSString stringWithFormat:@"MLTUISkeleton.bundle/tabbar_icon/%@.png", name])


@interface AMTTabbarIconManager()

@property(nonatomic,weak)MLTTabBarController *target;

@end

@implementation AMTTabbarIconManager



- (void)loadTheTabImages {
    
    
    [self setTheItemImage];

}

- (void)clearTheCacheImageData {
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *ourDocumentPath =[documentPaths objectAtIndex:0];
    NSString *norFileName0 = [ourDocumentPath stringByAppendingString:[NSString stringWithFormat:@"/%@%d@3x.png",kNormalCommendKey,0]];
    NSString *selectFileName0 = [ourDocumentPath stringByAppendingString:[NSString stringWithFormat:@"/%@%d@3x.png",kSelectedCommendKey,0]];
    
    NSString *norFileName1 = [ourDocumentPath stringByAppendingString:[NSString stringWithFormat:@"/%@%d@3x.png",kNormalCommendKey,1]];
    NSString *selectFileName1 = [ourDocumentPath stringByAppendingString:[NSString stringWithFormat:@"/%@%d@3x.png",kSelectedCommendKey,1]];
    
    NSString *norFileName2 = [ourDocumentPath stringByAppendingString:[NSString stringWithFormat:@"/%@%d@3x.png",kNormalCommendKey,2]];
    NSString *selectFileName2 = [ourDocumentPath stringByAppendingString:[NSString stringWithFormat:@"/%@%d@3x.png",kSelectedCommendKey,2]];
    
    NSString *norFileName3= [ourDocumentPath stringByAppendingString:[NSString stringWithFormat:@"/%@%d@3x.png",kNormalCommendKey,3]];
    NSString *selectFileName3 = [ourDocumentPath stringByAppendingString:[NSString stringWithFormat:@"/%@%d@3x.png",kSelectedCommendKey,3]];
    
    [[NSFileManager defaultManager] removeItemAtPath:norFileName0 error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:selectFileName0 error:nil];
    
    [[NSFileManager defaultManager] removeItemAtPath:norFileName1 error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:selectFileName1 error:nil];
    
    [[NSFileManager defaultManager] removeItemAtPath:norFileName2 error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:selectFileName2 error:nil];
    
    [[NSFileManager defaultManager] removeItemAtPath:norFileName3 error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:selectFileName3 error:nil];
    
    [self setLocalItemImage];
    
}


//设置item图片
- (void)setTheItemImage {
    
    self.target = [MLTTabBarManager shareInstance].tabBarController;
    
    [self setLocalItemImage];
}

- (void)setLocalItemImage {

    self.target = [MLTTabBarManager shareInstance].tabBarController;
    
    [[MLTTabBarManager shareInstance] setTabBarController:self.target];
    
    
}

@end
