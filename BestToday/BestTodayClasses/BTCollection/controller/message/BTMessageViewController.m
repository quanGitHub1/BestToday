//
//  BTMessageViewController.m
//  BestToday
//
//  Created by 王卓 on 2017/11/20.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTMessageViewController.h"
#import "BTTableview.h"
#import "BTChatToolBar.h"
#import "EaseBaseMessageCell.h"
#import "EaseMessageModel.h"
#import "BTLikeCommentService.h"
#import "BTHomeCommentEntity.h"
#import "BTMessageService.h"

@interface BTMessageViewController ()<UITableViewDelegate,UITableViewDataSource,BTChatToolbarDelegate,LEBaseTableViewDelegate>
{
    int page;

}

@property (nonatomic ,strong) BTTableview *tableView;
/*!
 @property
 @brief 底部输入控件
 */
@property (strong, nonatomic) BTChatToolBar *chatToolbar;

@property (nonatomic, strong) BTLikeCommentService *commentService;

@property (nonatomic, strong) BTMessageService *messageService;


@end

@implementation BTMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
     [self.navigationBar setLeftBarButton:[UIButton mlt_rightBarButtonWithImage:[UIImage imageNamed:@"info_backs"] highlightedImage:nil target:self action:@selector(navigationBackButtonClicked:) forControlEvents:UIControlEventTouchUpInside]];
    self.dataArray = [NSMutableArray array];

    _tableView = [[BTTableview alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, kSCREEN_WIDTH, kSCREEN_HEIGHT -64-46) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.dataDelegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [_tableView autoRefreshLoad];
    [_tableView hiddenFreshHead];
    [_tableView hiddenFreshFooter];
    [self.view addSubview:_tableView];
    
    if (_isComment) {
        self.navigationBar.title = @"评论";
        [self requestDataSource];
    }else{
        [_tableView hiddenFreshHead];
        [_tableView hiddenFreshFooter];
        self.navigationBar.title = @"系统消息";
        [self setDataForMessage:self.messageEntity];
    }
    
    self.chatToolbar = [[BTChatToolBar alloc] initWithFrame:CGRectMake(0, kSCREEN_HEIGHT - 46, self.view.frame.size.width, 46)];
    self.chatToolbar.delegate = self;
    self.chatToolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHidden:)];
    [self.view addGestureRecognizer:tap];
    
    [[EaseBaseMessageCell appearance] setSendBubbleBackgroundImage:[[UIImage imageNamed:@"EaseUIResource.bundle/chat_sender_bg"] stretchableImageWithLeftCapWidth:5 topCapHeight:35]];
    [[EaseBaseMessageCell appearance] setRecvBubbleBackgroundImage:[[UIImage imageNamed:@"EaseUIResource.bundle/chat_receiver_bg"] stretchableImageWithLeftCapWidth:35 topCapHeight:35]];
    [[EaseBaseMessageCell appearance] setAvatarSize:40.f];
    [[EaseBaseMessageCell appearance] setAvatarCornerRadius:20.f];
    // Do any additional setup after loading the view.
}
- (void)setDataForMessage:(BTMessageEntity *)entity{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:entity.isOwn,@"isSender",entity.userEntity.nickName,@"nickname",entity.userEntity.avatarUrl,@"avatarurl",entity.content,@"text", nil];
    NSLog(@"%@",dic);
    EaseMessageModel * model = [[EaseMessageModel alloc] initWithMessage:dic];
    [self.dataArray addObject:model];
    [self.tableView reloadData];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.isViewDidAppear = YES;
//    [self _scrollViewToBottom:NO];

//    if (self.scrollToBottomWhenAppear) {
//    }
//    self.scrollToBottomWhenAppear = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.isViewDidAppear = NO;
}

- (void)navigationBackButtonClicked:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - setter

- (void)requestDataSource{
    __weak __typeof(self)weakSelf = self;
    page = 1;
    [self.dataArray removeAllObjects];
    [self.commentService loadqueryCommentListResource:_resourceId pageindex:page completion:^(BOOL isSuccess, BOOL isCache) {
//        [self.tableView.mj_header endRefreshing];
        if (isSuccess) {
//            page ++;
            for (BTHomeCommentEntity *entity in weakSelf.commentService.arrCommentList) {
                NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:entity.isOwn,@"isSender",entity.commentNickName,@"nickname",entity.commentAvatarUrl,@"avatarurl",entity.content,@"text", nil];
                EaseMessageModel * model = [[EaseMessageModel alloc] initWithMessage:dic];
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.tableView reloadData];
//            [weakSelf _scrollViewToBottom:NO];
        }else{
            
        }
    }];
}

- (void)requestMoreDataSource{
    __weak __typeof(self)weakSelf = self;
    NSLog(@"刷新 页数 %d",page);
    [self.commentService loadqueryCommentListResource:_resourceId pageindex:page completion:^(BOOL isSuccess, BOOL isCache) {
        [self.tableView.mj_footer endRefreshing];

        if (isSuccess) {
            page++;
            for (BTHomeCommentEntity *entity in weakSelf.commentService.arrCommentList) {
                NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:entity.isOwn,@"isSender",entity.commentNickName,@"nickname",entity.commentAvatarUrl,@"avatarurl",entity.content,@"text", nil];
                EaseMessageModel * model = [[EaseMessageModel alloc] initWithMessage:dic];
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.tableView reloadData];
//            [weakSelf _scrollViewToBottom:NO];
        }else{
            
        }
    }];
}



- (void)setIsViewDidAppear:(BOOL)isViewDidAppear
{
    _isViewDidAppear =isViewDidAppear;
   
}

- (void)setChatToolbar:(BTChatToolBar *)chatToolbar
{
    [_chatToolbar removeFromSuperview];
    
    _chatToolbar = chatToolbar;
    if (_chatToolbar) {
        [self.view addSubview:_chatToolbar];
    }
    
//    CGRect tableFrame = self.tableView.frame;
//    tableFrame.size.height = kSCREEN_HEIGHT - _chatToolbar.frame.size.height -64;
//    self.tableView.frame = tableFrame;
   
}

#pragma mark - private helper

/*!
 @method
 @brief tableView滑动到底部

 */
- (void)_scrollViewToBottom:(BOOL)animated
{
    if (self.dataArray.count > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0]  atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }

//    if (self.tableView.contentSize.height > self.tableView.frame.size.height)
//    {
//        CGPoint offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height);
//        [self.tableView setContentOffset:offset animated:animated];
//    }
}

#pragma mark - GestureRecognizer

-(void)keyBoardHidden:(UITapGestureRecognizer *)tapRecognizer
{
    if (tapRecognizer.state == UIGestureRecognizerStateEnded) {
        [self.chatToolbar endEditing:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EaseMessageModel * object = [self.dataArray objectAtIndex:indexPath.row];
   
    NSString *CellIdentifier = [EaseMessageCell cellIdentifierWithModel:object];
    EaseBaseMessageCell *sendCell = (EaseBaseMessageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (sendCell == nil) {
        sendCell = [[EaseBaseMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:object];
        sendCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    sendCell.model = object;
    return sendCell;
   
    return nil;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EaseMessageModel * model = [self.dataArray objectAtIndex:indexPath.row];
    return [EaseBaseMessageCell cellHeightWithModel:model];
}


#pragma mark - EMChatToolbarDelegate

- (void)chatToolbarDidChangeFrameToHeight:(CGFloat)toHeight
{
    NSLog(@"%f\n  ",kSCREEN_HEIGHT);
    NSLog(@"\n %f",self.view.frame.size.height);
    NSLog(@"\n %f",self.tableView.contentSize.height);
    NSLog(@"\n %f",self.tableView.frame.size.height);

    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.tableView.frame;
        rect.origin.y = 64;
        rect.size.height = self.view.frame.size.height -64 - toHeight;
        self.tableView.frame = rect;
    }];
    
    [self _scrollViewToBottom:NO];
}

- (void)inputTextViewWillBeginEditing:(EaseTextView *)inputTextView
{
    
}

- (void)didSendText:(NSString *)text
{
    if (text && text.length > 0) {
        if (_isComment) {
            [self uploadCommentWithContent:text];
        }else{
            [self uploadMessageWithContent:text];
        }
    }
}

- (void)uploadCommentWithContent:(NSString *)content{
    __weak __typeof(self)weakSelf = self;
    [self.commentService upLoadCommentResource:_resourceId content:content completion:^(BOOL isSuccess, BOOL isCache) {
        if (isSuccess) {
            [weakSelf uploadUIForCell:content];
        }else{
            
        }
    }];
}

- (void)uploadMessageWithContent:(NSString *)content{
    __weak __typeof(self)weakSelf = self;
    [self.messageService feedBackInfoWithContent:content Completion:^(BOOL isSuccess, NSString *message) {
        if (isSuccess) {
            [weakSelf uploadUIForCell:content];
        }else{
            NSLog(@"%@",message);
        }
    }];
}

- (void)uploadUIForCell:(NSString *)content{
    NSString *avatarString = [[NSUserDefaults standardUserDefaults] objectForKey:@"bt_userAvatarUrl"];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"isSender",[BTMeEntity shareSingleton].nickName,@"nickname",avatarString,@"avatarurl",content,@"text", nil];
    EaseMessageModel * model = [[EaseMessageModel alloc] initWithMessage:dic];
    
    [self.dataArray addObject:model];
    [self.tableView reloadData];
    [self _scrollViewToBottom:NO];

}

- (BTLikeCommentService *)commentService {
    if (!_commentService) {
        _commentService = [[BTLikeCommentService alloc] init];
    }
    return _commentService;
}

- (BTMessageService *)messageService {
    if (!_messageService) {
        _messageService = [[BTMessageService alloc] init];
    }
    return _messageService;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
