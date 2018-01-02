//
//  MLTUISkeletonModule.h
//  AMCustomer
//
//  Created by wangfaquan on 16/9/7.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

/**
 *  设置app基础框架 - NavigationController, TabBarController
 */

#import <Foundation/Foundation.h>
#import "BTCollectionViewController.h"

@interface MLTUISkeletonModule : NSObject

@property (nonatomic, strong) BTCollectionViewController *collectionViewController;

+ (instancetype)shareInstance;



@end
