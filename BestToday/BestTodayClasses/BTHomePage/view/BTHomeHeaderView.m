//
//  BTHomeHeaderView.m
//  BestToday
//
//  Created by leeco on 2017/11/24.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTHomeHeaderView.h"
#import "BTHomePageTableViewCell.h"
#import "BTHomeDetailPageTableViewCell.h"
#import "BTHomeDetailService.h"


@interface BTHomeHeaderView ()<UITableViewDataSource, UITableViewDelegate, BTHomepageDetailViewDelegate>

@property (nonatomic, strong)BTTableview *tableView;

@property (nonatomic, strong) BTHomeDetailService *detailService;

@property (nonatomic, strong) NSMutableDictionary *dicCell;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, assign) CGFloat heightCells;


@end

@implementation BTHomeHeaderView

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
    
    [self requestDetailResourceTwo];
}

- (void)setupTableView{
    
    _tableView = [[BTTableview alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 500)];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    _tableView.estimatedRowHeight = 100;
    
    [_tableView hiddenFreshFooter];
    
    _tableView.scrollEnabled = NO;
        
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, _tableView.bottom + 20, FULL_WIDTH, 20)];
    
    _labTitle.text = @"随便看看";
    
    _labTitle.textAlignment = NSTextAlignmentCenter;
    
    _labTitle.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_tableView];
    
    [self addSubview:_labTitle];
    
}

- (void)reloadTableViewheight:(CGFloat)height{

    if ([_delegate respondsToSelector:@selector(reloadTwoCollection:)]) {
        
        _tableView.frame = CGRectMake(0, 0, FULL_WIDTH, height);
        
        _labTitle.frame = CGRectMake(0, _tableView.bottom + 20, FULL_WIDTH, 20);
        
        [self.delegate reloadTwoCollection:height + 50];
    }

}

- (void)reloadTableviewDatas{
  
    [self.tableView reloadData];
}

- (void)requestDetailResourceTwo{
    
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
    
    
    return 800;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString * const cellID = @"BTHomePageTableViewCell";
    
    BTHomeDetailPageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    cell.backgroundColor = [UIColor redColor];
    
    if (!cell) {
        
        cell = [[BTHomeDetailPageTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    cell.delegate = self;

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
