//
//  BTMessageEntity.h
//  BestToday
//
//  Created by 王卓 on 2017/11/24.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BTMessageUserEntity.h"

@interface BTMessageEntity : NSObject

@property (nonatomic, strong) NSString *messageId;  // 资源id
@property (nonatomic, strong) NSString *content;  // 资源id
@property (nonatomic, strong) NSString *isOwn;  // 资源id
@property (nonatomic, strong) NSString *resourceId;  // 资源id
@property (nonatomic, strong) NSString *resourcePicUrl;
@property (nonatomic, strong) NSString *createTime;  // 资源id
@property (nonatomic, strong) NSString *createTimeShort;  // 资源id
@property (nonatomic, strong) BTMessageUserEntity *userEntity;  // 发消息用户
@property (nonatomic, strong) NSDictionary *userVo;  //

@end