//
//  CalendarLayout.m
//  Mango
//
//  Created by 周永 on 16/10/21.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "CalendarLayout.h"

@interface CalendarLayout()
{
    int cellCount;
}
@end

@implementation CalendarLayout


- (void)prepareLayout {
    [super prepareLayout];
    cellCount = 6*7;
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *attributes = [NSMutableArray arrayWithCapacity:0];
    
    NSIndexPath *indexPath;
    for (int i = 0 ; i < cellCount; i++) {
        indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [attributes addObject:attr];
    }
    
    return attributes;
}


- (UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat width = (ScreenWidth-10.0)/7;
    CGFloat height = self.collectionView.bounds.size.height/6;
    attr.size = CGSizeMake(width, height);
    CGFloat x = width*(indexPath.row%7);
    CGFloat y = height*(indexPath.row/7);
    attr.frame = CGRectMake(x, y, width, height);
    return attr;
}

@end









