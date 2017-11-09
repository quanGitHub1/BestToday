//
//  BTHomeOpenHander.m
//  BestToday
//
//  Created by leeco on 2017/11/8.
//  Copyright © 2017年 leeco. All rights reserved.
//

#import "BTHomeOpenHander.h"

@implementation BTHomeOpenHander

+ (instancetype)shareHomeOpenHander{

    static BTHomeOpenHander *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;

}

- (void)initDataArry{

    _arrydata = [NSMutableArray array];
    
}

- (void)removDataArry{
    
    [_arrydata removeAllObjects];
    
}

@end
