//
//  BTMeEntity.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTMeEntity.h"

@implementation BTMeEntity


+ (BTMeEntity *)shareSingleton {
    
    static BTMeEntity *tManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (tManager == nil) {
            tManager = [[BTMeEntity alloc] init];
        }
    });
    
    return tManager;
}


//- (instancetype)init {
//    
//    self = [super init];
//    
//    if (self) {
//        
////        LEMeUserEntity *userModel = [LEMeUserEntity keyedUnarchiver:@"SaveUserEntity"  path:kSaveUserEntityPath];
////        
////        self.userName = !userModel.userName ? @"":userModel.userName;
////        
////        self.userId = !userModel.userId ? @"":userModel.userId;
////        
////        self.userSex = !userModel.userSex ? @"":userModel.userSex;
////        
////        self.userDescribe = !userModel.userDescribe?@"":userModel.userDescribe;
////        
////        self.avatarUrl = !userModel.avatarUrl ? @"":userModel.avatarUrl;
////        
////        self.userPhone= !userModel.userPhone ? @"":userModel.userPhone;
////        
////        self.userSign= !userModel.userSign ? @"":userModel.userSign;
////        
////        self.isLogin = userModel.userId.length > 0 ? 1 : 0;
//    }
//    return self;
//}
//
//- (void)manageLoginData{
//    
////    LEMeUserEntity *userModel = [LEMeUserEntity keyedUnarchiver:@"SaveUserEntity"  path:kSaveUserEntityPath];
////    
////    self.userName = !userModel.userName ? @"":userModel.userName;
////    
////    self.userId = !userModel.userId ? @"":userModel.userId;
////    
////    self.userSex = !userModel.userSex ? @"":userModel.userSex;
////    
////    self.userDescribe = !userModel.userDescribe?@"":userModel.userDescribe;
////    
////    self.avatarUrl = !userModel.avatarUrl ? @"":userModel.avatarUrl;
////    
////    self.userPhone= !userModel.userPhone ? @"":userModel.userPhone;
////    
////    self.userSign= !userModel.userSign ? @"":userModel.userSign;
////    
////    self.isLogin = userModel.userId.length > 0 ? 1 : 0;
////    
////    // 登录成功 发通知
////    if (self.isLogin) {
////        [[NSNotificationCenter defaultCenter] postNotificationName:LeTVLoginSDKUserDidLoginNotification object:nil];
////    }
//}
//
//- (void)logout{
//    
//    NSError * error = nil;
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    NSString *thirdLogin = [defaults valueForKey:@"thirdLogins"];
//    
//    switch ([thirdLogin integerValue]) {
//        case 1:
//            [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
//            break;
//        case 2:
//            [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ];
//            break;
//        case 3:
//            [ShareSDK cancelAuthorize:SSDKPlatformTypeSinaWeibo];
//            break;
//        default:
//            break;
//    }
//    
//    if ([[NSFileManager defaultManager] fileExistsAtPath:kSaveUserEntityPath]) {
//        
//        [[NSFileManager defaultManager]removeItemAtPath:kSaveUserEntityPath error:&error];//删除
//        
//        [self manageLoginData];
//        
//        // 退出登录成功 发通知
//        [[NSNotificationCenter defaultCenter] postNotificationName:LeTVLoginSDKUserDidLogoutNotification object:nil];
//        
//    }
//    
//}
//
//
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    NSLog(@"调用了initWithCoder方法");
//    if (self = [super init]) {
//        self.userName = [aDecoder decodeObjectForKey:@"nickName"];
//        self.userId = [aDecoder decodeObjectForKey:@"uid"];
//        self.userSex = [aDecoder decodeObjectForKey:@"sex"];
//        self.userDescribe = [aDecoder decodeObjectForKey:@"intro"];
//        self.avatarUrl = [aDecoder decodeObjectForKey:@"avatar"];
//        self.userPhone = [aDecoder decodeObjectForKey:@"phone"];
//        self.userSign = [aDecoder decodeObjectForKey:@"sign"];
//        self.isLogin = [aDecoder decodeObjectForKey:@"isLogin"];
//        
//    }
//    
//    return self;
//}
//
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    NSLog(@"调用了encodeWithCoder方法");
//    [aCoder encodeObject:self.userName forKey:@"nickName"];
//    [aCoder encodeObject:self.userId forKey:@"uid"];
//    [aCoder encodeObject:self.avatarUrl forKey:@"avatar"];
//    [aCoder encodeObject:self.userDescribe forKey:@"intro"];
//    [aCoder encodeObject:self.userSex forKey:@"sex"];
//    [aCoder encodeObject:self.userPhone forKey:@"phone"];
//    [aCoder encodeObject:self.userSign forKey:@"sign"];
//    [aCoder encodeBool:self.isLogin forKey:@"isLogin"];
//    
//}

@end
