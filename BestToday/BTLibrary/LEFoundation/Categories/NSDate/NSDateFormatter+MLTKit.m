//
//  NSDateFormatter+MLTKit.m
//  AMCustomer
//
//  Created by 恺撒 on 16/9/2.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#import "NSDateFormatter+MLTKit.h"

@implementation NSDateFormatter (MLTKit)

+ (id)mlt_dateFormatter {
    return [[self alloc] init];
}

+ (id)mlt_dateFormatterWithFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

//+ (id)mlt_defaultDateFormatter {
//    return [self dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
//}

@end
