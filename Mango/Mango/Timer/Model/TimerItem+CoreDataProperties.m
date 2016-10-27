//
//  TimerItem+CoreDataProperties.m
//  Mango
//
//  Created by 周永 on 16/10/26.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "TimerItem+CoreDataProperties.h"

@implementation TimerItem (CoreDataProperties)

+ (NSFetchRequest<TimerItem *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TimerItem"];
}

@dynamic title;
@dynamic startDate;
@dynamic endDate;
@dynamic note;
@dynamic notice;
@dynamic createDate;

@end
