//
//  LETableViewController.h
//  LEFinanceNewsIphone
//
//  Created by wangfaquan on 17/5/9.
//  Copyright © 2017年 wangfaquan. All rights reserved.
//

#import "BTViewController.h"
#import "MLTTableView.h"

@protocol MLTTableViewControllerDelegate <NSObject>

/**
 *  当ViewDidLoad、用户上拉刷新、下拉加载更多，该方法被回调
 *
 */
- (void)mltTableView:(MLTTableView *)tableView
            loadPage:(NSInteger)page
             success:(void (^)(NSArray *list, NSInteger page, BOOL hasMore))success
              failed:(void (^)(NSError *))failed;

@end

@interface BTTableViewController : BTViewController

@property (nonatomic)MLTTableView *tableView;

@property (nonatomic,weak)id<MLTTableViewControllerDelegate> pagerDelegate;

/**
 *  是否允许刷新，默认为NO
 */
@property (nonatomic) BOOL enableRefresh;

/**
 *  是否允许分页，默认为NO
 */
@property (nonatomic) BOOL enablePager;

/*
 *  10.27  是否自动开启断网提示view，铺满整个tableview，默认是NO
 *         暂时的逻辑是这样的：只有当从来没有从接口获得过数据并且网络错误时才显示，否则显示之前的数据即可
 */

@property (nonatomic, assign) BOOL autoShowBrokenNetwork;

@end
