//
//  BTHomePageTableViewCell.h
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenDetailsView.h"
#import "BTHomeCommentView.h"
#import <UShareUI/UShareUI.h>


@protocol BTHomepageViewDelegate <NSObject>

- (void)reloadTableView:(NSInteger)indexpath height:(CGFloat)height;


@end

@interface BTHomePageTableViewCell : UITableViewCell<UMSocialShareMenuViewDelegate>


@property(nonatomic, weak) id <BTHomepageViewDelegate>delegate;

@property (nonatomic, strong) UIImageView *imageAvtar; // 头像

@property (nonatomic, strong) UILabel *labName;  // 姓名

@property (nonatomic, strong) UIButton *btnAtten;  // 点击关注

@property (nonatomic, strong) UIImageView *imagePic; // 图片

@property (nonatomic, strong) UILabel *labTime; // 时间

@property (nonatomic, strong) UILabel *labFabulous; // 赞

@property (nonatomic, strong) UIButton *btnCollection; // 收藏

@property (nonatomic, strong) UIButton *btnComment; // 评论

@property (nonatomic, strong) UIButton *btnShare; // 分享

@property (nonatomic, strong) OpenDetailsView *labDescrp; //描述

@property (nonatomic, strong) UIView *viewLine; //线

@property (nonatomic, strong) BTHomeCommentView *homeCommentView;

@property (nonatomic, assign) CGFloat heightCell;

@property (nonatomic) BOOL cell;


- (void)makeDatacell:(NSInteger)indexpath ;


@end
