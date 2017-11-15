//
//  BTAttentionMeViewController.m
//  BestToday
//
//  Created by leeco on 2017/11/15.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTAttentionMeViewController.h"
#import "BTAttentionTableViewCell.h"

@interface BTAttentionMeViewController ()<UITableViewDelegate, UITableViewDataSource, LEBaseTableViewDelegate>

@property (nonatomic, strong)BTTableview *tableView;

@property (nonatomic, assign) NSInteger page;//页数

@property (nonatomic) BOOL isPullup;

@end

@implementation BTAttentionMeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    [self setupTableView];
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
    
    [self.view addSubview:_tableView];
    
}

- (void)navigationBackButtonClicked:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
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
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
