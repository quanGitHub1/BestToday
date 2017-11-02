//
//  NSURL+MLTKit.h
//  AMCustomer
//
//  Created by 恺撒 on 16/9/2.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (MLTKit)

#pragma mark --- Safe

+ (NSURL *)mlt_safeURLWithString:(NSString*)string;

@end
