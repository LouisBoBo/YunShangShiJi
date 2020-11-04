//
//  HYJIntegralCell.h
//  YunShangShiJi
//
//  Created by hyj on 15/9/8.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalTool.h"
#import "IntegralModel.h"

@interface HYJIntegralCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *W_countLabel;

- (void)refreshWithModel:(IntegralModel *)model;
@end
