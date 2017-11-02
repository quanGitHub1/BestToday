//
//  NSDate+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "NSDate+YU.h"
#import "NSCalendar+YU.h"


#pragma mark - DateFormat
NSString * const  YU_DateFormatNill = @"0000-00-00 00:00:00.000";
NSString * const  YU_DefaultDateFormat =  @"yyyy-MM-dd HH:mm:ss";
NSString * const  YU_DefaultDateFormat_SSS =  @"yyyyMMddHHmmssSSS";

NSString * const  YU_DateFormat_01 =  @"yyyy-MM-dd HH:mm:ss.SSS";
NSString * const  YU_DateFormat_02 =  @"yyyy-MM-dd HH:mm:ss";
NSString * const  YU_DateFormat_03 =  @"yyyy-MM-dd HH:mm";
NSString * const  YU_DateFormat_04 =  @"yyyy-MM-dd HH";
NSString * const  YU_DateFormat_05 =  @"yyyy-MM-dd";
NSString * const  YU_DateFormat_06 =  @"MM-dd HH:mm";

NSString * const  YU_DateFormat01 =  @"yyyy.MM.dd HH:mm.ss.SSS";
NSString * const  YU_DateFormat02 =  @"yyyy.MM.dd HH:mm.ss";
NSString * const  YU_DateFormat03 =  @"yyyy.MM.dd HH:mm";
NSString * const  YU_DateFormat04 =  @"yyyy.MM.dd HH";
NSString * const  YU_DateFormat05 =  @"yyyy.MM.dd";

NSString * const  YU_DateFormat一 =  @"yyyy年MM月dd日HH点mm分";
NSString * const  YU_DateFormat二 =  @"MM月dd日HH点mm分";


#define kOneDayInterval (24 * 60 * 60 )
#define k7DayInterval (7 * kOneDayInterval)

@implementation NSDate (YU)
-(int)day
{
    return [NSCalendar getDayWithDate:self];
}


-(int)month
{
    return [NSCalendar getMonthWithDate:self];
}

-(int)year
{
    return [NSCalendar getYearWithDate:self];
}


-(int)nextDay
{
    NSDate *date = [self dateByAddingTimeInterval:kOneDayInterval];
    return date.day;
}

-(int)preDay
{
    NSDate *date = [self dateByAddingTimeInterval:-kOneDayInterval];
    return date.day;
    
}

-(NSDate*)nextWeek
{
    return [self dateByAddingTimeInterval:7 * kOneDayInterval];
}

-(NSDate*)preWeek
{
    return [self dateByAddingTimeInterval:-7 * kOneDayInterval];
}


-(NSDate*)nextDate
{
    return [self dateByAddingTimeInterval:kOneDayInterval];
}

-(NSDate*)preDate
{
    return [self dateByAddingTimeInterval:-kOneDayInterval];
}

-(NSDate*)weekMonday
{
    int weekDay = [NSCalendar getWeekdayWithDate:self];
    int offset = 0;
    if (weekDay == 1) {
        offset = -6;
    } else {
        offset = 2- weekDay;
    }
    NSDate *date = [self dateByAddingTimeInterval:(kOneDayInterval * offset)];
    return date;
}

-(NSDate*)natualWeekFirstDay
{
    int weekDay = [NSCalendar getWeekdayWithDate:self];
    int offset = weekDay - 1;
    
    NSDate *date = [self dateByAddingTimeInterval:-(kOneDayInterval * offset)];
    return date;
}

-(NSDate*)monthFirstDay
{
    NSDateComponents *comp = [NSCalendar dateComponentsWithDate:self];
    comp.day = 1;
    
    
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comp];
    return date.dayStart;
}

-(NSDate*)nextMonth
{
    NSDateComponents *comp = [NSCalendar dateComponentsWithDate:self];
    comp.month = (comp.month + 1) % 13 + (comp.month + 1) / 13;
    comp.day = 1;
    if (comp.month == 1) {
        comp.year++;
    }
    return [[NSCalendar currentCalendar] dateFromComponents:comp];
    
}

-(NSDate*)preMonth
{
    NSDateComponents *comp = [NSCalendar dateComponentsWithDate:self];
    int month = (comp.month - 1) % 13;
    int year = (int)comp.year;
    if (month == 0) {
        month = 12;
        year--;
    }
    comp.day = 1;
    comp.year = year;
    comp.month = month;
    return [[NSCalendar currentCalendar] dateFromComponents:comp];
}

-(NSDate*)dayStart
{
    NSDateComponents *comp = [NSCalendar dateComponentsWithDate:self];
    comp.hour = 0;
    comp.minute = 0;
    comp.second = 0;
    return [[NSCalendar currentCalendar] dateFromComponents:comp];
}

-(NSDate*)dayEnd
{
    NSDateComponents *comp = [NSCalendar dateComponentsWithDate:self];
    comp.hour = 23;
    comp.minute = 59;
    comp.second = 59;
    return [[NSCalendar currentCalendar] dateFromComponents:comp];
}

-(NSDate*)nextYearFirstDay
{
    NSDateComponents *comp = [NSCalendar dateComponentsWithDate:self];
    comp.year++;
    comp.month = comp.day = 1;
    comp.hour = comp.second = comp.minute = 0;
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comp];
    return date;
}

-(NSDate*)preYearFirstDay
{
    NSDateComponents *comp = [NSCalendar dateComponentsWithDate:self];
    comp.year--;
    comp.month = comp.day = 1;
    comp.hour = comp.second = comp.minute = 0;
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comp];
    return date.dayStart;
}

-(NSDate*)yearEnd
{
    NSDateComponents *comp = [NSCalendar dateComponentsWithDate:self];
    comp.month = 12;
    comp.day = 31;
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comp];
    return date.dayEnd;
}

-(NSDate*)yearFirst
{
    NSDateComponents *comp = [NSCalendar dateComponentsWithDate:self];
    comp.month = 1;
    comp.day = 1;
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comp];
    return date.dayStart;
}

-(NSDate*)yearLastWeekMonday
{
    NSDate *date = self.yearEnd;
    int week = [NSCalendar getWeekdayWithDate:date];
    date = [date dateByAddingTimeInterval:-(week - 1) * kOneDayInterval];
    return date.dayStart;
}

-(NSDate*)weekEnd
{
    int week = [NSCalendar getWeekOfYearWithDate:self];
    if (week == 1 && self.month == 12) {
        return self.yearEnd;
    } else {
        return self.natualWeekFirstDay.nextWeek.preDate.dayEnd;
    }
}

-(NSString*)dateStringFormat:(NSString*)ft
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:ft];
    
    NSString *destDateString = [dateFormatter stringFromDate:self];
    return  destDateString;
}

-(NSString*)dateStr{
    return [self dateStringFormat:@"yyyy-MM-dd HH:mm:ss"];
}



//大于date  返回yes
-(BOOL)compareDate:(NSDate*)date{
    return [[self earlierDate:date] isEqualToDate:date];
}

-(BOOL)comparewithDate:(NSDate *)date{
    NSComparisonResult result = [self compare:date];
    BOOL isbig = NO;
    if (result==NSOrderedDescending) {//大于
        isbig = YES;
    }
    return isbig;
}


-(BOOL)isEqualDay:(NSDate*)date{
    return ([NSCalendar getYearWithDate:self] == [NSCalendar getYearWithDate:date] &&
            [NSCalendar getMonthWithDate:self] == [NSCalendar getMonthWithDate:date] &&
            [NSCalendar getDayWithDate:self] == [NSCalendar getDayWithDate:date])
    ;
}

-(BOOL)isEqualWeek:(NSDate*)date{
    BOOL isEqual =  ([NSCalendar getYearWithDate:self] == [NSCalendar getYearWithDate:date] &&
                     [NSCalendar getMonthWithDate:self] == [NSCalendar getMonthWithDate:date] && [NSCalendar getWeekOfYearWithDate2:self]== [NSCalendar getWeekOfYearWithDate2:date]);
    return isEqual;
    
}

-(BOOL)isEqualMOnth:(NSDate*)date{
    return ([NSCalendar getYearWithDate:self] == [NSCalendar getYearWithDate:date] &&
            [NSCalendar getMonthWithDate:self] == [NSCalendar getMonthWithDate:date])
    ;
}

-(BOOL)isEqualYear:(NSDate*)date{
    return [NSCalendar getYearWithDate:self] == [NSCalendar getYearWithDate:date];
}

//仅限本地操作有效
#define YU_NotDisturbDateBefore @"YYYY-MM-DD 08:00:00" //早上 XXX 之前免打扰
#define YU_NotDisturbDateAfter  @"YYYY-MM-DD 19:00:00" //晚上 XXX 之后免打扰

-(BOOL)isNotDisturb{
    NSDate *NotDisturbStartDate = [[NSDate date] CurrentDate:YU_NotDisturbDateBefore];
    NSDate *NotDisturbEndDate = [[NSDate date] CurrentDate:YU_NotDisturbDateAfter];
    //>08 && < 19 非打扰
    if ([self compareDate:NotDisturbStartDate] && ![self compareDate:NotDisturbEndDate]){
        return NO;
    }
    return YES;
}

-(NSDate *)CurrentDate:(NSString *)pattern{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setDateFormat:pattern];
    NSString *currentDateStr = [dateFormatter stringFromDate:self];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:YU_DefaultDateFormat];
    return [dateFormatter dateFromString: currentDateStr];
}

+(NSString *)currentDate:(NSString*)pattern{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setDateFormat:pattern];
    return [dateFormatter stringFromDate:[NSDate date]];
}

+(NSString *)anyDate:(NSString*)pattern date:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setDateFormat:pattern];
    return [dateFormatter stringFromDate:date];
}

+(NSString *)currentDate{
    return [NSDate currentDate:@"HH:mm.ss.sss"];
}


/** 是否是今年 */
- (BOOL)isThisYear{
    // 获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 比较时间
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    // NSInteger之间的比较
    return nowYear == selfYear;
}

/** 是否是今天 */
- (BOOL)isToday{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    
    // 字符串之间的比较
    return [nowString isEqualToString:selfString];
    //    return [nowString isEqual:selfString];
}

/** 是否是昨天 */
- (BOOL)isYesterday{
    // 去除掉时分秒
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth |
    NSCalendarUnitDay;
    NSDateComponents *coms = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    return coms.year == 0
    && coms.month == 0
    && coms.day == 1;
}

/** 是否是明天  (注：这个只是扩展，实际开发不会用到是否是明天的) */
- (BOOL)isTomorrow{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth |
    NSCalendarUnitDay;
    NSDateComponents *coms = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    return coms.year == 0
    && coms.month == 0
    && coms.day == -1;
}


/**
 *  拿到服务器返回的时间和当前时间进行比较
 *  返回一个字符串时间
 */
+ (NSString *)created_atDateString:(NSString *)dataString{
    return [NSDate created_atDateString:dataString dataFormat:@"yyyyMMddHHmmss"];
}

+ (NSString *)created_atDateString:(NSString *)dataString dataFormat:(NSString *)dataFormat {
    // 1.创建NSDateFormatter对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 1.1并日期格式化
    fmt.dateFormat = dataFormat;
    // 1.2拿到服务器返回的时间
    
    NSDate *creat = [fmt dateFromString:dataString];
    
    // 2.判断服务器返回的时间
    if (creat.isThisYear) {          // 今年
        if (creat.isToday) {         // 今天
            NSDateComponents *coms = [NSCalendar dateComponentsWithDate:creat];
            if (coms.hour > 1) {        // 几小时前
                return [NSString stringWithFormat:@"%zd小时前",coms.hour];
            }else if (coms.minute > 1){ // 几分钟前
                return [NSString stringWithFormat:@"%zd分钟前",coms.minute];
            }else{                      // 刚刚
                return @"刚刚";
            }
        }else if (creat.isYesterday){// 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:creat];
        }else{                          // 今年其他日子
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:creat];
        }
    }else{                              // 非今年
        return dataString;
    }
}

+ (NSString *)anyDate:(NSString *)originalDate toDataFormat:(NSString *)toDataFormat fromDataFormat:(NSString *)fromDataFormat {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 1.1并日期格式化
    fmt.dateFormat = fromDataFormat;
    // 1.2拿到服务器返回的时间
    NSDate *creat = [fmt dateFromString:originalDate];
    // 1.3再次转换日期格式
    fmt.dateFormat = toDataFormat;
    return [fmt stringFromDate:creat];
}
@end
