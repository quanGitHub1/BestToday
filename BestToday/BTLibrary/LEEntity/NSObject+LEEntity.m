//
//  NSObject+LEEntity.m
//  LEFinanceNewsIphone
//
//  Created by wangfaquan on 2017/5/12.
//  Copyright © 2017年 wangfaquan. All rights reserved.
//

#import "NSObject+LEEntity.h"

#import <objc/runtime.h>


@interface NSObject(LEEntity)

- (void)mgj_parseValueToDictionary:(NSMutableDictionary *)dict withClass:(Class)class;
- (NSString *)mgj_getClassNameFromAttributeString:(NSString *)attributeString;
- (id)mgj_convertToValidJSONObject;

@end

@implementation NSObject (LEEntity)
#pragma mark - public methods
+ (instancetype)mgj_entityWithDictionary:(NSDictionary *)dict
{
    if (!dict || ![dict isKindOfClass:[NSDictionary class]] || dict.count == 0) {
        return nil;
    }
    
    Class cls = [self class];
    
    NSObject *entity = [cls new];
    
    return [entity mgj_entityWithDictionary:dict] ? entity : nil;
}

- (void)mgj_setValueWithDictionary:(NSDictionary *)dict
{
    [self mgj_parseValueFromDic:dict withClass:[self class]];
}

- (id)mgj_entityToJSONObject
{
    id jsonObject = [self mgj_convertToValidJSONObject];
    if ([jsonObject isKindOfClass:[NSDictionary class]] || [jsonObject isKindOfClass:[NSArray class]]) {
        return jsonObject;
    }
    else {
        return nil;
    }
}

- (id)mgj_convertToValidJSONObject
{
    if (self == [NSNull null]) {
        return nil;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        return self;
    }
    
    if ([self isKindOfClass:[NSNumber class]]) {
        return self;
    }
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        if ([NSJSONSerialization isValidJSONObject:self]) {
            return self;
        }
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [(NSDictionary *)self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *stringKey = [key isKindOfClass:[NSString class]] ? key : [key description];
            if (stringKey) {
                dict[stringKey] = [obj mgj_convertToValidJSONObject];
            }
        }];
        
        return dict;
    }
    
    if ([self isKindOfClass:[NSSet class]]) {
        NSArray *array = ((NSSet *)self).allObjects;
        return [array mgj_entityToJSONObject];
    }
    
    if ([self isKindOfClass:[NSArray class]]) {
        if ([NSJSONSerialization isValidJSONObject:self]) {
            return self;
        }
        
        NSMutableArray *jsonArray = [NSMutableArray array];
        for (id obj in (NSArray *)self) {
            id jsonObject = [obj mgj_convertToValidJSONObject];
            if (jsonObject) {
                [jsonArray addObject:jsonObject];
            }
        }
        return jsonArray;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [self mgj_parseValueToDictionary:dict withClass:[self class]];
    return dict;
}

- (NSString *)mgj_entityToJSONString
{
    id jsonObject = [self mgj_entityToJSONObject];
    
    if (!jsonObject) {
        return nil;
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:0 error:nil];
    
    if (!jsonData) {
        return nil;
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark - private methods
- (BOOL)mgj_entityWithDictionary:(NSDictionary *)dict
{
    if (!dict || ![dict isKindOfClass:[NSDictionary class]] || dict.count == 0) {
        return NO;
    }
    
    if ([self respondsToSelector:@selector(willParseValue)]) {
        [self performSelector:@selector(willParseValue)];
    }
    
    [self mgj_parseValueFromDic:dict withClass:[self class]];
    
    if ([self respondsToSelector:@selector(didParseValue)]) {
        [self performSelector:@selector(didParseValue)];
    }
    return YES;
}

- (void)mgj_parseValueFromDic:(NSDictionary *)dict withClass:(Class)class
{
    Class superClass = class_getSuperclass(class);
    
    //不处理 root class
    if (!superClass) {
        return;
    }
    
    [self mgj_parseValueFromDic:dict withClass:superClass];
    
    
    unsigned int propertyCount;
    
    objc_property_t *properties = class_copyPropertyList(class, &propertyCount);
    
    NSDictionary *keyMapDictionary = [self respondsToSelector:@selector(keyMapDictionary)] ? [self performSelector:@selector(keyMapDictionary)] : [NSDictionary dictionary];
    NSDictionary *entityMapDictionary = [self respondsToSelector:@selector(entityMapForArray)] ? [self performSelector:@selector(entityMapForArray)] : [NSDictionary dictionary];
    
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        
        //取属性名称
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        
        if (![self mgj_class:class hasSetterForProperty:propertyName] || ![self mgj_class:class hasGetterForProperty:propertyName]) {
            continue;
        }
        
        NSString *key = propertyName;
        
        //key映射
        if ([keyMapDictionary.allKeys containsObject:propertyName]) {
            key = keyMapDictionary[propertyName];
        }
        
        id value = dict[key];
        
        //字典中如果没有当前字段，则进入下一个循环
        if (!value) {
            continue;
        }
        
        NSString *attributeString = [NSString stringWithUTF8String:property_getAttributes(property)];
        NSString *typeString = [[attributeString componentsSeparatedByString:@","] objectAtIndex:0];
        
        //类名，非基础类型
        NSString *classNameString = [self mgj_getClassNameFromAttributeString:typeString];;
        
        //基础类型
        if ([value isKindOfClass:[NSNumber class]]) {
            //当对应的属性为基础类型或者 NSNumber 时才处理
            if ([typeString isEqualToString:@"Td"] || [typeString isEqualToString:@"Ti"] || [typeString isEqualToString:@"Tf"] || [typeString isEqualToString:@"Tl"] || [typeString isEqualToString:@"Tc"] || [typeString isEqualToString:@"Ts"] || [typeString isEqualToString:@"TI"]|| [typeString isEqualToString:@"Tq"] || [typeString isEqualToString:@"TQ"] || [typeString isEqualToString:@"TB"] ||[classNameString isEqualToString:@"NSNumber"]) {
                [self setValue:value forKey:propertyName];
            }
            else {
                if ([classNameString isEqualToString:@"NSString"]) {
                    [self setValue:[value stringValue] forKey:propertyName];
                }
                else{
                    NSLog(@"type error -- name:%@ attribute:%@ ", propertyName, typeString);
                }
            }
        }
        //字符串
        else if ([value isKindOfClass:[NSString class]]) {
            if ([classNameString isEqualToString:@"NSString"]) {
                [self setValue:value forKey:propertyName];
            }
            else if ([classNameString isEqualToString:@"NSMutableString"]) {
                [self setValue:[NSMutableString stringWithString:value] forKey:propertyName];
            }
            //对应的属性为基础类型时，先转成 nsnumber
            else if ([typeString isEqualToString:@"Td"] || [typeString isEqualToString:@"Ti"] || [typeString isEqualToString:@"Tf"] || [typeString isEqualToString:@"Tl"] || [typeString isEqualToString:@"Tc"] || [typeString isEqualToString:@"Ts"] || [typeString isEqualToString:@"TI"]|| [typeString isEqualToString:@"Tq"] || [typeString isEqualToString:@"TQ"] || [typeString isEqualToString:@"TB"]) {
                
                NSNumberFormatter *formater = [[NSNumberFormatter alloc] init];
                NSNumber *number = [formater numberFromString:value];
                if (number)
                {
                    [self setValue:number forKey:propertyName];
                }
            }
        }
        //字典（对象）
        else if ([value isKindOfClass:[NSDictionary class]]) {
            if ([classNameString isEqualToString:@"NSDictionary"]) {
                [self setValue:value forKey:propertyName];
            }
            else if ([classNameString isEqualToString:@"NSMutableDictionary"]) {
                [self setValue:[NSMutableDictionary dictionaryWithDictionary:value] forKey:propertyName];
            }
            else
            {
                [self setValue:[NSClassFromString(classNameString) mgj_entityWithDictionary:value] forKey:propertyName];
            }
        }
        //数组
        else if ([value isKindOfClass:[NSArray class]]) {
            NSString *entityTypeStringForArray = entityMapDictionary[propertyName];
            Class entityTypeForArray = NSClassFromString(entityTypeStringForArray);
            
            if ([classNameString isEqualToString:@"NSArray"]) {
                if (entityTypeForArray) {
                    [self setValue:[NSArray mgj_entityArrayWithJsonArray:value andClass:entityTypeForArray] forKey:propertyName];
                }
                else
                {
                    [self setValue:value forKey:propertyName];
                }
            }
            else if ([classNameString isEqualToString:@"NSMutableArray"]) {
                if (entityTypeForArray) {
                    [self setValue:[NSArray mgj_entityArrayWithJsonArray:value andClass:entityTypeForArray] forKey:propertyName];
                }
                else
                {
                    [self setValue:[NSMutableArray arrayWithArray:value] forKey:propertyName];
                }
            }
        }
        //空
        else if ([value isKindOfClass:[NSNull class]]) {
            continue;
        }
        //其它不处理
        else
        {
            continue;
        }
        
    }
    
    free(properties);
}

- (void)mgj_parseValueToDictionary:(NSMutableDictionary *)dict withClass:(Class)class
{
    if (!dict) {
        return;
    }
    
    Class superClass = class_getSuperclass(class);
    
    //不处理 root class
    if (!superClass) {
        return;
    }
    
    //先解析父类
    [self mgj_parseValueToDictionary:dict withClass:superClass];
    
    unsigned int propertyCount;
    
    objc_property_t *properties = class_copyPropertyList(class, &propertyCount);
    
    NSDictionary *keyMapDictionary = [self respondsToSelector:@selector(keyMapDictionary)] ? [self performSelector:@selector(keyMapDictionary)] : [NSDictionary dictionary];
    
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        
        //取属性名称
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        
        //过滤一下引入 protocol 以后暴露出来的由父类实现的方法
        if (![self mgj_class:[self class] hasGetterForProperty:propertyName] || ![self mgj_class:[self class] hasSetterForProperty:propertyName]) {
            continue;
        }
        
        NSString *key = propertyName;
        
        //key映射
        if ([keyMapDictionary.allKeys containsObject:propertyName]) {
            key = keyMapDictionary[propertyName];
        }
        
        id val = [self valueForKey:propertyName];
        
        if (val) {
            dict[key] = [val mgj_convertToValidJSONObject];
        }
    }
    
    free(properties);
    
    
}

- (NSString *)mgj_getClassNameFromAttributeString:(NSString *)attributeString
{
    NSString *className = nil;
    
    NSScanner *scanner = [NSScanner scannerWithString: attributeString];
    
    [scanner scanUpToString:@"T" intoString: nil];
    [scanner scanString:@"T" intoString:nil];
    
    if ([scanner scanString:@"@\"" intoString: &className]) {
        
        [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\"<"]
                                intoString:&className];
    }
    
    return className;
}

- (BOOL)mgj_class:(Class)class hasGetterForProperty:(NSString *)propertyName
{
    NSString *getter = propertyName;
    return [class instancesRespondToSelector:NSSelectorFromString(getter)];
}

- (BOOL)mgj_class:(Class)class hasSetterForProperty:(NSString *)propertyName
{
    NSString *setter = [NSString stringWithFormat:@"set%@%@:", [[propertyName substringToIndex:1] uppercaseString], [propertyName substringFromIndex:1]];
    return [class instancesRespondToSelector:NSSelectorFromString(setter)];
}
@end

@interface NSArray(MGJEntity)

@end

@implementation NSArray (MGJEntity)
+ (NSArray *)mgj_entityArrayWithJsonArray:(NSArray *)jsonArray andClass:(Class)cls
{
    if (!cls || !jsonArray) {
        return nil;
    }
    
    NSMutableArray *entityArray = [NSMutableArray array];
    for (id jsonObject in jsonArray) {
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            id entity = [cls mgj_entityWithDictionary:jsonObject];
            if (entity) {
                [entityArray addObject:entity];
            }
        }
        else if ([jsonObject isKindOfClass:cls]) {
            [entityArray addObject:jsonObject];
        }
    }
    return entityArray;
}

+ (NSArray *)mgj_entityArrayWithJsonString:(NSString *)jsonString andClass:(Class)cls
{
    if (jsonString.length == 0) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData.length == 0) {
        return nil;
    }
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    if (!jsonObject || ![jsonObject isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    NSArray *jsonArray = jsonObject;
    
    return [self mgj_entityArrayWithJsonArray:jsonArray andClass:cls];
}@end
