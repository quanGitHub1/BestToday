//
//  MLTCollectionView.m
//  MLTPagerView
//
//  Created by jinzi on 16/9/1.
//  Copyright © 2016年 MLT. All rights reserved.
//

#import "MLTCollectionView.h"
#import "MJRefresh.h"
#import "MLTCollectionView+MLTBrokenNetwork.h"

@implementation MLTCollectionView

#pragma mark - View Life

- (instancetype) init {
    
    if (self = [super init]) {
        
        [self setCollectionViewStyle];
        [self mlt_initRereshHeaderAndFooter];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setCollectionViewStyle];
        [self mlt_initRereshHeaderAndFooter];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        [self setCollectionViewStyle];
        [self mlt_initRereshHeaderAndFooter];
        
    }
    return self;
}

#pragma mark - Private Method

- (void)setCollectionViewStyle {
    
    self.backgroundView = nil;
    self.showsVerticalScrollIndicator = NO;
    self.backgroundView = [UIView new];
    self.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Refresh Related

- (void)mlt_dataDidLoad {
    
    [self reloadData];
}

- (void)mlt_dataFailLoad {
    
    if (self.autoShowBrokenNetwork) {
        [self showBrokenNetworkView];
    }
    
}

@end
