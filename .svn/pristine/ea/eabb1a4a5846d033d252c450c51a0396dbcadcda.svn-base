//
//  HYJIntegralCell.m
//  YunShangShiJi
//
//  Created by hyj on 15/9/8.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "HYJIntegralCell.h"
#import "MyMD5.h"

@implementation HYJIntegralCell

- (void)awakeFromNib {
    // Initialization code
    
    self.timeLabel.textColor = kTextColor;
    self.countLabel.textColor = tarbarrossred;
    
    self.countLabel.font= [UIFont systemFontOfSize:ZOOM(100)];
    self.W_countLabel.constant = ZOOM(337);
}

- (void)refreshWithModel:(IntegralModel *)model
{
    int count = [model.count intValue];
    
    if (count>=0) {
        _countLabel.text = [NSString stringWithFormat:@"+%@",model.count];
    } else {
        _countLabel.text = [NSString stringWithFormat:@"%@",model.count];
    }
    //1签到2购物3做任务4分享5别人点击其分享的链接,6退回积分0其他
    NSInteger type = model.desc.integerValue;
    NSArray *arr = @[@"其他",@"签到",@"购物",@"做任务",@"分享",@"别人点击其分享的链接",@"退回积分",@"官方奖励/补贴积分"];
    _descLabel.text = [NSString stringWithFormat:@"%@",arr[type]];
    
    _timeLabel.text = [MyMD5 getTimeToShowWithTimestamp:model.time];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
