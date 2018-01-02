//
//  BTCellCommentTableView.m
//  BestToday
//
//  Created by 王卓 on 2017/12/26.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTCellCommentTableView.h"
#import "BTCellCommentCell.h"

@interface BTCellCommentTableView()<UITableViewDelegate,UITableViewDataSource>



@end

@implementation BTCellCommentTableView

static NSString * const CellIdentifier = @"LZMomentsCellCommentViewCell";
static NSString * const HeaderFooterViewIdentifier = @"LZMomentsSectionHeaderView";

- (void)setCommentArray:(NSMutableArray *)commentArray{
    _commentArray = commentArray;
    [self reloadData];
}

- (void)setTotleString:(NSString *)totleString{
    _totleString = totleString;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.userInteractionEnabled = YES;
    [self registerClass:[BTCellCommentCell class] forCellReuseIdentifier:CellIdentifier];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.delegate = self;
    self.dataSource = self;
    self.scrollEnabled = NO;
    self.estimatedRowHeight = 60;
    self.rowHeight = UITableViewAutomaticDimension;
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTCellCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.comment = self.commentArray[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 200, 20)];
    label.text = _totleString;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = HEX(@"969696");
    [backView addSubview:label];
    
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}


@end
