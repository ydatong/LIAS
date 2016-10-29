//
//  MangoCalendar.h
//  Mango
//
//  Created by 周永 on 16/10/21.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarCell.h"

@protocol MangoCalendarDelegate <NSObject>

@optional
- (void)mangoCalendarDidSelectDate:(NSDate *)date atCell:(CalendarCell*)cell;

@end

@interface MangoCalendar : UIView

@property (nonatomic, weak) id<MangoCalendarDelegate> delegate;
@property (strong, nonatomic) IBOutlet UICollectionView *calendarView;
@property (strong, nonatomic) NSDate *currentDate;  //当前日历的时间
@property (strong, nonatomic) NSDate *selectedDate; //当前选中的时间(因为有可能是通过next，pre过来的)
- (CalendarCell*)calendarCellForDate:(NSDate*)date;

@end
