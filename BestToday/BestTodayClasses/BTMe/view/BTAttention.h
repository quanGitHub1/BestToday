//
//  BTAttention.h
//  BestToday
//
//  Created by leeco on 2017/12/15.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTAttention : NSObject

// 取消关注接口
+ (void)requestFollowUser:(NSString *)userId success:(void(^) (BOOL isSuccess))success faild:(void(^)(BOOL failure))failure;

// 关注接口
+ (void)requestUnFollowUser:(NSString *)userId success:(void(^) (BOOL isSuccess))success faild:(void(^)(BOOL failure))failure;

@end
