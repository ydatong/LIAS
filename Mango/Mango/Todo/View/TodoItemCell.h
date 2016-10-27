//
//  TodoItemCell.h
//  Mango
//
//  Created by 周永 on 16/10/22.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TodoItemCellDelegate <NSObject>

@optional
- (void)todoItemCell:(UITableViewCell*)cell didCheckFinishButton:(UIButton*)finishButton;

@end

@interface TodoItemCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *checkBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *priorityImg;
@property (strong, nonatomic) IBOutlet UIView *finishLine;

@property (weak, nonatomic) id<TodoItemCellDelegate> delegate;

@property (nonatomic, assign) BOOL finished;
@property (nonatomic, copy) NSString *priority;
@end
