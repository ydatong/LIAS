//
//  SGOptions.h
//  Mango
//
//  Created by 周永 on 16/10/25.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SGOptionDelegate <NSObject>

- (NSArray*)sgOptionTitleOfOptions;
@optional
- (void)sgOptionDidSelectAtIndex:(NSInteger)index;

@end

@interface SGOption: UIView

@property (nonatomic, weak) id<SGOptionDelegate> delegate;

- (instancetype)initWithDelegate:(id)delegate;
- (void)show;

@end
