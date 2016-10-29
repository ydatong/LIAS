//
//  NewTimerController.m
//  Mango
//
//  Created by 周永 on 16/10/28.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "TimerViewControllerNew.h"
#import "TimerCollectionCell.h"
#import "CountdownViewController.h"

@interface TimerViewControllerNew ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SGOptionDelegate,CountdownProtocol,TimerCellDelegate>
{
    NSMutableArray *timerItemList;
    NSIndexPath *detailIndexPath;//当前显示详情的cell index ，同一时间只能一个cell显示详情
}
@property (strong, nonatomic) IBOutlet UICollectionView *timerCollection;

@end

@implementation TimerViewControllerNew

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_timerCollection registerNib:[UINib nibWithNibName:@"TimerCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"timerCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    //    [[DataManager manager] deleteAllTimerItems];
    timerItemList = [NSMutableArray arrayWithCapacity:0];
    [timerItemList addObjectsFromArray:[[DataManager manager] getTimerItems]];
    [_timerCollection reloadData];
}

- (void)addNewItem {
    
    SGOption *option = [[SGOption alloc] initWithDelegate:self];
    [option show];
}

#pragma mark -- SGOption

- (NSArray*)sgOptionTitleOfOptions {
    return @[@"倒数日",@"正数日"];
}

- (void)sgOptionDidSelectAtIndex:(NSInteger)index {
    
    if (index == 0) {
        [self showCountDown];
    }else{
        [self showTimer];
    }
}

//倒数日
- (void)showCountDown {
    
    CountdownViewController *countdownVC = [[CountdownViewController alloc] initWithNibName:@"CountdownViewController" bundle:nil];
    countdownVC.delegate = self;
    [self presentViewController:countdownVC animated:YES completion:nil];
}

//正数日
- (void)showTimer {
    
}

- (void)countdownViewControllerDidConfirm:(TimerItem *)timerItem {
    [timerItemList addObject:timerItem];
    [_timerCollection reloadData];
}

#pragma mark -- UICollection Delegate & Datasource


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return timerItemList.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TimerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"timerCell" forIndexPath:indexPath];
    cell.delegate = self;
    TimerItem *item = timerItemList[indexPath.row];
    cell.item = item;
    if ((cell.type = item.timer)) {//正数日
        cell.timeLabel.text = [item.startDate formattedString:@"yyyy-MM-dd"];
        cell.titleLabel.text = [NSString stringWithFormat:@"坚持%@已经",item.title];
    }else{//倒数日
        cell.timeLabel.text = [item.endDate formattedString:@"yyyy-MM-dd"];
        cell.titleLabel.text = [NSString stringWithFormat:@"距离%@还有",item.title];
        NSTimeInterval timeInterval = [item.endDate timeIntervalSinceDate:[NSDate date]];
        NSTimeInterval totalInterval = [item.endDate timeIntervalSinceDate:item.startDate];
        cell.dayView.progress =  (totalInterval - timeInterval)/totalInterval;
        if (timeInterval > 0) {
            int intervalPerDay = 24*60*60;
            cell.daysCount = [NSString stringWithFormat:@"%d",(int)round(timeInterval/intervalPerDay)];
            cell.finished = NO;
        }else{
            cell.daysCount = @"0";
            cell.dayView.progress = 1.0;
            cell.finished = YES;
        }
    }
    return cell;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((ScreenWidth - 30)/2.0, 250);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
}


#pragma mark -- Timer Cell Delegate
//删除
-(void)timerCellDidClickedDeleteButton:(UICollectionViewCell *)cell{
    
    NSIndexPath *indexPath = [_timerCollection indexPathForCell:cell];
    TimerItem *item = timerItemList[indexPath.row];
    if ([[DataManager manager] deleteTimerItem:item]) {
        [timerItemList removeObject:item];
        [_timerCollection deleteItemsAtIndexPaths:@[indexPath]];
    }
}

////详情
//- (void)timerCellDidClickedDetailButton {
//    
//}
//
//- (void)timerCellWillShowDetail:(UICollectionViewCell *)cell {
//    if (!detailIndexPath) {
//        detailIndexPath = [_timerCollection indexPathForCell:cell];
//    }else{
//        TimerCollectionCell *cell = (TimerCollectionCell*)[_timerCollection cellForItemAtIndexPath:detailIndexPath];
//        [cell hideDetail:nil];
//        detailIndexPath = [_timerCollection indexPathForCell:cell];
//    }
//}
//
//- (void)timerCellDidHideDetail:(UICollectionViewCell *)cell {
////    detailIndexPath = nil;
//}

@end
