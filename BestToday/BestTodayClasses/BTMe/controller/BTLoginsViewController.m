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
#import "BTAgreeMentWebViewController.h"

static NSString *kAuthScope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";
static NSString *kAuthOpenID = @"wx8910bc5d166f699a";
static NSString *kAuthState = @"今日最佳";

@interface BTLoginsViewController ()<WechatAuthAPIDelegate, WXApiManagerDelegate>

@property (nonatomic, strong) BTLoginService *loginService;

@property (weak, nonatomic) IBOutlet UIImageView *loginImage;

@property (strong, nonatomic) IBOutlet UITextField *nickNameTF;

@property (strong, nonatomic) IBOutlet UITextField *passwordTF;


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

    [self loadAppLoginTypes];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadAppLoginTypes{
    
    __weak __typeof(self)weakSelf = self;
    [self.loginService getLoadAppLoginTypesCompletion:^(BOOL isSuccess,NSString * status) {
        if (isSuccess) {
//            if ([status isEqualToString:@"0"]) {
                weakSelf.nickNameTF.hidden = NO;
                weakSelf.passwordTF.hidden = NO;
                weakSelf.sureButton.hidden = NO;
//            }else{
//                weakSelf.nickNameTF.hidden = YES;
//                weakSelf.passwordTF.hidden = YES;
//                weakSelf.sureButton.hidden = YES;
//            }
        }
    }];
    
}


- (IBAction)loginAction:(id)sender {
    if ([_nickNameTF.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入用户名"];
        return;
    }
    if (_passwordTF.text.length < 6) {
        [SVProgressHUD showInfoWithStatus:@"密码必须大于6位"];
        return;
    }
    
    __weak __typeof(self)weakSelf = self;
    [self.loginService loginWithUserName:_nickNameTF.text password:_passwordTF.text completion:^(BOOL isSuccess) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            weakSelf.loginCallBack(@"1111");
        }];
    }];
    
    
}

- (IBAction)onClickAgreement:(id)sender {
    
    BTAgreeMentWebViewController *web = [[BTAgreeMentWebViewController alloc] init];
    
    [self.navigationController pushViewController:web animated:YES];
}


//成功登录
- (void)onAuthFinish:(int)errCode AuthCode:(NSString *)authCode
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"onAuthFinish"
                                                    message:[NSString stringWithFormat:@"authCode:%@ errCode:%d", authCode, errCode]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

- (void)tapView:(UITapGestureRecognizer*)gesTap{
    //取得所点击的点的坐标
    CGPoint point = [gesTap locationInView:_loginImage];
    // 判断该点在不在区域内
    if (CGRectContainsPoint(CGRectMake(0,screenHight/2, screenWidth, screenHight/2), point)){
        [WXApiRequestHandler sendAuthRequestScope: kAuthScope
                                            State:kAuthState
                                           OpenID:kAuthOpenID
                                 InViewController:self];
    }
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
