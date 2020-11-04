//
//  LoginDeviceCell.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/8.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "LoginDeviceCell.h"

@implementation LoginDeviceCell

- (void)awakeFromNib {
    // Initialization code
    self.titleLabel.font = kFont6px(32);
    self.timeLabel.font = kFont6px(28);
    self.visityLabel.font = kFont6px(28);
    
    self.constraint_headImg_h.constant = ZOOM(100);
    self.constraint_headImg_w.constant = ZOOM(100);
    
}

- (void)receiveDataModel:(LoginDeviceModel *)model
{
    if (([model.device intValue] == 1)||([model.device intValue] == 2)) {
        self.headImageView.image = [UIImage imageNamed:@"登录设备手机"];
        if ([model.device intValue] == 1) {
            self.titleLabel.text = @"安卓设备";
        } else {
            self.titleLabel.text = @"iOS设备";
        }
    } else {
        self.headImageView.image = [UIImage imageNamed:@"登录设备手机"];
        self.titleLabel.text = @"网页端";
    }
    NSString *timeString = [NSString stringWithFormat:@"%lld",(long long)[model.login_time longLongValue]/1000];
    [self timeInfoWithDateString:timeString];
}

//显示时间
- (void)timeInfoWithDateString:(NSString *)timeString
{
    NSDate *oldDate = [NSDate dateWithTimeIntervalSince1970:[timeString longLongValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *showtimeNew = [formatter stringFromDate:oldDate];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@",[showtimeNew substringToIndex:16]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
