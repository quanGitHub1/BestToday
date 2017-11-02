//
//  NSDateFormatter+MLTKit.h
//  AMCustomer
//
//  Created by 恺撒 on 16/9/2.
//  Copyright © 2016年 aimeizhuyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (MLTKit)

+ (id)mlt_dateFormatter;

+ (id)mlt_dateFormatterWithFormat:(NSString *)dateFormat;

+ (id)mlt_defaultDateFormatter;/*yyyy-MM-dd HH:mm:ss*/

@end
