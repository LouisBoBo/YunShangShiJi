//
//  memberRawardTableViewCell.m
//  YunShangShiJi
//
//  Created by hebo on 2019/7/26.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "memberRawardTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "GlobalTool.h"
@implementation memberRawardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.headImage.clipsToBounds = YES;
    self.headImage.layer.cornerRadius = CGRectGetWidth(self.headImage.frame)/2;
    self.rawardLab.textColor = tarbarrossred;
    self.nickname.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.timeLab.font = [UIFont systemFontOfSize:ZOOM6(24)];
    self.timeLab.textColor = kTextColor;
    self.rawardLab.font = [UIFont systemFontOfSize:ZOOM6(26)];
    
    self.shareBtn.clipsToBounds = YES;
    self.shareBtn.layer.cornerRadius = 5;
}
- (void)refreshData:(rawardsFriendsModel*)model;
{
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    self.nickname.text = model.nickName;
    self.timeLab.text = model.time;
    self.rawardLab.text = model.money.floatValue>0?[NSString stringWithFormat:@"+%@元奖励金",model.money]:@"";
    
    [self.shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)shareClick:(UIButton*)sender
{
    if(self.shareClickBlock)
    {
        self.shareClickBlock();
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
