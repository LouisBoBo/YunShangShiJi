//
//  FightIndianaTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/8/28.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "FightIndianaTableViewCell.h"
#import "GlobalTool.h"
@implementation FightIndianaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.fightTitle.textColor = RGBCOLOR_I(62, 62, 62);
    self.fightTitle.font = [UIFont systemFontOfSize:ZOOM6(32)];
    self.name1.textColor = RGBCOLOR_I(125, 125, 125);
    self.name1.font = [UIFont systemFontOfSize:ZOOM6(20)];
    self.name2.textColor = RGBCOLOR_I(125, 125, 125);
    self.name2.font = [UIFont systemFontOfSize:ZOOM6(20)];
    self.name3.textColor = RGBCOLOR_I(125, 125, 125);
    self.name3.font = [UIFont systemFontOfSize:ZOOM6(20)];
    CGFloat space = (kScreenWidth - 2*ZOOM6(130) - 3*ZOOM6(120))/2;
    
    [self.fightTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(ZOOM6(60));
        make.centerX.equalTo(self);
        make.height.offset(ZOOM6(40));
    }];
    
    [self.imageOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fightTitle.mas_bottom).offset(ZOOM6(40));
        make.left.offset(ZOOM6(130));
        make.width.height.offset(ZOOM6(120));
    }];
    
    [self.imageTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageOne);
        make.left.equalTo(self.imageOne.mas_right).offset(space);
        make.width.height.offset(ZOOM6(120));
    }];

    [self.imageThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageOne);
        make.left.equalTo(self.imageTwo.mas_right).offset(space);
        make.width.height.offset(ZOOM6(120));
    }];

    [self.tuanZhangImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageOne);
        make.left.equalTo(self.imageOne.mas_right).offset(-ZOOM6(50));
        make.width.offset(ZOOM6(64));
        make.height.offset(ZOOM6(36));
    }];
    
    [self.name1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageOne.mas_bottom).offset(ZOOM6(12));
        make.left.equalTo(self.imageOne.mas_left);
        make.width.equalTo(self.imageOne);
        make.height.offset(ZOOM6(25));
    }];
    
    [self.name2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageTwo.mas_bottom).offset(ZOOM6(12));
        make.left.equalTo(self.imageTwo.mas_left);
        make.width.equalTo(self.imageTwo);
        make.height.offset(ZOOM6(25));
    }];
    
    [self.name3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageThree.mas_bottom).offset(ZOOM6(12));
        make.left.equalTo(self.imageThree.mas_left);
        make.width.equalTo(self.imageThree);
        make.height.offset(ZOOM6(25));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
