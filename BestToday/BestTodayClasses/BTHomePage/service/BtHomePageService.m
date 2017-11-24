//
//  BtHomePageService.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BtHomePageService.h"
#import "BTHomeUserEntity.h"
#import "BTHomePageEntity.h"
#import "BTHomeComment.h"

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

// 分页查询首页已关注图片资源列表接口
- (void)loadqueryFollowedResource:(NSInteger)pageIndex pageAssistParam:(NSString *)pageAssistParam completion:(void(^)(BOOL isSuccess, BOOL isCache, NSString *pageAssistParam))completion{

    NSString *urlString = [NSString stringWithFormat:@"%@?pageIndex=%ld&pageAssistParam=%@",BTqueryFollowedResource,pageIndex,pageAssistParam];

    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
        
    } success:^(id responseObject) {
        
        if ([pageAssistParam isEqualToString:@""]) {
            
            [_arrFollowedResource removeAllObjects];
            
        }
        
        [self handleFollowedResourceListData:responseObject];
        
        completion(YES,NO, _pageAssistParam);
        
    } failure:^(NSError *error) {
        completion(NO,NO, _pageAssistParam);
    }];

}

/** 查询我的关注用户列表数据 */
- (BOOL)handleListData:(id)respones {
    
    if (respones && [respones isKindOfClass:[NSDictionary class]]) {
        if (!([respones[@"code"] integerValue] == 0)) {
            return NO;
        }
        [self.arrFollowedUsers removeAllObjects];
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

/** 查询关注图片资源列表数据 */
- (BOOL)handleFollowedResourceListData:(id)respones {
    
    if (respones && [respones isKindOfClass:[NSDictionary class]]) {
        if (!([respones[@"code"] integerValue] == 0)) {
            return NO;
        }
        
        NSDictionary *dicData = respones[@"data"];
        
        if (dicData && [dicData isKindOfClass:[NSDictionary class]]) {
            
            NSArray *resDetailVoList = dicData[@"resDetailVoList"];
            
            _pageAssistParam = dicData[@"pageAssistParam"];
            
            for (NSDictionary *dic in resDetailVoList) {
                
                BTHomePageEntity *pageEntity = [BTHomePageEntity yy_modelWithDictionary:dic];
                
                [self.arrFollowedResource addObject:pageEntity];
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

- (NSMutableArray *)arrFollowedResource{
    if (!_arrFollowedResource) {
        _arrFollowedResource = [[NSMutableArray alloc]init];
    }
    return _arrFollowedResource;
}

@end
