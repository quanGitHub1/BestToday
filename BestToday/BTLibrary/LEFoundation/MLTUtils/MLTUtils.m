//
//  MLTUtils.m
//  AMCustomer
//
//  Created by WangFaquan on 16/9/1.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#import "MLTUtils.h"
#import <AdSupport/AdSupport.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>
#import <sys/utsname.h>

@implementation MLTUtils

+ (NSString *)appVersion
{
    NSString *result = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    if ([result length] == 0)
        result = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    
    return result;
}

+ (NSString *)bundleId
{

    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSString *)osVersion
{
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    return [[UIDevice currentDevice] systemVersion];
#else
    return [NSDictionary dictionaryWithContentsOfFile:@"/System/Library/CoreServices/SystemVersion.plist"][@"ProductVersion"];
#endif
}

//+ (NSString *)idfa
//{
//    return ASIdentifierManager.sharedManager.advertisingIdentifier.UUIDString;
//}

//当前设备类型
+ (NSString*)getCurrentDevicePlatform
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone 系列
    if ([deviceModel isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceModel isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceModel isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7 (CDMA)";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7 (GSM)";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus (CDMA)";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus (GSM)";
    if([deviceModel isEqualToString:@"iPhone10,1"])    return@"iPhone 8";
    if([deviceModel isEqualToString:@"iPhone10,4"])    return@"iPhone 8";
    if([deviceModel isEqualToString:@"iPhone10,2"])    return@"iPhone 8 Plus";
    if([deviceModel isEqualToString:@"iPhone10,5"])    return@"iPhone 8 Plus";
    return deviceModel;

    
}

+ (NSString *)localeIdentifier
{
    return [[NSLocale currentLocale] localeIdentifier];
}


+ (NSString *)getCurrentLanguage
{
    // 获取用户的语言偏好设置列表
    NSArray *languages = [NSLocale preferredLanguages];
    return [languages objectAtIndex:0];
}

+ (NSString *)md5:(NSString *)encryption {
    const char *strEncryption = [encryption UTF8String];
    unsigned char result[32];
    CC_MD5( strEncryption, (CC_LONG)strlen(strEncryption), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
