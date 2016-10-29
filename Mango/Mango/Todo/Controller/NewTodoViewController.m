//
//  NewTodoViewController.m
//  Mango
//
//  Created by 周永 on 16/10/23.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "NewTodoViewController.h"

@interface NewTodoViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *todoTextField;
@property (strong, nonatomic) IBOutlet UITextView *noteTextView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sgementControl;
@property (strong, nonatomic) IBOutlet UILabel *wordLabel;
@end

@implementation NewTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title  = @"待办详情";
    
    if (_todoItem) {
        _todoTextField.text = _todoItem.todo;
        _noteTextView.text = _todoItem.notes;
        _sgementControl.selectedSegmentIndex = _todoItem.priority.intValue;
    }else{
        [_todoTextField becomeFirstResponder];
        _sgementControl.selectedSegmentIndex = TodoItemPriorityNormal;
    }
    _todoTextField.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    
    _todoTextField.layer.borderColor = MainColor.CGColor;
    _todoTextField.layer.borderWidth = 0.5;
    _todoTextField.layer.cornerRadius = 5.0;
    _todoTextField.layer.masksToBounds = YES;
    
    _noteTextView.layer.borderColor = MainColor.CGColor;
    _noteTextView.layer.borderWidth = 0.5;
    _noteTextView.layer.cornerRadius = 5.0;
    _noteTextView.layer.masksToBounds = YES;
    
    _sgementControl.tintColor = MainColor;
}

- (void)loadData {
    
}

- (IBAction)close:(id)sender {
    [_todoTextField  resignFirstResponder];
    [_noteTextView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)confirm:(id)sender {
    if (![self infoRight]) {
        return;
    }
    
    [_noteTextView resignFirstResponder];
    [_todoTextField resignFirstResponder];
    
    TodoItem *item = [[TodoItem alloc] init];
    item.todo = _todoTextField.text;
    item.notes = _noteTextView.text;
    item.calendarDate = [_date sgtimeFormattedString];
    item.priority = [NSString stringWithFormat:@"%ld",(long)_sgementControl.selectedSegmentIndex];
    item.lastEditTime = [NSString stringWithFormat:@"%.f",[[NSDate date] timeIntervalSinceReferenceDate]];
    if (!_todoItem) {
        item.createDate = [NSString stringWithFormat:@"%.f",[[NSDate date] timeIntervalSinceReferenceDate]];
    }else{
        item.createDate = _todoItem.createDate;
    }
    item.status = @"1"; //待办
    
    if (_todoItem) {
        objc_setAssociatedObject(item, "editTodo", objc_getAssociatedObject(_todoItem, "editTodo"), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(newTodoVidwDidConfirm:editting:)]) {
        [_delegate newTodoVidwDidConfirm:item editting:(_todoItem ? YES : NO)];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (BOOL)infoRight {
    if (_todoTextField.text.length == 0) {
        [self noText];
        [[AnimationBuilder defaultAnimator] addShakeAnimationToView:_todoTextField fromVertical:NO];
        return NO;
    }
    return YES;
}

- (void)noText {
    _todoTextField.layer.borderColor = [UIColor redColor].CGColor;
    _todoTextField.layer.borderWidth = 1;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.location == 0 && string.length == 0) {
        [self noText];
    }else{
        _todoTextField.layer.borderColor = MainColor.CGColor;
    }
    return YES;
}



@end
