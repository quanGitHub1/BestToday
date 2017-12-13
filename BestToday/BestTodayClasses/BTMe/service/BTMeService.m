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
#import "BTMeResourceVoList.h"

@implementation BTMeService

- (void)loadqueryUserById:(NSInteger)userID completion:(void(^)(BOOL isSuccess, BOOL isCache))completion{

    NSString *urlString = [NSString stringWithFormat:@"%@?userId=%ld",BTqueryUserById,userID];
    
    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        
        [self handleListData:responseObject];
        
        completion(YES,NO);
        
    } failure:^(NSError *error) {
        completion(NO,NO);
    }];
    
}

- (void)loadqueryUserOtherId:(NSInteger)userID completion:(void(^)(BOOL isSuccess, BOOL isCache))completion{


    
}


- (void)loadqueryMyResourceByPage:(NSInteger)pageIndex pageAssistParam:(NSString *)pageAssistParam completion:(void(^)(BOOL isSuccess, BOOL isCache, NSString* pageAssistParam, NSString *nextPage))completion{

    NSString *urlString = [NSString stringWithFormat:@"%@?pageIndex=%ld",BTqueryMyResourceByPage,pageIndex];
    
    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        
        if ([pageAssistParam isEqualToString:@""]) {
            
            [self.arrMyResource removeAllObjects];
        }
        [self handleRequestSourceListData:responseObject];
        
        completion(YES,NO,_pageAssistParam, _nextPage);
        
    } failure:^(NSError *error) {
        completion(NO,NO, _pageAssistParam, _nextPage);
    }];
}

- (void)loadqueryCommentResourceByPage:(NSInteger)pageIndex pageAssistParam:(NSString *)pageAssistParam completion:(void(^)(BOOL isSuccess, BOOL isCache, NSString* pageAssistParam, NSString *nextPage))completion{

    NSString *urlString = [NSString stringWithFormat:@"%@?pageIndex=%ld",BTqueryCommentResourceByPage,pageIndex];
    
    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        
        if ([pageAssistParam isEqualToString:@""]) {
            
            [self.arrCommentResource removeAllObjects];
            
        }
        [self handleRequestLikeSourceListData:responseObject];
        
        completion(YES,NO,_pageAssistParam, _nextPageTwo);
        
    } failure:^(NSError *error) {
        completion(NO,NO, _pageAssistParam, _nextPageTwo);
    }];
}


/** 查询我的关注用户列表数据 */
- (BOOL)handleListData:(id)respones {
    
    if (respones && [respones isKindOfClass:[NSDictionary class]]) {
        
        if (!([respones[@"code"] integerValue] == 0)) {
            return NO;
        }else if (([respones[@"code"] integerValue] == 1002)){
        
            [[BTMeEntity shareSingleton] logout];
        }
        
        NSDictionary *dicData = respones[@"data"];
        
        [self.arrByUser removeAllObjects];
        
        if (dicData && [dicData isKindOfClass:[NSDictionary class]]) {
            
            BTMeEntity *userEntity = [BTMeEntity yy_modelWithDictionary:dicData];

            [self.arrByUser addObject:userEntity];
            
//            [BTMeService keyedArchiver:userEntity key:@"SaveUserEntity" path:kSaveUserEntityPath];
//            
//            [[BTMeEntity shareSingleton] manageLoginData];
            
            return YES;
            
        }
    }
    
    return NO;
}

/** 我发表的图片资源接口 */
- (BOOL)handleRequestSourceListData:(id)respones {
    
    if (respones && [respones isKindOfClass:[NSDictionary class]]) {
        if (!([respones[@"code"] integerValue] == 0)) {
            return NO;
        }
        
        NSDictionary *dicData = respones[@"data"];
        
        if (dicData && [dicData isKindOfClass:[NSDictionary class]]) {
            
            NSArray *datas = dicData[@"resourceVoList"];
            
            _nextPage = dicData[@"nextPage"];

            _pageAssistParam = dicData[@"pageAssistParam"];

            if (datas && [datas isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in datas) {
                    
                    BTMeResourceVoList *resourceVoList = [BTMeResourceVoList yy_modelWithDictionary:dic];
                    
                    [self.arrMyResource addObject:resourceVoList];
                }
                
                return YES;
            }
        }
    }
    
    return NO;
}

/** 我喜欢的图片资源接口 */
- (BOOL)handleRequestLikeSourceListData:(id)respones {
    
    if (respones && [respones isKindOfClass:[NSDictionary class]]) {
        if (!([respones[@"code"] integerValue] == 0)) {
            return NO;
        }
        
        NSDictionary *dicData = respones[@"data"];
        
        if (dicData && [dicData isKindOfClass:[NSDictionary class]]) {
            
            NSArray *datas = dicData[@"resourceVoList"];
            
            _pageAssistParam = dicData[@"pageAssistParam"];

            
            _nextPage = dicData[@"nextPage"];

            
            if (datas && [datas isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in datas) {
                    
                    BTMeResourceVoList *resourceVoList = [BTMeResourceVoList yy_modelWithDictionary:dic];
                    
                    [self.arrCommentResource addObject:resourceVoList];
                }
                
                return YES;
            }
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

- (NSMutableArray *)arrMyResource{
    if (!_arrMyResource) {
        _arrMyResource = [[NSMutableArray alloc]init];
    }
    return _arrMyResource;
}

- (NSMutableArray *)arrCommentResource{
    if (!_arrCommentResource) {
        _arrCommentResource = [[NSMutableArray alloc]init];
    }
    return _arrCommentResource;
}

@end
