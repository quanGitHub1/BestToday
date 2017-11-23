//
//  BTMeService.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTMeService.h"
#import "NetworkHelper.h"
#import "BTMeEntity.h"

@implementation BTMeService

- (void)loadqueryUserById:(NSInteger)userID completion:(void(^)(BOOL isSuccess, BOOL isCache))completion{

    NSString *urlString = [NSString stringWithFormat:@"%@?userID=%ld",BTqueryUserById,userID];
    
    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        
        [self handleListData:responseObject];
        
        completion(YES,NO);
        
    } failure:^(NSError *error) {
        completion(NO,NO);
    }];
    
}

- (void)loadqueryMyResourceByPage:(NSInteger)userID pageAssistParam:(NSString *)pageAssistParam completion:(void(^)(BOOL isSuccess, BOOL isCache, NSString* pageAssistParam))completion{

    
    
}

/** 查询我的关注用户列表数据 */
- (BOOL)handleListData:(id)respones {
    
    if (respones && [respones isKindOfClass:[NSDictionary class]]) {
        if (!([respones[@"code"] integerValue] == 0)) {
            return NO;
        }
        
        NSDictionary *dicData = respones[@"data"];
        
        if (dicData && [dicData isKindOfClass:[NSDictionary class]]) {
            
            BTMeEntity *userEntity = [BTMeEntity yy_modelWithDictionary:dicData];

            [self.arrByUser addObject:userEntity];
            
            return YES;
            
        }
    }
    
    return NO;
    
}


- (NSMutableArray *)arrByUser{
    if (!_arrByUser) {
        _arrByUser = [[NSMutableArray alloc]init];
    }
    return _arrByUser;
}

@end
