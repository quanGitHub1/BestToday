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

@implementation BTHomeDetailPageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        if (self) {
            
            self.backgroundColor = [UIColor whiteColor];
            
            _imageAvtar = [[UIImageView alloc] initWithFrame:CGRectMake(15, 9, ScaleWidth(32), ScaleHeight(32))];
            
            _imageAvtar.contentMode = UIViewContentModeScaleAspectFit;
            
            _imageAvtar.backgroundColor = [UIColor whiteColor];
            
            _imageAvtar.layer.cornerRadius = ScaleWidth(16);
            
            _imageAvtar.clipsToBounds = YES;
            
            _labName = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#212121" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:16] bkColor:nil frame:CGRectMake(_imageAvtar.right + 10, _imageAvtar.top + (_imageAvtar.height - 18)/2, 200, 18)];
            
            _btnAtten = [[UIButton alloc] initWithFrame:CGRectMake(FULL_WIDTH - 35, 10, 30, 20)];
            
            _btnAtten.backgroundColor = [UIColor whiteColor];
            
            [_btnAtten addTarget:self action:@selector(onclickBtnAtten:) forControlEvents:UIControlEventTouchUpInside];
                        
            [_btnAtten setTitleColor:[UIColor colorWithHexString:@"#616161"] forState:UIControlStateNormal];
            
            _btnAtten.titleLabel.font = [UIFont systemFontOfSize:20];
            
            _imagePic = [[UIImageView alloc] initWithFrame:CGRectMake(0, _imageAvtar.bottom + 15, FULL_WIDTH, ScaleHeight(350))];
            
            _imagePic.backgroundColor = [UIColor whiteColor];
            
            _labTime = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#bdbdbd" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:12] bkColor:nil frame:CGRectMake(_imageAvtar.left, _imagePic.bottom + 15, 150, 18)];
            
            
            _labFabulous = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#bdbdbd" alpha:1] align:NSTextAlignmentRight font:[UIFont systemFontOfSize:12] bkColor:nil frame:CGRectMake(FULL_WIDTH / 2, _labTime.top, 50, 15)];
            
            _labTextInfor = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#bdbdbd" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:12] bkColor:nil frame:CGRectMake(FULL_WIDTH / 2 + 15, _labTime.top, FULL_WIDTH - 30, 0)];
            
            
            _viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, _labTextInfor.bottom , FULL_WIDTH - 20, 10)];

            
            _btnCollection = [[UIButton alloc] init];
            
            [_btnCollection addTarget:self action:@selector(onclickBtnCollection:) forControlEvents:UIControlEventTouchUpInside];
            
            _btnComment = [[UIButton alloc] init];
            
            [_btnComment addTarget:self action:@selector(onclickBtnComment:) forControlEvents:UIControlEventTouchUpInside];
            
            _btnShare = [[UIButton alloc] init];
            
            [_btnShare addTarget:self action:@selector(onclickBtnShare:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.contentView addSubview:_imageAvtar];
            
            [self.contentView addSubview:_labName];
            
            [self.contentView addSubview:_btnAtten];
            
            [self.contentView addSubview:_imagePic];
            
            [self.contentView addSubview:_labTime];
            
            [self.contentView addSubview:_labFabulous];
            
            [self.contentView addSubview:_btnCollection];
            
            [self.contentView addSubview:_btnComment];
            
            [self.contentView addSubview:_btnShare];
            
            [self.contentView addSubview:_labTextInfor];
            
            [self.contentView addSubview:_labDescrp];
            
            [self.contentView addSubview:_viewLine];

        }
        return self;
        
    }
    return self;
}


- (void)onclickBtnAtten:(UIButton *)btn{
    
    
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
                
                
                
            }else {
                
                [SVProgressHUD showInfoWithStatus:@"点赞失败"];
                
            }
        }];
    }
    
}

- (void)onclickBtnComment:(UIButton *)btn{
    
}

- (void)onclickBtnShare:(UIButton *)btn{
    
    
    [WYShareView showShareViewWithPublishContent:@{@"text" :@"11111",
                                                   @"desc":@"2222",
                                                   @"image":@[_imagePic.image],
                                                   @"url"  :@""}
                                          Result:^(ShareType type, BOOL isSuccess) {
                                              
                                              
                                              //回调
                                          }];
}

//分享文本
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}


- (void)makeDatacellData:(BTHomePageEntity *)homePage index:(NSInteger)indexpath{
    
    //  拿到id 点赞关注评论都有用
    _resourceId = homePage.resourceId;
    
    _homePageEntity = homePage;
    
    BTHomeUserEntity *userEntity = [BTHomeUserEntity yy_modelWithJSON:homePage.userVo];
    
    _labName.text = userEntity.nickName;
    
    [_imageAvtar sd_setImageWithURL:[NSURL URLWithString:userEntity.avatarUrl] placeholderImage:nil];
    
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
    
    _labFabulous.frame = CGRectMake(FULL_WIDTH / 2, _labTime.top, 50, 15);
    
    
    UIImage *iamgeshare = [UIImage imageNamed:@"share"];
    
    UIImage *iamgeInformation = [UIImage imageNamed:@"information"];
    
    UIImage *iamgeCollectionSelect = [UIImage imageNamed:@"collection_select"];
    
    UIImage *iamgeCollection = [UIImage imageNamed:@"collection"];
    
    // 是否已经点赞
    _btnCollection.selected = [_homePageEntity.isLiked boolValue];
    
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
    
    
    [paragraphStyle  setLineSpacing:5];
    
    NSMutableAttributedString  *setString;
    
    setString = [[NSMutableAttributedString alloc] initWithString:_homePageEntity.textInfo];
    
    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_homePageEntity.textInfo length])];
    
    _labTextInfor.frame = CGRectMake(_imageAvtar.left, _labTime.bottom + 15, FULL_WIDTH - 30, 0);
    
    _labTextInfor.attributedText = setString;
    
    _labTextInfor.numberOfLines = 0;
    
    [_labTextInfor sizeToFit];
    
    _viewLine.frame = CGRectMake(_imageAvtar.left,  _labTextInfor.bottom + 2, FULL_WIDTH - 2 * _imageAvtar.left, 0.6);

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
    
    [btnComment setTitle:_homePageEntity.totalCommentMsg forState:UIControlStateNormal];
    
    [btnComment setTitleColor:[UIColor colorWithHexString:@"#969696"] forState:UIControlStateNormal];
    
    btnComment.titleLabel.font = [UIFont systemFontOfSize:14];
    
    if (_homePageEntity.partCommentList.count == 0) {
        
        btnComment.frame = CGRectMake(0, 0, 0, 0);
        
        _heightCell = _labTextInfor.bottom + 3;
        
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
