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

#import <UIKit/UIKit.h>

#import "EaseMessageModel.h"
#import "EaseBubbleView.h"

typedef enum {
    EMMessageBodyTypeText   = 1,    /*! \~chinese 文本类型 \~english Text */
    EMMessageBodyTypeImage,         /*! \~chinese 图片类型 \~english Image */
    EMMessageBodyTypeVideo,         /*! \~chinese 视频类型 \~english Video */
    EMMessageBodyTypeLocation,      /*! \~chinese 位置类型 \~english Location */
    EMMessageBodyTypeVoice,         /*! \~chinese 语音类型 \~english Voice */
    EMMessageBodyTypeFile,          /*! \~chinese 文件类型 \~english File */
    EMMessageBodyTypeCmd,           /*! \~chinese 命令类型 \~english Command */
} EMMessageBodyType;

/** @brief 缩略图宽度(当缩略图宽度为0或者宽度大于高度时) */
#define kEMMessageImageSizeWidth 120
/** @brief 缩略图高度(当缩略图高度为0或者宽度小于高度时) */
#define kEMMessageImageSizeHeight 120
/** @brief 位置消息cell的高度 */
#define kEMMessageLocationHeight 95
/** @brief 语音消息cell的高度 */
#define kEMMessageVoiceHeight 23

extern CGFloat const EaseMessageCellPadding;

typedef enum{
    EaseMessageCellEvenVideoBubbleTap,      /** @brief 视频消息cell点击 */
    EaseMessageCellEventLocationBubbleTap,  /** @brief 位置消息cell点击 */
    EaseMessageCellEventImageBubbleTap,     /** @brief 图片消息cell点击 */
    EaseMessageCellEventAudioBubbleTap,     /** @brief 语音消息cell点击 */
    EaseMessageCellEventFileBubbleTap,      /** @brief 文件消息cell点击 */
    EaseMessageCellEventCustomBubbleTap,    /** @brief 自定义gif图片消息cell点击 */
}EaseMessageCellTapEventType;

@protocol EaseMessageCellDelegate;
@interface EaseMessageCell : UITableViewCell
{
    EaseBubbleView *_bubbleView;
    NSLayoutConstraint *_statusWidthConstraint;
}

@property (weak, nonatomic) id<EaseMessageCellDelegate> delegate;

@property (nonatomic, strong) UIActivityIndicatorView *activity;

@property (strong, nonatomic) UIImageView *avatarView;

@property (strong, nonatomic) UILabel *nameLabel;

@property (strong, nonatomic) UIButton *statusButton;

@property (strong, nonatomic) UILabel *hasRead;

/** @brief 气泡视图 */
@property (strong, nonatomic) EaseBubbleView *bubbleView;

@property (strong, nonatomic) EaseMessageModel *model;

/*
 *  聊天气泡的最大宽度
 */
@property (nonatomic) CGFloat bubbleMaxWidth UI_APPEARANCE_SELECTOR; //default 200;

@property (nonatomic) UIEdgeInsets bubbleMargin UI_APPEARANCE_SELECTOR; //default UIEdgeInsetsMake(8, 0, 8, 0);

@property (nonatomic) UIEdgeInsets leftBubbleMargin UI_APPEARANCE_SELECTOR; //default UIEdgeInsetsMake(8, 15, 8, 10);

@property (nonatomic) UIEdgeInsets rightBubbleMargin UI_APPEARANCE_SELECTOR; //default UIEdgeInsetsMake(8, 10, 8, 15);

/*
 *  发送者气泡图片
 */
@property (strong, nonatomic) UIImage *sendBubbleBackgroundImage UI_APPEARANCE_SELECTOR;

/*
 *  接收者气泡图片
 */
@property (strong, nonatomic) UIImage *recvBubbleBackgroundImage UI_APPEARANCE_SELECTOR;

/*
 *  消息显示字体
 */
@property (nonatomic) UIFont *messageTextFont UI_APPEARANCE_SELECTOR; //default [UIFont systemFontOfSize:15];

/*
 *  消息显示颜色
 */
@property (nonatomic) UIColor *messageTextColor UI_APPEARANCE_SELECTOR; //default [UIColor blackColor];

/*
 *  @param  cell
 *  @param  
 *  @param  消息model
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                        model:(EaseMessageModel *)model;

/*
 *  
 *
 *  @param  消息model
 *
 *  @result
 */
+ (NSString *)cellIdentifierWithModel:(EaseMessageModel *)model;

/*
 *
 *
 *  @param  消息model
 *
 *  @result cell高度
 */
+ (CGFloat)cellHeightWithModel:(EaseMessageModel *)model;

@end

@protocol EaseMessageCellDelegate <NSObject>

@optional

/*
 *  消息点击回调
 *
 *  @param  消息model
 */
- (void)messageCellSelected:(EaseMessageModel *)model;

/*
 *  状态按钮点击回调
 *
 *  @param  消息model
 *  @param  当前cell
 */
- (void)statusButtonSelcted:(EaseMessageModel *)model withMessageCell:(EaseMessageCell*)messageCell;

/*
 *  头像点击回调
 *
 *  @param  消息model
 */
- (void)avatarViewSelcted:(EaseMessageModel *)model;

@end

