//
//  logistTableViewCell.m
//  YunShangShiJi
//
//  Created by yssj on 15/9/19.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "logistTableViewCell.h"
#define SN ([UIScreen mainScreen].bounds.size.width)/(1080)
#define ZOOM(px) (px)*(SN)

@implementation logistTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.img.frame=CGRectMake(ZOOM(60), self.img.frame.origin.y, self.img.frame.size.width, self.img.frame.size.height);
    self.img2.frame=CGRectMake(ZOOM(85), self.img2.frame.origin.y, self.img2.frame.size.width, self.img2.frame.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
