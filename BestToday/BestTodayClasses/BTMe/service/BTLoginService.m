//
//  BTLoginService.m
//  BestToday
//
//  Created by leeco on 2017/11/7.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTLoginService.h"
#import "BTUserEntity.h"

@implementation BTLoginService

/** 第三方登录 */
- (void)thirdPartyLogin:(NSDictionary *)dicUser completion:(void (^)(BOOL isSuccess))completion{
    
    [NetworkHelper POST:BTUserLogin parameters:dicUser success:^(id responseObject) {
        
        if (responseObject) {
            
            // code 等于200 就代表请求成功
            NSString *code = responseObject[@"code"];
            
            if ([code integerValue] == 0) {
                
                NSDictionary *dicData = responseObject[@"data"];
                
                if (dicData && [dicData isKindOfClass:[NSDictionary class]]) {
                    
                    NSMutableDictionary *allDic = [NSMutableDictionary dictionaryWithDictionary:dicData[@"appUserDetailVo"]];
                    [allDic setValuesForKeysWithDictionary:dicData];
                    
                    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                    [defaults setObject:allDic[@"avatarUrl"] forKey:@"bt_userAvatarUrl"];
                    [defaults synchronize];//用synchronize方法把数据持久化到standardUserDefaults数据库
                    BTMeEntity *userEntity = [BTMeEntity yy_modelWithJSON:allDic];
                    
                    [BTLoginService keyedArchiver:userEntity key:@"SaveUserEntity" path:kSaveUserEntityPath];
                    [[BTMeEntity shareSingleton] manageLoginData];
                    
                    completion(YES);
                    
                }
            }
        }

    } failure:^(NSError *error) {
        completion(NO);

    }];
    
}

- (void)loginWithUserName:(NSString *)username password:(NSString *)password completion:(void (^)(BOOL isSuccess))completion{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:username,@"userName",password,@"password", nil];
    [NetworkHelper POST:BTUserLoginWithShen parameters:dic success:^(id responseObject) {
        
        if (responseObject) {
            
            // code 等于200 就代表请求成功
            NSString *code = responseObject[@"code"];
            
            if ([code integerValue] == 0) {
                
                NSDictionary *dicData = responseObject[@"data"];
                
                if (dicData && [dicData isKindOfClass:[NSDictionary class]]) {
                    
                    NSMutableDictionary *allDic = [NSMutableDictionary dictionaryWithDictionary:dicData[@"appUserDetailVo"]];
                    [allDic setValuesForKeysWithDictionary:dicData];
                    
                    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                    [defaults setObject:allDic[@"avatarUrl"] forKey:@"bt_userAvatarUrl"];
                    [defaults synchronize];//用synchronize方法把数据持久化到standardUserDefaults数据库
                    BTMeEntity *userEntity = [BTMeEntity yy_modelWithJSON:allDic];
                    
                    [BTLoginService keyedArchiver:userEntity key:@"SaveUserEntity" path:kSaveUserEntityPath];
                    [[BTMeEntity shareSingleton] manageLoginData];
                    
                    completion(YES);
                    
                }
            }
        }
        
    } failure:^(NSError *error) {
        completion(NO);
        
    }];
    
}

- (void)getLoadAppLoginTypesCompletion:(void (^)(BOOL isSuccess,NSString * status))completion{
    
    [NetworkHelper GET:BTAppLoginTypes parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"0"]) {
            NSDictionary *dicData = responseObject[@"data"];
            completion(YES,dicData[@"auditStatus"]);

        }else{
            completion(NO,@"");

        }
        
        
    } failure:^(NSError *error) {
        completion(NO,@"");
    }];
}




@end
