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
//
////当前设备类型
//+ (NSString*)getCurrentDevicePlatform
//{
//    int name[] = {CTL_HW,HW_MACHINE};
//    size_t size = 100;
//    sysctl(name, 2, NULL, &size, NULL, 0); // getting size of answer
//    char *hw_machine = malloc(size);
//    
//    sysctl(name, 2, hw_machine, &size, NULL, 0);
//    NSString *hardware = [NSString stringWithUTF8String:hw_machine];
//    free(hw_machine);
//    
//    if ([hardware isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
//    if ([hardware isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
//    if ([hardware isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
//    if ([hardware isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
//    if ([hardware isEqualToString:@"iPhone3,2"])    return @"iPhone 4 (GSM Rev. A)";
//    if ([hardware isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
//    if ([hardware isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
//    if ([hardware isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
//    if ([hardware isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (Global)";
//    if ([hardware isEqualToString:@"iPhone5,3"])    return @"iPhone 5C (GSM)";
//    if ([hardware isEqualToString:@"iPhone5,4"])    return @"iPhone 5C (Global)";
//    if ([hardware isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
//    if ([hardware isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (Global)";
//    
//    if ([hardware isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
//    if ([hardware isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
//    
//    if ([hardware isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
//    if ([hardware isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
//    if ([hardware isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
//    if ([hardware isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
//    if ([hardware isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
//    
//    if ([hardware isEqualToString:@"iPad1,1"])      return @"iPad (WiFi)";
//    if ([hardware isEqualToString:@"iPad1,2"])      return @"iPad 3G";
//    if ([hardware isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
//    if ([hardware isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
//    if ([hardware isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
//    if ([hardware isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi Rev. A)";
//    if ([hardware isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
//    if ([hardware isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
//    if ([hardware isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
//    if ([hardware isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
//    if ([hardware isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
//    if ([hardware isEqualToString:@"iPad3,3"])      return @"iPad 3 (Global)";
//    if ([hardware isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
//    if ([hardware isEqualToString:@"iPad3,5"])      return @"iPad 4 (CDMA)";
//    if ([hardware isEqualToString:@"iPad3,6"])      return @"iPad 4 (Global)";
//    if ([hardware isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
//    if ([hardware isEqualToString:@"iPad4,2"])      return @"iPad Air (WiFi+GSM)";
//    if ([hardware isEqualToString:@"iPad4,3"])      return @"iPad Air (WiFi+CDMA)";
//    if ([hardware isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
//    if ([hardware isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (WiFi+CDMA)";
//    if ([hardware isEqualToString:@"iPad4,6"])      return @"iPad Mini Retina (Wi-Fi + Cellular CN)";
//    if ([hardware isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (Wi-Fi)";
//    if ([hardware isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (Wi-Fi + Cellular)";
//    if ([hardware isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (Wi-Fi)";
//    if ([hardware isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Wi-Fi + Cellular)";
//    
//    if ([hardware isEqualToString:@"i386"])         return @"Simulator";
//    if ([hardware isEqualToString:@"x86_64"])       return @"Simulator";
//    if ([hardware hasPrefix:@"iPhone"])             return @"iPhone";
//    if ([hardware hasPrefix:@"iPod"])               return @"iPod";
//    if ([hardware hasPrefix:@"iPad"])               return @"iPad";
//    return nil;
//}

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
