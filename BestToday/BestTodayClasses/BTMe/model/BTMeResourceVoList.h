//
//  BTMeResourceVoList.h
//  BestToday
//
//  Created by leeco on 2017/11/27.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTMeResourceVoList : NSObject

@property (nonatomic, strong) NSString *userId;  // 用户ID

@property (nonatomic, strong) NSString *nickName;  // 用户昵称

@property (nonatomic, strong) NSString *avatarUrl;  // 用户头像url

@property (nonatomic, strong) NSString *jumpType;  // 点击跳转类型，1:跳转到个人主页，2:跳转到佳人推荐页

@property (nonatomic, strong) NSString *category;

@property (nonatomic, strong) NSString *backgroundColor;  // 颜色

@property (nonatomic, strong) NSString *commentCount;  // 评论数量

@property (nonatomic, strong) NSString *likeCount;  // 点赞数量

@property (nonatomic, strong) NSString *createTime;  // 发布时间

@property (nonatomic, strong) NSString *topicName;  // 话题名称

@property (nonatomic, strong) NSString *createTimeShort;  // 图片发表时间简短格式

@property (nonatomic, strong) NSString *resourceId;  // 图片资源ID

@property (nonatomic, strong) NSString *smallPicUrl;  // 颜色

@property (nonatomic, strong) NSString *picUrl;


@property (nonatomic, strong) NSString *textInfo;



@end
