//
//  TimerItem+CoreDataProperties.h
//  Mango
//
//  Created by 周永 on 16/10/26.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "TimerItem+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TimerItem (CoreDataProperties)

+ (NSFetchRequest<TimerItem *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSDate *startDate;
@property (nullable, nonatomic, copy) NSDate *endDate;
@property (nullable, nonatomic, copy) NSString *note;
@property (nonatomic) BOOL notice;
@property (nullable, nonatomic, copy) NSDate *createDate;

@end

NS_ASSUME_NONNULL_END
