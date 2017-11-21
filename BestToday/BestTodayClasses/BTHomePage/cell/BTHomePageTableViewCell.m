//
//  BTHomePageTableViewCell.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTHomePageTableViewCell.h"


@implementation BTHomePageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        if (self) {
            
            self.backgroundColor = [UIColor whiteColor];
            
            _imageAvtar = [[UIImageView alloc] initWithFrame:CGRectMake(15, 9, ScaleWidth(32), ScaleHeight(32))];
            
            _imageAvtar.contentMode = UIViewContentModeScaleAspectFit;
            
            _imageAvtar.backgroundColor = [UIColor redColor];
            
            _imageAvtar.layer.cornerRadius = ScaleWidth(16);
            
            _imageAvtar.clipsToBounds = YES;
            
            _labName = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#212121" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:16] bkColor:nil frame:CGRectMake(_imageAvtar.right + 10, _imageAvtar.top + (_imageAvtar.height - 18)/2, 200, 18)];
            
            _btnAtten = [[UIButton alloc] initWithFrame:CGRectMake(FULL_WIDTH - 35, 10, 30, 20)];
            
            _btnAtten.backgroundColor = [UIColor whiteColor];
            
            [_btnAtten addTarget:self action:@selector(onclickBtnAtten:) forControlEvents:UIControlEventTouchUpInside];
            
            [_btnAtten setTitle:@"..." forState:UIControlStateNormal];
            
            [_btnAtten setTitleColor:[UIColor colorWithHexString:@"#616161"] forState:UIControlStateNormal];
            
            _btnAtten.titleLabel.font = [UIFont systemFontOfSize:20];
            
            _imagePic = [[UIImageView alloc] initWithFrame:CGRectMake(0, _imageAvtar.bottom + 15, FULL_WIDTH, ScaleHeight(350))];
            
            _imagePic.backgroundColor = [UIColor yellowColor];
            
            _labTime = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#bdbdbd" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:12] bkColor:nil frame:CGRectMake(_imageAvtar.left, _imagePic.bottom + 15, 80, 18)];
        
            
            _labFabulous = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#bdbdbd" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:12] bkColor:nil frame:CGRectMake(FULL_WIDTH / 2 + 15, _labTime.top, 50, 0)];
            
//            _labDescrp = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#616161" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:14] bkColor:nil frame:CGRectMake(_imageAvtar.left, _labTime.bottom + 15, FULL_WIDTH - 30, 0)];
            
            _btnCollection = [[UIButton alloc] init];
            
            [_btnCollection addTarget:self action:@selector(onclickBtnCollection:) forControlEvents:UIControlEventTouchUpInside];
            
            _btnComment = [[UIButton alloc] init];
            
            [_btnComment addTarget:self action:@selector(onclickBtnComment:) forControlEvents:UIControlEventTouchUpInside];

            
            _btnShare = [[UIButton alloc] init];
            
            [_btnShare addTarget:self action:@selector(onclickBtnShare:) forControlEvents:UIControlEventTouchUpInside];

            
//           _viewLine = [[UIView alloc] initWithFrame:CGRectMake(5, _labDescrp.bottom + 15, FULL_WIDTH - 10, 0.6)];
            
            
            [self.contentView addSubview:_imageAvtar];
            
            [self.contentView addSubview:_labName];
            
            [self.contentView addSubview:_btnAtten];
            
            [self.contentView addSubview:_imagePic];
            
            [self.contentView addSubview:_labTime];
            
            [self.contentView addSubview:_labFabulous];
            
            [self.contentView addSubview:_btnCollection];

            [self.contentView addSubview:_btnComment];
            
            [self.contentView addSubview:_btnShare];
            
//            [self.contentView addSubview:_viewLine];

//            [self.contentView addSubview:_labDescrp];
            
        }
        return self;
        
    }
    return self;
}


- (void)onclickBtnAtten:(UIButton *)btn{
    

}

- (void)onclickBtnCollection:(UIButton *)btn{
    if (btn.selected == YES) {
        btn.selected = NO;
        
        _labFabulous.text = [NSString stringWithFormat:@"%ld",[_labFabulous.text integerValue] - 1];
    }else {
        btn.selected = YES;
        
        _labFabulous.text = [NSString stringWithFormat:@"%ld",[_labFabulous.text integerValue] + 1];

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
    
    __weak typeof(self) weakSelf = self;

    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo)
     {
        // 根据获取的platformType确定所选平台进行下一步操作
         [weakSelf shareTextToPlatformType:platformType];
         
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


- (void)makeDatacell:(NSInteger)indexpath{

    _labName.text = @"罗密欧";
    
    _labTime.text = @"5分钟前";
    
    _labFabulous.text = @"119赞";
    
    [_labFabulous sizeToFit];
    
    UIImage *iamgeshare = [UIImage imageNamed:@"share"];
    
    UIImage *iamgeInformation = [UIImage imageNamed:@"information"];

    UIImage *iamgeCollectionSelect = [UIImage imageNamed:@"collection_select"];
    
    UIImage *iamgeCollection = [UIImage imageNamed:@"collection"];


    [_btnCollection setImage:iamgeCollection forState:UIControlStateNormal];
    
    [_btnCollection setImage:iamgeCollectionSelect forState:UIControlStateSelected];

    _btnCollection.frame = CGRectMake(_labFabulous.right + 15, _imagePic.bottom + 12, iamgeCollection.size.width, iamgeCollection.size.height);
    
    
    [_btnComment setImage:iamgeInformation forState:UIControlStateNormal];

    _btnComment.frame = CGRectMake(_btnCollection.right + 24, _imagePic.bottom + 12, iamgeCollection.size.width, iamgeCollection.size.height);
    
    _btnComment.frame = CGRectMake(_btnCollection.right + 24, _imagePic.bottom + 12, 22, 22);
    
    [_btnShare setImage:iamgeshare forState:UIControlStateNormal];

    _btnShare.frame = CGRectMake(_btnComment.right + 24, _imagePic.bottom + 12, iamgeCollection.size.width, iamgeCollection.size.height);
    
    NSArray *arrData = @[@"阿加阿达科技大厦空军啊空军打卡多久啊开始搭建啊看来大家啊看来大家啊可怜的", @"阿加阿达科技大厦空军啊空军打卡多久啊开始搭建啊看来大家啊看来大家啊可怜的符合双方就开始恢复健康顺利返回就开始了复活节凯撒绿肥红瘦开发和科技阿里复活节卡洛斯复活节卡什莱夫", @"小阿联军啊jlksjfklsajfl;kasfjkls;afjas;l"];
    
    CGFloat heightLab = 0.0;
    
     CGFloat heightLabTwo = 0.0;
    
    for (int i = 0; i < arrData.count; i++) {
        
        UILabel *labComment = [[UILabel alloc] initWithFrame:CGRectMake(_imageAvtar.left, heightLab + _labDescrp.bottom + 15, FULL_WIDTH - 30, 0)];
        
        // 设置label的行间距
        NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        
        [paragraphStyle  setLineSpacing:8];
        
        NSMutableAttributedString  *setString;
        
        setString = [[NSMutableAttributedString alloc] initWithString:arrData[i]];
        
        [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [arrData[i] length])];
        
        labComment.attributedText = setString;
        
        labComment.numberOfLines = 3;
        
        labComment.font = [UIFont systemFontOfSize:14];
        
        [labComment sizeToFit];
        
        heightLab += labComment.height + 10;
        
        if (i == arrData.count - 1) {
            
            heightLabTwo = heightLab + labComment.height;
        }
        
    }
    
    NSString *testStr = @"阿加阿达科技大厦空军啊空军打卡多久啊开始搭建啊看来大家啊看来大家啊可怜的了大家啊陆慷的杰拉德将离开饿哦我反胃啊没事卡利久里开车拉萨城看看撒加克里斯朵夫考虑是否将咖喱饭就啊哭了；飞机";
    
    
    int font = 15;
    
    int row = 3;
    
    CGFloat height = font * (row + 1) + heightLabTwo + 30;
    
    
    _labDescrp = [OpenDetailsView initWithFrame:CGRectMake(_imageAvtar.left, _labTime.bottom + 15, FULL_WIDTH - 30, height) text:testStr font:font numberOfRow:row + 1 indexPath:indexpath block:^(CGFloat height, NSInteger indexpath) {
        
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
