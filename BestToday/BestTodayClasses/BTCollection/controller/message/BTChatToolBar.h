//
//  BTChatToolBar.h
//  BestToday
//
//  Created by 王卓 on 2017/11/20.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseTextView.h"

@protocol BTChatToolbarDelegate;
@interface BTChatToolBar : UIView

@property (weak, nonatomic) id<BTChatToolbarDelegate> delegate;

@property (nonatomic, readonly) CGFloat inputViewMaxHeight;

@property (nonatomic, readonly) CGFloat inputViewMinHeight;

@property (nonatomic, readonly) CGFloat horizontalPadding;

@property (nonatomic, readonly) CGFloat verticalPadding;

@property (strong, nonatomic) NSArray *inputViewLeftItems;

@property (strong, nonatomic) NSArray *inputViewRightItems;

@property (strong, nonatomic) EaseTextView *inputTextView;


/*!
 @method
 @brief 获取chatToolBar默认的高度
 @result  返回chatToolBar默认的高度
 */
+ (CGFloat)defaultHeight;


@end

@protocol BTChatToolbarDelegate <NSObject>

@optional

/*
 *  文字输入框开始编辑
 *
 *  @param inputTextView 输入框对象
 */
- (void)inputTextViewDidBeginEditing:(EaseTextView *)inputTextView;

/*
 *  文字输入框将要开始编辑
 *
 *  @param inputTextView 输入框对象
 */
- (void)inputTextViewWillBeginEditing:(EaseTextView *)inputTextView;

/*
 *  发送文字消息，可能包含系统自带表情
 *
 *  @param text 文字消息
 */
- (void)didSendText:(NSString *)text;

/*
 *  发送文字消息，可能包含系统自带表情
 *
 *  @param text 文字消息
 *  @param ext 扩展消息
 */
- (void)didSendText:(NSString *)text withExt:(NSDictionary*)ext;

@required
/*
 *  高度变到toHeight
 */
- (void)chatToolbarDidChangeFrameToHeight:(CGFloat)toHeight;

@end
