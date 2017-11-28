//
//  BTMeEditInforService.m
//  BestToday
//
//  Created by leeco on 2017/11/28.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTMeEditInforService.h"
#import "AFHTTPSessionManager.h"


@implementation BTMeEditInforService

- (void)loadqueryUpdateAvatar:(UIImage *)picImage completion:(void(^)(BOOL isSuccess, BOOL isCache))completion{

    picImage = [self imageWithImageSimple:picImage scaledToSize:CGSizeMake(100, 100)];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json",@"application/x-www-form-urlencoded", nil];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSMutableDictionary  *parameters = [NSMutableDictionary dictionary];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    //        [parameters setValue:@"iOS" forKey:@"appType"];
    [parameters setValue:version forKey:@"appVersion"];
    [parameters setValue:version forKey:@"osVersion"];
    [parameters setValue:@"abc1005" forKey:@"cSessionId"];
    
    [parameters setValue:[MLTUtils getCurrentDevicePlatform] forKey:@"phoneModel"];
    
    [manager POST:BTqueryUpdateAvatar parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *data =UIImageJPEGRepresentation(picImage,0.5);
        [formData appendPartWithFileData:data
                                    name:@"avatarPicFile"
                                fileName:@"1.png"
                                mimeType:@"image/jpeg"];
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *resultDict=responseObject;
        NSString *code=[resultDict objectForKey:@"code"];
        NSString *codeStr= [NSString stringWithFormat:@"%@",code];
        if ([codeStr isEqualToString:@"200"]) {
            NSDictionary *dataDict=[resultDict objectForKey:@"data"];
            NSString *headUrl=[dataDict valueForKey:@"url"];
            completion(YES,headUrl);
        }else{
            completion(NO,@"");
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        completion(NO,@"");
        
    }];

}

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}


@end
