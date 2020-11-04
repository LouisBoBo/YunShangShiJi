//
//  FightIndianaHeadTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/8/28.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "FightIndianaHeadTableViewCell.h"
#import "GlobalTool.h"
#import "DefaultImgManager.h"
#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]
@implementation FightIndianaHeadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(36)];
    self.headTitle.textColor = RGBCOLOR_I(62, 62, 62);
    
    self.detailTitle.font = [UIFont systemFontOfSize:ZOOM6(32)];
    self.detailTitle.textColor = RGBCOLOR_I(62, 62, 62);
    
    self.shareTitle.font = [UIFont systemFontOfSize:ZOOM6(28)];
    self.shareTitle.textColor = RGBCOLOR_I(125, 125, 125);
    
    self.weixinLab.font = [UIFont systemFontOfSize:ZOOM6(24)];
    self.weixinLab.textColor = RGBCOLOR_I(125, 125, 125);

    self.friendLab.font = [UIFont systemFontOfSize:ZOOM6(24)];
    self.friendLab.textColor = RGBCOLOR_I(125, 125, 125);
    
    self.bottomTitle.font = [UIFont systemFontOfSize:ZOOM6(28)];
    self.bottomTitle.textColor = RGBCOLOR_I(255, 63, 139);
    
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.width.offset(kScreenWidth);
        make.height.offset(kScreenWidth/2);
    }];
    [self.statueImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImage.mas_bottom).offset(ZOOM6(60));
        make.left.offset((kScreenWidth-ZOOM6(340))/2);
        make.width.height.offset(ZOOM6(46));
    }];
    [self.headTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImage.mas_bottom).offset(ZOOM6(60));
        make.left.equalTo(self.statueImage.mas_right).offset(ZOOM6(12));
        make.height.offset(ZOOM6(46));
    }];
    [self.detailTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statueImage.mas_bottom).offset(ZOOM6(16));
        make.centerX.equalTo(self);
        make.height.offset(ZOOM6(40));
    }];
    [self.shareTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailTitle.mas_bottom).offset(ZOOM6(60));
        make.centerX.equalTo(self);
        make.height.offset(ZOOM6(30));
        
    }];
    [self.weixinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shareTitle.mas_bottom).offset(ZOOM6(20));
        make.left.offset((kScreenWidth-ZOOM6(300))/2);
        make.width.height.offset(ZOOM6(100));
    }];
    [self.friendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shareTitle.mas_bottom).offset(ZOOM6(20));
        make.left.equalTo(self.weixinBtn.mas_right).offset(ZOOM6(100));
        make.width.height.offset(ZOOM6(100));
        
    }];
    [self.weixinLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weixinBtn.mas_bottom).offset(ZOOM6(20));
        make.left.equalTo(self.weixinBtn.mas_left).offset(-ZOOM6(20));
        make.width.offset(ZOOM6(140));
        make.height.offset(ZOOM6(40));
    }];
    [self.friendLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.friendBtn.mas_bottom).offset(ZOOM6(20));
        make.left.equalTo(self.friendBtn.mas_left).offset(-ZOOM6(20));
        make.width.offset(ZOOM6(140));
        make.height.offset(ZOOM6(40));
    }];
    [self.bottomTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weixinLab.mas_bottom).offset(ZOOM6(40));
        make.centerX.equalTo(self);
        make.height.offset(ZOOM6(30));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomTitle.mas_bottom).offset(ZOOM6(60));
        make.left.offset(0);
        make.width.offset(kScreenWidth);
        make.height.offset(1);
    }];

}

- (void)refresh:(ShopDetailModel*)model Group:(TreasureGroupsModel*)groupmodel;
{
    BOOL result = NO;
    if(model.my_num.intValue <= 0 && (model.owestatue.intValue==1 || model.owestatue.intValue==2))
    {
        result = YES;
    }

    self.statueImage.hidden = result;
    self.headTitle.hidden = result;
    self.shareTitle.hidden = result;
    self.weixinBtn.hidden = result;
    self.friendBtn.hidden = result;
    self.weixinLab.hidden = result;
    self.friendLab.hidden = result;
    self.bottomTitle.hidden = result;
    self.line.hidden = result;

    [self.weixinBtn addTarget:self action:@selector(weixinClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.friendBtn addTarget:self action:@selector(friendClick:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *countStr = [NSString stringWithFormat:@"%zd",model.group_number.integerValue-groupmodel.num.integerValue];
    if(model.owestatue.integerValue==1 || model.owestatue.integerValue==2)
    {
        countStr = @"0";
    }
    self.detailTitle.text =result?@"你未参与本期抽奖哦~":[NSString stringWithFormat:@"还差%@位就成团了，赶紧邀请好友参团吧!",countStr];
    if(self.detailTitle.text.length && !result)
    {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:self.detailTitle.text];
        [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(40)] range:NSMakeRange(2, 1)];
        [attr addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(2, countStr.length)];
        [self.detailTitle setAttributedText:attr];
    }

    self.bottomTitle.text = [NSString stringWithFormat:@"分享到%@个群后，成团率高达%@!",@"3",@"98%"];
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.banner]] placeholderImage:DefaultImg(self.headImage.size)];

}

- (void)weixinClick:(UIButton*)sender
{
    if(self.weixinBlock)
    {
        self.weixinBlock();
    }
}
- (void)friendClick:(UIButton*)sender
{
    if(self.friendBlock)
    {
        self.friendBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
