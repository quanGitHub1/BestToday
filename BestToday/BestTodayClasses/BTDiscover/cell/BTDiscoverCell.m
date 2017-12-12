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
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _imageView.backgroundColor =[UIColor clearColor];
        [self addSubview:_imageView];
    }
    return self;
}

- (void)setImageUrl:(NSString *)imageUrl{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}




@end
