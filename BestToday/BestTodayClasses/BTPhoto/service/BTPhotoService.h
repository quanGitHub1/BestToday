//
//  BTPhotoService.h
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTPhotoService : NSObject

@property (nonatomic, strong) NSMutableArray *tagsArray;  // 我的消息

@property (nonatomic, strong) NSMutableArray *categoryArray;  // 我的消息


- (void)uploadImage:(UIImage *)image text:(NSString *)text categoryId:(NSString *)categoryId tagIdList:(NSString *)tagIdList tagName:(NSString *)tagName completion:(void(^)(BOOL isSuccess, NSString *message))completion;


- (void)getUploadPictureTagscompletion:(void(^)(BOOL isSuccess, NSString *message))completion;

- (void)getUploadPictureTagsByCategoryId:(NSString *)categoryId categoryName:(NSString *)categoryName Cacompletion:(void(^)(BOOL isSuccess, NSString *message))completion;

@end
