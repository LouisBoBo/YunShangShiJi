//
//  commentView.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/4/8.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "commentView.h"
#import "GlobalTool.h"
#import "CommetReplyModel.h"
@implementation commentView

- (instancetype)initWithFrame:(CGRect)frame data:(IntimateCircleModel*)model;
{
    if(self = [super initWithFrame:frame])
    {
        [self creatMainview];
    }
    return self;
}

- (void)creatMainview
{
    self.backview = [[UIView alloc]initWithFrame:self.bounds];
    for(int i =0; i<5;i++)
    {
        UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), i*ZOOM6(40), self.frame.size.width-2*ZOOM6(20), ZOOM6(40))];
        titlelab.textColor = RGBCOLOR_I(125, 125, 125);
        titlelab.font = [UIFont systemFontOfSize:ZOOM6(26)];
        titlelab.tag = 80000+i;
        titlelab.text = @"";
        [self.backview addSubview:titlelab];
    }

    [self addSubview:self.backview];
}

- (void)refreshView:(IntimateCircleModel*)model
{
    int count = model.commentArray.count>5?5:(int)model.commentArray.count;
    for(int i =0; i<count;i++)
    {
        CommetReplyModel *commodel = model.commentArray[i];
        UILabel *titlelab = [self.backview viewWithTag:80000+i];
        
        if(commodel.receive_nickname != nil)
        {
            titlelab.text = [NSString stringWithFormat:@"%@回复%@：%@",commodel.send_nickname,commodel.receive_nickname,commodel.content];
        }else{
            titlelab.text = [NSString stringWithFormat:@"%@：%@",commodel.send_nickname,commodel.content];
        }
        
        NSMutableAttributedString *noteStr ;
        if(titlelab.text)
        {
            noteStr = [[NSMutableAttributedString alloc]initWithString:titlelab.text];
        }
        NSString *str1;
        
        NSString *str2;
        
        if(commodel.send_nickname)
        {
            str1 =[NSString stringWithFormat:@"%@",commodel.send_nickname];
            str1.length>0?[noteStr addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(0, str1.length)]:nil;
            
            if(commodel.receive_nickname)
            {
                str2 =[NSString stringWithFormat:@"%@",commodel.receive_nickname];
                str2.length>0?[noteStr addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(str1.length+2, str2.length)]:nil;
            }
        }
        [titlelab setAttributedText:noteStr];
    }
    
    }
@end
