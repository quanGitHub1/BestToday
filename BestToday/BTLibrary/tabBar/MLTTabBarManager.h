//
//  MLTTabBarManager.h
//  AMCustomer
//
//  Created by wangfaquan on 16/9/7.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

/**
 *  管理 tabBar 上面 item的显示和图片文字下载等
 */

#import <Foundation/Foundation.h>
#import "MLTTabBarController.h"

@interface MLTTabBarManager : NSObject

@property (nonatomic, strong) MLTTabBarController *tabBarController;

@property (nonatomic, assign) CGRect defaultFrame;

+ (instancetype)shareInstance;

@end
