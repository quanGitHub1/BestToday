//
//  BTHomedetailHeaderView.m
//  BestToday
//
//  Created by leeco on 2017/11/14.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTHomedetailHeaderView.h"
#import "BTHomePageTableViewCell.h"


@interface BTHomedetailHeaderView ()<UITableViewDataSource, UITableViewDelegate, BTHomepageViewDelegate>

@property (nonatomic, strong)BTTableview *tableView;


@property (nonatomic, strong) NSMutableDictionary *dicCell;

@end

@implementation BTHomedetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _dicCell = [[NSMutableDictionary alloc] init];

//        [self setupTableView];
        
    }
    return self;
}


- (void)initCreatTableview{

    [self setupTableView];
}

- (void)setupTableView{
    
    self.tableView = [[BTTableview alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, _heightTab)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 200;
    
    [self.tableView hiddenFreshFooter];
    
    _tableView.scrollEnabled = NO;

    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, _tableView.bottom + 20, FULL_WIDTH, 20)];
    
    labTitle.text = @"随便看看";

    labTitle.textAlignment = NSTextAlignmentCenter;
    
    labTitle.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.tableView];
    
    [self addSubview:labTitle];
    
}

#pragma mark - BTHomepageViewDelegate

- (void)reloadTableView:(NSInteger)indexpath height:(CGFloat)height {
    
    BTHomePageTableViewCell *announcementCell = [_dicCell objectForKey:[NSString stringWithFormat:@"indexPath%ld", indexpath]];
    
    announcementCell.heightCell = height;
    
    [self.tableView reloadData];
    
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
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
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    [cell.btnAtten addTarget:self action:@selector(onclickBtnAtten:) forControlEvents:UIControlEventTouchUpInside];
    
//    [cell makeDatacell:indexPath.row];
    
    if (![[_dicCell allKeys] containsObject:[NSString stringWithFormat:@"indexPath%ld", indexPath.row]]) {
        
        [_dicCell setObject:cell forKey:[NSString stringWithFormat:@"indexPath%ld", indexPath.row]];
        
    }
    
    return cell;
}


- (void)onclickBtnAtten:(UIButton *)btn{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"取消关注" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"置顶该用户" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:defaultAction];
    [alertController addAction:destructiveAction];
    [alertController addAction:cancelAction];
    
    
}


@end
