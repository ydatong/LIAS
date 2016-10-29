//
//  DataManager.h
//  Mango
//
//  Created by 周永 on 16/10/20.
//  Copyright © 2016年 shuige. All rights reserved.
//

typedef NS_ENUM(NSInteger, TodoItemPriority) {
    TodoItemPriorityMostImportant = 0,
    TodoItemPriorityImportant,
    TodoItemPriorityNormal,
    TodoItemPriorityLowest
};

typedef NS_ENUM(NSInteger, TimerItemType) {
    TimerItemTypeCountdown = 1,
    TimerItemTypeTimer
};

#pragma mark -- Key

static NSString *const kTabbarOrderNameTodo = @"todo";
static NSString *const kTabbarOrderNamePlan = @"plan";
static NSString *const kTabbarOrderNameNote = @"note";
static NSString *const kTabbarOrderNameTimer = @"timer";
static NSString *const kTabbarOrderNameSetting = @"setting";



#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TimerItem+CoreDataClass.h"

@interface DataManager : NSObject

+ (instancetype)manager;


#pragma mark -- Todo
/* 保存待办事项*/
- (BOOL)saveTodoItemToDatabse:(TodoItem*)item;

/*获取所有的待办事项*/
- (NSArray*)getAllTodoItems;

/*获取某一天的待办事项*/
- (NSArray*)getTodoItemsWithDate:(NSDate*)date;

/*获取某一天已完成的事项*/
- (NSArray*)getFinishedTodoItemsWithDate:(NSDate*)date;

/*更新待办事项*/
- (BOOL)updateTodoItem:(TodoItem*)item;

/*更新待办事项的完成状态*/
- (BOOL)updateTodoItemStatus:(TodoItem*)item;

/*删除待办事项*/
- (BOOL)deleteTodoItem:(TodoItem*)item;


#pragma mark -- Timer

/*存储计时*/

- (BOOL)saveTimerItem:(NSDictionary *)timerInfo;

/*获取所有计时*/

- (NSArray*)getTimerItems;

/*字典转模型*/
- (TimerItem*)timerInfoToTimerItem:(NSDictionary*)timerInfo;

/*删除所有计时*/
- (BOOL)deleteAllTimerItems;

/*删除计时*/
- (BOOL)deleteTimerItem:(TimerItem*)item;

@end
