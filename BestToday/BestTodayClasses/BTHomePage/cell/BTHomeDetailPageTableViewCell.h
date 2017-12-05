//
//  BTHomeDetailPageTableViewCell.h
//  BestToday
//
//  Created by wangfaquan on 2017/12/3.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenDetailsView.h"
#import "BTHomeCommentView.h"
#import <UShareUI/UShareUI.h>
#import "BTHomePageEntity.h"
#import "BTLikeCommentService.h"

@protocol BTHomepageDetailViewDelegate <NSObject>

- (void)reloadTableView:(NSInteger)indexpath height:(CGFloat)height;

- (void)reloadTableViewheight:(CGFloat)height;

- (void)reloadTableviewDatas;


@end

@interface BTHomeDetailPageTableViewCell : UITableViewCell


@property(nonatomic, weak) id <BTHomepageDetailViewDelegate>delegate;

@property (nonatomic, strong) UIImageView *imageAvtar; // 头像

@property (nonatomic, strong) UILabel *labName;  // 姓名

@property (nonatomic, strong) UIButton *btnAtten;  // 点击关注

@property (nonatomic, strong) UIImageView *imagePic; // 图片

@property (nonatomic, strong) UILabel *labTime; // 时间

@property (nonatomic, strong) UILabel *labFabulous; // 赞

@property (nonatomic, strong) UIButton *btnCollection; // 收藏

@property (nonatomic, strong) UIButton *btnComment; // 评论

@property (nonatomic, strong) UIButton *btnShare; // 分享

@property (nonatomic, strong) UILabel *labDescrp; //描述

@property (nonatomic, strong) UILabel *labTextInfor; //描述


@property (nonatomic, strong) UIView *viewLine; //线

@property (nonatomic, strong) UILabel *labComment;



@property (nonatomic, strong) BTHomeCommentView *homeCommentView;


@property (nonatomic, strong) NSString *resourceId;


@property (nonatomic, assign) CGFloat heightCell;

@property (nonatomic, strong) BTHomePageEntity *homePageEntity;

@property (nonatomic) BOOL cell;


- (void)makeDatacellData:(BTHomePageEntity *)homePage index:(NSInteger)indexpath;

@end
