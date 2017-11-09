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


@end
