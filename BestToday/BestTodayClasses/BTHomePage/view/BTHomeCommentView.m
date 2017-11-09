//
//  BTHomeCommentView.m
//  BestToday
//
//  Created by leeco on 2017/11/8.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTHomeCommentView.h"
#import "BTHomeCommentTableViewCell.h"

@interface BTHomeCommentView ()<UITableViewDelegate, UITableViewDataSource, LEBaseTableViewDelegate>

@property (nonatomic, strong) BTTableview * tableView;

@property (nonatomic, strong) NSMutableDictionary *dicCell;


@end

@implementation BTHomeCommentView

- (instancetype)initWithFrame:(CGRect)frame  block:(void (^)(CGFloat))block
{
    self = [super initWithFrame:frame ];
    
    if (self) {
        
        _dicCell = [[NSMutableDictionary alloc] init];
        
        [self setupTableView:frame];
        
        [self getCommentCellHeight];

    }
    return self;
}

- (void)setupTableView:(CGRect)frame{
    
    self.tableView = [[BTTableview alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 30;
    
    self.tableView.backgroundColor = [UIColor yellowColor];
    
    self.tableView.scrollEnabled = NO;
    
    self.tableView.dataDelegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addSubview:self.tableView];
    
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_dicCell.count > indexPath.row) {
        
        BTHomeCommentTableViewCell *announcementCell = [_dicCell objectForKey:[NSString stringWithFormat:@"indexPath%ld", indexPath.row]];
        
        return announcementCell.heightCell;
    }
    
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString * const cellID = @"mindCell";
    
    BTHomeCommentTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    
    if (!cell) {
        
        cell = [[BTHomeCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    [cell makeDatacell:indexPath.row];
    
    if (![[_dicCell allKeys] containsObject:[NSString stringWithFormat:@"indexPath%ld", indexPath.row]]) {
        
        [_dicCell setObject:cell forKey:[NSString stringWithFormat:@"indexPath%ld", indexPath.row]];
        
    }
    
    return cell;
}

- (void)getCommentCellHeight{
    CGFloat heights = 0.0;
    
    for (int i = 0; i < _dicCell.count; i++) {
        
        BTHomeCommentTableViewCell *announcementCell = [_dicCell objectForKey:[NSString stringWithFormat:@"indexPath%d", i]];
        
        heights +=announcementCell.heightCell;
    }
    
    if (self.CommentHeightBlock) {
        
        self.CommentHeightBlock(heights);
        
    }
    
}

@end
