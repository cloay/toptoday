//
//  DateUtil.m
//  lvYe
//
//  Created by Cloay on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil

//将字符串日期转换为Date类型
+ (NSDate *)dateWithString:(NSString *)date{
    if (date != nil) {
        NSTimeInterval t = [date doubleValue];
        NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:t];
        return newDate;
    }
    return nil;
}

//格式化日期
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format{
    NSString *f = (format == nil) ? @"%f" : format;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:f];
    return [formatter stringFromDate:date];
}

+ (NSString *)getFormatDateWithString:(NSString *)date withformat:(NSString *)format{
    NSString *f = (format == nil) ? @"%f" : format;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setDateFormat:f];
    [formatter setLocale:locale];
    NSDate *formateDate = [formatter dateFromString:date];
    return [self stringFromDate:formateDate withFormat:@"MM-dd HH:mm"];
}

//获取日期中的年月份
+ (NSString *)getMonthWithDate:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *componments = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:date];
    return [NSString stringWithFormat:@"%i年%i月", [componments year], [componments month]];
}

//获取日期中的月份日
+ (NSString *)getMonthAndDayWiteDate:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *componments = [calendar components:NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
    return [NSString stringWithFormat:@"%i月%i日", [componments month], [componments day]]; 
}
@end
