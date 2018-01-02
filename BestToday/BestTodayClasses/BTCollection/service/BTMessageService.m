//
//  BTCollectionService.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTMessageService.h"
#import "BTMessageEntity.h"
#import "BTMessageUserEntity.h"

@implementation BTMessageService

// 获取系统消息
- (void)loadQuerySystemMessageResourceCompletion:(void(^)(BOOL isSuccess, NSString *message))completion{
    
    NSString *urlString = [NSString stringWithFormat:@"%@",BTquerySystemMessage];
    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
        
    } success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"code"] integerValue] == 0) {
                [_arrSystemMessageResource removeAllObjects];
                NSDictionary *dicData = responseObject[@"data"];
                if (dicData && [dicData isKindOfClass:[NSDictionary class]]) {
                    NSArray *resDetailVoList = dicData[@"messageVoList"];
                    for (NSDictionary *dic in resDetailVoList) {
                        BTMessageEntity *messageEntity = [BTMessageEntity yy_modelWithDictionary:dic];
                        messageEntity.userEntity = [BTMessageUserEntity yy_modelWithDictionary:messageEntity.userVo];
                        [self.arrSystemMessageResource addObject:messageEntity];
                    }
                    completion(YES,responseObject[@"msg"]);
                }else{
                    completion(NO,responseObject[@"msg"]);
                }
            }else{
                completion(NO,responseObject[@"msg"]);
            }
        }else{
            completion(NO,@"错误的返回类型");
        }
    } failure:^(NSError *error) {
        completion(NO,@"请求失败");
    }];
    
    
}

// 获取个人消息
- (void)loadQueryMeMessageResourceCompletion:(void(^)(BOOL isSuccess, NSString *message))completion{
    NSString *urlString = [NSString stringWithFormat:@"%@",BTqueryMeMessage];
    NSLog(@"%@",urlString);
    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
        
    } success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"code"] integerValue] == 0) {
                [_arrMeMessageResource removeAllObjects];
                NSDictionary *dicData = responseObject[@"data"];
                if (dicData && [dicData isKindOfClass:[NSDictionary class]]) {
                    NSArray *resDetailVoList = dicData[@"messageVoList"];
                    for (NSDictionary *dic in resDetailVoList) {
                        BTMessageEntity *messageEntity = [BTMessageEntity yy_modelWithDictionary:dic];
                        messageEntity.userEntity = [BTMessageUserEntity yy_modelWithDictionary:messageEntity.userVo];
                        [self.arrMeMessageResource addObject:messageEntity];
                    }
                    completion(YES,responseObject[@"msg"]);
                }else{
                    completion(NO,responseObject[@"msg"]);
                }
            }else{
                completion(NO,responseObject[@"msg"]);
            }
        }else{
            completion(NO,responseObject[@"msg"]);
        }
    } failure:^(NSError *error) {
        completion(NO,error.localizedDescription);
    }];
}


- (void)feedBackInfoWithContent:(NSString *)content Completion:(void(^)(BOOL isSuccess, NSString *message))completion{
    NSString *contentEncode = [content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSString *urlString = [NSString stringWithFormat:@"%@?content=%@",BTFeedBackInfo,contentEncode];

    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
        
    }success:^(id responseObject) {
        if ([responseObject[@"code"] integerValue] == 0) {
            completion(YES,responseObject[@"msg"]);
        }else{
            completion(NO,responseObject[@"msg"]);

        }
    } failure:^(NSError *error) {
        completion(NO,error.localizedDescription);
    }];
    
    
}


- (NSMutableArray *)arrSystemMessageResource{
    if (!_arrSystemMessageResource) {
        _arrSystemMessageResource = [[NSMutableArray alloc]init];
    }
    return _arrSystemMessageResource;
}

- (NSMutableArray *)arrMeMessageResource{
    if (!_arrMeMessageResource) {
        _arrMeMessageResource = [[NSMutableArray alloc]init];
    }
    return _arrMeMessageResource;
}



@end
