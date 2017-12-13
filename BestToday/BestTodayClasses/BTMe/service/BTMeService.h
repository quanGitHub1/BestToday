//
//  BTMeService.h
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTMeService : NSObject

@property (nonatomic, strong)NSMutableArray *arrByUser;

@property (nonatomic, strong)NSMutableArray *arrMyResource; // 我发表的

@property (nonatomic, strong)NSMutableArray *arrCommentResource; // 我关注的

@property (nonatomic, strong) NSString *pageAssistParam;

@property (nonatomic, strong) NSString *pageAssistParamTwo;

@property (nonatomic, strong) NSString *nextPage;

@property (nonatomic, strong) NSString *nextPageTwo;





//用户信息
- (void)loadqueryUserById:(NSInteger)userID completion:(void(^)(BOOL isSuccess, BOOL isCache))completion;

- (void)loadqueryUserOtherId:(NSInteger)userID completion:(void(^)(BOOL isSuccess, BOOL isCache))completion;

// 我发表的图片资源接口
- (void)loadqueryMyResourceByPage:(NSInteger)pageIndex pageAssistParam:(NSString *)pageAssistParam completion:(void(^)(BOOL isSuccess, BOOL isCache, NSString* pageAssistParam, NSString *nextPage))completion;

// 我点赞过的图片资源接口
- (void)loadqueryCommentResourceByPage:(NSInteger)userID pageAssistParam:(NSString *)pageAssistParam completion:(void(^)(BOOL isSuccess, BOOL isCache, NSString* pageAssistParam, NSString *nextPage))completion;


@end
