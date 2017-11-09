//
//  BTPhotoViewController.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTPhotoViewController.h"

#import "BestToday-Swift.h"

@interface BTPhotoViewController ()

@end

@implementation BTPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.title = @"拍照";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 200, 100, 100);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"拍照" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(doPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

- (void)doPhoto{
    
    FusumaViewController *fusumaViewController = [[FusumaViewController alloc] init];
    fusumaViewController.cropHeightRatio = 0.6;
    [self.navigationController presentViewController:fusumaViewController animated:YES completion:nil];
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
