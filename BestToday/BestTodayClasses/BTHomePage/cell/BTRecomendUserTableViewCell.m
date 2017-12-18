//
//  BTRecomendUserTableViewCell.m
//  BestToday
//
//  Created by leeco on 2017/11/6.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTRecomendUserTableViewCell.h"

@implementation BTRecomendUserTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        if (self) {
            
            self.backgroundColor = [UIColor whiteColor];
            
            _imagePic = [[UIImageView alloc] initWithFrame:CGRectMake(15, 13, ScaleWidth(60), ScaleHeight(60))];
            
//            _imagePic.contentMode = UIViewContentModeScaleAspectFit;
            
            _imagePic.backgroundColor = [UIColor whiteColor];
            
            _imagePic.layer.cornerRadius = ScaleWidth(30);
            
            _imagePic.clipsToBounds = YES;
            
            _labName = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#616161" alpha:1] align:NSTextAlignmentCenter font:[UIFont systemFontOfSize:13] bkColor:nil frame:CGRectMake(_imagePic.left - 10, _imagePic.bottom + 10, _imagePic.width + 20, 18)];
            
            [self.contentView addSubview:_imagePic];
            
            [self.contentView addSubview:_labName];
            
            self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];

            
            
        }
        return self;
        
    }
    return self;
}

- (void)makeEditCellData:(BTHomeUserEntity *)userEnty{

    _labName.text = userEnty.nickName;
    
    [_imagePic sd_setImageWithURL:[NSURL URLWithString:userEnty.avatarUrl] placeholderImage:nil];
}

@end
