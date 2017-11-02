//
//  MLTLoadingFooter.h
//  LEFinanceNewsIphone
//
//  Created by wangfaquan on 17/5/9.
//  Copyright © 2017年 wangfaquan. All rights reserved.
//

#import "MLTLoadingFooter.h"
#import "MLTRefreshIndicatorView.h"

#define kMLTLoadingFooterIdleText @"上拉加载更多"
#define kMLTLoadingFooterPullingText @"松开加载更多"
#define kMLTLoadingFooterRefreshingText @"加载中..."
#define kMLTLoadingFooterNoMoreDataText @"哎呦，到底啦~"

#define kIndicatorViewSize 20

#define kMLTLoadingTipLabelWidth 90
#define kMLTLoadingTipLabelHeight 12

@interface MLTLoadingFooter () {
    
    MLTRefreshIndicatorView *_indicatorView;
    UILabel *_tipLabel;
}
@end

@implementation MLTLoadingFooter

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSubviews];
    }
    return self;
}

#pragma mark - Private Method

- (void)setupSubviews {
    
    _tipLabel = [UILabel new];
    _tipLabel.font = [UIFont boldSystemFontOfSize:12];
    _tipLabel.textColor = HEX(@"c09034");
    _tipLabel.frame = CGRectMake((SCREEN_WIDTH - kMLTLoadingTipLabelWidth) / 2.f + kIndicatorViewSize + 10, 16, kMLTLoadingTipLabelWidth, kMLTLoadingTipLabelHeight);
    [self addSubview:_tipLabel];
    
    _indicatorView = [[MLTRefreshIndicatorView alloc] initWithTintFontColor:nil tintBackColor:nil size:kIndicatorViewSize];
    _indicatorView.centerY = _tipLabel.centerY;
    _indicatorView.right = _tipLabel.left - 10;
    [self addSubview:_indicatorView];
}

#pragma mark - Instance Method

- (void)startAnimating {
    
    [_indicatorView startAnimating];
}

- (void)stopAnimating {
    
    [_indicatorView stopAnimating];
}

#pragma mark - 重写父类的方法

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    if (self.state != MJRefreshStateNoMoreData) {
        
        _indicatorView.progress = self.pullingPercent;
    }
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
    // 内容的高度
    CGFloat contentHeight = self.scrollView.mj_contentH + self.ignoredScrollViewContentInsetBottom;
    // 表格的高度
    CGFloat scrollHeight = self.scrollView.mj_h - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom + self.ignoredScrollViewContentInsetBottom;
    // 设置位置和尺寸
    self.mj_y = MAX(contentHeight, scrollHeight);
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 设置
    _indicatorView.hidden = NO;
    _tipLabel.centerX = self.width / 2.f + kIndicatorViewSize + 10;
    _indicatorView.centerY = _tipLabel.centerY;
    _indicatorView.right = _tipLabel.left - 10;
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
    
        _tipLabel.text = kMLTLoadingFooterIdleText;
        [self stopAnimating];
    } else if (state == MJRefreshStatePulling) {
        
        _tipLabel.text = kMLTLoadingFooterPullingText;
        [self stopAnimating];
    } else if (state == MJRefreshStateRefreshing) {
        
        _tipLabel.text = kMLTLoadingFooterRefreshingText;
        [self startAnimating];
    } else if (state == MJRefreshStateNoMoreData) {
        
        _indicatorView.hidden = YES;
        _tipLabel.text = kMLTLoadingFooterNoMoreDataText;
        _tipLabel.centerX = self.width / 2.f;
        [self stopAnimating];
    }
}

@end

