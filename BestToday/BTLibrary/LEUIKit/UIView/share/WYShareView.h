//
//  WYShareView.h
//  Finance
//
//  Created by 王艳 on 2017/5/8.
//  Copyright © 2017年 luluzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ShareType) {
    ShareTypeSocial = 0, //社交分享
    ShareTypeSysterm     //系统
};

typedef void(^ShareResultBlock)(ShareType type,BOOL isSuccess);

@interface WYShareView : UIView

/**
 *  分享
 *
 *  @param content     @{@"text":@"",@"image":@[],@"url":@""}
 *  @param resultBlock 结果
 */
+ (void)showShareViewWithPublishContent:(id)content
                                 Result:(ShareResultBlock)resultBlock;
/**
 *  分享
 *
 *  @param content     @{@"text":@"",@"image":@[],@"url":@""}
 *  @param resultBlock 结果
 */
- (void)initPublishContent:(id)content
                    Result:(ShareResultBlock)resultBlock;

@end
