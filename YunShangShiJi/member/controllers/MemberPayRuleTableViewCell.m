//
//  MemberPayRuleTableViewCell.m
//  YunShangShiJi
//
//  Created by hebo on 2020/7/30.
//  Copyright © 2020 ios-1. All rights reserved.
//

#import "MemberPayRuleTableViewCell.h"

@implementation MemberPayRuleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)refreshData:(vipDataModel*)ruleModel Price:(NSString*)price Count:(NSString*)count;
{
    NSDictionary *dic ;
    NSString *vip_code = [NSString stringWithFormat:@"%@",ruleModel.vip_code];
    if(![vip_code isEqualToString:@"(null)"] && ruleModel.equityYet.count){
        dic = ruleModel.equityYet[count.integerValue];
    }else if (ruleModel.equity.count){
        dic = ruleModel.equity[count.integerValue];
    }
    
    self.ruleTitle.text = [NSString stringWithFormat:@"%@",dic[@"equity_content"]];
    [self.ruleTitle setFont:[UIFont systemFontOfSize:ZOOM6(30)]];
    
    NSMutableAttributedString* noteStr = [[NSMutableAttributedString alloc]initWithString:self.ruleTitle.text];
    NSArray *replaces = dic[@"replaces"];
    for(int k =0;k < replaces.count;k++)
    {
        NSRange range = [self.ruleTitle.text rangeOfString:@"{replace}"];
        [noteStr addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(range.location, range.length)];
        [noteStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:ZOOM6(30)] range:NSMakeRange(range.location, range.length)];
        [noteStr.string stringByReplacingCharactersInRange:NSMakeRange(range.location, range.length) withString:replaces[k]];
        [noteStr replaceCharactersInRange:range withString:replaces[k]];
        [self.ruleTitle setAttributedText:noteStr];
        
        continue;
    }

    [self.ruleImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@!450",[NSObject baseURLStr_Upy],dic[@"equity_url"]]]]]];
    
    if(ruleModel.vip_type.integerValue == 4 && count.integerValue == 0)
    {
        self.markviewHeigh.constant = 35;
        self.marklabel1.text = @"会员提现区";
        self.marklabel2.text = [NSString stringWithFormat:@"提现%@元",price];
        self.marklabel3.text = @"直接打入微信零钱";
    }else{
        self.markviewHeigh.constant = 0;
    }
}

//获取字符串中多个相同字符串的所有range
- (NSArray*)rangeOfSubString:(NSString*)subStr inString:(NSString*)string {
    NSMutableArray *rangeArray = [NSMutableArray array];
    NSString*string1 = [string stringByAppendingString:subStr];
    NSString *temp;
    for(int i =0; i < string.length; i ++) {
        temp = [string1 substringWithRange:NSMakeRange(i, subStr.length)];
        if ([temp isEqualToString:subStr]) {
            NSRange range = {i,subStr.length};
            [rangeArray addObject: [NSValue valueWithRange:range]];
        }
    }
    return rangeArray;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
