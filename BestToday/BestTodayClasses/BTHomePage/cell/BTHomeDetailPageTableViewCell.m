//
//  BTHomeDetailPageTableViewCell.m
//  BestToday
//
//  Created by wangfaquan on 2017/12/3.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTHomeDetailPageTableViewCell.h"
#import "BTHomeUserEntity.h"
#import "BTHomeComment.h"
#import "CoreText/CoreText.h"
#import "WYShareView.h"
#import "BtHomePageService.h"
#import "BTMessageViewController.h"
#import "BTMeViewController.h"

@implementation BTHomeDetailPageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        if (self) {
            
            self.backgroundColor = [UIColor whiteColor];
            
            _imageAvtar = [[UIImageView alloc] initWithFrame:CGRectMake(15, 9, ScaleWidth(32), ScaleHeight(32))];
            
//            _imageAvtar.contentMode = UIViewContentModeScaleAspectFit;
            
            _imageAvtar.backgroundColor = [UIColor whiteColor];
            
            _imageAvtar.layer.cornerRadius = ScaleWidth(16);
            
            _imageAvtar.clipsToBounds = YES;
            
            _imageAvtar.userInteractionEnabled = YES;
            
            //创建手势 使用initWithTarget:action:的方法创建
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
            
            //设置属性
            tap.numberOfTouchesRequired = 1;
            
            //别忘了添加到testView上
            [_imageAvtar addGestureRecognizer:tap];

            
            _labName = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#212121" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:16] bkColor:nil frame:CGRectMake(_imageAvtar.right + 10, _imageAvtar.top + (_imageAvtar.height - 18)/2, 200, 18)];
            
            _labName.userInteractionEnabled = YES;
            
            //创建手势 使用initWithTarget:action:的方法创建
            UITapGestureRecognizer *tapLab = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewName:)];
            
            //设置属性
            tapLab.numberOfTouchesRequired = 1;
            
            [_labName addGestureRecognizer:tapLab];
            
            _btnAtten = [[UIButton alloc] initWithFrame:CGRectMake(FULL_WIDTH - ScaleWidth(50) - 15, 10, ScaleWidth(50), ScaleWidth(25))];
            
            [_btnAtten setTitle:@"已关注" forState:UIControlStateNormal];
            
            _btnAtten.layer.borderColor = [UIColor colorWithHexString:@"#bdbdbd"].CGColor;
            
            _btnAtten.layer.borderWidth = 1;
            
            [_btnAtten setTitleColor:[UIColor colorWithHexString:@"#616161"] forState:UIControlStateNormal];
            
            _btnAtten.layer.cornerRadius = 1.5;
            
            _btnAtten.titleLabel.font = [UIFont systemFontOfSize:13];
            
            [_btnAtten addTarget:self action:@selector(onclickBtnAtten:) forControlEvents:UIControlEventTouchUpInside];

            
            _imagePic = [[UIImageView alloc] initWithFrame:CGRectMake(0, _imageAvtar.bottom + 15, FULL_WIDTH, ScaleHeight(350))];
            
            _imagePic.backgroundColor = [UIColor whiteColor];
            
            _labTime = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#bdbdbd" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:12] bkColor:nil frame:CGRectMake(_imageAvtar.left, _imagePic.bottom + 15, 150, 18)];
            
            if (FULL_WIDTH > 380) {

                  _labFabulous = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#bdbdbd" alpha:1] align:NSTextAlignmentRight font:[UIFont systemFontOfSize:12] bkColor:nil frame:CGRectMake(FULL_WIDTH / 2, _labTime.top, 50, 15)];
            }else {
            
                _labFabulous = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#bdbdbd" alpha:1] align:NSTextAlignmentRight font:[UIFont systemFontOfSize:12] bkColor:nil frame:CGRectMake(FULL_WIDTH / 2 - 20, _labTime.top, 50, 15)];
            }
            
            _labTextInfor = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#616161" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:15] bkColor:nil frame:CGRectMake(FULL_WIDTH / 2 + 15, _labTime.top, FULL_WIDTH - 30, 0)];
            
            
            _viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, _labTextInfor.bottom , FULL_WIDTH - 20, 0.6)];

            
            _btnCollection = [[UIButton alloc] init];
            
            [_btnCollection addTarget:self action:@selector(onclickBtnCollection:) forControlEvents:UIControlEventTouchUpInside];
            
            _btnComment = [[UIButton alloc] init];
            
            [_btnComment addTarget:self action:@selector(onclickBtnComment:) forControlEvents:UIControlEventTouchUpInside];
            
            _btnShare = [[UIButton alloc] init];
            
            [_btnShare addTarget:self action:@selector(onclickBtnShare:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.contentView addSubview:_imageAvtar];
            
            [self.contentView addSubview:_labName];
            
            [self.contentView addSubview:_btnAtten];
            
            [self.contentView addSubview:_viewLine];
            
            [self.contentView addSubview:_imagePic];
            
            [self.contentView addSubview:_labTime];
            
            [self.contentView addSubview:_labFabulous];
            
            [self.contentView addSubview:_btnCollection];
            
            [self.contentView addSubview:_btnComment];
            
            [self.contentView addSubview:_btnShare];
            
            [self.contentView addSubview:_labTextInfor];
            
            [self.contentView addSubview:_labDescrp];
            

        }
        return self;
        
    }
    return self;
}


- (void)onclickBtnAtten:(UIButton *)btn{
    
    if ([btn.titleLabel.text isEqualToString:@"+关注"]) {
        [self requestFollowUser];
    }else {
        [self requestUnFollowUser];
    }
    
}


- (void)onclickBtnCollection:(UIButton *)btn{
    
    BTLikeCommentService *likeService = [BTLikeCommentService new];
    
    if (btn.selected == YES) {
        
        [likeService loadqueryCancelSaveLikeResource:_resourceId completion:^(BOOL isSuccess, BOOL isCache) {
            
            if (isSuccess) {
            
                btn.selected = NO;
                
                _homePageEntity.isLiked = @"0";
                
                
                _homePageEntity.likeCount = [NSString stringWithFormat:@"%ld",[_labFabulous.text integerValue] - 1];
                
                
                _labFabulous.text = [NSString stringWithFormat:@"%ld赞",[_labFabulous.text integerValue] - 1];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"BTHomePageNSNotificationIsLike" object:nil userInfo:@{@"isLiked":@"0",@"resourceId" : _homePageEntity.resourceId}];

                if (_homePageEntity.likeCount.integerValue == 0) {
                    _labFabulous.hidden = YES;
                }else {
                    _labFabulous.hidden = NO;
                    
                }
                
            }else {
                
                [SVProgressHUD showInfoWithStatus:@"取消点赞失败"];
            }
        }];
        
    }else {
        
        [likeService loadquerySaveLikeResource:_resourceId completion:^(BOOL isSuccess, BOOL isCache) {
            
            if (isSuccess) {
                
                btn.selected = YES;
                
                _homePageEntity.isLiked = @"1";
                
                _homePageEntity.likeCount = [NSString stringWithFormat:@"%ld",[_labFabulous.text integerValue] + 1];
                
                _labFabulous.text = [NSString stringWithFormat:@"%ld赞",[_labFabulous.text integerValue] + 1];
                
                   [[NSNotificationCenter defaultCenter] postNotificationName:@"BTHomePageNSNotificationIsLike" object:nil userInfo:@{@"isLiked":@"1",@"resourceId" : _homePageEntity.resourceId}];
                
                if (_homePageEntity.likeCount.integerValue == 0) {
                    _labFabulous.hidden = YES;
                }else {
                    _labFabulous.hidden = NO;
                    
                }
                
            }else {
                
                [SVProgressHUD showInfoWithStatus:@"点赞失败"];
                
            }
        }];
    }
    
}

- (void)onclickBtnComment:(UIButton *)btn{
 
    BTMessageViewController *messageVC = [[BTMessageViewController alloc] init];
    messageVC.isComment = YES;
    messageVC.resourceId = _resourceId;
    [[self viewController].navigationController pushViewController:messageVC animated:YES];

}

/** 点击啊头像 */
- (void)tapView:(UITapGestureRecognizer*)gesTap{
    
    BTMeViewController *meView = [[BTMeViewController alloc] init];
    
    BTHomeUserEntity *userEntity = [BTHomeUserEntity yy_modelWithJSON:_homePageEntity.userVo];
    
    meView.userId = userEntity.userId;
    
    meView.otherId = YES;
    
    [[self viewController].navigationController pushViewController:meView animated:YES];
    
}

/** 点击姓名 */
- (void)tapViewName:(UITapGestureRecognizer*)gesTap{
    
    BTMeViewController *meView = [[BTMeViewController alloc] init];
    
    BTHomeUserEntity *userEntity = [BTHomeUserEntity yy_modelWithJSON:_homePageEntity.userVo];
    
    meView.userId = userEntity.userId;
    
    meView.otherId = YES;
    
    [[self viewController].navigationController pushViewController:meView animated:YES];
    
}


// 关注接口
- (void)requestFollowUser{
    
    BtHomePageService *pageService = [BtHomePageService new];
    
    BTHomeUserEntity *userEntity = [BTHomeUserEntity yy_modelWithJSON:_homePageEntity.userVo];
    
    [pageService loadqueryFollowUser:[userEntity.userId integerValue] completion:^(BOOL isSuccess, BOOL isCache) {
        
        [_btnAtten setTitle:@"已关注" forState:UIControlStateNormal];
        [_btnAtten setTitleColor:[UIColor colorWithHexString:@"#616161"] forState:UIControlStateNormal];

        _btnAtten.layer.borderColor = [UIColor colorWithHexString:@"#bdbdbd"].CGColor;

        [[NSNotificationCenter defaultCenter] postNotificationName:@"BTHomePageNSNotificationIsFollow" object:nil userInfo:@{@"isFollow":@"1",@"resourceId" : _homePageEntity.resourceId, @"indexPath": [NSString stringWithFormat:@"%ld",_indexpath + 10000]}];

        [SVProgressHUD showWithStatus:@"添加关注成功"];
        
        [SVProgressHUD dismissWithDelay:0.3f];
        
    }];
}


// 取消关注接口
- (void)requestUnFollowUser{
    
    BtHomePageService *pageService = [BtHomePageService new];
    
    BTHomeUserEntity *userEntity = [BTHomeUserEntity yy_modelWithJSON:_homePageEntity.userVo];

    [pageService loadqueryUnFollowUser:[userEntity.userId integerValue] completion:^(BOOL isSuccess, BOOL isCache) {
        
        [_btnAtten setTitle:@"+关注" forState:UIControlStateNormal];
        _btnAtten.layer.borderColor = [UIColor colorWithHexString:@"#fd8671"].CGColor;
        [_btnAtten setTitleColor:[UIColor colorWithHexString:@"#fd8671"] forState:UIControlStateNormal];

        [[NSNotificationCenter defaultCenter] postNotificationName:@"BTHomePageNSNotificationIsFollow" object:nil userInfo:@{@"isFollow":@"0",@"resourceId" : _homePageEntity.resourceId, @"indexPath": [NSString stringWithFormat:@"%ld",_indexpath + 10000]}];

        [SVProgressHUD showWithStatus:@"取消关注成功"];
        [SVProgressHUD dismissWithDelay:0.3f];
        
    }];
}

- (void)onclickBtnShare:(UIButton *)btn{
    
    BTLikeCommentService *likeService = [BTLikeCommentService new];
    
    [likeService loadqueryGetSharePic:_resourceId completion:^(BOOL isSuccess, BOOL isCache, NSString *picUrl) {
        if (isSuccess) {
            
            [self shareUM:picUrl];

        }
        
    }];
}

- (void)shareUM:(NSString *)picUrl;
{
    _picUrl = picUrl;
    
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_None;
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        [self shareImageURLToPlatformType:platformType];
        
    }];
}

//分享网络图片
- (void)shareImageURLToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = _picUrl;
    
    [shareObject setShareImage:_picUrl];
    
    // 设置Pinterest参数
    if (platformType == UMSocialPlatformType_Pinterest) {
        [self setPinterstInfo:messageObject];
    }
    
    // 设置Kakao参数
    if (platformType == UMSocialPlatformType_KakaoTalk) {
        messageObject.moreInfo = @{@"permission" : @1}; // @1 = KOStoryPermissionPublic
    }
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[self viewController]completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //            [self alertWithError:error];
    }];
}


- (void)setPinterstInfo:(UMSocialMessageObject *)messageObj
{
    messageObj.moreInfo = @{@"source_url":_picUrl ,
                            @"app_name": @"今日最佳",
                            @"suggested_board_name": @"UShareProduce",
                            @"description": @"U-Share: best social bridge"};
}



- (void)makeDatacellData:(BTHomePageEntity *)homePage index:(NSInteger)indexpath{
    
    //  拿到id 点赞关注评论都有用
    _resourceId = homePage.resourceId;
    
    _homePageEntity = homePage;
    
    _indexpath = indexpath;
    
    BTHomeUserEntity *userEntity = [BTHomeUserEntity yy_modelWithJSON:homePage.userVo];
    
    _labName.text = userEntity.nickName;
    
    [_imageAvtar sd_setImageWithURL:[NSURL URLWithString:userEntity.avatarUrl] placeholderImage:nil];
    
    
    if ([userEntity.isFollowed integerValue] == 0) {
        
        [_btnAtten setTitle:@"+关注" forState:UIControlStateNormal];
        [_btnAtten setTitleColor:[UIColor colorWithHexString:@"#fd8671"] forState:UIControlStateNormal];

        _btnAtten.layer.borderColor = [UIColor colorWithHexString:@"#fd8671"].CGColor;

        
    }else if ([userEntity.isFollowed integerValue] == 1){
        [_btnAtten setTitle:@"已关注" forState:UIControlStateNormal];
        _btnAtten.layer.borderColor = [UIColor colorWithHexString:@"#bdbdbd"].CGColor;
        [_btnAtten setTitleColor:[UIColor colorWithHexString:@"#616161"] forState:UIControlStateNormal];

    }else{
        [_btnAtten setTitle:@"" forState:UIControlStateNormal];
        _btnAtten.layer.borderColor = [UIColor whiteColor].CGColor;
        [_btnAtten setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    _labTime.text = homePage.createTime;
    
    _labFabulous.text = [NSString stringWithFormat:@"%@赞",homePage.likeCount];
    
    
    if (_homePageEntity.picWidth && _homePageEntity.picHeight) {
        
        [self makeDatacellindex:indexpath];
        
    }else {
        
        UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:homePage.picUrl];
        
        if (!cachedImage) {
            
            [_imagePic sd_setImageWithURL:[NSURL URLWithString:homePage.picUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                if (_delegate && [_delegate respondsToSelector:@selector(reloadTableviewDatas)]) {
                    [self.delegate reloadTableviewDatas];
                }
                
            }];
            
        }else {
            
            CGFloat heightSize = cachedImage.size.height / cachedImage.size.width;
            
            _imagePic.frame = CGRectMake(0, _imageAvtar.bottom + 15, FULL_WIDTH, FULL_WIDTH * heightSize);
            
            [_imagePic setImage:cachedImage];
            
            _labTime.frame = CGRectMake(_imageAvtar.left, _imagePic.bottom + 15, 150, 18);
            
            _labFabulous.frame = CGRectMake(FULL_WIDTH / 2, _labTime.top, 50, 15);
            
            
            UIImage *iamgeshare = [UIImage imageNamed:@"share"];
            
            UIImage *iamgeInformation = [UIImage imageNamed:@"information"];
            
            UIImage *iamgeCollectionSelect = [UIImage imageNamed:@"collection_select"];
            
            UIImage *iamgeCollection = [UIImage imageNamed:@"collection"];
            
            // 是否已经点赞
            _btnCollection.selected = [homePage.isLiked boolValue];
            
            [_btnCollection setImage:iamgeCollection forState:UIControlStateNormal];
            
            [_btnCollection setImage:iamgeCollectionSelect forState:UIControlStateSelected];
            
            _btnCollection.frame = CGRectMake(_labFabulous.right + 15, _imagePic.bottom + 12, iamgeCollection.size.width, iamgeCollection.size.height);
            
            [_btnComment setImage:iamgeInformation forState:UIControlStateNormal];
            
            _btnComment.frame = CGRectMake(_btnCollection.right + 24, _imagePic.bottom + 12, iamgeCollection.size.width, iamgeCollection.size.height);
            
            _btnComment.frame = CGRectMake(_btnCollection.right + 24, _imagePic.bottom + 12, 22, 22);
            
            [_btnShare setImage:iamgeshare forState:UIControlStateNormal];
            
            _btnShare.frame = CGRectMake(_btnComment.right + 24, _imagePic.bottom + 12, iamgeCollection.size.width, iamgeCollection.size.height);
            
            // 设置label的行间距
            NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            
            [paragraphStyle  setLineSpacing:8];
            
            NSMutableAttributedString  *setString;
            
            setString = [[NSMutableAttributedString alloc] initWithString:_homePageEntity.textInfo];
            
            [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_homePageEntity.textInfo length])];
            
            _labTextInfor.frame = CGRectMake(_imageAvtar.left, _labTime.bottom + 15, FULL_WIDTH - 30, 0);
            
            _labTextInfor.attributedText = setString;
            
            _labTextInfor.numberOfLines = 0;
            
            [_labTextInfor sizeToFit];
            
            CGFloat heightLab = 0.0;
            
            for (int i = 0; i < [_homePageEntity.partCommentList count]; i++) {
                
                NSDictionary *dicpart = [_homePageEntity.partCommentList objectAtIndex:i];
                
                BTHomeComment *comment = [BTHomeComment yy_modelWithJSON:dicpart];
                
                
                // 如果没有描述 评论重0开始添加
                if (_labTextInfor.text.length == 0) {
                    
                    _labComment = [[UILabel alloc] initWithFrame:CGRectMake(_imageAvtar.left, _labTextInfor.bottom + 13.6 , FULL_WIDTH - 30, 0)];
                }else {
                    
                    _labComment = [[UILabel alloc] initWithFrame:CGRectMake(_imageAvtar.left, _labTextInfor.bottom +  26, FULL_WIDTH - 30, 0)];
                }
                
                _labComment.textColor = [UIColor colorWithHexString:@"#616161"];
                
                _labComment.font = [UIFont systemFontOfSize:15];
                
                // 把名字和评论拼接上
                NSString *strComment = [NSString stringWithFormat:@"%@： %@", comment.commentNickName, comment.content];
                
                // 设置label的行间距
                NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                
                [paragraphStyle  setLineSpacing:8];
                
                NSMutableAttributedString  *setString;
                
                NSRange range = NSMakeRange(0, comment.commentNickName.length + 1);
                
                setString = [[NSMutableAttributedString alloc] initWithString:strComment];
                
                [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [strComment length])];
                
                // 设置颜色
                [setString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#212121"] range:range];
                
                [setString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:range];
                
                
                _labComment.attributedText = setString;
                
                _labComment.numberOfLines = 3;
                
                [_labComment sizeToFit];
                
                heightLab += _labComment.height + 10;
                
                [self.contentView addSubview:_labComment];
                
            }
            
            UIButton *btnComment = [[UIButton alloc] initWithFrame:CGRectMake(_imageAvtar.left, _labTextInfor.bottom + heightLab + 4, FULL_WIDTH - 20, 20)];
            
            [btnComment setTitle:_homePageEntity.totalCommentMsg forState:UIControlStateNormal];
            
            [btnComment setTitleColor:[UIColor colorWithHexString:@"#969696"] forState:UIControlStateNormal];
            
            btnComment.titleLabel.font = [UIFont systemFontOfSize:14];
            
            if (_homePageEntity.partCommentList.count == 0) {
                
                btnComment.frame = CGRectMake(0, 0, 0, 0);
                
                _heightCell = _labTextInfor.bottom;
                
            }else {
                
                _heightCell = btnComment.bottom;
                
            }
            
            btnComment.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            
            [self addSubview:btnComment];
            
            
            if (_delegate && [_delegate respondsToSelector:@selector(reloadTableViewheight:)]) {
                
                [self.delegate reloadTableViewheight:_heightCell];
                
            }
        }
    }
}


- (void)makeDatacellindex:(NSInteger)indexpath{
    
    CGFloat heightSize = [_homePageEntity.picHeight floatValue] / [_homePageEntity.picWidth floatValue];
    
    _imagePic.frame = CGRectMake(0, _imageAvtar.bottom + 15, FULL_WIDTH, FULL_WIDTH * heightSize);
    
    [_imagePic sd_setImageWithURL:[NSURL URLWithString:_homePageEntity.picUrl] placeholderImage:nil];
    
    _labTime.frame = CGRectMake(_imageAvtar.left, _imagePic.bottom + 15, 150, 18);
    
    if (FULL_WIDTH > 380) {
        
        _labFabulous.frame = CGRectMake(FULL_WIDTH / 2, _labTime.top, 50, 15);

    }else {
    
        _labFabulous.frame = CGRectMake(FULL_WIDTH / 2 - 20, _labTime.top, 50, 15);

    }
    
    if ([_homePageEntity.likeCount isEqualToString:@"0"]) {
        _labFabulous.text = @"";
    }else{
        _labFabulous.text = [NSString stringWithFormat:@"%@赞",_homePageEntity.likeCount];
    }
    
    UIImage *iamgeshare = [UIImage imageNamed:@"share"];
    
    UIImage *iamgeInformation = [UIImage imageNamed:@"information"];
    
    UIImage *iamgeCollectionSelect = [UIImage imageNamed:@"collection_select"];
    
    UIImage *iamgeCollection = [UIImage imageNamed:@"collection"];
    
    // 是否已经点赞
    _btnCollection.selected = [_homePageEntity.isLiked boolValue];
    
    [_btnCollection setImage:iamgeCollection forState:UIControlStateNormal];
    
    [_btnCollection setImage:iamgeCollectionSelect forState:UIControlStateSelected];
    
    _btnCollection.frame = CGRectMake(_labFabulous.right + ScaleWidth(12), _imagePic.bottom + 12, iamgeCollection.size.width, iamgeCollection.size.height);
    
    [_btnComment setImage:iamgeInformation forState:UIControlStateNormal];
    
    _btnComment.frame = CGRectMake(_btnCollection.right + ScaleWidth(21), _imagePic.bottom + 12, iamgeCollection.size.width, iamgeCollection.size.height);
    
    _btnComment.frame = CGRectMake(_btnCollection.right + ScaleWidth(21), _imagePic.bottom + 12, 22, 22);
    
    [_btnShare setImage:iamgeshare forState:UIControlStateNormal];
    
    _btnShare.frame = CGRectMake(_btnComment.right + ScaleWidth(21), _imagePic.bottom + 12, iamgeCollection.size.width, iamgeCollection.size.height);
    
    // 设置label的行间距
    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    
    [paragraphStyle  setLineSpacing:5];
    
    NSMutableAttributedString  *setString;
    
    setString = [[NSMutableAttributedString alloc] initWithString:_homePageEntity.textInfo];
    
    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_homePageEntity.textInfo length])];
    
    _labTextInfor.frame = CGRectMake(_imageAvtar.left, _labTime.bottom + 15, FULL_WIDTH - 30, 0);
    
    _labTextInfor.attributedText = setString;
    
    _labTextInfor.numberOfLines = 0;
    
    [_labTextInfor sizeToFit];
    
    if (_labTextInfor.height > 40) {
        
        _viewLine.frame = CGRectMake(_imageAvtar.left,  _labTextInfor.bottom + 6, FULL_WIDTH - 2 * _imageAvtar.left, 0.6);

    }

    _viewLine.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];

    CGFloat heightLab = 0.0;
    
    for (int i = 0; i < ([_homePageEntity.partCommentList count] > 3 ? 3 : _homePageEntity.partCommentList.count); i++) {
        
        NSDictionary *dicpart = [_homePageEntity.partCommentList objectAtIndex:i];
        
        BTHomeComment *comment = [BTHomeComment yy_modelWithJSON:dicpart];
        
        // 如果没有描述 评论重0开始添加
        if (_labTextInfor.text.length == 0) {
            
            _labComment = [[UILabel alloc] initWithFrame:CGRectMake(_imageAvtar.left, _labTextInfor.bottom + 13.6 + heightLab, FULL_WIDTH - 30, 0)];
            
            _viewLine.frame = CGRectMake(_imageAvtar.left,  _labTextInfor.bottom , FULL_WIDTH - 20, 0.6);
            
            
        }else {
            
            _labComment = [[UILabel alloc] initWithFrame:CGRectMake(_imageAvtar.left, _labTextInfor.bottom +  26 + heightLab, FULL_WIDTH - 30, 0)];
            
            _viewLine.frame = CGRectMake(_imageAvtar.left,  _labTextInfor.bottom + 13, FULL_WIDTH - 20, 0.6);

        }
        
        _labComment.textColor = [UIColor colorWithHexString:@"#616161"];
        
        _labComment.font = [UIFont systemFontOfSize:15];
        
        // 把名字和评论拼接上
        NSString *strComment = [NSString stringWithFormat:@"%@： %@", comment.commentNickName, comment.content];
        
        // 设置label的行间距
        NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle  setLineSpacing:5];
        
        NSMutableAttributedString  *setString;
        
        NSRange range = NSMakeRange(0, comment.commentNickName.length + 1);
        
        setString = [[NSMutableAttributedString alloc] initWithString:strComment];
        
        [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [strComment length])];
        
        // 设置颜色
        [setString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#212121"] range:range];
        
        [setString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:range];
        
        
        _labComment.attributedText = setString;
        
        _labComment.numberOfLines = 3;
        
        [_labComment sizeToFit];
        
        heightLab += _labComment.height + 7;
        
        [self.contentView addSubview:_labComment];
        
    }
    
    // 全部几条评论
    UIButton *btnComment = [[UIButton alloc] initWithFrame:CGRectMake(_imageAvtar.left, _labTextInfor.bottom + heightLab + 30, FULL_WIDTH - 20, 16)];
    
    [btnComment addTarget:self action:@selector(onclickBtnComment:) forControlEvents:UIControlEventTouchUpInside];

    
    [btnComment setTitle:_homePageEntity.totalCommentMsg forState:UIControlStateNormal];
    
    [btnComment setTitleColor:[UIColor colorWithHexString:@"#969696"] forState:UIControlStateNormal];
    
    btnComment.titleLabel.font = [UIFont systemFontOfSize:14];
    
    if (_homePageEntity.partCommentList.count == 0) {
        
        btnComment.frame = CGRectMake(0, 0, 0, 0);
        
        _heightCell = _labTextInfor.bottom + 7;
        
    }else {
        
        _heightCell = btnComment.bottom;
        
    }
    
    btnComment.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [self addSubview:btnComment];
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(reloadTableViewheight:)]) {
        
        [self.delegate reloadTableViewheight:_heightCell];
        
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
