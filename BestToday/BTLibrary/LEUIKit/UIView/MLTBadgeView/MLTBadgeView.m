//
//  MLTBadgeView.m
//  AMCustomer
//
//  Created by fuyao on 16/9/6.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

#import "MLTBadgeView.h"
#import "MLTDotBadgeView.h"
#import "MLTNormalBadgeView.h"
#import "MLTImageBadgeView.h"

@implementation MLTBadgeView

+ (MLTBadgeView *)bageViewForType:(MLTBadgeType)type {
    switch (type) {
        case MLTBadgeNormalType:
            return [[MLTNormalBadgeView alloc] init];
            break;
        case MLTBadgeDotType:
            return [[MLTDotBadgeView alloc] init];
            break;
        case MLTBadgeNewType: {
            MLTImageBadgeView *imageBadgeView = [[MLTImageBadgeView alloc] initWithFrame:CGRectMake(0, 0, 27, 15)];
            [imageBadgeView setImagePath:@"MLTUIKit.bundle/icon_new"];
        }
            break;
        case MLTBadgeSuggestType: {
            MLTImageBadgeView *imageBadgeView = [[MLTImageBadgeView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
            [imageBadgeView setImagePath:@"MLTUIKit.bundle/icon_suggest"];
        }
            break;
        default:
            break;
    }
    return nil;
}

@end
