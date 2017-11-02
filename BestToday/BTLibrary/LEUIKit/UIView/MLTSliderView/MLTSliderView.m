//
//  MLTSliderView.m
//  AMCustomer
//
//  Created by WangFaquan on 16/9/2.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#import "MLTSliderView.h"
#import "MLTTimer.h"

#define kBundleImage(name) ([NSString stringWithFormat:@"MLTUIKit.bundle/pagecontrol/%@.png", name])

static const float SliderBannerChangeInterval = 5.0f;

static const double SliderAutoScrollDuration = 0.4;

@interface MLTSliderView (){
    
  __weak NSTimer *_timer;
        
}

@end

@implementation MLTSliderView

@synthesize pageControl = pageControl;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self creatViews];
    }
    return self;
}


#pragma mark -- creatView
- (void)creatViews {
    if (nil == _swipeView) {
        _swipeView = [[SwipeView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _swipeView.backgroundColor = [UIColor clearColor];
        _swipeView.delegate = self;
        _swipeView.dataSource = self;
        _swipeView.wrapEnabled = YES;
        _swipeView.pagingEnabled = YES;
        [self addSubview:_swipeView];
    }
    
    if (nil == pageControl) {
        pageControl = [[MLTPageControl alloc] initWithFrame:CGRectMake(0, 0, self.width, 40)];
        pageControl.bottom = self.height - 3;
        pageControl.hidesForSinglePage = YES;
        pageControl.userInteractionEnabled = NO;

        if (pageControl.pageControlStyle == 1) {
            
            [pageControl setPageControlStyle:PageControlStyleThumb];
            
            [pageControl setThumbImage:[UIImage imageNamed:kBundleImage(@"pagecontrol-thumb-normal")]];
            
            [pageControl setSelectedThumbImage:[UIImage imageNamed:kBundleImage(@"pagecontrol-thumb-selected")]];
            
        } else {
            
            [pageControl setPageControlStyle:PageControlStyleDefault];

            // 设置选中颜色
            [pageControl setCurrentPageDotColor:[UIColor colorWithHexString:_currentPageDotColor.length > 0 ? _currentPageDotColor : @"#fd5456"]];


            // 设置未选中颜色
            
            [pageControl setOtherPageDotColor:[UIColor colorWithHexString:_otherPageDotColor.length > 0 ? _otherPageDotColor : @"#e2e2e2"]];

        }
        
        [pageControl setDiameter:_diameter > 0 ? _diameter : 12];

        [pageControl setGapWidth:_gapWidth > 0 ? _gapWidth : 10];
        
        [self addSubview:pageControl];
    }
}

#pragma mark -- Properties

- (NSInteger)totalItemCount {
    return _swipeView.numberOfItems;
}

- (NSInteger)currentIndex {
    return _swipeView.currentItemIndex;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _swipeView.currentItemIndex = currentIndex;
    self.pageControl.currentPage = currentIndex;
}

- (UIView *)currentItemView {
    
    return _swipeView.currentItemView;
}


- (BOOL)wrapEnabled {
    return _swipeView.wrapEnabled;
}

- (void)setWrapEnabled:(BOOL)wrapEnabled {
    _swipeView.wrapEnabled = wrapEnabled;
}


- (void)setAutoScroll:(BOOL)autoScroll {
    _autoScroll = autoScroll;
    if (_autoScroll) {
        [self startAnimation];
    }
    else {
        [self stopAnimation];
    }
}

#pragma mark -- Animation

- (void)stopAnimation {
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)startAnimation {
    if (!_timer) {
        
        _timer = [MLTTimer scheduledTimerWithTimeInterval:SliderBannerChangeInterval block:^(id userInfo) {
            
            [self step];
            
        } userInfo:nil repeats:YES ];
        
        // 如果需求中要求滑动scrollview停止轮播图滑动，请注释掉下面的的2行代码
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
    }
}

#pragma mark -- MLTSliderViewDataSource

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfItemsInSliderView:)]) {
        return [self.dataSource numberOfItemsInSliderView:self];
    }
    return 0;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(sliderView:viewForItemAtIndex:reusingView:)]) {
        return [self.dataSource sliderView:self viewForItemAtIndex:index reusingView:view];
    }
    return nil;
}

- (void)reloadData {
    [_swipeView reloadData];
    [self reloadPageControl];
}

- (void)reloadPageControl {
    pageControl.width = self.width / 3.0f * 2;
    pageControl.centerX = self.width / 2;
    
    pageControl.numberOfPages = _swipeView.numberOfPages;
    
    pageControl.currentPage = self.currentIndex;
    
    if (_bottomHeight > 0) {
        
        pageControl.bottom = self.height - _bottomHeight;

    }else {
        
        pageControl.bottom = self.height - 3;

    }
    
    
    if (_swipeView.numberOfPages <= 1 && self.disableScrollOnlyOneImage) {
        _swipeView.scrollEnabled = NO;
    }
}

- (void)step {
    if (!_swipeView.isScrolling) {
        [_swipeView scrollToItemAtIndex:_swipeView.currentItemIndex + 1 duration:SliderAutoScrollDuration];
    }
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    if (self.window && self.autoScroll) {
        [self startAnimation];
    }
    else{
        [self stopAnimation];
    }
}

- (void)scrollToItemAtIndex:(NSInteger)index {
    [_swipeView scrollToItemAtIndex:index duration:SliderAutoScrollDuration];
}


#pragma mark -- SwipeViewDelegate

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView {
    pageControl.currentPage = swipeView.currentItemIndex;
    if ([self.delegate respondsToSelector:@selector(sliderView:didSliderToIndex:)]) {
        [self.delegate sliderView:self didSliderToIndex:swipeView.currentItemIndex];
    }
    
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(sliderView:didSelectViewAtIndex:)]) {
        [self.delegate sliderView:self didSelectViewAtIndex:index];
    }
    
}

- (void)swipeViewDidScroll:(SwipeView *)swipeView {
    if ([self.delegate respondsToSelector:@selector(sliderViewDidScroll:)]) {
        [self.delegate sliderViewDidScroll:self];
    }
}

- (void)swipeViewWillBeginDragging:(SwipeView *)swipeView {
    if (self.autoScroll) {
        [self stopAnimation];
    }
    
    if ([self.delegate respondsToSelector:@selector(sliderViewWillBeginDragging:)]) {
        [self.delegate sliderViewWillBeginDragging:self];
    }
}

- (void)swipeViewDidEndDragging:(SwipeView *)swipeView willDecelerate:(BOOL)decelerate {
    if (self.autoScroll) {
        [self startAnimation];
    }
    if ([self.delegate respondsToSelector:@selector(sliderViewDidEndDragging:willDecelerate:)]) {
        [self.delegate sliderViewDidEndDragging:self willDecelerate:decelerate];
    }
}

- (void)swipeViewWillBeginDecelerating:(SwipeView *)swipeView {
    if ([self.delegate respondsToSelector:@selector(sliderViewWillBeginDecelerating:)]) {
        [self.delegate sliderViewWillBeginDecelerating:self];
    }
}

- (void)swipeViewDidEndDecelerating:(SwipeView *)swipeView {
    if ([self.delegate respondsToSelector:@selector(sliderViewDidEndDecelerating:)]) {
        [self.delegate sliderViewDidEndDecelerating:self];
    }
}

- (void)swipeViewDidEndScrollingAnimation:(SwipeView *)swipeView {
    if ([self.delegate respondsToSelector:@selector(sliderViewDidEndScrollingAnimation:)]) {
        [self.delegate sliderViewDidEndScrollingAnimation:self];
    }
}

@end
