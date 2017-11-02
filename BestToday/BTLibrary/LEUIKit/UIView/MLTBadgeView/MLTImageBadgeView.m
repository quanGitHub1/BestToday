//
//  MLTImageBadgeView.m
//  AMCustomer
//
//  Created by fuyao on 16/9/6.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "MLTImageBadgeView.h"

@interface MLTImageBadgeView()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MLTImageBadgeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        self.imageView.userInteractionEnabled = YES;
        [self addSubview:self.imageView];
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        self.hidden = YES;
        
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.imageView.frame = self.bounds;
}

- (void)setBadgeNum:(NSInteger)badgeNum
{
    _badgeNum = badgeNum;
    if (_badgeNum <= 0) {
        self.hidden = YES;
    }
    else
    {
        self.hidden = NO;
    }
}

-(void)setImagePath:(NSString *)path{
    self.imageView.image = [UIImage imageNamed:path];
}

@end
