//
//  BTHomePageDetailViewController.m
//  BestToday
//
//  Created by leeco on 2017/11/14.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTHomePageDetailViewController.h"
#import "BTHomePageTableViewCell.h"
#import "BTHomeDetailCollectionView.h"
#import "BTHomedetailHeaderView.h"


@interface BTHomePageDetailViewController ()<BTHomeDetailCollectionViewDelegate>

@property (nonatomic,strong) BTHomeDetailCollectionView *collectionView;

@end


@implementation BTHomePageDetailViewController

static NSString *const headerId = @"headerId";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.title = @"今日最佳";
    
    [self.navigationBar setLeftBarButton:[UIButton mlt_rightBarButtonWithImage:[UIImage imageNamed:@"info_backs"] highlightedImage:nil target:self action:@selector(navigationBackButtonClicked:) forControlEvents:UIControlEventTouchUpInside]];


    [self setUpCollectionView];
    
}


- (void)navigationBackButtonClicked:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setUpCollectionView{
    
    _collectionView = [[BTHomeDetailCollectionView alloc] initWithFrame:CGRectMake(0, kNavigationBarHight, SCREEN_WIDTH, SCREEN_HEIGHT-kNavigationBarHight)];
    
    [_collectionView.collectionView registerClass:[BTHomedetailHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    
    _collectionView.discoverCVDelegate = self;

    
    [self.view addSubview:_collectionView];
    
}

#pragma mark ---- CollectionView 数据源

- (void)requestDataSource{
    NSLog(@"下拉刷新数据");
}

- (void)requestMoreDataSource{
    NSLog(@"上拉加载更多");
}


// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    BTHomedetailHeaderView *headerView = nil;
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor whiteColor];
        
        headerView.heightTab = _heightCell;
        
        [headerView initCreatTableview];
        
        return headerView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){FULL_WIDTH,_heightCell + 60};
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
