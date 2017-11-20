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
        _avatarImageView.backgroundColor = kRedColor;
        [self addSubview:_avatarImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 20)];
        _titleLabel.backgroundColor = kGreenColor;
        [self addSubview:_titleLabel];
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, screenWidth-100, 20)];
        _detailLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:_detailLabel];
        
    }
    
    return self;
}

- (void)setDataForCell{
    
    
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
