//
//  NSObject+LEEntity.h
//  LEFinanceNewsIphone
//
//  Created by wangfaquan on 2017/5/12.
//  Copyright © 2017年 wangfaquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LEEntity)
/**
 *  从字典创建实体类,默认会转数组
 *
 *  @param dict 字典
 *
 *  @return 实体类
 */
+ (instancetype _Nullable )mgj_entityWithDictionary:(NSDictionary *_Nullable)dict;

/**
 *  从字典填充数据到当前实体
 *
 *  @param dict       字典
 */
- (void)mgj_setValueWithDictionary:(NSDictionary *_Nonnull)dict;

/**
 把当前对象转成 JSON 对象，即 NSDictionary、NSArray 如果无法转成这些类型，则返回 nil
 
 */
- (__nullable id)mgj_entityToJSONObject;


/**
 把当前对象转成 JSON 字符串
 
 */
- (NSString * _Nullable)mgj_entityToJSONString;
@end


@interface NSArray (LEEntity)
+ (nullable NSArray *)mgj_entityArrayWithJsonArray:(NSArray *_Nonnull)jsonArray andClass:(Class _Nullable )cls;
+ (nullable NSArray *)mgj_entityArrayWithJsonString:(NSString *_Nullable)jsonString andClass:(Class _Nullable )cls;
@end


@protocol MGJEntityProtocol <NSObject>

@optional
#pragma mark - map
/**
 *  字段名映射，key 为实体的字段, value 为字典中的字段
 *
 */
- (NSDictionary *_Nullable)keyMapDictionary;

/**
 *  数组中的实体类型映射，key 为数组变量名，value 为数组中的元素类型
 *
 */
- (NSDictionary *_Nullable)entityMapForArray;

#pragma mark - others
/**
 *  开始解析前调用
 */
- (void)willParseValue;

/**
 *  解析完成后调用
 */
- (void)didParseValue;


@end
