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

#import "EaseMessageCell.h"

#import "EaseBubbleView+Text.h"
#import "UIImageView+EMWebCache.h"
#import "EaseEmotionEscape.h"
#import "EaseLocalDefine.h"

CGFloat const EaseMessageCellPadding = 10;

NSString *const EaseMessageCellIdentifierRecvText = @"EaseMessageCellRecvText";
NSString *const EaseMessageCellIdentifierSendText = @"EaseMessageCellSendText";


@interface EaseMessageCell()
{
    EMMessageBodyType _messageType;
}

@property (nonatomic) NSLayoutConstraint *bubbleMaxWidthConstraint;

@end

@implementation EaseMessageCell

@synthesize statusButton = _statusButton;
@synthesize bubbleView = _bubbleView;
@synthesize hasRead = _hasRead;
@synthesize activity = _activity;

+ (void)initialize
{
    // UIAppearance Proxy Defaults
    EaseMessageCell *cell = [self appearance];
    cell.bubbleMaxWidth = 200;
    cell.leftBubbleMargin = UIEdgeInsetsMake(8, 15, 8, 10);
    cell.rightBubbleMargin = UIEdgeInsetsMake(8, 10, 8, 15);
    cell.bubbleMargin = UIEdgeInsetsMake(8, 0, 8, 0);
    
    cell.messageTextFont = [UIFont systemFontOfSize:15];
    cell.messageTextColor = [UIColor blackColor];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                        model:(EaseMessageModel *)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessibilityIdentifier = @"table_cell";

        [self _setupSubviewsWithType:1
                            isSender:model.isSender
                               model:model];
    }
    
    return self;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

#pragma mark - setup subviews

/*!
 @method
 @brief 加载子视图
 @param messageType  消息体类型
 @param isSender     登录用户是否为发送方
 @param model        消息对象model
 */
- (void)_setupSubviewsWithType:(EMMessageBodyType)messageType
                      isSender:(BOOL)isSender
                         model:(EaseMessageModel *)model
{
    
    _bubbleView = [[EaseBubbleView alloc] initWithMargin:isSender?_rightBubbleMargin:_leftBubbleMargin isSender:isSender];
    _bubbleView.translatesAutoresizingMaskIntoConstraints = NO;
    _bubbleView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_bubbleView];
    
    _avatarView = [[UIImageView alloc] init];
    _avatarView.translatesAutoresizingMaskIntoConstraints = NO;
    _avatarView.backgroundColor = [UIColor clearColor];
    _avatarView.clipsToBounds = YES;
    _avatarView.userInteractionEnabled = YES;
    _avatarView.backgroundColor = kRedColor;
    [self.contentView addSubview:_avatarView];
    
    
    [_bubbleView setupTextBubbleView];
    
    _bubbleView.textLabel.font = _messageTextFont;
    _bubbleView.textLabel.textColor = _messageTextColor;
    
    [self _setupConstraints];
    
}

#pragma mark - Setup Constraints

/*!
 @method
 @brief 设置控件约束
 @discussion  设置气泡宽度
 */
- (void)_setupConstraints
{
    //bubble view
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-EaseMessageCellPadding]];
    
    self.bubbleMaxWidthConstraint = [NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.bubbleMaxWidth];
    [self addConstraint:self.bubbleMaxWidthConstraint];

}

#pragma mark - Update Constraint

/*!
 @method
 @brief 修改气泡的宽度约束
 */
- (void)_updateBubbleMaxWidthConstraint
{
    [self removeConstraint:self.bubbleMaxWidthConstraint];
//    self.bubbleMaxWidthConstraint.active = NO;
    
    //气泡宽度小于等于bubbleMaxWidth
    self.bubbleMaxWidthConstraint = [NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.bubbleMaxWidth];
    [self addConstraint:self.bubbleMaxWidthConstraint];
}

#pragma mark - setter

- (void)setModel:(EaseMessageModel *)model
{
    _model = model;
    _bubbleView.textLabel.attributedText = [[EaseEmotionEscape sharedInstance] attStringFromTextForChatting:model.text textFont:self.messageTextFont];
}

- (void)setSendBubbleBackgroundImage:(UIImage *)sendBubbleBackgroundImage
{
    _sendBubbleBackgroundImage = sendBubbleBackgroundImage;
}

- (void)setRecvBubbleBackgroundImage:(UIImage *)recvBubbleBackgroundImage
{
    _recvBubbleBackgroundImage = recvBubbleBackgroundImage;
}

- (void)setBubbleMaxWidth:(CGFloat)bubbleMaxWidth
{
    _bubbleMaxWidth = bubbleMaxWidth;
    [self _updateBubbleMaxWidthConstraint];
}

- (void)setRightBubbleMargin:(UIEdgeInsets)rightBubbleMargin
{
    _rightBubbleMargin = rightBubbleMargin;
}

- (void)setLeftBubbleMargin:(UIEdgeInsets)leftBubbleMargin
{
    _leftBubbleMargin = leftBubbleMargin;
}

- (void)setBubbleMargin:(UIEdgeInsets)bubbleMargin
{
    _bubbleMargin = bubbleMargin;
    _bubbleMargin = self.model.isSender ? _rightBubbleMargin:_leftBubbleMargin;
    if (_bubbleView) {
        [_bubbleView updateTextMargin:_bubbleMargin];
    }
}

- (void)setMessageTextFont:(UIFont *)messageTextFont
{
    _messageTextFont = messageTextFont;
    if (_bubbleView.textLabel) {
        _bubbleView.textLabel.font = messageTextFont;
    }
}

- (void)setMessageTextColor:(UIColor *)messageTextColor
{
    _messageTextColor = messageTextColor;
    if (_bubbleView.textLabel) {
        _bubbleView.textLabel.textColor = _messageTextColor;
    }
}



#pragma mark - public

/*!
 @method
 @brief 获取cell的重用标识
 @param model        消息对象model
 @result 返回cell的重用标识
 */
+ (NSString *)cellIdentifierWithModel:(EaseMessageModel *)model
{
    NSString *cellIdentifier = nil;
    if (model.isSender) {
        cellIdentifier = EaseMessageCellIdentifierSendText;
    }
    else{
        cellIdentifier = EaseMessageCellIdentifierRecvText;
    }
    
    return cellIdentifier;
}

/*!
 @method
 @brief 根据消息的内容，获取当前cell的高度
 @param model        消息对象model
 @result 返回cell高度
 */
+ (CGFloat)cellHeightWithModel:(EaseMessageModel *)model
{
    if (model.cellHeight > 0) {
        return model.cellHeight;
    }
    
    EaseMessageCell *cell = [self appearance];
    CGFloat bubbleMaxWidth = cell.bubbleMaxWidth;
    if ([UIDevice currentDevice].systemVersion.floatValue == 7.0) {
        bubbleMaxWidth = 200;
    }
    bubbleMaxWidth -= (cell.leftBubbleMargin.left + cell.leftBubbleMargin.right + cell.rightBubbleMargin.left + cell.rightBubbleMargin.right)/2;
    
    CGFloat height = EaseMessageCellPadding + cell.bubbleMargin.top + cell.bubbleMargin.bottom;
    NSAttributedString *text = [[EaseEmotionEscape sharedInstance] attStringFromTextForChatting:model.text textFont:cell.messageTextFont];
    CGRect rect = [text boundingRectWithSize:CGSizeMake(bubbleMaxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    height += (rect.size.height > 20 ? rect.size.height : 20) + 10;
    height += EaseMessageCellPadding;
    model.cellHeight = height;
    
    return height;
}

@end
