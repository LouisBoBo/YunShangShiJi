//
//  MemberPayTableViewCell.m
//  YunShangShiJi
//
//  Created by hebo on 2019/2/27.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "MemberPayTableViewCell.h"

@implementation MemberPayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.delateHeigh1.constant =0;
    self.delateHeigh2.constant =0;
    self.delateHeigh3.constant =0;
    self.delateHeigh4.constant =0;
    
    [self.markImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/meihong_daosanjiao.png"]]];
}
- (void)refreshData:(NSInteger)selectIndex VipData:(vipDataModel*)model;
{
    NSString *retrun_money = [NSString stringWithFormat:@"￥%@",model.return_money];
    self.cashableLabel.text = [NSString stringWithFormat:@"%@日后可返还%@",model.punch_days,retrun_money];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc]initWithString:self.cashableLabel.text];
    NSRange range = [self.cashableLabel.text rangeOfString:retrun_money];
    [noteStr addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(range.location, range.length)];
    [self.cashableLabel setAttributedText:noteStr];
    
    if(model.vip_type.integerValue == 7)
    {
        self.markLabel.text = [NSString stringWithFormat:@"预存%@元赠送1张%@,享如下特权",model.vip_price,model.vip_name];
    }else{
        self.markLabel.text = [NSString stringWithFormat:@"预存%@卡,享如下特权",model.vip_name];
    }
    
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f",model.vip_price.floatValue];
    self.discriptionLabel.text = @"预存多张会员卡，权益叠加";
    
    self.messageLab2Heigh.constant = model.arrears_price.floatValue==0 ? 25:0;
    self.message2Top.constant = model.arrears_price.floatValue == 0 ? 10:0;
    
    UITapGestureRecognizer *distap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disclick)];
    self.discriptionImg.userInteractionEnabled = YES;
    [self.discriptionImg addGestureRecognizer:distap];
    
    UITapGestureRecognizer *wenhaotap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wenhaoclick)];
    self.wenhaoImg.userInteractionEnabled = YES;
    [self.wenhaoImg addGestureRecognizer:wenhaotap];
}

- (void)disclick{
    if(self.disblock)
    {
        self.disblock();
    }
}
- (void)wenhaoclick{
    if(self.wenhaoblock)
    {
        self.wenhaoblock();
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
