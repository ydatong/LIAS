//
//  TimerTableCell.m
//  Mango
//
//  Created by 周永 on 16/10/27.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "TimerTableCell.h"

@implementation TimerTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    strokeInfo = @{NSStrokeColorAttributeName:[UIColor blackColor],
                         NSForegroundColorAttributeName:[UIColor whiteColor],
                         NSStrokeWidthAttributeName:@-2.0
                         };
    
    _statusImgView.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];

    _leftHeadLabel.text = _type == TimerCellTypeTimer ? @"坚持" : @"距离";
    _rightHeadLabel.text = _type == TimerCellTypeTimer ? @"已经" : @"还有";
    _typeImage.image = _type == TimerCellTypeTimer ? [UIImage imageNamed:@"border_timer_1"] : [UIImage imageNamed:@"border_countdown_1"];
    _titleLabel.textColor = _type == TimerCellTypeTimer ? MainColor : [[StyleBuilder builder] getColor:@"#eb4f38"];
}

- (void)setDays:(NSString *)days {
    _days = days;
    _daysLabel.attributedText = [[NSAttributedString alloc] initWithString:days attributes:strokeInfo];
}

@end
