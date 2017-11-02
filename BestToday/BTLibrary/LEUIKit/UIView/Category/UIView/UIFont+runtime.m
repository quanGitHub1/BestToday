//
//  UIFont+runtime.m
//  LEFinanceNewsIphone
//
//  Created by leeco on 2017/10/20.
//  Copyright © 2017年 wangfaquan. All rights reserved.
//

#import "UIFont+runtime.h"
#import <objc/runtime.h>

@implementation UIFont (runtime)

+ (void)load {
    // 获取替换后的类方法
    Method newMethod = class_getClassMethod([self class], @selector(adjustFont:));
    // 获取替换前的类方法
    Method method = class_getClassMethod([self class], @selector(boldSystemFontOfSize:));
    // 然后交换类方法，交换两个方法的IMP指针，(IMP代表了方法的具体的实现）
    method_exchangeImplementations(newMethod, method);
    
    // 获取替换后的类方法
    Method newMethod1 = class_getClassMethod([self class], @selector(adjustFont1:));
    // 获取替换前的类方法
    Method method1 = class_getClassMethod([self class], @selector(systemFontOfSize:));
    // 然后交换类方法，交换两个方法的IMP指针，(IMP代表了方法的具体的实现）
    method_exchangeImplementations(newMethod1, method1);
}

+ (UIFont *)adjustFont:(CGFloat)fontSize {
    UIFont *newFont = nil;
    newFont = [UIFont adjustFont:fontSize * [UIScreen mainScreen].bounds.size.width/375];
    return newFont;
}

+ (UIFont *)adjustFont1:(CGFloat)fontSize {
    UIFont *newFont = nil;
    newFont = [UIFont adjustFont1:fontSize * [UIScreen mainScreen].bounds.size.width/375];
    return newFont;
}


@end
