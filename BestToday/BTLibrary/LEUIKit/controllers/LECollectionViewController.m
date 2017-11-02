//
//  LECollectionViewController.h
//  LEFinanceNewsIphone
//
//  Created by wangfaquan on 17/5/9.
//  Copyright © 2017年 wangfaquan. All rights reserved.
//

#import "LECollectionViewController.h"
#import "MLTRefreshHeader.h"
#import "MLTLoadingFooter.h"
#import "MLTCollectionView+MLTBrokenNetwork.h"




@interface LECollectionViewController () <MLTPagerViewDelegate>

@end

@implementation LECollectionViewController

#pragma mark - view life

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCollectionView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.collectionView mlt_loadFirstPage];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setAutoShowBrokenNetwork:(BOOL)autoShowBrokenNetwork {
    self.collectionView.autoShowBrokenNetwork = autoShowBrokenNetwork;
}

#pragma mark - init ui

- (void)initCollectionView {
    
    _collectionView = [[MLTCollectionView alloc] initWithFrame:CGRectMake(0, MLTFULLNAVBAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - MLTFULLNAVBAR_HEIGHT) collectionViewLayout:[UICollectionViewFlowLayout new]];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.backgroundView = nil;
    _collectionView.mlt_pagerDelegate = self;
    _collectionView.mlt_headerView = [MLTRefreshHeader new];
    _collectionView.mlt_footerView = (MLTBaseRefreshFooter *)[MLTLoadingFooter new];
    _collectionView.mlt_enablePager = NO;
    _collectionView.mlt_enableRefresh = NO;
    [self.view addSubview:_collectionView];
}

#pragma mark - private method

- (void)resignKeyBoard {
    
    [self.collectionView endEditing:YES];
}

#pragma mark - setter

- (void)setCollectionView:(MLTCollectionView *)collectionView {
    
    [_collectionView removeFromSuperview];
    _collectionView = collectionView;
    _collectionView.frame = CGRectMake(0, STATUSBAR_HEIGHT + NAVBAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - STATUSBAR_HEIGHT + NAVBAR_HEIGHT);
    [self.view addSubview:_collectionView];
}

#pragma mark - MLTPagerViewDelegate

- (void)mltPagerView:(UIScrollView *)scrollView
            loadPage:(NSInteger)page
             success:(void (^)(NSArray *list, NSInteger page, BOOL hasMore))success
              failed:(void (^)(NSError *))failed {
    
    if ([self.pagerDelegate respondsToSelector:@selector(mltCollectionView:loadPage:success:failed:)]) {
        
        [self.pagerDelegate mltCollectionView:self.collectionView loadPage:page success:success failed:failed];
    }
}


#pragma mark - setter

- (void)setEnableRefresh:(BOOL)enableRefresh {
    
    _collectionView.mlt_enableRefresh = enableRefresh;
}

- (void)setEnablePager:(BOOL)enablePager {
    
    _collectionView.mlt_enablePager = enablePager;
}

@end
