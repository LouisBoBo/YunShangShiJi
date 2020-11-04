//
//  CollectTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/15.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "CollectTableViewCell.h"

@implementation CollectTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];

    // Configure the view for the selected state
}

@end
