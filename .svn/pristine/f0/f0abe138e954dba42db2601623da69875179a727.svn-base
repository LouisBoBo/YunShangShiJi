//
//  PayStyleTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/7/28.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "PayStyleTableViewCell.h"

#define SN ([UIScreen mainScreen].bounds.size.width)/(1080)
#define ZOOM(px) (px)*(SN)

@implementation PayStyleTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.headimge.frame=CGRectMake(ZOOM(62), self.headimge.frame.origin.y, self.headimge.frame.size.width, self.headimge.frame.size.height);
    self.selectBtn.frame=CGRectMake(self.frame.size.width-self.selectBtn.frame.size.width-ZOOM(62), self.selectBtn.frame.origin.y, self.selectBtn.frame.size.width, self.selectBtn.frame.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}

@end
