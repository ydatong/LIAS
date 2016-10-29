//
//  MangoCalendar.m
//  Mango
//
//  Created by 周永 on 16/10/21.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "MangoCalendar.h"
#import "CalendarLayout.h"
#import "MonthPickerVIew.h"

static const NSTimeInterval timeIntervalPerDay = 24*60*60;
static const NSInteger cellCount = 6*7;

@interface MangoCalendar ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MonthPickerDelegate>
{
    NSArray *weekdays;
    NSMutableArray *dateList;
    
    NSDate *firstDateOfCurrentMonth;
    NSInteger firstWeekdayOfCurrentMonth;
    NSInteger daysCountOfCurrentMonth;
    NSArray *chineseDays;
    NSArray *chineseMonth;
    
    MonthPickerVIew *monthPickerView;
}
@property (strong, nonatomic) IBOutlet UIView *weekDayView;
@property (strong, nonatomic) IBOutlet UILabel *monthLabel;

@end

@implementation MangoCalendar


- (void)awakeFromNib {
    [super awakeFromNib];
    weekdays = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    chineseDays = @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二",@"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"];
    chineseMonth = @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月"];
    [self configureWeekdayView];
    [self configureCalendarView];
    _currentDate = [NSDate date];
    [self reloadAllDate];
}

- (void)configureWeekdayView {
    
    for (int i = 0 ; i < weekdays.count; i++) {
        
        CGFloat width = ScreenWidth/weekdays.count;
        CGFloat height = 35.0;
        CGFloat x = i*width;
        CGFloat y = 0;
        UILabel *weekdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        weekdayLabel.textAlignment = NSTextAlignmentCenter;
        weekdayLabel.textColor = [UIColor blackColor];
        weekdayLabel.text = weekdays[i];
        weekdayLabel.font = DefaultFontWithSize(15);
        NSLog(@"%@",DefaultFontWithSize(15));
        [_weekDayView addSubview:weekdayLabel];
    }
}

- (void)configureCalendarView {

    _calendarView.delegate = self;
    _calendarView.dataSource = self;
    _calendarView.scrollEnabled = NO;
    _calendarView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    CalendarLayout *calendarLayout = [[CalendarLayout alloc] init];
    _calendarView.collectionViewLayout = calendarLayout;
    [_calendarView registerNib:[UINib nibWithNibName:@"CalendarCell" bundle:nil] forCellWithReuseIdentifier:@"calendarCell"];
}

//重新加载日期数据
- (void)reloadAllDate{
    dateList = [NSMutableArray arrayWithCapacity:0];
    [self resetDate:_currentDate];
    
    for (int i = 0 ; i < cellCount; i++) {
        [dateList addObject:[NSDate dateWithTimeInterval:(i-firstWeekdayOfCurrentMonth)*timeIntervalPerDay
                                               sinceDate:firstDateOfCurrentMonth]];
    }
    _monthLabel.text = [NSString stringWithFormat:@"%d/%d",[_currentDate sgtime].year, [_currentDate sgtime].month];
//    NSLog(@"%@",[NSString stringWithFormat:@"%d - %d",[currentDate sgtime].year, [currentDate sgtime].month]);
    [self.calendarView reloadData];
}

- (void)resetDate:(NSDate*)date{
    firstDateOfCurrentMonth = [date firstDayOfCurrentMonth];
    firstWeekdayOfCurrentMonth = [date firstWeekDayOfCurrentMonth];
    daysCountOfCurrentMonth = [date daysCountOfCurrentMonth];
}

#pragma mark -- uicollectionview delegate & datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return cellCount;
}


- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"calendarCell" forIndexPath:indexPath];
    NSDate *date = dateList[indexPath.row];
    SGTime chineseTime = [date toChineseCalendarDate];
    cell.lunarLabel.text = [NSString stringWithFormat:@"%d",[date sgtime].day];
    cell.solarLabel.text = chineseDays[chineseTime.day-1];
    cell.isDateInCurrentMonth = [_currentDate sgtime].year == [date sgtime].year && [_currentDate sgtime].month == [date sgtime].month;

    if([date isEqualToDateSgtime:[NSDate date]] ){
        cell.backgroundType = CalendarCellBackgroundTypeToday;
    }else if ([date isEqualToDateSgtime:_selectedDate]) {
        cell.backgroundType = CalendarCellBackgroundTypeSelected;
    }else{
        cell.backgroundType = CalendarCellBackgroundTypeOther;
    }
    
    if ([[DataManager manager] getTodoItemsWithDate:date].count > 0) {
        cell.markStatus = CalendarCellMarkStatusUnFinished;
    }else if([[DataManager manager] getFinishedTodoItemsWithDate:date].count > 0) {
        cell.markStatus = CalendarCellMarkStatusAllFinished;
    }else{
        cell.markStatus = CalendarCellMarkStatusNoItem;
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_delegate && [_delegate respondsToSelector:@selector(mangoCalendarDidSelectDate:atCell:)]) {
        [_delegate mangoCalendarDidSelectDate:dateList[indexPath.item] atCell:(CalendarCell*)[collectionView cellForItemAtIndexPath:indexPath]];
        _selectedDate = dateList[indexPath.row];
        _currentDate = _selectedDate;
        [self reloadAllDate];
    }
}

#pragma mark -- button clicked

- (IBAction)preMonth:(id)sender {
    SGTime sgtime = [_currentDate sgtime];
    if (sgtime.month - 1 == 0) {
        sgtime.year = sgtime.year - 1;
        sgtime.month = 12;
    }else{
        sgtime.month = sgtime.month - 1;
    }
    _currentDate = [NSDate dateFromSgtime:sgtime];
    [self reloadAllDate];
}

- (IBAction)nextMonth:(id)sender {
    
    SGTime sgtime = [_currentDate sgtime];
    if (sgtime.month + 1 <= 12) {
        sgtime.month = sgtime.month + 1;
    }else{
        sgtime.year = sgtime.year + 1;
        sgtime.month = 1;
    }
    _currentDate = [NSDate dateFromSgtime:sgtime];
    [self reloadAllDate];
}


- (IBAction)showMonthPicker:(id)sender {
    
    monthPickerView = [UIView loadViewFromNib:@"MonthPickerView"];
    monthPickerView.frame = self.bounds;
    monthPickerView.delegate = self;
    
    [UIView animateWithDuration:0.5 animations:^{
        [self addSubview:monthPickerView];
    }];
}


#pragma mark -- month picker delegate 

- (void)monthPickerDidSelectDate:(NSDate *)date {
    _currentDate = date;
    [self reloadAllDate];
}


- (CalendarCell*)calendarCellForDate:(NSDate *)date {
    
    NSInteger item = -1;
    for (int i = 0 ; i < cellCount; i++) {
        if ([date isEqualToDateSgtime:dateList[i]]) {
            item = i;
        }
    }
    if (item>= 0 ) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:item inSection:0];
        return (CalendarCell*)[_calendarView cellForItemAtIndexPath:indexpath];
    }
    return nil;
}


@end






















