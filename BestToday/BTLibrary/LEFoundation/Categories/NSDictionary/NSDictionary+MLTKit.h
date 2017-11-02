//
//  NSDictionary+MLTKit.h
//  AMCustomer
//
//  Created by 恺撒 on 16/9/2.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MLTKit)

#pragma mark --- Safe Fetch data

- (id)mlt_safeObjectForKey:(id)key;

- (id)mlt_safeKeyForValue:(id)value;

- (int)mlt_intValueOfKey:(NSString*)key;

- (BOOL)mlt_boolValueOfKey:(NSString *)key;

- (float)mlt_floatValueOfKey:(NSString *)key;

- (double)mlt_doubleValueOfKey:(NSString *)key;

- (long long)mlt_longlongValueOfKey:(NSString *)key;

- (NSInteger)mlt_integerValueOfKey:(NSString *)key;

- (NSDate *)mlt_dateValueOfKey:(NSString *)key;

- (NSString *)mlt_timeStampForKey:(NSString *)key;

- (NSString *)mlt_timeForKey:(NSString *)key;

- (NSString *)mlt_stringValueOfKey:(NSString *)key;

- (NSArray *)mlt_arrayOfStringOfKey:(NSString *)key;

- (NSArray *)mlt_arrayValueOfKey:(NSString *)key;

- (NSDictionary *)mlt_dictValueOfKey:(NSString *)key;

#pragma mark --- JSON

- (NSString *)mlt_toJSONString;

+ (NSDictionary*)mlt_dictionaryFromJsonString:(NSString *)json;

#pragma mark --- Deep Copy

- (NSDictionary *)mlt_mutableDeepCopy;

@end
