//
//  FriendsRawardsTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/12/13.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "FriendsRawardsTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "GlobalTool.h"
@implementation FriendsRawardsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headimage.clipsToBounds = YES;
    self.headimage.layer.cornerRadius = 30;
    
    self.nickname.textColor = RGBCOLOR_I(62, 62, 62);
    self.nickname.font = [UIFont systemFontOfSize:ZOOM6(30)];
    
    self.time.textColor = RGBCOLOR_I(168, 168, 168);
    self.time.font = [UIFont systemFontOfSize:ZOOM6(24)];
    
    self.extra.textColor = RGBCOLOR_I(255, 63, 139);
    self.extra.font = [UIFont systemFontOfSize:ZOOM6(30)];
    
    self.money.textColor = RGBCOLOR_I(255, 63, 139);
    self.money.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.money.textAlignment = NSTextAlignmentRight;
}
- (void)refreshData:(FriendsRawardModel*)model;
{
    NSString *img = [model.pic hasPrefix:@"http"]?model.pic:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.pic];
    [self.headimage sd_setImageWithURL:[NSURL URLWithString:img]];
    
    self.nickname.text = model.nickname;
    
    self.time.text = model.add_date;
    
    self.extra.text = [NSString stringWithFormat:@"+%.2f元提现额度",model.f_extra.floatValue];
    
    self.money.text = [NSString stringWithFormat:@"+%.2f元余额",model.f_money.floatValue];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
