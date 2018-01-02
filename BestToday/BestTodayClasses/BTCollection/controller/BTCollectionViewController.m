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
#import "BTMessageViewController.h"
#import "BTMessageService.h"
#import "EaseMessageModel.h"
@interface BTCollectionViewController ()<UITableViewDelegate,UITableViewDataSource,LEBaseTableViewDelegate>
{
    BOOL messageType;
    ZFJSegmentedControl * segmentedControl;
}
@property (nonatomic ,strong) BTTableview *systemTableView;
@property (nonatomic ,strong) BTTableview *meTableView;
@property (nonatomic, strong) BTMessageService *messageService;

@end

@implementation BTCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    segmentedControl = [[ZFJSegmentedControl alloc] initwithTitleArr:@[@"系统消息",@"我的"] iconArr:nil SCType:SCType_Underline];
    segmentedControl.frame = CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, 40);
    segmentedControl.backgroundColor = [UIColor whiteColor];
    segmentedControl.titleColor = [UIColor colorWithHexString:@"#969696"];
    segmentedControl.selectTitleColor = [UIColor colorWithHexString:@"#212121"];
    segmentedControl.selectBtnSpace = 5;//设置按钮间的间距
    segmentedControl.SCType_Underline_HEI = 2;//设置底部横线的高度
    segmentedControl.titleFont = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
    segmentedControl.selectIndex = 1;
    segmentedControl.selectType = ^(NSInteger selectIndex,NSString *selectIndexTitle){
        if (selectIndex == 0) {
            messageType = YES;
            [_meTableView removeFromSuperview];
            [self.view addSubview:self.systemTableView];
        }else{
            messageType = NO;
            [_systemTableView removeFromSuperview];
            [self.view addSubview:self.meTableView];
        }
    };
    self.navigationBar.titleView = segmentedControl;
    
    self.systemTableView = [[BTTableview alloc]initWithFrame:CGRectMake(0, kNavigationBarHight, kSCREEN_WIDTH, kSCREEN_HEIGHT-kNavigationBarHight-TAB_HEIGHT) style:UITableViewStylePlain];
    self.systemTableView.delegate = self;
    self.systemTableView.dataSource = self;
    self.systemTableView.dataDelegate = self;
    [self.systemTableView autoRefreshLoad];
    [self.systemTableView hiddenFreshFooter];
    
    self.meTableView = [[BTTableview alloc]initWithFrame:CGRectMake(0, kNavigationBarHight, kSCREEN_WIDTH, kSCREEN_HEIGHT-kNavigationBarHight-TAB_HEIGHT) style:UITableViewStylePlain];
    self.meTableView.delegate = self;
    self.meTableView.dataSource = self;
    self.meTableView.dataDelegate = self;
    [self.meTableView autoRefreshLoad];
    [self.meTableView hiddenFreshFooter];
    [self.view addSubview:self.meTableView];
}


- (void)notificationIsAlert:(NSString *)notiInfo{
    if ([notiInfo isEqualToString:@"systemMessage"]) {
        segmentedControl.selectIndex = 0;
        
    }else if ([notiInfo isEqualToString:@"personalMessage"]){
        segmentedControl.selectIndex = 1;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LEBaseTableViewDelegate
// 请求数据
- (void)requestDataSource{
    if (messageType) {
        [self.messageService loadQuerySystemMessageResourceCompletion:^(BOOL isSuccess, NSString *message) {
            [self.systemTableView stop];
            if (isSuccess) {
                [self.systemTableView reloadData];
            }else{
                NSLog(@"%@",message);
            }
        }];
    }else{
        [self.messageService loadQueryMeMessageResourceCompletion:^(BOOL isSuccess, NSString *message) {
            [self.meTableView stop];
            if (isSuccess) {
                [self.meTableView reloadData];
            }else{
                NSLog(@"%@",message);
            }
        }];
    }
}

#pragma mark - tableViewDelegate&DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _systemTableView) {
        return self.messageService.arrSystemMessageResource.count;
    }else{
        return self.messageService.arrMeMessageResource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _systemTableView) {
        BTSystemMessageCell *cell = [[BTSystemMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"systemTableView"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        BTMessageEntity *entity = self.messageService.arrSystemMessageResource[indexPath.row];
        [cell setDataForCell:entity];
        return cell;
    }else{
        BTMeMessageCell *cell = [[BTMeMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"metableView"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        BTMessageEntity *entity = self.messageService.arrMeMessageResource[indexPath.row];
        [cell setDataForCell:entity];

        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _systemTableView) {
        BTMessageEntity *entity = self.messageService.arrSystemMessageResource[indexPath.row];
        BTMessageViewController *messageVC = [[BTMessageViewController alloc] init];
        messageVC.messageEntity = entity;
        [self.navigationController pushViewController:messageVC animated:YES];
    }
}


- (BTMessageService *)messageService {
    if (!_messageService) {
        _messageService = [[BTMessageService alloc] init];
    }
    return _messageService;
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
