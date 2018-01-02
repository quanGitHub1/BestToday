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


- (void)loadqueryUpdateUserwithName:(NSString *)mName introduction:(NSString *)introduction personalTags:(NSArray *)personalTags  completion:(void (^)(BOOL isSuccess, BOOL isCache))completion{
    
    NSMutableDictionary  *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:(mName.length > 0 ? mName : @" ") forKey:@"nickName"];
    [parameters setValue:introduction.length > 0 ? introduction : @" " forKey:@"introduction"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:personalTags options:NSJSONWritingPrettyPrinted error:nil];
    [parameters setValue:[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding] forKey:@"personalTags"];
    
    [NetworkHelper POST:BTqueryUpdateUser parameters:parameters success:^(id responseObject) {
        
        NSString *code = responseObject[@"code"];
        
        if ([code integerValue] == 0) {
            completion(YES,NO);
            
        }else{
            completion(NO,NO);
        }
    } failure:^(NSError *error) {
        completion(NO,NO);
        
    }];

}

- (void)loadqueryUpdateAvatar:(UIImage *)picImage completion:(void(^)(BOOL isSuccess, BOOL isCache))completion{

    picImage = [self imageWithImageSimple:picImage scaledToSize:CGSizeMake(100, 100)];
    
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
        if ([codeStr isEqualToString:@"0"]) {
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
