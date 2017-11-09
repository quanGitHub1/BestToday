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

@interface BTDiscoverViewController ()<BTDiscoverCollectionViewDelegate>

@property (nonatomic, strong) BTDiscoverCollectionView *collectionView;

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
    _collectionView = [[BTDiscoverCollectionView alloc] initWithFrame:CGRectMake(0, kNavigationBarHight, SCREEN_WIDTH, SCREEN_HEIGHT-TAB_HEIGHT)];
    [_collectionView.collectionView registerClass:[BTDiscoverHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    _collectionView.discoverCVDelegate = self;

    [_collectionView setDataForCollectionView:@[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"]];
    
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
    BTDiscoverHeaderView *headerView = nil;
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor grayColor];
        
        return headerView;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
