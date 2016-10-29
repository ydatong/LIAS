//
//  DataManager.m
//  Mango
//
//  Created by 周永 on 16/10/20.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "DataManager.h"
#import "AppDelegate.h"

static DataManager *manager = nil;

@interface DataManager()

@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation DataManager

+ (instancetype)manager {
    if (!manager) {
        manager = [[DataManager alloc] init];
        manager.appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        manager.context = manager.appDelegate.persistentContainer.viewContext;
    }
    
    return manager;
}



- (BOOL)saveTodoItemToDatabse:(TodoItem *)item {

    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TodoItem" inManagedObjectContext:_context];
    NSManagedObject *managedObject = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:_context];
    [managedObject setValue:item.todo forKey:@"todo"];
    [managedObject setValue:item.notes forKey:@"notes"];
    [managedObject setValue:item.createDate forKey:@"createDate"];
    [managedObject setValue:item.calendarDate forKey:@"calendarDate"];
    [managedObject setValue:item.lastEditTime forKey:@"lastEditDate"];
    [managedObject setValue:item.priority forKey:@"priority"];
    [managedObject setValue:item.status forKey:@"status"];
    [managedObject setValue:item.remindDate forKey:@"remindDate"];
    NSError *error;
    [_context save:&error];
    if (error) {
        NSLog(@"数据库存储错误:%@",error);
        return NO;
    }else{
        NSLog(@"数据库存储成功");
        return YES;
    }
}


- (NSArray*)getAllTodoItems {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TodoItem"];
    NSArray *objects = (NSArray*)[_context executeFetchRequest:request error:nil];
    NSLog(@"%@",[objects[0] valueForKey:@"todo"]);
    return [self todoItemsFromOjbects:objects];
}

/*
 object转成todoitem
 */
- (NSArray*)todoItemsFromOjbects:(NSArray*)objects {
    
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0 ; i < objects.count; i++) {
        NSManagedObject *object = objects[i];
        TodoItem *item = [[TodoItem alloc] init];
        item.todo = [object valueForKey:@"todo"];
        item.notes = [object valueForKey:@"notes"];
        item.createDate = [object valueForKey:@"createDate"];
        item.calendarDate = [object valueForKey:@"calendarDate"];
        item.lastEditTime = [object valueForKey:@"lastEditDate"];
        item.priority = [object valueForKey:@"priority"];
        item.status = [object valueForKey:@"status"];
        item.remindDate = [object valueForKey:@"remindDate"];
        [results addObject:item];
    }
    
    return results;
}
/*
获取某一天的待办事项
*/
- (NSArray*)getTodoItemsWithDate:(NSDate*)date {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TodoItem"];
    request.predicate = [NSPredicate predicateWithFormat:@"calendarDate = %@ AND status = %@",[date sgtimeFormattedString],@"1"];
    NSArray *objects = [_context executeFetchRequest:request error:nil];
    return [self todoItemsFromOjbects:objects];
}

/*
 获取某一天已完成的事项
 */
- (NSArray*)getFinishedTodoItemsWithDate:(NSDate*)date {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TodoItem"];
    request.predicate = [NSPredicate predicateWithFormat:@"calendarDate = %@ AND status = %@",[date sgtimeFormattedString],@"2"];
    NSArray *objects = [_context executeFetchRequest:request error:nil];
    return [self todoItemsFromOjbects:objects];
}

/*
 更新某一项待办事项
 */
- (BOOL)updateTodoItem:(TodoItem*)item {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TodoItem"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"createDate = %@",item.createDate];
    request.predicate = predicate;
    NSManagedObject *object = [[_context executeFetchRequest:request error:nil] firstObject];
    [object setValue:item.todo forKey:@"todo"];
    [object setValue:item.notes forKey:@"notes"];
    [object setValue:item.createDate forKey:@"createDate"];
    [object setValue:item.calendarDate forKey:@"calendarDate"];
    [object setValue:item.lastEditTime forKey:@"lastEditDate"];
    [object setValue:item.priority forKey:@"priority"];
    [object setValue:item.status forKey:@"status"];
    [object setValue:item.remindDate forKey:@"remindDate"];
    return [_context save:nil];
}

/*
 更新待办事项的完成状态
 */
- (BOOL)updateTodoItemStatus:(TodoItem*)item {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TodoItem"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"createDate = %@",item.createDate];
    request.predicate = predicate;
    NSManagedObject *object = [[_context executeFetchRequest:request error:nil] firstObject];
    [object setValue:item.status forKey:@"status"];
    return [_context save:nil];
}

/*
 删除待办事项
 */
- (BOOL)deleteTodoItem:(TodoItem*)item {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TodoItem"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"createDate = %@",item.createDate];
    request.predicate = predicate;
    NSManagedObject *object = [[_context executeFetchRequest:request error:nil] firstObject];
    [_context deleteObject:object];
    return [_context save:nil];
}



#pragma mark - Timer

- (BOOL)saveTimerItem:(NSDictionary *)timerInfo {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TimerItem" inManagedObjectContext:_context];
    TimerItem *object = (TimerItem*)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:_context];
    object.timer = [[timerInfo valueForKey:@"timer"] boolValue];
    object.title = [timerInfo valueForKey:@"title"];
    object.note = [timerInfo valueForKey:@"note"];
    object.startDate = [timerInfo valueForKey:@"startDate"];
    object.endDate = [timerInfo valueForKey:@"endDate"];
    object.createDate = [timerInfo valueForKey:@"createDate"];
    object.notice = [[timerInfo valueForKey:@"notice"] boolValue];
    return [_context save:nil];
}

- (TimerItem*)timerInfoToTimerItem:(NSDictionary*)timerInfo {
//    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TimerItem" inManagedObjectContext:_context];
    TimerItem *object = (TimerItem*)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    object.timer = [[timerInfo valueForKey:@"timer"] boolValue];
    object.title = [timerInfo valueForKey:@"title"];
    object.note = [timerInfo valueForKey:@"note"];
    object.startDate = [timerInfo valueForKey:@"startDate"];
    object.endDate = [timerInfo valueForKey:@"endDate"];
    object.createDate = [timerInfo valueForKey:@"createDate"];
    object.notice = [[timerInfo valueForKey:@"notice"] boolValue];
    return object;
}

- (NSArray*)getTimerItems{
    NSFetchRequest *request = [TimerItem fetchRequest];
    NSError *error;
    NSArray *results = [_context executeFetchRequest:request error:&error];
    return  results;
}


//- (BOOL)deleteAllTimerItems {
//
//    NSFetchRequest *request = [TimerItem fetchRequest];
//    NSArray *items = [_context executeFetchRequest:request error:nil];
//    for (int i = 0 ; i < items.count; i++) {
//        [_context deleteObject:items[i]];
//    }
//    return [_context save:nil];
//}

- (BOOL)deleteTimerItem:(TimerItem*)item {
    NSFetchRequest *request = [TimerItem fetchRequest];
    request.predicate = [NSPredicate predicateWithFormat:@"createDate = %@",item.createDate];
    TimerItem *timerItem = [[_context executeFetchRequest:request error:nil] firstObject];
    [_context deleteObject:timerItem];
    return [_context save:nil];
}

@end



































