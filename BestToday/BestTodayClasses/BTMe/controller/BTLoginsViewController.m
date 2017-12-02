//
//  BTLoginsViewController.m
//  BestToday
//
//  Created by leeco on 2017/11/16.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTLoginsViewController.h"
//#import "WXApiRequestHandler.h"
//#import "WXApiManager.h"
#import "BTLoginService.h"
#import "WechatAuthSDK.h"

static NSString *kAuthScope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";
static NSString *kAuthOpenID = @"0c806938e2413ce73eef92cc3";
static NSString *kAuthState = @"xxx";

@interface BTLoginsViewController ()<WechatAuthAPIDelegate>

@property (nonatomic, strong) BTLoginService *loginService;

@end

@interface BTLoginsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *loginImage;

@end

@implementation BTLoginsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationBar.hidden = YES;
    
//    [WXApiManager sharedManager].delegate = self;
    
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
    
  
    

    // Do any additional setup after loading the view from its nib.
}

- (void)tapView:(UITapGestureRecognizer*)gesTap{

//    [WXApiRequestHandler sendAuthRequestScope: kAuthScope
//                                        State:kAuthState
//                                       OpenID:kAuthOpenID
//                             InViewController:self];
    
}

//- (void)managerDidRecvAuthResponse:(SendAuthResp *)response {
//
////    NSDictionary *dic = @{
////                          @"appType": @"iOS",
////                          @"code":response.code,
////                          @"phoneModel":[MLTUtils getCurrentDevicePlatform],
////                          @"appVersion":[MLTUtils appVersion]
////                          };
////
////    [self.loginService thirdPartyLogin:dic completion:^(BOOL isSuccess) {
////
////        NSLog(@"1111111298908080-8");
////
////    }];
//    
//}


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
