//
//  LECollectionView.h
//  LEFinanceNewsIphone
//
//  Created by leeco on 2017/8/2.
//  Copyright © 2017年 wangfaquan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJRefresh;

@protocol LEBaseCollectionViewDelegate <NSObject>

- (void)requestDataSource;//下拉刷新的回调

@optional

- (void)requestMoreDataSource;//上拉加载更多

@end


@interface LECollectionView : UICollectionView

@property (nonatomic,strong) UIView *nodataView;
@property (nonatomic,strong) UIView *noNetView;
@property (nonatomic,weak)  UIView *parentView;
@property (nonatomic,weak) id<LEBaseCollectionViewDelegate>dataDelegate;

//
//自动刷新
- (void)autoRefreshLoad;

//头部刷新
- (void)headRefresh;

//隐藏头部刷新
-(void)hiddenFreshHead;

//隐藏尾部刷新
-(void)hiddenFreshFooter;

//结束后隐藏
- (void)hiddenFooterEndRefreshing;

//结束后提示无数据
- (void)noDataFooterEndRefreshing;
- (void)resetNoMoreData;

//停止网络请求
- (void)stop;

//重设高度
- (void)refreshCustomBackgroudView;



@end
