//
//  TomorrowTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/10/31.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TomorrowTableViewCell.h"
#import "GlobalTool.h"
@implementation TomorrowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.baseView.frame = CGRectMake(10, 0, CGRectGetWidth(self.frame)-19.5, CGRectGetHeight(self.baseView.frame));
    
    self.backview.layer.cornerRadius = 5;
    self.backview.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    
    self.superlab.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.tixianlab.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.mustlab.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.extralab.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.extrareward.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.discripLab.font = [UIFont systemFontOfSize:ZOOM6(30)];
    
    self.discripLab.numberOfLines = 0;
    self.discripLab.textColor = tarbarrossred;
    self.superlab.textColor = RGBCOLOR_I(125, 125, 125);
    self.tixianlab.textColor = RGBCOLOR_I(125, 125, 125);
    self.mustlab.textColor = RGBCOLOR_I(125, 125, 125);
    self.extralab.textColor = RGBCOLOR_I(125, 125, 125);
    self.extrareward.textColor = RGBCOLOR_I(125, 125, 125);
    
}

-(void)refreshData:(NSMutableArray*)dataArray;
{
    NSString *s1 = @"0";
    NSString *s2 = @"0";
    NSString *s3 = @"0";
    NSString *s4 = @"0";
    NSString *s5 = @"50";
    
    int i=0;int j =0;int k =0;int l=0;
    for (TaskModel *model in dataArray) {
        if(model.task_class.intValue ==1)
        {
            i++;
        }
        if(model.task_class.intValue ==2)
        {
            j++;
        }
        if(model.task_class.intValue ==6)
        {
            k++;
        }
        if(model.task_class.intValue ==4)
        {
            l++;
        }

    }
    s1 = [NSString stringWithFormat:@"%d",i];
    s2 = [NSString stringWithFormat:@"%d",j];
    s3 = [NSString stringWithFormat:@"%d",k];
    s4 = [NSString stringWithFormat:@"%d",l];
    
    
    self.superlab.text = [NSString stringWithFormat:@"超级惊喜任务%@个",s3];
    NSMutableAttributedString *mu1 = [[NSMutableAttributedString alloc]initWithString:self.superlab.text];
    [mu1 addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(6, s3.length)];
    [self.superlab setAttributedText:mu1];

    self.tixianlab.text = [NSString stringWithFormat:@"惊喜提现任务%@个",s4];
    NSMutableAttributedString *mu2 = [[NSMutableAttributedString alloc]initWithString:self.tixianlab.text];
    [mu2 addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(6, s4.length)];
    [self.tixianlab setAttributedText:mu2];
    
    self.mustlab.text = [NSString stringWithFormat:@"必做任务%@个",s1];
    NSMutableAttributedString *mu3 = [[NSMutableAttributedString alloc]initWithString:self.mustlab.text];
    [mu3 addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(4, s1.length)];
    [self.mustlab setAttributedText:mu3];
    
    self.extralab.text = [NSString stringWithFormat:@"额外任务%@个",s2];
    NSMutableAttributedString *mu4 = [[NSMutableAttributedString alloc]initWithString:self.extralab.text];
    [mu4 addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(4, s2.length)];
    [self.extralab setAttributedText:mu4];
    
    if(s1.intValue == 0 && s2.intValue == 0 && s3.intValue == 0 && s4.intValue == 0)
    {
        s5 = @"0";
    }
    self.extrareward.text = [NSString stringWithFormat:@"最高奖励%@元",s5];
    NSMutableAttributedString *mu5 = [[NSMutableAttributedString alloc]initWithString:self.extrareward.text];
    [mu5 addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(4, s5.length)];
    [self.extrareward setAttributedText:mu5];
    
    self.discripLab.text = @"每天坚持来，完成本月全部赚钱任务，最高能得到1000元现金奖励哦。加油吧！";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
