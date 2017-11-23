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
        _avatarImageView.backgroundColor = kRedColor;
        [self addSubview:_avatarImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10,screenWidth-160, 20)];
        _titleLabel.backgroundColor = kGreenColor;
        [self addSubview:_titleLabel];
        
        _followLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth-60, 10, 40, 20)];
        _followLabel.text = @"+ 关注";
        _followLabel.layer.masksToBounds = YES;
        _followLabel.layer.borderColor = [UIColor redColor].CGColor;
        _followLabel.layer.borderWidth = .5f;
        [self addSubview:_followLabel];
        
        _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-60, 10, 40, 40)];
        _photoImageView.backgroundColor = kRedColor;
        
    }
    
    return self;
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
