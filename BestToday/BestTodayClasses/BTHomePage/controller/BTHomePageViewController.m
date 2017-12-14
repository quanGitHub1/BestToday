//
//  BTHomePageViewController.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTHomePageViewController.h"
#import "BTSpreadTableView.h"
#import "BTLoginsViewController.h"
#import "BTHomePageTableViewCell.h"
#import "BTHomeOpenHander.h"
#import "BTHomePageDetailViewController.h"
#import <UShareUI/UShareUI.h>
#import "BtHomePageService.h"
#import "BTHomePageEntity.h"
#import "BTHomeUserEntity.h"

@interface BTHomePageViewController ()<LEBaseTableViewDelegate,UITableViewDataSource, UITableViewDelegate, BTSpreadTableViewDelegate, BTHomepageViewDelegate>

@property (nonatomic, strong)BTTableview *tableView;

@property (nonatomic, strong) BTSpreadTableView *spreadTableView;

@property (nonatomic, strong) NSMutableDictionary *dicCell;

@property (nonatomic, strong) BtHomePageService *homePageService;

@property (nonatomic, strong) NSString *pageAssistParam;

@property (nonatomic, assign) NSInteger nextPage;

@end

@implementation BTHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.title = @"今日最佳";
    self.nextPage = 1;
    
//      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"BTHomePageNSNotificationIsLike" object:@{@"isLiked":@"0",@"resourceId" : _homePageEntity.resourceId}];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationIsLike:) name:@"BTHomePageNSNotificationIsLike" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationIsFollow:) name:@"BTHomePageNSNotificationIsFollow" object:nil];

    _dicCell = [[NSMutableDictionary alloc] init];
    
    if ([BTMeEntity shareSingleton].isLogin) {
        
        [[BTHomeOpenHander shareHomeOpenHander] initDataArry];
        
        [self setupTableView];
        
        [self loadData];
    }else {
    
        BTLoginsViewController *loginvc = [[BTLoginsViewController alloc] init];
    
        MGJNavigationController *navigationController = [[MGJNavigationController alloc] initWithRootViewController:loginvc];
    
        [self presentViewController:navigationController animated:YES completion:^{
    
    
        }];
    
       loginvc.loginCallBack = ^(NSString *fromViewController) {
    
           [[BTHomeOpenHander shareHomeOpenHander] initDataArry];
    
           [self setupTableView];
           
           [self loadData];
           
       };
    }
}

/** 修改点赞方法 */
- (void)notificationIsLike:(NSNotification *)notify{
    
    NSString *isLike = notify.userInfo[@"isLiked"];
    
    NSString *resourceId = notify.userInfo[@"resourceId"];
    
    for (int i = 0; i < _homePageService.arrFollowedResource.count; i++) {
        
        BTHomePageEntity *pageEntity = [_homePageService.arrFollowedResource objectAtIndex:i];
        
        if ([pageEntity.resourceId isEqualToString:resourceId]) {
            
            pageEntity.isLiked = isLike;
            
            if ([isLike isEqualToString:@"1"]) {
                
                pageEntity.likeCount = [NSString stringWithFormat:@"%ld",[pageEntity.likeCount integerValue] + 1];

            }else {
                pageEntity.likeCount = [NSString stringWithFormat:@"%ld",[pageEntity.likeCount integerValue] - 1];

            }
            
            [self.tableView reloadData];
            
        }
    }
    
}

/** 修改关注方法 */
- (void)notificationIsFollow:(NSNotification *)notify{
    
    NSString *isFollow = notify.userInfo[@"isFollow"];
    
    NSString *resourceId = notify.userInfo[@"resourceId"];
    
    NSString *indexPat = notify.userInfo[@"indexPath"];
    
    UIButton *btnAtten = (UIButton *)[self.view viewWithTag:[indexPat integerValue]];
    
    for (int i = 0; i < _homePageService.arrFollowedResource.count; i++) {
        
        BTHomePageEntity *pageEntity = [_homePageService.arrFollowedResource objectAtIndex:i];
        
//        BTHomeUserEntity *userEntity = [BTHomeUserEntity yy_modelWithJSON:pageEntity.userVo];

        if ([pageEntity.resourceId isEqualToString:resourceId]) {
            
            [pageEntity.userVo setValue:isFollow forKey:@"isFollowed"];

            if ([isFollow isEqualToString:@"1"]) {
                
                [btnAtten setTitle:@"..." forState:UIControlStateNormal];
                
                btnAtten.frame = CGRectMake(FULL_WIDTH - 35, 13, 30, 20);
                
                [btnAtten setTitleColor:[UIColor colorWithHexString:@"#616161"] forState:UIControlStateNormal];
                
                btnAtten.layer.borderColor = [UIColor whiteColor].CGColor;
                
                btnAtten.layer.borderWidth = 0;
                
            }else {

                btnAtten.frame = CGRectMake(FULL_WIDTH - 65, 15, 50, 25);
                
                [btnAtten setTitle:@"+关注" forState:UIControlStateNormal];
                
                btnAtten.layer.borderColor = [UIColor colorWithHexString:@"#fd8671"].CGColor;
                
                btnAtten.layer.borderWidth = 1;
                
                btnAtten.layer.cornerRadius = 1.5;
                
                [btnAtten setTitleColor:[UIColor colorWithHexString:@"#fd8671"] forState:UIControlStateNormal];

            }
            
//            [self.tableView reloadData];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[indexPat integerValue] - 10000 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:
             UITableViewRowAnimationNone];
            
        }
    }
    
}

- (void)shareUM:(NSString *)picUrl;
{
    _picUrl = picUrl;
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_None;
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        [self shareImageURLToPlatformType:UMSocialPlatformType_WechatSession];
        
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
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
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


- (void)setupTableView{
    
    self.tableView = [[BTTableview alloc]initWithFrame:CGRectMake(0, kNavigationBarHight, kSCREEN_WIDTH, kSCREEN_HEIGHT-kNavigationBarHight - kTabBarHeight)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 200;
    
    self.tableView.dataDelegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    [self createTableViewHeaderView];
    
//    [self.tableView autoRefreshLoad];
    
}

- (void)createTableViewHeaderView{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FULL_WIDTH, ScaleHeight(120))];
    headerView.backgroundColor = kCardBackColor;
    
    // 调用tableView
    if (!_spreadTableView) {
        
        /**
         宽和高调换顺序
         */
        _spreadTableView = [[BTSpreadTableView alloc] initWithFrame:CGRectMake(0, 0, ScaleHeight(120), FULL_WIDTH) style:UITableViewStylePlain withType:BTSpreadTableViewStyleImageText];// x,y 高，宽
        
        _spreadTableView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
        
       _spreadTableView.dataArr = self.homePageService.arrFollowedUsers;
        
        _spreadTableView.spreadDelegate = self;
        
    }
    
    [headerView addSubview:_spreadTableView];
    
    self.tableView.tableHeaderView = headerView;
    
}

- (void)requestDataSource{

    [[BTHomeOpenHander shareHomeOpenHander] removDataArry];
    
    [_tableView resetNoMoreData];
    
    _pageAssistParam = @"";
    
    _nextPage = 1;
    
    [_dicCell removeAllObjects];
    
    
    [self loadData];
}

- (void)requestMoreDataSource{
    
    if (self.homePageService.arrFollowedResource.count % 10  != 0) {
        [self.tableView noDataFooterEndRefreshing];
        
    }else{
        [self loadData];
    }
}

- (void)loadData{

    [self requestAnnouncementData];
    
    [self requestQueryFollowedResource];
    
}

/** 查询我的关注用户列表接口 */
- (void)requestAnnouncementData{
    
    [self.homePageService loadqueryMyFollowedUsers:1 userId:[[BTMeEntity shareSingleton].userId integerValue] completion:^(BOOL isSuccess, BOOL isCache) {
        
        [self.tableView stop];
        
        if (isSuccess) {
            
            _spreadTableView.dataArr = self.homePageService.arrFollowedUsers;
            
            [_spreadTableView reloadData];
            
            [self.tableView reloadData];

        }
    }];
}

/** 分页查询首页已关注图片资源列表接口 */
- (void)requestQueryFollowedResource{

    [self.homePageService loadqueryFollowedResource:_nextPage pageAssistParam:_pageAssistParam completion:^(BOOL isSuccess, BOOL isCache, NSString* pageAssistParam, NSString *nextPage) {
        
        [self.tableView stop];
        
        _pageAssistParam = pageAssistParam;
        
        _nextPage = [nextPage integerValue];
        
        if (isSuccess) {
            
          [self.tableView reloadData];
            
        }
    }];
}


- (void)reloadTableviewDatas{
    [self.tableView reloadData];
}


#pragma mark - BTHomepageViewDelegate

- (void)reloadTableView:(NSInteger)indexpath height:(CGFloat)height {
    
    BTHomePageTableViewCell *announcementCell = [_dicCell objectForKey:[NSString stringWithFormat:@"indexPath%ld", indexpath]];

    announcementCell.heightCell = height;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexpath inSection:0];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
}


#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _homePageService.arrFollowedResource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_dicCell.count > indexPath.row) {
        
        BTHomePageTableViewCell *announcementCell = [_dicCell objectForKey:[NSString stringWithFormat:@"indexPath%ld", indexPath.row]];
        
        if (announcementCell.heightCell > 0) {
            return announcementCell.heightCell;

        }
        
        return 800;
        
    }
    
    return 0;
}

    
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (_dicCell.count > indexPath.row) {
        
        BTHomePageTableViewCell *announcementCell = [_dicCell objectForKey:[NSString stringWithFormat:@"indexPath%ld", indexPath.row]];
        
        if (announcementCell.heightCell > 0) {
            return announcementCell.heightCell;
            
        }
        
        return 800;
        
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString * const cellID = @"mindCell";
    
    BTHomePageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        
    cell = [[BTHomePageTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    
    cell.delegate = self;

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    [cell.btnAtten addTarget:self action:@selector(onclickBtnAtten:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.btnAtten.tag = indexPath.row;
    
    [cell makeDatacellData:[self.homePageService.arrFollowedResource objectAtIndex:indexPath.row] index:indexPath.row];
    
    cell.updateCellAttention = ^(NSInteger indexpathRow) {
        
        
    };
    
    if (![[_dicCell allKeys] containsObject:[NSString stringWithFormat:@"indexPath%ld", indexPath.row]]) {
        
        [_dicCell setObject: cell forKey:[NSString stringWithFormat:@"indexPath%ld", indexPath.row]];
        
    }
    
    cell.updateCellBlock = ^(NSInteger indexpathRow) {
        
        [self.tableView reloadData];
    };
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (void)onclickBtnAtten:(UIButton *)btn{

    if ([btn.titleLabel.text isEqualToString:@"..."]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"今日最佳APP" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *canAction = [UIAlertAction actionWithTitle:@"取消关注" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self requestUnFollowUser:btn.tag];
            
        }];
        
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"置顶该用户" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self requestSetTopUser:btn.tag isTopped:1];
            
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:canAction];
        [alertController addAction:destructiveAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else {
    
        [self requestFollowUser:btn.tag];
    }
   
}

// 置顶用户/取消置顶接口
- (void)requestSetTopUser:(NSInteger)index isTopped:(NSInteger)isTopped{
    
    BTHomePageEntity *pageEntity = [_homePageService.arrFollowedResource objectAtIndex:index - 10000];
    
    BTHomeUserEntity *userEntity = [BTHomeUserEntity yy_modelWithJSON:pageEntity.userVo];
    
    [self.homePageService loadquerySetTopUser:isTopped followedUserId:[userEntity.userId integerValue] completion:^(BOOL isSuccess, BOOL isCache) {
        
        [self requestAnnouncementData];
        
        
    }];
}

// 取消关注接口
- (void)requestUnFollowUser:(NSInteger)index{
    
    UIButton *btnAtten = (UIButton *)[self.view viewWithTag:index];
    
    BTHomePageEntity *pageEntity = [_homePageService.arrFollowedResource objectAtIndex:index - 10000];
    
    BTHomeUserEntity *userEntity = [BTHomeUserEntity yy_modelWithJSON:pageEntity.userVo];
    
    [self.homePageService loadqueryUnFollowUser:[userEntity.userId integerValue] completion:^(BOOL isSuccess, BOOL isCache) {
        
        [SVProgressHUD showWithStatus:@"取消关注成功"];
        
//        pageEntity.userVo[@"isFollowed"] = @"0";
        
        [pageEntity.userVo setValue:@"0" forKey:@"isFollowed"];
        
//        userEntity.isFollowed = @"0";
        
        btnAtten.frame = CGRectMake(FULL_WIDTH - 65, 15, 50, 25);
        
        [btnAtten setTitle:@"+关注" forState:UIControlStateNormal];
        
        btnAtten.layer.borderColor = [UIColor colorWithHexString:@"#fd8671"].CGColor;
        
        btnAtten.layer.borderWidth = 1;
        
        btnAtten.layer.cornerRadius = 1.5;
        
        [btnAtten setTitleColor:[UIColor colorWithHexString:@"#fd8671"] forState:UIControlStateNormal];
        
        [SVProgressHUD dismissWithDelay:0.3f];
                
        [self requestAnnouncementData];
        
    }];
}


// 关注接口
- (void)requestFollowUser:(NSInteger)index{
    
    UIButton *btnAtten = (UIButton *)[self.view viewWithTag:index];
    
    BTHomePageEntity *pageEntity = [_homePageService.arrFollowedResource objectAtIndex:index - 10000];
    
    BTHomeUserEntity *userEntity = [BTHomeUserEntity yy_modelWithJSON:pageEntity.userVo];
    
    [self.homePageService loadqueryFollowUser:[userEntity.userId integerValue] completion:^(BOOL isSuccess, BOOL isCache) {
        
        
        [btnAtten setTitle:@"..." forState:UIControlStateNormal];
        
        btnAtten.frame = CGRectMake(FULL_WIDTH - 35, 13, 30, 20);
        
        
        [btnAtten setTitleColor:[UIColor colorWithHexString:@"#616161"] forState:UIControlStateNormal];
        
        btnAtten.layer.borderColor = [UIColor whiteColor].CGColor;
        
        btnAtten.layer.borderWidth = 0;
        
        [pageEntity.userVo setValue:@"1" forKey:@"isFollowed"];

        [SVProgressHUD showWithStatus:@"添加关注成功"];
        
        [SVProgressHUD dismissWithDelay:0.3f];
        
        [self requestAnnouncementData];
        
    }];
}


#pragma mark - lazy
- (BtHomePageService *)homePageService {
    if (!_homePageService) {
        _homePageService = [[BtHomePageService alloc] init];
    }
    return _homePageService;
}

-(void)dealloc{

    //移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
