/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import <Foundation/Foundation.h>

/** @brief 消息模型 */

@interface EaseMessageModel : NSObject

/** @brief 消息cell的高度 */
@property (nonatomic) CGFloat cellHeight;
/** @brief 当前登录用户是否为消息的发送方 */
@property (nonatomic) BOOL isSender;
/** @brief 消息发送方的昵称 */
@property (strong, nonatomic) NSString *nickname;
/** @brief 消息发送方的头像url */
@property (strong, nonatomic) NSString *avatarURLPath;
/** @brief 消息发送方的头像 */
@property (strong, nonatomic) UIImage *avatarImage;
/** @brief 文本消息的文字 */
@property (strong, nonatomic) NSString *text;
/** @brief 文本消息的富文本属性 */
@property (strong, nonatomic) NSAttributedString *attrBody;


/*!
 @method
 @brief 初始化消息对象模型
 @return 消息对象模型
 */
- (instancetype)initWithMessage:(NSDictionary *)message;

@end
