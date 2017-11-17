//
//  MLTWaterflowLayout.h
//  AMCustomer
//
//  Created by WangFaquan on 16/10/31.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLTWaterflowLayout;

@protocol MLTWaterflowLayoutDelegate <NSObject>

/**
 *	@brief	cell的高度
 *
 *	@param 	waterflowLayout
 *	@param 	index 	某个cell
 *	@param 	itemWidth 	cell的宽度
 *
 *	@return	cell高度
 */
- (CGFloat)waterflowLayout:(MLTWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional

/**瀑布流的列数*/
- (CGFloat)columnCountInWaterflowLayout:(MLTWaterflowLayout *)waterflowLayout;

/**每一列之间的间距*/
- (CGFloat)columnMarginInWaterflowLayout:(MLTWaterflowLayout *)waterflowLayout;

/**每一行之间的间距*/
- (CGFloat)rowMarginInWaterflowLayout:(MLTWaterflowLayout *)waterflowLayout;

/**cell边缘的间距*/
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(MLTWaterflowLayout *)waterflowLayout;

@end


@interface MLTWaterflowLayout : UICollectionViewLayout

@property (nonatomic, assign) id<MLTWaterflowLayoutDelegate> delegate;
@end
