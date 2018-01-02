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

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        BTMeEntity *userModel = [BTMeEntity keyedUnarchiver:@"SaveUserEntity"  path:kSaveUserEntityPath];
        
        self.nickName = !userModel.nickName ? @"":userModel.nickName;
        self.csessionId = !userModel.csessionId ? @"":userModel.csessionId;

        self.userId = !userModel.userId ? @"":userModel.userId;
        
        self.gender = !userModel.gender ? @"":userModel.gender;
        self.introduction = !userModel.introduction?@"":userModel.introduction;
        
        self.avatarUrl = !userModel.avatarUrl ? @"":userModel.avatarUrl;
        self.country = !userModel.country ? @"":userModel.country;
        
        self.isLogin = userModel.userId.length > 0 ? 1 : 0;
    }
    return self;
}

- (void)manageLoginData{
    
    BTMeEntity *userModel = [BTMeEntity keyedUnarchiver:@"SaveUserEntity"  path:kSaveUserEntityPath];
    
    self.nickName = !userModel.nickName ? @"":userModel.nickName;
    
    self.csessionId = !userModel.csessionId ? @"":userModel.csessionId;
    
    self.userId = !userModel.userId ? @"":userModel.userId;
    
    self.gender = !userModel.gender ? @"":userModel.gender;
    
    self.introduction = !userModel.introduction?@"":userModel.introduction;
    
    self.avatarUrl = !userModel.avatarUrl ? @"":userModel.avatarUrl;
    
    self.country = !userModel.country ? @"":userModel.country;
    
    self.isLogin = userModel.userId.length > 0 ? 1 : 0;
    
    // 登录成功 发通知
    if (self.isLogin) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSDKUserDidLoginNotification" object:nil];
    }
}

- (void)logout{
    
    NSError * error = nil;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:kSaveUserEntityPath]) {
        
        [[NSFileManager defaultManager]removeItemAtPath:kSaveUserEntityPath error:&error];//删除
        
        [self manageLoginData];
        
        // 退出登录成功 发通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSDKUserDidLogoutNotification" object:nil];
        
    }
    
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"调用了initWithCoder方法");
    if (self = [super init]) {
        self.nickName = [aDecoder decodeObjectForKey:@"nickName"];
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.csessionId = [aDecoder decodeObjectForKey:@"ionId"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.introduction = [aDecoder decodeObjectForKey:@"introduction"];
        self.avatarUrl = [aDecoder decodeObjectForKey:@"avatarUrl"];
        self.country = [aDecoder decodeObjectForKey:@"country"];
        self.isLogin = [aDecoder decodeObjectForKey:@"isLogin"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    NSLog(@"调用了encodeWithCoder方法");
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.csessionId forKey:@"ionId"];
    [aCoder encodeObject:self.avatarUrl forKey:@"avatar"];
    [aCoder encodeObject:self.introduction forKey:@"introduction"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.country forKey:@"country"];
    [aCoder encodeBool:self.isLogin forKey:@"isLogin"];
}

@end
