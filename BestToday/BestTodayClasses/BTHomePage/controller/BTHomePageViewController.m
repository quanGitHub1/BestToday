//
//  BTHomePageViewController.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTHomePageViewController.h"
#import "BTSpreadTableView.h"
#import "BTLoginsViewController.h"
#import "BTHomePageTableViewCell.h"
#import "BTHomeOpenHander.h"
#import "BTHomePageDetailViewController.h"
#import <UShareUI/UShareUI.h>
#import "BtHomePageService.h"
#import "BTHomePageEntity.h"
#import "BTHomeUserEntity.h"


@interface BTHomePageViewController ()<LEBaseTableViewDelegate,UITableViewDataSource, UITableViewDelegate, BTSpreadTableViewDelegate, BTHomepageViewDelegate>

@property (nonatomic, strong)BTTableview *tableView;

@property (nonatomic, strong) BTSpreadTableView *spreadTableView;

@property (nonatomic, strong) NSMutableDictionary *dicCell;

@property (nonatomic, strong) BtHomePageService *homePageService;

@property (nonatomic, strong) NSString *pageAssistParam;

@end

@implementation BTHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.title = @"今日最佳";
    
    _dicCell = [[NSMutableDictionary alloc] init];
    
    
    [[BTHomeOpenHander shareHomeOpenHander] initDataArry];

    [self setupTableView];
    
    [self loadData];


//    BTLoginsViewController *loginvc = [[BTLoginsViewController alloc] init];
//    
//    
//    MGJNavigationController *navigationController = [[MGJNavigationController alloc] initWithRootViewController:loginvc];
//    
//    [self presentViewController:navigationController animated:YES completion:^{
//        
//        
//    }];
    
}

- (void)setupTableView{
    
    self.tableView = [[BTTableview alloc]initWithFrame:CGRectMake(0, kNavigationBarHight, kSCREEN_WIDTH, kSCREEN_HEIGHT-kNavigationBarHight - kTabBarHeight)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 200;
    
    self.tableView.dataDelegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    [self createTableViewHeaderView];
    
//    [self.tableView autoRefreshLoad];
    
}

- (void)createTableViewHeaderView{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FULL_WIDTH, ScaleHeight(120))];
    headerView.backgroundColor = kCardBackColor;
    
    // 调用tableView
    if (!_spreadTableView) {
        
        /**
         宽和高调换顺序
         */
        _spreadTableView = [[BTSpreadTableView alloc] initWithFrame:CGRectMake(0, 0, ScaleHeight(120), FULL_WIDTH) style:UITableViewStylePlain withType:BTSpreadTableViewStyleImageText];// x,y 高，宽
        
        _spreadTableView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
        
       _spreadTableView.dataArr = self.homePageService.arrFollowedUsers;
        
        _spreadTableView.spreadDelegate = self;
        
    }
    
    [headerView addSubview:_spreadTableView];
    
    self.tableView.tableHeaderView = headerView;
    
}

- (void)requestDataSource{
    
    if (_dicCell.count > 0) {
        [_dicCell removeAllObjects];
    }
    
    [_tableView resetNoMoreData];
    
    _pageAssistParam = @"";
    
    [self loadData];
}

- (void)requestMoreDataSource{
    
    if (self.homePageService.arrFollowedResource.count % 10  != 0) {
        [self.tableView noDataFooterEndRefreshing];
        
    }else{
        [self loadData];
    }
}

- (void)loadData{

    [self requestAnnouncementData];
    
    [self requestQueryFollowedResource];
    
}

/** 关注我的接口 */
- (void)requestAnnouncementData{
    
    [self.homePageService loadqueryMyFollowedUsers:1 completion:^(BOOL isSuccess, BOOL isCache) {
        
        [self.tableView stop];
        
        if (isSuccess) {
            
            _spreadTableView.dataArr = self.homePageService.arrFollowedUsers;
            
            [_spreadTableView reloadData];
            
            [self.tableView reloadData];

        }
    }];
}

- (void)requestQueryFollowedResource{

    [self.homePageService loadqueryFollowedResource:0 pageAssistParam:_pageAssistParam completion:^(BOOL isSuccess, BOOL isCache, NSString* pageAssistParam) {
        
        
        [self.tableView stop];
        
        _pageAssistParam = pageAssistParam;
        
        if (isSuccess) {
            
          [self.tableView reloadData];
            
        }
    }];
}

#pragma mark - BTHomepageViewDelegate

- (void)reloadTableView:(NSInteger)indexpath height:(CGFloat)height {
    
    BTHomePageTableViewCell *announcementCell = [_dicCell objectForKey:[NSString stringWithFormat:@"indexPath%ld", indexpath]];

    announcementCell.heightCell = height;
    
    [self.tableView reloadData];
    
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _homePageService.arrFollowedResource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_dicCell.count > indexPath.row) {
        
        BTHomePageTableViewCell *announcementCell = [_dicCell objectForKey:[NSString stringWithFormat:@"indexPath%ld", indexPath.row]];
        return announcementCell.heightCell;
    }
    
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString * const cellID = @"mindCell";
    
    BTHomePageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    
    
    if (!cell) {
        
        cell = [[BTHomePageTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        
        cell.delegate = self;

        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    [cell.btnAtten addTarget:self action:@selector(onclickBtnAtten:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.btnAtten.tag = indexPath.row;
    
    [cell makeDatacellData:[self.homePageService.arrFollowedResource objectAtIndex:indexPath.row] index:indexPath.row];
    
    if (![[_dicCell allKeys] containsObject:[NSString stringWithFormat:@"indexPath%ld", indexPath.row]]) {
        
        [_dicCell setObject:cell forKey:[NSString stringWithFormat:@"indexPath%ld", indexPath.row]];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    BTHomePageDetailViewController *homePagedetail = [[BTHomePageDetailViewController alloc] init];
    
    BTHomePageEntity *pageEntity = [_homePageService.arrFollowedResource objectAtIndex:indexPath.row];
    
    homePagedetail.resourceId = pageEntity.resourceId;
    
    [self.navigationController pushViewController:homePagedetail animated:YES];
    
}

- (void)onclickBtnAtten:(UIButton *)btn{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *canAction = [UIAlertAction actionWithTitle:@"取消关注" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self requestUnFollowUser:btn.tag];
        
    }];
    
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"置顶该用户" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self requestSetTopUser:btn.tag isTopped:1];
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:canAction];
    [alertController addAction:destructiveAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

// 置顶用户/取消置顶接口
- (void)requestSetTopUser:(NSInteger)index isTopped:(NSInteger)isTopped{
    
    BTHomePageEntity *pageEntity = [_homePageService.arrFollowedResource objectAtIndex:index];
    
    BTHomeUserEntity *userEntity = [BTHomeUserEntity yy_modelWithJSON:pageEntity.userVo];

    
    [self.homePageService loadquerySetTopUser:isTopped followedUserId:[userEntity.userId integerValue] completion:^(BOOL isSuccess, BOOL isCache) {
        
        
        
    }];
    
}


// 置顶用户/取消置顶接口
- (void)requestUnFollowUser:(NSInteger)index{
    
    BTHomePageEntity *pageEntity = [_homePageService.arrFollowedResource objectAtIndex:index];
    
    BTHomeUserEntity *userEntity = [BTHomeUserEntity yy_modelWithJSON:pageEntity.userVo];
    
    [self.homePageService loadqueryUnFollowUser:[userEntity.userId integerValue] completion:^(BOOL isSuccess, BOOL isCache) {
        
        
        
    }];
}


#pragma mark - lazy
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
