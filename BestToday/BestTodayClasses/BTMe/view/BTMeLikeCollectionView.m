//
//  BTMeLikeCollectionView.m
//  BestToday
//
//  Created by leeco on 2017/11/27.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTMeLikeCollectionView.h"
#import "MLTWaterflowLayout.h"
#import "LECollectionView.h"
#import "BTMeCollectionViewCell.h"
#import "BTMeService.h"
#import "BTHomePageDetailViewController.h"

@interface BTMeLikeCollectionView() <UICollectionViewDelegate, UICollectionViewDataSource, LEBaseCollectionViewDelegate, MLTWaterflowLayoutDelegate>

@property (nonatomic, strong) NSString *lpage;

@property (nonatomic, assign) BOOL isPullup;

@property (nonatomic, assign) BOOL isMoreData;

@property (nonatomic, strong) LECollectionView *collectionView;

@property (nonatomic, strong) BTMeService *meService;

@property (nonatomic, strong) NSString *pageAssistParam;

@end

@implementation BTMeLikeCollectionView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self creatTableview];
        
        [self loadData];
        
    }
    
    return self;
}

-(void)initDataAndView{
    [self creatTableview];
}


- (void)creatTableview{
    
    //创建布局
    MLTWaterflowLayout * layout = [[MLTWaterflowLayout alloc]init];
    
    layout.delegate = self;
    
    _collectionView = [[LECollectionView alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, self.height) collectionViewLayout:layout];
    
    [_collectionView registerClass:[BTMeCollectionViewCell class] forCellWithReuseIdentifier:@"BTMeCollectionViewCell"];
    
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
    
    _collectionView.dataDelegate = self;
    
    //    [_collectionView autoRefreshLoad];
    
    [self addSubview:_collectionView];
}

- (void)requestDataSource{
    
    _pageAssistParam = @""; //时表示默认请求第一页
    
    [_collectionView resetNoMoreData];
    
    [self loadData];
}

- (void)requestMoreDataSource{
    
    if (self.meService.arrCommentResource.count % 10  != 0) {
        [self.collectionView noDataFooterEndRefreshing];
        
    }else{
        [self loadData];
    }
    
}

- (void)loadData{
    
    [self requestqueryMyResourceByPage];
}

- (void)requestqueryMyResourceByPage{
    
    [self.meService loadqueryCommentResourceByPage:1 pageAssistParam:_pageAssistParam completion:^(BOOL isSuccess, BOOL isCache, NSString *pageAssistParam) {
        
        [self.collectionView stop];
        
        _pageAssistParam = pageAssistParam;
        
        if (isSuccess) {
            
            [self.collectionView reloadData];
            
        }

    }];
    
}

#pragma mark - UICollectionViewDelegate / UICollectionViewDataSource / UICollectionViewDelegateFlowLayout

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.meService.arrCommentResource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * CellIdentifier = @"BTMeCollectionViewCell";
    
    BTMeCollectionViewCell * cell = (BTMeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell makeLiveFiannceCellData:[self.meService.arrCommentResource objectAtIndex:indexPath.item]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BTHomePageDetailViewController *homePagedetail = [[BTHomePageDetailViewController alloc] init];
    
    BTMeResourceVoList *ResourceVoList = [self.meService.arrCommentResource objectAtIndex:indexPath.row];
    
    homePagedetail.resourceId = ResourceVoList.resourceId;
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

#pragma mark - <WaterflowLayoutDelegate>
/** 行之间的高度 */
-(CGFloat)waterflowLayout:(MLTWaterflowLayout*)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth {
    
    return (FULL_WIDTH - 3)/ 3;
}

//瀑布流列数
- (CGFloat)columnCountInWaterflowLayout:(MLTWaterflowLayout *)waterflowLayout {
    return 3;
}

// 列间距
- (CGFloat)columnMarginInWaterflowLayout:(MLTWaterflowLayout *)waterflowLayout {
    return 2;
}

// 行间距
- (CGFloat)rowMarginInWaterflowLayout:(MLTWaterflowLayout *)waterflowLayout {
    return 2;
}

// 这个是collection的离屏幕的距离
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(MLTWaterflowLayout *)waterflowLayout {
    return UIEdgeInsetsMake(0, 0, 10, 0); // 上左下右
}

#pragma mark - lazy
- (BTMeService *)meService {
    if (!_meService) {
        _meService = [[BTMeService alloc] init];
    }
    return _meService;
}


@end
