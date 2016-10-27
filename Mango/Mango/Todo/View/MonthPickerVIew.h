//
//  MonthPickerVIew.h
//  Mango
//
//  Created by 周永 on 16/10/22.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MonthPickerDelegate <NSObject>

@optional
- (void)monthPickerDidSelectDate:(NSDate*)date;

@end

@interface MonthPickerVIew : UIView <UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIPickerView *datePicker;
@property (nonatomic, weak) id<MonthPickerDelegate> delegate;
@property (strong, nonatomic) NSArray *years;
@property (strong, nonatomic) NSArray *months;

@end
