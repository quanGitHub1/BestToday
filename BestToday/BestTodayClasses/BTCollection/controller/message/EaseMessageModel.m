/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "EaseMessageModel.h"

@implementation EaseMessageModel

- (instancetype)initWithMessage:(NSDictionary *)message
{
    self = [super init];
    if (self) {
        _cellHeight = -1;
        _isSender = [message[@"isSender"] boolValue];
        _nickname = message[@"nickname"];
        _avatarURLPath = message[@"avatarurl"];
        _text = message[@"text"];
    }
    return self;
}

@end
