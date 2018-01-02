//
//  BTLikeCommentService.m
//  BestToday
//
//  Created by leeco on 2017/11/23.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTLikeCommentService.h"
#import "BTHomeCommentEntity.h"
@implementation BTLikeCommentService


- (void)loadquerySaveLikeResource:(NSString*)resourceId completion:(void(^)(BOOL isSuccess, BOOL isCache))completion{
    
    NSString *urlString = [NSString stringWithFormat:@"%@?resourceId=%@",BTquerySaveLikeResource,resourceId];
    
    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
        
    } success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"code"] integerValue] == 0) {
               completion(YES,NO);
            }else{
                completion(NO,NO);
            }
        }else {
            completion(NO,NO);

        }
        
    } failure:^(NSError *error) {
        completion(NO,NO);
    }];
    
}

- (void)loadqueryCancelSaveLikeResource:(NSString*)resourceId completion:(void(^)(BOOL isSuccess, BOOL isCache))completion{


    NSString *urlString = [NSString stringWithFormat:@"%@?resourceId=%@",BTqueryDelLikeResource,resourceId];
    
    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
        
    } success:^(id responseObject) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"code"] integerValue] == 0) {
                completion(YES,NO);
            }else{
                completion(NO,NO);
            }
        }else {
            completion(NO,NO);
            
        }
        
    } failure:^(NSError *error) {
        completion(NO,NO);
    }];
}

- (void)loadqueryCommentListResource:(NSString*)resourceId pageindex:(int)index completion:(void(^)(BOOL isSuccess, BOOL isCache))completion{
    if (index == 1) {
        [self.arrCommentList removeAllObjects];
    }
    NSString *urlString = [NSString stringWithFormat:@"%@?resourceId=%@&pageIndex=%d",BTqueryCommentList,resourceId,index];
    NSLog(@"%@",urlString);
    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"code"] integerValue] == 0) {
                NSDictionary *dicData = responseObject[@"data"];
                if (dicData && [dicData isKindOfClass:[NSDictionary class]]) {
                    NSArray *resDetailVoList = dicData[@"commentVoList"];
                    
                    if ([resDetailVoList isKindOfClass:[NSNull class]]) {
                        completion(YES,NO);
                        return ;
                    }
                    if (resDetailVoList.count <= 0) {
                        completion(NO,NO);
                        return;
                    }
                    for (NSDictionary *dic in resDetailVoList) {
                        BTHomeCommentEntity *pageEntity = [BTHomeCommentEntity yy_modelWithDictionary:dic];
                        [self.arrCommentList addObject:pageEntity];
                    }
                    completion(YES,NO);
                }else{
                    completion(NO,NO);
                }
            }else{
                completion(NO,NO);
            }
        }else {
            completion(NO,NO);
            
        }
    } failure:^(NSError *error) {
        completion(NO,NO);
    }];
}

- (void)upLoadCommentResource:(NSString*)resourceId content:(NSString *)content completion:(void(^)(BOOL isSuccess, BOOL isCache))completion{
    NSString *contentEncode = [content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlString = [NSString stringWithFormat:@"%@?resourceId=%@&content=%@",BTUpLoadComment,resourceId,contentEncode];
    NSLog(@"%@",urlString);
    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"code"] integerValue] == 0) {
                    completion(YES,NO);
            }else{
                completion(NO,NO);
            }
        }else {
            completion(NO,NO);
        }
    } failure:^(NSError *error) {
        completion(NO,NO);
    }];
}

- (void)loadqueryGetSharePic:(NSString*)resourceId completion:(void(^)(BOOL isSuccess, BOOL isCache, NSString *picUrl))completion{

    NSString *urlString = [NSString stringWithFormat:@"%@?resourceId=%@",BTqueryGetSharePic,resourceId];
    
    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"code"] integerValue] == 0) {
                
                NSDictionary *data = responseObject[@"data"];
               
                if ([data isKindOfClass:[NSNull class]]) {
                    return ;
                }
                if (data && [data isKindOfClass:[NSDictionary class]]) {
                    
                    _picUrl = data[@"sharePicUrl"];
                }
                completion(YES,NO,_picUrl);
                
            }else{
                
                completion(NO,NO,_picUrl);
            }
            
        }else {
            
            completion(NO,NO,_picUrl);
            
        }
        
    } failure:^(NSError *error) {
        completion(NO,NO,_picUrl);
    }];

}


- (NSMutableArray *)arrCommentList{
    if (!_arrCommentList) {
        _arrCommentList = [[NSMutableArray alloc]init];
    }
    return _arrCommentList;
}

@end
