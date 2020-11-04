//
//  PreferredMoreTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/4/23.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "PreferredMoreTableViewCell.h"
#import "GlobalTool.h"
@implementation PreferredMoreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshTitle:(NSString*)title
{
   
    self.headlab.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.Preferredlab.text = title;
    self.Preferredlab.textColor = kTitleColor;
    self.Preferredlab.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.Preferredlab.textAlignment = NSTextAlignmentCenter;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
