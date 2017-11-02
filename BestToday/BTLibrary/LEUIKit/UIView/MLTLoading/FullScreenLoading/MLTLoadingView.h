//
//  MLTLoadingView.h
//  AMCustomer
//
//  Created by aimei on 16/9/5.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 **  发起请求时的loading框
*/
@interface MLTLoadingView : UIView

/**
 *  在指定的 view 中显示 loadingView
 *
 *  @param view     需要加 loading 的 view
 *  @param animated 是否需要动画
 *
 *  @return MLTLoadingView实例
 */
+ (MLTLoadingView *)showInView:(UIView *)view animated:(BOOL)animated;

+ (MLTLoadingView *)showInView:(UIView *)view animated:(BOOL)animated backgoundColor:(UIColor *)color;

/**
 *  请求结束时隐藏 loadingView
 *
 *  @param view     需要加 loading 的 view
 *  @param animated 是否需要动画
 *
 *  @return YES or NO 
 */
+ (BOOL)hideActivityIndicatorForView:(UIView *)view animated:(BOOL)animated;

@end
