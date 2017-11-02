//
//  UIView+MLTBrokenNetwork.m
//  AMCustomer
//
//  Created by 恺撒 on 2016/10/28.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "UIView+MLTBrokenNetwork.h"

@implementation UIView (MLTBrokenNetwork)

- (void)showBrokenNetworkViewWithClickedHandler:(clickedHandler)handler {
    [self showBrokenNetworkViewInFrame:self.bounds clickedHandler:handler];
}

- (void)showBrokenNetworkViewInFrame:(CGRect)frame clickedHandler:(clickedHandler)handler {
    MLTBrokenNetworkView *brokenNetworkView = [[MLTBrokenNetworkView alloc] initWithFrame:frame clickedHandler:handler];
    [self addSubview:brokenNetworkView];
}

@end
