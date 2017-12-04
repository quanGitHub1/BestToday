//
//  BTMeEntity.h
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 用户状态更新
 */
typedef enum {
    BTUserStatusLogout = 0, //登出状态
    BTUserStatusLogin = 1, //登录状态
} BTUserStatus;


@interface BTMeEntity : NSObject

@property (nonatomic, strong) NSString *userId;  // 用户ID

@property (nonatomic, strong) NSString *nickName;  // 用户昵称

@property (nonatomic, strong) NSString *avatarUrl;  // 用户头像url

@property (nonatomic, strong) NSString *jumpType;  // 点击跳转类型，1:跳转到个人主页，2:跳转到佳人推荐页

@property (nonatomic, strong) NSString *isFollowed;  // 是否已关注，0:否、1:是

@property (nonatomic, strong) NSString *ids;  // 用户ID

@property (nonatomic, strong) NSString *gender;  // 性别

@property (nonatomic, strong) NSString *country;  // 国家

@property (nonatomic, strong) NSString *province;  // 省份

@property (nonatomic, strong) NSString *city;  // 城市

@property (nonatomic, strong) NSString *introduction;  // 个人简介

@property (nonatomic, strong) NSArray *personalTags;  // 个人标签列表

@property (nonatomic, strong) NSString *fansCount;  // 粉丝数量

@property (nonatomic, strong) NSString *followCount;  // 关注数量

@property (nonatomic, strong) NSString *publishCount;  // 发表数量

+ (BTMeEntity *)shareSingleton;

/**
 *  是否登录
 */
@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, assign) BTUserStatus userStatus;

@end
