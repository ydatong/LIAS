//
//  TodoItemCell.m
//  Mango
//
//  Created by 周永 on 16/10/22.
//  Copyright © 2016年 ;. All rights reserved.
//

#import "TodoItemCell.h"

@implementation TodoItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _finishLine.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)finish:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(todoItemCell:didCheckFinishButton:)]) {
        [_delegate todoItemCell:self didCheckFinishButton:sender];
    }
}


- (void)setFinished:(BOOL)finished {
    _finished = finished;
    
    if (_finished) {
        _finishLine.hidden = NO;
        [_checkBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        _titleLabel.textColor = [UIColor lightGrayColor];
    }else{
        _finishLine.hidden = YES;
        [_checkBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        _titleLabel.textColor = [UIColor blackColor];
    }
}

- (void)setPriority:(NSString *)priority {
    switch (priority.intValue) {
        case TodoItemPriorityMostImportant:
        {
            _priorityImg.image = [UIImage imageNamed:@"priority_mostimportant"];
        }
            break;
        case TodoItemPriorityImportant:
        {
            _priorityImg.image = [UIImage imageNamed:@"priority_important"];
        }
            break;
        case TodoItemPriorityNormal:
        {
            _priorityImg.image = [UIImage imageNamed:@"priority_today"];
        }
            break;
        case TodoItemPriorityLowest:
        {
            _priorityImg.image = [UIImage imageNamed:@"priority_lowest"];
        }
            break;
        default:
            break;
    }
}

@end
