//
//  BTPhotoService.h
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTPhotoService : NSObject


- (void)uploadImage:(UIImage *)image text:(NSString *)text categoryId:(NSString *)categoryId tagIdList:(NSString *)tagIdList completion:(void(^)(BOOL isSuccess, NSString *message))completion;


@end
