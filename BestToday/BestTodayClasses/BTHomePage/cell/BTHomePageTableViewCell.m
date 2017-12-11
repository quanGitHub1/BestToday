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

@implementation BTHomePageTableViewCell

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
            
            _btnAtten = [[UIButton alloc] initWithFrame:CGRectMake(FULL_WIDTH - 65, 15, 50, 25)];
            
            _btnAtten.backgroundColor = [UIColor whiteColor];
            
            [_btnAtten setTitleColor:[UIColor colorWithHexString:@"#616161"] forState:UIControlStateNormal];
            
            _btnAtten.titleLabel.font = [UIFont systemFontOfSize:13];
            
            _imagePic = [[UIImageView alloc] initWithFrame:CGRectMake(0, _imageAvtar.bottom + 15, FULL_WIDTH, ScaleHeight(350))];
            
            _imagePic.backgroundColor = [UIColor whiteColor];
            
            _labTime = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#bdbdbd" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:12] bkColor:nil frame:CGRectMake(_imageAvtar.left, _imagePic.bottom + 15, 150, 18)];
        
            
            _labFabulous = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#bdbdbd" alpha:1] align:NSTextAlignmentRight font:[UIFont systemFontOfSize:12] bkColor:nil frame:CGRectMake(FULL_WIDTH / 2, _labTime.top, 50, 15)];
            
            _labTextInfor = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#bdbdbd" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:15] bkColor:nil frame:CGRectMake(FULL_WIDTH / 2 + 15, _labTime.top, FULL_WIDTH - 30, 0)];
            
            
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

- (void)onclickBtnComment:(UIButton *)btn{
    
    //设置用户自定义的平台
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),
                                               @(UMSocialPlatformType_WechatTimeLine),
                                               @(UMSocialPlatformType_WechatFavorite),
                                               @(UMSocialPlatformType_QQ),
                                               @(UMSocialPlatformType_Tim),
                                               @(UMSocialPlatformType_Qzone),
                                               @(UMSocialPlatformType_Sina),
                                               @(UMSocialPlatformType_TencentWb),
                                               ]];
    
    [UMSocialUIManager setShareMenuViewDelegate:self];
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

- (void)tapView:(UITapGestureRecognizer*)gesTap{
    
    BTMeViewController *meView = [[BTMeViewController alloc] init];
    
    BTHomeUserEntity *userEntity = [BTHomeUserEntity yy_modelWithJSON:_homePageEntity.userVo];

    meView.userId = userEntity.userId;
    
    meView.otherId = YES;
    
    [[self viewController].navigationController pushViewController:meView animated:YES];
    
}

- (void)makeDatacellData:(BTHomePageEntity *)homePage index:(NSInteger)indexpath{
    
    //  拿到id 点赞关注评论都有用
    _resourceId = homePage.resourceId;
    
    _homePageEntity = homePage;
    
    BTHomeUserEntity *userEntity = [BTHomeUserEntity yy_modelWithJSON:homePage.userVo];
    
    _btnAtten.tag = indexpath + 10000;

    
    if ([userEntity.isFollowed integerValue] == 0) {
        
        _btnAtten.frame = CGRectMake(FULL_WIDTH - 65, 15, 50, 25);
        [_btnAtten setTitle:@"+关注" forState:UIControlStateNormal];
        
        _btnAtten.layer.borderColor = [UIColor colorWithHexString:@"#fd8671"].CGColor;
        
        _btnAtten.layer.borderWidth = 1;
        
        _btnAtten.layer.cornerRadius = 1.5;

        
        [_btnAtten setTitleColor:[UIColor colorWithHexString:@"#fd8671"] forState:UIControlStateNormal];
        
        
    }else {
        
        [_btnAtten setTitle:@"..." forState:UIControlStateNormal];
        
        _btnAtten.frame = CGRectMake(FULL_WIDTH - 35, 13, 30, 20);

        
        [_btnAtten setTitleColor:[UIColor colorWithHexString:@"#616161"] forState:UIControlStateNormal];
        
        _btnAtten.layer.borderColor = [UIColor whiteColor].CGColor;
        
        _btnAtten.layer.borderWidth = 0;

    }

    _labName.text = userEntity.nickName;
    
    [_imageAvtar sd_setImageWithURL:[NSURL URLWithString:userEntity.avatarUrl] placeholderImage:nil];
    
    _labTime.text = homePage.createTime;
    
    _labFabulous.text = [NSString stringWithFormat:@"%@赞",homePage.likeCount];
    
    
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
                
                CGFloat heightLab = 0.0;
                
                CGFloat heightLabTwo = 0.0;
                
                for (int i = 0; i < arrCommentList.count; i++) {
                    
                    BTHomeComment *comment = [arrCommentList objectAtIndex:i];
                    
                    UILabel *labComment = [[UILabel alloc] initWithFrame:CGRectMake(_imageAvtar.left, heightLab + _labDescrp.bottom + 15, FULL_WIDTH - 30, 0)];
                    
                    // 设置label的行间距
                    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                    
                    
                    [paragraphStyle  setLineSpacing:8];
                    
                    NSMutableAttributedString  *setString;
                    
                    setString = [[NSMutableAttributedString alloc] initWithString:comment.content];
                    
                    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [comment.content length])];
                    
                    labComment.attributedText = setString;
                    
                    labComment.numberOfLines = 3;
                    
                    labComment.font = [UIFont systemFontOfSize:14];
                    
                    [labComment sizeToFit];
                    
                    heightLab += labComment.height + 10;
                    
                    // 可能会有问题还需要修改
                    if (i == arrCommentList.count - 1 && i > 1) {
                        
                        heightLabTwo = heightLab + labComment.height;
                    }else {
                        
                        heightLabTwo = heightLab;
                    }
                    
                }
                
                
                _labTextInfor.text = homePage.textInfo;
                
                NSArray *textArry = [self getSeparatedLinesFromLabel:_labTextInfor];
                
                int font = 15;
                
                CGFloat height = 0.0;
                
                
                // 没有评论和描述高度为0
                if (arrCommentList.count == 0 && homePage.textInfo.length == 0) {
                    
                    height = 0;
                    
                }else {
                    
                    height = font * (textArry.count + 1) + heightLabTwo + 10;
                    
                }
                
                _labDescrp = [OpenDetailsView initWithFrame:CGRectMake(_imageAvtar.left, _labTime.bottom + 15, FULL_WIDTH - 30, height) text:homePage.textInfo totalCommentMsg:homePage.totalCommentMsg comment:arrCommentList font:font numberOfRow:(int)textArry.count + 1 indexPath:indexpath block:^(CGFloat height, NSInteger indexpath) {
                    
                    _labDescrp.frame = CGRectMake(_imageAvtar.left, _labTime.bottom + 15, FULL_WIDTH - 30, height);
                    
                    if (_delegate && [_delegate respondsToSelector:@selector(reloadTableView:height:)]) {
                        
                        _heightCell = _labDescrp.bottom + 20;
                        
                        [self.delegate reloadTableView:indexpath height:_heightCell];
                        
                    }
                    
                }];
                
                
                [self.contentView addSubview:_labDescrp];
                
                if (_heightCell == 0) {
                    
                    _heightCell = _labDescrp.bottom + 10;
                    
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
        
        _labFabulous.frame = CGRectMake(FULL_WIDTH / 2, _labTime.top, 50, 15);
        
        _labTextInfor.frame = CGRectMake(FULL_WIDTH / 2 + 15, _labTime.top, FULL_WIDTH - 30, 0);
        
        
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
        
        NSMutableArray *arrCommentList = [NSMutableArray array];
        
        if (_homePageEntity.partCommentList.count > 0) {
            
            for (NSDictionary *dicList in _homePageEntity.partCommentList) {
                
                BTHomeComment *homeComment = [BTHomeComment yy_modelWithJSON:dicList];
                
                [arrCommentList addObject:homeComment];
                
            }
            
        }
        
        CGFloat heightLab = 0.0;
        
        CGFloat heightLabTwo = 0.0;
        
        for (int i = 0; i < arrCommentList.count; i++) {
            
            BTHomeComment *comment = [arrCommentList objectAtIndex:i];
            
            UILabel *labComment = [[UILabel alloc] initWithFrame:CGRectMake(_imageAvtar.left, heightLab + _labDescrp.bottom + 15, FULL_WIDTH - 30, 0)];
            
            // 设置label的行间距
            NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            
            [paragraphStyle  setLineSpacing:8];
            
            NSMutableAttributedString  *setString;
            
            setString = [[NSMutableAttributedString alloc] initWithString:comment.content];
            
            [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [comment.content length])];
            
            labComment.attributedText = setString;
            
            labComment.numberOfLines = 3;
            
            labComment.font = [UIFont systemFontOfSize:14];
            
            [labComment sizeToFit];
            
            heightLab += labComment.height + 10;
            
            // 可能会有问题还需要修改
            if (i == arrCommentList.count - 1 && i > 1) {
                
                heightLabTwo = heightLab + labComment.height;
                
            }else {
                
                heightLabTwo = heightLab;
            }
            
        }
        
        
        _labTextInfor.text = _homePageEntity.textInfo;
        
        NSArray *textArry = [self getSeparatedLinesFromLabel:_labTextInfor];
        
        int font = 15;
        
        CGFloat height = 0.0;
        
        
        // 没有评论和描述高度为0
        if (arrCommentList.count == 0 && _homePageEntity.textInfo.length == 0) {
            
            height = 0;
            
        }else {
            
            height = font * (textArry.count + 1) + heightLabTwo + 50;
            
        }
        
        _labDescrp = [OpenDetailsView initWithFrame:CGRectMake(_imageAvtar.left, _labTime.bottom + 15, FULL_WIDTH - 30, height) text:_homePageEntity.textInfo totalCommentMsg:_homePageEntity.totalCommentMsg comment:arrCommentList font:font numberOfRow:(int)textArry.count indexPath:indexpath block:^(CGFloat height, NSInteger indexpath) {
            
            _labDescrp.frame = CGRectMake(_imageAvtar.left, _labTime.bottom + 15, FULL_WIDTH - 30, height);
            
            if (_delegate && [_delegate respondsToSelector:@selector(reloadTableView:height:)]) {
                
                _heightCell = _labDescrp.bottom + 20;
                
                [self.delegate reloadTableView:indexpath height:_heightCell];
                
            }
            
        }];
        
        
        [self.contentView addSubview:_labDescrp];
        
        if (_heightCell == 0) {
            
            _heightCell = _labDescrp.bottom + 10;
            
        }
    
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
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines){
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return linesArray;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
