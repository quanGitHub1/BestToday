//
//  BTLoginsViewController.m
//  BestToday
//
//  Created by leeco on 2017/11/16.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTLoginsViewController.h"
#import "BTLoginService.h"
#import "WechatAuthSDK.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"

static NSString *kAuthScope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";
static NSString *kAuthOpenID = @"wx8910bc5d166f699a";
static NSString *kAuthState = @"今日最佳";

@interface BTLoginsViewController ()<WechatAuthAPIDelegate, WXApiManagerDelegate>

@property (nonatomic, strong) BTLoginService *loginService;

@end

@interface BTLoginsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *loginImage;

@end

@implementation BTLoginsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.hidden = YES;
    
    _loginImage.userInteractionEnabled = YES;
    //创建手势 使用initWithTarget:action:的方法创建
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    
    //设置属性
    //tap 手势一共两个属性，一个是设置轻拍次数，一个是设置点击手指个数
    //设置轻拍次数
    //设置手指字数
    tap.numberOfTouchesRequired = 1;
    
    //别忘了添加到testView上
    [_loginImage addGestureRecognizer:tap];
    
    [WXApiManager sharedManager].delegate = self;

    

    // Do any additional setup after loading the view from its nib.
}

//成功登录
- (void)onAuthFinish:(int)errCode AuthCode:(NSString *)authCode
{
    NSLog(@"onAuthFinish");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"onAuthFinish"
                                                    message:[NSString stringWithFormat:@"authCode:%@ errCode:%d", authCode, errCode]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

- (void)tapView:(UITapGestureRecognizer*)gesTap{

    [WXApiRequestHandler sendAuthRequestScope: kAuthScope
                                        State:kAuthState
                                       OpenID:kAuthOpenID
                             InViewController:self];
    
}


#pragma mark - WXApiManagerDelegate

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response {

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setValue:response.code forKey:@"code"];

    [self.loginService thirdPartyLogin:dic completion:^(BOOL isSuccess) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            
            self.loginCallBack(@"1111");
            
        }];

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

@end
