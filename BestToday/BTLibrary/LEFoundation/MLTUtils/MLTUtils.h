//
//  MLTUtils.h
//  AMCustomer
//
//  Created by WangFaquan on 16/9/1.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 
   * 创建一个用于管理项目的基本信息的类，类似与版本号、设备ID、bundleID 等等
 
 */

@interface MLTUtils : NSObject

/**
  * 版本号
 */
+ (NSString *)appVersion;

+ (NSString *)bundleId;

/**
 * 设备的系统版本
 */
+ (NSString *)osVersion;

/**
 * 获取idfa码
 */
+ (NSString *)idfa;


/**
 *当前设备类型
 */
+ (NSString*) getCurrentDevicePlatform;

/**
 * 获取当前系统设置语言的标识符
 */

+ (NSString *)localeIdentifier;


/**
  * 获取用户设置的的语言
 */
+ (NSString *)getCurrentLanguage;


/**
 * 最简单的MD5加密
 */
+ (NSString *)md5:(NSString *)encryption;


@end
