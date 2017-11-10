//
//  BTMeViewController.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTMeViewController.h"

@interface BTMeViewController ()

@property (nonatomic, strong) UIImageView *imageAvtar;

@property (nonatomic, strong) UILabel *labName;

@property (nonatomic, strong) UIButton *btnPublish;   // 发表

@property (nonatomic, strong) UIButton *btnFans;      // 粉丝

@property (nonatomic, strong) UIButton *btnfollow;   // 关注

@property (nonatomic, strong) UILabel *labDes;       // 描述

@property (nonatomic, strong) UIButton *btnModify;    // 修改


@end

@implementation BTMeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.title = @"个人中心";
    
   UIView *headView = [self creatHeaderView:CGRectMake(0, NAVBAR_HEIGHT, FULL_WIDTH, 200)];
    
   [self.view addSubview:headView];
    
}

-(void)setNavgationBar{

    
}

- (UIView *)creatHeaderView:(CGRect)frame{
    
    UIView *viewHeaer = [[UIView alloc] initWithFrame:frame];
    
    _imageAvtar = [[UIImageView alloc] initWithFrame:CGRectMake(15, 17, ScaleWidth(54), ScaleHeight(54))];
    
    _imageAvtar.contentMode = UIViewContentModeScaleAspectFit;
    
    _imageAvtar.backgroundColor = [UIColor redColor];
    
    _imageAvtar.layer.cornerRadius = ScaleWidth(27);
    
    _imageAvtar.clipsToBounds = YES;
    
    _labName = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#212121" alpha:1] align:NSTextAlignmentLeft font:[UIFont boldSystemFontOfSize:18] bkColor:nil frame:CGRectMake(13 + _imageAvtar.right, 21, 200, 0)];
    
    _labName.text = @"dsfdsfsdv";
    
    [_labName sizeToFit];
    
    UIImage *imageName = [UIImage imageNamed:@"My_Modify"];

    _btnModify = [[UIButton alloc] initWithFrame:CGRectMake(_labName.right + 6, 16, imageName.size.width, imageName.size.height)];
    
    [_btnModify setImage:imageName forState:UIControlStateNormal];
    
    _btnPublish = [[UIButton alloc] initWithFrame:CGRectMake(_labName.left, _labName.bottom + 20, 55, 0)];
    
    [_btnPublish setTitle:@"发表 20" forState:UIControlStateNormal];
    
    _btnPublish.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [_btnPublish setTitleColor:[UIColor colorWithHexString:@"#969696"] forState:UIControlStateNormal];

    
    [_btnPublish.titleLabel sizeToFit];
    
    
    
    _btnFans = [[UIButton alloc] initWithFrame:CGRectMake(_btnPublish.right + 40, _labName.bottom + 20, 55, 0)];
    
    [_btnFans setTitle:@"粉丝 350" forState:UIControlStateNormal];
    
    [_btnFans setTitleColor:[UIColor colorWithHexString:@"#969696"] forState:UIControlStateNormal];
    
    _btnFans.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [_btnFans.titleLabel sizeToFit];
    
    _btnfollow = [[UIButton alloc] initWithFrame:CGRectMake(_btnFans.right + 40, _labName.bottom + 20, 55, 0)];
    
    [_btnfollow setTitle:@"关注 365" forState:UIControlStateNormal];
    
    [_btnfollow setTitleColor:[UIColor colorWithHexString:@"#969696"] forState:UIControlStateNormal];
    
    _btnfollow.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [_btnfollow.titleLabel sizeToFit];
    
    _labDes = [UILabel mlt_labelWithText:@"成年快乐撒开连锁酒店；打卡大哭大哭；利库德的考拉我钦点的扩大到；奥兰多的萨达大厦" color:[UIColor mlt_colorWithHexString:@"#212121" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:14] bkColor:nil frame:CGRectMake(_imageAvtar.left, _imageAvtar.bottom + 17, FULL_WIDTH - 30, 0)];

    // 设置label的行间距
    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle  setLineSpacing:15];
    
    NSMutableAttributedString  *setString;
    
    setString = [[NSMutableAttributedString alloc] initWithString:_labDes.text];
    
    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_labDes.text length])];
    
    _labDes.attributedText = setString;
    
    _labDes.numberOfLines = 0;
    
    [_labDes sizeToFit];
    
    [viewHeaer addSubview:_imageAvtar];
    
    [viewHeaer addSubview:_labName];
    
    [viewHeaer addSubview:_btnModify];
    
    [viewHeaer addSubview:_btnPublish];

    [viewHeaer addSubview:_btnFans];
    
    [viewHeaer addSubview:_btnfollow];
    
    [viewHeaer addSubview:_labDes];
    
    return viewHeaer;
    
}

@end
