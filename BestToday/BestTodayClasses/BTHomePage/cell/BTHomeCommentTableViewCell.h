//
//  BTHomeCommentTableViewCell.h
//  BestToday
//
//  Created by leeco on 2017/11/8.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTHomeCommentTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *viewLine; //线

@property (nonatomic, strong) UILabel *labName;  // 姓名

@property (nonatomic, strong) UILabel *labComment; //描述

@property (nonatomic, assign) CGFloat heightCell;

- (void)makeDatacell:(NSInteger)indexpath;


@end
