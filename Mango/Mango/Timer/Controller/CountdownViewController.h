//
//  CountdownViewController.h
//  Mango
//
//  Created by 周永 on 16/10/26.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CountdownProtocol <NSObject>

- (void)countdownViewControllerDidConfirm:(TimerItem*)timerItem;

@end

@interface CountdownViewController : BaseViewController

@property (nonatomic, weak) id<CountdownProtocol> delegate;

@end
