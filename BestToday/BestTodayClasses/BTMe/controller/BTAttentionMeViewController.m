//
//  BTAttentionMeViewController.m
//  BestToday
//
//  Created by leeco on 2017/11/15.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTAttentionMeViewController.h"
#import "BTAttentionTableViewCell.h"
#import "BTMeAttentionService.h"
#import "BTUserEntity.h"
#import "BtHomePageService.h"


@interface BTAttentionMeViewController ()<UITableViewDelegate, UITableViewDataSource, LEBaseTableViewDelegate>

@property (nonatomic, strong)BTTableview *tableView;

@property (nonatomic, assign) NSInteger page;//页数

@property (nonatomic) BOOL isPullup;

@property (nonatomic, strong) BTMeAttentionService *meService;

@property (nonatomic, strong) BtHomePageService *homePageService;


@end

@implementation BTAttentionMeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    [self setupTableView];
    
    [self loadData];
}


- (void)setupNavigationBar {
    
    self.navigationBar.title = _navTitle;
    
    [self.navigationBar setLeftBarButton:[UIButton mlt_rightBarButtonWithImage:[UIImage imageNamed:@"info_backs"] highlightedImage:nil target:self action:@selector(navigationBackButtonClicked:) forControlEvents:UIControlEventTouchUpInside]];
    
}

- (void)setupTableView{
    
    _tableView = [[BTTableview alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, FULL_WIDTH, FULL_HEIGHT - NAVBAR_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.dataDelegate = self;
    
    _tableView.estimatedRowHeight = 90;
    
    
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView hiddenFreshHead];

    [self.tableView hiddenFreshFooter];
    
    [self.view addSubview:_tableView];
    
}

- (void)loadData{
    
    if ([self.navigationBar.title isEqualToString:@"关注我的"]) {
        [self requestqueryUser];

    }else {
    
        [self requestAnnouncementData];
    }
}

- (void)requestqueryUser{
    
    [self.meService loadqueryMyFansUsersId:[self.userId integerValue] Completion:^(BOOL isSuccess, BOOL isCache) {
        
        [self.tableView stop];
        
        if (isSuccess) {
            
            [self.tableView reloadData];
            
        }
    }];
}


/** 查询我的关注用户列表接口 */
- (void)requestAnnouncementData{
    
    [self.homePageService loadqueryMyFollowedUsers:3 completion:^(BOOL isSuccess, BOOL isCache) {
        
        [self.tableView stop];
        
        if (isSuccess) {
            
            [self.tableView reloadData];
            
        }
    }];
}

- (void)navigationBackButtonClicked:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.meService.arrUserVoList.count ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 65;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * const cellID = @"BTAttentionTableViewCell";
    
    BTAttentionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[BTAttentionTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell makeCellData:[self.meService.arrUserVoList objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - lazy
- (BTMeAttentionService *)meService {
    if (!_meService) {
        _meService = [[BTMeAttentionService alloc] init];
    }
    return _meService;
}

- (BtHomePageService *)homePageService {
    if (!_homePageService) {
        _homePageService = [[BtHomePageService alloc] init];
    }
    return _homePageService;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
