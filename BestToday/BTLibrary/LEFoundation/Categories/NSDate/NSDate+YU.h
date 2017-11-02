//
//  NSDate+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSCalendar+YU.h"
@interface NSDate (YU)

-(int)day;
-(int)month;
-(int)year;
-(int)nextDay;
-(int)preDay;

-(NSDate*)nextWeek;
-(NSDate*)preWeek;

-(NSDate*)nextDate;
-(NSDate*)preDate;

-(NSDate*)weekMonday;
-(NSDate*)natualWeekFirstDay;

-(NSDate*)monthFirstDay;
-(NSDate*)nextMonth;
-(NSDate*)preMonth;

-(NSDate*)dayStart;
-(NSDate*)dayEnd;

-(NSDate*)nextYearFirstDay;
-(NSDate*)preYearFirstDay;
-(NSDate*)yearEnd;
-(NSDate*)yearFirst;

-(NSDate*)yearLastWeekMonday;
-(NSDate*)weekEnd;

-(NSString*)dateStringFormat:(NSString*)ft;
-(NSString*)dateStr;

//大于date  返回yes
-(BOOL)compareDate:(NSDate*)date;

//大于date  返回yes
-(BOOL)comparewithDate:(NSDate *)date;


//判断是否是同一天 周 月 年
-(BOOL)isEqualDay:(NSDate*)date;

-(BOOL)isEqualWeek:(NSDate*)date;

-(BOOL)isEqualMOnth:(NSDate*)date;

-(BOOL)isEqualYear:(NSDate*)date;


//是否本地免打扰
-(BOOL)isNotDisturb;

+(NSString *)currentDate;
+(NSString *)anyDate:(NSString*)pattern date:(NSDate *)date;
+(NSString *)currentDate:(NSString*)pattern;

+ (NSString *)created_atDateString:(NSString *)dataString;
+ (NSString *)created_atDateString:(NSString *)dataString dataFormat:(NSString *)dataFormat;
//时间格式转换
+ (NSString *)anyDate:(NSString *)originalDate toDataFormat:(NSString *)toDataFormat fromDataFormat:(NSString *)fromDataFormat;

@end
