//
//  UIFont+Ext.m
//  Mango
//
//  Created by 周永 on 16/10/22.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "UIFont+Ext.h"

@implementation UIFont (Ext)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

+ (UIFont *)boldSystemFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
}

+ (UIFont *)systemFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
}

#pragma clang diagnostic pop


@end
