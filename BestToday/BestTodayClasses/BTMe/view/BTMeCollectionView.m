//
//  BTMeCollectionView.m
//  BestToday
//
//  Created by leeco on 2017/11/10.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTMeCollectionView.h"
#import "MLTWaterflowLayout.h"
#import "LECollectionView.h"
#import "BTMeCollectionViewCell.h"

@interface BTMeCollectionView()<UICollectionViewDelegate, UICollectionViewDataSource, LEBaseCollectionViewDelegate, MLTWaterflowLayoutDelegate>

@property (nonatomic, strong) NSString *lpage;

@property (nonatomic, assign) BOOL isPullup;

@property (nonatomic, assign) BOOL isMoreData;

@property (nonatomic, strong) LECollectionView *collectionView;

@end

@implementation BTMeCollectionView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
       [self creatTableview];

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
    
    _lpage = @""; // _lpage = nil 时表示默认请求第一页
    
    _isMoreData = NO;
    
    _isPullup = NO;
    
//    [self loadLiveVideoList];
}

- (void)requestMoreDataSource{
    
    self.isPullup = YES;
    
    if (!_isMoreData) {
        
//        [self loadLiveVideoList];
        
    }else{
        [self.collectionView noDataFooterEndRefreshing];
    }
    
}

#pragma mark - UICollectionViewDelegate / UICollectionViewDataSource / UICollectionViewDelegateFlowLayout

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * CellIdentifier = @"BTMeCollectionViewCell";
    
    BTMeCollectionViewCell * cell = (BTMeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
//    [cell makeLiveFiannceCellData:[self.financeService.videoFinanceArr objectAtIndex:indexPath.item]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
  
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



@end
