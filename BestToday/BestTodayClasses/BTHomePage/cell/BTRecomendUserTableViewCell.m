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
            
            _imagePic = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, ScaleWidth(50), ScaleHeight(50))];
            
            _imagePic.contentMode = UIViewContentModeScaleAspectFit;
            
            _imagePic.backgroundColor = [UIColor redColor];
            
            _imagePic.layer.cornerRadius = ScaleWidth(25);
            
            _imagePic.clipsToBounds = YES;
            
            _labName = [UILabel mlt_labelWithText:@"" color:[UIColor mlt_colorWithHexString:@"#333333" alpha:1] align:NSTextAlignmentCenter font:[UIFont systemFontOfSize:13] bkColor:nil frame:CGRectMake(_imagePic.left, _imagePic.bottom + 10, _imagePic.width, 18)];

            _labName.text = @"罗密欧";
            
            [self.contentView addSubview:_imagePic];
            
            [self.contentView addSubview:_labName];
            
            self.backgroundColor = [UIColor yellowColor];
            
        }
        return self;
        
    }
    return self;
}

//- (void)makeEditCellData:(MLTDiscoverDetailEditStockEnty *)editStockEnty{
//    
//    [_imagePic mlt_setImageWithSourceString:editStockEnty.img placeHolder:nil];
//    
//    _labName.text = editStockEnty.name;
//    
//}

@end
