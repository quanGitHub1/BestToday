//
//  UIButton+Font.m
//  LEFinanceNewsIphone
//
//  Created by leeco on 2017/10/20.
//  Copyright © 2017年 wangfaquan. All rights reserved.
//

#import "UIButton+Font.h"
#import <objc/runtime.h>

#define IPHONE_Width      [UIScreen mainScreen].bounds.size.width

#define SizeScale  IPHONE_Width/375

#define UILabelEnable 1



//@interface UILabel (FontSize)
//
//@end
//
//@implementation UILabel (FontSize)
//
//+ (void)load{
//    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
//    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
//    method_exchangeImplementations(imp, myImp);
//}
//
//- (id)myInitWithCoder:(NSCoder*)aDecode{
//    [self myInitWithCoder:aDecode];
//    if (self) {
//        //部分不像改变字体的 把tag值设置成333跳过
//        if(self.tag != 333){
//            CGFloat fontSize = self.font.pointSize;
//            self.font = [UIFont systemFontOfSize:fontSize * SizeScale];
//        }
//    }
//    return self;
//}
//
//@end
//
//
//
//@implementation UIButton (Font)
//
//+ (void)load{
//    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
//    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
//    method_exchangeImplementations(imp, myImp);
//}
//
//- (id)myInitWithCoder:(NSCoder*)aDecode{
//    [self myInitWithCoder:aDecode];
//    if (self) {
//        //部分不像改变字体的 把tag值设置成333跳过
//        if(self.titleLabel.tag != 333){
//            CGFloat fontSize = self.titleLabel.font.pointSize;
//            self.titleLabel.font = [UIFont systemFontOfSize:fontSize * SizeScale];
//        }
//    }
//    return self;
//}


//@end
