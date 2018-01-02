//
//  BTPhotoService.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTPhotoService.h"
#import "AFHTTPSessionManager.h"
#import "BTPhotoEntity.h"

@implementation BTPhotoService

- (void)uploadImage:(UIImage *)image text:(NSString *)text categoryId:(NSString *)categoryId tagIdList:(NSString *)tagIdList tagName:(NSString *)tagName completion:(void(^)(BOOL isSuccess, NSString *message))completion{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *imageName = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg",imageName];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json",@"application/x-www-form-urlencoded", nil];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSMutableDictionary  *parameters = [NSMutableDictionary dictionary];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [parameters setValue:version forKey:@"appVersion"];
    [parameters setValue:version forKey:@"osVersion"];
    [parameters setValue:[BTMeEntity shareSingleton].csessionId forKey:@"cSessionId"];
    [parameters setValue:[MLTUtils getCurrentDevicePlatform] forKey:@"phoneModel"];
    [parameters setValue:text forKey:@"textInfo"];
    [parameters setValue:categoryId forKey:@"categoryId"];
    [parameters setValue:tagIdList forKey:@"tagIdList"];
    [parameters setValue:tagName forKey:@"tagName"];

    [manager POST:BTUploadPicture parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data =UIImageJPEGRepresentation(image,0.5);
        [formData appendPartWithFileData:data
                                    name:@"picFile"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"downLoadProcess = %@",uploadProgress);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 0) {
            completion(YES,responseObject[@"msg"]);
        }else{
            completion(NO,responseObject[@"msg"]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(NO,error.localizedDescription);
    }];
    
}

- (void)getUploadPictureTagscompletion:(void(^)(BOOL isSuccess, NSString *message))completion{
    NSString *urlString = [NSString stringWithFormat:@"%@",BTGetTagsList];
    NSLog(@"%@",urlString);

    [NetworkHelper GET:urlString parameters:nil responseCache:^(id responseCache) {
        
        
    } success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"code"] integerValue] == 0) {
                NSDictionary *dicData = responseObject[@"data"];
                if (dicData && [dicData isKindOfClass:[NSDictionary class]]) {
                    NSArray *resDetailVoList = dicData[@"categoryVoList"];
                    for (NSDictionary *dic in resDetailVoList) {
                        BTPhotoEntity *tagEntity = [BTPhotoEntity yy_modelWithDictionary:dic];
                        [self.categoryArray addObject:tagEntity];
                    }
                    completion(YES,responseObject[@"msg"]);
                }else{
                    completion(NO,responseObject[@"msg"]);
                }
            }else{
                completion(NO,responseObject[@"msg"]);
            }
        }else{
            completion(NO,responseObject[@"msg"]);
        }
    } failure:^(NSError *error) {
        completion(NO,error.localizedDescription);
    }];
    
}

- (void)getUploadPictureTagsByCategoryId:(NSString *)categoryId categoryName:(NSString *)categoryName Cacompletion:(void(^)(BOOL isSuccess, NSString *message))completion{
    [self.tagsArray removeAllObjects];
    NSString *urlString = [NSString stringWithFormat:@"%@",BTGetTagsCategory];
    
    [NetworkHelper GET:urlString parameters:@{@"categoryId":categoryId,@"categoryName":categoryName} responseCache:^(id responseCache) {
        
        
    }success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"code"] integerValue] == 0) {
                NSDictionary *dicData = responseObject[@"data"];
                if (dicData && [dicData isKindOfClass:[NSDictionary class]]) {
                    NSArray *resDetailVoList = dicData[@"tagVoList"];
                    for (NSDictionary *dic in resDetailVoList) {
                        BTPhotoEntity *tagEntity = [BTPhotoEntity yy_modelWithDictionary:dic];
                        [self.tagsArray addObject:tagEntity];
                    }
                    completion(YES,responseObject[@"msg"]);
                }else{
                    completion(NO,responseObject[@"msg"]);
                }
            }else{
                completion(NO,responseObject[@"msg"]);
            }
        }else{
            completion(NO,responseObject[@"msg"]);
        }
    } failure:^(NSError *error) {
        completion(NO,error.localizedDescription);
    }];
    
}

- (BTPhotoEntity *)getEntityWithTitle:(NSString *)title{
    for (BTPhotoEntity *entity in self.categoryArray) {
        if ([entity.categoryName isEqualToString:title]) {
            return entity;
        }
    }
    return nil;
}

- (BTPhotoEntity *)getTagCatgoryEntityWithTitle:(NSString *)title{
    for (BTPhotoEntity *entity in self.tagsArray) {
        if ([entity.tagName isEqualToString:title]) {
            return entity;
        }
    }
    return nil;
}


- (NSMutableArray *)tagsArray{
    if (!_tagsArray) {
        _tagsArray = [[NSMutableArray alloc]init];
    }
    return _tagsArray;
}

- (NSMutableArray *)categoryArray{
    if (!_categoryArray) {
        _categoryArray = [[NSMutableArray alloc]init];
    }
    return _categoryArray;
}

@end
