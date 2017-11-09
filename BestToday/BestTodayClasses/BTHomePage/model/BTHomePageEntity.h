//
//  BTHomePageEntity.h
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTHomePageEntity : NSObject

@property (nonatomic, strong) NSString *picUrl;  // 图片URL

@property (nonatomic, strong) NSString *textInfo;  // 描述

@property (nonatomic, strong) NSString *totalCommentMsg;  // 评论总数描述信息

@property (nonatomic, strong) NSString *backgroundColor;  // 颜色

@property (nonatomic, strong) NSString *commentCount;  // 评论数量

@property (nonatomic, strong) NSString *likeCount;  // 点赞数量

@property (nonatomic, strong) NSString *createTime;  // 发布时间


@end


