//
//  BTDiscoverHeaderView.m
//  BestToday
//
//  Created by 王卓 on 2017/11/6.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTDiscoverHeaderView.h"
#import "BTSpreadTableView.h"

@interface BTDiscoverHeaderView()<BTSpreadTableViewDelegate>

@property (nonatomic, strong) BTSpreadTableView *spreadTableView;


@end

@implementation BTDiscoverHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.spreadTableView];
    }
    return self;
}
- (BTSpreadTableView *)spreadTableView{
    // 调用tableView
    if (!_spreadTableView) {
        /**
         宽和高调换顺序
         */
        _spreadTableView = [[BTSpreadTableView alloc] initWithFrame:CGRectMake(0, 0, ScaleHeight(120), FULL_WIDTH) style:UITableViewStylePlain withType:BTSpreadTableViewStyleImageText];// x,y 高，宽
        
        _spreadTableView.backgroundColor = [UIColor yellowColor];
        _spreadTableView.spreadDelegate = self;
        
    }
    return _spreadTableView;
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

@end
