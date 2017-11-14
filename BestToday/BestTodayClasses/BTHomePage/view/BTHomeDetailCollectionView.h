//
//  BTHomeDetailCollectionView.h
//  BestToday
//
//  Created by leeco on 2017/11/14.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LECollectionView.h"

@protocol BTHomeDetailCollectionViewDelegate <NSObject>

- (void)requestDataSource;

@optional

- (void)requestMoreDataSource;

// 点击选择 代理
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

// collectionView header footer 代理
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;

//collectionView header  size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;

@end


@interface BTHomeDetailCollectionView : UIView

@property (nonatomic, assign)id <BTHomeDetailCollectionViewDelegate> discoverCVDelegate;

@property (nonatomic, strong) LECollectionView *collectionView;

//- (void)setDataForCollectionView:(NSArray *)data;


@end
