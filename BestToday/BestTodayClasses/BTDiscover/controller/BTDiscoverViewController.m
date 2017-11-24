//
//  BTDiscoverViewController.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTDiscoverViewController.h"
#import "BTDiscoverHeaderView.h"
#import "BTDiscoverCollectionView.h"
#import "BTDiscoverEntity.h"
#import "BTDiscoverService.h"
#import "BtHomePageService.h"

@interface BTDiscoverViewController ()<BTDiscoverCollectionViewDelegate>
{
    NSString *_pageAssistParam;
    int page;
}
@property (nonatomic, strong) BTDiscoverCollectionView *collectionView;

@property (nonatomic, strong) BTDiscoverService *discoverService;

@property (nonatomic, strong) BtHomePageService *homePageService;

@property (nonatomic, strong) BTDiscoverHeaderView *discoverHeaderView;

@end

@implementation BTDiscoverViewController

static NSString *const headerId = @"headerId";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.navigationBar.title = @"发现";
    // Do any additional setup after loading the view.
    [self setUpCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpCollectionView{
    _collectionView = [[BTDiscoverCollectionView alloc] initWithFrame:CGRectMake(0, kNavigationBarHight, SCREEN_WIDTH, SCREEN_HEIGHT-TAB_HEIGHT-kNavigationBarHight)];
    [_collectionView.collectionView registerClass:[BTDiscoverHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    _collectionView.discoverCVDelegate = self;
    [self.view addSubview:_collectionView];
    
    _discoverHeaderView = [[BTDiscoverHeaderView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 120)];
}

#pragma mark ---- CollectionView 数据源

- (void)requestDataSource{
    __weak BTDiscoverViewController *weakSelf = self;
    page = 1;
    //发现 的图片内容
    [self.discoverService loadqueryDiscoverResource:page pageAssistParam:@"" completion:^(BOOL isSuccess,  NSString *message, NSString *pageAssistParam) {
        [weakSelf.collectionView.collectionView stop];
        if (isSuccess) {
            page ++;
            [_collectionView setDataForCollectionView:weakSelf.discoverService.arrDiscoverResource];
            _pageAssistParam = pageAssistParam;
            [weakSelf.collectionView.collectionView reloadData];
        }
    }];
    // 推荐关注列表
    [self.homePageService loadqueryMyFollowedUsers:2 completion:^(BOOL isSuccess, BOOL isCache) {
        if (isSuccess) {
            weakSelf.discoverHeaderView.spreadTableView.dataArr = weakSelf.homePageService.arrFollowedUsers;
        }
    }];
}

- (void)requestMoreDataSource{
    //发现内容加载更多
    __weak BTDiscoverViewController *weakSelf = self;
    [self.discoverService loadqueryDiscoverResource:page pageAssistParam:_pageAssistParam completion:^(BOOL isSuccess,  NSString *message, NSString *pageAssistParam) {
        [weakSelf.collectionView.collectionView stop];
        if (isSuccess) {
            page++;
            [_collectionView setDataForCollectionView:weakSelf.discoverService.arrDiscoverResource];
            _pageAssistParam = pageAssistParam;
            [weakSelf.collectionView.collectionView reloadData];
        }
    }];
}


// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        _discoverHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        return _discoverHeaderView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){FULL_WIDTH,120};
}

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中cell ");
}


- (BTDiscoverService *)discoverService {
    if (!_discoverService) {
        _discoverService = [[BTDiscoverService alloc] init];
    }
    return _discoverService;
}

- (BtHomePageService *)homePageService {
    if (!_homePageService) {
        _homePageService = [[BtHomePageService alloc] init];
    }
    return _homePageService;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
