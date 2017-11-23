//
//  BTDiscoverHeaderView.m
//  BestToday
//
//  Created by 王卓 on 2017/11/6.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTDiscoverHeaderView.h"

@interface BTDiscoverHeaderView()<BTSpreadTableViewDelegate>


@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation BTDiscoverHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.spreadTableView];
    }
    return self;
}
- (BTSpreadTableView *)spreadTableView{
    // 调用tableView
    if (!_spreadTableView) {
        _dataArray = [NSArray array];
        /**
         宽和高调换顺序
         */
        _spreadTableView = [[BTSpreadTableView alloc] initWithFrame:CGRectMake(0, 0, ScaleHeight(120), FULL_WIDTH) style:UITableViewStylePlain withType:BTSpreadTableViewStyleImageText];// x,y 高，宽
        _spreadTableView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
        _spreadTableView.spreadDelegate = self;
        
    }
    return _spreadTableView;
}

#pragma mark - BTSpreadTableViewDelegate

- (void)spreadTableViewDidSelectMore;
{
    
}

// 滑动时记住tableview的位置
- (void)spreadTableViewContentOffset:(CGFloat)contentOffsetY;
{
    
}

@end
