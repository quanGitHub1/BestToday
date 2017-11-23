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

@interface BTMessageViewController ()<UITableViewDelegate,UITableViewDataSource,BTChatToolbarDelegate>

@property (nonatomic ,strong) BTTableview *tableView;
/*!
 @property
 @brief 底部输入控件
 */
@property (strong, nonatomic) BTChatToolBar *chatToolbar;


@end

@implementation BTMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.title = @"系统消息";
    self.dataArray = [NSMutableArray array];
    CGFloat chatbarHeight = [BTChatToolBar defaultHeight];

    _tableView = [[BTTableview alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height -NAVBAR_HEIGHT-chatbarHeight) style:UITableViewStylePlain];
    _tableView.accessibilityIdentifier = @"table_view";
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
    self.chatToolbar = [[BTChatToolBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - chatbarHeight, self.view.frame.size.width, chatbarHeight)];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.isViewDidAppear = YES;
    
    if (self.scrollToBottomWhenAppear) {
        [self _scrollViewToBottom:NO];
    }
    self.scrollToBottomWhenAppear = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.isViewDidAppear = NO;
}
#pragma mark - setter

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
    
    CGRect tableFrame = self.tableView.frame;
    tableFrame.size.height = self.view.frame.size.height - _chatToolbar.frame.size.height;
    self.tableView.frame = tableFrame;
   
}

#pragma mark - private helper

/*!
 @method
 @brief tableView滑动到底部

 */
- (void)_scrollViewToBottom:(BOOL)animated
{
    if (self.tableView.contentSize.height > self.tableView.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height);
        [self.tableView setContentOffset:offset animated:animated];
    }
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
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.tableView.frame;
        rect.origin.y = 64;
        rect.size.height = self.view.frame.size.height - toHeight;
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
//        [self sendTextMessage:text];
        NSLog(@"%@",text);
        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"isSender",@"我",@"nickname",@"",@"avatarurl",text,@"text", nil];
        EaseMessageModel * model = [[EaseMessageModel alloc] initWithMessage:dic];
        [self.dataArray addObject:model];
        [self.tableView reloadData];
        
    }
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
