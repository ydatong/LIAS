//
//  CalendarCell.m
//  Mango
//
//  Created by 周永 on 16/10/21.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "CalendarCell.h"

@interface CalendarCell()




@end

@implementation CalendarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _circleView.layer.cornerRadius = 4.0;
    _circleView.layer.masksToBounds = YES;
    _circleView.hidden = YES;
    
    [_solarLabel adjustsFontSizeToFitWidth];
}

- (void)setIsDateInCurrentMonth:(BOOL)isDateInCurrentMonth {
    _isDateInCurrentMonth = isDateInCurrentMonth;
    if (_isDateInCurrentMonth) {
        self.backgroundColor = [UIColor whiteColor];
        self.lunarLabel.textColor = [UIColor blackColor];
        self.solarLabel.textColor = [UIColor grayColor];
    }else{
        self.lunarLabel.textColor = [UIColor lightGrayColor];
        self.solarLabel.textColor = [UIColor lightGrayColor];
        self.alpha = 0.5;
    }
}

- (void)setBackgroundType:(CalendarCellBackgroundType)backgroundType {
    if (_backgroundType == backgroundType) {
        return;
    }
    _backgroundType = backgroundType;
    if (_backgroundType == CalendarCellBackgroundTypeToday) {
        self.backImageView.image = [UIImage imageNamed:@"today"];
        self.backImageView.alpha = .5f;
    }else if(_backgroundType == CalendarCellBackgroundTypeSelected){
        self.backImageView.image = [UIImage imageNamed:@"circle"];
        self.backImageView.alpha = 1.0;
    }else{
        self.backImageView.image = [[UIImage alloc] init];
    }
}

- (void)setMarkStatus:(CalendarCellMarkStatus)markStatus {
    
    if (_markStatus == markStatus) {
        return;
    }
    _markStatus = markStatus;
    if (_markStatus == CalendarCellMarkStatusUnFinished) {
        _circleView.hidden = NO;
        _circleView.backgroundColor = [UIColor redColor];
    }else if(_markStatus == CalendarCellMarkStatusAllFinished){
        _circleView.backgroundColor = MainColor;
        _circleView.hidden = NO;
    }else{
        _circleView.hidden = YES;
    }
}

@end
