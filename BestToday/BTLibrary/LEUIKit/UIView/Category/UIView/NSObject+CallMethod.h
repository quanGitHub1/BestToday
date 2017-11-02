//
//  NSObject+CallMethod.h
//  Finance
//
//  Created by Gnet_lulizhi on 2017/6/16.
//  Copyright © 2017年 luluzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CallMethod)
-(BOOL)getCurrencyByID:(NSString *)currencyID;
-(BOOL)themarket:(NSString *)currentID;
-(NSString *)getCurrency:(NSString *)currencyName;
@end
