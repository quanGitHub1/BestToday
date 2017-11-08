//
//  BTHomeComment.h
//  BestToday
//
//  Created by leeco on 2017/11/8.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTHomeComment : NSObject

@property (nonatomic, strong) NSString *commentId;  // 评论ID

@property (nonatomic, strong) NSString *resourceId;  // 图片资源ID

@property (nonatomic, strong) NSString *commentUserId;  // 评论者ID

@property (nonatomic, strong) NSString *commentNickName;  // 评论者昵称

@property (nonatomic, strong) NSString *commentAvatarUrl;  // 评论者头像url

@property (nonatomic, strong) NSString *content;  // 评论内容

@property (nonatomic, strong) NSString *createTime;  // 评论时间

@property (nonatomic, strong) NSString *isOwn;  // 是否本人评论，0:否、1:是(用于前端显示)

@end
