//
//  BTHomedetailHeaderView.m
//  BestToday
//
//  Created by leeco on 2017/11/14.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTHomedetailHeaderView.h"
#import "BTHomeDetailPageTableViewCell.h"
#import "BTHomeDetailService.h"


@interface BTHomedetailHeaderView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)BTTableview *tableView;

@property (nonatomic, strong) BTHomeDetailService *detailService;

@property (nonatomic, strong) NSMutableDictionary *dicCell;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, assign) CGFloat heightCells;

@end

@implementation BTHomedetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}


- (void)initCreatTableview{
    
    _dicCell = [[NSMutableDictionary alloc] init];

    [self setupTableView];
    
    [self requestDetailResource];
}

- (void)setupTableView{
    
    self.tableView = [[BTTableview alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, self.height - 50)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 400;
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView hiddenFreshFooter];
    
    _tableView.scrollEnabled = NO;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, _tableView.bottom + 20, FULL_WIDTH, 20)];
    
    _labTitle.text = @"随便看看";

    _labTitle.textAlignment = NSTextAlignmentCenter;
    
    _labTitle.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.tableView];
    
    [self addSubview:_labTitle];
    
}


- (void)requestDetailResource{
    
    [self.detailService loadqueryResourceDetail:[_resourceId integerValue] completion:^(BOOL isSuccess, BOOL isCache) {
        
        if (isSuccess) {
            
            [_tableView reloadData];
            
        }
        
    }];
}


#pragma mark - BTHomepageViewDelegate

- (void)reloadTableView:(NSInteger)indexpath height:(CGFloat)height {
    
    BTHomeDetailPageTableViewCell *announcementCell = [_dicCell objectForKey:[NSString stringWithFormat:@"indexPath%ld", indexpath]];
    
    announcementCell.heightCell = height;
    
    [self.tableView reloadData];
    
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return _heightCells;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString * const cellID = @"mindCell";
    
    BTHomeDetailPageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    
    if (!cell) {
        
        cell = [[BTHomeDetailPageTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    [cell.btnAtten addTarget:self action:@selector(onclickBtnAtten:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.detailService.arrDetailResource.count > 0) {
        
        [cell makeDatacellData:[self.detailService.arrDetailResource objectAtIndex:indexPath.row] index:indexPath.row];

    }
    
    _heightCells = cell.heightCell;
    
    
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

#pragma mark - lazy
- (BTHomeDetailService *)detailService{
    if (!_detailService) {
        _detailService = [[BTHomeDetailService alloc] init];
    }
    return _detailService;
}

@end
