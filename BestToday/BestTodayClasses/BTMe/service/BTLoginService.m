//
//  BTLoginService.m
//  BestToday
//
//  Created by leeco on 2017/11/7.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTLoginService.h"

@implementation BTLoginService

/** 第三方登录 */
- (void)thirdPartyLogin:(NSDictionary *)dicUser completion:(void (^)(BOOL isSuccess))completion{
    
    [NetworkHelper POST:BTUserLogin parameters:dicUser success:^(id responseObject) {
        
        if (responseObject) {
            
            // code 等于200 就代表请求成功
            NSString *code = responseObject[@"code"];
            
            if ([code integerValue] == 200) {
                
                NSDictionary *dicData = responseObject[@"data"];
                
                if (dicData && [dicData isKindOfClass:[NSDictionary class]]) {
                    
                    completion(YES);
                    
                }
            }
        }

    } failure:^(NSError *error) {
        completion(NO);

    }];
    
}


@end
