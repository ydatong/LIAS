//
//  TabbarSortController.m
//  Mango
//
//  Created by 周永 on 16/10/23.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "TabbarSortController.h"
#import "SettingTableCell.h"

@interface TabbarSortController () <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *sortTable;
@property (strong, nonatomic) NSMutableDictionary *sortInfo;
@property (strong, nonatomic) NSMutableArray *tableData;
@end

@implementation TabbarSortController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray *tmp = @[
              @{@"title":@"待办",@"image":@"tabbar_todo",@"name":@"todo"},
              @{@"title":@"计划",@"image":@"tabbar_plan",@"name":@"plan"},
              @{@"title":@"记事",@"image":@"tabbar_note",@"name":@"note"},
              @{@"title":@"定时",@"image":@"tabbar_timer",@"name":@"timer"}
              ];
    _tableData = [NSMutableArray arrayWithCapacity:0];
    [_tableData addObjectsFromArray:tmp];
    _sortInfo = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:kTabbarOrderInfoKey]];
    self.navigationItem.title = @"Tabbar排序";
    [_sortTable registerNib:[UINib nibWithNibName:@"SettingTableCell" bundle:nil] forCellReuseIdentifier:@"sortCell"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting_sort"] style:UIBarButtonItemStylePlain target:self action:@selector(sort)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sortCell"];
    NSString *name = _sortInfo[[NSString stringWithFormat:@"%d",(int)indexPath.row]];
    cell.leftImageView.image = [UIImage imageNamed:[self dataOfNmae:name][@"image"]];
    cell.titleLabel.text = [self dataOfNmae:name][@"title"];
    return cell;
}

- (NSDictionary*)dataOfNmae:(NSString*)name {
    for (NSDictionary *dict in _tableData) {
        if ([dict[@"name"] isEqualToString:name]) {
            return dict;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *sourceName = _tableData[destinationIndexPath.row][@"name"];
    NSString *destinationName = _tableData[sourceIndexPath.row][@"name"];
    int sourceIndex = (int)sourceIndexPath.row;
    int desIndex = (int)destinationIndexPath.row;
    [_sortInfo setObject:destinationName forKey:[NSString stringWithFormat:@"%d",desIndex]];
    [_sortInfo setObject:sourceName forKey:[NSString stringWithFormat:@"%d",sourceIndex]];
    NSLog(@"sortInfo = %@", _sortInfo);
}

///
- (void)sort {
    if (_sortTable.isEditing) {
        [_sortTable setEditing:NO];
        [self saveToDefault];
    }else{
        [_sortTable setEditing:YES];
    }
}

/*
 tabbarOrderInfo = @{@"0":@"todo",
 @"1":@"plan",
 @"2":@"note",
 @"3":@"timer",
 @"4":@"setting"};
 */
- (void)saveToDefault {
    NSMutableDictionary *tabbarOrderInfo = [NSMutableDictionary dictionaryWithCapacity:0];
    for (int i = 0 ; i < _tableData.count; i++) {
        [tabbarOrderInfo setObject:_tableData[i][@"name"] forKey:[NSString stringWithFormat:@"%d",i]];
    }
    [tabbarOrderInfo setObject:@"setting" forKey:[NSString stringWithFormat:@"4"]];
    [[NSUserDefaults standardUserDefaults] setObject:tabbarOrderInfo forKey:kTabbarOrderInfoKey];
}


@end









