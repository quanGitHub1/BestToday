//
//  BTHomeDetailCollectionView.h
//  BestToday
//
//  Created by leeco on 2017/11/14.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LECollectionView.h"

@interface BTHomeDetailCollectionView : UIView



@property (nonatomic, strong) LECollectionView *collectionView;

@property (nonatomic, strong) NSString *resourceId;


- (instancetype)initWithFrame:(CGRect)frame resourceId:(NSString *)resourceId;

@end
