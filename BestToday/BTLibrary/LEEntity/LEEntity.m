//
//  MGJEntity.h
//  MGJiPhoneSDK
//
//  Created by kunka on 14-8-25.
//  Copyright (c) 2013年 juangua. All rights reserved.
//

#import "LEEntity.h"
#import <objc/runtime.h>

@interface LEEntity ()
@end

@implementation LEEntity

#pragma mark - class method

+ (id)entityWithDictionary:(NSDictionary *)dict
{
    return [self entityWithDictionary:dict parseArray:YES];
}

+ (id)entityWithDictionary:(NSDictionary *)dict parseArray:(BOOL)parseArray
{
    return [[self class] mgj_entityWithDictionary:dict];
}

+ (NSArray *)parseToEntityArray:(NSArray *)array withType:(Class)type
{
    return [NSArray mgj_entityArrayWithJsonArray:array andClass:type];
}

+ (NSArray *)parseToDictionaryArray:(NSArray *)array
{
    return [array mgj_entityToJSONObject];
}

#pragma mark - init method

- (id)initWithDictionary:(NSDictionary *)dict
{
    return [self initWithDictionary:dict parseArray:YES];
}

- (id)initWithDictionary:(NSDictionary *)dict parseArray:(BOOL)parseArray
{
    return [[self class] entityWithDictionary:dict parseArray:parseArray];
}

- (NSDictionary *)entityToDictionary
{
    return [self mgj_entityToJSONObject];
}

- (void)parseValueFromDic:(NSDictionary *)dict parseArray:(BOOL)parseArray
{
    return [self mgj_setValueWithDictionary:dict];
}
#pragma mark - MGJEntityProtocol
- (NSDictionary *)keyMapDictionary
{
    return nil;
}

- (NSDictionary *)entityMapForArray
{
    return nil;
}

- (void)willParseValue
{
    
}

- (void)didParseValue
{
    
}

//#pragma NSCopying
//- (id)copyWithZone:(NSZone *)zone
//{
//    id copy = [[[self class] alloc] init];
//    for (NSString *key in [self codableProperties])
//    {
//        [copy setValue:[self valueForKey:key] forKey:key];
//    }
//    return copy;
//}
@end
