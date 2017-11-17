//
//  MLTSegementView.h
//  AMCustomer
//
//  Created by WangFaquan on 16/9/23.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TouchLabelIndexBlock)();

@protocol MLTTouchLabelDelegate <NSObject>

- (void)touchLabelWithIndex:(NSInteger)index;

@end

@interface MLTSegementView : UIView

/**
 *  标题数组
 */
@property ( nonatomic, strong) NSArray *titleArray;

/**
 *  标题颜色
 */
@property ( nonatomic, strong) UIColor *titleColor;

/**
 *  标题被选中的颜色
 */
@property ( nonatomic, strong) UIColor *titleSelectedColor;

/**
 *  滚动条
 */
@property ( nonatomic, strong) UIView *scrollLine;

/**
 *  滚动条颜色
 */
@property ( nonatomic, strong) UIColor *scrollLineColor;

/**
 *  分割线颜色
 */
@property ( nonatomic, strong) UIColor *separateColor;

/**
 *  分割线
 */
@property ( nonatomic, strong) UIView *separateLine;

/**
 *  滚动条高度
 */
@property ( nonatomic, assign) float scrollLineHeight;

/**
 *  分割线高度
 */
@property ( nonatomic, assign) float separateHeight;

/**
 *  标题字体大小
 */
@property ( nonatomic, assign) CGFloat titleFont;

/**
 *  是否有竖直分割线
 */
@property ( nonatomic, assign) BOOL haveRightLine;


@property ( nonatomic, assign) CGFloat offestX;


@property ( nonatomic, strong) id<MLTTouchLabelDelegate>touchDelegate;

//根据titleArray配置label
- (void)configSubLabel;

//选中指定位置label
- (void)selectLabelWithIndex:(NSInteger)index;

@end
