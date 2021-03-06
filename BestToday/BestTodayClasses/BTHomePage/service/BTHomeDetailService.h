//
//  BTHomeDetailService.h
//  BestToday
//
//  Created by leeco on 2017/11/22.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTHomeDetailService : NSObject

@property (nonatomic, strong) NSMutableArray *arrDetailResourceByPage;

@property (nonatomic, strong) NSString *pageAssistParam;

@property (nonatomic, strong) NSMutableArray *arrDetailResource;

@property (nonatomic, strong) NSString *nextPage;



// 查询我的关注用户列表接口
- (void)loadRecommendResourceByPage:(NSInteger)pageIndex pageAssistParam:(NSString *)pageAssistParam resourceIds:(NSString *)resourceIds completion:(void(^)(BOOL isSuccess, BOOL isCache, NSString* pageAssistParam, NSString *nextPage))completion;

//查询图片详情接口
- (void)loadqueryResourceDetail:(NSInteger)resourceId completion:(void(^)(BOOL isSuccess, BOOL isCache))completion;

@end
