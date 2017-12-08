//
//  BTCollectionService.h
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTMessageService : NSObject

@property (nonatomic, strong) NSMutableArray *arrSystemMessageResource;  // 系统消息
@property (nonatomic, strong) NSMutableArray *arrMeMessageResource;  // 我的消息

// 获取系统消息
- (void)loadQuerySystemMessageResourceCompletion:(void(^)(BOOL isSuccess, NSString *message))completion;
// 获取个人消息
- (void)loadQueryMeMessageResourceCompletion:(void(^)(BOOL isSuccess, NSString *message))completion;

- (void)feedBackInfoWithContent:(NSString *)content Completion:(void(^)(BOOL isSuccess, NSString *message))completion;

@end
