//
//  DateUtil.h
//  lvYe
//
//  Created by Cloay on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtil : NSObject

+ (NSDate *)dateWithString:(NSString *)date;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;
+ (NSString *)getMonthWithDate:(NSDate *)date;
+ (NSString *)getMonthAndDayWiteDate:(NSDate *)date;

+ (NSString *)getFormatDateWithString:(NSString *)date withformat:(NSString *)format;
@end
