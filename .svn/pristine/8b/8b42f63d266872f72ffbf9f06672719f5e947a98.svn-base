//
//  ReplyTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/23.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "ReplyTableViewCell.h"
#import "GlobalTool.h"
@implementation ReplyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.content.textColor = RGBCOLOR_I(125, 125, 125);
    self.content.font = [UIFont systemFontOfSize:ZOOM6(30)];
}

- (void)refreshData:(LreplistModel*)model
{
    self.content.frame = CGRectMake(self.content.frame.origin.x, self.content.frame.origin.y, self.content.frame.size.width, model.cellheigh);
    self.content.backgroundColor = [UIColor clearColor];
    self.content.numberOfLines = 0;

    NSString *receive_user_id = [NSString stringWithFormat:@"%@",model.receive_user_id];
    if(model.send_user_id.intValue == model.base_user_id.intValue)
    {
        model.send_nickname = @"楼主";
    }else if (model.send_nickname.length > 8)
    {
        model.send_nickname = [model.send_nickname substringToIndex:8];
    }
    if(model.receive_user_id.intValue == model.base_user_id.intValue)
    {
        model.receive_nickname = @"楼主";
    }else if (model.receive_nickname.length > 8)
    {
        model.receive_nickname = [model.receive_nickname substringToIndex:8];
    }
    
    if([receive_user_id isEqualToString:@"(null)"] ||[receive_user_id isEqual:[NSNull null]])
    {
        self.content.text = [NSString stringWithFormat:@"%@：%@",model.send_nickname,model.content];
    }else{
        self.content.text = [NSString stringWithFormat:@"%@回复%@：%@",model.send_nickname,model.receive_nickname,model.content];
    }
    
    NSMutableAttributedString *noteStr ;
    if(self.content.text)
    {
        noteStr = [[NSMutableAttributedString alloc]initWithString:self.content.text];
    }
    NSString *str1;
    NSString *str2;
    if([receive_user_id isEqualToString:@"(null)"] ||[receive_user_id isEqual:[NSNull null]])
    {
        str1 =[NSString stringWithFormat:@"%@：",model.send_nickname];
        str1.length>0?[noteStr addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(0, str1.length)]:nil;
    }else{//评论内回复
        
        str1 =[NSString stringWithFormat:@"%@",model.send_nickname];
        str1.length>0?[noteStr addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(0, str1.length)]:nil;
        
        str2 =[NSString stringWithFormat:@"%@：",model.receive_nickname];
        str2.length>0?[noteStr addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(str1.length+2, str2.length)]:nil;

    }
    [self.content setAttributedText:noteStr];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
