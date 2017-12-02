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
#import "BTHomeHeaderView.h"
#import "BTHomedetailHeaderView.h"
#import "BTHomePageDetailViewController.h"
#import "BTHomePageEntity.h"

static NSString *const cellId = @"cellId";

static NSString *const headerId = @"headerId";


@interface BTHomeDetailCollectionView()<UICollectionViewDelegate, UICollectionViewDataSource, LEBaseCollectionViewDelegate, UICollectionViewDelegateFlowLayout, HomeDetailheaderDelegate>

@property (nonatomic, strong) NSString *lpage;

@property (nonatomic, assign) BOOL isPullup;

@property (nonatomic, assign) BOOL isMoreData;

@property (nonatomic, strong) BTHomeDetailService *detailService;

@property (nonatomic, strong) NSString *pageAssistParam;

@property (nonatomic, assign) CGFloat heightCell;

@property (nonatomic, assign) CGFloat heightCellTwo;

@property (nonatomic, assign) CGRect frames;


@property (nonatomic, strong) BTHomeHeaderView *headerViews;


@end

@implementation BTHomeDetailCollectionView

- (instancetype)initWithFrame:(CGRect)frame resourceId:(NSString *)resourceId
{
    if (self = [super initWithFrame:frame]) {
        
        _frames = frame;
        
        _headerViews = [[BTHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, 800)];
        
        _headerViews.resourceId = resourceId;
        
        _resourceId = resourceId;
        
        _headerViews.delegate = self;
        
        [_headerViews initCreatTableview];
        
        [self addSubview:_headerViews];
        
        _headerViews.hidden = YES;
        
        
    }
    return self;
}


- (void)setUpCollectionViewWithFrame:(CGRect)frame{
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[LECollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [_collectionView registerClass:[BTHomedetailCollectionViewCell class] forCellWithReuseIdentifier:@"BTHomedetailCollectionViewCell"];
    
      [_collectionView registerClass:[BTHomedetailHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];

    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.dataDelegate = self;
    [self addSubview:_collectionView];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
}


- (void)loadData{
    
    [self requestRecommendResourceByPage];
}


/** 请求推荐图片 */
- (void)requestRecommendResourceByPage{
   
    [self.detailService loadRecommendResourceByPage:1 pageAssistParam:_pageAssistParam resourceIds:@"18301" completion:^(BOOL isSuccess, BOOL isCache, NSString *pageAssistParam) {
        
        [self.collectionView stop];
        
        _pageAssistParam = pageAssistParam;
        
        if (isSuccess) {
            
            [self.collectionView reloadData];
        }

    }];

}

#pragma mark ---- CollectionView 数据源

- (void)requestDataSource{
   
    _pageAssistParam = @"";
    
    [_collectionView resetNoMoreData];

    
    [self loadData];
    
}

- (void)requestMoreDataSource{
    
    
    if (self.detailService.arrDetailResourceByPage.count % 10  != 0) {
        [self.collectionView noDataFooterEndRefreshing];
        
    }else{
        [self loadData];
    }
   
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _detailService.arrDetailResourceByPage.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * CellIdentifier = @"BTHomedetailCollectionViewCell";

    BTHomedetailCollectionViewCell * cell = (BTHomedetailCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell makeDetailRecomendCellData:[self.detailService.arrDetailResourceByPage objectAtIndex:indexPath.item]];
    
    return cell;
}

// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    BTHomedetailHeaderView *headerView = nil;
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        
        headerView.clipsToBounds = YES;
        
        headerView.backgroundColor = [UIColor whiteColor];
        
        headerView.resourceId = _resourceId;
        
        [headerView initCreatTableview];
        
        headerView.delegate = self;
        
        return headerView;
    }
    
    return nil;
}

// 拿到高度返回
-(void)reloadTwoCollection:(CGFloat)height{
    
    _heightCell = height;
    
    [self setUpCollectionViewWithFrame:_frames];
    
    [self loadData];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){FULL_WIDTH, _heightCell > 0 ? _heightCell : 0};

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


#pragma mark ---- UICollectionViewDelegate

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    BTHomePageDetailViewController *homePagedetail = [[BTHomePageDetailViewController alloc] init];
    
    BTHomePageEntity *PageEntity = [_detailService.arrDetailResourceByPage objectAtIndex:indexPath.row];
    
    homePagedetail.resourceId = PageEntity.resourceId;
    
    [[self viewController].navigationController pushViewController:homePagedetail animated:YES];
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - lazy
- (BTHomeDetailService *)detailService{
    if (!_detailService) {
        _detailService = [[BTHomeDetailService alloc] init];
    }
    return _detailService;
}

@end
