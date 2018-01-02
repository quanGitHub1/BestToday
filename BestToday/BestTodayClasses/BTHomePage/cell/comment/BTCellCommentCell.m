//
//  BTCellCommentCell.m
//  BestToday
//
//  Created by 王卓 on 2017/12/26.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTCellCommentCell.h"
#import "MLLabel.h"
#import "MLLinkLabel.h"

@implementation BTCellCommentCell
{
    MLLinkLabel *_commentLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        _commentLabel = [MLLinkLabel new];

        _commentLabel.linkTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
        _commentLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName:HEX(@"616161"),NSBackgroundColorAttributeName:kDefaultActiveLinkBackgroundColorForMLLinkLabel};
        _commentLabel.font = [UIFont systemFontOfSize:15];
        _commentLabel.numberOfLines = 0;
        _commentLabel.textColor = HEX(@"616161");
        _commentLabel.lineHeightMultiple = 1.1f;
        [self.contentView addSubview:_commentLabel];
        [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(self.contentView);
        }];
        
    }
    return self;
}

- (void)setComment:(BTHomeComment *)comment{
    _comment = comment;
    _commentLabel.attributedText = [self generateAttributedStringWithCommentItemModel:comment];
    [_commentLabel sizeToFit];
}

#pragma mark - private actions
- (NSMutableAttributedString *)generateAttributedStringWithCommentItemModel:(BTHomeComment *)model
{
    NSString *text = model.commentNickName;
    text = [text stringByAppendingString:[NSString stringWithFormat:@"：%@", model.content]];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    UIColor *highLightColor = HEX(@"616161");
    [attString setAttributes:@{NSForegroundColorAttributeName : highLightColor, NSLinkAttributeName : model.commentNickName} range:[text rangeOfString:model.commentNickName]];
    return attString;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
