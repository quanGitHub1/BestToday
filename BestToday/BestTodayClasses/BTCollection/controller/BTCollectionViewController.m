//
//  BTCollectionViewController.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTCollectionViewController.h"
#import "ZFJSegmentedControl.h"
#import "BTTableview.h"
#import "BTSystemMessageCell.h"
#import "BTMeMessageCell.h"

@interface BTCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) BTTableview *systemTableView;
@property (nonatomic ,strong) BTTableview *meTableView;


@end

@implementation BTCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    ZFJSegmentedControl * segmentedControl = [[ZFJSegmentedControl alloc] initwithTitleArr:@[@"系统消息",@"你"] iconArr:nil SCType:SCType_Underline];
    segmentedControl.frame = CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, 40);
    segmentedControl.backgroundColor = [UIColor whiteColor];
    segmentedControl.titleColor = [UIColor lightGrayColor];
    segmentedControl.selectBtnSpace = 5;//设置按钮间的间距
    segmentedControl.SCType_Underline_HEI = 2;//设置底部横线的高度
    segmentedControl.titleFont = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
    segmentedControl.selectType = ^(NSInteger selectIndex,NSString *selectIndexTitle){
        if (selectIndex == 0) {
            [_meTableView removeFromSuperview];
            [self.view addSubview:self.systemTableView];
        }else{
            [_systemTableView removeFromSuperview];
            [self.view addSubview:self.meTableView];
        }
    };
    self.navigationBar.titleView = segmentedControl;
    
    self.systemTableView = [[BTTableview alloc]initWithFrame:CGRectMake(0, kNavigationBarHight, kSCREEN_WIDTH, kSCREEN_HEIGHT-kNavigationBarHight)];
    self.systemTableView.delegate = self;
    self.systemTableView.dataSource = self;
    [self.view addSubview:self.systemTableView];
    
    self.meTableView = [[BTTableview alloc]initWithFrame:CGRectMake(0, kNavigationBarHight, kSCREEN_WIDTH, kSCREEN_HEIGHT-kNavigationBarHight)];
    self.meTableView.delegate = self;
    self.meTableView.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _systemTableView) {
        BTSystemMessageCell *cell = [[BTSystemMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"systemTableView"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        BTMeMessageCell *cell = [[BTMeMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"metableView"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _systemTableView) {
        
    }else{
        
    }
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
