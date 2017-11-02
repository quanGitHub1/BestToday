//
//  UIScrollView+MLTPager.h
//  LEFinanceNewsIphone
//
//  Created by wangfaquan on 17/5/9.
//  Copyright © 2017年 wangfaquan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLTBaseRefreshHeader.h"
#import "MLTBaseRefreshFooter.h"
#import "MLTPagerViewDelegate.h"

@interface UIScrollView (MLTPager)

/**
 *  数据源
 */
@property (nonatomic) NSMutableArray *mlt_dataArray;

/**
 *  是否正在加载
 */
@property (nonatomic,readonly) BOOL mlt_isLoading;

/**
 *  当前要加载的页码
 */
@property (nonatomic,readonly) NSInteger mlt_page;

/**
 *  是否还有更多数据
 */
@property (nonatomic,readonly) BOOL mlt_hasMore;

/**
 *  上拉未开始进行加载时底部提示语，默认【上拉加载更多】
 */
@property (nonatomic) NSString *mlt_footerIdleText ;

/**
 *  上拉将要开始进行加载时底部提示语，默认【松开加载更多】
 */
@property (nonatomic) NSString *mlt_footerPullingText;

/**
 *  上拉正在进行加载时底部提示语，默认【加载中...】
 */
@property (nonatomic) NSString *mlt_footerRefreshingText;

/**
 *  上拉没有更多可加载数据时底部提示语，默认【没有更多数据了】
 */
@property (nonatomic) NSString *mlt_footerNoMoreDataText;

/**
 *  下拉刷新时headerView，可子类化MLTBaseRefreshHeader进行定制
 */
@property (nonatomic) MLTBaseRefreshHeader *mlt_headerView;

/**
 *  下拉刷新时footerView，可子类化MLTBaseRefreshFooter进行定制
 */
@property (nonatomic) MLTBaseRefreshFooter *mlt_footerView;

/**
 *  分页代理对象
 */
@property (nonatomic,weak) id<MLTPagerViewDelegate> mlt_pagerDelegate;

/**
 *  是否允许刷新，默认为YES
 */
@property (nonatomic) BOOL mlt_enableRefresh;

/**
 *  是否允许分页，默认为YES
 */
@property (nonatomic) BOOL mlt_enablePager;


/**
 *  初始化下拉刷新和上拉加载view
 */
- (void)mlt_initRereshHeaderAndFooter;

/**
 *  加载第一页
 */
- (void)mlt_loadFirstPage;

/**
 *  加载下一页
 */
- (void)mlt_loadNextPage;

@end
