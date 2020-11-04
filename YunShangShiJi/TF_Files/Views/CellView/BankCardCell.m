//
//  BankCardCell.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/8.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "BankCardCell.h"
@implementation BankCardCell
- (void)awakeFromNib {
    // Initialization code
    
    self.titleLabel.font = kFont6px(32);
    self.bankNoLabel.font = kFont6px(29);
}

- (void)receiveDataModel:(BankCardModel *)model
{
    if([model.bank_name containsString:@"微信支付"])
    {
        self.headImageView.image = [UIImage imageNamed:@"pay_icon_微信支付"];
    }else{
        self.headImageView.image = [UIImage imageNamed:model.bank_name];
    }
    
    self.titleLabel.text = model.bank_name;
    NSString *bank_no = model.bank_no;
    self.bankNoLabel.text = [NSString stringWithFormat:@"**%@",[bank_no substringFromIndex:bank_no.length-4]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
