//
//  BtHomePageService.h
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BtHomePageService : NSObject

@property (nonatomic, strong) NSMutableArray *arrFollowedUsers;

- (void)loadqueryMyFollowedUsers:(NSInteger)tag completion:(void(^)(BOOL isSuccess, BOOL isCache))completion;


@end
