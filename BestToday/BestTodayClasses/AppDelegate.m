//
//  AppDelegate.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "AppDelegate.h"
#import "MLTUISkeletonModule.h"
#import "WXApiManager.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
//微信SDK头文件
#import "WXApi.h"

#import <UMSocialCore/UMSocialCore.h>

#import "BTMeService.h"
#import "BTMeEntity.h"
#import "UMessage.h"
#import "UMMobClick/MobClick.h"
#import "MLTTabBarController.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<UNUserNotificationCenterDelegate,UIAlertViewDelegate>
{
    NSDictionary * messageDic;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    messageDic = [NSDictionary dictionary];
//    [self requestqueryUserById];
    [self shareSDKConfiguration];
    // 友盟统计
    UMConfigInstance.appKey = @"5a2ff4eeb27b0a39e7000513";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    // 友盟推送
    [UMessage startWithAppkey:@"5a2ff4eeb27b0a39e7000513" launchOptions:launchOptions httpsEnable:YES];
    [UMessage registerForRemoteNotifications];
    if ([[[UIDevice currentDevice] systemVersion]intValue]>=10) {
        //iOS10必须加下面这段代码。
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate=self;
        UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
        [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                //点击允许
                //这里可以添加一些自己的逻辑
            } else {
                //点击不允许
                //这里可以添加一些自己的逻辑
            }
        }];
        
    }
    [UMessage setLogEnabled:YES];
//    //向微信注册
    [WXApi registerApp:@"wx8910bc5d166f699a" enableMTA:YES];
    //向微信注册支持的文件类型
    UInt64 typeFlag = MMAPP_SUPPORT_TEXT | MMAPP_SUPPORT_PICTURE | MMAPP_SUPPORT_LOCATION | MMAPP_SUPPORT_VIDEO |MMAPP_SUPPORT_AUDIO | MMAPP_SUPPORT_WEBPAGE | MMAPP_SUPPORT_DOC | MMAPP_SUPPORT_DOCX | MMAPP_SUPPORT_PPT | MMAPP_SUPPORT_PPTX | MMAPP_SUPPORT_XLS | MMAPP_SUPPORT_XLSX | MMAPP_SUPPORT_PDF;
    
    [WXApi registerAppSupportContentFlag:typeFlag];
    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5a2ff4eeb27b0a39e7000513"];

    [self configUSharePlatforms];
    
    [MLTUISkeletonModule shareInstance];

    return YES;
}

//- (void)requestqueryUserById{
//
//    BTMeService *meService = [BTMeService new];
//
//     [meService loadqueryUserById:[[BTMeEntity shareSingleton].userId integerValue] completion:^
//       (BOOL isSuccess, BOOL isCache){
//
//           // APP入口
//           [MLTUISkeletonModule shareInstance];
//
//
//    }];
//
//}


- (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx8910bc5d166f699a" appSecret:@"9743c6757c2d1cdac5a94b179b7b597d" redirectURL:nil];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106178838"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];

}

- (void)shareSDKConfiguration{
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    
     [ShareSDK registerApp:@"fa65adc6ddd4" activePlatforms:@[@(SSDKPlatformTypeWechat),@(SSDKPlatformSubTypeWechatSession),@(SSDKPlatformSubTypeWechatTimeline)] onImport:^(SSDKPlatformType platformType) {
        
        switch (platformType) {
            case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
                
            case SSDKPlatformTypeSinaWeibo:
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
                
            case SSDKPlatformTypeQQ:
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                break;
            default:
                break;
        }
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType) {
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:@"wx8910bc5d166f699a" appSecret:@"9743c6757c2d1cdac5a94b179b7b597d"];
                break;
            case SSDKPlatformTypeSinaWeibo:
                [appInfo SSDKSetupSinaWeiboByAppKey:@"1123281695" appSecret:@"bd9311337ee8647c4150e1ef48ec47e4" redirectUri:@"http://www.lefinance.com" authType:SSDKAuthTypeBoth];
                break;
            case SSDKPlatformTypeQQ:
                //                [appInfo SSDKSetupQQByAppId:@"1106046073" appKey:@"52PDysMqYo2KUz2V" authType:SSDKAuthTypeBoth];
                [appInfo SSDKSetupQQByAppId:@"1106178838" appKey:@"IjpQ03fxWU21ryAJ" authType:SSDKAuthTypeBoth];
                
                break;
            default:
                break;
        }
    }];

}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];

}

// 获得Device Token
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                  stringByReplacingOccurrencesOfString: @">" withString: @""]
                 stringByReplacingOccurrencesOfString: @" " withString: @""]);
    self.deviceToken = [NSString stringWithFormat:@"%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                                          stringByReplacingOccurrencesOfString: @">" withString: @""]
                                                         stringByReplacingOccurrencesOfString: @" " withString: @""]];

}
// 获得Device Token失败
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    self.deviceToken = @"";
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"%@",userInfo);
    [UMessage setAutoAlert:NO];

    [UMessage didReceiveRemoteNotification:userInfo];
    [self alertNotificationMessage:userInfo];
    //关闭U-Push自带的弹出框
        //定制自定的的弹出框
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        UINavigationController *navC = (UINavigationController *)AppWindow.rootViewController;
        MLTTabBarController *tabBarVC = navC.viewControllers[0];
        [tabBarVC selectAtIndex:3];
        [[MLTUISkeletonModule shareInstance].collectionViewController notificationIsAlert:messageDic[@"jumpUrl"]];
    }
}


- (void)alertNotificationMessage:(NSDictionary *)userInfo{
    NSDictionary * dic = userInfo[@"payload"];
    NSDictionary *alertDic = dic[@"aps"];
    NSString * alertString = alertDic[@"alert"];
    messageDic = dic[@"customData"];
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知"
                                                            message:alertString
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        
        [alertView show];
    }else{
        UINavigationController *navC = (UINavigationController *)AppWindow.rootViewController;
        MLTTabBarController *tabBarVC = navC.viewControllers[0];
        [tabBarVC selectAtIndex:3];
        [[MLTUISkeletonModule shareInstance].collectionViewController notificationIsAlert:messageDic[@"jumpUrl"]];

    }
}


//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:NO];
        //应用处于前台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        [self alertNotificationMessage:userInfo];

        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:[NSString stringWithFormat:@"%@",userInfo] forKey:@"UMPuserInfoNotification"];
        
    }else{
        //应用处于前台时的本地推送接受
    }
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        [self alertNotificationMessage:userInfo];

        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:[NSString stringWithFormat:@"%@",userInfo] forKey:@"UMPuserInfoNotification"];
        
    }else{
        //应用处于后台时的本地推送接受
    }
    
}



@end
