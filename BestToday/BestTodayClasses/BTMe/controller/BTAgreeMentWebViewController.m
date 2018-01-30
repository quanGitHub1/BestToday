//
//  BTAgreeMentWebViewController.m
//  BestToday
//
//  Created by wangfaquan on 2018/1/19.
//  Copyright © 2018年 leeco. All rights reserved.
//

#import "BTAgreeMentWebViewController.h"

@interface BTAgreeMentWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation BTAgreeMentWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setLeftBarButton:[UIButton mlt_rightBarButtonWithImage:[UIImage imageNamed:@"info_backs"] highlightedImage:nil target:self action:@selector(navigationBackButtonClicked:) forControlEvents:UIControlEventTouchUpInside]];

    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, FULL_WIDTH, FULL_HEIGHT - 64)];
    
    _webView.delegate = self;
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://zuijia365.com/todayHot/app/document/userAgreement.do"];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.view addSubview:_webView];
    
}

- (void)navigationBackButtonClicked:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
