//
//  MLTBrokenNetworkView.m
//  AMCustomer
//
//  Created by 恺撒 on 16/9/26.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "MLTBrokenNetworkView.h"

@implementation MLTBrokenNetworkView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initial];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame clickedHandler:(clickedHandler)handler {
    self = [super initWithFrame:frame];
    if (self) {
        self.handler = handler;
        [self initial];
    }
    return self;
}

- (void)initial {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [UIImageView new];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.image = [UIImage imageNamed:@"mlt_broken_network.png"];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(120);
        make.centerX.equalTo(self);
        make.width.height.mas_equalTo(101);
    }];
    
    UILabel *mesLabel = [[UILabel alloc] init];
    mesLabel.backgroundColor = [UIColor clearColor];
    mesLabel.textAlignment = NSTextAlignmentCenter;
    mesLabel.text = @"网络不给力，点击页面刷新试看看";
    mesLabel.font = [UIFont systemFontOfSize:14.0];
    mesLabel.textColor = HEX(@"#999999");
    [self addSubview:mesLabel];
    [mesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(imageView.mas_bottom).offset(30);
    }];
    
    [self mlt_whenTapWithTarget:self handler:@selector(contentClicked)];
    
}

- (void)contentClicked {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (_handler)
            _handler(self);
        [self removeFromSuperview];
    }];
}

@end
