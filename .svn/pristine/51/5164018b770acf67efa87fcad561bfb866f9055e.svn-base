//
//  topTableViewCell.m
//  YunShangShiJi
//
//  Created by yssj on 15/8/11.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "topTableViewCell.h"
#import "GlobalTool.h"

@implementation topTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.line.backgroundColor = kBackgroundColor;

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
    self.topImg.hidden = YES;
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


    //    self.line.frame=CGRectMake(0, self.frame.size.height, self.frame.size.width, 1);
    
    
    CGFloat x_point= 20;
    if (model.top.intValue == 1) {
        self.topImg.hidden = NO;
        //        self.name.hidden = YES;
        //        self.nameImg.hidden = YES;
        //        self.count.hidden = YES;
        //        self.countImg.hidden = YES;
        //        self.time.hidden = YES;
        //        self.timeImg.hidden = YES;
        x_point += 32;
    }
    if (model.fine.intValue == 1){
        self.essenceImg.hidden = NO;
        self.essenceImg.frame = CGRectMake(x_point+5, 9, 18, 18);
        x_point += 23;
        
    }
    if (model.hot.intValue == 1 ) {
        self.hotImg.hidden = NO;
        self.hotImg.frame = CGRectMake(x_point+5, 9, 18, 18);
        x_point += 23;
        
    }
    if (model.pic_list != nil&& ![model.pic_list isEqualToString:@""]) {
        self.photoImg.hidden = NO;
        self.photoImg.frame = CGRectMake(x_point+5, 9, 18, 18);
        x_point +=23;
    }
    

    
    self.title.frame = CGRectMake(x_point+10, 6, kScreenWidth-(x_point+20), 21);
    
    self.title.font = [UIFont systemFontOfSize:ZOOM(48)];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
