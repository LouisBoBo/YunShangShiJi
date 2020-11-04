//
//  KickBackCell.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/13.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "KickBackCell.h"
@implementation KickBackCell

- (void)awakeFromNib {
    // Initialization code
    self.timeLabel.adjustsFontSizeToFitWidth = YES;
    self.orderCodeLabel.adjustsFontSizeToFitWidth = YES;
    self.moneyLabel.adjustsFontSizeToFitWidth = YES;
    self.isSucessLabel.adjustsFontSizeToFitWidth = YES;
    
    self.timeLabel.font = kFont6px(26);
    self.orderCodeLabel.font = kFont6px(28);
    self.moneyLabel.font = [UIFont systemFontOfSize:ZOOM(100)];
    self.isSucessLabel.font = kFont6px(28);
}

- (void)receiveDataModel:(KickBackModel *)model
{
    
    if ([model.is_free intValue] == 1) { //解冻
        self.backgroundColor = COLOR_ROSERED;
        self.isSucessLabel.text = @"成功";
        
        NSMutableAttributedString *mast = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"+%.2f",[model.money doubleValue]]];
        [mast addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:ZOOM(75)] range:NSMakeRange(0, 1)];
        self.moneyLabel.attributedText = mast;
        
//        self.moneyLabel.text = [NSString stringWithFormat:@"+%.1f",[model.money doubleValue]];
    } else if ([model.is_free intValue] == 0) {
        self.backgroundColor = RGBACOLOR_F(0.5, 0.5, 0.5, 0.7);
        self.isSucessLabel.text = @"冻结";
        
        NSMutableAttributedString *mast = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%.2f",[model.money doubleValue]]];
        [mast addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:ZOOM(75)] range:NSMakeRange(0, 1)];
        self.moneyLabel.attributedText = mast;
//        self.moneyLabel.text = [NSString stringWithFormat:@"¥%.1f",[model.money doubleValue]];
    }
    //时间
    self.timeLabel.text = [self calculationSecFor1970:[model.add_date longLongValue]/1000.0];
    self.orderCodeLabel.text = [NSString stringWithFormat:@"订单号%@",model.order_code];
}

#pragma mark - 计算一个日期与1970计算日期
- (NSString *)calculationSecFor1970:(long long)theDate
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd  HH:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:theDate];
    NSString *showtimeNew = [dateFormatter stringFromDate:date];
    return showtimeNew;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
