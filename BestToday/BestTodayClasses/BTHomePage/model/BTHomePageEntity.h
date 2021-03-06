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

@property (nonatomic, strong) NSString *textInfo;  // 文字信息

@property (nonatomic, strong) NSString *totalCommentMsg;  // 评论总数描述信息

@property (nonatomic, strong) NSString *backgroundColor;  // 颜色

@property (nonatomic, strong) NSString *commentCount;  // 评论数量

@property (nonatomic, strong) NSString *likeCount;  // 点赞数量

@property (nonatomic, strong) NSString *createTime;  // 发布时间

@property (nonatomic, strong) NSString *topicName;  // 话题名称

@property (nonatomic, strong) NSString *isLiked;    //本人是否已点赞该图片，0:否、1:是

@property (nonatomic, strong) NSArray *partCommentList; //显示在详情页的部分评论列表(最多为3条评论)

@property (nonatomic, strong) NSMutableDictionary *userVo; //用户相关信息

@property (nonatomic, strong) NSString *createTimeShort;  // 图片发表时间简短格式

@property (nonatomic, strong) NSString *resourceId;  // 图片资源ID

@property (nonatomic, strong) NSString *picWidth;  // 图片宽

@property (nonatomic, strong) NSString *picHeight;  // 图片高度

@property (nonatomic, copy) NSString *msgContent;


@property (nonatomic, assign) BOOL isOpening;
@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;

@property (nonatomic, assign) CGFloat cellHeight;


@end


