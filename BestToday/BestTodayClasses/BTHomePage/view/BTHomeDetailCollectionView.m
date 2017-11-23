//
//  BTHomeDetailCollectionView.m
//  BestToday
//
//  Created by leeco on 2017/11/14.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTHomeDetailCollectionView.h"
#import "LECollectionView.h"
#import "BTMeCollectionViewCell.h"
#import "BTDiscoverHeaderView.h"
#import "BTHomeDetailService.h"
#import "BTHomedetailCollectionViewCell.h"

static NSString *const cellId = @"cellId";

@interface BTHomeDetailCollectionView()<UICollectionViewDelegate, UICollectionViewDataSource, LEBaseCollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSString *lpage;

@property (nonatomic, assign) BOOL isPullup;

@property (nonatomic, assign) BOOL isMoreData;

@property (nonatomic, strong) BTHomeDetailService *detailService;

@property (nonatomic, strong) NSString *pageAssistParam;


@end

@implementation BTHomeDetailCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpCollectionViewWithFrame:frame];
        
        [self requestRecommendResourceByPage];
    }
    return self;
}

- (void)setUpCollectionViewWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[LECollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [_collectionView registerClass:[BTHomedetailCollectionViewCell class] forCellWithReuseIdentifier:@"BTHomedetailCollectionViewCell"];

    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.dataDelegate = self;
    [self addSubview:_collectionView];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
}


- (void)requestRecommendResourceByPage{
   
    [self.detailService loadRecommendResourceByPage:1 pageAssistParam:_pageAssistParam resourceIds:@"18301" completion:^(BOOL isSuccess, BOOL isCache, NSString *pageAssistParam) {
        
        [self.collectionView stop];
        
        if (isSuccess) {
            
            [self.collectionView reloadData];
            
        }

        
    }];

}


#pragma mark ---- CollectionView 数据源

- (void)requestDataSource{
    if (_discoverCVDelegate && [_discoverCVDelegate respondsToSelector:@selector(requestDataSource)]) {
        [_discoverCVDelegate requestDataSource];
    }
}

- (void)requestMoreDataSource{
    if (_discoverCVDelegate && [_discoverCVDelegate respondsToSelector:@selector(requestMoreDataSource)]) {
        [_discoverCVDelegate requestMoreDataSource];
    }
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _detailService.arrDetailResourceByPage.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor purpleColor];
    
    static NSString * CellIdentifier = @"BTHomedetailCollectionViewCell";

    BTHomedetailCollectionViewCell * cell = (BTHomedetailCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell makeDetailRecomendCellData:[self.detailService.arrDetailResourceByPage objectAtIndex:indexPath.item]];
    
    return cell;
}

// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (_discoverCVDelegate && [_discoverCVDelegate respondsToSelector:@selector(collectionView: viewForSupplementaryElementOfKind:atIndexPath:)]) {
        return [_discoverCVDelegate collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
    }else{
        return nil;
    }
    
}

#pragma mark ---- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){(FULL_WIDTH - 10)/3,(FULL_WIDTH - 10)/3};
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.5f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.5f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (_discoverCVDelegate && [_discoverCVDelegate respondsToSelector:@selector(collectionView: layout:referenceSizeForHeaderInSection:)]) {
        return  [_discoverCVDelegate collectionView:collectionView layout:collectionViewLayout referenceSizeForHeaderInSection:section];
    }else{
        return (CGSize){0,0};
    }
}

#pragma mark ---- UICollectionViewDelegate

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_discoverCVDelegate && [_discoverCVDelegate respondsToSelector:@selector(collectionView: didSelectItemAtIndexPath:)]) {
        [_discoverCVDelegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - lazy
- (BTHomeDetailService *)detailService{
    if (!_detailService) {
        _detailService = [[BTHomeDetailService alloc] init];
    }
    return _detailService;
}

@end
