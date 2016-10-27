//
//  AnimationBuilder.m
//  Mango
//
//  Created by 周永 on 16/10/20.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "AnimationBuilder.h"

static AnimationBuilder *defaultAnimator = nil;
static const NSTimeInterval kAnimationDuration = 0.5;

@interface AnimationBuilder()

@end

@implementation AnimationBuilder

+ (instancetype)defaultAnimator {
    if (!defaultAnimator) {
        defaultAnimator = [[AnimationBuilder alloc] init];
    }
    
    return defaultAnimator;
}


/*
 view下落动画
 */
- (void)addFallDownAnimation:(void (^)())animations completion:(void(^)())completion{
    
    [UIView animateWithDuration:kAnimationDuration
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:animations completion:nil];
    
}


- (void)addShakeAnimationToView:(UIView*)view fromVertical:(BOOL)vertical{
    
    CABasicAnimation  *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    shake.duration = 0.2;
    shake.repeatCount = 2;
    shake.autoreverses = YES;
    if (vertical) {
        shake.fromValue = [NSValue valueWithCGPoint:CGPointMake(view.center.x, view.center.y + 3)];
        shake.toValue = [NSValue valueWithCGPoint:CGPointMake(view.center.x, view.center.y - 3)];
    }else{
        shake.fromValue = [NSValue valueWithCGPoint:CGPointMake(view.center.x + 3, view.center.y)];
        shake.toValue = [NSValue valueWithCGPoint:CGPointMake(view.center.x - 3, view.center.y)];
    }
    [view.layer addAnimation:shake forKey:@""];
}


@end
