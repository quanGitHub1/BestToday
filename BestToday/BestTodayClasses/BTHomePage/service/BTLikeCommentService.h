//
//  BTLikeCommentService.h
//  BestToday
//
//  Created by leeco on 2017/11/23.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTLikeCommentService : NSObject

@property (nonatomic, strong) NSMutableArray *arrCommentList;  //关注用户列表接口

@property (nonatomic, strong) NSString *picUrl;

// 点赞
- (void)loadquerySaveLikeResource:(NSString*)resourceId completion:(void(^)(BOOL isSuccess, BOOL isCache))completion;

// 取消点赞
- (void)loadqueryCancelSaveLikeResource:(NSString*)resourceId completion:(void(^)(BOOL isSuccess, BOOL isCache))completion;

// 评论列表
- (void)loadqueryCommentListResource:(NSString*)resourceId pageindex:(NSString *)index completion:(void(^)(BOOL isSuccess, BOOL isCache))completion;

// 上传评论
- (void)upLoadCommentResource:(NSString*)resourceId content:(NSString *)content completion:(void(^)(BOOL isSuccess, BOOL isCache))completion;

// 获取图片
- (void)loadqueryGetSharePic:(NSString*)resourceId completion:(void(^)(BOOL isSuccess, BOOL isCache, NSString *picUrl))completion;

@end
