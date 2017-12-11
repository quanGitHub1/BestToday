//
//  BTMeMessageCell.m
//  BestToday
//
//  Created by 王卓 on 2017/11/17.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTMeMessageCell.h"

@interface BTMeMessageCell()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * followLabel;
@property (nonatomic, strong) UIImageView *photoImageView;

@end

@implementation BTMeMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 20;
        [self addSubview:_avatarImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 15,screenWidth-160, 30)];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_titleLabel];
        
        _followLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth-70, 17.5, 50, 25)];
        _followLabel.text = @"+ 关注";
        _followLabel.font = [UIFont systemFontOfSize:12];
        _followLabel.textAlignment = NSTextAlignmentCenter;
        _followLabel.textColor = HEX(@"fd8671");
        _followLabel.layer.masksToBounds = YES;
        _followLabel.layer.borderColor = HEX(@"fd8671").CGColor;
        _followLabel.layer.borderWidth = 1.0f;
        _followLabel.layer.cornerRadius = 3;
        
        _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-60, 10, 40, 40)];
        _photoImageView.backgroundColor = kRedColor;
        
    }
    
    return self;
}

- (void)setDataForCell:(BTMessageEntity *)entity{
    //1:表示图片，2:表示显示“关注”按钮
    if ([entity.showType integerValue] == 1) {
        [_followLabel removeFromSuperview];
        [self addSubview:_photoImageView];

    }else if ([entity.showType integerValue] == 2){
        [_photoImageView removeFromSuperview];
        [self addSubview:_followLabel];
    }else{
        [_photoImageView removeFromSuperview];
        [_followLabel removeFromSuperview];
    }
     [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:entity.userEntity.avatarUrl]];
    _titleLabel.text = [NSString stringWithFormat:@"%@%@  %@",entity.userEntity.nickName,entity.content,entity.createTimeShort];
    [_photoImageView sd_setImageWithURL:[NSURL URLWithString:entity.resourcePicUrl]];
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
