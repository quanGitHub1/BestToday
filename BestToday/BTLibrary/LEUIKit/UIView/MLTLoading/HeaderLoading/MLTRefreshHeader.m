//
//  MLTBaseRefreshHeader.h
//  LEFinanceNewsIphone
//
//  Created by wangfaquan on 17/5/9.
//  Copyright © 2017年 wangfaquan. All rights reserved.
//


#import "MLTRefreshHeader.h"
#import "MLTRefreshIndicatorView.h"

#define kIndicatorViewSize 30

@interface MLTRefreshHeader () {
    
    MLTRefreshIndicatorView *_indicatorView;
}

@end

@implementation MLTRefreshHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _indicatorView = [[MLTRefreshIndicatorView alloc] initWithTintFontColor:nil tintBackColor:nil size:kIndicatorViewSize];
        [self addSubview:_indicatorView];
    }
    return self;
}

#pragma mark - Instance Method

- (void)startAnimating {
    
    [_indicatorView startAnimating];
}

- (void)stopAnimating {
    
    [_indicatorView stopAnimating];
}

#pragma mark - 覆盖父类方法

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    _indicatorView.progress = self.pullingPercent;
    _indicatorView.center = CGPointMake(self.width/2.f, self.height/2.f);
}

- (void)setState:(MJRefreshState)state {
    
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateRefreshing ) {
        
        [self startAnimating];
        
    } else if (state == MJRefreshStateNoMoreData || state == MJRefreshStateIdle) {
        
        [self stopAnimating];
    }
}

@end
