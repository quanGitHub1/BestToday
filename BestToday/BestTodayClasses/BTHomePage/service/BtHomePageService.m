//
//  BtHomePageService.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BtHomePageService.h"

@implementation BtHomePageService

- (void)loadqueryMyFollowedUsers:(NSInteger)tag completion:(void(^)(BOOL isSuccess, BOOL isCache))completion{

    NSString *urlString = [NSString stringWithFormat:@"%@&tag=%ld",BTQueryMyFollowedUsers,tag];
    
    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        
        completion(YES,NO);
        
        
    } failure:^(NSError *error) {
        completion(NO,NO);
    }];

    
}


@end
