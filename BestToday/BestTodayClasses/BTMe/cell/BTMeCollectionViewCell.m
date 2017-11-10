//
//  BTMeCollectionViewCell.m
//  BestToday
//
//  Created by leeco on 2017/11/10.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTMeCollectionViewCell.h"

@implementation BTMeCollectionViewCell

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        // 图片
        _imagePic = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (FULL_WIDTH - 3)/3, (FULL_WIDTH - 3)/3)];
        
        _imagePic.contentMode  = UIViewContentModeScaleAspectFit;
        
        _imagePic.backgroundColor = [UIColor redColor];
        
        _imagePic.userInteractionEnabled = YES;
        
        _imagePic.backgroundColor = [UIColor colorWithHexString:@"#ECECEC"];
        
        _imagePic.clipsToBounds = YES;
        
        [self.contentView addSubview:_imagePic];
        
        
    }
    return self;
}

- (void)makeLiveFiannceCellData{
    
//    [_imagePic sd_setImageWithURL:[NSURL URLWithString:financeEntity.image] placeholderImage:nil];
//    
//    _labName.text = financeEntity.title;
//    
//    _labName.numberOfLines = 2;
    
}

@end
