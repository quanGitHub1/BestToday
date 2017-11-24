//
//  BTHomeHeaderView.h
//  BestToday
//
//  Created by leeco on 2017/11/24.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeDetailheaderDelegate <NSObject>

- (void)reloadTwoCollection:(CGFloat)height;


@end

@interface BTHomeHeaderView : UIView

@property (nonatomic, strong)id<HomeDetailheaderDelegate>delegate;

@property (nonatomic, strong) NSString *resourceId;


- (void)initCreatTableview;


@end
