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
#import "BtHomePageService.h"


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
    
//    [cell.btnAtten addTarget:self action:@selector(onclickBtnAtten:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.detailService.arrDetailResource.count > 0) {
        
        [cell makeDatacellData:[self.detailService.arrDetailResource objectAtIndex:indexPath.row] index:indexPath.row];

    }
    
    
    [cell.btnAttenOne addTarget:self action:@selector(onclickBtnAtten:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.btnAtten.tag = indexPath.row + 10000;
    
    _heightCells = cell.heightCell;
    
    
    return cell;
}


- (void)onclickBtnAtten:(UIButton *)btn{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择操作" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ComplaintAction = [UIAlertAction actionWithTitle:@"举报..." style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择原因" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"发布低俗内容" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self requestComplaint:11 resourceId:btn.tag];
            
        }];
        
        
        UIAlertAction *canAction = [UIAlertAction actionWithTitle:@"发布违法内容" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self requestComplaint:12 resourceId:btn.tag];
            
        }];
        
        
        UIAlertAction *ComplaintAction = [UIAlertAction actionWithTitle:@"侵犯知识产权" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self requestComplaint:13 resourceId:btn.tag];
            
            
        }];
        
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消投诉" style:UIAlertActionStyleCancel handler:nil];
        
        
        [alertController addAction:destructiveAction];
        
        [alertController addAction:canAction];
        
        [alertController addAction:ComplaintAction];
        
        [alertController addAction:cancelAction];
        
        
        [self.viewController presentViewController:alertController animated:YES completion:nil];
        
        
    }];
    
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"拉黑该用户" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"拉黑该用户后，您将不再关注TA，并屏蔽TA的文章" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alert show];
    
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:ComplaintAction];
    [alertController addAction:destructiveAction];
    [alertController addAction:cancelAction];
    
    [self.viewController presentViewController:alertController animated:YES completion:nil];

}

// 投诉接口
- (void)requestComplaint:(NSInteger)index resourceId:(NSInteger)resourceId{
    
    BtHomePageService *homePageService = [BtHomePageService new];
    
    BTHomePageEntity *pageEntity = [_detailService.arrDetailResource objectAtIndex:0];
    
    [homePageService loadComplaintUser:[pageEntity.resourceId integerValue] userId:[[pageEntity.userVo valueForKey:@"userId"] integerValue]  feedbackType:index completion:^(BOOL isSuccess, BOOL isCache) {
        
        [SVProgressHUD showWithStatus:@"拉黑成功"];
        
        [SVProgressHUD dismissWithDelay:0.3f];
        
    }];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
 
    if (buttonIndex == 1) {
        
        [self requestComplaint:14 resourceId:0];

    }
}


//获取View所在的Viewcontroller方法
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - lazy
- (BTHomeDetailService *)detailService{
    if (!_detailService) {
        _detailService = [[BTHomeDetailService alloc] init];
    }
    return _detailService;
}



@end
