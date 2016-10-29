//
//  NSDate+Calendar.h
//  Mango
//
//  Created by 周永 on 16/10/21.
//  Copyright © 2016年 shuige. All rights reserved.
//


#import <Foundation/Foundation.h>

struct SGTime{
    int year;
    int month;
    int day;
};
typedef struct SGTime SGTime;

@interface NSDate (Calendar)

//本月的第一天
- (NSDate*)firstDayOfCurrentMonth;

//本月的第一天是星期几
- (NSInteger)firstWeekDayOfCurrentMonth;

//本月总共有多少天
- (NSInteger)daysCountOfCurrentMonth;

- (SGTime)sgtime;

//格式化时间 用来数据库查找
- (NSString*)sgtimeFormattedString;

- (BOOL)isEqualToDateSgtime:(NSDate*)date;

+ (NSDate*)dateFromSgtime:(SGTime)sgtime;

- (SGTime)toChineseCalendarDate;

- (NSString*)formattedString:(NSString*)format;

@end
