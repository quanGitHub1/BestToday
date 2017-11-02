//
//  LECollectionView.m
//  LEFinanceNewsIphone
//
//  Created by leeco on 2017/8/2.
//  Copyright © 2017年 wangfaquan. All rights reserved.
//

#import "LECollectionView.h"

static NSInteger const maxCount = 10000;


@implementation LECollectionView

/**
 *  初始化
 */
- (instancetype) initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setUpRefresh];
//        [self mlt_initRereshHeaderAndFooter];
        
    }
    return self;
}

-(void)setParentView:(UIView *)parentView
{
    _parentView = parentView;
    
    BOOL nodate = !_nodataView?YES:[_nodataView isHidden];
    BOOL noNet = !_noNetView?YES:[_noNetView isHidden];
    
    //清空后重设
    [_nodataView removeFromSuperview];
    _nodataView = nil;
    [_noNetView removeFromSuperview];
    _noNetView = nil;
    
    if(_nodataView==nil)
    {
        //添加失败界面
        _nodataView = [[UIView alloc]init];
        CGRect failframe = CGRectMake(self.x, self.y, self.width, self.height);
        [_nodataView setFrame:failframe];
        [_nodataView setBackgroundColor:[UIColor whiteColor]];
        //失败图片
        UIImage *failImg = [UIImage imageNamed:@"default_noData.png"];
        UIImageView *imgView = [[UIImageView alloc]initWithImage:failImg];
        [imgView setFrame:CGRectMake(0,0,self.width, self.height*0.8)];
        //设置居中对齐
        [imgView setContentMode:UIViewContentModeCenter];
        [_nodataView addSubview:imgView];
        
        UILabel *tipLabel = [[UILabel alloc]init];
        tipLabel.frame = CGRectMake(0, imgView.height/2+60, self.width, 30);
        tipLabel.textColor = kExcerptColor;
        tipLabel.font = [UIFont systemFontOfSize:14];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"这里什么都没有～";
        [imgView addSubview:tipLabel];
        
        UIButton *errorbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [errorbtn setFrame:imgView.frame];
        [errorbtn addTarget:self action:@selector(errorbtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_nodataView addSubview:errorbtn];
        _nodataView.hidden = nodate;
        [_parentView addSubview:_nodataView];
        [_parentView bringSubviewToFront:_nodataView];
    }
    
    if(_noNetView==nil)
    {
        //添加无网络界面
        _noNetView = [[UIView alloc]init];
        CGRect failframe = CGRectMake(self.x, self.y, self.width, self.height);
        [_noNetView setFrame:failframe];
        [_noNetView setBackgroundColor:[UIColor whiteColor]];
        //图片
        UIImage *failImg = [UIImage imageNamed:@"default_noNet.png"];
        UIImageView *imgView = [[UIImageView alloc]initWithImage:failImg];
        [imgView setFrame:CGRectMake(0,0,self.width, self.height*0.8)];
        //设置居中对齐
        [imgView setContentMode:UIViewContentModeCenter];
        [_noNetView addSubview:imgView];
        
        UILabel *tipLabel = [[UILabel alloc]init];
        tipLabel.frame = CGRectMake(0, imgView.height/2+60, self.width, 30);
        tipLabel.textColor = kExcerptColor;
        tipLabel.font = [UIFont systemFontOfSize:14];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"网络丢失了，刷新重试哦！";
        [imgView addSubview:tipLabel];
        
        UIButton *errorbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [errorbtn setFrame:imgView.frame];
        [errorbtn addTarget:self action:@selector(errorbtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_noNetView addSubview:errorbtn];
        _noNetView.hidden = noNet;
        [_parentView addSubview:_noNetView];
        [_parentView bringSubviewToFront:_noNetView];
    }
}


- (void)refreshCustomBackgroudView{
    //重设高度
    CGFloat height = self.frame.size.height;
    CGRect changeFrame = self.frame;
    changeFrame.size.height = height;
    self.frame = changeFrame;
    _nodataView.frame = changeFrame;
    _noNetView.frame = changeFrame;
}

//加载失败按钮点击
- (void)errorbtnClick {
    if (self.mj_header.isRefreshing) {
        return;
    }
    //隐藏失败视图 显示加载视图
    _nodataView.hidden = YES;
    _noNetView.hidden = YES;
    //点击后重新刷新
    [self autoRefreshLoad];
}

-(void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    if (hidden) {
        _nodataView.y = kSCREEN_HEIGHT * maxCount;
        _noNetView.y = kSCREEN_HEIGHT * maxCount;
    }
    else{
        _nodataView.y = self.y;
        _noNetView.y = self.y;
    }
}

#pragma mark 实现父类方法
- (void)setLayoutFrame:(CGRect)pRect {
    [self setFrame:pRect];
    
    [self setFrame:CGRectMake(0, 0, CGRectGetWidth(pRect), CGRectGetHeight(pRect))];
    _nodataView.frame = self.frame;
    _noNetView.frame = self.frame;
}

#pragma mark - 刷新方法
- (void)setUpRefresh{
    //1.下拉刷新
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    self.mj_header.automaticallyChangeAlpha = YES;
    //2.上拉加载更多
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
}
#pragma mark 自动刷新
- (void)autoRefreshLoad {
    if (self.mj_header.isRefreshing) {
        return;
    }
    _nodataView.hidden = YES;
    _noNetView.hidden = YES;
    [self.mj_header beginRefreshing];
}
//头部刷新
- (void)headRefresh {
    if (self.mj_header.isRefreshing) {
        return;
    }
    [self.mj_header beginRefreshing];
}

//隐藏头部刷新
-(void)hiddenFreshHead {
    //隐藏下拉刷新，但是会留有空白
    self.mj_header.hidden = YES;
    //设置高度去掉空白，如果改为0会有问题，所以改成最小值，这里取得1像素
    self.mj_header.height = 1;
}

//隐藏尾部刷新
-(void)hiddenFreshFooter{
    self.mj_footer.hidden = YES;
}


//结束后隐藏
- (void)hiddenFooterEndRefreshing{
    [self.mj_footer endRefreshing];
    // 隐藏当前的上拉刷新控件
    self.mj_footer.hidden = YES;
}

//结束后提示无数据
- (void)noDataFooterEndRefreshing{
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)resetNoMoreData{
    [self.mj_footer resetNoMoreData];
}

#pragma mark 头部刷新
- (void)headerRereshing {
    if ([NetworkHelper isNetwork]) {
        _noNetView.hidden = YES;
    }else{
        _noNetView.hidden = NO;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        if ([self.dataDelegate respondsToSelector:@selector(requestDataSource)]) {
            [self.dataDelegate requestDataSource];
        }
    });
}

#pragma mark 底部刷新
- (void)footerRereshing {
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        if ([self.dataDelegate respondsToSelector:@selector(requestMoreDataSource)]) {
            [self.dataDelegate requestMoreDataSource];
        }
    });
}

//停止网络请求
- (void)stop {
    if (self.mj_header.isRefreshing) {
        [self.mj_header endRefreshing];
    }
    if (self.mj_footer.isRefreshing) {
        [self.mj_footer endRefreshing];
    }
}

@end
