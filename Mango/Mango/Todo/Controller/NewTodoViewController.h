//
//  NewTodoViewController.h
//  Mango
//
//  Created by 周永 on 16/10/23.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewTodoViewDelegate <NSObject>

- (void)newTodoVidwDidConfirm:(TodoItem*)todoItem editting:(BOOL)editting;

@end

@interface NewTodoViewController : BaseViewController

@property (nonatomic, weak) id<NewTodoViewDelegate> delegate;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) TodoItem *todoItem;

@end
