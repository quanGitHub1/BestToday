//
//  BTMeEditInforService.h
//  BestToday
//
//  Created by leeco on 2017/11/28.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTMeEditInforService : NSObject


// 更换头像
- (void)loadqueryUpdateAvatar:(UIImage *)picImage completion:(void(^)(BOOL isSuccess, BOOL isCache))completion;


// 编辑用户信息接口
- (void)loadqueryUpdateUserwithName:(NSString *)mName introduction:(NSString *)introduction personalTags:(NSArray *)personalTags  completion:(void (^)(BOOL isSuccess, BOOL isCache))completion;


@end
