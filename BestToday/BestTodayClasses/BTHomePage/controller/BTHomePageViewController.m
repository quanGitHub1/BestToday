//
//  BTHomePageViewController.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTHomePageViewController.h"
#import "BTSpreadTableView.h"
#import "BTLoginViewController.h"
#import "BTHomePageTableViewCell.h"

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

    
    [self setupTableView];

//    BTLoginViewController *loginvc = [[BTLoginViewController alloc] init];
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


- (void)reloadTableView{

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
    
    [cell makeDatacell];
    
    if (![[_dicCell allKeys] containsObject:[NSString stringWithFormat:@"indexPath%ld", indexPath.row]]) {
        
        [_dicCell setObject:cell forKey:[NSString stringWithFormat:@"indexPath%ld", indexPath.row]];
        
    }
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
