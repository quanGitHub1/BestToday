//
//  MLTNormalBadgeView.m
//  AMCustomer
//
//  Created by fuyao on 16/9/6.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "MLTNormalBadgeView.h"
#import "UIView+MLTKit.h"
#import "MGJMacros.h"

#define NUMBER_BADGE_HEIGHT   17.0f

@interface MLTNormalBadgeView()

@property (nonatomic, strong) UILabel *badgeLabel;

@end

@implementation MLTNormalBadgeView

- (id)initWithBackgroundColor:(UIColor *)backgroundColor fontColor:(UIColor *)fontColor
{
    self = [super initWithFrame:CGRectMake(0, 0, NUMBER_BADGE_HEIGHT, NUMBER_BADGE_HEIGHT)];
    if (self) {
        self.backgroundColor = backgroundColor;
        
        self.badgeLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.badgeLabel.backgroundColor = [UIColor clearColor];
        
        self.badgeLabel.textAlignment = NSTextAlignmentCenter;
        self.badgeLabel.textColor = fontColor;
        self.badgeLabel.font = [UIFont systemFontOfSize:13.f];
        
        self.layer.cornerRadius = self.height / 2;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        self.hidden = YES;
        [self addSubview: self.badgeLabel];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithBackgroundColor:MGJ_RGBCOLOR(242, 55, 55) fontColor:[UIColor whiteColor]];
}

- (void)setBadgeNum:(NSInteger)badgeNum
{
    _badgeNum = badgeNum;
    if (_badgeNum <= 0) {
        self.hidden = YES;
    }
    else
    {
        if (_badgeNum > 99) {
            self.badgeLabel.text = @"•••";
        }
        else
        {
            self.badgeLabel.text = [NSString stringWithFormat:@"%ld",(long)_badgeNum];
        }
        self.hidden = NO;
        CGPoint center = self.center;
        if (_badgeNum < 10) {
            self.width = NUMBER_BADGE_HEIGHT;
        }
        else//变长
        {
            self.width = 25.f;
        }
        self.badgeLabel.frame = self.bounds;
        self.center = center;
    }
}

@end
