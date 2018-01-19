//
//  BTGPUIImageViewController.m
//  BestToday
//
//  Created by 王卓 on 2018/1/4.
//  Copyright © 2018年 leeco. All rights reserved.
//

#import "BTGPUIImageViewController.h"
#import "AlbumFiterViewCell.h"
#import "AlbumFiterModel.h"
#import "AlbumFilterUtil.h"
#import "BTPublishViewController.h"

@interface BTGPUIImageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *albumFiterImages;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation BTGPUIImageViewController

static NSString * const reuseIdentifier = @"AlbumFiterViewCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.title = @"滤镜";
    [self.navigationBar setLeftBarButton:[UIButton mlt_leftBarButtonWithImage:[UIImage imageNamed:@"info_backs"] highlightedImage:nil target:self action:@selector(navigationBackButtonClicked) forControlEvents:UIControlEventTouchUpInside]];
    UIButton *rightBarButton = [UIButton mlt_buttonWithTitle:@"下一步" image:nil highlightedImage:nil backgroundImage:nil highlightedBackgroundImage:nil target:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBarButton setTitleColor:[UIColor colorWithHexString:@"#fd8671"] forState:UIControlStateNormal];
    [self.navigationBar setRightBarButton:rightBarButton];
    
    [self initialization];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view.
}

- (void)navigationBackButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)submitAction{
    BTPublishViewController *publishVC = [[BTPublishViewController alloc] init];
    publishVC.imageSource = self.imageView.image;
    [self.navigationController pushViewController:publishVC animated:YES];
}

#pragma mark - UICollectionViewDelegate、UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.albumFiterImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AlbumFiterViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.fiter = self.albumFiterImages[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(75, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 12, 0, 12);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIImage *albumFiterImage = self.photoImage;
    
    self.imageView.image = [self renderEditAfterAlbumImage:albumFiterImage didSelectItemAtIndex:indexPath.row];
}

// 渲染图片
- (UIImage *)renderEditAfterAlbumImage:(UIImage *)albumImage didSelectItemAtIndex:(NSInteger)filterImageIndex {
    
    GPUImageColormatrixFilterType filterType = [[AlbumFilterUtil sharedInstance] colormatrixFilterTypeByIndex:filterImageIndex];
    return [[AlbumFilterUtil sharedInstance] imageByFilteringImage:albumImage filterType:filterType];
}

#pragma mark -
- (void)initialization {
    
    UIImage *thumbnailImage = self.photoImage;
    for (int i = 0; i < 8; i++) {
        AlbumFiterModel *fiter = [[AlbumFiterModel alloc] init];
        GPUImageColormatrixFilterType filterType = [[AlbumFilterUtil sharedInstance] colormatrixFilterTypeByIndex:i];
        fiter.thumbnailName = [[AlbumFilterUtil sharedInstance] getFilterName:filterType];
        UIImage *tempThumbnailImage = [[AlbumFilterUtil sharedInstance] imageByFilteringImage:thumbnailImage filterType:filterType];
        fiter.thumbnailImage = tempThumbnailImage;
        [self.albumFiterImages addObject:fiter];
        [self.collectionView reloadData];
        
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            UIImage *tempThumbnailImage = [[AlbumFilterUtil sharedInstance] imageByFilteringImage:thumbnailImage filterType:filterType];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                fiter.thumbnailImage = tempThumbnailImage;
//                [self.albumFiterImages addObject:fiter];
//                [self.collectionView reloadData];
//            });
//        });
    }
}

#pragma mark - Lazy Load

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor redColor];
        _imageView.image = self.photoImage;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        CGFloat imageViewWidth = kSCREEN_WIDTH;
        _imageView.frame = CGRectMake(0, 100, imageViewWidth, imageViewWidth);
        _imageView.clipsToBounds = YES;
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flowLayout.minimumInteritemSpacing = 12;
        flowLayout.minimumLineSpacing = 12;
        CGFloat collectionViewHeight = kSCREEN_HEIGHT - CGRectGetMaxY(self.imageView.frame);
        CGRect frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame), kSCREEN_WIDTH, collectionViewHeight);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[AlbumFiterViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (NSMutableArray *)albumFiterImages {
    if (!_albumFiterImages) {
        _albumFiterImages = [NSMutableArray array];
    }
    return _albumFiterImages;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
