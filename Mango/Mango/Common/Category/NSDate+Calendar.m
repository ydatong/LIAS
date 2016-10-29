//
//  NSDate+Calendar.m
//  Mango
//
//  Created by 周永 on 16/10/21.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "NSDate+Calendar.h"


SGTime SGTimeMake(int year, int month, int day) {
    SGTime time;
    time.year = year;
    time.month = month;
    time.day = day;
    return time;
};

@implementation NSDate (Calendar)

- (NSDate*)firstDayOfCurrentMonth {
    
    NSCalendar *calendar = [self calendar];
    NSDateComponents *currentDateComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:self];
    NSDate *startOfMonth = [calendar dateFromComponents:currentDateComponents];
    NSDate *date = [startOfMonth dateByAddingTimeInterval:8*60*60];
    return date;
}


- (NSInteger)firstWeekDayOfCurrentMonth {
    NSCalendar *calendar = [self calendar];
    NSDateComponents *currentDateComponents = [calendar components:NSCalendarUnitWeekday fromDate:[self firstDayOfCurrentMonth]];
    return currentDateComponents.weekday - 1;
}


- (NSInteger)daysCountOfCurrentMonth {
    NSCalendar *calendar = [self calendar];
    return [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}


- (SGTime)sgtime {
    NSCalendar *calendar = [self calendar];
    NSDateComponents *currentDateComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    return  SGTimeMake((int)currentDateComponents.year, (int)currentDateComponents.month, (int)currentDateComponents.day);
}

- (NSString*)sgtimeFormattedString {
    SGTime time = [self sgtime];
    return [NSString stringWithFormat:@"%d/%d/%d",time.year,time.month,time.day];
}


- (BOOL)isEqualToDateSgtime:(NSDate *)date {
    SGTime selfTime = [self sgtime];
    SGTime dateTime = [date sgtime];
    if (dateTime.year == selfTime.year && dateTime.month == selfTime.month && dateTime.day == selfTime.day) {
        NSLog(@"%@\n%d-%d-%d",date,dateTime.year,dateTime.month,dateTime.day);
        NSLog(@"%@\n%d-%d-%d",self,selfTime.year,selfTime.month,selfTime.day);
        return YES;
    }
    return NO;
}


+ (NSDate*)dateFromSgtime:(SGTime)sgtime {
    
    NSCalendar *calendar = [[NSDate date] calendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = sgtime.year;
    components.month = sgtime.month;
    components.day = sgtime.day;
    return [calendar dateFromComponents:components];
}


- (SGTime)toChineseCalendarDate {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    SGTime sgtime;
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    sgtime.year = (int)components.year;
    sgtime.month = (int)components.month;
    sgtime.day = (int)components.day;
    return sgtime;
}

- (NSCalendar*)calendar {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"GMT+0800"];
    return calendar;
}

- (NSString*)formattedString:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    dateFormatter.calendar = [self calendar];
    return [dateFormatter stringFromDate:self];
}

@end
