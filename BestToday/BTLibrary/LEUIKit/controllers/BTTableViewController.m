//
//  LETableViewController.h
//  LEFinanceNewsIphone
//
//  Created by wangfaquan on 17/5/9.
//  Copyright © 2017年 wangfaquan. All rights reserved.
//

#import "BTTableViewController.h"
#import "MLTRefreshHeader.h"
#import "MLTLoadingFooter.h"
#import "MLTTableView+MLTBrokenNetwork.h"

@interface BTTableViewController () <MLTPagerViewDelegate>

@end

@implementation BTTableViewController

#pragma mark - view life

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;

    
    [self initTableView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView mlt_loadFirstPage];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setAutoShowBrokenNetwork:(BOOL)autoShowBrokenNetwork {
    self.tableView.autoShowBrokenNetwork = autoShowBrokenNetwork;
}

#pragma mark - init ui 

- (void)initTableView {
    
    _tableView = [[MLTTableView alloc] initWithFrame:CGRectMake(0, MLTFULLNAVBAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - MLTFULLNAVBAR_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.backgroundView = nil;
    _tableView.mlt_pagerDelegate = self;
    _tableView.mlt_headerView = [MLTRefreshHeader new];
    _tableView.mlt_footerView = [MLTLoadingFooter new];
    _tableView.mlt_enablePager = NO;
    _tableView.mlt_enableRefresh = NO;
    [self.view addSubview:_tableView];
}

#pragma mark - private method 

- (void)resignKeyBoard {
    
    [self.tableView endEditing:YES];
}

#pragma mark - MLTPagerViewDelegate

- (void)mltPagerView:(UIScrollView *)scrollView
            loadPage:(NSInteger)page
             success:(void (^)(NSArray *list, NSInteger page, BOOL hasMore))success
              failed:(void (^)(NSError *))failed {
    
    if ([self.pagerDelegate respondsToSelector:@selector(mltTableView:loadPage:success:failed:)]) {
        [self.pagerDelegate mltTableView:self.tableView loadPage:page success:success failed:failed];
    }
}


#pragma mark - setter

- (void)setEnableRefresh:(BOOL)enableRefresh {
    
    _tableView.mlt_enableRefresh = enableRefresh;
}

- (void)setEnablePager:(BOOL)enablePager {
    
    _tableView.mlt_enablePager = enablePager;
}

@end
