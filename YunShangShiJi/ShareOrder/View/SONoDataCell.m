//
//  SONoDataCell.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/6.
//  Copyright © 2016年 ios-1. All rights reserved.
//  无数据时

#import "SONoDataCell.h"

@implementation SONoDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.text = @"暂无评论！";
        self.textLabel.textColor = [UIColor colorWithRed:152/255. green:152/255. blue:152/255. alpha:1.];
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
