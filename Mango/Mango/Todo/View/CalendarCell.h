//
//  CalendarCell.h
//  Mango
//
//  Created by 周永 on 16/10/21.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 右上角的标记状态
 1.有未完成事件
 2.事件全部完成
 3.没有事件
 */
typedef NS_ENUM(NSInteger, CalendarCellMarkStatus) {
    CalendarCellMarkStatusUnFinished = 1,
    CalendarCellMarkStatusAllFinished,
    CalendarCellMarkStatusNoItem
};


/*
 背景
 1.当天
 2.当前选中
 3.其他（暂时无）
 */
typedef NS_ENUM(NSInteger, CalendarCellBackgroundType) {
    CalendarCellBackgroundTypeToday = 1,
    CalendarCellBackgroundTypeSelected = 2,
    CalendarCellBackgroundTypeOther
};

@interface CalendarCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *lunarLabel;
@property (strong, nonatomic) IBOutlet UIView *circleView;
@property (strong, nonatomic) IBOutlet UILabel *solarLabel;
@property (strong, nonatomic) IBOutlet UIImageView *backImageView;

@property (nonatomic, assign) CalendarCellMarkStatus markStatus;
@property (nonatomic, assign) CalendarCellBackgroundType backgroundType;
@property (nonatomic, assign) BOOL isDateInCurrentMonth;    //当前cell时间是否是在当前月中

@end




















