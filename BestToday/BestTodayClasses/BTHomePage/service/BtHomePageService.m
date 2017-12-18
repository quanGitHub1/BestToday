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

- (void)loadqueryMyFollowedUsers:(NSInteger)tag userId:(NSInteger)userId completion:(void(^)(BOOL isSuccess, BOOL isCache))completion{

    NSString *urlString = [NSString stringWithFormat:@"%@?callFrom=%ld&userId=%ld",BTQueryMyFollowedUsers,tag, userId];
    
    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
        
    } success:^(id responseObject) {
        
        [self handleListData:responseObject];
        
        completion(YES,NO);
        
    } failure:^(NSError *error) {
        completion(NO,NO);
    }];

}

// 分页查询首页已关注图片资源列表接口
- (void)loadqueryFollowedResource:(NSInteger)pageIndex pageAssistParam:(NSString *)pageAssistParam completion:(void(^)(BOOL isSuccess, BOOL isCache, NSString *pageAssistParam, NSString *nextPage))completion{

    NSString *urlString = [NSString stringWithFormat:@"%@?pageIndex=%ld&pageAssistParam=%@",BTqueryFollowedResource,pageIndex,pageAssistParam];
    
    if ([pageAssistParam isEqualToString:@""]) {
        
        [_arrFollowedResource removeAllObjects];
        
    }

    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
        
    } success:^(id responseObject) {
                
        [self handleFollowedResourceListData:responseObject];
        
        completion(YES,NO, _pageAssistParam, _nextPage);
        
    } failure:^(NSError *error) {
        completion(NO,NO, _pageAssistParam, _nextPage);
    }];

}

// 置顶用户/取消置顶接口
- (void)loadquerySetTopUser:(NSInteger)isTopped followedUserId:(NSInteger)followedUserId completion:(void(^)(BOOL isSuccess, BOOL isCache))completion{
    
    NSString *urlString = [NSString stringWithFormat:@"%@?isTopped=%ld&followedUserId=%ld",BTquerySetTopUser,isTopped,followedUserId];
    
    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
        
    } success:^(id responseObject) {
        
        if (([responseObject[@"code"] integerValue] == 0)) {
            completion(YES,NO);

        }else {
            completion(NO,NO);

        }        
    } failure:^(NSError *error) {
        completion(NO,NO);
    }];
}

- (void)loadqueryUnFollowUser:(NSInteger)followedUserId completion:(void(^)(BOOL isSuccess, BOOL isCache))completion{

    NSString *urlString = [NSString stringWithFormat:@"%@?followedUserId=%ld",BTqueryUnFollowUser, followedUserId];
    
    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
        
    } success:^(id responseObject) {
        
        if (([responseObject[@"code"] integerValue] == 0)) {
            
            completion(YES,NO);
            
        }else {
            completion(NO,NO);
        }
        
    } failure:^(NSError *error) {
        completion(NO,NO);
    }];
}


- (void)loadqueryFollowUser:(NSInteger)followedUserId completion:(void(^)(BOOL isSuccess, BOOL isCache))completion{

    NSString *urlString = [NSString stringWithFormat:@"%@?followedUserId=%ld",BTqueryFollowUser, followedUserId];
    
    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
        
    } success:^(id responseObject) {
        
        if (([responseObject[@"code"] integerValue] == 0)) {
            
            completion(YES,NO);
            
        }else {
            completion(NO,NO);
        }
        
    } failure:^(NSError *error) {
        completion(NO,NO);
    }];
}


/** 佳人推荐 */
- (void)loadqueryRecommendUsers:(NSInteger)userID completion:(void(^)(BOOL isSuccess, BOOL isCache))completion{
    
    NSString *urlString = [NSString stringWithFormat:@"%@?userId=%ld",BTqueryRecommendUsers,userID];
    
    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        
        [self handleRecommendListData:responseObject];
        
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
        
        [self.arrFollowedUsers removeAllObjects];
        
        NSDictionary *dicData = respones[@"data"];
        
        if (dicData && [dicData isKindOfClass:[NSDictionary class]]) {
            
            NSArray *datas = dicData[@"followedUsers"];
            
            if ([datas isKindOfClass:[NSNull class]]) {
                return NO;
            }
            
            for (NSDictionary *dic in datas) {
                
                BTHomeUserEntity *userEntity = [BTHomeUserEntity yy_modelWithDictionary:dic];
                
                [self.arrFollowedUsers addObject:userEntity];
            }
            
            return YES;
            
        }
    }
    
    return NO;
    
}



/** 佳人推荐列表数据 */
- (BOOL)handleRecommendListData:(id)respones {
    
    if (respones && [respones isKindOfClass:[NSDictionary class]]) {
        if (!([respones[@"code"] integerValue] == 0)) {
            return NO;
        }
        
        [self.arrRecommendUsers removeAllObjects];
        
        NSDictionary *dicData = respones[@"data"];
        
        if (dicData && [dicData isKindOfClass:[NSDictionary class]]) {
            
            NSArray *datas = dicData[@"followedUsers"];
            
            if ([datas isKindOfClass:[NSNull class]]) {
                return NO;
            }
            
            for (NSDictionary *dic in datas) {
                
                BTHomeUserEntity *userEntity = [BTHomeUserEntity yy_modelWithDictionary:dic];
                
                [self.arrRecommendUsers addObject:userEntity];
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
            
            _nextPage = dicData[@"nextPage"];
            
            if (![resDetailVoList isKindOfClass:[NSArray class]]) {
                
                return NO;
            }
            
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

- (NSMutableArray *) arrRecommendUsers{
    if (!_arrRecommendUsers) {
        _arrRecommendUsers = [[NSMutableArray alloc]init];
    }
    return _arrRecommendUsers;
}

@end
