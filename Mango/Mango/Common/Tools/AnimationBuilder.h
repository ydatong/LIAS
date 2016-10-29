//
//  AnimationBuilder.h
//  Mango
//
//  Created by 周永 on 16/10/20.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimationBuilder : NSObject

+ (instancetype)defaultAnimator;

- (void)addFallDownAnimation:(void (^)())animations
                  completion:(void(^)())completion;


/*
 shake动画
 */
- (void)addShakeAnimationToView:(UIView*)view fromVertical:(BOOL)vertical;
@end
