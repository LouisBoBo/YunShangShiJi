//
//  HBcardCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/1/27.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "HBcardCell.h"
#import "GlobalTool.h"
@implementation HBcardCell

- (void)awakeFromNib {
    // Initialization code
    
    self.money.font = [UIFont systemFontOfSize:ZOOM(120)];
    self.money.adjustsFontSizeToFitWidth = YES;
    self.title.font = FONT_40;
    self.time.font = [UIFont systemFontOfSize:ZOOM(30)];
    
    self.frame = CGRectMake(0, 0, kScreenWidth, 100);
    
    self.backimage.frame = CGRectMake(self.backimage.frame.origin.x, self.backimage.frame.origin.y, kScreenWidth-20, self.backimage.frame.size.height);
    
    self.money.frame = CGRectMake(self.money.frame.origin.x, self.money.frame.origin.y, ZOOM(200*3.4), self.money.frame.size.height);
    
    self.title.frame = CGRectMake(self.title.frame.origin.x, self.title.frame.origin.y, ZOOM(200*3.4), self.title.frame.size.height);
    
    self.time.frame = CGRectMake(self.backimage.frame.size.width-ZOOM(92*3.4), self.time.frame.origin.y, ZOOM(100*3.4), self.time.frame.size.height);
    
}
- (void)receiveDataModel:(MyCardModel *)model
{
    
    self.title.clipsToBounds = YES;
    self.time.clipsToBounds = YES;
    self.backimage.clipsToBounds = YES;
    
    self.money.textAlignment = NSTextAlignmentCenter;
    self.title.textAlignment = NSTextAlignmentCenter;
    self.time.textAlignment = NSTextAlignmentCenter;
    
    
    NSString *timeStr = [NSString stringWithFormat:@"%lld",[model.c_last_time longLongValue]/1000];
    
    NSString *time = [self timeInfoWithDateString:timeStr];
    

    if ([self isInvalid:time] == NO && [model.is_use intValue] == 1) {
        self.backimage.image = [UIImage imageNamed:@"优惠劵-有效"];
        self.money.textColor = [UIColor whiteColor];
        self.time.textColor = tarbarrossred;
        self.title.textColor = [UIColor whiteColor];
        
    } else {
        self.backimage.image = [UIImage imageNamed:@"优惠劵-失效"];
        self.money.textColor = [UIColor whiteColor];
        self.time.textColor = kTextColor;
        self.title.textColor = [UIColor whiteColor];
        
    }
    
    self.money.text = [NSString stringWithFormat:@"%@元",model.c_price];
    
    self.time.text = [NSString stringWithFormat:@"有效期至/%@",[time substringToIndex:10]];
    self.title.text = [NSString stringWithFormat:@"【订单满%@可用】",model.c_cond];
    
    if ([model.c_type intValue] == 1) {
        self.title.text = [NSString stringWithFormat:@"现金劵[满减]"];
    } else if ([model.c_type intValue] == 2) {
        self.title.text = [NSString stringWithFormat:@"H5店铺专用劵[满减]"];
    } else if ([model.c_type intValue] == 3) {
        self.title.text = [NSString stringWithFormat:@"APP店铺专用劵[满减]"];
    } else if ([model.c_type intValue] == 4) {
        self.title.text = [NSString stringWithFormat:@"积分换取劵[满减]"];
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
