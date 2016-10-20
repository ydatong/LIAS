//
//  UIView+Mango.m
//  Mango
//
//  Created by 周永 on 16/10/20.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "UIView+Mango.h"

@implementation UIView (Mango)

+ (id)loadViewFromNib:(NSString *)nibName  {
    return [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] lastObject];
}

@end
