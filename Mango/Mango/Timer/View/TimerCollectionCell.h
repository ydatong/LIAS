//
//  TimerCollectionCell.h
//  Mango
//
//  Created by 周永 on 16/10/28.
//  Copyright © 2016年 shuige. All rights reserved.
//

typedef NS_ENUM(NSInteger, TimerCellType) {
    TimerCellTypeCountDown = 1,//倒计时
    TimerCellTypeTimer
};

@protocol TimerCellDelegate <NSObject>

@optional
- (void)timerCellDidClickedDetailButton:(UICollectionViewCell*)cell;
- (void)timerCellDidClickedDeleteButton:(UICollectionViewCell*)cell;
- (void)timerCellWillShowDetail:(UICollectionViewCell*)cell; //即将显示详情按钮和删除按钮
- (void)timerCellDidHideDetail:(UICollectionViewCell*)cell; //隐藏了详情

@end

#import <UIKit/UIKit.h>

@interface TimerCollectionCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet SGCircleView *dayView;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *statusImg;
@property (strong, nonatomic) IBOutlet UIView *backView;


@property (nonatomic, copy) NSString *daysCount;
@property (nonatomic, assign) TimerCellType type;
@property (nonatomic, assign) BOOL finished;
@property (nonatomic, weak) id<TimerCellDelegate> delegate;
@property (nonatomic, strong) TimerItem *item;

- (void)hideDetail :(void(^)())complete;

@end
