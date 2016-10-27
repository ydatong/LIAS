//
//  TodoViewController.m
//  Mango
//
//  Created by 周永 on 16/10/20.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "TodoViewController.h"
#import "MangoCalendar.h"
#import "TodoItemCell.h"
#import "NewTodoViewController.h"

@interface TodoViewController() <NewTodoViewDelegate,UITableViewDelegate,UITableViewDataSource,MangoCalendarDelegate,TodoItemCellDelegate>{
    NSMutableArray *completedList;
    NSMutableArray *todoList;
    
    NSDate *currentDate;
    MangoCalendar *mangoCalendar;
    
    UIView *emptyTableContentView;
    UIView *headerView;
}

@property (strong, nonatomic) IBOutlet UIView *calendar;
@property (strong, nonatomic) IBOutlet UITableView *todoTableView;
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
    
    self.navigationItem.title = @"每日待办";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add"]
//                                                                              style:UIBarButtonItemStylePlain
//                                                                             target:self
//                                                                             action:@selector(addTodoItem)];
    
    mangoCalendar = [UIView loadViewFromNib:@"MangoCalendar"];
    mangoCalendar.frame = _calendar.frame;
    mangoCalendar.delegate = self;
    [_calendar addSubview:mangoCalendar];
    
    [_todoTableView registerNib:[UINib nibWithNibName:@"TodoItemCell" bundle:nil] forCellReuseIdentifier:@"TodoCell"];
    
}

- (void)loadData {
    
    todoList = [NSMutableArray arrayWithCapacity:0];
    completedList = [NSMutableArray arrayWithCapacity:0];
    currentDate = [NSDate date];
    [todoList addObjectsFromArray:[[DataManager manager] getTodoItemsWithDate:[NSDate date]]];
    [completedList addObjectsFromArray:[[DataManager manager] getFinishedTodoItemsWithDate:[NSDate date]]];
    [_todoTableView reloadData];
}


#pragma mark -- UITableView Delegate & Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (todoList.count == 0 && completedList.count == 0) {
        [self configureEmptyTable];
    }else{
        _todoTableView.backgroundView = nil;
    }
    
    return section == 0 ? todoList.count : completedList.count;
}

- (void)configureEmptyTable{

    EmptyTableContentView *emptyView = [UIView loadViewFromNib:@"EmptyTableContentView"];
    emptyView.imageView.image = [UIImage imageNamed:@"fightting"];
    emptyView.descriptionLabel.text = @"种一棵树最好的时间是十年前，其次是现在!";
    self.todoTableView.backgroundView = emptyView;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TodoItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoCell"];
    cell.delegate = self;
    TodoItem *item = indexPath.section == 0 ? todoList[indexPath.row] : completedList[indexPath.row];
    cell.titleLabel.text = item.todo;
    cell.finished = indexPath.section == 0 ? NO : YES;
    cell.priority = item.priority;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TodoItem *item = indexPath.section == 0 ? todoList[indexPath.row] : completedList[indexPath.row];
    objc_setAssociatedObject(item, "editTodo", indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self showNewTodoView:item];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 32)];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
//    imageView.contentMode = UIViewContentModeScaleToFill;
//    imageView.image = section == 0 ? [UIImage imageNamed:@"corner_todo"] : [UIImage imageNamed:@"corner_finished"];
//    [headerView addSubview:imageView];
//    return headerView;
//}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                                            title:@"删除"
                                                                          handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                              [tableView setEditing:NO animated:YES];
                                                                              TodoItem *item = indexPath.section == 0 ? todoList[indexPath.row] : completedList[indexPath.row];
                                                                              if ([[DataManager manager] deleteTodoItem:item]) {
                                                                                  if (indexPath.section == 0) {
                                                                                      [todoList removeObjectAtIndex:indexPath.row];
                                                                                  }else{
                                                                                      [completedList removeObjectAtIndex:indexPath.row];
                                                                                  }
                                                                                  [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                                                                  [mangoCalendar.calendarView reloadData];
                                                                              }
    }];
    
    return @[deleteAction];
}

#pragma mark -- todo cell delegate

- (void)todoItemCell:(TodoItemCell *)cell didCheckFinishButton:(UIButton *)finishButton {
    
    NSIndexPath *indexPath = [_todoTableView indexPathForCell:cell];
    if (indexPath.section == 0) {
        cell.finished = YES;
        TodoItem *item = todoList[indexPath.row];
        item.status = @"2";
        //更新数据库
        if ([[DataManager manager] updateTodoItemStatus:item]) {
            [completedList insertObject:item atIndex:0];
            [todoList removeObjectAtIndex:indexPath.row];
            [_todoTableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
            [mangoCalendar.calendarView reloadData];
        }
    }else{
        cell.finished = NO;
        TodoItem *item = completedList[indexPath.row];
        item.status = @"1";
        //更新数据库
        if ([[DataManager manager] updateTodoItemStatus:item]) {
            [todoList insertObject:item atIndex:0];
            [completedList removeObjectAtIndex:indexPath.row];
            [_todoTableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [[DataManager manager] updateTodoItemStatus:item];
            [mangoCalendar.calendarView reloadData];
        }
    }
}


#pragma mark -- button clicked

- (void)addNewItem {
    
    [self showNewTodoView:nil];
}

- (void)showNewTodoView:(TodoItem*)todoItem {
    
    NewTodoViewController *newTodoVC = [[NewTodoViewController alloc] initWithNibName:@"NewTodoViewController" bundle:nil];
    newTodoVC.delegate = self;
    newTodoVC.date =currentDate;
    newTodoVC.todoItem = todoItem;
    [self presentViewController:newTodoVC animated:YES completion:nil];
}

#pragma mark -- NewTodoViewDelegate

- (void)newTodoVidwDidConfirm:(TodoItem *)todoItem  editting:(BOOL)editting{
    
    if (editting) {
        NSIndexPath *indexPath = objc_getAssociatedObject(todoItem, "editTodo");
        if (indexPath.section == 0) {
            if ([[DataManager manager] updateTodoItem:todoItem]) {
                [todoList replaceObjectAtIndex:indexPath.row withObject:todoItem];
            }
        }else{
            if ([[DataManager manager] updateTodoItem:todoItem]) {
                [completedList removeObjectAtIndex:indexPath.row];
                [todoList insertObject:todoItem atIndex:0];
            }
        }
    }else{
        if ([[DataManager manager] saveTodoItemToDatabse:todoItem]) {
            [todoList addObject:todoItem];
        }
    }
    CalendarCell *cell = [mangoCalendar calendarCellForDate:[NSDate dateWithTimeIntervalSinceReferenceDate:todoItem.calendarDate.doubleValue]];
    cell.markStatus = CalendarCellMarkStatusUnFinished;
    [_todoTableView reloadData];
    [mangoCalendar.calendarView reloadData];
}


#pragma mark -- calendar delegate

- (void)mangoCalendarDidSelectDate:(NSDate *)date atCell:(CalendarCell*)cell{
    
    currentDate = date;
    [todoList removeAllObjects];
    [completedList removeAllObjects];
    [todoList addObjectsFromArray:[[DataManager manager] getTodoItemsWithDate:currentDate]];
    [completedList addObjectsFromArray:[[DataManager manager] getFinishedTodoItemsWithDate:currentDate]];
    [_todoTableView reloadData];
}



@end






























