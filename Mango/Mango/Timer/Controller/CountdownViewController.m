//
//  CountdownViewController.m
//  Mango
//
//  Created by 周永 on 16/10/26.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "CountdownViewController.h"

@interface CountdownViewController ()<UITextViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *titleTxtField;
@property (strong, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (strong, nonatomic) IBOutlet UIDatePicker *endDatePicker;
@property (strong, nonatomic) IBOutlet UITextView *noteTextView;
@property (strong, nonatomic) IBOutlet UISwitch *noticeSwitch;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *startHight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *endHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *noteHeight;

@property (strong, nonatomic) IBOutlet UIScrollView *contentScroll;
@property (strong, nonatomic) IBOutlet UIView *backView;
@end

@implementation CountdownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

- (void)setupUI {
    
    if ([UIScreen mainScreen].bounds.size.height > 600) {
        _startHight.constant = 100.0;
        _endHeight.constant = 100.0;
        _noteHeight.constant = 100.0;
    }else{
        _startHight.constant = 80.0;
        _endHeight.constant = 80.0;
        _noteHeight.constant = 80.0;
    }
    _endDatePicker.minimumDate = [NSDate date];
    
    
    
    _titleTxtField.layer.borderColor = MainColor.CGColor;
    _titleTxtField.layer.borderWidth = 0.5;
    _titleTxtField.layer.cornerRadius = 5.0;
    _titleTxtField.layer.masksToBounds = YES;
    _titleTxtField.delegate = self;
    
    _noteTextView.layer.borderColor = MainColor.CGColor;
    _noteTextView.layer.borderWidth = 0.5;
    _noteTextView.layer.cornerRadius = 5.0;
    _noteTextView.layer.masksToBounds = YES;
    _noteTextView.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keybordHide)];
    [_backView addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keybordHide{
    [_titleTxtField resignFirstResponder];
    [_noteTextView resignFirstResponder];
}

- (IBAction)close:(id)sender {
    [self dismiss];
}

- (IBAction)confirm:(id)sender {
    
    [self keybordHide];
    
    if (![self infoRight]) {
        return;
    }
    
    NSMutableDictionary *timerInfo = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [timerInfo setValue:[NSDate date] forKey:@"createDate"];
    [timerInfo setValue:_titleTxtField.text forKey:@"title"];
    [timerInfo setValue:_startDatePicker.date forKey:@"startDate"];
    [timerInfo setValue:_endDatePicker.date forKey:@"endDate"];
    [timerInfo setValue:_noteTextView.text forKey:@"note"];
    [timerInfo setValue:@(_noticeSwitch.on) forKey:@"notice"];
    [timerInfo setValue:@NO forKey:@"timer"];
    
    if ([[DataManager manager] saveTimerItem:timerInfo]) {
        if (_delegate && [_delegate respondsToSelector:@selector(countdownViewControllerDidConfirm:)]) {
            [_delegate countdownViewControllerDidConfirm:[[DataManager manager] timerInfoToTimerItem:timerInfo]];
            [self dismiss];
        }
    }
}

- (BOOL)infoRight {
    
    if (_titleTxtField.text.length == 0) {
        [self noText];
        [[AnimationBuilder defaultAnimator] addShakeAnimationToView:_titleTxtField fromVertical:NO];
        return NO;
    }
    
    if ([_startDatePicker.date compare:_endDatePicker.date] != NSOrderedDescending) {
        return YES;
    }else {
        return NO;
    }
    
    return YES;
}

- (void)noText {
    _titleTxtField.layer.borderColor = [UIColor redColor].CGColor;
    _titleTxtField.layer.borderWidth = 1;
}

- (void)dismiss {
    
    [_titleTxtField resignFirstResponder];
    [_noteTextView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)keybordShow:(NSNotification*)noti {
    
    if ([_noteTextView isFirstResponder]) {
        CGRect keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        keyboardFrame = [self.view convertRect:keyboardFrame fromView:nil];
        _contentScroll.contentOffset = CGPointMake(0, keyboardFrame.size.height);
    }
}

- (void)keybordHide:(NSNotification*)noti {
    _contentScroll.contentOffset = CGPointMake(0, 0);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.location == 0 && string.length == 0) {
        [self noText];
    }else{
        _titleTxtField.layer.borderColor = MainColor.CGColor;
    }
    return YES;
}


@end
