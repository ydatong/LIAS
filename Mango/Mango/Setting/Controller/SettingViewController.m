//
//  SettingViewController.m
//  Mango
//
//  Created by 周永 on 16/10/23.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableCell.h"
#import "TabbarSortController.h"

@interface SettingViewController ()
{
    NSArray *settingData;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    [self.tableView registerNib:[UINib nibWithNibName:@"SettingTableCell" bundle:nil] forCellReuseIdentifier:@"settingCell"];
}

- (void)loadData {
    
    settingData = @[@[
                        @{@"image":@"setting_word",@"title":@"签名",@"action":@""},
                        @{@"image":@"setting_theme",@"title":@"主题",@"action":@""},
                        @{@"image":@"setting_night",@"title":@"夜间模式",@"action":@""},
//                        @{@"image":@"setting_sort",@"title":@"Tabbar顺序",@"action":@"sortTabbar"}
                        ],
                    @[
                        @{@"image":@"setting_sync",@"title":@"同步设置",@"action":@""}
                        ],
                    @[
                        @{@"image":@"setting_safe",@"title":@"密码及指纹解锁",@"action":@""}
                        ],
                    @[
                        @{@"image":@"setting_trash",@"title":@"回收站",@"action":@""}
                        ],
                    @[
                        @{@"image":@"setting_about",@"title":@"关于",@"action":@""}
                        ]
                    ];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return settingData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [settingData[section] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
    NSDictionary *info = settingData[indexPath.section][indexPath.row];
    cell.titleLabel.text = info[@"title"];
    cell.leftImageView.image = [UIImage imageNamed:info[@"image"]];
    if ([info[@"title"] isEqualToString:@"Tabbar顺序"]) {
        cell.rightLabel.hidden = NO;
        cell.rightLabel.text = @"设置后重启APP生效";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *info = settingData[indexPath.section][indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SEL selector = NSSelectorFromString(info[@"action"]);
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector];
    }
}

#pragma mark -- action 


- (void)sortTabbar {
    
    TabbarSortController *sortVC = [[TabbarSortController alloc] initWithNibName:@"TabbarSortController" bundle:nil];
    [self.navigationController pushViewController:sortVC animated:YES];
}


@end

































