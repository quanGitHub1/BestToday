//
//  LELoginViewController.m
//  BestToday
//
//  Created by leeco on 2017/11/7.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTLoginViewController.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "BTLoginService.h"
#import "WechatAuthSDK.h"

static NSString *kAuthScope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";
static NSString *kAuthOpenID = @"0c806938e2413ce73eef92cc3";
static NSString *kAuthState = @"xxx";


@interface BTLoginViewController ()<WXApiManagerDelegate, WechatAuthAPIDelegate>

@property (nonatomic, strong) BTLoginService *loginService;

@end

@implementation BTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.hidden = YES;

    [WXApiManager sharedManager].delegate = self;

    // Do any additional setup after loading the view from its nib.
}
- (IBAction)onClickLoginWeixin:(id)sender {
    
    
    [WXApiRequestHandler sendAuthRequestScope: kAuthScope
                                        State:kAuthState
                                       OpenID:kAuthOpenID
                             InViewController:self];
}

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response {
    
    NSDictionary *dic = @{
                          @"appType": @"iOS",
                          @"code":response.code,
                          @"phoneModel":[MLTUtils getCurrentDevicePlatform],
                          @"appVersion":[MLTUtils appVersion]
                          };
    
    [self.loginService thirdPartyLogin:dic completion:^(BOOL isSuccess) {
        
        NSLog(@"1111111298908080-8");
    
    }];
    
}


#pragma mark - lazy
- (BTLoginService *)loginService {
    if (!_loginService) {
        _loginService = [[BTLoginService alloc]init];
    }
    return _loginService;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
