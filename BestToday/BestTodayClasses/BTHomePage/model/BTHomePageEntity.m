//
//  BTHomePageEntity.m
//  BestToday
//
//  Created by leeco on 2017/11/2.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTHomePageEntity.h"
#import "NSString+Extension.h"
#import "BTHomeComment.h"
#import "MLLinkLabel.h"

CGFloat maxContentLabelHeight = 75;

@implementation BTHomePageEntity
{
    CGFloat _lastContentWidth;
}

- (NSString *)msgContent
{
    CGFloat margin = 10;
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    CGFloat iconViewWH = 45;
    CGFloat contentW = cellW - (margin + iconViewWH + margin) - margin;
    if (contentW != _lastContentWidth) {
        _lastContentWidth = contentW;
        CGSize textSize = [self.textInfo sizeWithFont:[UIFont systemFontOfSize:15] maxW:contentW];
        if (textSize.height > maxContentLabelHeight) {
            _shouldShowMoreButton = YES;
        } else {
            _shouldShowMoreButton = NO;
        }
    }
    
    return self.textInfo;
}

- (void)setIsOpening:(BOOL)isOpening
{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    } else {
        _isOpening = isOpening;
        _cellHeight = 0;
    }
}
- (CGFloat)cellHeight
{
       // 头视图高度 + 图片高度
    CGFloat headerHeight = ScaleHeight(32) +18;
    CGFloat heightSize = [self.picHeight floatValue] / [self.picWidth floatValue];
    CGFloat pic = FULL_WIDTH * heightSize;
    CGFloat msgHeight = 0;
        if (self.msgContent.length) {  // 有文字
            CGFloat margin = 10;
            CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
            CGFloat iconViewWH = 45;
            CGFloat contentW = cellW - (margin + iconViewWH + margin) - margin;
            CGSize msgContentSize = [self.msgContent sizeWithFont:[UIFont systemFontOfSize:15] maxW:contentW];
            if (self.shouldShowMoreButton) { // 如果文字高度超过60
                if (self.isOpening) {
                    msgHeight = msgContentSize.height + 15 + 5;
                } else {
                    msgHeight = 60 + 15 + 5;
                }
            }else {  // 没有超过60
                msgHeight = msgContentSize.height + 5;
            }
        }
    CGFloat commentHeght = 0;
    
    if (self.partCommentList.count > 0) {
        NSMutableArray *arrCommentList = [NSMutableArray array];
        for (NSDictionary *dicList in self.partCommentList) {
            
            BTHomeComment *homeComment = [BTHomeComment yy_modelWithJSON:dicList];
            
            [arrCommentList addObject:homeComment];
        }
        CGSize commentSize = [self getCommentViewSizeWithComment:arrCommentList];
        commentHeght = commentSize.height;
    }else{
        commentHeght = -30;
    }
    
    _cellHeight = headerHeight + pic + msgHeight + commentHeght + 80;
    return _cellHeight;
    
}


- (CGSize)getCommentViewSizeWithComment:(NSArray *)commentArray
{
    CGFloat tableViewHeight = 0;
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 70;
    if (commentArray.count) {
        for (int i = 0; i < commentArray.count; i++) {
            BTHomeComment * model = commentArray[i];
            NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:[self generateAttributedStringWithCommentItemModel:model]];
            MLLinkLabel *label = [MLLinkLabel new];
            label.numberOfLines = 3;
            label.attributedText = text;
            label.lineHeightMultiple = 1.1f;
            label.font = [UIFont systemFontOfSize:14];
            UIColor *highLightColor = [UIColor blackColor];
            label.linkTextAttributes = @{NSForegroundColorAttributeName : highLightColor};
            label.activeLinkTextAttributes = @{NSForegroundColorAttributeName:[UIColor blueColor],NSBackgroundColorAttributeName:kDefaultActiveLinkBackgroundColorForMLLinkLabel};
            CGFloat h = [label preferredSizeWithMaxWidth:contentW].height;
            label = nil;
            tableViewHeight += h;
        }
    }
    return CGSizeMake(contentW, tableViewHeight);
}

#pragma mark - private actions
- (NSMutableAttributedString *)generateAttributedStringWithCommentItemModel:(BTHomeComment *)model
{
    NSString *text = model.commentNickName;
    text = [text stringByAppendingString:[NSString stringWithFormat:@"：%@", model.content]];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    UIColor *highLightColor = [UIColor blackColor];
    [attString setAttributes:@{NSForegroundColorAttributeName : highLightColor, NSLinkAttributeName : model.commentNickName} range:[text rangeOfString:model.commentNickName]];
    return attString;
}

@end
