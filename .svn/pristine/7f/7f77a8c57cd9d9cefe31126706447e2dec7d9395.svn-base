//
//  TableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/5/28.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "RecordTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "GlobalTool.h"
#import "MyMD5.h"
@implementation RecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)refreshData:(participateModel*)model
{
    self.titleimage.clipsToBounds = YES;
    self.titleimage.layer.cornerRadius = CGRectGetWidth(self.titleimage.frame)/2;
    if ([model.uhead hasPrefix:@"http://"]) {
        [self.titleimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.uhead]]];
    }else{
        [self.titleimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy],model.uhead]]];
    }
    
    self.titlelable.text = model.nickname;
    self.titlelable.textColor = RGBCOLOR_I(62, 62, 62);
    self.titlelable.font = [UIFont systemFontOfSize:ZOOM6(26)];
    
    NSString *starttime = [MyMD5 getTimeToShowWithTimestampSecond:model.atime];
    self.timelable.text = starttime;
    self.timelable.textColor = RGBCOLOR_I(125, 125, 125);
    self.timelable.font = [UIFont systemFontOfSize:ZOOM6(20)];
    
    self.numlable.text = [NSString stringWithFormat:@"%@次",model.num];
    self.numlable.textColor = RGBCOLOR_I(125, 125, 125);
    self.numlable.font = [UIFont systemFontOfSize:ZOOM6(26)];
    self.numlable.textAlignment = NSTextAlignmentRight;
    NSMutableAttributedString *noteStr ;
    
    if(self.numlable.text)
    {
        noteStr = [[NSMutableAttributedString alloc]initWithString:self.numlable.text];
    }
    if(self.isFightIndiana)
    {
        [noteStr addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(2, model.num.length)];
    }else{
        [noteStr addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(0, model.num.length)];
    }
    [self.numlable setAttributedText:noteStr];

}

- (void)refreshIndiana:(FightIndianaRecordModel*)model
{
    self.titleimage.clipsToBounds = YES;
    self.titleimage.layer.cornerRadius = CGRectGetWidth(self.titleimage.frame)/2;
    if ([model.user_head hasPrefix:@"http://"]) {
        [self.titleimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.user_head]]];
    }else{
        [self.titleimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy],model.user_head]]];
    }
    
    self.titlelable.text = model.user_name;
    self.titlelable.textColor = RGBCOLOR_I(62, 62, 62);
    self.titlelable.font = [UIFont systemFontOfSize:ZOOM6(26)];
    
    NSString *starttime = [MyMD5 getTimeToShowWithTimestampSecond:model.join_time];
    self.timelable.text = starttime;
    self.timelable.textColor = RGBCOLOR_I(125, 125, 125);
    self.timelable.font = [UIFont systemFontOfSize:ZOOM6(20)];
    
    self.numlable.text = [NSString stringWithFormat:@"%@次",model.num];
    self.numlable.textColor = RGBCOLOR_I(125, 125, 125);
    self.numlable.font = [UIFont systemFontOfSize:ZOOM6(26)];
    self.numlable.textAlignment = NSTextAlignmentRight;
    NSMutableAttributedString *noteStr ;
    
    if(self.isFightIndiana)
    {
        self.titlelable.text = [NSString stringWithFormat:@"%@",model.user_name];
        self.numlable.text = [NSString stringWithFormat:@"已建%@团次",model.num];
    }
    
    if(self.numlable.text)
    {
        noteStr = [[NSMutableAttributedString alloc]initWithString:self.numlable.text];
    }
    NSString *num = [NSString stringWithFormat:@"%@",model.num];
    if(self.isFightIndiana)
    {
        [noteStr addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(2, num.length)];
    }else{
        [noteStr addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(0, num.length)];
    }
    [self.numlable setAttributedText:noteStr];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
