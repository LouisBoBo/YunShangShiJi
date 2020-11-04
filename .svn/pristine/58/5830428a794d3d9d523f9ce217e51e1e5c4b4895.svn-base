//
//  PersonCenterCell.m
//  YunShangShiJi
//
//  Created by yssj on 15/11/26.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "PersonCenterCell.h"
#import "GlobalTool.h"

@implementation PersonCenterCell

- (void)awakeFromNib {
    // Initialization code
    self.arrow = [[UIImageView alloc] init];
    self.arrow.layer.cornerRadius = ZOOMPT(4);
    self.arrow.backgroundColor = tarbarrossred;
    [self.contentView addSubview:self.arrow];
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.equalTo(self.detailLabel);
        make.width.height.mas_equalTo(ZOOMPT(8));
    }];
    
    self.arrow.hidden = YES;
    self.nameLabel.frame=CGRectMake(CGRectGetMaxX(self.headImg.frame)+ZOOM6(10), self.nameLabel.frame.origin.y, self.nameLabel.frame.size.width, self.nameLabel.frame.size.height);
    self.nameLabel.textColor=[UIColor colorWithRed:62/255.0 green:62/255.0 blue:62/255.0 alpha:1];
    self.nameLabel.font=[UIFont systemFontOfSize:ZOOM6(34)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
