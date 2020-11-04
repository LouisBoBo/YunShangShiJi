//
//  AgoAnnounceCell.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/5/30.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "AgoAnnounceCell.h"
#import "UIImageView+WebCache.h"
#import "GlobalTool.h"
#import "MyMD5.h"
@implementation AgoAnnounceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.H_shopimgV.constant = kZoom6pt(45);
    self.H_theNoLabel.constant = kZoom6pt(35);
    
    self.theNoLabel.font = kFont6pt(15);
    self.timeLable.font = kFont6pt(12);
    self.titleLabel.font = kFont6pt(15);
    self.personLabel.font = kFont6pt(12);
    self.numberLabel.font = kFont6pt(12);
    
    self.shopimgV.layer.masksToBounds = YES;
    self.shopimgV.layer.cornerRadius = kZoom6pt(45)*0.5;

}


- (void)setModel:(TreasureRecordsModel *)model
{
    _model = model;
    self.theNoLabel.text = [NSString stringWithFormat:@"第%@期", model.issue_code];
    NSString *str = model.OneIndiana?@"开奖时间":@"揭晓时间";
    self.timeLable.text = [NSString stringWithFormat:@"%@：%@", str,[MyMD5 timeInfoWithTimeInterval:[model.otime longLongValue]]];
    
    NSURL *imgUrl;
    if ([model.in_head hasPrefix:@"http"]) {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.in_head]];
    } else {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!382",[NSObject baseURLStr_Upy],model.in_head]];
    }
    
    [self.shopimgV sd_setImageWithURL:imgUrl];

    NSString *nString = [NSString stringWithFormat:@"获奖者：%@", model.in_name];
    NSMutableAttributedString *atStr = [[NSMutableAttributedString alloc] initWithString:nString];
    [atStr addAttribute:NSForegroundColorAttributeName value:COLOR_ROSERED range:NSMakeRange(0, 4)];
    self.titleLabel.attributedText = atStr;
    
    
    NSString *numString;
    if (kUnNilAndNULL(model.virtual_num)) {
        numString = [NSString stringWithFormat:@"本期参与：%lld人次", [self.model.num longLongValue]+[self.model.virtual_num longLongValue]];
    } else {
        numString = [NSString stringWithFormat:@"本期参与：%@人次", self.model.num];
    }
    
    NSMutableAttributedString *atString = [[NSMutableAttributedString alloc] initWithString:numString];
    [atString addAttribute:NSForegroundColorAttributeName value:COLOR_ROSERED range:NSMakeRange(5, numString.length-7)];
    self.personLabel.attributedText = atString;

    self.numberLabel.text = [NSString stringWithFormat:@"幸运号码：%@", model.in_code];
    
}
- (void)setModel2:(TreasureRecordsModel *)model2
{
    UIImageView *userIco = [[UIImageView alloc]init];
    userIco.image = [UIImage imageNamed:@"团长"];
    userIco.frame = CGRectMake(self.shopimgV.right-ZOOM6(64), self.shopimgV.y-ZOOM6(12), ZOOM6(64), ZOOM6(36));
    [self.contentView addSubview:userIco];

    _model2 = model2;
    self.theNoLabel.text = [NSString stringWithFormat:@"第%@期", model2.issue_code];
    NSString *str = model2.OneIndiana?@"开奖时间":@"揭晓时间";
    self.timeLable.text = [NSString stringWithFormat:@"%@：%@", str,[MyMD5 timeInfoWithTimeInterval:[model2.etime longLongValue]]];

    NSURL *imgUrl;
    if ([model2.in_rollHead hasPrefix:@"http"]) {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model2.in_rollHead]];
    } else {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!382",[NSObject baseURLStr_Upy],model2.in_rollHead]];
    }

    [self.shopimgV sd_setImageWithURL:imgUrl];

    NSString *nString = [NSString stringWithFormat:@"获奖团：%@的团", model2.in_rollUserName];
    NSMutableAttributedString *atStr = [[NSMutableAttributedString alloc] initWithString:nString];
    [atStr addAttribute:NSForegroundColorAttributeName value:COLOR_ROSERED range:NSMakeRange(0, 4)];
    self.titleLabel.attributedText = atStr;


    NSString *numString;
//    if (kUnNilAndNULL(model2.virtual_num)) {
//        numString = [NSString stringWithFormat:@"本期参与：%lld人次", [self.model2.in_sum longLongValue]];
//    } else {
        numString = [NSString stringWithFormat:@"本期开团：%@团次", self.model2.in_sum];
//    }

    NSMutableAttributedString *atString = [[NSMutableAttributedString alloc] initWithString:numString];
    [atString addAttribute:NSForegroundColorAttributeName value:COLOR_ROSERED range:NSMakeRange(5, numString.length-7)];
    self.personLabel.attributedText = atString;

    self.numberLabel.text = [NSString stringWithFormat:@"中奖号码：%@", model2.in_code];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
