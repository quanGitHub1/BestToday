//
//  MLTDotBadgeView.m
//  AMCustomer
//
//  Created by fuyao on 16/9/6.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "MLTDotBadgeView.h"
#import "UIView+MLTKit.h"

@implementation MLTDotBadgeView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.bounds = CGRectMake(0, 0, 8, 8);
        self.layer.cornerRadius = self.width / 2;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        self.backgroundColor = RGB(242, 55, 55);
        self.hidden = YES;
    }
    return self;
}

- (void)setBadgeNum:(NSInteger)badgeNum {
    _badgeNum = badgeNum;
    if (_badgeNum <= 0) {
        self.hidden = YES;
    }
    else{
        self.hidden = NO;
    }
}

@end
