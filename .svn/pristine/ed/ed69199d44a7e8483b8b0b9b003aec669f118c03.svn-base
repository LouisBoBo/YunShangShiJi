//
//  TaskFinishPopview.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/10/12.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TaskFinishPopview.h"
#import "GlobalTool.h"
@implementation TaskFinishPopview

- (instancetype)initWithFrame:(CGRect)frame andbalance:(NSString*)balance
{
    if(self = [super initWithFrame:frame])
    {
        [self creatPopView:nil];
    }
    return self;
}

#pragma mark 签到说明、夺宝弹框
-(void)creatPopView:(NSString*)str
{
    _Popview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    _Popview.userInteractionEnabled = YES;
    
    //弹框内容
    _InvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(120), ZOOM(420)-(IMGSIZEW(@"icon_close1")/2), kScreenWidth-ZOOM(120)*2, kScreenHeight-ZOOM(420)*2+IMGSIZEW(@"icon_close1"))];
    _InvitationCodeView.backgroundColor=[UIColor clearColor];
    
    _InvitationCodeView.clipsToBounds = YES;
    [_Popview addSubview:_InvitationCodeView];
    
    //关闭按钮
    CGFloat btnwidth = IMGSIZEW(@"icon_close1");
    
    _canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _canclebtn.frame=CGRectMake(CGRectGetWidth(_InvitationCodeView.frame)-btnwidth-ZOOM(10), 0, btnwidth, btnwidth);
    [_canclebtn setImage:[UIImage imageNamed:@"icon_close1"] forState:UIControlStateNormal];
    _canclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    _canclebtn.layer.cornerRadius=btnwidth/2;
    [_canclebtn addTarget:self action:@selector(remindViewHiden) forControlEvents:UIControlEventTouchUpInside];
    [_InvitationCodeView addSubview:_canclebtn];
    
    _backview = [[UIView alloc]initWithFrame:CGRectMake(0,btnwidth+ZOOM(30), kScreenWidth-ZOOM(120)*2,CGRectGetHeight(_InvitationCodeView.frame)-btnwidth-ZOOM(30))];
    _backview.backgroundColor=[UIColor whiteColor];
    _backview.layer.cornerRadius=5;
    _backview.clipsToBounds = YES;
    [_InvitationCodeView addSubview:_backview];
    
    UIImageView *bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _InvitationCodeView.frame.size.width, _InvitationCodeView.frame.size.height/8)];
    bgImg.backgroundColor=tarbarrossred;
    [_backview addSubview:bgImg];
    
    
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bgImg.frame), CGRectGetHeight(bgImg.frame))];
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.font = [UIFont systemFontOfSize:ZOOM(70)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    [_backview addSubview:titlelabel];
    
   
    _InvitationCodeView.frame = CGRectMake(ZOOM(120), (kScreenHeight - ZOOM6(580))/2, kScreenWidth-ZOOM(120)*2, ZOOM6(580));
    
    _backview.frame = CGRectMake(0,0, kScreenWidth-ZOOM(120)*2,CGRectGetHeight(_InvitationCodeView.frame));
    
    
    titlelabel.text = @"任务完成!";
    
    _canclebtn.frame=CGRectMake(CGRectGetWidth(_InvitationCodeView.frame)-btnwidth-ZOOM(10), (CGRectGetHeight(bgImg.frame)-btnwidth)/2, btnwidth, btnwidth);
    [_canclebtn setImage:[UIImage imageNamed:@"qiandao_icon_close"] forState:UIControlStateNormal];
    
    [_backview addSubview:_canclebtn];
    
    [self creatDuobao:bgImg Value:nil];
    
    [_Popview addSubview:_InvitationCodeView];
    [self addSubview:_Popview];

    _InvitationCodeView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _InvitationCodeView.alpha = 0.5;
    
    _Popview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _Popview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        _InvitationCodeView.transform = CGAffineTransformMakeScale(1, 1);
        _InvitationCodeView.alpha = 1;
        
    } completion:^(BOOL finish) {
        
    }];
    
}


- (void)creatDuobao:(UIView*)headview Value:(NSString*)valuestr
{
    _titlelab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(headview.frame), CGRectGetWidth(_InvitationCodeView.frame)-40, 40)];
    _titlelab.text = @"诗酒风流诗酒风流双截龙放假时间发";
    
    _discriptionlab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_titlelab.frame), CGRectGetWidth(_InvitationCodeView.frame)-40, 40)];
    _discriptionlab.textColor = RGBCOLOR_I(125, 125, 125);
    _discriptionlab.text = @"诗酒风流诗酒风流双截龙放假时间发";
    
    _bwlklab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_discriptionlab.frame), CGRectGetWidth(_InvitationCodeView.frame)-40, 40)];
    _bwlklab.textColor = tarbarrossred;
    _bwlklab.text = @"诗酒风流诗酒风流双截龙放假时间发";
    
    [_backview addSubview:_titlelab];
    [_backview addSubview:_discriptionlab];
    [_backview addSubview:_bwlklab];
    
    CGFloat gobtnWidth = (CGRectGetWidth(_InvitationCodeView.frame)-2*20-20)/2;
    CGFloat gobtnHeigh = ZOOM(36*3.4);
    
    for(int k =0;k<2;k++)
    {
        UIButton *gobtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        gobtn.frame = CGRectMake(20+(gobtnWidth+20)*k, CGRectGetHeight(_InvitationCodeView.frame)-ZOOM6(150), gobtnWidth, gobtnHeigh);
        gobtn.backgroundColor = tarbarrossred;
        gobtn.clipsToBounds = YES;
        gobtn.layer.cornerRadius = 5;
        gobtn.tag = 7788+k;
        [gobtn setTintColor:[UIColor whiteColor]];
        
        if(k==0)
        {
            [gobtn setTitle:@"知道了" forState:UIControlStateNormal];
            
        }else if (k==1)
        {
            [gobtn setTitle:@"去逛逛" forState:UIControlStateNormal];
        }
        
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(51)];
        [gobtn addTarget:self action:@selector(goClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backview addSubview:gobtn];
    }
    
}

#pragma mark ******** 弹框点击事件 **********
- (void)goClick:(UIButton*)sender
{
    if(sender.tag == 7788)//签到
    {
        if(self.leftHideMindBlock)
        {
            self.leftHideMindBlock();
        }
        
    }else if (sender.tag == 7789)//钱包
    {
        if(self.leftHideMindBlock)
        {
            self.rightHideMindBlock();
        }
    }
    
}

//弹框消失
- (void)remindViewHiden
{
    [_canclebtn removeFromSuperview];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _Popview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        _InvitationCodeView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        _InvitationCodeView.alpha = 0;
        
    } completion:^(BOOL finish) {
        
        [_Popview removeFromSuperview];
        _Popview = nil;
    }];

}

@end
