//
//  BTSpreadTableView.h
//  BestToday
//
//  Created by leeco on 2017/11/6.
//  Copyright © 2017年 leeco. All rights reserved.

#import <UIKit/UIKit.h>

/**
 
 封装这个tableview主要是为了以后侧着滑动的时候可以共用
 
 写个tableview把tableview旋转一下
 
 通过下面的枚举来定义不同的样式cell
 
 主要思想就是把tableview贴在这个view上
 
 */

typedef enum {
    
    BTSpreadTableViewStyleImageText,      // 带图片和文字的
    
} BTSpreadTableViewStyle;

@protocol BTSpreadTableViewDelegate <NSObject>


// 点击跳转方法
//- (void)spreadTableViewIndex:(NSInteger)index withData:(id)data WithStyle:(MLTSpreadTableViewStyle)style;

@optional


- (void)spreadTableViewDidSelectMore;


// 滑动时记住tableview的位置
- (void)spreadTableViewContentOffset:(CGFloat)contentOffsetY;


@end

@interface BTSpreadTableView : UITableView

@property (nonatomic, assign)id <BTSpreadTableViewDelegate> spreadDelegate;


@property (nonatomic, assign)BTSpreadTableViewStyle type;

// 存储所有数据
@property (nonatomic, retain)NSArray *dataArr;


// 需要的特殊数组
@property (nonatomic, strong)NSArray *dateAll;

// 查看更多的个数
@property (nonatomic) int moreCount;

@property (nonatomic) int stockCount;


/**
 * 当有数据时，把数据传进来
 */
- (void)refreshData:(NSArray *)data;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style withType:(BTSpreadTableViewStyle)type;


@end
