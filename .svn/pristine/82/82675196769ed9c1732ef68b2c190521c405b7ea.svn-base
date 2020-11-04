//
//  TradAndDrawalCell.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/10.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TradAndDrawalCell.h"
@implementation TradAndDrawalCell

- (void)awakeFromNib {
    // Initialization code
    
//    self.titleLabel.adjustsFontSizeToFitWidth = YES;
//    self.timeLabel.adjustsFontSizeToFitWidth = YES;
//    self.moneyLabel.adjustsFontSizeToFitWidth = YES;
//    self.typeLabel.adjustsFontSizeToFitWidth = YES;
    
    self.timeLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
    self.typeLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
    self.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    self.moneyLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    
    self.moneyLabel.textColor = COLOR_ROSERED;
}

- (void)receiveDataModel:(AccountDetailModel *)model
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSNumber *UID = [ud objectForKey:USER_ID];
    
    NSString *uid = [NSString stringWithFormat:@"%@",UID];
    NSString *user_id = [NSString stringWithFormat:@"%@",model.user_id];
    NSString *s_user_id = [NSString stringWithFormat:@"%@",model.s_user_id];

    //时间
    self.timeLabel.text = [self calculationSecFor1970:[model.add_time longLongValue]/1000.0];
    NSString *typeStr;
    
    NSString *money = [NSString stringWithFormat:@"%@", model.money];
    NSString *money_temp;
    
    //把金额转换
    if ([money hasPrefix:@"-"]) {
        money_temp = [money substringFromIndex:1];
    } else {
        money_temp = money;
    }
    
//    MyLog(@"money = %@",money);
    
    if ([model.type intValue] == 1) { //购物
        typeStr = @"支付";
        self.moneyLabel.text = [NSString stringWithFormat:@"%.2f",[money_temp doubleValue]];
        self.titleLabel.text = [NSString stringWithFormat:@"订单号%@",model.order_code];
    } else if ([model.type intValue] == 2) {  //用户转账
        NSString *pay_user = [model.pay_user substringFromIndex:model.pay_user.length-4];
        typeStr = @"转账";
        if ([uid isEqualToString:user_id]) { //发起方
            self.moneyLabel.text = [NSString stringWithFormat:@"-%.2f",[money_temp doubleValue]];
        } else if ([uid isEqualToString:s_user_id]){ //接收方
            self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        }
        self.titleLabel.text = [NSString stringWithFormat:@"%@***%@",model.name,pay_user];
    } else if ([model.type intValue] == 3) { //提现
        NSString *pay_user = [model.pay_user substringFromIndex:model.pay_user.length-4];
        if (self.index == 0) {
            typeStr = @"提现";
        }
        self.moneyLabel.text = [NSString stringWithFormat:@"-%.2f",[money_temp doubleValue]];
        self.titleLabel.text = [NSString stringWithFormat:@"%@***%@",model.name,pay_user];
    } else if ([model.type intValue] == 4) { //充值
        NSString *pay_user = [model.pay_user substringFromIndex:model.pay_user.length-4];
        typeStr = @"充值";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = [NSString stringWithFormat:@"%@***%@",model.name,pay_user];
    } else if ([model.type intValue] == 5) { //返现
        typeStr = @"提现额度";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
//        self.titleLabel.text = [NSString stringWithFormat:@"订单号%@",model.order_code];
        self.titleLabel.text = @"邀请好友奖励";
    } else if ([model.type intValue] == 6) { //二级回佣
        typeStr = @"回佣";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = [NSString stringWithFormat:@"订单号%@",model.order_code];
    } else if ([model.type intValue] == 7) { //供应商回佣
        typeStr = @"回佣";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = [NSString stringWithFormat:@"订单号%@",model.order_code];
    } else if ([model.type intValue] == 8) { //退款
//        if (self.index == 0) {
//            typeStr = @"退款";
//        } else if (self.index == 2) {
//            typeStr = @"成功";
//        }
        typeStr = @"退款成功";
        self.moneyLabel.text = [NSString stringWithFormat:@"%.2f",[money_temp doubleValue]];
        self.titleLabel.text = [NSString stringWithFormat:@"订单号%@",model.order_code];
    } else if ([model.type intValue] == 9) { //供应商转账给用户
        NSString *pay_user = [model.pay_user substringFromIndex:model.pay_user.length-4];
        typeStr = @"转账";
        if ([uid isEqualToString:user_id]) { //发起方
            self.moneyLabel.text = [NSString stringWithFormat:@"-%.2f",[money_temp doubleValue]];
        } else if ([uid isEqualToString:s_user_id]){ //接收方
            self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        }
        self.titleLabel.text = [NSString stringWithFormat:@"%@***%@",model.name,pay_user];
    } else if ([model.type intValue] == 10) { //用户转账给供应商
        NSString *pay_user = [model.pay_user substringFromIndex:model.pay_user.length-4];
        typeStr = @"转账";
        if ([uid isEqualToString:user_id]) { //发起方
            self.moneyLabel.text = [NSString stringWithFormat:@"-%.2f",[money_temp doubleValue]];
        } else if ([uid isEqualToString:s_user_id]){ //接收方
            self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        }
        self.titleLabel.text = [NSString stringWithFormat:@"%@***%@",model.name,pay_user];
    } else if ([model.type intValue] == 11) { //供应商互转
        typeStr = @"转账";
        if ([uid isEqualToString:user_id]) { //发起方
            self.moneyLabel.text = [NSString stringWithFormat:@"-%.2f",[money_temp doubleValue]];
        } else if ([uid isEqualToString:s_user_id]){ //接收方
            self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        }
        self.titleLabel.text = [NSString stringWithFormat:@"%@%@",model.name,model.pay_user];
    } else if ([model.type intValue] == 12) {
        if (self.index == 0) {
            typeStr = @"提现";
        }
        NSString *pay_user = [model.pay_user substringFromIndex:model.pay_user.length-4];
        self.moneyLabel.text = [NSString stringWithFormat:@"-%.2f",[money_temp doubleValue]];
        self.titleLabel.text = [NSString stringWithFormat:@"%@***%@",model.name,pay_user];
    }else if ([model.type intValue] == 13)//三级回佣
    {
        typeStr = @"已到账";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = [NSString stringWithFormat:@"订单号%@",model.order_code];
    }
    else if ([model.type intValue] == 16) {   //发红包
        typeStr = @"发红包";
        self.moneyLabel.text = [NSString stringWithFormat:@"-%.2f",[money_temp doubleValue]];
        self.titleLabel.text = [NSString stringWithFormat:@"订单号%@",model.order_code];
    } else if ([model.type intValue] == 17) {
        typeStr = @"抢红包";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = [NSString stringWithFormat:@"订单号%@",model.order_code];
    } else if ([model.type intValue] == 18) {
        typeStr = @"免费红包";
        self.moneyLabel.text = [NSString stringWithFormat:@"%.2f",[money_temp doubleValue]];
        self.titleLabel.text = [NSString stringWithFormat:@"订单号%@",model.order_code];
    } else if ([model.type intValue] == 19||[model.type intValue] == 40) {
        typeStr = [model.type intValue] == 40?@"H5签到":@"余额";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"任务余额奖励";
    } else if ([model.type intValue] == 20){
        typeStr = @"提现退款";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = [NSString stringWithFormat:@"提现单号%@",model.order_code];

    } else if ([model.type intValue] == 30 )
    {
        typeStr = @"分享";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"分享额外奖励";
        
    }else if ([model.type intValue] == 31)
    {
        typeStr = @"奖励";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"签到额外奖励";
        
    }else if ([model.type intValue] == 32)
    {
        typeStr = @"奖励";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"粉丝奖励";
        
    }
    else if ([model.type intValue] == 33)
    {
        typeStr = @"返现";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"免付返现";

    }else if ([model.type intValue] == 34)
    {
        typeStr = @"返现";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"新用户注册赠送";
    }else if ([model.type intValue] == 35)
    {
        typeStr = @"点赞";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"点赞赠送";
    }else if ([model.type intValue] == 36)
    {
        typeStr = @"赠送";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = model.name;
    }else if ([model.type intValue] == 37)
    {
        typeStr = @"赠送";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = model.name;
    }else if ([model.type intValue] == 38)
    {
        typeStr = @"返现";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
//        self.titleLabel.text = model.name;
        self.titleLabel.text = [NSString stringWithFormat:@"订单号%@",model.order_code];
    }else if ([model.type intValue] == 39)
    {
        typeStr = @"余额";
        self.moneyLabel.text = [NSString stringWithFormat:@"-%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"余额衣豆抽奖";//model.name;
    }else if ([model.type intValue] == 41)
    {
        typeStr = @"余额";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"好友任务奖励";//model.name;
    }else if ([model.type intValue] == 42)
    {
        typeStr = @"余额";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"余额衣豆抽奖";//model.name;
    }else if ([model.type intValue] == 43)
    {
        typeStr = @"提现额度";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"余额衣豆抽奖";//model.name;
    }else if ([model.type intValue] == 44)
    {
        typeStr = @"提现额度";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"拼团疯抢返还";//model.name;
    }else if ([model.type intValue] == 45)
    {
        typeStr = @"余额及卡费";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"余额及卡费抵扣返还";//model.name;
    }else if ([model.type intValue] == 46)
    {
        typeStr = @"余额及卡费";
        self.moneyLabel.text = [NSString stringWithFormat:@"-%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"余额及卡费抵扣";//model.name;
    }else if ([model.type intValue] == 47) {
        typeStr = @"提现额度";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = [NSString stringWithFormat:@"%@",@"任务提现奖励"];
    }else if ([model.type intValue] == 48) {
        typeStr = @"提现额度";
        self.moneyLabel.text = [NSString stringWithFormat:@"-%.2f",[money_temp doubleValue]];
        self.titleLabel.text = [NSString stringWithFormat:@"%@",@"疯抢中奖"];
    }else if ([model.type intValue] == 49)
    {
        typeStr = @"提现额度";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"好友提现奖励";//model.name;
    }else if ([model.type intValue] == 50)
    {
        typeStr = [NSString stringWithFormat:@"%@",model.name];
        self.moneyLabel.text = [NSString stringWithFormat:@"%.2f",[money_temp doubleValue]];
        self.titleLabel.text = [NSString stringWithFormat:@"订单号%@",model.order_code];
    }else if ([model.type intValue] == 51)//至尊会员奖励
    {
        typeStr = @"提现额度";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"至尊会员奖励金";//model.name;
    }else if ([model.type intValue] == 52)//至尊会员奖励 1级
    {
        typeStr = @"提现额度";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"至尊会员奖励金";//model.name;
    }else if ([model.type intValue] == 53)//至尊会员奖励 2级
    {
        typeStr = @"提现额度";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"至尊会员奖励金";//model.name;
    }else if ([model.type intValue] == 54)
    {
        typeStr = @"提现额度";
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"取消订单退款";//model.name;
    }else if ([model.type intValue] == 55)
    {
        typeStr = [NSString stringWithFormat:@"%@",model.name];
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"下级会员奖励金";
    }else if ([model.type intValue] == 56)
    {
        typeStr = [NSString stringWithFormat:@"%@",model.name];
        self.moneyLabel.text = [NSString stringWithFormat:@"-%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"下级会员奖励金";
    }else if ([model.type intValue] == 57)
    {
        typeStr = [NSString stringWithFormat:@"%@",model.name];
        self.moneyLabel.text = [NSString stringWithFormat:@"-%.2f",[money_temp doubleValue]];
        self.titleLabel.text = @"奖励金扣除";
    }
    else {
        typeStr = model.name;
        self.moneyLabel.text = [NSString stringWithFormat:@"+%.2f",[money_temp doubleValue]];
        self.titleLabel.text = [NSString stringWithFormat:@"订单号%@",model.order_code];
    }
    
    
    self.typeLabel.text = [NSString stringWithFormat:@"%@",typeStr];
}
- (void)loadTaskAccountDetailModel:(DrawCashModel *)model isLeft:(BOOL)isLeft {
    self.typeLabel.hidden=YES;
//    self.moneyLabel.frame = CGRectMake(self.moneyLabel.x, self.contentView.centerY-self.moneyLabel.height/2, self.moneyLabel.width, self.moneyLabel.height);
    [self.moneyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
    }];
    self.timeLabel.text = isLeft ?
                                   [self calculationSecFor1970:[model.add_time longLongValue]/1000.0]
                                 : [self calculationSecFor1970:[model.add_date longLongValue]/1000.0];
    self.titleLabel.text = isLeft ? @"提现中" : @"审核中";
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f元",[model.money doubleValue]];
}
- (void)receiveDataCashModel:(DrawCashModel *)model
{
    //时间
    self.timeLabel.text = [self calculationSecFor1970:[model.add_date longLongValue]/1000.0];
    self.titleLabel.text = [NSString stringWithFormat:@"%@***%@",model.collect_bank_name,model.collect_bank_code];
    self.moneyLabel.text = [NSString stringWithFormat:@"-%.2f",[model.money doubleValue]];
    NSString *pubString = model.t_type.intValue == 2?@"退款":@"提现";
    if ([model.check intValue] == 3) {
        self.typeLabel.text = [NSString stringWithFormat:@"%@成功",pubString];
    } else if ([model.check intValue] == 0) {
        self.typeLabel.text = @"待审核";
    } else if ([model.check intValue] == 1) {
        self.typeLabel.text = @"通过";
    } else if ([model.check intValue] == 2) {
        self.typeLabel.text = @"不通过";
    } else if ([model.check intValue] == 4) {
        self.typeLabel.text = @"审核已通过";
    } else if ([model.check intValue] == 6) {
        self.typeLabel.text = [NSString stringWithFormat:@"%@已发起",pubString];
    } else if ([model.check intValue] == 7) {
        self.typeLabel.text = [NSString stringWithFormat:@"%@已提交至开户行",pubString];
    } else if ([model.check intValue] == 8) {
        self.typeLabel.text = @"开户行发放中，预计1个工作日内到账";
    } else if ([model.check intValue] == 9) {
        self.typeLabel.text = @"开户行发放中，预计1个工作日内到账";
    } else if ([model.check intValue] == 10) {
        self.typeLabel.text = [NSString stringWithFormat:@"%@成功",pubString];
    } else if ([model.check intValue] == 11) {
        self.typeLabel.text = @"转账失败";
    } else if ([model.check intValue] == 12) {
        self.typeLabel.text = @"已重新申请";
    } else {
        self.typeLabel.text = @"其他";
    }
 
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
