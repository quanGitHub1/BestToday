//
//  BTLikeCommentService.h
//  BestToday
//
//  Created by leeco on 2017/11/23.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTLikeCommentService : NSObject

// 点赞
- (void)loadquerySaveLikeResource:(NSString*)resourceId completion:(void(^)(BOOL isSuccess, BOOL isCache))completion;

// 取消点赞
- (void)loadqueryCancelSaveLikeResource:(NSString*)resourceId completion:(void(^)(BOOL isSuccess, BOOL isCache))completion;


@end
