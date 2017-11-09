//
//  BTHomePageViewController.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTHomePageViewController.h"
#import "BTSpreadTableView.h"

@interface BTHomePageViewController ()<LEBaseTableViewDelegate,UITableViewDataSource, UITableViewDelegate, BTSpreadTableViewDelegate>

@property (nonatomic, strong)BTTableview *tableView;

@property (nonatomic, strong) BTSpreadTableView *spreadTableView;


@end

@implementation BTHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.title = @"今日最佳";
    [self setupTableView];
    
}

- (void)setupTableView{
    
    self.tableView = [[BTTableview alloc]initWithFrame:CGRectMake(0, kNavigationBarHight, kSCREEN_WIDTH, kSCREEN_HEIGHT-kNavigationBarHight)];
    
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 100;
    
//    self.tableView.dataDelegate = self;
    
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

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        return 200;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
