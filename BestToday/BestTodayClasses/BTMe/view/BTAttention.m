//
//  BTAttention.m
//  BestToday
//
//  Created by leeco on 2017/12/15.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTAttention.h"
#import "BtHomePageService.h"

@implementation BTAttention

// 取消关注接口
+ (void)requestUnFollowUser:(NSString *)userId success:(void(^) (BOOL isSuccess))success faild:(void(^)(BOOL failure))failure{
    
    BtHomePageService *pageService = [BtHomePageService new];

    [pageService loadqueryUnFollowUser:[userId integerValue] completion:^(BOOL isSuccess, BOOL isCache) {
        
        if (isSuccess == YES) {
            
            success(1);
            
        }else {
        
            failure(0);
        }
        
    }];

}

// 关注接口
+ (void)requestFollowUser:(NSString *)userId success:(void(^) (BOOL isSuccess))success faild:(void(^)(BOOL failure))failure{
    
    
    BtHomePageService *pageService = [BtHomePageService new];
    
    [pageService loadqueryFollowUser:[userId integerValue] completion:^(BOOL isSuccess, BOOL isCache) {
        
         if (isSuccess == YES) {
             
             success(1);
         }else {
             
             failure(0);
         }
        
    }];

}

@end
