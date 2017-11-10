//
//  BTMeViewController.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTMeViewController.h"
#import "MLTSegementView.h"
#import "BTMeCollectionView.h"
#import "BTMeEditInforViewController.h"

@interface BTMeViewController ()<MLTTouchLabelDelegate>

@property (nonatomic, strong) UIImageView *imageAvtar;

@property (nonatomic, strong) UILabel *labName;

@property (nonatomic, strong) UIButton *btnPublish;   // 发表

@property (nonatomic, strong) UIButton *btnFans;      // 粉丝

@property (nonatomic, strong) UIButton *btnfollow;   // 关注

@property (nonatomic, strong) UILabel *labDes;       // 描述

@property (nonatomic, strong) UIButton *btnModify;    // 修改

@property (nonatomic, strong) UILabel *labTag;    // 标签

@property (nonatomic, strong) UIView *viewLine;    // 线

@property (nonatomic, strong) MLTSegementView *segementView;

@property (nonatomic) CGFloat heightHeader;

@property (nonatomic,strong) BTMeCollectionView *collectionView;

@property (nonatomic,strong) BTMeCollectionView *collectionViewTwo;


@end

@implementation BTMeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavgationBar];
    
   UIView *headView = [self creatHeaderView:CGRectMake(0, NAVBAR_HEIGHT, FULL_WIDTH, 270)];
    
   [self.view addSubview:headView];
    
   [self creatSegment];

}

-(void)setNavgationBar{

    self.navigationBar.title = @"个人中心";
    // 添加右上角按钮
    [self.navigationBar setRightBarButton:[UIButton mlt_rightBarButtonWithImage:[UIImage imageNamed:@"addFriend"] highlightedImage:nil target:self action:@selector(addFriend:)forControlEvents:UIControlEventTouchUpInside]];
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
    
    _labTag = [UILabel mlt_labelWithText:@"#电影  美食  设计  摄影  旅行  食物派" color:[UIColor mlt_colorWithHexString:@"#969696" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:14] bkColor:nil frame:CGRectMake(_imageAvtar.left, _labDes.bottom + 16, FULL_WIDTH - 30, 0)];
    
    [_labTag sizeToFit];
    
    _viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, _labTag.bottom + 16, FULL_WIDTH, 1)];
    
    _viewLine.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    _heightHeader = _viewLine.bottom + NAVBAR_HEIGHT;
    
    [viewHeaer addSubview:_imageAvtar];
    
    [viewHeaer addSubview:_labName];
    
    [viewHeaer addSubview:_btnModify];
    
    [viewHeaer addSubview:_btnPublish];

    [viewHeaer addSubview:_btnFans];
    
    [viewHeaer addSubview:_btnfollow];
    
    [viewHeaer addSubview:_labDes];
    
    [viewHeaer addSubview:_labTag];
    
    [viewHeaer addSubview:_viewLine];
    
    return viewHeaer;
}


- (void)creatSegment{
    
    _segementView = [[MLTSegementView alloc]initWithFrame:CGRectMake(0, _heightHeader, FULL_WIDTH, 50)];
    
    _segementView.touchDelegate = self;
    
    _segementView.titleArray = @[@"作品",@"喜欢"];
    
    [_segementView.scrollLine setBackgroundColor:[UIColor mlt_colorWithHexString:@"#c09034" alpha:1]];
    
    _segementView.titleSelectedColor = [UIColor mlt_colorWithHexString:@"#212121" alpha:1];
    
    _segementView.backgroundColor = [UIColor whiteColor];
    
    _collectionView = [[BTMeCollectionView alloc] initWithFrame:CGRectMake(0, _segementView.bottom, FULL_WIDTH, FULL_HEIGHT - _segementView.bottom)];
    
    _collectionViewTwo = [[BTMeCollectionView alloc] initWithFrame:CGRectMake(0, _segementView.bottom, FULL_WIDTH, FULL_HEIGHT - _segementView.bottom)];

    
    [self.view addSubview:_segementView];
    
    [self.view addSubview:_collectionView];
    
    [self.view addSubview:_collectionViewTwo];
}

/** 点击工具栏选择 */
- (void)touchLabelWithIndex:(NSInteger)index{
    
  
    if (index == 0) {
        
        [self.view bringSubviewToFront:_collectionView];
        
    }else {
        
        [self.view bringSubviewToFront:_collectionViewTwo];

      }
}

- (void)addFriend:(UIButton *)btn{
    
    BTMeEditInforViewController *editInfor = [[BTMeEditInforViewController alloc] init];
    
    [self.navigationController pushViewController:editInfor animated:YES];
}

@end
