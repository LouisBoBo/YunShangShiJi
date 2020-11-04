//
//  ReportTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/20.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "ReportTableViewCell.h"

@implementation ReportTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headimage.frame = CGRectMake(self.headimage.frame.origin.x, (ZOOM6(80)-CGRectGetHeight(self.headimage.frame))/2, CGRectGetWidth(self.headimage.frame), CGRectGetHeight(self.headimage.frame));

    self.title.frame = CGRectMake(self.title.frame.origin.x, (ZOOM6(80)-CGRectGetHeight(self.title.frame))/2, CGRectGetWidth(self.title.frame), CGRectGetHeight(self.title.frame));
    
}

- (void)refreshView:(ReportModel*)model
{
    self.title.textColor = RGBCOLOR_I(125, 125, 125);
    self.title.font = [UIFont systemFontOfSize:ZOOM6(24)];
    self.title.text = model.title;
    self.headimage.image=[model.is_select isEqualToString:@"选中"]?[UIImage imageNamed:@"icon_dapeigou_celect"]:[UIImage imageNamed:@"icon_dapeigou_normal"];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
