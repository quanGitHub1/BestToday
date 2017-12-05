//
//  Macros.h
//  Finance
//
//  Created by 周洪静 on 2017/4/17.
//  Copyright © 2017年 luluzhi. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#pragma mark - System Related

/**
 * Creates \c __weak shadow variables for each of the variables provided as
 * arguments, which can later be made strong again with #strongify.
 *
 * This is typically used to weakly reference variables in a block, but then
 * ensure that the variables stay alive during the actual execution of the block
 * (if they were live upon entry).
 *
 * See #strongify for an example of usage.
 */
#define weakify(...) \
ext_keywordify \
metamacro_foreach_cxt(ext_weakify_,, __weak, __VA_ARGS__)

/**
 * Like #weakify, but uses \c __unsafe_unretained instead, for targets or
 * classes that do not support weak references.
 */
#define unsafeify(...) \
ext_keywordify \
metamacro_foreach_cxt(ext_weakify_,, __unsafe_unretained, __VA_ARGS__)

/**
 * Strongly references each of the variables provided as arguments, which must
 * have previously been passed to #weakify.
 *
 * The strong references created will shadow the original variable names, such
 * that the original names can be used without issue (and a significantly
 * reduced risk of retain cycles) in the current scope.
 *
 * @code
 
 id foo = [[NSObject alloc] init];
 id bar = [[NSObject alloc] init];
 
 @weakify(foo, bar);
 
 // this block will not keep 'foo' or 'bar' alive
 BOOL (^matchesFooOrBar)(id) = ^ BOOL (id obj){
 // but now, upon entry, 'foo' and 'bar' will stay alive until the block has
 // finished executing
 @strongify(foo, bar);
 
 return [foo isEqual:obj] || [bar isEqual:obj];
 };
 
 * @endcode
 */
#define strongify(...) \
ext_keywordify \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
metamacro_foreach(ext_strongify_,, __VA_ARGS__) \
_Pragma("clang diagnostic pop")

#define ext_weakify_(INDEX, CONTEXT, VAR) \
CONTEXT __typeof__(VAR) metamacro_concat(VAR, _weak_) = (VAR);

#define ext_strongify_(INDEX, VAR) \
__strong __typeof__(VAR) VAR = metamacro_concat(VAR, _weak_);

// Details about the choice of backing keyword:
//
// The use of @try/@catch/@finally can cause the compiler to suppress
// return-type warnings.
// The use of @autoreleasepool {} is not optimized away by the compiler,
// resulting in superfluous creation of autorelease pools.
//
// Since neither option is perfect, and with no other alternatives, the
// compromise is to use @autorelease in DEBUG builds to maintain compiler
// analysis, and to use @try/@catch otherwise to avoid insertion of unnecessary
// autorelease pools.
#if DEBUG
#define ext_keywordify autoreleasepool {}
#else
#define ext_keywordify try {} @catch (...) {}
#endif

/******************************缺省*****************************/
#define kDefaultValue @"— — — —"
#define kDefaultVauleLitte @"- - - -"
#define kDefaultStockTitleDetailValue @"- -"
/******************************颜色*****************************/

/******************************颜色*****************************/
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


#define kNetErrorDesc @"刷新失败"


#ifndef kTitleColStr
#define kTitleColStr     @"#222222"//标题颜色
#endif
#ifndef kExcerptColStr
#define kExcerptColStr     @"#757575"//标题颜色
#endif
#ifndef kSourceColStr
#define kSourceColStr     @"#9E9E9E"//标题颜色
#endif
#ifndef kLineColStr
#define kLineColStr     @"#E5E5E5"//标题颜色
#endif
#ifndef kCardBackColStr
#define kCardBackColStr     @"#F2F2F2"//标题颜色
#endif
#ifndef kRedColStr
#define kRedColStr     @"#E53935"//标题颜色
#endif
#ifndef kGreenColStr
#define kGreenColStr     @"#FF9800"//标题颜色
#endif
#ifndef kClickColStr
#define kCLickColStr     @"#1194F6"//标题颜色
#endif
#ifndef kTopicColStr
#define kTopicColStr     @"#FFB400"//标题颜色
#endif

#ifndef kBlueTextCol
#define kBlueTextCol     [UIColor colorWithHexString:@"#0086F9"]// 蓝色字体颜色
#endif

#ifndef kLoginBottomColor
#define kLoginBottomColor     [UIColor colorWithHexString:@"#F3F5FA"]
#endif


#ifndef kTitleColor
#define kTitleColor     [UIColor colorWithHexString:@"#212121"]//标题颜色
#endif

#ifndef kExcerptColor
#define kExcerptColor     [UIColor colorWithHexString:@"#7B7B7B"]//摘要

#define kExcerptColorGreen     [UIColor colorWithHexString:@"#D8D8D8"]//摘要

#endif

#ifndef kSourceColor
#define kSourceColor     [UIColor colorWithHexString:@"#9E9E9E"]//来源、时间
#endif

#ifndef kLineColor
#define kLineColor     [UIColor colorWithHexString:@"#EEEEEE"]//分割线
#endif

#ifndef kCardBackColor
#define kCardBackColor     [UIColor colorWithHexString:@"#F2F2F2"]//卡片背景分段颜色
#endif

#ifndef kRedColor
#define kRedColor     [UIColor colorWithHexString:@"#F7412D"]//大盘红色
#define kRedColorOne     [UIColor colorWithHexString:@"#FD0029"]//大盘红色

#endif

#ifndef kGreenColor
#define kGreenColor     [UIColor colorWithHexString:@"#4CAF50"]//大盘绿色
#define kGreenColorOne     [UIColor colorWithHexString:@"#1BC468"]//大盘绿色

#endif

#ifndef kClickColor
#define kClickColor     [UIColor colorWithHexString:@"#2f81e0"]//点击、链接色
#endif

#ifndef kTopicColor
#define kTopicColor     [UIColor colorWithHexString:@"#ff9800"]//专题、提示色
#endif

// 字体
#define Font(x) [UIFont systemFontOfSize:x*FIT_750_WIDTH]
#define BFont(x) [UIFont boldSystemFontOfSize:x*FIT_750_WIDTH]

// 系统版本
#define SYSTEM_VERSION        [[[UIDevice currentDevice] systemVersion] floatValue]

// 是否 iOS 7 以上
#define IS_IOS7               (SYSTEM_VERSION >= 7)

// 是否3.5寸屏
#define IS_IPHONE4            (SCREEN_HEIGHT == 480)

// 是否4寸屏
#define IS_IPHONE5            (SCREEN_HEIGHT == 568)

// 是否4.7寸屏
#define IS_IPHONE6            (SCREEN_HEIGHT == 667)

// 是否5.5寸屏
//#define IS_IPHONE6P           (SCREEN_HEIGHT > 667)

#pragma mark - Size Related

#define MLTDefaultStatusBarHeight (20)

#define MLTDefaultNavBarHeight (44)

#define MLTDefaultTabBarHeight (49)

#define MLTNAVBAR_HEIGHT     44.0

#define MLTTABBAR_HEIGHT     49.0

#define MLTFULLNAVBAR_HEIGHT 70.0

// 屏幕高度
#define SCREEN_HEIGHT    [[UIScreen mainScreen] bounds].size.height

// 屏幕宽度
#define SCREEN_WIDTH     [[UIScreen mainScreen] bounds].size.width

// X坐标
#define LineX(l) l*FIT_750_WIDTH
// Y坐标
#define LineY(l) l*FIT_750_HEIGHT


// 应用宽度
#define FULL_WIDTH   SCREEN_WIDTH

// 应用高度
#define FULL_HEIGHT  (SCREEN_HEIGHT - ((SYSTEM_VERSION >= 7) ? 0 : STATUSBAR_HEIGHT))

// 状态栏高度
#define STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

// 导航栏高度
#define NAVBAR_HEIGHT         (44.f + ((SYSTEM_VERSION >= 7) ? STATUSBAR_HEIGHT : 0))

// 内容高度
#define CONTENT_HEIGHT        (FULL_HEIGHT - NAVBAR_HEIGHT)

// 内容部分的 frame
#define CONTENT_VIEW_FRAME    CGRectMake(0, NAVBAR_HEIGHT, FULL_WIDTH, CONTENT_HEIGHT)

// app 的frame
#define FULL_VIEW_FRAME       CGRectMake(0, 0, FULL_WIDTH, FULL_HEIGHT)

// Tab bar 高度
#define TAB_HEIGHT   49

#define ScreenScale SCREEN_WIDTH / 375.f

#define ScaleWidth(s) ScreenScale * (s)

#define ScaleHeight(s) ScreenScale * (s)

#define ScaleFont(s) ScreenScale * (s)

#define kScreenScaleHeight(s) ((SCREEN_WIDTH/375.f) * (s))

#define kAlertWidth 260

#define kAlertHeight 180

//等比缩放图片尺寸，比屏幕宽，放大高度，缩小宽度，比屏幕窄，放大宽度
#define kSizeScale(w,h) (SCREEN_WIDTH/w) * h

#pragma mark - Font Related

// 系统字体
#define FONT(s)          [UIFont systemFontOfSize:s]

// 系统粗体
#define BOLD_FONT(s)     [UIFont boldSystemFontOfSize:s]

#define RUDEFONT(s)      [UIFont boldSystemFontOfSize:s]

#define THINFONT(s)      [UIFont systemFontOfSize:s]

#define TEXTCOLOR(s)     [UIColor colorWithHexString:s]

#define HEX(hex)        [UIColor colorWithHexString:hex]


#define RGBA(r,g,b,a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

#define RGB(r,g,b)      RGBA(r,g,b,1)

// 导航栏字体大小
#define NAVBAR_FONT_SIZE          BOLD_FONT(16)

// tab、card功能模块标题、商品详情页文字字体大小
#define CUSTOM_TABBAR_TITLE_FONT_SIZE    BOLD_FONT(15)

// 主要信息用户名字体大小
#define MAIN_UAER_NAME_FONT_SIZE  BOLD_FONT(14)

// 描述文字、正文、链接商品描述字体大小
#define MAIN_BODY_FONT_SIZE       FONT(13)

// 收藏关注等按钮字体大小
#define BUTTON_ATTEND_FONT_SIZE   FONT(13)

// 评价相关字体大小
#define COMMENT_FONT_SIZE   FONT(13)

// 晒单和商品页卡描述文字 晒单评论 晒单运营标签
#define ORDER_SHARE_FONT_SIZE   FONT(12)

// 辅助文字、时间、粉丝、销量、等次要文字 小型标签文字 晒单页卡用户名字体大小
#define SUB_BODY_FONT_SIZE   FONT(11)

// 底部Tab字体大小
#define TAB_FONT_SIZE   FONT(11)

// 金额相关字体大小
#define PRICE_SECKILL_TITLE_FONT_SIZE           BOLD_FONT(18)
#define PRICE_SECKILL_SUBTITLE_FONT_SIZE        FONT(12)

#define PRICE_GOODS_DETAIL_TITLE_FONT_SIZE      BOLD_FONT(18)
#define PRICE_GOODS_DETAIL_SUBTITLE_FONT_SIZE   FONT(10)

#define PRICE_GOODS_LIST_TITLE_FONT_SIZE      FONT(12)
#define PRICE_GOODS_LIST_SUBTITLE_FONT_SIZE   FONT(10)


#pragma mark - Color Related

#define UIColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define AMColorRed                      [UIColor colorWithRed:255.0/255 green:89.0/255 blue:82.0/255 alpha:1.0]

#define AMColorWhite                    [UIColor whiteColor]

#define AMLabelColor                    UIColorFromHex(0xF5F0ED)

#define AMColorButton                   UIColorFromHex(0xfa565a)

#define AMColorBackground               [UIColor whiteColor]

// 导航栏字体颜色
#define NAVBAR_TITLE_COLOR    [UIColor colorWithHexString:@"#0d0d0d" alpha:1]

// tab、card功能模块标题、商品详情页文字字体颜色
#define CUSTOM_TABBAR_TITLE_NORMAL_COLOR        UIColorFromHex(0x333333)
#define CUSTOM_TABBAR_TITLE_HIGHLIGHT_COLOR     UIColorFromHex(0xfa565a)

// 主要信息用户名字体颜色
#define MAIN_UAER_NAME_NORMAL_COLOR      UIColorFromHex(0x333333)

// 描述文字、正文、链接商品描述字体颜色
#define MAIN_BODY_NORMAL_COLOR           UIColorFromHex(0x4d4d4d)
#define MAIN_BODY_HIGHLIGHT_COLOR        UIColorFromHex(0xfa565a)

// 收藏关注等按钮字体颜色
#define BUTTON_ATTEND_NORMAL_COLOR       UIColorFromHex(0x999999)
#define BUTTON_ATTEND_HIGHLIGHT_COLOR    UIColorFromHex(0xfa565a)

// 评价相关
#define COMMENT_BODY_NORMAL_COLOR        UIColorFromHex(0x666666)
#define COMMENT_BODY_HIGHLIGHT_COLOR     UIColorFromHex(0xfa565a)
#define COMMENT_NAME_COLOR               UIColorFromHex(0x999999)

// 晒单和商品页卡描述文字 晒单评论 晒单运营标签
#define ORDER_SHARE_DES                     UIColorFromHex(0x4d4d4d)
#define ORDER_SHARE_COMMENT_NORMAL_COLOR    UIColorFromHex(0x666666)
#define ORDER_SHARE_COMMENT_HILIGHT_COLOR   UIColorFromHex(0xfa565a)
#define ORDER_SHARE_NAME_COLOR              UIColorFromHex(0x999999)
#define ORDER_SHARE_LABEL_COLOR             UIColorFromHex(0xfa565a)

// 辅助文字、时间、粉丝、销量、等次要文字 小型标签文字 晒单页卡用户名
#define SUB_BODY_NORMAL_COLOR            UIColorFromHex(0x999999)
#define SUB_BODY_HIGHLIGHT_COLOR         UIColorFromHex(0xfa565a)


// 底部Tab
#define TAB_NORMAL_COLOR      UIColorFromHex(0x666666)
#define TAB_HIGHLIGHT_COLOR   UIColorFromHex(0xfa565a)

// 金额相关
#define PRICE_SECKILL_TITLE_COLOR           UIColorFromHex(0xfa565a)
#define PRICE_SECKILL_SUBTITLE_COLOR        UIColorFromHex(0x999999)

#define PRICE_GOODS_DETAIL_TITLE_COLOR      UIColorFromHex(0xfa565a)
#define PRICE_GOODS_DETAIL_SUBTITLE_COLOR   UIColorFromHex(0x999999)

#define PRICE_GOODS_LIST_TITLE_COLOR        UIColorFromHex(0xfa565a)
#define PRICE_GOODS_LIST_SUBTITLE_COLOR     UIColorFromHex(0x999999)


#define MLTCachesPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define MLTSpotlightCachePath [MLTCachesPath stringByAppendingPathComponent:@"spot_light_ios.txt"]


#define LEFineSearchCachePath [MLTCachesPath stringByAppendingPathComponent:@"LEFine_Search_ios.txt"]

// 列表背景色
#define kDefaultBackgroundColorArray @[@"#b2bcc6",@"#c89d56",@"#7c82a0",@"#9194a4",@"#57585b",@"#7b9196",@"#7ca099",@"#aea19f",@"#c79e91",@"#526a62",@"#bb745c",@"#9caab8",@"#728477",@"#826f78",@"#576579",@"#8b80a1",@"#695267",@"#525b69",@"#706f64",@"#747989"]


//在6上面的标准
#define kSixTopMargin 68.f
#define kSixBottomMargin 125.f
#define kSixCrileTopMargin 140

#define kFourHeight 480.f
#define kFiveHeight 568.f
#define kSixHeight 667.f
#define kSixPHeight 736.f


#pragma mark - 方法

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"

#define CHATVIEWBACKGROUNDCOLOR [UIColor colorWithRed:0.936 green:0.932 blue:0.907 alpha:1]

#define MQColor(r,g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


// System Compare
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IOS_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define IOS_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IOS_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define IOS_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IsEmptyArray(array) (!array || [array count]==0)

#define IsEmptyDictionary(dict) (!dict || [[dict allKeys] count]==0)

#define IsKindOfClass(_object, _class) [_object isKindOfClass:[_class class]]

#define isValidKey(key) ((key) != nil && ![key isKindOfClass:[NSNull class]])

#define isValidValue(value) (((value) != nil) && ![value isKindOfClass:[NSNull class]])

/******************************缺省*****************************/
#define kDefaultValue @"— — — —"
#define kDefaultVauleLitte @"- - - -"

/******************************颜色*****************************/
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//#ifndef kUpTitleColor
//#define kUpTitleColor   UserDefaultObjectForKey(kUpTitleColorKey)
//#endif
#ifndef kTitleColStr
#define kTitleColStr     @"#222222"//标题颜色
#endif
#ifndef kExcerptColStr
#define kExcerptColStr     @"#757575"//标题颜色
#endif
#ifndef kSourceColStr
#define kSourceColStr     @"#9E9E9E"//标题颜色
#endif
#ifndef kLineColStr
#define kLineColStr     @"#E5E5E5"//标题颜色
#endif
#ifndef kCardBackColStr
#define kCardBackColStr     @"#F2F2F2"//标题颜色
#endif
#ifndef kRedColStr
#define kRedColStr     @"#E53935"//标题颜色
#endif
#ifndef kGreenColStr
#define kGreenColStr     @"#FF9800"//标题颜色
#endif
#ifndef kClickColStr
#define kCLickColStr     @"#1194F6"//标题颜色
#endif
#ifndef kTopicColStr
#define kTopicColStr     @"#FFB400"//标题颜色
#endif

#ifndef kDefaultColor
#define kDefaultColor     [UIColor colorWithHexString:@"#ECECEC"]//默认
#endif

#ifndef kTitleColor
#define kTitleColor     [UIColor colorWithHexString:@"#222222"]//标题颜色
#endif

#ifndef kExcerptColor
#define kExcerptColor     [UIColor colorWithHexString:@"#757575"]//摘要
#endif

#ifndef kSourceColor
#define kSourceColor     [UIColor colorWithHexString:@"#9E9E9E"]//来源、时间
#endif

#ifndef kLineColor
#define kLineColor     [UIColor colorWithHexString:@"#E5E5E5"]//分割线
#endif

#ifndef kCardBackColor
#define kCardBackColor     [UIColor colorWithHexString:@"#F2F2F2"]//卡片背景分段颜色
#endif

#ifndef kRedColor
#define kRedColor     [UIColor colorWithHexString:@"#f7412d"]//大盘红色
#endif

#ifndef kGreenColor
#define kGreenColor     [UIColor colorWithHexString:@"#4caf50"]//大盘绿色
#endif

#ifndef kClickColor
#define kClickColor     [UIColor colorWithHexString:@"#2f81e0"]//点击、链接色
#endif

#ifndef kTopicColor
#define kTopicColor     [UIColor colorWithHexString:@"#ff9800"]//专题、提示色
#endif
/******************************调试*****************************/
#ifdef DEBUG

#define LSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])

#else

#define LSLog(...)

#endif

/******************************文件宏*****************************/
#define kShareURLPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"kShareURLPath"]

#define kSaveUserModelPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"kSaveUserModelPath"]

//#define kSaveUserAmountModelPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"kSaveUserAmountModelPath"]
#define kSaveUserAmountModelPatha(a) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent: [@"kSaveUserAmountModelPath" stringByAppendingString:[NSString stringWithFormat:@"%@",a]]]
#define kShareURLKey @"kShareURLKey"


#define kSaveUserEntityPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"kSaveUserEntityPath"]

/******************************系统*****************************/
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 [UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO

#define iPhone6plus [UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size)) : NO


/** 是否为iOS6 */
#define iOS6 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) ? YES : NO)

/** 是否为iOS7 */
#define iOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES : NO)

/** 是否为iOS8 */
#define iOS8 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? YES : NO)

/** 是否为iOS9 */
#define iOS9 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) ? YES : NO)

#define iOS10 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) ? YES : NO)

/****************************** UI *****************************/
#define kSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define FIT_750_HEIGHT (kSCREEN_HEIGHT/667.0)
#define FIT_750_WIDTH (kSCREEN_WIDTH/375.0)

#define AppWindow [[[UIApplication sharedApplication] delegate] window]

#define kNavigationBarHight 70
#define kTabBarHeight 49
#define KLoginBottomHeight 44*FIT_750_HEIGHT
#define Limit 20

#define kMajornewsVeidoH LineY(210)
#define kMajornewsVeidoNextH 50
//#define kMajornewsImageH 176
#define kMajornewsImageH 197.4

/******************************网络宏*****************************/
#ifndef kIsNetwork
#define kIsNetwork     [NetworkHelper isNetwork]  // 一次性判断是否有网的宏
#endif

#ifndef kIsWWANNetwork
#define kIsWWANNetwork [NetworkHelper isWWANNetwork]  // 一次性判断是否为手机网络的宏
#endif

#ifndef kIsWiFiNetwork
#define kIsWiFiNetwork [NetworkHelper isWiFiNetwork]  // 一次性判断是否为WiFi网络的宏
#endif

/******************************工具宏*****************************/
/**
 *  the saving objects      存储对象
 *
 *  @param __VALUE__ V
 *  @param __KEY__   K
 *
 *  @return
 */
#define UserDefaultSetObjectForKey(__VALUE__,__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

/**
 *  get the saved objects       获得存储的对象
 */
#define UserDefaultObjectForKey(__KEY__)  [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]

/**
 *  delete objects      删除对象
 */
#define UserDefaultRemoveObjectForKey(__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

#define WeakObj(o) __weak typeof(o) o##Weak = o;
#define StrongObj(o) __strong typeof(o) o##Strong = o;

#endif /* Macros_h */


