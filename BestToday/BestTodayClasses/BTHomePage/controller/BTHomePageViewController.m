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

@interface BTHomePageViewController ()<LEBaseTableViewDelegate,UITableViewDataSource, UITableViewDelegate, BTSpreadTableViewDelegate, BTHomepageViewDelegate>

@property (nonatomic, strong)BTTableview *tableView;

@property (nonatomic, strong) BTSpreadTableView *spreadTableView;

@property (nonatomic, strong) NSMutableDictionary *dicCell;

@end

@implementation BTHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.title = @"今日最佳";
    
    _dicCell = [[NSMutableDictionary alloc] init];
    
    
    [[BTHomeOpenHander shareHomeOpenHander] initDataArry];

    [self setupTableView];
    

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
    
    self.tableView = [[BTTableview alloc]initWithFrame:CGRectMake(0, kNavigationBarHight, kSCREEN_WIDTH, kSCREEN_HEIGHT-kNavigationBarHight)];
    
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
        
        _spreadTableView.backgroundColor = [UIColor yellowColor];
        _spreadTableView.spreadDelegate = self;
        
    }
    
    [headerView addSubview:_spreadTableView];
    
    self.tableView.tableHeaderView = headerView;
    
}

#pragma mark - BTHomepageViewDelegate

- (void)reloadTableView:(NSInteger)indexpath height:(CGFloat)height {
    
    BTHomePageTableViewCell *announcementCell = [_dicCell objectForKey:[NSString stringWithFormat:@"indexPath%ld", indexpath]];

    announcementCell.heightCell = height;
    
    [self.tableView reloadData];
    
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return 10;
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
    
    [cell makeDatacell:indexPath.row];
    
    if (![[_dicCell allKeys] containsObject:[NSString stringWithFormat:@"indexPath%ld", indexPath.row]]) {
        
        [_dicCell setObject:cell forKey:[NSString stringWithFormat:@"indexPath%ld", indexPath.row]];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    BTHomePageDetailViewController *homePagedetail = [[BTHomePageDetailViewController alloc] init];
    
    BTHomePageTableViewCell *announcementCell = [_dicCell objectForKey:[NSString stringWithFormat:@"indexPath%ld", indexPath.row]];
    
    homePagedetail.heightCell = announcementCell.heightCell;
    
    [self.navigationController pushViewController:homePagedetail animated:YES];
    
}


- (void)onclickBtnAtten:(UIButton *)btn{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"取消关注" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"置顶该用户" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:defaultAction];
    [alertController addAction:destructiveAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
