//
//  BTAttentionTableViewCell.m
//  BestToday
//
//  Created by leeco on 2017/11/15.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTAttentionTableViewCell.h"

#define cellHeight 65

@implementation BTAttentionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imageAvtar = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, ScaleWidth(40), ScaleHeight(40))];
        
        _imageAvtar.contentMode = UIViewContentModeScaleAspectFit;
        
        _imageAvtar.backgroundColor = [UIColor whiteColor];
        
        _imageAvtar.layer.cornerRadius = ScaleWidth(20);
        
        _imageAvtar.clipsToBounds = YES;
        
        _labName = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#212121" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:16] bkColor:nil frame:CGRectMake(_imageAvtar.right + 15, (cellHeight - 20)/2 + 2, 200, 20)];
        
        _btnAttention = [[UIButton alloc] initWithFrame:CGRectMake(FULL_WIDTH - 75, (cellHeight - 26)/2 + 2, 60, 26)];
        
        _btnAttention.layer.borderColor = [UIColor colorWithHexString:@"#969696"].CGColor;
        
        _btnAttention.layer.borderWidth = 1;
        
        _btnAttention.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [_btnAttention setTitleColor:[UIColor colorWithHexString:@"#969696"] forState:UIControlStateNormal];
        
        _btnAttention.layer.cornerRadius = 1.5;
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 64.4, FULL_WIDTH, 0.6)];
        
        viewLine.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        
        [self.contentView addSubview:_imageAvtar];
        
        [self.contentView addSubview:_labName];
        
        [self.contentView addSubview:_btnAttention];
        
        [self.contentView addSubview:viewLine];
        
    }
    return self;
}

- (void)makeCellData:(BTUserEntity *)meEntity{

    _labName.text = meEntity.nickName;
    
    [_imageAvtar sd_setImageWithURL:[NSURL URLWithString:meEntity.avatarUrl] placeholderImage:nil];
    
    if ([meEntity.isFollowed integerValue] == 0) {
        
        [_btnAttention setTitle:@"+关注" forState:UIControlStateNormal];

    }else {
    
        [_btnAttention setTitle:@"已关注" forState:UIControlStateNormal];

    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
