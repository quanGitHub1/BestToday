//
//  BtHomePageService.h
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BtHomePageService : NSObject

@property (nonatomic, strong) NSMutableArray *arrFollowedUsers;  //关注用户列表接口

@property (nonatomic, strong) NSMutableArray *arrFollowedResource;  // 分页查询首页

@property (nonatomic, strong) NSMutableArray *arrRecommendUsers;  //佳人列表接口

@property (nonatomic, strong) NSString *pageAssistParam;

@property (nonatomic, strong) NSString *nextPage;



// 查询我的关注用户列表接口
- (void)loadqueryMyFollowedUsers:(NSInteger)tag userId:(NSInteger)userId completion:(void(^)(BOOL isSuccess, BOOL isCache))completion;


// 分页查询首页已关注图片资源列表接口
- (void)loadqueryFollowedResource:(NSInteger)pageIndex pageAssistParam:(NSString *)pageAssistParam completion:(void(^)(BOOL isSuccess, BOOL isCache, NSString *pageAssistParam, NSString *nextPage))completion;


// 置顶用户/取消置顶接口
- (void)loadquerySetTopUser:(NSInteger)isTopped followedUserId:(NSInteger)followedUserId completion:(void(^)(BOOL isSuccess, BOOL isCache))completion;

// 取消关注接口
- (void)loadqueryUnFollowUser:(NSInteger)followedUserId completion:(void(^)(BOOL isSuccess, BOOL isCache))completion;


// 关注接口
- (void)loadqueryFollowUser:(NSInteger)followedUserId completion:(void(^)(BOOL isSuccess, BOOL isCache))completion;


// 佳人推荐接口
- (void)loadqueryRecommendUsers:(NSInteger)userID completion:(void(^)(BOOL isSuccess, BOOL isCache))completion;

// 投诉该用户
- (void)loadComplaintUser:(NSInteger)resourceId feedbackType:(NSInteger)feedbackType completion:(void(^)(BOOL isSuccess, BOOL isCache))completion;


@end
