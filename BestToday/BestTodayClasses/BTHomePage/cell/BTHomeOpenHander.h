//
//  BTHomeOpenHander.h
//  BestToday
//
//  Created by leeco on 2017/11/8.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTHomeOpenHander : NSObject

@property (nonatomic, strong)NSMutableArray *arrydata;


+ (instancetype)shareHomeOpenHander;


- (void)initDataArry;

- (void)removDataArry;


@end
