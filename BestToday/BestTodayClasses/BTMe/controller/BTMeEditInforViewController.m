//
//  BTMeEditInforViewController.m
//  BestToday
//
//  Created by leeco on 2017/11/10.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTMeEditInforViewController.h"

@interface BTMeEditInforViewController ()

@end

@implementation BTMeEditInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgationBar];
}

-(void)setNavgationBar{
    
    self.navigationBar.title = @"编辑个人资料";
    // 添加右上角按钮
    
    UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 50, 30)];
    
    [btnLeft setTitle:@"取消" forState:UIControlStateNormal];
    
    btnLeft.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [btnLeft setTitleColor:[UIColor colorWithHexString:@"#212121" alpha:1] forState:UIControlStateNormal];
    
    [self.navigationBar.leftBarButton addSubview:btnLeft];
    
    UIButton *btnRight = [[UIButton alloc] initWithFrame:CGRectMake(FULL_WIDTH - 55, 35, 50, 30)];
    
    [btnRight setTitle:@"确定" forState:UIControlStateNormal];
    
    btnRight.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [btnRight setTitleColor:[UIColor colorWithHexString:@"#212121" alpha:1] forState:UIControlStateNormal];
    
    [self.navigationBar addSubview:btnRight];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
