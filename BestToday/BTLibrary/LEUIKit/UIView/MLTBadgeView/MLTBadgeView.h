//
//  MLTBadgeView.h
//  AMCustomer
//
//  Created by fuyao on 16/9/6.
//  Copyright © 2016年 Meili Inc. All rights reserved.
//

/**
 *  用于各类显示角标,工厂类
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MLTBadgeType) {
    MLTBadgeNormalType,   //正常数字显示,超过99显示...
    MLTBadgeDotType,      //显示小红点
    MLTBadgeNewType,      //显示 [new]
    MLTBadgeSuggestType   //显示 [荐]
};

@interface MLTBadgeView : UIView
{
    NSInteger _badgeNum;
}

/**
 *  badge 数字
 */
@property (nonatomic, assign) NSInteger badgeNum;

/*
 * 获取各种型号badge
 * 使用姿势：传入类型,返回一个固定大小，左上角起点 (0,0)的badgeView，ps：badgeNum=0，则隐藏
 * @param   type    badge的类型
 * @return  构造完成的badgeView
 */
+ (MLTBadgeView *)bageViewForType:(MLTBadgeType)type;

@end
