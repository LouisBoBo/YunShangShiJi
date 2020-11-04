            //
//  PostTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/23.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "PostTableViewCell.h"
#import "MyMD5.h"
#import "GlobalTool.h"
@implementation PostTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.line.backgroundColor = kBackgroundColor;
    self.name.textColor=kTextColor;
    self.count.textColor=kTextColor;
    self.time.textColor=kTextColor;
    
    
    self.title.font = [UIFont systemFontOfSize:ZOOM(48)];
    self.name.font = [UIFont systemFontOfSize:ZOOM(37)];
    self.time.font = [UIFont systemFontOfSize:ZOOM(37)];
    self.count.font = [UIFont systemFontOfSize:ZOOM(37)];
    
}
-(void)refreshData:(ForumModel*)model
{
    NSString *title;
    if(model.nicktitle.length>0)
    {
        title=model.nicktitle;
    }else{
        title=model.title;
    }
//    self.topImg.hidden = YES;
    self.essenceImg.hidden = YES;
    self.hotImg.hidden = YES;
    self.photoImg.hidden = YES;
//    self.name.hidden = NO;
//    self.nameImg.hidden = NO;
//    self.count.hidden = NO;
//    self.countImg.hidden = NO;
//    self.time.hidden = NO;
//    self.timeImg.hidden = NO;
    
    self.title.text=[NSString stringWithFormat:@"%@",title];
    if(model.nickname)
    {
        self.name.text=[NSString stringWithFormat:@"%@",model.nickname];
    }else{
        self.name.text= @" ";
    }
    
    if(model.r_count)
    {
        self.count.text=[NSString stringWithFormat:@"%@",model.r_count];
    }else{
        self.count.text=@"0";
    }
    

    
    CGFloat x_point= 15;
//    if (model.top.intValue == 1) {
//        self.topImg.hidden = NO;
//        self.name.hidden = YES;
//        self.nameImg.hidden = YES;
//        self.count.hidden = YES;
//        self.countImg.hidden = YES;
//        self.time.hidden = YES;
//        self.timeImg.hidden = YES;
//        x_point += 25;
//    }
    if (model.fine.intValue == 1){
        self.essenceImg.hidden = NO;
        self.essenceImg.frame = CGRectMake(x_point+5, 9, 18, 18);
        x_point += 23;
//        //%f",x_point);
    }
    if (model.hot.intValue == 1 ) {
        self.hotImg.hidden = NO;
        self.hotImg.frame = CGRectMake(x_point+5, 9, 18, 18);
        x_point += 23;

    }
    if (model.pic_list != nil&& ![model.pic_list isEqualToString:@""]) {
        self.photoImg.hidden = NO;
//        //%f",x_point);
        self.photoImg.frame = CGRectMake(x_point+5, 9, 18, 18);
//        //%f",x_point);
        x_point +=23;
        
    }

    NSString *time=[MyMD5 compareCurrentTime:model.send_time];
    self.time.text=[NSString stringWithFormat:@"%@",time];
    
    self.title.frame = CGRectMake(x_point+10, 6, kScreenWidth-(x_point+10+10), 21);
    


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    // Configure the view for the selected state
}

@end
