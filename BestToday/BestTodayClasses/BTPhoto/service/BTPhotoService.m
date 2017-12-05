//
//  BTPhotoService.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTPhotoService.h"
#import "AFHTTPSessionManager.h"

@implementation BTPhotoService

- (void)uploadImage:(UIImage *)image text:(NSString *)text categoryId:(NSString *)categoryId tagIdList:(NSString *)tagIdList completion:(void(^)(BOOL isSuccess, NSString *message))completion{
    
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
    [parameters setValue:@"abc1005" forKey:@"cSessionId"];
    [parameters setValue:[MLTUtils getCurrentDevicePlatform] forKey:@"phoneModel"];
    [parameters setValue:text forKey:@"textInfo"];
    [parameters setValue:text forKey:@"categoryId"];
    [parameters setValue:text forKey:@"tagIdList"];

    [manager POST:BTqueryUpdateAvatar parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data =UIImageJPEGRepresentation(image,0.5);
        [formData appendPartWithFileData:data
                                    name:imageName
                                fileName:fileName
                                mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
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
@end
