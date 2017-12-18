//
//  BTHomedetailCollectionViewCell.m
//  BestToday
//
//  Created by leeco on 2017/11/22.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTHomedetailCollectionViewCell.h"

@implementation BTHomedetailCollectionViewCell


-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        // 图片
        _imagePic = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (FULL_WIDTH - 10)/3,(FULL_WIDTH - 10)/3)];
        
//        _imagePic.contentMode  = UIViewContentModeScaleAspectFit;
        
        _imagePic.contentMode  = UIViewContentModeScaleAspectFill;
        
        _imagePic.userInteractionEnabled = YES;
        
        _imagePic.backgroundColor = [UIColor colorWithHexString:@"#ECECEC"];
        
        _imagePic.clipsToBounds = YES;
        
        [self.contentView addSubview:_imagePic];
                
        
    }
    return self;
}

- (void)makeDetailRecomendCellData:(BTHomeDetailLookEntity *)lookEntity{
    
    _imagePic.backgroundColor = [UIColor colorWithHexString:lookEntity.backgroundColor];

    [_imagePic sd_setImageWithURL:[NSURL URLWithString:lookEntity.smallPicUrl] placeholderImage:nil];
    
}

@end
