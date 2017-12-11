//
//  BTMeAttentionService.h
//  BestToday
//
//  Created by leeco on 2017/11/28.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTMeAttentionService : NSObject

@property (nonatomic, strong) NSMutableArray *arrUserVoList;

- (void)loadqueryMyFansUsersId:(NSInteger )userId Completion:(void(^)(BOOL isSuccess, BOOL isCache))completion;

//- (void)loadqueryMyFollowedUsers:(void(^)(BOOL isSuccess, BOOL isCache))completion;


@end
