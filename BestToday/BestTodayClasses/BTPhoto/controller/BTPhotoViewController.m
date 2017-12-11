//
//  BTPhotoViewController.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTPhotoViewController.h"

#import "BestToday-Swift.h"
#import "BTPublishViewController.h"

@interface BTPhotoViewController ()<FusumaDelegate>

@end

@implementation BTPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.title = @"拍照";
   
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    FusumaViewController *fusumaViewController = [[FusumaViewController alloc] init];
    fusumaViewController.cropHeightRatio = 0.6;
    fusumaViewController.delegate = self;
    [self.navigationController presentViewController:fusumaViewController animated:NO completion:nil];
}

- (void)fusumaImageSelected:(UIImage *)image source:(enum FusumaMode)source{
    
    BTPublishViewController *publishVC = [[BTPublishViewController alloc] init];
    publishVC.imageSource = image;
    [self.navigationController pushViewController:publishVC animated:YES];
}

- (void)fusumaWillClosed{
    
}

- (void)fusumaClosed{
    UINavigationController *navC = (UINavigationController *)AppWindow.rootViewController;
    MLTTabBarController *tabBarVC = navC.viewControllers[0];
    [tabBarVC selectAtIndex:0];
}

- (void)fusumaVideoCompletedWithFileURL:(NSURL *)fileURL{
    
}


- (void)fusumaCameraRollUnauthorized{
    
}

- (void)fusumaDismissedWithImage:(UIImage *)image source:(enum FusumaMode)source{
    
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
