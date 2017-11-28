//
//  BTMeAttentionService.m
//  BestToday
//
//  Created by leeco on 2017/11/28.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTMeAttentionService.h"
#import "BTMeEntity.h"

@implementation BTMeAttentionService

- (void)loadqueryMyFansUsersCompletion:(void(^)(BOOL isSuccess, BOOL isCache))completion{

    NSString *urlString = [NSString stringWithFormat:@"%@",BTqueryMyFansUsers];
    
    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        
        [self handleListData:responseObject];
        
        completion(YES,NO);
        
    } failure:^(NSError *error) {
        completion(NO,NO);
    }];
    
}

/** 查询我的关注用户列表数据 */
- (BOOL)handleListData:(id)respones {
    
    if (respones && [respones isKindOfClass:[NSDictionary class]]) {
        if (!([respones[@"code"] integerValue] == 0)) {
            return NO;
        }
        
        NSDictionary *dicData = respones[@"data"];
        
        if (dicData && [dicData isKindOfClass:[NSDictionary class]]) {
            
            NSArray *datas = dicData[@"followedUsers"];

            if (datas && [datas isKindOfClass:[NSArray class]]) {

                for (NSDictionary *dic in datas) {

                    BTMeEntity *userEntity = [BTMeEntity yy_modelWithDictionary:dic];
                    
                    [self.arrUserVoList addObject:userEntity];
                }
                
                return YES;

            }
        }
    }
    
    return NO;
}

- (NSMutableArray *)arrUserVoList{
    if (!_arrUserVoList) {
        _arrUserVoList = [[NSMutableArray alloc]init];
    }
    return _arrUserVoList;
}

@end
