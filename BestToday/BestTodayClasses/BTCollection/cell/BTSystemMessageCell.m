//
//  BTSystemMessageCell.m
//  BestToday
//
//  Created by 王卓 on 2017/11/17.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTSystemMessageCell.h"

@interface BTSystemMessageCell()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * detailLabel;

@end

@implementation BTSystemMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 20;
        
        [self addSubview:_avatarImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 20)];
        _titleLabel.text = @"系统消息";
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#212121"];
        [self addSubview:_titleLabel];
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, screenWidth-100, 20)];
        _detailLabel.textColor = [UIColor colorWithHexString:@"969696"];
        _detailLabel.numberOfLines = 1;
        _detailLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_detailLabel];
        
    }
    
    return self;
}

- (void)setDataForCell:(BTMessageEntity *)entity{
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:entity.userEntity.avatarUrl]];
    _detailLabel.text = entity.content;
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
