//
//  BTHomePageTableViewCell.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTHomePageTableViewCell.h"
#import "BTHomeUserEntity.h"
#import "BTHomeComment.h"
#import "CoreText/CoreText.h"
#import "WYShareView.h"
#import "BTMeViewController.h"
#import "BTMessageViewController.h"
#import "BTHomePageDetailViewController.h"
#import "MLLinkLabel.h"
#import "UILabel+Extension.h"
#import "UIButton+Extension.h"
#import "NSString+Extension.h"

@implementation BTHomePageTableViewCell
{
    UILabel *_contentLabel;
    UIButton *_moreButton;
    BOOL _shouldOpenContentLabel;
    CGFloat _lastContentWidth;
    NSInteger _indexPath;
    NSInteger _openHeight;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        if (self) {
            _shouldOpenContentLabel = YES;
            self.backgroundColor = [UIColor whiteColor];
            
            _imageAvtar = [[UIImageView alloc] initWithFrame:CGRectMake(15, 9, ScaleWidth(32), ScaleHeight(32))];
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
            
            _btnAtten = [[UIButton alloc] initWithFrame:CGRectMake(FULL_WIDTH - 65, 15, 50, 25)];
            
            _btnAtten.backgroundColor = [UIColor whiteColor];
            
            [_btnAtten setTitleColor:[UIColor colorWithHexString:@"#616161"] forState:UIControlStateNormal];
            
            _btnAtten.titleLabel.font = [UIFont systemFontOfSize:13];
            
            _imagePic = [[UIImageView alloc] initWithFrame:CGRectMake(0, _imageAvtar.bottom + 15, FULL_WIDTH, ScaleHeight(350))];
            
//            _imagePic.backgroundColor = [UIColor whiteColor];
//            
//            _imagePic.userInteractionEnabled = YES;
//            
//            //创建手势 使用initWithTarget:action:的方法创建
//            UITapGestureRecognizer *tapPic = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewPic:)];
//            
//            //设置属性
//            tapPic.numberOfTouchesRequired = 1;
//            
//            [_imagePic addGestureRecognizer:tapPic];
            
            _labTime = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#bdbdbd" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:12] bkColor:nil frame:CGRectMake(_imageAvtar.left, _imagePic.bottom + 15, 150, 18)];
        
            if (FULL_WIDTH > 380) {
                 _labFabulous = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#bdbdbd" alpha:1] align:NSTextAlignmentRight font:[UIFont systemFontOfSize:12] bkColor:nil frame:CGRectMake(FULL_WIDTH / 2, _labTime.top, 50, 15)];
            }else {
            
                 _labFabulous = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#bdbdbd" alpha:1] align:NSTextAlignmentRight font:[UIFont systemFontOfSize:12] bkColor:nil frame:CGRectMake(FULL_WIDTH / 2 - 20, _labTime.top, 50, 15)];
            }
           
            
//            _labTextInfor = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#bdbdbd" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:15] bkColor:nil frame:CGRectMake(FULL_WIDTH / 2 + 15, _labTime.top, FULL_WIDTH - 30, 0)];
            
            
            _btnCollection = [[UIButton alloc] init];
            
            [_btnCollection addTarget:self action:@selector(onclickBtnCollection:) forControlEvents:UIControlEventTouchUpInside];
            
            _btnComment = [[UIButton alloc] init];
            
            [_btnComment addTarget:self action:@selector(onclickBtnComment:) forControlEvents:UIControlEventTouchUpInside];

            
            _btnShare = [[UIButton alloc] init];
            
            [_btnShare addTarget:self action:@selector(onclickBtnShare:) forControlEvents:UIControlEventTouchUpInside];
            
            _contentLabel = [UILabel labelWithTitle:@"" color:HEX(@"616161") fontSize:15 alignment:NSTextAlignmentLeft];
            _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
//            if (maxContentLabelHeight == 0) {
//                maxContentLabelHeight = _contentLabel.font.lineHeight * 3 - 10;
//            }
            
            // 更多
            _moreButton = [UIButton buttonWithTitle:@"全文" imageName:nil target:self action:@selector(moreButtonClick)];
            
            [_moreButton setTitleColor:HEX(@"969696") forState:UIControlStateNormal];
            
            _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
            
            _commentTableView = [[BTCellCommentTableView alloc] init];
            
            UITapGestureRecognizer *commentTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableOnclickBtnComment)];
            [_commentTableView addGestureRecognizer:commentTap];
        
            [self.contentView addSubview:_imageAvtar];
            
            [self.contentView addSubview:_labName];
            
            [self.contentView addSubview:_btnAtten];
            
            [self.contentView addSubview:_imagePic];
            
            [self.contentView addSubview:_labTime];
            
            [self.contentView addSubview:_labFabulous];
            
            [self.contentView addSubview:_btnCollection];

            [self.contentView addSubview:_btnComment];
            
            [self.contentView addSubview:_btnShare];
            [self.contentView addSubview:_contentLabel];
            [self.contentView addSubview:_moreButton];
        }
        return self;
        
    }
    return self;
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

- (void)tableOnclickBtnComment{
    BTMessageViewController *messageVC = [[BTMessageViewController alloc] init];
    messageVC.isComment = YES;
    messageVC.resourceId = _resourceId;
    [[self viewController].navigationController pushViewController:messageVC animated:YES];
}

- (void)onclickBtnComment:(UIButton *)button{
    
    BTMessageViewController *messageVC = [[BTMessageViewController alloc] init];
    messageVC.isComment = YES;
    messageVC.resourceId = _resourceId;
    [[self viewController].navigationController pushViewController:messageVC animated:YES];

}

- (void)onclickBtnShare:(UIButton *)btn{
    

//    [WYShareView showShareViewWithPublishContent:@{@"text" :@"11111",
//                                                   @"desc":@"2222",
//                                                   @"image":@[_imagePic.image],
//                                                   @"url"  :@""}
//                                          Result:^(ShareType type, BOOL isSuccess) {
//                                              
//                                              
//                                              //回调
//                                          }];
    
    
        BTLikeCommentService *likeService = [BTLikeCommentService new];

        [likeService loadqueryGetSharePic:_resourceId completion:^(BOOL isSuccess, BOOL isCache, NSString *picUrl) {
            
            if (_delegate && [_delegate respondsToSelector:@selector(shareUM:)]) {

               [_delegate shareUM:picUrl];
            }

        }];
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

///** 点击大图*/
//- (void)tapViewPic:(UITapGestureRecognizer*)gesTap{
//    
//    BTHomePageDetailViewController *homePagedetail = [[BTHomePageDetailViewController alloc] init];
//    
//    homePagedetail.resourceId = _homePageEntity.resourceId;
//    
//    [[self viewController].navigationController pushViewController:homePagedetail animated:YES];
//    
//}

- (void)makeDatacellData:(BTHomePageEntity *)homePage index:(NSInteger)indexpath{
    
    //  拿到id 点赞关注评论都有用
    _resourceId = homePage.resourceId;
    
    _indexPath = indexpath;
    _homePageEntity = homePage;
    
    BTHomeUserEntity *userEntity = [BTHomeUserEntity yy_modelWithJSON:homePage.userVo];
    
    _btnAtten.tag = indexpath + 10000;

    if ([userEntity.isFollowed integerValue] == 0) {
        
        _btnAtten.frame = CGRectMake(FULL_WIDTH - 65, 15, 50, 25);
        [_btnAtten setTitle:@"+关注" forState:UIControlStateNormal];
        [_btnAtten setTitleColor:[UIColor colorWithHexString:@"#616161"] forState:UIControlStateNormal];
        
        _btnAtten.titleLabel.font = [UIFont systemFontOfSize:13];
        _btnAtten.layer.borderColor = [UIColor colorWithHexString:@"#fd8671"].CGColor;
        
        _btnAtten.layer.borderWidth = 1;
        
        _btnAtten.layer.cornerRadius = 1.5;

        [_btnAtten setTitleColor:[UIColor colorWithHexString:@"#fd8671"] forState:UIControlStateNormal];
        
    }else if ([userEntity.isFollowed integerValue] == 1){
        
        [_btnAtten setTitle:@"..." forState:UIControlStateNormal];
        [_btnAtten setTitleColor:[UIColor colorWithHexString:@"#969696"] forState:UIControlStateNormal];
        _btnAtten.titleLabel.font = [UIFont systemFontOfSize:16];
        _btnAtten.frame = CGRectMake(FULL_WIDTH - 35, 13, 30, 20);

        [_btnAtten setTitleColor:[UIColor colorWithHexString:@"#616161"] forState:UIControlStateNormal];
        
        _btnAtten.layer.borderColor = [UIColor whiteColor].CGColor;
        
        _btnAtten.layer.borderWidth = 0;

    }else{
        [_btnAtten setTitle:@"" forState:UIControlStateNormal];
        
        _btnAtten.frame = CGRectMake(FULL_WIDTH - 35, 13, 30, 20);
        
        [_btnAtten setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnAtten.titleLabel.font = [UIFont systemFontOfSize:13];

        _btnAtten.layer.borderColor = [UIColor whiteColor].CGColor;
        
        _btnAtten.layer.borderWidth = 0;
    }

    _labName.text = userEntity.nickName;
    
    [_imageAvtar sd_setImageWithURL:[NSURL URLWithString:userEntity.avatarUrl] placeholderImage:nil];
    
    _labTime.text = homePage.createTime;
    
    if ([homePage.likeCount isEqualToString:@"0"]) {
        _labFabulous.text = @"";
    }else{
        _labFabulous.text = [NSString stringWithFormat:@"%@赞",homePage.likeCount];
    }
    
    if (_homePageEntity.picWidth > 0 && _homePageEntity.picHeight > 0) {
        
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
            
            if (cachedImage) {
                
                CGFloat heightSize = cachedImage.size.height / cachedImage.size.width;
                
                _imagePic.frame = CGRectMake(0, _imageAvtar.bottom + 15, FULL_WIDTH, FULL_WIDTH * heightSize);
                
                [_imagePic setImage:cachedImage];
                
                _labTime.frame = CGRectMake(_imageAvtar.left, _imagePic.bottom + 15, 150, 18);
                
                _labFabulous.frame = CGRectMake(FULL_WIDTH / 2, _labTime.top, 50, 15);
                
                _labTextInfor.frame = CGRectMake(FULL_WIDTH / 2 + 15, _labTime.top, FULL_WIDTH - 30, 0);
                
                
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
                
                NSMutableArray *arrCommentList = [NSMutableArray array];
                
                if (homePage.partCommentList.count > 0) {
                    
                    for (NSDictionary *dicList in homePage.partCommentList) {
                        
                        BTHomeComment *homeComment = [BTHomeComment yy_modelWithJSON:dicList];
                        
                        [arrCommentList addObject:homeComment];
                        
                    }
                    
                }
                
                [self setupContentViewWithContent:_homePageEntity.msgContent with:arrCommentList totalString:_homePageEntity.totalCommentMsg];
                
                if (_heightCell == 0) {
                    _heightCell = _commentTableView.bottom + 20;
                }
                
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
    
        _labTextInfor.frame = CGRectMake(FULL_WIDTH / 2 + 15, _labTime.top, FULL_WIDTH - 30, 0);
        
        
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
        
        NSMutableArray *arrCommentList = [NSMutableArray array];
        
        if (_homePageEntity.partCommentList.count > 0) {
            
            for (NSDictionary *dicList in _homePageEntity.partCommentList) {
                
                BTHomeComment *homeComment = [BTHomeComment yy_modelWithJSON:dicList];
                
                [arrCommentList addObject:homeComment];
            }
        }
        [self setupContentViewWithContent:_homePageEntity.msgContent with:arrCommentList totalString:_homePageEntity.totalCommentMsg];
    
        if (_heightCell == 0) {
            _heightCell = _commentTableView.bottom + 20;
        }
}

- (CGFloat)getHeightForCell{
    return _heightCell;
}

- (void)setupContentViewWithContent:(NSString *)content with:(NSArray *)arrCommentList totalString:(NSString *)totalString
{
    
    BOOL hasContent = content.length > 0;
    _contentLabel.hidden = _moreButton.hidden = !hasContent;
    CGSize commentViewSize = CGSizeMake(0, 0);
    if (arrCommentList.count > 0) {
        commentViewSize = [self getCommentViewSizeWithComment:arrCommentList];
        [self.contentView addSubview:_commentTableView];
    }

    CGFloat margin = 10;
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    CGFloat iconViewWH = 45;
    CGFloat contentW = cellW - (margin + iconViewWH + margin) - margin;
    if (content.length) {  // 有文字
        _contentLabel.text = content;
        CGSize textSize = [content sizeWithFont:[UIFont systemFontOfSize:15] maxW:contentW];
        if (self.homePageEntity.shouldShowMoreButton) { // 如果文字高度超过60
            _moreButton.hidden = NO;
            if (self.homePageEntity.isOpening) {
                [_moreButton setTitle:@"收起" forState:UIControlStateNormal];
                _contentLabel.frame = CGRectMake(_imageAvtar.left, _labTime.bottom +5, FULL_WIDTH - 30,textSize.height);
            } else {
                [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
                _contentLabel.frame = CGRectMake(_imageAvtar.left, _labTime.bottom +5, FULL_WIDTH - 30, 60);
            }
            _moreButton.frame = CGRectMake(_imageAvtar.left, _contentLabel.bottom +5, 50, 15);;
            _commentTableView.frame = CGRectMake(_imageAvtar.left, _contentLabel.bottom +25, commentViewSize.width, commentViewSize.height +30);
        }else {  // 没有超过60
            _moreButton.hidden = YES;
            _contentLabel.frame = CGRectMake(_imageAvtar.left, _labTime.bottom +10, FULL_WIDTH - 30, textSize.height);
            _commentTableView.frame = CGRectMake(_imageAvtar.left, _contentLabel.bottom +10, commentViewSize.width, commentViewSize.height +30);
        }
        
    }else{
        _commentTableView.frame = CGRectMake(_imageAvtar.left, _labTime.bottom +10, commentViewSize.width, commentViewSize.height + 30);
    }

    _commentTableView.commentArray = arrCommentList;
    _commentTableView.totleString =totalString;
}

// 展开文字高度超过的按钮
- (void)moreButtonClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LZMoreButtonClickedNotification" object:self userInfo:@{@"LZMoreButtonClickedNotificationKey" : [NSString stringWithFormat:@"%ld",(long)_indexPath]}];
}

- (CGSize)getCommentViewSizeWithComment:(NSArray *)commentArray
{
    CGFloat tableViewHeight = 0;
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 70;
    if (commentArray.count) {
        for (int i = 0; i < commentArray.count; i++) {
            BTHomeComment * model = commentArray[i];
            NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:[self generateAttributedStringWithCommentItemModel:model]];
            MLLinkLabel *label = [MLLinkLabel new];
            label.attributedText = text;
            label.numberOfLines = 0;
            label.lineHeightMultiple = 1.1f;
            label.font = [UIFont systemFontOfSize:14];
            UIColor *highLightColor = [UIColor blueColor];
            label.linkTextAttributes = @{NSForegroundColorAttributeName : highLightColor};
            label.activeLinkTextAttributes = @{NSForegroundColorAttributeName:[UIColor blueColor],NSBackgroundColorAttributeName:kDefaultActiveLinkBackgroundColorForMLLinkLabel};
            CGFloat h = [label preferredSizeWithMaxWidth:contentW].height;
            label = nil;
            tableViewHeight += h;
        }
    }
    return CGSizeMake(contentW, tableViewHeight);
}

#pragma mark - private actions
- (NSMutableAttributedString *)generateAttributedStringWithCommentItemModel:(BTHomeComment *)model
{
    NSString *text = model.commentNickName;
    text = [text stringByAppendingString:[NSString stringWithFormat:@"：%@", model.content]];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    UIColor *highLightColor = [UIColor blackColor];
    [attString setAttributes:@{NSForegroundColorAttributeName : highLightColor, NSLinkAttributeName : model.commentNickName} range:[text rangeOfString:model.commentNickName]];
    return attString;
}


//获取View所在的Viewcontroller方法
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


- (NSArray *)getSeparatedLinesFromLabel:(UILabel *)label
{
    NSString *text = [label text];
    UIFont *font = [label font];
    CGRect rect = [label frame];
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width - 35,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines){
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        
        lineString = [lineString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        [linesArray addObject:lineString];
    }
    return linesArray;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
