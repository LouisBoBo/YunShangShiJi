//
//  PersonTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/11.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "PersonTableViewCell.h"
#import "GlobalTool.h"
@implementation PersonTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.title.font = [UIFont systemFontOfSize:ZOOM(50)];
    
    CGRect frame = self.title.frame;
    frame.origin.y = CGRectGetMaxX(self.headimg.frame)+ZOOM(40);
    self.title.frame = frame;
    
    
    CGFloat lr = (kScreenWidth/5.0-ZOOM(75))/2.0;
    
    self.constraint_headImg_left.constant = lr;
    self.constraint_moreImg_right.constant = lr;
    
    self.constraint_headImg_height.constant = ZOOM(75);
    self.constraint_headImg_width.constant = ZOOM(75);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
