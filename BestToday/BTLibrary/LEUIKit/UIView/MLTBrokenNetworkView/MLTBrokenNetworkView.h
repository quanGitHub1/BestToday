//
//  MLTBrokenNetworkView.h
//  AMCustomer
//
//  Created by 恺撒 on 16/9/26.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  9.26  断网提示重新加载view，先临时写着，出UI后会调整
 *  10.26 取消代理的回调方式，改成block
 */

@class MLTBrokenNetworkView;

typedef void (^clickedHandler) (MLTBrokenNetworkView *brokenView);

@interface MLTBrokenNetworkView : UIView

@property (nonatomic, copy) clickedHandler handler;

/*
 *  应用此方法初始化就好
 */
- (instancetype)initWithFrame:(CGRect)frame;

/*
 *  应用此方法初始化一次传两个参数
 */
- (instancetype)initWithFrame:(CGRect)frame clickedHandler:(clickedHandler)handler;

@end
