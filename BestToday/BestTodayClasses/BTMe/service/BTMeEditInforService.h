//
//  BTMeEditInforService.h
//  BestToday
//
//  Created by leeco on 2017/11/28.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTMeEditInforService : NSObject

- (void)loadqueryUpdateAvatar:(UIImage *)picImage completion:(void(^)(BOOL isSuccess, BOOL isCache))completion;


@end
