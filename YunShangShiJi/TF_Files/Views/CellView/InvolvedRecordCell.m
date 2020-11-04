//
//  InvolvedRecordCell.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/5/30.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "InvolvedRecordCell.h"
#import "UIImageView+WebCache.h"
#import "GlobalTool.h"
#import "MyMD5.h"
@implementation InvolvedRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.H_shopimgV.constant = kZoom6pt(70);
    self.H_theNoLabel.constant = kZoom6pt(35);
    self.H_statusView.constant = kZoom6pt(35);
    self.S_titleL.constant = kZoom6pt(12);
    self.S_personL.constant = kZoom6pt(-12);
    
    self.theNoLabel.font = kFont6pt(15);
    self.timeLable.font = kFont6pt(12);
    self.titleLabel.font = kFont6pt(15);
    self.personLabel.font = kFont6pt(12);
    self.numberLabel.font = kFont6pt(12);
    
    self.winPersonLabel.font = kFont6pt(15);
    self.winNumberLabel.font = kFont6pt(12);
    
//    self.statusLabel.hidden = YES;
    self.statusLabel.font = kFont6pt(12);

    [self.winPersonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(kScreenWidth/2-24);
    }];
}

- (void)setModel:(TreasureRecordsModel *)model
{
    _model = model;
    
    if ([model.status intValue]== 0||[model.status intValue]== 4) {
        self.type = CellType2; // 进行中
    } else if ([model.status intValue] == 2) {
        self.type = CellType4; // 未满足
    } else if ([model.status intValue] == 3) {
        
        int in_uid = [model.in_uid intValue];
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *uid = [ud objectForKey:USER_ID];
        int my_uid = [uid intValue];
        
        if (in_uid == my_uid) {
            self.type = CellType1; // 中奖
        } else {
            self.type = CellType3; // 未中
        }
    }
    
    self.theNoLabel.text = [NSString stringWithFormat:@"第%@期", self.model.issue_code];
    
    NSMutableString *code = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",model.shop_code]];
    NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
    NSString *pic;
    if(model.shop_pic) {
        pic = [NSString stringWithFormat:@"%@/%@/%@",supcode,model.shop_code,model.shop_pic];
    }
    NSString *picSize;
    
    if (kDevice_Is_iPhone6Plus) {
        picSize = @"!382";
    } else {
        picSize = @"!280";
    }
    //!280
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],pic,picSize]];
    
    MyLog(@"imgUrl: %@", imgUrl);
    [self.shopimgV sd_setImageWithURL:imgUrl];
    self.titleLabel.text = self.model.shop_name;
    
    NSString *pString;
    if (kUnNilAndNULL(model.virtual_num)) {
        pString = [NSString stringWithFormat:@"本期参与：%lld人次", [self.model.num longLongValue]+[self.model.virtual_num longLongValue]];
    } else {
        pString = [NSString stringWithFormat:@"本期参与：%lld人次", [self.model.num longLongValue]];
    }
    NSMutableAttributedString *atStr = [[NSMutableAttributedString alloc] initWithString:pString];
    [atStr addAttribute:NSForegroundColorAttributeName value:COLOR_ROSERED range:NSMakeRange(5, pString.length-7)];
    self.personLabel.attributedText = atStr;

}

- (void)setType:(CellType)type
{
    _type = type;
    
    NSString *statusString;
    
    if (type == CellType1) {        // yes
        self.statusLabel.hidden = YES;
        
        self.H_statusView.constant = kZoom6pt(35);
        self.statusView.hidden = NO;
        NSString *pString = [NSString stringWithFormat:@"获奖者：%@",self.model.in_name];
        NSMutableAttributedString *atStr = [[NSMutableAttributedString alloc] initWithString:pString];
        [atStr addAttribute:NSForegroundColorAttributeName value:COLOR_ROSERED range:NSMakeRange(0, 4)];
        self.winPersonLabel.attributedText = atStr;
        self.winNumberLabel.text = [NSString stringWithFormat:@"中奖号码：%@", self.model.in_code];
        
        self.timeLable.text = [NSString stringWithFormat:@"揭晓时间：%@",  [MyMD5 timeInfoWithTimeInterval:[self.model.otime longLongValue]]];

    } else if (type == CellType2) { // ing
        self.H_statusView.constant = 0;
        self.statusView.hidden = YES;
        self.statusImgV.hidden = YES;
        
        statusString = @"进行中";
        [self setStatuseLabelText:statusString color:[UIColor greenColor]];
        
        self.timeLable.text = [NSString stringWithFormat:@"开始时间：%@",  [MyMD5 timeInfoWithTimeInterval:[self.model.btime longLongValue]]];
        
    } else if (type == CellType3) { // not
        self.statusImgV.hidden = YES;
        
        statusString = @"已揭晓";
        [self setStatuseLabelText:statusString color:COLOR_ROSERED];
        
        self.H_statusView.constant = kZoom6pt(35);
        self.statusView.hidden = NO;
        
        NSString *pString = [NSString stringWithFormat:@"获奖者：%@",self.model.in_name];
        NSMutableAttributedString *atStr = [[NSMutableAttributedString alloc] initWithString:pString];
        [atStr addAttribute:NSForegroundColorAttributeName value:COLOR_ROSERED range:NSMakeRange(0, 4)];
        self.winPersonLabel.attributedText = atStr;
        
        self.winNumberLabel.text = [NSString stringWithFormat:@"中奖号码：%@", self.model.in_code];
        self.timeLable.text = [NSString stringWithFormat:@"揭晓时间：%@",  [MyMD5 timeInfoWithTimeInterval:[self.model.otime longLongValue]]];
        
    } else if (type == CellType4) { // inv
        self.H_statusView.constant = 0;
        self.statusView.hidden = YES;
        self.statusImgV.hidden = YES;
        
        statusString = @"已退款";
        [self setStatuseLabelText:statusString color:RGBCOLOR_I(220,220,220)];
        
        self.timeLable.text = @"未满足预定开奖人数";
        
    }
}

- (void)setModel2:(TreasureRecordsModel *)model2
{
    _model2 = model2;

    //"status": 当前状态 0正常参与 1等待开奖 2已经开奖,
    if ([model2.status intValue]== 0||[model2.status intValue]== 1) {
        self.type2 = CellType2; // 进行中
    } else if ([model2.status intValue] == 2) {

        int in_uid = [model2.in_uid intValue];

        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *uid = [ud objectForKey:USER_ID];
        int my_uid = [uid intValue];

        if (in_uid == my_uid) {
            self.type2 = CellType1; // 中奖
        } else {
            self.type2 = CellType3; // 未中
        }
    }

    self.theNoLabel.text = [NSString stringWithFormat:@"第%@期", self.model2.issue_code];

    NSMutableString *code = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",model2.shop_code]];
    NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
    NSString *pic;
    if(model2.shop_pic) {
        pic = [NSString stringWithFormat:@"%@/%@/%@",supcode,model2.shop_code,model2.shop_pic];
    }
    NSString *picSize;

    if (kDevice_Is_iPhone6Plus) {
        picSize = @"!382";
    } else {
        picSize = @"!280";
    }
    //!280
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],pic,picSize]];

    MyLog(@"imgUrl: %@", imgUrl);
    [self.shopimgV sd_setImageWithURL:imgUrl];
    self.titleLabel.text = self.model2.shop_name;

    NSString *pString;
    if (kUnNilAndNULL(model2.v_num)) {
        pString = [NSString stringWithFormat:@"本期开团：%lld团次", [self.model2.num longLongValue]+[self.model2.v_num longLongValue]];
    } else {
        pString = [NSString stringWithFormat:@"本期开团：%lld团次", [self.model2.num longLongValue]];
    }
    NSMutableAttributedString *atStr = [[NSMutableAttributedString alloc] initWithString:pString];
    [atStr addAttribute:NSForegroundColorAttributeName value:COLOR_ROSERED range:NSMakeRange(5, pString.length-7)];
    self.personLabel.attributedText = atStr;

}

- (void)setType2:(CellType)type2
{
    _type2 = type2;

    NSString *statusString;

    if (type2 == CellType1) {        // yes
        self.statusLabel.hidden = YES;

        self.H_statusView.constant = kZoom6pt(35);
        self.statusView.hidden = NO;
        NSString *pString = [NSString stringWithFormat:@"获奖团：%@的团",self.model2.in_rollUserName];
        NSMutableAttributedString *atStr = [[NSMutableAttributedString alloc] initWithString:pString];
        [atStr addAttribute:NSForegroundColorAttributeName value:COLOR_ROSERED range:NSMakeRange(0, 4)];
        self.winPersonLabel.attributedText = atStr;
        self.winNumberLabel.text = [NSString stringWithFormat:@"中奖号码：%@", self.model2.in_code];

        self.timeLable.text = [NSString stringWithFormat:@"揭晓时间：%@",  [MyMD5 timeInfoWithTimeInterval:[self.model2.otime longLongValue]]];

    } else if (type2 == CellType2) { // ing
        self.H_statusView.constant = 0;
        self.statusView.hidden = YES;
        self.statusImgV.hidden = YES;

        statusString = @"进行中";
        [self setStatuseLabelText:statusString color:[UIColor greenColor]];

        self.timeLable.text = [NSString stringWithFormat:@"开始时间：%@",  [MyMD5 timeInfoWithTimeInterval:[self.model2.btime longLongValue]]];

    } else if (type2 == CellType3) { // not
        self.statusImgV.hidden = YES;

        statusString = @"已揭晓";
        [self setStatuseLabelText:statusString color:COLOR_ROSERED];

        self.H_statusView.constant = kZoom6pt(35);
        self.statusView.hidden = NO;

        NSString *pString = [NSString stringWithFormat:@"获奖团：%@的团",self.model2.in_rollUserName];
        NSMutableAttributedString *atStr = [[NSMutableAttributedString alloc] initWithString:pString];
        [atStr addAttribute:NSForegroundColorAttributeName value:COLOR_ROSERED range:NSMakeRange(0, 4)];
        self.winPersonLabel.attributedText = atStr;

        self.winNumberLabel.text = [NSString stringWithFormat:@"中奖号码：%@", self.model2.in_code];
        self.timeLable.text = [NSString stringWithFormat:@"揭晓时间：%@",  [MyMD5 timeInfoWithTimeInterval:[self.model2.otime longLongValue]]];

    }
}

- (void)setStatuseLabelText:(NSString *)text color:(UIColor *)color
{
    CGSize size = [text boundingRectWithSize:CGSizeMake(100, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFont6pt(12)} context:nil].size;
    self.statusLabel.text = text;
    self.statusLabel.textColor = color;
    self.W_statusL.constant = size.width + 6;
    self.H_statusL.constant = size.height + 2;
    self.statusLabel.layer.masksToBounds = YES;
    self.statusLabel.layer.borderColor = [color CGColor];
    self.statusLabel.layer.borderWidth = 1;
    self.statusLabel.layer.cornerRadius = 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
