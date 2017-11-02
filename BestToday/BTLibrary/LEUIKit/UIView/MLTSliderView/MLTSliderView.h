//
//  MLTSliderView.h
//  AMCustomer
//
//  Created by WangFaquan on 16/9/2.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLTPageControl.h"
#import "SwipeView.h"

/**
 
 * 创建sliderView 就是一个无线轮播功能
 
 * 原理就类似是创建一个tableview ，添加他的各种代理方法设置代理MLTSliderViewDelegate，MLTSliderViewDataSource
 
 */

@protocol MLTSliderViewDelegate;
@protocol MLTSliderViewDataSource;

@interface MLTSliderView : UIView <SwipeViewDelegate, SwipeViewDataSource>

@property(nonatomic, strong) MLTPageControl *pageControl;


@property(nonatomic, readonly) SwipeView *swipeView;

@property(nonatomic, weak) id <MLTSliderViewDelegate> delegate;

@property(nonatomic, weak) id <MLTSliderViewDataSource> dataSource;

/**
 *  距离下边界的高度
 */
@property(nonatomic) NSInteger bottomHeight;

/**
 *  当前选中的dot的颜色
 */
@property(nonatomic, strong) NSString *currentPageDotColor;


/**
 *  其余未选中的dot的颜色
 */
@property (nonatomic, strong) NSString *otherPageDotColor;



/**
 *  pageControlStyle 等于0为默认样式，等于1的话图片模式
 */
@property (nonatomic) NSInteger pageControlStyle;


/**
 *   pageControl中dot的大小
 */
@property (nonatomic, assign) CGSize pageDotSize;


/**
 *   pageControl中dot的直径，仅限于圆点对图片样式的不起作用
 */
@property (nonatomic) NSInteger diameter;


/**
 *   pageControl中相邻dot之间的间距
 */
@property (nonatomic, assign) NSInteger gapWidth;


/**
 * 所有页面的数量
 */
@property (nonatomic, readonly) NSInteger totalItemCount;

/**
 * 现在页面的索引
 */
@property (nonatomic, assign) NSInteger currentIndex;

/**
 * 现在页面的显示的view
 */
@property (nonatomic) UIView *currentItemView;

/**
 * 是否启用循环滚动
 */
@property (nonatomic, assign) BOOL wrapEnabled;

/**
 * 是否启用自动滚动
 */
@property (nonatomic, assign) BOOL autoScroll;


/**
 * 当只有一张图片的时候禁用滚动
 */
@property (nonatomic) BOOL disableScrollOnlyOneImage;

/**
 * 重载数据
 */
- (void)reloadData;

/**
 * 滚动到指定的项
 */
- (void)scrollToItemAtIndex:(NSInteger)index;

@end

@protocol MLTSliderViewDelegate <NSObject>

@optional
/**
 *  选中了 SliderView 中某个 cell
 *
 *  @param swipeView swipeView
 *  @param index      cell 的索引
 */
- (void)sliderView:(MLTSliderView *)sliderView didSelectViewAtIndex:(NSInteger)index;

/**
 *  SliderView 滚动到某个 cell
 *
 *  @param swipeView swipeView
 *  @param index      cell 的索引
 */
- (void)sliderView:(MLTSliderView *)sliderView didSliderToIndex:(NSInteger)index;

- (void)sliderViewDidScroll:(MLTSliderView *)sliderView;

- (void)sliderViewWillBeginDragging:(MLTSliderView *)sliderView;

- (void)sliderViewDidEndDragging:(MLTSliderView *)sliderView willDecelerate:(BOOL)decelerate;

- (void)sliderViewWillBeginDecelerating:(MLTSliderView *)sliderView;

- (void)sliderViewDidEndDecelerating:(MLTSliderView *)sliderView;

- (void)sliderViewDidEndScrollingAnimation:(MLTSliderView *)sliderView;

@end


/**
 *  MLTSliderViewDataSource
 
 *  这些方法都是必需要实现的类似tableview的DataSource
 
 */
@protocol MLTSliderViewDataSource <NSObject>

@required
/**
 *  swipeView 中的 cell 数量
 *
 *  @param swipeView swipeView
 *
 *  @return cell 数量
 */
- (NSInteger)numberOfItemsInSliderView:(MLTSliderView *)sliderView;

/**
 *  某个索引的 view
 *
 *  @param swipeView swipeView
 *  @param index      index
 *
 *  @return 这个Slider要显示的view
 */
- (UIView *)sliderView:(MLTSliderView *)sliderView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view;


@end


