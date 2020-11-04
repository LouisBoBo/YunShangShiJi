//
//  TaskTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/10/12.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TaskTableViewCell.h"
#import "GlobalTool.h"
#import "MyMD5.h"
@implementation TaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.baseView.frame = CGRectMake(10, 0, CGRectGetWidth(self.frame)-19.5, CGRectGetHeight(self.baseView.frame));
    
    self.titleimage.frame = CGRectMake(CGRectGetMinX(self.titleimage.frame), CGRectGetMinY(self.titleimage.frame), 50, 50);
    
    self.titlelable.textColor = RGBCOLOR_I(125, 125, 125);
    self.titlelable.font = [UIFont systemFontOfSize:ZOOM6(28)];
    self.extraLab.font = [UIFont systemFontOfSize:ZOOM6(20)];
    
//    self.priceLab.frame = CGRectMake(CGRectGetWidth(self.backView.frame)-ZOOM6(120)-20, self.priceLab.frame.origin.y, ZOOM6(135), self.priceLab.frame.size.height);
    self.priceLab.font = [UIFont systemFontOfSize:ZOOM6(24)];
    self.priceLab.numberOfLines = 0;
}

-(void)refreshData:(TaskModel*)model Data:(NSMutableArray*)dataArr ValueData:(NSMutableArray*)valueArray;
{
    self.MydataArray = dataArr;
    self.valueArray = valueArray;
    
    //已完成的任务
    if(model.isfinish == YES && model.task_type.intValue !=1)
    {
        [self getFinishImage:model];
    }else{
        //未完成的任务
        [self getTitleImage:model];
    }
}
#pragma mark 完成的任务
- (void)getFinishImage:(TaskModel*)model
{
    NSString *tasktype = model.task_type;
    
    [self creatUI:model.t_name TaskModel:model];
    
    self.titleimage.frame = CGRectMake(CGRectGetMinX(self.titleimage.frame), CGRectGetMinY(self.titleimage.frame), 50, 50);
    self.titleimage.image= [UIImage imageNamed:model.imagestr];
    self.titlelable.text = [NSString stringWithFormat:@"%@",model.t_name];
    
    self.finisgImg.image = [UIImage imageNamed:@"task-icon_completed"];
    self.finisgImg.hidden = NO;
    self.priceLab.textColor = RGBCOLOR_I(213, 213, 213);
    self.moreimage.hidden = YES;

    if(tasktype.intValue == 4 || tasktype.intValue == 5)
    {
        self.titleimage.frame = CGRectMake(CGRectGetMinX(self.titleimage.frame), 5, 50, 50);
        if(model.shopImage.length > 10)
        {
            [self.titleimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.shopImage]]];
        }else{
            self.titleimage.image = [UIImage imageNamed:@"newtask_icon_liulan"];
        }
        
        self.titlelable.text = [NSString stringWithFormat:@"继续%@",model.t_name];
        self.moreimage.hidden = NO;
    }else if (tasktype.intValue == 9)
    {
        self.finisgImg.image = [UIImage imageNamed:@"task_yilingqu"];
    }else if (tasktype.intValue == 16)
    {
        self.moreimage.hidden = NO;
        self.priceLab.textColor = tarbarrossred;
        NSString *namess = [NSString stringWithFormat:@"继续%@",model.t_name];
        self.titlelable.text = model.task_class.intValue==4?@"集赞赢提现":namess;
        self.finisgImg.image = [UIImage imageNamed:@"icon_jxyq"];
        
    }else if (tasktype.intValue == 18)//开团
    {
        if(self.orderStatus == 0)
        {
            self.finisgImg.image = [UIImage imageNamed:@"fight_已开团"];
        }else if (self.orderStatus == 1)
        {
            self.finisgImg.image = [UIImage imageNamed:@"task-icon_completed"];
        }
    }
    else if (tasktype.intValue == 17)//参团
    {
        self.finisgImg.image = [UIImage imageNamed:@"fight_已参与"];
    }else if (tasktype.intValue == 23){
        self.finisgImg.image = [UIImage imageNamed:@"task_icon_over"];
    }
}

#pragma mark 任务类型
- (void)getTitleImage:(TaskModel*)model
{
    [self creatUI:model.t_name TaskModel:model];
    
    self.titleimage.frame = CGRectMake(CGRectGetMinX(self.titleimage.frame), CGRectGetMinY(self.titleimage.frame), 50, 50);
    self.titleimage.image= [UIImage imageNamed:model.imagestr];
    self.titlelable.text = model.t_name;

    if(model.task_type.intValue == 9 || model.task_type.intValue == 24)
    {
        self.buyImage.frame = CGRectMake(63, 0, 101, 23);
        self.buyImage.image = [UIImage imageNamed:@"task-200+"];
    }else if(model.task_type.intValue == 6){
        self.buyImage.frame = CGRectMake(63, 0, 101, 23);
        if(model.task_class.intValue == 4)
        {
            self.buyImage.frame = CGRectMake(63, 0, 161, 23);
            self.buyImage.image = [UIImage imageNamed:@"new_paopao"];
        }else if (model.task_class.intValue == 2)
        {
            self.buyImage.frame = CGRectMake(63, 0, 171, 23);
            self.buyImage.image = [UIImage imageNamed:@"goumai_paopao"];
        }
        else
        self.buyImage.image = [UIImage imageNamed:@"task-200+"];
    }else if (model.task_type.intValue == 999)
    {
        self.buyImage.frame = self.mondaytype==Mondytype_YES?CGRectMake(53, 0, 161, 23):CGRectMake(63, 0, 101, 23);
        self.buyImage.image = self.mondaytype==Mondytype_YES?[UIImage imageNamed:@"mandy_100%z"]:[UIImage imageNamed:@"task-200+"];
    }
}

#pragma mark 奖励类型
- (void)rewardType:(TaskModel*)model
{
    NSString *t_id = model.t_id;
    NSString *task_id = @"";
    NSString *type_id = @"";
    NSString *value   = @"";
    
    for(NSDictionary *taskdic in _MydataArray)
    {
        task_id = [NSString stringWithFormat:@"%@",taskdic[@"t_id"]];
        if([t_id isEqualToString:task_id])
        {
            type_id = [NSString stringWithFormat:@"%@",taskdic[@"type_id"]];
            value   = [NSString stringWithFormat:@"%@",taskdic[@"value"]];
            self.value = value;
            
            [self getRewardtype:type_id RewardValue:value TaskModel:model];
            
            break;
        }
    }
}
#pragma mark 夺宝商品
- (void)duobaoRewardType:(TaskModel*)model
{
    NSString *value   = @"";
    for(NSDictionary *shopdic in self.valueArray)
    {
        NSString *taskid = [NSString stringWithFormat:@"%@",shopdic[@"id"]];
        if(taskid.intValue == 28 && model.task_type.intValue == 2)
        {
            value = [NSString stringWithFormat:@"%@",shopdic[@"value"]];
            self.value = value;
    
            break;
        }else if (taskid.intValue == 33 && model.task_type.intValue == 21)
        {
            value = [NSString stringWithFormat:@"%@",shopdic[@"value"]];
            self.value = value;
            
            break;
        }else if (taskid.intValue == 35 && model.task_type.intValue == 22)
        {
            value = [NSString stringWithFormat:@"%@",shopdic[@"value"]];
            self.value = value;
            
            break;
        }else if (taskid.intValue == 36 && model.task_type.intValue == 27)
        {
            value = [NSString stringWithFormat:@"%@",shopdic[@"value"]];
            self.value = value;
            
            break;
        }else if (taskid.intValue == 37 && model.task_type.intValue == 30)
        {
            value = [NSString stringWithFormat:@"%@",shopdic[@"value"]];
            self.value = value;
            
            break;
        }else if (taskid.intValue == 38 && model.task_type.intValue == 31)
        {
            value = [NSString stringWithFormat:@"%@",shopdic[@"value"]];
            self.value = value;
            
            break;
        }else if (taskid.intValue == 66 && model.task_type.intValue == 32)
        {
            value = [NSString stringWithFormat:@"%@",shopdic[@"value"]];
            self.value = value;
            
            break;
        }
    }
}

- (void)getRewardtype:(NSString*)type_id RewardValue:(NSString*)value TaskModel:(TaskModel*)model
{
    NSString *namestr = @"";
    NSString *valustr = @"";
    
    if(model.task_class.intValue == 4)
    {
        if(value.length>0)
        {
            if(model.task_type.intValue == 19 || model.task_type.intValue == 20)
            {
                value = [NSString stringWithFormat:@"%f",value.floatValue*model.num.intValue];
            }else{
                NSMutableString *vvss = [NSMutableString stringWithString:value];
                value = [vvss stringByReplacingOccurrencesOfString:@"," withString:@"-"];
            }
        }
    }else{
        value = [NSString stringWithFormat:@"%f",value.floatValue*model.num.intValue];
    }
    
    NSMutableString *sss = [NSMutableString stringWithFormat:@"%@",value];
    NSArray *arr = [sss componentsSeparatedByString:@"."];
    if(arr.count >= 2)
    {
        if([arr[1] intValue] > 0)
        {
            value =  [NSString stringWithFormat:@"%.2f",value.floatValue];
        }else{
            value =  [NSString stringWithFormat:@"%.1f",value.floatValue];
        }
    }
    
    switch (type_id.intValue) {
        case 1://补签卡
            valustr = [NSString stringWithFormat:@"%.1f",[value floatValue]];
            namestr = [NSString stringWithFormat:@"+%@元",valustr];

            break;
        case 2://0元疯抢
            
            break;
        case 3://优惠券
            
            valustr = [NSString stringWithFormat:@"%d",[value intValue]];
            namestr = [NSString stringWithFormat:@"+%@元\n优惠劵",valustr];
            self.priceLab.textAlignment = NSTextAlignmentCenter;
            
            break;
        case 4://积分
            valustr = [NSString stringWithFormat:@"%d",[value intValue]];
            namestr = [NSString stringWithFormat:@"+%@\n积分",valustr];
            self.priceLab.textAlignment = NSTextAlignmentCenter;
            
            break;
        case 5://现金
            
            valustr = [NSString stringWithFormat:@"%.1f",[value floatValue]];
            namestr = [NSString stringWithFormat:@"+%.1f元",[value floatValue]];
            
            if (model.task_type.intValue == 16)
            {
                valustr = [NSString stringWithFormat:@"%.1f",[self.fxqd floatValue]];
                namestr = [NSString stringWithFormat:@"+%.1f元\n提现额度",[valustr floatValue]];
            }

            break;
        case 6://开店奖励
            valustr = [NSString stringWithFormat:@"%.1f",[value floatValue]];
            namestr = [NSString stringWithFormat:@"+%@元",valustr];
            break;
        case 7://夺宝
            
            if(value.intValue == 5)
            {
                namestr = @"vivo+\nOPPO";
            }else if (value.intValue == 3)
            {
                namestr = @"iPhone7";
            }
            valustr = namestr;
            
            break;
        case 8://余额翻倍
            
            break;
        case 9://积分升级金币
            
            break;
        case 10://优惠券升级金券
            
            break;
        case 11:
            valustr = [NSString stringWithFormat:@"%d",value.intValue];
            namestr = [NSString stringWithFormat:@"+%d个衣豆",valustr.intValue];

            break;
        case 12://提现额度
            
            valustr = [NSString stringWithFormat:@"%d",value.intValue];
            self.priceLab.textAlignment = NSTextAlignmentCenter;
            if(model.task_class.intValue == 4)
            {
                valustr = model.task_type.intValue==6?@"2-60":value;
                NSString *ss = model.task_type.intValue==6?@"随机提现额度":@"提现额度";
                namestr = [NSString stringWithFormat:@"+%@元\n%@",valustr,ss];
            }else if (model.task_class.intValue == 2)
            {
                valustr = model.task_type.intValue==6?@"3-20":value;
                NSString *ss = model.task_type.intValue==6?@"随机提现额度":@"提现额度";
                namestr = [NSString stringWithFormat:@"+%@元\n%@",valustr,ss];
            }else if (model.task_type.intValue == 16)
            {                
                valustr = [NSString stringWithFormat:@"%.1f",[self.fxqd floatValue]];
                namestr = [NSString stringWithFormat:@"+%.1f元\n随机提现额度",[valustr floatValue]];
            }
            else{
                namestr = [NSString stringWithFormat:@"+%@元\n提现额度",valustr];
            }
            
            break;
  
        case 13:
            valustr = [NSString stringWithFormat:@"%@",@"9块9"];
            namestr = [NSString stringWithFormat:@"%@\n两件包邮",valustr];
            
            break;
      
        default:
            break;
    }
    
    self.priceLab.text = namestr;
    NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:self.priceLab.text];
    if(type_id.intValue == 7)
    {
        [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(30)] range:NSMakeRange(0, valustr.length)];
    }else{
        
        [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(48)] range:NSMakeRange(1, valustr.length)];
    }
    
    [self.priceLab setAttributedText:mutable];

}

- (void)creatUI:(NSString*)title TaskModel:(TaskModel*)model
{
    if(model.task_type.intValue == 2 || model.task_type.intValue == 21 || model.task_type.intValue == 22 || model.task_type.intValue == 27 || model.task_type.intValue == 30 || model.task_type.intValue == 31 || model.task_type.intValue == 32)
    {
        [self duobaoRewardType:model];
    }else{
        [self rewardType:model];
    }
    
    if(self.value !=nil && self.value.length > 0)
    {
        self.priceLab.hidden = NO;
    }else{
        self.mondaytype==Mondytype_NO?self.priceLab.hidden = YES:0;
    }
    
    self.priceLab.frame = CGRectMake(CGRectGetWidth(self.backView.frame)-ZOOM6(120)-20, self.priceLab.frame.origin.y, ZOOM6(135), self.priceLab.frame.size.height);
    
    if(model.task_type.intValue == 1)
    {
        self.extraLab.hidden = NO;
        
        CGFloat XX = CGRectGetMinX(self.titlelable.frame)+[self getRowWidth:title fontSize:ZOOM6(34)];
        self.extraLab.frame = CGRectMake(XX , CGRectGetMinY(self.titlelable.frame), 80, CGRectGetHeight(self.titlelable.frame));
        self.extraLab.text = @"奖励不封顶";
        self.extraLab.textColor = tarbarrossred;
        
        if(model.isfinish == YES)
        {
            self.finisgImg.hidden = NO;
            self.finisgImg.image = [UIImage imageNamed:@"icon_jxyq"];
        }
        
    }else if(model.task_type.intValue == 2 || model.task_type.intValue == 22)
    {
        self.priceLab.frame = CGRectMake(CGRectGetWidth(self.backView.frame)-ZOOM6(140)-20, self.priceLab.frame.origin.y, ZOOM6(155), self.priceLab.frame.size.height);
        self.priceLab.text = self.value;
        if(self.priceLab.text !=nil && ![self.priceLab.text isEqual:[NSNull null]])
        {
            NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:self.priceLab.text];
            [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(36)] range:NSMakeRange(0, self.priceLab.text.length)];
            [self.priceLab setAttributedText:mutable];
        }
    }
    else if (model.task_type.intValue == 6)
    {
        self.titlelable.textColor = RGBCOLOR_I(125, 125, 125);
        
        self.extraLab.hidden = NO;
        CGFloat XX = CGRectGetMinX(self.titlelable.frame)+[self getRowWidth:title fontSize:ZOOM6(34)];
        self.extraLab.frame = CGRectMake(XX, CGRectGetMinY(self.titlelable.frame), 80, CGRectGetHeight(self.titlelable.frame));
        self.extraLab.textColor = [UIColor whiteColor];

        if(model.isfinish == YES)
        {
            if(model.task_class.intValue == 3)
            {
                self.backView.backgroundColor = RGBCOLOR_I(226, 226, 226);
            }
            self.moreimage.image = [UIImage imageNamed:@"task-icon_go"];
        }
        
        if(model.task_class.intValue == 3)
        {
            self.priceLab.text = @"+600元";
            NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:self.priceLab.text];
            [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(48)] range:NSMakeRange(1, 3)];
            [self.priceLab setAttributedText:mutable];
                        
        }else if (model.task_class.intValue == 2){
            self.priceLab.frame = CGRectMake(CGRectGetWidth(self.backView.frame)-ZOOM6(140)-20, self.priceLab.frame.origin.y, ZOOM6(155), self.priceLab.frame.size.height);
        }
        else if (model.task_class.intValue == 4)
        {
            self.titlelable.textColor = tarbarrossred;
            self.titlelable.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(28)];
            self.priceLab.frame = CGRectMake(CGRectGetWidth(self.backView.frame)-ZOOM6(140)-20, self.priceLab.frame.origin.y, ZOOM6(155), self.priceLab.frame.size.height);
            
            NSString * valustr = @"2-60";
            NSString * ss =@"随机提现额度";
            self.priceLab.text = [NSString stringWithFormat:@"+%@元\n%@",valustr,ss];
            if(self.priceLab.text.length)
            {
                NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:self.priceLab.text];
                
                [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(48)] range:NSMakeRange(1, valustr.length)];
                
                [self.priceLab setAttributedText:mutable];
            }
        }
    }else if (model.task_type.intValue == 9)
    {
        self.extraLab.hidden = NO;
        CGFloat XX = CGRectGetMinX(self.titlelable.frame)+[self getRowWidth:title fontSize:ZOOM6(34)];
        self.extraLab.frame = CGRectMake(XX, CGRectGetMinY(self.titlelable.frame), 80, CGRectGetHeight(self.titlelable.frame));
        self.extraLab.textColor = RGBCOLOR_I(125, 125, 125);
    }else if (model.task_type.intValue == 15)
    {
        self.priceLab.hidden = YES;
    }else if (model.task_type.intValue == 16)
    {
         self.priceLab.frame = CGRectMake(CGRectGetWidth(self.backView.frame)-ZOOM6(140)-10, self.priceLab.frame.origin.y, ZOOM6(155), self.priceLab.frame.size.height);
    }else if (model.task_type.intValue == 18)
    {
        self.priceLab.frame = CGRectMake(CGRectGetWidth(self.backView.frame)-ZOOM6(140)-20, self.priceLab.frame.origin.y, ZOOM6(155), self.priceLab.frame.size.height);
        self.priceLab.text = @"2件9.9元";
    
        NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:self.priceLab.text];
        [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(48)] range:NSMakeRange(0, 1)];
        [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(48)] range:NSMakeRange(2, 3)];
        [self.priceLab setAttributedText:mutable];

    }else if (model.task_type.intValue == 17)
    {
        self.priceLab.hidden = YES;
    }else if (model.task_type.intValue == 20)
    {
       self.priceLab.frame = CGRectMake(CGRectGetWidth(self.backView.frame)-ZOOM6(120)-20, self.priceLab.frame.origin.y, ZOOM6(135), self.priceLab.frame.size.height);
    }
    else if (model.task_type.intValue == 21)
    {
        self.priceLab.frame = CGRectMake(CGRectGetWidth(self.backView.frame)-ZOOM6(140)-20, self.priceLab.frame.origin.y, ZOOM6(155), self.priceLab.frame.size.height);
        self.priceLab.text = [NSString stringWithFormat:@"+%@元\n提现额度",self.value];
        
        if(self.priceLab.text.length)
        {
            NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:self.priceLab.text];
            
            [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(48)] range:NSMakeRange(1, self.value.length)];
            
            [self.priceLab setAttributedText:mutable];
        }

    }else if (model.task_type.intValue == 23)
    {
        self.titlelable.textColor = tarbarrossred;
        self.titlelable.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(28)];
        
        self.priceLab.frame = CGRectMake(CGRectGetWidth(self.backView.frame)-ZOOM6(150)-20, self.priceLab.frame.origin.y, ZOOM6(165), self.priceLab.frame.size.height);
        self.priceLab.text = @"+1000元";
        
        NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:self.priceLab.text];
        [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(48)] range:NSMakeRange(1, 4)];
        [self.priceLab setAttributedText:mutable];
    }else if(model.task_type.intValue == 24){
    
        self.titlelable.textColor = [UIColor redColor];
        self.titlelable.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(28)];
        
//        self.priceLab.frame = CGRectMake(CGRectGetWidth(self.backView.frame)-ZOOM6(150)-20, self.priceLab.frame.origin.y, ZOOM6(165), self.priceLab.frame.size.height);
//        self.priceLab.text = @"";
//        NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:self.priceLab.text];
//        [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(48)] range:NSMakeRange(1, 3)];
//        [self.priceLab setAttributedText:mutable];
    }else if (model.task_type.intValue == 25){
        self.value = @"50.0";
        self.priceLab.frame = CGRectMake(CGRectGetWidth(self.backView.frame)-ZOOM6(140)-20, self.priceLab.frame.origin.y, ZOOM6(155), self.priceLab.frame.size.height);
        self.priceLab.text = [NSString stringWithFormat:@"+%.1f元\n提现额度",self.value.floatValue];
        
        if(self.priceLab.text.length)
        {
            NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:self.priceLab.text];
            
            [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(48)] range:NSMakeRange(1, self.value.length)];
            
            [self.priceLab setAttributedText:mutable];
        }

    } else if (model.task_type.intValue == 26)
    {
        self.priceLab.frame = CGRectMake(CGRectGetWidth(self.backView.frame)-ZOOM6(140)-20, self.priceLab.frame.origin.y, ZOOM6(155), self.priceLab.frame.size.height);
        if(model.raward_false !=nil)
        {
            self.priceLab.text = model.raward_false;
        }else{
            if([self taskrawardHttp:@"去抽奖"])
            {
                self.priceLab.text = [self taskrawardHttp:@"去抽奖"];
                model.raward_false = self.priceLab.text;

            }else{
                self.priceLab.text = @"+500元";
            }
        }
        
        if(self.priceLab.text.length > 2)
        {
            NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:self.priceLab.text];
            [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(48)] range:NSMakeRange(1, self.priceLab.text.length-2)];
            [self.priceLab setAttributedText:mutable];
        }
    }else if (model.task_type.intValue == 27)
    {
        self.priceLab.frame = CGRectMake(CGRectGetWidth(self.backView.frame)-ZOOM6(140)-20, self.priceLab.frame.origin.y, ZOOM6(155), self.priceLab.frame.size.height);
        self.priceLab.text = [NSString stringWithFormat:@"+%@元\n随机提现额度",self.value];
        
        if(self.priceLab.text.length)
        {
            NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:self.priceLab.text];
            
            [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(48)] range:NSMakeRange(1, self.value.length)];
            
            [self.priceLab setAttributedText:mutable];
        }
    }else if (model.task_type.intValue == 28)
    {
        self.titlelable.textColor = [UIColor redColor];
        self.titlelable.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(30)];
        
        self.priceLab.frame = CGRectMake(CGRectGetWidth(self.backView.frame)-ZOOM6(140)-20, self.priceLab.frame.origin.y, ZOOM6(135), self.priceLab.frame.size.height);
        self.priceLab.text = @"美衣白送\n全额返现";
        
        if(self.priceLab.text.length)
        {
            NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:self.priceLab.text];
            [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(26)] range:NSMakeRange(0, self.priceLab.text.length)];
            [self.priceLab setAttributedText:mutable];
        }
    }else if (model.task_type.intValue == 30)
    {
        NSString *str = @"150";
        if(self.value)
        {
            NSArray *strArr = [self.value componentsSeparatedByString:@"元"];
            if(strArr.count == 2)
            {
                str = strArr[0];
            }
        }

        self.titlelable.textColor = [UIColor redColor];
        self.titlelable.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(30)];
        
        self.priceLab.frame = CGRectMake(CGRectGetWidth(self.backView.frame)-ZOOM6(140)-20, self.priceLab.frame.origin.y, ZOOM6(155), self.priceLab.frame.size.height);
        self.priceLab.text = [NSString stringWithFormat:@"+%@元/人",str];
        
        if(self.priceLab.text.length)
        {
            NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:self.priceLab.text];
            
            [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(40)] range:NSMakeRange(1, str.length)];
            
            [self.priceLab setAttributedText:mutable];
        }

    }else if (model.task_type.intValue == 31)
    {
        NSString *str = @"50";
        if(self.value)
        {
            NSArray *strArr = [self.value componentsSeparatedByString:@"元"];
            if(strArr.count == 2)
            {
                str = strArr[0];
            }
        }
        self.priceLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(30)];
        self.priceLab.frame = CGRectMake(CGRectGetWidth(self.backView.frame)-ZOOM6(130)-20, self.priceLab.frame.origin.y, ZOOM6(155), self.priceLab.frame.size.height);
        self.priceLab.text = [NSString stringWithFormat:@"%@元\n可提现",str];
    }else if (model.task_type.integerValue == 32)
    {
        self.priceLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(30)];
        self.priceLab.frame = CGRectMake(CGRectGetWidth(self.backView.frame)-ZOOM6(140)-20, self.priceLab.frame.origin.y, ZOOM6(140), self.priceLab.frame.size.height);
        self.priceLab.text = [NSString stringWithFormat:@"%@元",self.value];
    }
    else if (model.task_type.intValue == 999)
    {
        self.titlelable.textColor = [UIColor redColor];
        self.titlelable.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(28)];
        
        self.extraLab.hidden = NO;
        CGFloat XX = CGRectGetMinX(self.titlelable.frame)+[self getRowWidth:title fontSize:ZOOM6(34)];
        self.extraLab.frame = CGRectMake(XX, CGRectGetMinY(self.titlelable.frame), 80, CGRectGetHeight(self.titlelable.frame));
        self.extraLab.textColor = [UIColor whiteColor];
        
        if(model.isfinish == YES)
        {
            self.backView.backgroundColor = RGBCOLOR_I(226, 226, 226);
            self.moreimage.image = [UIImage imageNamed:@"task-icon_go"];
        }
        
        if(model.task_class.intValue == 3)
        {
            self.priceLab.frame = CGRectMake(CGRectGetWidth(self.backView.frame)-ZOOM6(160)-20, self.priceLab.frame.origin.y, ZOOM6(175), self.priceLab.frame.size.height);
            self.priceLab.font = [UIFont systemFontOfSize:ZOOM6(24)];
            NSString *rawardstr = @"";
            
            if(model.raward_false !=nil)
            {
                rawardstr = model.raward_false;
            }else{
                rawardstr = [self taskrawardHttp:@"疯狂新衣节"];
                model.raward_false = rawardstr;
            }

            NSRange range;
            NSRange centrange;
            if(model.value.intValue <= 0)
            {
                self.priceLab.text = [NSString stringWithFormat:@"%@中奖\n%@",@"100%",rawardstr];
                range = [self.priceLab.text rangeOfString:@"100%中奖"];
                
            }else{
                NSString *countstr = [NSString stringWithFormat:@"剩余%@次",model.value];
                self.priceLab.text = [NSString stringWithFormat:@"%@\n%@",countstr,rawardstr];
                
                range = [self.priceLab.text rangeOfString:countstr];
            }
            
            if(range.length >0)
            {
                NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:self.priceLab.text];
                [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(30)] range:NSMakeRange(0, range.length)];
                [self.priceLab setAttributedText:mutable];
            }

            if(model.value.intValue <= 0)
            {
                centrange= [self.priceLab.text rangeOfString:@"100%"];
                NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:self.priceLab.text];
                [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(36)] range:NSMakeRange(0, centrange.length)];
                [self.priceLab setAttributedText:mutable];
            }
        }
    }
}

- (NSString*)taskrawardHttp:(NSString*)strtype
{
    NSString *textstr = @"";
    
    NSString *URL= [NSString stringWithFormat:@"%@paperwork/paperwork.json",[NSObject baseURLStr_Upy]];
    NSURL *httpUrl=[NSURL URLWithString:URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpUrl];
    request.timeoutInterval = 3;
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            if(responseObject[@"cjjxrwqcj"] != nil && [strtype isEqualToString:@"去抽奖"])
            {
                if(responseObject[@"cjjxrwqcj"][@"text"] != nil)
                {
                    NSString *str0 = responseObject[@"cjjxrwqcj"][@"text"];
                    textstr = [NSString stringWithFormat:@"+%@元",str0];
                }
            }else if (responseObject[@"fkxyjmchjl"] != nil && [strtype isEqualToString:@"疯狂新衣节"]){
                if(responseObject[@"fkxyjmchjl"][@"t1"] != nil)
                {
                    NSString *str0 = responseObject[@"fkxyjmchjl"][@"t1"];
                    textstr = str0;
                }
            }else if (responseObject[@"fxqd"] != nil && [strtype isEqualToString:@"集赞"])
            {
                NSString *str0 = responseObject[@"fxqd"][@"text"];
                textstr = str0;
            }
        }
    }
    
    return textstr;
}

-(CGFloat)getRowWidth:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat width;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(kScreenWidth, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        width=rect.size.width;
    }
    else{
        
    }
    return width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
