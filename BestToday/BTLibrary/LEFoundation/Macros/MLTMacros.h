//
//  MLTMacros.h
//  AMCustomer
//
//  Created by 恺撒 on 16/9/1.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#ifndef MLTMacros_h
#define MLTMacros_h

/*
 9.1  和业务无关UI无关的宏定义
 */

#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

#pragma mark --- Judgement

#define IsNull(value) ([value isKindOfClass:[NSNull class]])

#ifndef IsEmptyString
#define IsEmptyString(str) (str.length == 0 || [str isEqualToString:@""])
#endif

#define IsEmptyArray(array) (!array || [array count]==0)

#define IsEmptyDictionary(dict) (!dict || [[dict allKeys] count]==0)

#define IsKindOfClass(_object, _class) [_object isKindOfClass:[_class class]]

#define isValidKey(key) ((key) != nil && ![key isKindOfClass:[NSNull class]])

#define isValidValue(value) (((value) != nil) && ![value isKindOfClass:[NSNull class]])

#pragma mark --- String

#define StringFromBool(boolV) [NSString stringWithFormat:@"%d",boolV]

#define StringFromInt(intV)   [NSString stringWithFormat:@"%d",intV]

#define StringFromInteger(integerV)  [NSString stringWithFormat:@"%ld",integerV]

#define StringFromFloat(floatV)   [NSString stringWithFormat:@"%f",floatV]

#define StringFromSize(sizeV)     [NSString stringWithFormat:@"w:%f h:%f",sizeV.width,sizeV.height]

#define StringFromFrame(frame)    [NSString stringWithFormat:@"x:%f y:%f w:%f h:%f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height]

#pragma mark --- Directory

#define PathTemp NSTemporaryDirectory()

#define PathCache    [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#define PathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

#pragma mark --- GCD

#define DISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);

#define DISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);

#define DISPATCH_BACKGROUND_THREAD(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlock);

#pragma mark --- Block

#define EXCUTE_BLOCK(block, ...) if (block) { block(__VA_ARGS__); };

#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#pragma mark --- UserDefaults

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#pragma mark --- Notification

#define NotificationCenter [NSNotificationCenter defaultCenter]

#define theNotificationCenter [NSNotificationCenter defaultCenter]

#define AddObserver(_notificationName, _observer, _observerSelector, _obj) [[NSNotificationCenter defaultCenter] addObserver:_observer selector:@selector(_observerSelector) name:_notificationName object: _obj];

#define NotifyObserver(_notificationName, _obj, _userInfoDictionary) [[NSNotificationCenter defaultCenter] postNotificationName: _notificationName object: _obj userInfo: _userInfoDictionary];

#define RemoveObserver(_observer) [[NSNotificationCenter defaultCenter] removeObserver: _observer];

#pragma mark --- Language

#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#pragma mark --- MATH

#define DEGREES_TO_RADIANS(degrees) degrees * M_PI / 180.0

#define RADIANS_TO_DEGREES(radians) radians * 180.0 / M_PI

#pragma mark --- Log

#ifdef DEBUG
#define DBG(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define DBG(format, ...)
#endif

#pragma mark --- Condition

#define ALWAYS_TRUE YES
#define NEVER_TRUE  NO

#define AssertMainThread() NSAssert([NSThread isMainThread], @"This method must be called on the main thread")

#define METHOD_NOT_IMPLEMENTED() NSAssert(NO, @"You must override %@ in a subclass", NSStringFromSelector(_cmd))

#define SHOULDOVERRIDE(basename, subclassname){ NSAssert([basename isEqualToString:subclassname], @"subclass should override the method!");}

#import <Foundation/Foundation.h>

static inline BOOL MLT_IS_EMPTY(id thing) {
    return thing == nil ||
    ([thing isEqual:[NSNull null]]) ||
    ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0) ||
    ([thing respondsToSelector:@selector(count)]  && [(NSArray *)thing count] == 0);
}

/**
 用来处理Array判空处理

 @param thing

 @return
 */
static inline BOOL MLT_ARR_IS_EMPTY(id thing){
    
    return thing == nil ||
    ([thing isEqual:[NSNull null]]) ||
    (![thing isKindOfClass:[NSArray class]]) ||
    (!((NSArray *)thing).count);
    
}

/**
 用来处理Dictionary判空处理
 
 @param thing
 
 @return
 */
static inline BOOL MLT_DICT_IS_EMPTY(id thing){
    
    return thing == nil ||
    ([thing isEqual:[NSNull null]]) ||
    (![thing isKindOfClass:[NSDictionary class]]) ||
    (!((NSDictionary *)thing).allKeys.count);
    
}

/**
 处理str判空

 @param str str

 @return 是否是空字符串
 */
static inline BOOL MLT_STR_IS_EMPTY(id str){
    
    return str == nil || ![str isKindOfClass:[NSString class]] || [str isEqualToString:@""] || [str isEqualToString:@"(null)"];
    
}

#endif /* MLTMacros_h */

