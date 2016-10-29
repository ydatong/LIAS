//
//  TimerDetailView.m
//  Mango
//
//  Created by 周永 on 16/10/28.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "TimerDetailView.h"

@implementation TimerDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)close:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        [self removeFromSuperview];
    }];
}

@end
