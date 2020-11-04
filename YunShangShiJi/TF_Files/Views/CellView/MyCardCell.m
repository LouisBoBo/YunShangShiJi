//
//  MyCardCell.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/18.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "MyCardCell.h"

@implementation MyCardCell

- (void)awakeFromNib {
    // Initialization code
    
    [self bringSubviewToFront:self.moneyLabel];
    
    self.moneyLabel.font = kFont6px(62);
    self.moneyLabel.adjustsFontSizeToFitWidth = YES;
    self.detailLabel.font = kFont6px(28);
    self.dayLabel.font = kFont6px(28);
    self.explainLabel.font = kFont6px(28);
    
    self.Constraint_Height_MoneyLabel.constant = ZOOM(360);
    
}

- (void)receiveDataModel:(MyCardModel *)model
{
    NSString *timeStr = [NSString stringWithFormat:@"%lld",[model.c_last_time longLongValue]/1000];
    
    NSString *time = [self timeInfoWithDateString:timeStr];
    
//    //time = %@",time);
    if ([self isInvalid:time] == NO && [model.is_use intValue] == 1) {
        self.bgImageView.image = [UIImage imageNamed:@"有效劵"];
        self.dayLabel.textColor = COLOR_ROSERED;
        self.detailLabel.textColor = RGBCOLOR_I(22,22,22);
        self.explainLabel.textColor = RGBCOLOR_I(22,22,22);
        self.bgView.layer.masksToBounds = YES;
        self.bgView.layer.borderWidth = 1;
        self.bgView.layer.borderColor = [COLOR_ROSERED CGColor];
    } else {
        self.bgImageView.image = [UIImage imageNamed:@"失效券"];
        self.dayLabel.textColor = RGBCOLOR_I(220,220,220);
        self.detailLabel.textColor = RGBCOLOR_I(220,220,220);
        self.explainLabel.textColor = RGBCOLOR_I(220,220,220);
        self.bgView.layer.masksToBounds = YES;
        self.bgView.layer.borderWidth = 1;
        self.bgView.layer.borderColor = [RGBCOLOR_I(220,220,220) CGColor];
    }
    
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",model.c_price];
    
    self.dayLabel.text = [NSString stringWithFormat:@"有效期至 %@",[time substringToIndex:10]];
    self.explainLabel.text = [NSString stringWithFormat:@"满%@可用",model.c_cond];
    if ([model.c_type intValue] == 1) {
        self.detailLabel.text = [NSString stringWithFormat:@"现金劵[满减]"];
    } else if ([model.c_type intValue] == 2) {
        self.detailLabel.text = [NSString stringWithFormat:@"H5店铺专用劵[满减]"];
    } else if ([model.c_type intValue] == 3) {
        self.detailLabel.text = [NSString stringWithFormat:@"APP店铺专用劵[满减]"];
    } else if ([model.c_type intValue] == 4) {
        self.detailLabel.text = [NSString stringWithFormat:@"积分换取劵[满减]"];
    }
    
}

//显示时间
- (NSString *)timeInfoWithDateString:(NSString *)timeString
{
    NSDate *oldDate = [NSDate dateWithTimeIntervalSince1970:[timeString longLongValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *showOldDate = [formatter stringFromDate:oldDate];
    
    return showOldDate;
}

- (BOOL)isInvalid:(NSString *)timeStr
{
    NSDate *curDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *showCurDate = [formatter stringFromDate:curDate];
    
    int currYear = [[showCurDate substringToIndex:4] intValue];
    int oldYear = [[timeStr substringToIndex:4] intValue];
    
    int currMonth = [[showCurDate substringWithRange:NSMakeRange(5, 2)] intValue];
    int oldMonth = [[timeStr substringWithRange:NSMakeRange(5, 2)] intValue];
    
    int currDay = [[showCurDate substringWithRange:NSMakeRange(8, 2)] intValue];
    int oldDay = [[timeStr substringWithRange:NSMakeRange(8, 2)] intValue];
    
    int currHour = [[showCurDate substringWithRange:NSMakeRange(11, 2)] intValue];
    int oldHour = [[timeStr substringWithRange:NSMakeRange(11, 2)] intValue];
    
    int currMin = [[showCurDate substringWithRange:NSMakeRange(14, 2)] intValue];
    int oldMin = [[timeStr substringWithRange:NSMakeRange(14, 2)] intValue];
    
    if (currYear != oldYear) {
        if (currYear>oldYear) {
            return YES;
        } else {
            return NO;
        }
    } else if (currYear == oldYear&&currMonth!=oldMonth) {
        if (currMonth>oldMonth) {
            return YES;
        } else {
            return NO;
        }
    } else if (currYear == oldYear&&currMonth==oldMonth&&currDay!=oldDay) {
        if (currDay>oldDay) {
            return YES;
        } else {
            return NO;
        }
    } else if (currYear == oldYear&&currMonth==oldMonth&&currDay==oldDay&&currHour!=oldHour) {
        if (currHour>oldHour) {
            return YES;
        } else {
            return NO;
        }

    } else if (currYear == oldYear&&currMonth==oldMonth&&currDay==oldDay&&currHour==oldHour&&currMin!=oldMin) {
        if (currMin>oldMin) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return YES;
    }
    
    return YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
