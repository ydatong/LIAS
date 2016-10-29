//
//  TimerDetailView.h
//  Mango
//
//  Created by 周永 on 16/10/28.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerDetailView : UIView
@property (strong, nonatomic) IBOutlet UILabel *startDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *endDateLabel;
@property (strong, nonatomic) IBOutlet UITextView *noteLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end
