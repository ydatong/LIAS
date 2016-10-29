//
//  SGOptions.m
//  Mango
//
//  Created by 周永 on 16/10/25.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "SGOptions.h"

@interface SGOption ()<UITableViewDelegate,UITableViewDataSource>

{
    NSArray *titles;
    UITableView *optionTable;
}

@end

@implementation SGOption


- (instancetype)initWithDelegate:(id)delegate {
    
    if (self = [super init]) {
        self.delegate = delegate;
        if (self.delegate && [self.delegate respondsToSelector:@selector(sgOptionTitleOfOptions)]) {
            titles = [self.delegate sgOptionTitleOfOptions];
        }
        [self setup];
    }
    
    return self;
}


- (void)setup {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    self.frame = keyWindow.frame;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    optionTable = [[UITableView alloc] initWithFrame:CGRectMake(screenWidth - 110, 65, 100, titles.count*44.0) style:UITableViewStylePlain];
    optionTable.delegate = self;
    optionTable.dataSource = self;
    optionTable.layer.borderColor = [UIColor grayColor].CGColor;
    optionTable.layer.borderWidth = 1.0;
    optionTable.scrollEnabled = NO;
    optionTable.layer.borderColor = [UIColor whiteColor].CGColor;
    [self setupBorder];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}

- (void)setupBorder {
    
    CAShapeLayer *mask = [[CAShapeLayer alloc] init];
//    mask.frame = optionTable.bounds;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGFloat width = 100;
    CGFloat height = titles.count*44 + 10;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat x = screenWidth - 110;
    CGFloat y = 55;
    [path moveToPoint:CGPointMake(x, y + 10)];
    [path addLineToPoint:CGPointMake(x, y + height)];
    [path addLineToPoint:CGPointMake(x + width,y + height)];
    [path addLineToPoint:CGPointMake(x + width, y + 10)];
    [path addLineToPoint:CGPointMake(x +width - 10,y + 10)];
    [path addLineToPoint:CGPointMake(x +width - 20,y)];
    [path addLineToPoint:CGPointMake(x +width - 30,y + 10)];
    [path addLineToPoint:CGPointMake(x, y + 10)];
    [path closePath];
    path.lineWidth = 3.0;
    mask.path = path.CGPath;
    mask.fillColor = [UIColor whiteColor].CGColor;
    mask.strokeColor = [UIColor grayColor].CGColor;
    mask.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:mask];
    
    [self addSubview:optionTable];
    
}

- (void)tap:(UITapGestureRecognizer*)tap {
    if (!CGRectContainsPoint(optionTable.frame, [tap locationInView:self])) {
        [self dismiss];
    }else{
        CGPoint point = [tap locationInView:optionTable];
        NSIndexPath *indexPath = [optionTable indexPathForRowAtPoint:point];
        [self tableView:optionTable didSelectRowAtIndexPath:indexPath];
    }
}

- (void)show {
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
}

- (void)dismiss {
    [self removeFromSuperview];
}

#pragma mark --


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titles.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"optionCell"];
    cell.textLabel.text = titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(sgOptionDidSelectAtIndex:)]) {
        [_delegate sgOptionDidSelectAtIndex:indexPath.row];
        [self dismiss];
    }
}


@end
