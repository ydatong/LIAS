//
//  BLTextField.m
//  Mango
//
//  Created by 周永 on 16/10/27.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "BLTextField.h"

@implementation BLTextField


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CALayer *border = [CALayer layer];
    border.frame = CGRectMake(0, rect.size.height - 2, rect.size.width, 2);
    border.borderColor = MainColor.CGColor;
    self.layer.masksToBounds = YES;
    [self.layer addSublayer:border];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.borderStyle = UITextBorderStyleNone;
}



@end
