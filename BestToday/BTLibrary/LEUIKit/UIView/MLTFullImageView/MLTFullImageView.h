//
//  MLTFullImageView.h
//  AMCustomer
//
//  Created by WangFaquan on 16/9/5.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
  * 创建一个点击图片放大显示的视图
  * 方法中支持url展示 和image展示
 */


@protocol MLTFullImageViewDelegate <NSObject>

/**
 * 点击图片的代理方法
 */
- (void)clickImageViewDismiss;

@end

@interface MLTFullImageView : UIView<UIScrollViewDelegate>

@property(nonatomic,assign)id<MLTFullImageViewDelegate>delegate;


/**
 *  点击相应的图片来显示
 *
 *  @param imageArr   存放图片或者图片Url的数组
 *  @param Index      点击相应图片的索引查找显示对应的图片
 *  @param isUrl      是否是以Url来显示大图
 */

- (void)clickShowFullImageView:(NSArray *)imageArr Index:(NSInteger)index isUrl:(BOOL)isUrl;


/**
 *  显示视图
 */
- (void)showFullImageView:(UIView *)view;


/**
 *  隐藏视图
 */
- (void)hideFullImageView:(UIView *)view;


@end
