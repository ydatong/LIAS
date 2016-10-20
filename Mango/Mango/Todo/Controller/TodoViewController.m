//
//  TodoViewController.m
//  Mango
//
//  Created by 周永 on 16/10/20.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "TodoViewController.h"
#import "NewTodoView.h"

@interface TodoViewController ()

@end

@implementation TodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupUI {
    
    self.title = @"每日待办";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(addTodoItem)];
}


- (void)addTodoItem {
    
    NewTodoView *newTodoView =  [UIView loadViewFromNib:@"NewTodoView"];
    newTodoView.frame = self.view.bounds;
    [AppWindow addSubview:newTodoView];
    
}

@end
