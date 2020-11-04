//
//  FreeOrderPopview.m
//  YunShangShiJi
//
//  Created by ios-1 on 2016/11/28.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "FreeOrderPopview.h"
#import "GlobalTool.h"
@implementation FreeOrderPopview
{
    CGFloat shareimageYY ;
    
    CGFloat invitcodeYY;                  //弹框初始y坐标
    CGFloat ShareInvitationCodeViewHeigh; //弹框的高度
    CGFloat ShareInvitationCodeViewWidth; //弹框的宽度
}

- (instancetype)initWithFrame:(CGRect)frame FreeOrderType:(FreeOrderType)FreeOrderType;
{
    if(self = [super initWithFrame:frame])
    {
        self.freeOrderType = FreeOrderType;
        
        [self creaPopview];
    }
    
    return self;
}

- (void)creaPopview
{
    _SharePopview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    
    _SharePopview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _SharePopview.userInteractionEnabled = YES;
    
    ShareInvitationCodeViewWidth = (kScreenWidth-ZOOM(120)*2);
    ShareInvitationCodeViewHeigh = ShareInvitationCodeViewWidth*1.4+ZOOM6(100);
    invitcodeYY = (kScreenHeight - ShareInvitationCodeViewHeigh)/2;
    
    //底视图
    _ShareBackView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(120), invitcodeYY, ShareInvitationCodeViewWidth, ShareInvitationCodeViewHeigh)];
    _ShareBackView.userInteractionEnabled = YES;
    _ShareBackView.backgroundColor = [UIColor clearColor];
    [_SharePopview addSubview:_ShareBackView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclick)];
    [_ShareBackView addGestureRecognizer:tap];
    
    //关闭按钮
    CGFloat btnwidth = ZOOM6(80);
    _canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _canclebtn.frame=CGRectMake(CGRectGetWidth(_ShareBackView.frame)-btnwidth, 0, btnwidth, btnwidth);
    [_canclebtn setImage:[UIImage imageNamed:@"task_icon_close60X60"] forState:UIControlStateNormal];
    _canclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    _canclebtn.layer.cornerRadius=btnwidth/2;
    [_canclebtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    [_ShareBackView addSubview:_canclebtn];
    
    //弹框上大图
    _SignImageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, ZOOM6(100), ShareInvitationCodeViewWidth, ShareInvitationCodeViewHeigh-ZOOM6(100))];
    if(self.freeOrderType == FreeOrder_fifty)
    {
        _SignImageview.image = [UIImage imageNamed:@"pop up_50.jpg"];
    }else if(self.freeOrderType == FreeOrder_hundred)
    {
        _SignImageview.image = [UIImage imageNamed:@"pop up.jpg"];
    }else if (self.freeOrderType == CrazyMonday_activity)
    {
        UIButton *getluckbtn = [[UIButton alloc]init];
        getluckbtn.frame = CGRectMake(0, CGRectGetHeight(_SignImageview.frame)-ZOOM6(80), CGRectGetWidth(_SignImageview.frame),ZOOM6(80));
        getluckbtn.backgroundColor = [UIColor clearColor];
        [getluckbtn addTarget:self action:@selector(getluck) forControlEvents:UIControlEventTouchUpInside];
        
        _SignImageview.userInteractionEnabled = YES;
        _SignImageview.clipsToBounds = YES;
        [_SignImageview addSubview:getluckbtn];
        
        _SignImageview.image = [UIImage imageNamed:@"monday_pop-up_fkxqy"];
    }
    [_ShareBackView addSubview:_SignImageview];
    
    [self addSubview:_SharePopview];
    
    _ShareBackView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _ShareBackView.alpha = 0.5;
    
    _SharePopview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [UIView animateWithDuration:0.5 animations:^{
        
        _SharePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        _ShareBackView.transform = CGAffineTransformMakeScale(1, 1);
        _ShareBackView.alpha = 1;
        
    } completion:^(BOOL finish) {
        
    }];
    
}

#pragma mark ******** 弹框点击事件 **********
- (void)tapclick
{
    if(self.tapHideMindBlock)
    {
        self.tapHideMindBlock();
    }
    
    [self remindViewHiden];
}

#pragma mark 关闭弹框
- (void)cancleClick
{
    [self remindViewHiden];
}

#pragma mark 获取抽奖机会
- (void)getluck
{
    if(self.getLuckBlock)
    {
        self.getLuckBlock();
    }
    [self remindViewHiden];
}
#pragma mark 弹框消失
- (void)remindViewHiden
{
    [UIView animateWithDuration:0.5 animations:^{
        
        _SharePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        _ShareBackView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        _ShareBackView.alpha = 0;
        
    } completion:^(BOOL finish) {
        
        [self removeFromSuperview];
    }];
    
}

@end
