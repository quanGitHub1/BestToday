//
//  MLTTableView+MLTBrokenNetwork.m
//  AMCustomer
//
//  Created by 恺撒 on 2016/10/27.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "MLTTableView+MLTBrokenNetwork.h"

static const char *MLTTVBrokenNetworkKey = "MLTTVBrokenNetworkKey";

@implementation MLTTableView (MLTBrokenNetwork)

- (void)setAutoShowBrokenNetwork:(BOOL)autoShowBrokenNetwork {
    NSNumber *autoShow = @(0);
    if (autoShowBrokenNetwork) {
        autoShow = @(1);
    }
    objc_setAssociatedObject(self, &MLTTVBrokenNetworkKey,autoShow, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)autoShowBrokenNetwork {
    NSNumber *autoShow = objc_getAssociatedObject(self, &MLTTVBrokenNetworkKey);
    return [autoShow boolValue];
}

- (void)showBrokenNetworkView {
    if ([self.mlt_dataArray count] != 0) return;
//    @weakify(self);
//    [self showBrokenNetworkViewInFrame:self.bounds clickedHandler:^(MLTBrokenNetworkView *brokenView) {
//        @strongify(self);
//        [self mlt_loadFirstPage];
//    }];
}

@end
