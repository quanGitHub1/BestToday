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

            
            [self.contentView addSubview:_imageAvtar];
            
            [self.contentView addSubview:_labName];
            
            [self.contentView addSubview:_btnAtten];
            
            [self.contentView addSubview:_imagePic];
            
            [self.contentView addSubview:_labTime];
            
            [self.contentView addSubview:_labFabulous];
            
            [self.contentView addSubview:_btnCollection];

            [self.contentView addSubview:_btnComment];
            
            [self.contentView addSubview:_btnShare];
            
//            [self.contentView addSubview:_labDescrp];
            
        }
        return self;
        
    }
    return self;
}


- (void)onclickBtnAtten:(UIButton *)btn{
    

}

- (void)onclickBtnCollection:(UIButton *)btn{

}

- (void)onclickBtnComment:(UIButton *)btn{
    
}

- (void)onclickBtnShare:(UIButton *)btn{
    
}

- (void)makeDatacell{

    _labName.text = @"罗密欧";
    
    _labTime.text = @"5分钟前";
    
    _labFabulous.text = @"119赞";
    
    [_labFabulous sizeToFit];
    
    UIImage *iamgeshare = [UIImage imageNamed:@"share"];
    
    UIImage *iamgeInformation = [UIImage imageNamed:@"information"];

    UIImage *iamgeCollection = [UIImage imageNamed:@"collection_select"];

    [_btnCollection setImage:iamgeCollection forState:UIControlStateNormal];
    
//    _btnCollection.frame = CGRectMake(_labFabulous.right + 15, _imagePic.bottom + 12, iamgeCollection.size.width, iamgeCollection.size.height);
    
    _btnCollection.frame = CGRectMake(_labFabulous.right + 15, _imagePic.bottom + 12, 20, 20);

    
    [_btnComment setImage:iamgeInformation forState:UIControlStateNormal];

//    _btnComment.frame = CGRectMake(_btnCollection.right + 24, _imagePic.bottom + 12, iamgeCollection.size.width, iamgeCollection.size.height);
    
    _btnComment.frame = CGRectMake(_btnCollection.right + 24, _imagePic.bottom + 12, 20, 20);


    
    [_btnShare setImage:iamgeshare forState:UIControlStateNormal];

//    _btnShare.frame = CGRectMake(_btnComment.right + 24, _imagePic.bottom + 12, iamgeCollection.size.width, iamgeCollection.size.height);
    
    _btnShare.frame = CGRectMake(_btnComment.right + 24, _imagePic.bottom + 12, 20, 20);
    
    NSString *testStr = @"阿加阿达科技大厦空军啊空军打卡多久啊开始搭建啊看来大家啊看来大家啊可怜的了大家啊陆慷的杰拉德将离开饿哦我反胃啊没事卡利久里开车拉萨城看看撒加克里斯朵夫考虑是否将咖喱饭就啊哭了；飞机";
    
    int font = 15;
    int row = 3;
    
    CGFloat height = font * (row + 1);
    
    
      _labDescrp = [OpenDetailsView initWithFrame:CGRectMake(_imageAvtar.left, _labTime.bottom + 15, FULL_WIDTH - 30, height) text:testStr font:font numberOfRow:row + 1 block:^(CGFloat height) {
        
        _labDescrp.frame = CGRectMake(_imageAvtar.left, _labTime.bottom + 15, FULL_WIDTH - 30, height);
        

    }];
    
    [self.contentView addSubview:_labDescrp];

    
    _heightCell = _labDescrp.bottom + 20;

    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
