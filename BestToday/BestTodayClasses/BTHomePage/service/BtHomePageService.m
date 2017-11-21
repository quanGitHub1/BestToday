//
//  BtHomePageService.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BtHomePageService.h"
#import "BTHomeUserEntity.h"

@implementation BtHomePageService

- (void)loadqueryMyFollowedUsers:(NSInteger)tag completion:(void(^)(BOOL isSuccess, BOOL isCache))completion{

    NSString *urlString = [NSString stringWithFormat:@"%@?appType=%ld",BTQueryMyFollowedUsers,tag];
    
    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
        
    } success:^(id responseObject) {
        
        [self handleListData:responseObject];
        
        completion(YES,NO);
        
    } failure:^(NSError *error) {
        completion(NO,NO);
    }];

}

/** 新闻列表数据 */
- (BOOL)handleListData:(id)respones {
    
    if (respones && [respones isKindOfClass:[NSDictionary class]]) {
        if (!([respones[@"code"] integerValue] == 0)) {
            return NO;
        }
        
        NSDictionary *dicData = respones[@"data"];
        
        if (dicData && [dicData isKindOfClass:[NSDictionary class]]) {
            
            NSArray *datas = dicData[@"followedUsers"];
            
            for (NSDictionary *dic in datas) {
                
                BTHomeUserEntity *userEntity = [BTHomeUserEntity yy_modelWithDictionary:dic];
                
                [self.arrFollowedUsers addObject:userEntity];
            }
            
            return YES;
            
        }
    }
    
    return NO;
    
}

- (NSMutableArray *)arrFollowedUsers{
    if (!_arrFollowedUsers) {
        _arrFollowedUsers = [[NSMutableArray alloc]init];
    }
    return _arrFollowedUsers;
}

@end
