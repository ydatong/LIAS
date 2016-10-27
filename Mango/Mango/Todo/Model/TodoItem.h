

//
//  TodoItem.h
//  Mango
//
//  Created by 周永 on 16/10/21.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoItem : NSObject

@property (nonatomic, copy) NSString *todo;             //待办
@property (nonatomic, copy) NSString *notes;            //备注
@property (nonatomic, copy) NSString *priority;         //优先级
@property (nonatomic, copy) NSString *status;           //完成状态(已完成，未完成)

@property (nonatomic, copy) NSString *createDate;       //创建时间
@property (nonatomic, copy) NSString *calendarDate;     //格式化时间（用来数据库查找） 2016/10/22
@property (nonatomic, copy) NSString *lastEditTime;     //最后编辑时间
@property (nonatomic, copy) NSString *remindDate;       //提醒时间

@end
