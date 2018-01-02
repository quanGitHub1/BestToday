//
//  BTLoginService.h
//  BestToday
//
//  Created by leeco on 2017/11/7.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTLoginService : NSObject

/** 第三方登录 */
- (void)thirdPartyLogin:(NSDictionary *)dicUser completion:(void (^)(BOOL isSuccess))completion;

- (void)loginWithUserName:(NSString *)username password:(NSString *)password completion:(void (^)(BOOL isSuccess))completion;

- (void)getLoadAppLoginTypesCompletion:(void (^)(BOOL isSuccess,NSString * status))completion;

@end
