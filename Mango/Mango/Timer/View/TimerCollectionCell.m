//
//  TimerCollectionCell.m
//  Mango
//
//  Created by 周永 on 16/10/28.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "TimerCollectionCell.h"
#import "TimerDetailView.h"

@interface TimerCollectionCell ()

{
    NSIndexPath *detailIndexpath; //当前显示详情的cell  同一时间只能有一个cell显示详情
    UIPanGestureRecognizer *panOnView;
}

@property (strong, nonatomic) IBOutlet UIButton *detailBtn;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;


@end

@implementation TimerCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.layer.borderWidth = 1.0;
    _statusImg.hidden = YES;
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    
    panOnView = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:panOnView];
    
    _detailBtn.hidden = YES;
    _deleteBtn.hidden = YES;
    
    
}


- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self layoutDigital];
}

- (void)layoutDigital {
    CGRect rect = CGRectMake(0, 0, 130,0);
    CGFloat circleR = rect.size.width/2;
    CGFloat dayWidth = rect.size.width/_daysCount.length;
    CGFloat daysHeight = 2 * circleR*sin(M_2_PI/2);
    for (int i = 0 ; i < _daysCount.length; i++) {
        UIImageView *numberImgView = [[UIImageView alloc] init];
        CGFloat x = i*dayWidth;
        CGFloat y =  circleR - circleR*sin(M_2_PI/2);
        CGFloat width = dayWidth;
        CGFloat height = daysHeight;
        numberImgView.frame = CGRectMake(x, y, width, height);
        unichar digital = [_daysCount characterAtIndex:i];
        NSString *digitalString = [NSString stringWithFormat:@"%c",digital];
        numberImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"digital_%d",[digitalString intValue]]];
        if (_daysCount.length == 1) {
            numberImgView.contentMode = UIViewContentModeCenter;
        }else if(_daysCount.length == 2 ) {
            numberImgView.contentMode = i == 0 ? UIViewContentModeRight : UIViewContentModeLeft;
        }else if(_daysCount.length % 2 == 1) {
            numberImgView.contentMode = i == _daysCount.length/2 ? UIViewContentModeCenter : (i < _daysCount.length/2 ? UIViewContentModeRight : UIViewContentModeLeft);
        }else{
            numberImgView.contentMode = i >= _daysCount.length/2 ? UIViewContentModeLeft : UIViewContentModeRight;
        }
        [_dayView addSubview:numberImgView];
    }
}

- (void)setDaysCount:(NSString *)daysCount {
    
    _daysCount = daysCount;
    
    for (UIView *subView in _dayView.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            [subView removeFromSuperview];
        }
    }
    
    [self layoutDigital];
    
}



- (void)setFinished:(BOOL)finished {
    if (_finished == finished) {
        return;
    }
    _finished = finished;
    
    if (_finished) {
        _statusImg.hidden = NO;
    }else{
        _statusImg.hidden = YES;
    }
}

- (void)pan:(UIPanGestureRecognizer*)pan {

    CGPoint tranlation = [pan translationInView:self];
    if (tranlation.x < 0 && fabs(tranlation.x) > 60  && fabs(tranlation.y) < 50) {//从右向左平滑
        
        if (pan.state == UIGestureRecognizerStateEnded) {
            
            if (_delegate && [_delegate respondsToSelector:@selector(timerCellWillShowDetail:)]) {
                [_delegate timerCellWillShowDetail:self];
            }
            [UIView animateWithDuration:0.5 animations:^{
                CATransform3D perspectiveTransform = CATransform3DIdentity;
                perspectiveTransform.m34 = 1.0 / 500;
                _backView.layer.transform = CATransform3DRotate(perspectiveTransform, M_2_PI, 0.0f, 1.0f, 0.0f);;
                _backView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
                _backView.layer.shadowOffset = CGSizeMake(10, 10);
                _backView.layer.shadowRadius = 10.0;
                _backView.center = CGPointMake(_dayView.center.x - 20.0, _dayView.center.y);
            } completion:^(BOOL finished) {
                _deleteBtn.hidden = NO;
                _detailBtn.hidden = NO;
            }];
        }
        
    }
    
    if (tranlation.x > 60  && fabs(tranlation.y) < 50) {//从左向右平滑
        if (pan.state == UIGestureRecognizerStateEnded) {
            [self hideDetail:nil];
        }
    }
    
}


- (IBAction)showDetailInfo:(id)sender {
    
    [self hideDetail:^{
        if (_delegate && [_delegate respondsToSelector:@selector(timerCellDidClickedDetailButton:)]) {
            [_delegate timerCellDidClickedDetailButton:self];
        }
        
        TimerDetailView *detail = [UIView loadViewFromNib:@"TimerDetailView"];
//        detail.frame = CGRectMake(0, -_backView.frame.size.height, _backView.frame.size.width, _backView.frame.size.height);
        detail.frame = _backView.bounds;
        detail.titleLabel.text = _item.title;
        detail.startDateLabel.text = [_item.startDate formattedString:@"yyyy-MM-dd"];
        detail.endDateLabel.text = [_item.endDate formattedString:@"yyyy-MM-dd"];
        detail.noteLabel.text = _item.note;
        [self addSubview:detail];
        
//        [UIView animateWithDuration:1 animations:^{
//            detail.frame = _backView.bounds;
//        }];
        
        UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[detail]];
        [animator addBehavior:gravity];
        
    }];
}

- (IBAction)delete:(id)sender {
    
    [self hideDetail:^{
        if (_delegate && [_delegate respondsToSelector:@selector(timerCellDidClickedDeleteButton:)]) {
            [_delegate timerCellDidClickedDeleteButton:self];
        }
    }];
}

- (void)hideDetail :(void(^)())complete{
    
    [UIView animateWithDuration:0.3 animations:^{
        _backView.center = CGPointMake(_dayView.center.x, _dayView.center.y);
        _deleteBtn.hidden = YES;
        _detailBtn.hidden = YES;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            _backView.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            if (_delegate && [_delegate respondsToSelector:@selector(timerCellDidHideDetail:)]) {
                [_delegate timerCellDidHideDetail:self];
            }
        }];
    }];
    
    if (complete) {
        complete();
    }
}

@end

