//
//  BTLikeCommentService.m
//  BestToday
//
//  Created by leeco on 2017/11/23.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTLikeCommentService.h"

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

@end
