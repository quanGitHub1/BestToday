//
//  BTDiscoverService.h
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTDiscoverService : NSObject

@property (nonatomic, strong) NSMutableArray *arrDiscoverResource;  // 分页查询首页

@property (nonatomic, strong) NSString *pageAssistParam;

// 分页查询首页已关注图片资源列表接口
- (void)loadqueryDiscoverResource:(NSInteger)pageIndex pageAssistParam:(NSString *)pageAssistParam completion:(void(^)(BOOL isSuccess, NSString *message, NSString *pageAssistParam))completion;


@end
