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

@property (nonatomic, strong) NSString *pageAssistParam;

// 查询我的关注用户列表接口
- (void)loadqueryMyFollowedUsers:(NSInteger)tag completion:(void(^)(BOOL isSuccess, BOOL isCache))completion;


// 分页查询首页已关注图片资源列表接口
- (void)loadqueryFollowedResource:(NSInteger)pageIndex pageAssistParam:(NSString *)pageAssistParam completion:(void(^)(BOOL isSuccess, BOOL isCache, NSString *pageAssistParam))completion;




@end
