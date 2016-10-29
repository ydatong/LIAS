//
//  SettingTableCell.h
//  Mango
//
//  Created by 周永 on 16/10/23.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *leftImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *rightLabel;

@end
