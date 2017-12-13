//
//  BTHomedetailHeaderView.h
//  BestToday
//
//  Created by leeco on 2017/11/14.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeDetailheaderDelegate <NSObject>

- (void)reloadCollection:(CGFloat)height;


@end

@interface BTHomedetailHeaderView : UICollectionReusableView

@property (nonatomic, strong)id<HomeDetailheaderDelegate>delegate;

@property (nonatomic, assign) CGFloat heightTab;

@property (nonatomic, strong) NSString *resourceId;

@property (nonatomic, strong) NSString *picUrl;

- (void)initCreatTableview;

@end
