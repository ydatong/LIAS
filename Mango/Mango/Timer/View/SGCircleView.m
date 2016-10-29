//
//  SGCircleView.m
//  Mango
//
//  Created by 周永 on 16/10/28.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "SGCircleView.h"

@implementation SGCircleView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CAShapeLayer *circleLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect)) radius:rect.size.width/2 startAngle:0 endAngle:2*M_PI clockwise:YES];
    circleLayer.path = path.CGPath;
    circleLayer.lineWidth = 5.0;
    circleLayer.strokeColor = [UIColor groupTableViewBackgroundColor].CGColor;
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:circleLayer];
    
    _progressLayer = [CAShapeLayer layer];
    UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect)) radius:rect.size.width/2 startAngle:-M_PI_2 endAngle:-M_PI_2 + _progress*M_PI*2 clockwise:YES];
    _progressLayer.path = progressPath.CGPath;
    _progressLayer.lineWidth = 5.0;
    _progressLayer.strokeColor = [[StyleBuilder builder] getColor:@"#00bb9c"].CGColor;
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:_progressLayer];
    
    [self showProgress];
}

- (void)showProgress {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 2.0;
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [_progressLayer addAnimation:animation forKey:@"strokeEnd"];

}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    CGRect rect = self.bounds;
    
    UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect)) radius:rect.size.width/2 startAngle:-M_PI_2 endAngle:-M_PI_2 + _progress*M_PI*2 clockwise:YES];
    _progressLayer.path = progressPath.CGPath;
    _progressLayer.lineWidth = 5.0;
    _progressLayer.strokeColor = [[StyleBuilder builder] getColor:@"#00bb9c"].CGColor;
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.path = progressPath.CGPath;
}


@end
