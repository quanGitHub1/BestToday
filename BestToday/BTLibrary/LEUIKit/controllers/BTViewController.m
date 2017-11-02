//
//  LEViewController.h
//  LEFinanceNewsIphone
//
//  Created by wangfaquan on 17/5/9.
//  Copyright © 2017年 wangfaquan. All rights reserved.
//

#import "BTViewController.h"
#import "BTMeViewController.h"

#define kBundleImage(name) ([NSString stringWithFormat:@"MLTUIKit.bundle/common/%@.png", name])

@interface BTViewController ()

@property (nonatomic ) UIView *navSeparator;

@end

@implementation BTViewController
@synthesize defaultFrame = _defaultFrame;
@synthesize mltTabBarItem = _mltTabBarItem;
@synthesize mltTabBarController = _mltTabBarController;

#pragma mark - view life

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;

    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)setUpNavigationBar {
    _navigationBar = [[MGJNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.view.width,  70) needBlurEffect:NO];
    _navigationBar.bottomBorderColor = [UIColor clearColor];
    _navigationBar.titleColor = HEX(@"0d0d0d");
    _navigationBar.title = self.title;
    _navigationBar.backgroundColor = [UIColor whiteColor];

    if (self.navigationController.viewControllers.count > 1) {
        UIButton *backButton = [UIButton mlt_leftBarButtonWithImage:[UIImage imageNamed:kBundleImage(@"navigation_bar_back_icon")] highlightedImage:nil target:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [_navigationBar setLeftBarButton:backButton];
    }
    [self.view addSubview:_navigationBar];
    
    
    self.navSeparator = [[UIView alloc] initWithFrame:(CGRect) {0,_navigationBar.height - .5, _navigationBar.width, 0.5}];
    _navSeparator.backgroundColor = HEX(@"d9d9d9");
    _navSeparator.hidden = NO;
    [_navigationBar addSubview:_navSeparator];
    
}

-(void)setIsShowNavSeparatorLine:(BOOL)isShowNavSeparatorLine{
    
    _isShowNavSeparatorLine = isShowNavSeparatorLine;
    
    _navSeparator.hidden = !isShowNavSeparatorLine;
    
}

#pragma mark - responder

- (void)back:(id)sender {
    
    [self backButtonTapped];
}

- (void)backButtonTapped {
    if (self.navigationController.viewControllers.count > 1) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        
        [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    }
}

/**
 *  收起键盘
 */
- (void)resignKeyBoard {
    
    [self.view endEditing:YES];
}

#pragma mark - broken network show

- (void)showBrokenNetworkViewWithClickedHandler:(clickedHandler)handler {
    [self showBrokenNetworkViewInFrame:CGRectMake(0, self.navigationBar.height, self.view.width, self.view.height - self.navigationBar.height) clickHandler:handler];
}

- (void)showBrokenNetworkViewInFrame:(CGRect)frame clickHandler:(clickedHandler)handler {
    [self.view showBrokenNetworkViewInFrame:frame clickedHandler:handler];
}

#pragma mark - system event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self resignKeyBoard];
}

#pragma mark - synthesize setter/getter
- (void)setDefaultFrame:(CGRect)defaultFrame {
    _defaultFrame = defaultFrame;
}

- (void)setMltTabBarItem:(MLTTabBarItem *)mltTabBarItem {
    _mltTabBarItem = mltTabBarItem;
}

- (void)setMltTabBarController:(MLTTabBarController *)mltTabBarController {
    _mltTabBarController = mltTabBarController;
}

- (CGRect)defaultFrame {
    return _defaultFrame;
}

- (MLTTabBarItem *)mltTabBarItem {
    return _mltTabBarItem;
}

- (MLTTabBarController *)mltTabBarController {
    return _mltTabBarController;
}

- (BOOL)isShowInTabBar {
    
    return self.navigationController.viewControllers.count == 1;
    
}

@end
