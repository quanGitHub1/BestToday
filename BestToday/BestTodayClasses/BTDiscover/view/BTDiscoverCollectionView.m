//
//  BTDiscoverCollectionView.m
//  BestToday
//
//  Created by 王卓 on 2017/11/7.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTDiscoverCollectionView.h"
#import "BTDiscoverCell.h"
#import "BTDiscoverEntity.h"

@interface BTDiscoverCollectionView ()<LEBaseCollectionViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end


@implementation BTDiscoverCollectionView

static NSString *const cellId = @"cellId";
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _dataArray = [NSMutableArray array];
        [self setUpCollectionViewWithFrame:frame];
    }
    return self;
}

- (void)setUpCollectionViewWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[LECollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.dataDelegate = self;
    [_collectionView autoRefreshLoad];
    [_collectionView hiddenFreshFooter];
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[BTDiscoverCell class] forCellWithReuseIdentifier:cellId];
}

- (void)setDataForCollectionView:(NSMutableArray *)data{
    _dataArray = data;
    [_collectionView reloadData];
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
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BTDiscoverEntity *entity = _dataArray[indexPath.row];
    BTDiscoverCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithHexString:entity.backgroundColor];
    cell.imageUrl = entity.smallPicUrl;
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
    if (_discoverCVDelegate && [_discoverCVDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [_discoverCVDelegate scrollViewDidScroll:scrollView];
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



@end
