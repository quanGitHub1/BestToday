//
//  BTMessageViewController.h
//  BestToday
//
//  Created by 王卓 on 2017/11/20.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTViewController.h"
#import "BTMessageEntity.h"
/** @brief tabeleView的cell高度 */
#define KCELLDEFAULTHEIGHT 50.0

@interface BTMessageViewController : BTViewController

/*!
 @property
 @brief 当前页面显示时，是否滚动到最后一条
 */
@property (nonatomic) BOOL scrollToBottomWhenAppear; //default YES;

/*!
 @property
 @brief 页面是否处于显示状态
 */
@property (nonatomic) BOOL isViewDidAppear;
/*!
 @property
 @brief 加载的每页message的条数
 */
@property (nonatomic) NSInteger messageCountOfPage; //default 50

/*!
 @property
 @brief 时间分割cell的高度
 */
@property (nonatomic) CGFloat timeCellHeight;

/*!
 @property
 @brief 时间间隔标记
 */
@property (nonatomic) NSTimeInterval messageTimeIntervalTag;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) BTMessageEntity *messageEntity;



@end
