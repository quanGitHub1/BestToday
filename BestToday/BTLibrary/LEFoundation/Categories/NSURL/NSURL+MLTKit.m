//
//  NSURL+MLTKit.m
//  AMCustomer
//
//  Created by 恺撒 on 16/9/2.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#import "NSURL+MLTKit.h"

#define isValidURLString(string) ((string) != nil && ![string isKindOfClass:[NSNull class]])

@implementation NSURL (MLTKit)

#pragma mark --- Safe

+ (NSURL *)mlt_safeURLWithString:(NSString*)string {
    if (isValidURLString(string))
    {
        return [NSURL URLWithString:string];
    }
    else
    {
        return nil;
    }
}

@end
