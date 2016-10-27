//
//  TimerTableCell.h
//  Mango
//
//  Created by 周永 on 16/10/27.
//  Copyright © 2016年 shuige. All rights reserved.
//

typedef NS_ENUM(NSInteger, TimerCellType) {
    TimerCellTypeCountDown = 1,//倒计时
    TimerCellTypeTimer
};

#import <UIKit/UIKit.h>

@interface TimerTableCell : UITableViewCell

{
    NSDictionary *strokeInfo;
}

@property (strong, nonatomic) IBOutlet UILabel *rightHeadLabel;
@property (strong, nonatomic) IBOutlet UILabel *leftHeadLabel;
@property (strong, nonatomic) IBOutlet UIImageView *typeImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *daysLabel;


@property (nonatomic, assign) TimerCellType type;
@property (nonatomic, copy) NSString *days;
@property (strong, nonatomic) IBOutlet UIImageView *statusImgView;

@end
