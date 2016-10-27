//
//  TimerViewController.m
//  Mango
//
//  Created by 周永 on 16/10/20.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "TimerViewController.h"
#import "CountdownViewController.h"
#import "TimerTableCell.h"

@interface TimerViewController ()<UITableViewDelegate,UITableViewDataSource,SGOptionDelegate,CountdownProtocol>

{
    NSMutableArray *timerItems;
}

@property (strong, nonatomic) IBOutlet UITableView *timerTable;



@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- from super

- (void)setupUI {
    
    [_timerTable registerNib:[UINib nibWithNibName:@"TimerTableCell" bundle:nil] forCellReuseIdentifier:@"timerCell"];
}

- (void)loadData {
//    [[DataManager manager] deleteAllTimerItems];
     timerItems = [NSMutableArray arrayWithCapacity:0];
    [timerItems addObjectsFromArray:[[DataManager manager] getTimerItems]];
    [_timerTable reloadData];
}


- (void)addNewItem {
    
    SGOption *option = [[SGOption alloc] initWithDelegate:self];
    [option show];
}

#pragma mark -- SGOption

- (NSArray*)sgOptionTitleOfOptions {
    return @[@"倒数日",@"正数日"];
}

- (void)sgOptionDidSelectAtIndex:(NSInteger)index {
    
    if (index == 0) {
        [self showCountDown];
    }else{
        [self showTimer];
    }
}

//倒数日
- (void)showCountDown {
    
    CountdownViewController *countdownVC = [[CountdownViewController alloc] initWithNibName:@"CountdownViewController" bundle:nil];
    countdownVC.delegate = self;
    [self presentViewController:countdownVC animated:YES completion:nil];
}

//正数日
- (void)showTimer {
    
}

- (void)countdownViewControllerDidConfirm:(TimerItem *)timerItem {
    [timerItems addObject:timerItem];
    [_timerTable reloadData];
}

#pragma tableview delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return timerItems.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"timerCell"];
    TimerItem *item = timerItems[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.type = item.timer ? TimerCellTypeTimer : TimerCellTypeCountDown;
    cell.titleLabel.text = item.title;
    if (cell.type == item.timer) {//正数日
        
    }else{//倒数日
        NSTimeInterval timeInterval = (int)[item.endDate timeIntervalSinceDate:[NSDate date]];
        
        if (timeInterval > 0) {
            int intervalPerDay = 24*60*60;
            cell.days = [NSString stringWithFormat:@"%d",(int)round(timeInterval/intervalPerDay)];
        }else{
            cell.days = @"0";
            cell.statusImgView.hidden = NO;
            cell.statusImgView.image = [UIImage imageNamed:@"jieshu"];
        }
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                                            title:@"删除"
                                                                          handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                              [tableView setEditing:NO animated:YES];
                                                                              TimerItem *item = timerItems[indexPath.row];
                                                                              if ([[DataManager manager] deleteTimerItem:item]) {
                                                                                  [timerItems removeObject:item];
                                                                                  [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                                                              }
                                                                          }];
    
    return @[deleteAction];
}

@end
