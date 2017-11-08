//
//  BTHomeCommentTableViewCell.m
//  BestToday
//
//  Created by leeco on 2017/11/8.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTHomeCommentTableViewCell.h"

@implementation BTHomeCommentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        if (self) {
            
            self.backgroundColor = [UIColor whiteColor];
            
           _viewLine = [[UIView alloc] initWithFrame:CGRectMake(5, 0, FULL_WIDTH - 10, 0.6)];
            [self.contentView addSubview:_viewLine];
            
            _labComment = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#212121" alpha:1] align:NSTextAlignmentLeft font:[UIFont systemFontOfSize:14] bkColor:nil frame:CGRectMake(15, 15 , FULL_WIDTH - 30, 0)];
            
            _labComment.numberOfLines = 3;
            [self.contentView addSubview:_labComment];
            
            self.contentView.backgroundColor = [UIColor redColor];
            
        }
        return self;
        
    }
    return self;
}

- (void)makeDatacell:(NSInteger)indexpath{
    
    _labComment.text = @"就啊的叫卡就打开撒娇啊可是贷记卡来得及啊看得见啊开始搭建啊看得见啊可怜的大咖来打卡陆慷达拉斯打卡达拉斯；了";
    [_labComment sizeToFit];
    _labComment.numberOfLines = 3;
    
    _heightCell = _labComment.bottom + 5;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
