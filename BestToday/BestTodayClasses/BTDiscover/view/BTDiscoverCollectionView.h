//
//  BTDiscoverCollectionView.h
//  BestToday
//
//  Created by 王卓 on 2017/11/7.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LECollectionView.h"

@protocol BTDiscoverCollectionViewDelegate <NSObject>

- (void)requestDataSource;

@optional

- (void)requestMoreDataSource;

// 点击选择 代理
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

// collectionView header footer 代理
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;

//collectionView header  size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end

@interface BTDiscoverCollectionView : UIView

@property (nonatomic, strong) LECollectionView *collectionView;
@property (nonatomic, assign)id <BTDiscoverCollectionViewDelegate> discoverCVDelegate;

- (void)setDataForCollectionView:(NSMutableArray *)data;

@end
