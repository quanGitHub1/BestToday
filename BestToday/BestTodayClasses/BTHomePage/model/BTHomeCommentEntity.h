//
//  BTHomeCommentEntity.h
//  BestToday
//
//  Created by 王卓 on 2017/12/11.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTHomeCommentEntity : NSObject

@property (nonatomic, strong) NSString *commentId;

@property (nonatomic, strong) NSString *resourceId;

@property (nonatomic, strong) NSString *commentUserId;

@property (nonatomic, strong) NSString *commentNickName;

@property (nonatomic, strong) NSString *commentAvatarUrl;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *isOwn;

@end
