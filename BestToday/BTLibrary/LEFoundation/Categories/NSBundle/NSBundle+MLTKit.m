//
//  NSBundle+MLTKit.m
//  AMCustomer
//
//  Created by 恺撒 on 16/9/5.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "NSBundle+MLTKit.h"
#define IsNull(value) ([value isKindOfClass:[NSNull class]])

#ifndef IsEmptyString
#define IsEmptyString(str) (str.length == 0 || [str isEqualToString:@""])
#endif

@implementation NSBundle (MLTKit)

+ (NSBundle *)mlt_libraryResourcesBundle:(NSString *)libraryName {
    NSBundle *libraryResourcesBundle = nil;
    do {
        if (IsEmptyString(libraryName)) {
            libraryResourcesBundle = [NSBundle mainBundle];
        }
        else{
            NSURL* pathUrl = [[NSBundle mainBundle] URLForResource:libraryName withExtension:@"bundle"];
            
            //pathUrl 不能为空
            if (pathUrl) {
                libraryResourcesBundle = [NSBundle bundleWithURL:pathUrl];
            }
        }
        
#ifdef MGJBOUNDLESUPPORT_DISABLE
        libraryResourcesBundle = [NSBundle mainBundle];
#endif
        
    } while (NO);
    return libraryResourcesBundle;
}

@end
