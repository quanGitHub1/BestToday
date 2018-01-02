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


@interface BTHomePageDetailViewController ()

@property (nonatomic,strong) BTHomeDetailCollectionView *collectionView;

@end


@implementation BTHomePageDetailViewController

static NSString *const headerId = @"headerId";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.title = @"图片";
    
    [self.navigationBar setLeftBarButton:[UIButton mlt_rightBarButtonWithImage:[UIImage imageNamed:@"info_backs"] highlightedImage:nil target:self action:@selector(navigationBackButtonClicked:) forControlEvents:UIControlEventTouchUpInside]];
    [self.navigationBar setRightBarButton:[UIButton mlt_rightBarButtonWithImage:[UIImage imageNamed:@"backhome"] highlightedImage:nil target:self action:@selector(navigationBackHomeButtonClicked:) forControlEvents:UIControlEventTouchUpInside]];

    [self setUpCollectionView];
    
}


- (void)navigationBackButtonClicked:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navigationBackHomeButtonClicked:(UIButton *)button{
    [self.navigationController popToRootViewControllerAnimated:NO];
    UINavigationController *navC = (UINavigationController *)AppWindow.rootViewController;
    MLTTabBarController *tabBarVC = navC.viewControllers[0];
    [tabBarVC selectAtIndex:0];

}

- (void)setUpCollectionView{
    
    _collectionView = [[BTHomeDetailCollectionView alloc] initWithFrame:CGRectMake(0, kNavigationBarHight, SCREEN_WIDTH, SCREEN_HEIGHT-kNavigationBarHight) resourceId:_resourceId];
    
    [_collectionView.collectionView registerClass:[BTHomedetailHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
        
    [self.view addSubview:_collectionView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
