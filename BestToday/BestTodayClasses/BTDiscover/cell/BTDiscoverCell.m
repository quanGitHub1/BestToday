//
//  BTDiscoverCell.m
//  BestToday
//
//  Created by 王卓 on 2017/11/23.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTDiscoverCell.h"

@interface BTDiscoverCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation BTDiscoverCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setImageUrl:(NSString *)imageUrl{
    //注意cell里面的控件 使用的位置 是相对于cell 的位置的 所以使用bounds
    _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    _imageView.backgroundColor =[UIColor clearColor];
//    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    [self addSubview:_imageView];
}




@end
