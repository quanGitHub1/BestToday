//
//  BTCollectionViewController.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTCollectionViewController.h"
#import "ZFJSegmentedControl.h"

@interface BTCollectionViewController ()

@end

@implementation BTCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.title = @"关注";
    ZFJSegmentedControl * segmentedControl = [[ZFJSegmentedControl alloc] initwithTitleArr:@[@"系统消息",@"你"] iconArr:nil SCType:SCType_Underline];
    segmentedControl.frame = CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, 40);
    segmentedControl.backgroundColor = [UIColor whiteColor];
    segmentedControl.titleColor = [UIColor lightGrayColor];
    segmentedControl.selectBtnSpace = 5;//设置按钮间的间距
//        segmentedControl.selectBtnWID = 120;//设置按钮的宽度 不设就是均分
    segmentedControl.SCType_Underline_HEI = 2;//设置底部横线的高度
    segmentedControl.titleFont = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
    segmentedControl.selectType = ^(NSInteger selectIndex,NSString *selectIndexTitle){
        if (selectIndex == 0) {
        
        }else{
        
        }
    };
    [self.view addSubview:segmentedControl];
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
