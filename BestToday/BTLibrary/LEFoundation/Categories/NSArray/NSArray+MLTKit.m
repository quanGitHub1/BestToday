//
//  NSArray+MLTKit.m
//  AMCustomer
//
//  Created by 恺撒 on 16/9/2.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#import "NSArray+MLTKit.h"

@implementation NSArray (MLTKit)

#pragma mark --- Safe

- (id)mlt_safeObjectAtIndex:(NSInteger)index {
    id obj = nil;
    if (index < self.count) {
        obj = [self objectAtIndex:index];
    }
    return obj;
}

- (NSUInteger)mlt_safeIndexOfObject:(id)anObject {
    if (anObject == nil) {
        return NSNotFound;
    } else {
        return [self indexOfObject:anObject];
    }
}

- (NSArray *)mlt_safeSubArrayWithRange:(NSRange)range {
    NSUInteger location = range.location;
    NSUInteger length = range.length;
    if (location + length > self.count) {
        //超过了边界,就获取从loction开始所有的item
        if ((location + length) > self.count) {
            length = (self.count - location);
            return [self mlt_safeSubArrayWithRange:NSMakeRange(location, length)];
        }
        return nil;
    }
    else {
        return [self subarrayWithRange:range];
    }
}

#pragma mark --- JSON

- (NSString *)mlt_toJSONString {
    NSData *paramsJSONData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    return [[NSString alloc] initWithData:paramsJSONData encoding:NSUTF8StringEncoding];
}

+ (NSArray *)mlt_arrayFromJSONString:(NSString *)json {
    NSData *infoData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *info = [NSJSONSerialization JSONObjectWithData:infoData options:0 error:nil];
    return info;
}

@end
