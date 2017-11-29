//
//  BTMessageUserEntity.h
//  BestToday
//
//  Created by 王卓 on 2017/11/24.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTMessageUserEntity : NSObject

@property (nonatomic, strong) NSString *userId;  // 用户id
@property (nonatomic, strong) NSString *nickName;  // 用户名
@property (nonatomic, strong) NSString *avatarUrl;  // 用户头像url
@property (nonatomic, strong) NSString *jumpType;  // 跳转类型
@property (nonatomic, strong) NSString *isFollowed;  // 资源id


@end
