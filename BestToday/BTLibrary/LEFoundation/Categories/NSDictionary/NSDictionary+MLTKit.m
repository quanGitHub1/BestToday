//
//  NSDictionary+MLTKit.m
//  AMCustomer
//
//  Created by 恺撒 on 16/9/2.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#import "NSDictionary+MLTKit.h"
//#import "NSArray+BlocksKit.h"
//#import "MLTMacros.h"

@implementation NSDictionary (MLTKit)

#pragma mark --- Safe Fetch data

- (id)mlt_safeObjectForKey:(id)key {
    if (!isValidKey(key)) {
        return nil;
    }
    id obj = [self objectForKey:key];
    if(!isValidValue(obj))
        return nil;
    return obj;
}

- (id)mlt_safeKeyForValue:(id)value {
    for (id key in self.allKeys) {
        if ([value isEqual:[self objectForKey:key]]) {
            return key;
        }
    }
    return nil;
}

- (int)mlt_intValueOfKey:(NSString*)key {
    id value = [self mlt_safeObjectForKey:key];
    if ([value respondsToSelector:@selector(intValue)]){
        return [value intValue];
    }
    return 0;
}

- (BOOL)mlt_boolValueOfKey:(NSString *)key {
    id value = [self mlt_safeObjectForKey:key];
    if ([value respondsToSelector:@selector(boolValue)]){
        return [value boolValue];
    }
    return NO;
}

- (float)mlt_floatValueOfKey:(NSString *)key {
    id value = [self mlt_safeObjectForKey:key];
    if ( [value respondsToSelector:@selector(floatValue)] ){
        return [value floatValue];
    }
    return 0.0f;
}

- (double)mlt_doubleValueOfKey:(NSString *)key {
    id value = [self mlt_safeObjectForKey:key];
    if ( [value respondsToSelector:@selector(doubleValue)] ){
        return [value doubleValue];
    }
    return 0.0;
}

- (long long)mlt_longlongValueOfKey:(NSString *)key {
    id value = [self mlt_safeObjectForKey:key];
    if ( [value respondsToSelector:@selector(longLongValue)] ){
        return [value longLongValue];
    }
    return 0;
}

- (NSInteger)mlt_integerValueOfKey:(NSString *)key {
    id value = [self mlt_safeObjectForKey:key];
    if ( [value respondsToSelector:@selector(integerValue)]) {
        return [value integerValue];
    }
    return 0;
}

- (NSDate *)mlt_dateValueOfKey:(NSString *)key {
    id value = [self mlt_safeObjectForKey:key];
    if ( [value respondsToSelector:@selector(doubleValue)] ){
        return [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
    }
    return nil;
}

- (NSString *)mlt_timeStampForKey:(NSString *)key {
    id value = [self mlt_safeObjectForKey:key];
    if ( [value respondsToSelector:@selector(doubleValue)] ){
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *currentDateStr = [formatter stringFromDate:date];
        return currentDateStr;
    }
    return nil;
}

- (NSString *)mlt_timeForKey:(NSString *)key {
    id value = [self mlt_safeObjectForKey:key];
    if ( [value respondsToSelector:@selector(doubleValue)] ){
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *currentDateStr = [formatter stringFromDate:date];
        return currentDateStr;
    }
    return nil;
}

- (NSString *)mlt_stringValueOfKey:(NSString *)key {
    id value = [self mlt_safeObjectForKey:key];
    if ( [value isKindOfClass:[NSString class]] ){
        return value;
    }
    // 如果后台类型为NSNumber，我们需要的是string 就给强转一下
    if ([value isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",value];
    }
    return @"";
}

//- (NSArray *)mlt_arrayOfStringOfKey:(NSString *)key {
//    id value = [self mlt_safeObjectForKey:key];
//    if ( [value isKindOfClass:[NSArray class]] ){
//        NSArray * arr = (NSArray *) value;
//        return [arr bk_map:^id(id obj){
//            if ( [obj isKindOfClass:[NSString class]] )
//                return obj;
//            else
//                return @"";
//        }];
//    }
//    return [NSArray array];
//}

- (NSArray *)mlt_arrayValueOfKey:(NSString *)key {
    id value = [self mlt_safeObjectForKey:key];
    if ( [value isKindOfClass:[NSArray class]] ){
        return value;
    }
    return [NSArray array];
}

- (NSDictionary *)mlt_dictValueOfKey:(NSString *)key {
    id value = [self mlt_safeObjectForKey:key];
    if ( [value isKindOfClass:[NSDictionary class]] ){
        return value;
    }
    return nil;
}


#pragma mark --- JSON

- (NSString *)mlt_toJSONString {
    NSData *infoJsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    if (!infoJsonData) {
        return nil;
    }
    else {
        NSString *json = [[NSString alloc] initWithData:infoJsonData encoding:NSUTF8StringEncoding];
        return json;
    }
}

+ (NSDictionary*)mlt_dictionaryFromJsonString:(NSString *)json {
    NSData *infoData = [json dataUsingEncoding:NSUTF8StringEncoding];
    if (!infoData) {
        return nil;
    }
    NSDictionary *info = [NSJSONSerialization JSONObjectWithData:infoData options:0 error:nil];
    return info;
}

#pragma mark --- Deep Copy

- (NSDictionary *)mlt_mutableDeepCopy {
    NSMutableDictionary* muDic = [[NSMutableDictionary alloc]initWithCapacity:self.count];
    for (id key in self.allKeys){
        id val = [self objectForKey:key];
        
        if ([val respondsToSelector:@selector(mlt_mutableDeepCopy)]) {
            [muDic setObject:[val mlt_mutableDeepCopy] forKey:key];
        }
        else if ([val respondsToSelector:@selector(mutableCopy)]){
            [muDic setObject:[val mutableCopy] forKey:key];
        }
        else{
            [muDic setObject:[val copy] forKey:key];
        }
    }
    return muDic;
}

@end
