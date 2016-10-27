//
//  StyleBuilder.h
//  Mango
//
//  Created by 周永 on 16/10/21.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StyleBuilder : NSObject

+ (instancetype)builder;

- (UIColor*)getColor:(NSString *)hexColor;
- (UIFont*)defaultFontWithSize:(CGFloat)fontSize;

- (UIColor*)mainColor;

@end
