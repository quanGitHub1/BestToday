//
//  BTMeEntity.h
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTMeEntity : NSObject

@property (nonatomic, strong) NSString *userId;  // 用户ID

@property (nonatomic, strong) NSString *nickName;  // 用户昵称

@property (nonatomic, strong) NSString *avatarUrl;  // 用户头像url

@property (nonatomic, strong) NSString *jumpType;  // 点击跳转类型，1:跳转到个人主页，2:跳转到佳人推荐页

@property (nonatomic, strong) NSString *isFollowed;  // 是否已关注，0:否、1:是


@end
