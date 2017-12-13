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
#import "BTMeLikeCollectionView.h"
#import "BTMeEditInforViewController.h"
#import "BTAttentionMeViewController.h"
#import "BTMeAttentionViewController.h"
#import "BTMeService.h"
#import "BTMeEntity.h"
#import "BtHomePageService.h"


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

@property (nonatomic, strong) UIButton *btn;     //

@property (nonatomic, strong) MLTSegementView *segementView;

@property (nonatomic) CGFloat heightHeader;

@property (nonatomic,strong) BTMeCollectionView *collectionView;

@property (nonatomic,strong) BTMeLikeCollectionView *collectionViewTwo;

@property (nonatomic, strong) UIButton *btnAtten;  // 点击关注

@property (nonatomic, strong)BTMeService *meService;

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

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self loadData];

    [_collectionViewTwo loadData];
    
    [_collectionView loadData];
    
}

-(void)setNavgationBar{

    self.navigationBar.title = @"个人中心";
    // 添加右上角按钮
    [self.navigationBar setRightBarButton:[UIButton mlt_rightBarButtonWithImage:[UIImage imageNamed:@"addFriend"] highlightedImage:nil target:self action:@selector(addFriend:)forControlEvents:UIControlEventTouchUpInside]];
    
    if (_otherId == YES) {
        
        [self.navigationBar setLeftBarButton:[UIButton mlt_rightBarButtonWithImage:[UIImage imageNamed:@"info_backs"] highlightedImage:nil target:self action:@selector(navigationBackButtonClicked:) forControlEvents:UIControlEventTouchUpInside]];
    }
    
}

- (UIView *)creatHeaderView:(CGRect)frame{
    
    UIView *viewHeaer = [[UIView alloc] initWithFrame:frame];
    
    _imageAvtar = [[UIImageView alloc] initWithFrame:CGRectMake(15, 17, ScaleWidth(54), ScaleHeight(54))];
    
    _imageAvtar.backgroundColor = [UIColor whiteColor];
    
    _imageAvtar.layer.cornerRadius = ScaleWidth(27);
    
    _imageAvtar.clipsToBounds = YES;
    
    _labName = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#212121" alpha:1] align:NSTextAlignmentLeft font:[UIFont boldSystemFontOfSize:18] bkColor:nil frame:CGRectMake(13 + _imageAvtar.right, 21, 200, 0)];
    
    UIImage *imageName = [UIImage imageNamed:@"My_Modify"];

    _btnModify = [[UIButton alloc] initWithFrame:CGRectMake(_labName.right , 21, imageName.size.width, imageName.size.height)];
    
    [_btnModify setImage:imageName forState:UIControlStateNormal];
    
    [_btnModify addTarget:self action:@selector(onclickModify:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnModifys = [[UIButton alloc] initWithFrame:CGRectMake(_imageAvtar.right + 5, 21, 100, imageName.size.height)];

    [btnModifys addTarget:self action:@selector(onclickModify:) forControlEvents:UIControlEventTouchUpInside];
    
    btnModifys.backgroundColor = [UIColor clearColor];
    
    btnModifys.hidden = YES;
    
    [viewHeaer addSubview:btnModifys];
    
    _btnAtten = [[UIButton alloc] initWithFrame:CGRectMake(_labName.right, 16, ScaleWidth(50), ScaleWidth(25))];
    
    _btnAtten.backgroundColor = [UIColor whiteColor];
    
    [_btnAtten setTitleColor:[UIColor colorWithHexString:@"#969696"] forState:UIControlStateNormal];
    
    _btnAtten.titleLabel.font = [UIFont systemFontOfSize:13];
    
    _btnAtten.hidden = YES;
    
    [_btnAtten addTarget:self action:@selector(onclickBtnAtten:) forControlEvents:UIControlEventTouchUpInside];
    
    [viewHeaer addSubview:_btnAtten];
    
    // 发表
    _btnPublish = [[UIButton alloc] initWithFrame:CGRectMake(_imageAvtar.right + 5, 61, 65, 0)];
    
    _btnPublish.titleLabel.font = [UIFont systemFontOfSize:14];
    
    _btnPublish.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [_btnPublish setTitleColor:[UIColor colorWithHexString:@"#969696"] forState:UIControlStateNormal];

    [_btnPublish.titleLabel sizeToFit];
    
    // 粉丝
    _btnFans = [[UIButton alloc] initWithFrame:CGRectMake(_btnPublish.right + ScaleWidth(35), _btnPublish.top, 65, 0)];
    
    [_btnFans setTitleColor:[UIColor colorWithHexString:@"#969696"] forState:UIControlStateNormal];
    
    [_btnFans addTarget:self action:@selector(onclickFans:) forControlEvents:UIControlEventTouchUpInside];
    
    _btnFans.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [_btnFans.titleLabel sizeToFit];
    
    // 关注
    _btnfollow = [[UIButton alloc] initWithFrame:CGRectMake(_btnFans.right + ScaleWidth(35), _btnPublish.top, 65, 0)];
    
    [_btnfollow addTarget:self action:@selector(onclickFollow:) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnfollow setTitleColor:[UIColor colorWithHexString:@"#969696"] forState:UIControlStateNormal];
    
    _btnfollow.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [_btnfollow.titleLabel sizeToFit];
    
    _btnfollow.userInteractionEnabled = YES;
    
    _labDes = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#212121" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:14] bkColor:nil frame:CGRectMake(_imageAvtar.left, _imageAvtar.bottom + 17, FULL_WIDTH - 30, 0)];
    
    // 设置label的行间距
    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle  setLineSpacing:15];
    
    NSMutableAttributedString  *setString;
    
    setString = [[NSMutableAttributedString alloc] initWithString:_labDes.text];
    
    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_labDes.text length])];
    
    _labDes.attributedText = setString;
    
    _labDes.numberOfLines = 0;
    
    _labTag = [UILabel mlt_labelWithText:@"#电影  美食  设计  摄影  旅行  食物派" color:[UIColor mlt_colorWithHexString:@"#969696" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:14] bkColor:nil frame:CGRectMake(_imageAvtar.left, _labDes.bottom + 16, FULL_WIDTH - 30, 0)];
    
    [_labTag sizeToFit];
    
    _viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, _labTag.bottom + 16, FULL_WIDTH, 1)];
    
    _viewLine.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    _heightHeader = _viewLine.bottom + NAVBAR_HEIGHT;
    
    [viewHeaer addSubview:_imageAvtar];
    
    [viewHeaer addSubview:_labName];
    
    [viewHeaer addSubview:_btnModify];
    
    [viewHeaer addSubview:_btnFans];
    
    [viewHeaer addSubview:_btnfollow];
    
    [viewHeaer addSubview:_labDes];
    
    [viewHeaer addSubview:_labTag];
    
    [viewHeaer addSubview:_btnPublish];

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
    
    _collectionView = [[BTMeCollectionView alloc] initWithFrame:CGRectMake(0, _segementView.bottom, FULL_WIDTH, FULL_HEIGHT - _segementView.bottom - MLTTabbarHeight)];
    
    _collectionView.userId = _userId;
    
    [_collectionView loadData];
    
    _collectionViewTwo = [[BTMeLikeCollectionView alloc] initWithFrame:CGRectMake(0, _segementView.bottom, FULL_WIDTH, FULL_HEIGHT - _segementView.bottom - MLTTabbarHeight)];
    
    _collectionViewTwo.userId = _userId;

    [_collectionViewTwo loadData];

    [self.view addSubview:_segementView];
    
    [self.view addSubview:_collectionViewTwo];
    
    [self.view addSubview:_collectionView];

}

- (void)loadData{

    [self requestqueryUserById];
    
}

- (void)requestqueryUserById{
    
    if (_otherId == YES) {
        
        [self.meService loadqueryUserById:[_userId integerValue] completion:^(BOOL isSuccess, BOOL isCache) {
            
            if (isSuccess) {
                
                [self refreshHeaderView];
            }
            
        }];
        
    }else {
    
        [self.meService loadqueryUserById:[[BTMeEntity shareSingleton].userId integerValue] completion:^(BOOL isSuccess, BOOL isCache) {
            
            if (isSuccess) {
                
                [self refreshHeaderView];
            }
            
        }];
    }
   
}

// 刷新头部试图
- (void)refreshHeaderView{
    
    if (self.meService.arrByUser.count == 0) {
        
        return;
    }
    BTMeEntity *meEntity = [self.meService.arrByUser objectAtIndex:0];
    
    [_imageAvtar sd_setImageWithURL:[NSURL URLWithString:meEntity.avatarUrl] placeholderImage:nil];
    
    _labName.text = meEntity.nickName;
    
    [_labName sizeToFit];
    
    if (_otherId == YES) {
        
        _btnModify.hidden = YES;
        
        _btnAtten.hidden = NO;
        
        _btnAtten.frame = CGRectMake(_labName.right + 10, 16, ScaleWidth(50), ScaleWidth(25));

        if ([meEntity.isFollowed isEqualToString:@"1"]) {
            [_btnAtten setTitle:@"已关注" forState:UIControlStateNormal];
            
            _btnAtten.layer.borderColor = [UIColor colorWithHexString:@"#bdbdbd"].CGColor;
            
            _btnAtten.layer.borderWidth = 1;
            
            [_btnAtten setTitleColor:[UIColor colorWithHexString:@"#969696"] forState:UIControlStateNormal];

            
        }else {
            [_btnAtten setTitle:@"+关注" forState:UIControlStateNormal];
            
            _btnAtten.layer.borderColor = [UIColor colorWithHexString:@"#fd8671"].CGColor;
            
            _btnAtten.layer.borderWidth = 1;
            
            [_btnAtten setTitleColor:[UIColor colorWithHexString:@"#fd8671"] forState:UIControlStateNormal];


        }
        
    }else {
        UIImage *imageName = [UIImage imageNamed:@"My_Modify"];
        
        _btnModify.frame = CGRectMake(_labName.right + 5 , 21, imageName.size.width, imageName.size.height);
        
        
        _btnModify.hidden = NO;
        
        _btnAtten.hidden = YES;
    }
    
   

    [_btnPublish setTitle:[NSString stringWithFormat:@"发表  %@", meEntity.publishCount] forState:UIControlStateNormal];
    
    CGSize titleSize = [_btnPublish.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:_btnPublish.titleLabel.font.fontName size:_btnPublish.titleLabel.font.pointSize]}];
    
    titleSize.height = 20;
    
    titleSize.width += 20;

    _btnPublish.frame = CGRectMake(_imageAvtar.right + 5, 61, titleSize.width, titleSize.height);

    [_btnFans setTitle:[NSString stringWithFormat:@"粉丝  %@", meEntity.fansCount] forState:UIControlStateNormal];
    
    CGSize titleSizeTwo = [_btnFans.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:_btnFans.titleLabel.font.fontName size:_btnFans.titleLabel.font.pointSize]}];
    
    titleSizeTwo.height = 20;
    
    titleSizeTwo.width += 20;
    
    _btnFans.frame = CGRectMake(_btnPublish.right + 40, 61, titleSizeTwo.width, titleSizeTwo.height);
    
    [_btnfollow setTitle:[NSString stringWithFormat:@"关注  %@", meEntity.followCount] forState:UIControlStateNormal];
    
    
    CGSize titleSizeThree = [_btnfollow.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:_btnfollow.titleLabel.font.fontName size:_btnfollow.titleLabel.font.pointSize]}];
    
    titleSizeThree.height = 20;
    
    titleSizeThree.width += 20;
    
    _btnfollow.frame = CGRectMake(_btnFans.right + 40, 61, titleSizeThree.width, titleSizeThree.height);
    
    
    _labDes.text = meEntity.introduction;
    
    [_labDes sizeToFit];
    
    _labTag.frame = CGRectMake(_imageAvtar.left, _labDes.bottom + 16, FULL_WIDTH - 30, 0);
    
    for (int i = 0; i < meEntity.personalTags.count; i++) {
        
        _labTag.text = [NSString stringWithFormat:@"%@ %@",_labTag.text, meEntity.personalTags[i]];
        
    }
    
    [_labTag sizeToFit];
    
    _viewLine.frame = CGRectMake(0, _labTag.bottom + 16, FULL_WIDTH, 1);
    
    _heightHeader = _viewLine.bottom + NAVBAR_HEIGHT;
    
    _segementView.frame = CGRectMake(0, _heightHeader, FULL_WIDTH, 50);
    
    _collectionView.frame = CGRectMake(0, _segementView.bottom, FULL_WIDTH, FULL_HEIGHT - _segementView.bottom - MLTTabbarHeight);

    _collectionViewTwo.frame = CGRectMake(0, _segementView.bottom, FULL_WIDTH, FULL_HEIGHT - _segementView.bottom - MLTTabbarHeight);

}

- (void)navigationBackButtonClicked:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

/** 点击工具栏选择 */
- (void)touchLabelWithIndex:(NSInteger)index{
    
  
    if (index == 0) {
        
        [self.view bringSubviewToFront:_collectionView];
        
    }else {
        
        [self.view bringSubviewToFront:_collectionViewTwo];

      }
}

- (void)onclickModify:(UIButton *)btn{
    
    BTMeEntity *meEntity = [self.meService.arrByUser objectAtIndex:0];

    
    BTMeEditInforViewController *editInfor = [[BTMeEditInforViewController alloc] init];
    
    editInfor.nikeName = meEntity.nickName;
    
    editInfor.introduction = meEntity.introduction;
    
    editInfor.picAvtar = _imageAvtar.image;
    
    // block 值回掉
    editInfor.updateInforBlock = ^(NSString *nikeName, NSString *introduction, UIImage *picAvtar) {
        
        _imageAvtar.image = picAvtar;
        
        _labName.text = nikeName;
        
        [_labName sizeToFit];

        UIImage *imageName = [UIImage imageNamed:@"My_Modify"];

        _btnModify.frame = CGRectMake(_labName.right + 5 , 21, imageName.size.width, imageName.size.height);
        
        _labDes.frame = CGRectMake(_imageAvtar.left, _imageAvtar.bottom + 17, FULL_WIDTH - 30, 0);

        _labDes.text = introduction;
        
        [_labDes sizeToFit];
        
        _labTag.frame = CGRectMake(_imageAvtar.left, _labDes.bottom + 16, FULL_WIDTH - 30, 0);
        
        for (int i = 0; i < meEntity.personalTags.count; i++) {
            _labTag.text = [NSString stringWithFormat:@"%@ %@",_labTag.text, meEntity.personalTags[i]];
        }
        
        [_labTag sizeToFit];

    };
    
    [self.navigationController pushViewController:editInfor animated:YES];
}

- (void)addFriend:(UIButton *)btn{
    
    BTAttentionMeViewController *Attention = [[BTAttentionMeViewController alloc] init];
    
    BTMeEntity *meEntity;
    
    if (self.meService.arrByUser.count > 0) {
        
        meEntity = [self.meService.arrByUser objectAtIndex:0];
        
    }
    
    Attention.userId = meEntity.userId;
    Attention.navTitle = @"关注我的";
    
    [self.navigationController pushViewController:Attention animated:YES];
}

- (void)onclickFollow:(UIButton *)btn{
    
    BTMeAttentionViewController *Attention = [[BTMeAttentionViewController alloc] init];
    BTMeEntity *meEntity;

    if (self.meService.arrByUser.count > 0) {
        
        meEntity = [self.meService.arrByUser objectAtIndex:0];
        
    }
    
    Attention.userId = meEntity.userId;

    Attention.navTitle = @"我关注的";
    
    
    [self.navigationController pushViewController:Attention animated:YES];
}

- (void)onclickFans:(UIButton *)btn{

    BTAttentionMeViewController *Attention = [[BTAttentionMeViewController alloc] init];
    
    BTMeEntity *meEntity;
    
    if (self.meService.arrByUser.count > 0) {
        
       meEntity = [self.meService.arrByUser objectAtIndex:0];
        
    }
    
    Attention.userId = meEntity.userId;
    
    Attention.navTitle = @"关注我的";
    
    [self.navigationController pushViewController:Attention animated:YES];
}


// 关注接口
- (void)requestFollowUser{
    
    BtHomePageService *pageService = [BtHomePageService new];
    
    BTMeEntity *meEntity;
    
    if (self.meService.arrByUser.count > 0) {
        
        meEntity = [self.meService.arrByUser objectAtIndex:0];
        
    }
    
    [pageService loadqueryFollowUser:[meEntity.userId integerValue] completion:^(BOOL isSuccess, BOOL isCache) {
        
        [_btnAtten setTitle:@"已关注" forState:UIControlStateNormal];
        
        [SVProgressHUD showWithStatus:@"添加关注成功"];
        
        [SVProgressHUD dismissWithDelay:0.3f];
        
    }];
}

// 取消关注接口
- (void)requestUnFollowUser{
    
    BtHomePageService *pageService = [BtHomePageService new];
    
    BTMeEntity *meEntity;
    
    if (self.meService.arrByUser.count > 0) {
        
        meEntity = [self.meService.arrByUser objectAtIndex:0];
    }
    
    
    [pageService loadqueryUnFollowUser:[meEntity.userId integerValue] completion:^(BOOL isSuccess, BOOL isCache) {
        
        [_btnAtten setTitle:@"+关注" forState:UIControlStateNormal];
        [SVProgressHUD showWithStatus:@"取消关注成功"];
        [SVProgressHUD dismissWithDelay:0.3f];

        
    }];
}

- (void)onclickBtnAtten:(UIButton *)btn{
    
    if ([btn.titleLabel.text isEqualToString:@"+关注"]) {
        [self requestFollowUser];
    }else {
        [self requestUnFollowUser];
    }
    
}


#pragma mark - lazy
- (BTMeService *)meService {
    if (!_meService) {
        _meService = [[BTMeService alloc] init];
    }
    return _meService;
}

@end
