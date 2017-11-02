//
//  UIScrollView+MLTPager.h
//  LEFinanceNewsIphone
//
//  Created by wangfaquan on 17/5/9.
//  Copyright © 2017年 wangfaquan. All rights reserved.
//

#import "UIScrollView+MLTPager.h"
#import <objc/runtime.h>
#import "MJRefresh.h"

#define kMLTRefreshAutoFooterIdleText @"上拉加载更多"
#define kMLTRefreshAutoFooterPullingText @"松开加载更多"
#define kMLTRefreshAutoFooterRefreshingText @"加载中..."
#define kMLTRefreshAutoFooterNoMoreDataText @"没有更多数据了"


static const char *MLTPagerDataArrayKey = "MLTPagerDataArrayKey";
static const char *MLTPagerIsLoadingKey = "MLTPagerIsLoadingKey";
static const char *MLTPagerPageKey = "MLTPagerPageKey";
static const char *MLTPagerHasMoreKey = "MLTPagerHasMoreKey";
static const char *MLTPagerFooterIdleTextKey = "MLTPagerFooterIdleTextKey";
static const char *MLTPagerFooterPullingTextKey = "MLTPagerFooterPullingTextKey";
static const char *MLTPagerFooterRefreshingTextKey = "MLTPagerFooterRefreshingTextKey";
static const char *MLTPagerFooterNoMoreDataTextKey = "MLTPagerFooterNoMoreDataTextKey";
static const char *MLTPagerHeaderViewKey = "MLTPagerHeaderViewKey";
static const char *MLTPagerFooterViewKey = "MLTPagerFooterViewKey";
static const char *MLTPagerDelegateKey = "MLTPagerDelegateKey";
static const char *MLTPagerEnableRefreshKey = "MLTPagerEnableRefreshKey";
static const char *MLTPagerEnablePagerKey = "MLTPagerEnablePagerKey";


@implementation UIScrollView (MLTPager)

#pragma mark - pulic method

- (void)mlt_initRereshHeaderAndFooter {
    
    __unsafe_unretained UIScrollView *scrollView = self;
    
    // 下拉刷新
    self.mlt_enableRefresh = YES;
    scrollView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [scrollView mlt_loadFirstPage];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    scrollView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉加载
    self.mlt_enablePager = YES;
    scrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [scrollView mlt_loadNextPage];
    }];
    
    [self mlt_setFooterTips];
}

- (void)mlt_setFooterTips {
    
    MJRefreshFooter *footer = self.mj_footer;
    if ([footer isKindOfClass:[MJRefreshBackNormalFooter class]]) {
        
        [((MJRefreshBackNormalFooter *)footer) setTitle:self.mlt_footerIdleText ?: kMLTRefreshAutoFooterIdleText
                                               forState:MJRefreshStateIdle];
        [((MJRefreshBackNormalFooter *)footer) setTitle:self.mlt_footerPullingText ?: kMLTRefreshAutoFooterPullingText
                                               forState:MJRefreshStatePulling];
        [((MJRefreshBackNormalFooter *)footer) setTitle:self.mlt_footerRefreshingText ?: kMLTRefreshAutoFooterRefreshingText
                                               forState:MJRefreshStateRefreshing];
        [((MJRefreshBackNormalFooter *)footer) setTitle:self.mlt_footerNoMoreDataText ?: kMLTRefreshAutoFooterNoMoreDataText
                                               forState:MJRefreshStateNoMoreData];
    }
}

#pragma mark - pager related

- (void)mlt_loadFirstPage {
    
    self.mlt_dataArray = nil;
    self.mlt_page = 0;
    self.mlt_hasMore = YES;
    [self mlt_loadNextPage];
}

- (void)mlt_loadNextPage {
    
    if (self.mlt_isLoading) return;
    
    if (!self.mlt_hasMore)  {
        
        // 恢复header、footer状态
        [self.mj_header endRefreshing];
        [self.mj_footer endRefreshing];
        return;
    };
    
    NSInteger nextPage = self.mlt_page + 1;
    self.mlt_isLoading = YES;
    if ([self.mlt_pagerDelegate respondsToSelector:@selector(mltPagerView:loadPage:success:failed:)]) {
        
        [self.mlt_pagerDelegate mltPagerView:self
                                    loadPage:nextPage
                                     success:^(NSArray *list, NSInteger page, BOOL hasMore) {
                                         
                                         self.mlt_page = page;
                                         self.mlt_hasMore = hasMore;
                                         self.mlt_isLoading = NO;
                                         
                                         if (self.mlt_page == 1) {
                                             
                                             // 第一页时，恢复分页状态
                                             [self.mj_footer resetNoMoreData];
                                             
                                             // 第一页时，必然是下拉，停止header动画
                                             [self.mj_header endRefreshing];
                                         }
                                         else {
                                             
                                             // 非第一页时，必然是上拉，停止footer动画
                                             [self.mj_footer endRefreshing];
                                         }
                                         
                                         // 最后一页时展示无更多数据
                                         if (!self.mlt_hasMore) {
                                             
                                             [self.mj_footer endRefreshingWithNoMoreData];
                                         }
                                         
                                         if ( self.mlt_page <= 1 ){
                                             
                                             self.mlt_dataArray = [NSMutableArray arrayWithArray:list];
                                         }
                                         else{
                                             
                                             [self.mlt_dataArray addObjectsFromArray:list];
                                         }
                                         [self mlt_dataDidLoad];
                                     }
                                      failed:^(NSError *error) {
                                          [self.mj_header endRefreshing];
                                          [self.mj_footer endRefreshing];
                                          self.mlt_isLoading = NO;
                                          
                                          [self mlt_dataFailLoad];
                                          
                                      }];
    }
}

- (void)mlt_dataDidLoad {
    
}

- (void)mlt_dataFailLoad {
    
}

#pragma mark - setter

- (void)setMlt_dataArray:(NSMutableArray *)dataArray {
    
    objc_setAssociatedObject(self, &MLTPagerDataArrayKey,dataArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMlt_isLoading:(BOOL)isLoading {
    
    NSNumber *isLoadingState = @(0);
    if (isLoading) {
        
        isLoadingState = @(1);
    }
    objc_setAssociatedObject(self, &MLTPagerIsLoadingKey,isLoadingState, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMlt_page:(NSInteger)page {
    
    NSNumber *pageInfo = @(page);
    objc_setAssociatedObject(self, &MLTPagerPageKey,pageInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMlt_hasMore:(BOOL)hasMore {
    
    NSNumber *hasMoreState = @(0);
    if (hasMore) {
        
        hasMoreState = @(1);
    }
    objc_setAssociatedObject(self, &MLTPagerHasMoreKey,hasMoreState, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMlt_footerIdleText:(NSString *)footerIdleText {
    
    objc_setAssociatedObject(self, &MLTPagerFooterIdleTextKey,footerIdleText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMlt_footerPullingText:(NSString *)footerPullingText {
    
    objc_setAssociatedObject(self, &MLTPagerFooterPullingTextKey,footerPullingText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMlt_footerRefreshingText:(NSString *)footerRefreshingText {
    
    objc_setAssociatedObject(self, &MLTPagerFooterRefreshingTextKey,footerRefreshingText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMlt_footerNoMoreDataText:(NSString *)footerNoMoreDataText {
    
    objc_setAssociatedObject(self, &MLTPagerFooterNoMoreDataTextKey,footerNoMoreDataText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMlt_headerView:(MLTBaseRefreshHeader *)headerView {
    
    objc_setAssociatedObject(self, &MLTPagerHeaderViewKey,headerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [headerView setRefreshingTarget:self refreshingAction:@selector(mlt_loadFirstPage)];
    self.mj_header = headerView;
}

- (void)setMlt_footerView:(MLTBaseRefreshFooter *)footerView {
    
    objc_setAssociatedObject(self, &MLTPagerFooterViewKey,footerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [footerView setRefreshingTarget:self refreshingAction:@selector(mlt_loadNextPage)];
    self.mj_footer = footerView;
}


- (void)setMlt_pagerDelegate:(id<MLTPagerViewDelegate>)pagerDelegate {
    
    objc_setAssociatedObject(self, &MLTPagerDelegateKey,pagerDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (void)setMlt_enableRefresh:(BOOL)mlt_enableRefresh {
    
    NSNumber *enableRefreshState = @(0);
    if (mlt_enableRefresh) {
        
        enableRefreshState = @(1);
    }
    objc_setAssociatedObject(self, &MLTPagerEnableRefreshKey,enableRefreshState, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.mj_header = nil;
    if (mlt_enableRefresh) {
        
        self.mj_header = self.mlt_headerView;
    }
}

- (void)setMlt_enablePager:(BOOL)mlt_enablePager {
    
    NSNumber *pagerEnableState = @(0);
    if (mlt_enablePager) {
        
        pagerEnableState = @(1);
    }
    objc_setAssociatedObject(self, &MLTPagerEnablePagerKey,pagerEnableState, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.mj_footer = nil;
    if (mlt_enablePager) {
        
        self.mj_footer = self.mlt_footerView;
        [self mlt_setFooterTips];
    }
}

#pragma mark - getter

- (NSMutableArray *)mlt_dataArray {
    
    return objc_getAssociatedObject(self, &MLTPagerDataArrayKey);
}

- (BOOL)mlt_isLoading {
    
    NSNumber *isLoadingState = objc_getAssociatedObject(self, &MLTPagerIsLoadingKey);
    return [isLoadingState boolValue];
}

- (NSInteger)mlt_page {
    
    NSNumber *pageInfo = objc_getAssociatedObject(self, &MLTPagerPageKey);;
    return [pageInfo integerValue];
}

- (BOOL)mlt_hasMore {
    
    NSNumber *hasMoreState = objc_getAssociatedObject(self, &MLTPagerHasMoreKey);
    return [hasMoreState boolValue];
}

- (NSString *)mlt_footerIdleText {
    
    return objc_getAssociatedObject(self, &MLTPagerFooterIdleTextKey);
}

- (NSString *)mlt_footerPullingText {
    
    return objc_getAssociatedObject(self, &MLTPagerFooterPullingTextKey);
}

- (NSString *)mlt_footerRefreshingText {
    
    return objc_getAssociatedObject(self, &MLTPagerFooterRefreshingTextKey);
}

- (NSString *)mlt_footerNoMoreDataText {
    
    return objc_getAssociatedObject(self, &MLTPagerFooterNoMoreDataTextKey);
}

- (MLTBaseRefreshHeader *)mlt_headerView {
    
    return objc_getAssociatedObject(self, &MLTPagerHeaderViewKey);
}

- (MLTBaseRefreshFooter *)mlt_footerView {
    
    return objc_getAssociatedObject(self, &MLTPagerFooterViewKey);
}

- (id<MLTPagerViewDelegate>)mlt_pagerDelegate {
    
    return objc_getAssociatedObject(self, &MLTPagerDelegateKey);
}

- (BOOL)mlt_enableRefresh {
    
    NSNumber *enableRefreshState = objc_getAssociatedObject(self, &MLTPagerEnableRefreshKey);
    return [enableRefreshState boolValue];
}

- (BOOL)mlt_enablePager {
    
    NSNumber *enablePagerState = objc_getAssociatedObject(self, &MLTPagerEnablePagerKey);
    return [enablePagerState boolValue];
}

@end
