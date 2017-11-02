//
//  MLTUIMacros.h
//  AMCustomer
//
//  Created by 恺撒 on 16/9/1.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#ifndef MLTUIMacros_h
#define MLTUIMacros_h

/*
 9.1  和业务无关UI相关的宏定义
 */

#pragma mark --- Size

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define SCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#endif

//用户信息
static NSString *const kUserID = @"kUserID";
static NSString *const kUserLoginNoti = @"kUserLoginNoti";

//设置字段如颜色，字体等
static NSString *const kUpTitleColorKey = @"kUpTitleColorKey";
static NSString *const kTitleColorValue = @"kTitleColorValueUpRed";
static NSString *const kTitleFontKey = @"kTitleFontKey";

//BaseCustomLabel
static NSString *const kFontChange = @"kFontChange";
static NSString *const kFontKey = @"kFontKey";
static NSString *const kTextSpace = @"kTextSpace";

//LoopViewCell
static NSString * const kLoopViewCellId = @"kLoopViewCellId";
static NSString * const kLoopViewLargeCapCellId = @"kLoopViewLargeCapCellId";
static NSString * const kLoopViewInformationCellId = @"kLoopViewInformationCellId";
static NSString * const kLoopViewMajornewsSpecialCellId = @"kLoopViewMajornewsSpecialCellId";

//InformationCell
static NSString *const kInformationMajornewsCellId = @"kInformationMajornewsCellId";
static NSString *const kInformationLiveCellId = @"kInformationLiveCellId";
static NSString *const kInformationMajornewsSpecialCellId = @"kInformationMajornewsSpecialCellId";
static NSString *const kInformationMajornewsCommentCellId = @"kInformationMajornewsCommentCellId";


//information类型
static NSString *const kInformationNewsType = @"NEWS";
static NSString *const kInformationTypeRICHTEXT = @"RICHTEXT";
static NSString *const kInformationTyepVIDEO = @"VIDEO";



#define STATUSBAR_HEIGHT  [[UIApplication sharedApplication] statusBarFrame].size.height

#define IS_IPHONE_SIZE_3_5            (SCREEN_WIDTH == 320 && SCREEN_HEIGHT == 480)

#define IS_IPHONE_SIZE_4_0            (SCREEN_WIDTH == 320 && SCREEN_HEIGHT == 568)

#define IS_IPHONE_SIZE_4_7            (SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 667)

#define IS_IPHONE_SIZE_5_5            (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 736)

//小屏幕总和，包括se，5s，4s，4
#define IS_SMALLSCREEN_DEVICE (SCREEN_HEIGHT <= 568)

#define MLT_1PX (1.0f / [UIScreen mainScreen].scale)

#define MLTScreenScale SCREEN_WIDTH / 375.f

#define MLTScaleWidth(s) ScreenScale * (s)

#define MLTScaleHeight(s) ScreenScale * (s)

// 根据iphone6标注的尺寸来计算宽高
#define kpixelToFrame(pixel) ScaleHeight((pixel)/2.f)

#define pixelValue(s) ([[UIScreen mainScreen] scale] > 0.0 ? 1.0 / [[UIScreen mainScreen] scale] : 1.0) * (s)

#pragma mark --- System

#define IS_IPHONE   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define IS_IPAD     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define SYSTEM_VERSION        [[[UIDevice currentDevice] systemVersion] floatValue]

#define IOS_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define IOS_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IOS_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define IOS_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_IOS7_OR_LATER               (SYSTEM_VERSION >= 7.0)

#define IS_IOS8_OR_LATER               (SYSTEM_VERSION >= 8.0)

#define IS_IOS9_OR_LATER               (SYSTEM_VERSION >= 9.0)

#define IS_IOS10_OR_LATER              (SYSTEM_VERSION >= 10.0)

#pragma mark --- Position

#define VIEW_LEFT(view)   (view.frame.origin.x)

#define VIEW_TOP(view)    (view.frame.origin.y)

#define VIEW_WIDTH(view)  (view.frame.size.width)

#define VIEW_HEIGHT(view) (view.frame.size.height)

#define VIEW_RIGHT(view)  (view.frame.origin.x + view.frame.size.width)

#define VIEW_BOTTOM(view) (view.frame.origin.y + view.frame.size.height)

#pragma mark --- Frame

#define FRAME_X(frame)    (frame.origin.x)

#define FRAME_Y(frame)    (frame.origin.y)

#define FRAME_W(frame)    (frame.size.width)

#define FRAME_H(frame)    (frame.size.height)

#pragma mark --- Font & Color

#define FONT(s)          [UIFont systemFontOfSize:s]

#define BOLD_FONT(s)     [UIFont boldSystemFontOfSize:s]

#define RGB(r,g,b)       RGBA(r,g,b,1)

#define RGBA(r,g,b,a)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

#define HEX(hex)        [UIColor colorWithHexString:hex]

// example usage: ColorFromHex(0x9daa76)
#define ColorFromHex(hexValue)            ColorFromHexWithAlpha(hexValue,1.0)

#define ColorFromHexWithAlpha(hexValue,a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]

#define RandomColor      [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

#define ClearColor       [UIColor clearColor]

#pragma mark --- Image

#define ImageName(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

#pragma mark - View Related

// 底部线
#define AddBottomLine(toView, lineName, colorString) { \
UIView *lineName = [UIView new]; \
lineName.backgroundColor = [UIColor mlt_colorWithHexString:colorString alpha:1]; \
[toView addSubview:lineName]; \
[lineName mas_makeConstraints:^(MASConstraintMaker *make) { \
make.left.bottom.and.right.with.insets(UIEdgeInsetsMake(0, 0, 0, 0)); \
make.height.mas_equalTo(@(.5));\
}]; \
}

// 底部线(含margen)
#define AddBottomLineWithMargen(toView, lineName, colorString, margenLeft, margenRight) { \
UIView *lineName = [UIView new]; \
lineName.backgroundColor = [UIColor mlt_colorWithHexString:colorString alpha:1]; \
[toView addSubview:lineName]; \
[lineName mas_makeConstraints:^(MASConstraintMaker *make) { \
make.left.bottom.and.right.with.insets(UIEdgeInsetsMake(0, margenLeft, 0, margenRight)); \
make.height.mas_equalTo(@(.5));\
}]; \
}

#endif /* MLTUIMacros_h */


