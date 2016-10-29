//
//  MonthPickerVIew.m
//  Mango
//
//  Created by 周永 on 16/10/22.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "MonthPickerVIew.h"

@implementation MonthPickerVIew

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _datePicker.delegate = self;
    _datePicker.dataSource = self;
    NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:0];
    
    SGTime time = [[NSDate date] sgtime];
    for (int i = 1990; i < 2101; i++) {
        [tmp addObject:[NSString stringWithFormat:@"%d",i]];
    }
    _years = [NSArray arrayWithArray:tmp];
    [_datePicker selectRow:time.year - 1990 inComponent:0 animated:YES];
    
    [tmp removeAllObjects];
    for (int i = 0; i < 12; i++) {
        [tmp addObject:[NSString stringWithFormat:@"%d",i+1]];
    }
    _months = [NSArray arrayWithArray:tmp];
    [_datePicker selectRow:time.month-1 inComponent:1 animated:YES];
    
    
}
- (IBAction)close:(id)sender {
    [self remove];
}

- (IBAction)confirm:(id)sender {
    [self remove];
}

- (void)remove {
    [UIView animateWithDuration:0.5 animations:^{
        [self removeFromSuperview];
    }];
}

#pragma mark -- pickerview delegate 

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return component == 0 ? _years.count : _months.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return component == 0 ? _years[row] : _months[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

@end
