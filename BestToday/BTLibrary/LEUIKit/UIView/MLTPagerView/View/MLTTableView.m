//
//  MLTTableView.h
//  MLTPagerView
//
//  Created by jinzi on 16/9/1.
//  Copyright © 2016年 MLT. All rights reserved.
//

#import "MLTTableView.h"
#import "MJRefresh.h"
#import "MLTTableView+MLTBrokenNetwork.h"

@implementation MLTTableView

#pragma mark - View Life

- (instancetype) init {
    
    if (self = [super init]) {
        
        [self setTableViewStyle];
        [self mlt_initRereshHeaderAndFooter];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
     
        [self setTableViewStyle];
        [self mlt_initRereshHeaderAndFooter];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        [self setTableViewStyle];
        [self mlt_initRereshHeaderAndFooter];
    }
    return self;
}

#pragma mark - Private Method

- (void)setTableViewStyle {
    
    self.backgroundView = nil;
    self.tableFooterView = [UIView new];
    self.showsVerticalScrollIndicator = NO;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
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
