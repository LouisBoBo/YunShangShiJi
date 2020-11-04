//
//  DoubleRemindView.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/8/15.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "DoubleRemindView.h"
#import "GlobalTool.h"
@implementation DoubleRemindView

- (instancetype)initWithFrame:(CGRect)frame andbalance:(NSString*)balance
{
    if(self = [super initWithFrame:frame])
    {
        _balance = balance;
        [self creatMainView];
    }
    return self;
}

- (void)creatMainView
{
    _SharePopview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    
    _SharePopview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _SharePopview.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapper)];
    [_SharePopview addGestureRecognizer:tap];
    
    CGFloat invitcodeYY = ZOOM(420);
    CGFloat invitcodeWith = ZOOM6(700);
    //弹框内容
    _ShareInvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(120), (kScreenHeight-invitcodeWith)/2, kScreenWidth-ZOOM(120)*2, invitcodeWith)];
    [_SharePopview addSubview:_ShareInvitationCodeView];
    
    CGFloat imgHeigh = IMGSIZEH(@"-congratulation");
    
    _SharebackView = [[UIView alloc]initWithFrame:CGRectMake(0,imgHeigh/2, kScreenWidth-ZOOM(120)*2, CGRectGetHeight(_ShareInvitationCodeView.frame)-imgHeigh/2)];
    _SharebackView.backgroundColor=[UIColor whiteColor];
    _SharebackView.layer.cornerRadius=5;
    _SharebackView.clipsToBounds = YES;
    _SharebackView.userInteractionEnabled = YES;
    [_ShareInvitationCodeView addSubview:_SharebackView];
    
    _SharetitleImg = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(120), 0, CGRectGetWidth(_ShareInvitationCodeView.frame)-2*ZOOM(120), imgHeigh)];
    _SharetitleImg.image = [UIImage imageNamed:@"-congratulation"];
    [_ShareInvitationCodeView addSubview:_SharetitleImg];
    
    
    //弹框内容
    [self creatshare];
    
    [self addSubview:_SharePopview];
    
    _ShareInvitationCodeView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _ShareInvitationCodeView.alpha = 0.5;
    
    _SharePopview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _SharePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        _ShareInvitationCodeView.transform = CGAffineTransformMakeScale(1, 1);
        _ShareInvitationCodeView.alpha = 1;
        
    } completion:^(BOOL finish) {
        
    }];
    
    
}

- (void)creatshare
{
    
    CGFloat headimageW = IMGSIZEW(@"yuefanbei");;
    CGFloat headimageH = IMGSIZEH(@"yuefanbei");
    CGFloat headimageY = ZOOM(40*3.4);
    
    UIImageView *headimage = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(_SharebackView.frame)-headimageW)/2, headimageY, headimageW, headimageH)];
    headimage.image = [UIImage imageNamed:@"yuefanbei"];
    [_SharebackView addSubview:headimage];
    
    
    UILabel *titlelab1 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(headimage.frame), CGRectGetWidth(_SharebackView.frame)-40, 0)];
    titlelab1.textColor = tarbarrossred;
    titlelab1.textAlignment = NSTextAlignmentCenter;
    titlelab1.font = [UIFont systemFontOfSize:ZOOM(51)];
    
    UILabel *titlelab2 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(titlelab1.frame), CGRectGetWidth(_SharebackView.frame)-40, ZOOM6(120))];
    titlelab2.textColor = tarbarrossred;
    
    titlelab2.font = [UIFont systemFontOfSize:ZOOM6(30)];
    
    titlelab2.textColor = kTextColor;
    titlelab2.numberOfLines = 0;
    
    //按钮
    CGFloat gobtnWidth = (CGRectGetWidth(_SharebackView.frame)-2*20-20)/2;
    CGFloat gobtnHeigh = ZOOM(36*3.4);
    
    CGFloat spaceHeigh = 0;
    
    for(int k =0;k<2;k++)
    {
        UIButton *gobtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        gobtn.frame = CGRectMake(20+(gobtnWidth+20)*k, CGRectGetMaxY(titlelab2.frame)+ZOOM(15*3.4) +spaceHeigh, gobtnWidth, gobtnHeigh);
        gobtn.backgroundColor = tarbarrossred;
        gobtn.clipsToBounds = YES;
        gobtn.tag = 7788+k;
        gobtn.layer.cornerRadius = 5;
        [gobtn setTintColor:[UIColor whiteColor]];
        
        
        [self buttontitle:nil button:gobtn Image:headimage Lab1:titlelab1 Lab2:titlelab2];
        
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(51)];
        [gobtn addTarget:self action:@selector(goClick:) forControlEvents:UIControlEventTouchUpInside];
        [_SharebackView addSubview:gobtn];
    }
    
    
    [_SharebackView addSubview:titlelab1];
    [_SharebackView addSubview:titlelab2];
    
    
}

- (void)buttontitle:(NSString*)type button:(UIButton*)mybtn Image:(UIImageView*)headimage Lab1:(UILabel*)lab1 Lab2:(UILabel*)lab2
{
    
    mybtn.hidden = NO;
    
    if(mybtn.tag == 7789)
    {
        [mybtn setTitle:@"立即翻倍" forState:UIControlStateNormal];
    }else{
        [mybtn setTitle:@"继续提现" forState:UIControlStateNormal];
        mybtn.backgroundColor = [UIColor clearColor];
        mybtn.tintColor = tarbarrossred;
        mybtn.layer.borderColor = tarbarrossred.CGColor;
        mybtn.layer.borderWidth=1;
    }
    
    NSString *balance = [self notRounding:[_balance floatValue]*2 afterPoint:2];

    lab2.text = [NSString stringWithFormat:@"幸运女神降临，您免费获得1次余额翻倍的机会，余额可变为%@元，立即开启翻倍买买买吧~",balance];
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

- (void)disapper
{
    if(self.tapHideMindBlock)
    {
        self.tapHideMindBlock();
    }
}

//弹框消失
- (void)remindViewHiden
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _SharePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        _ShareInvitationCodeView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        _ShareInvitationCodeView.alpha = 0;
        
    } completion:^(BOOL finish) {
        
        [self removeFromSuperview];
      
    }];

}

/// price:需要处理的数字，position：保留小数点第几位
- (NSString *)notRounding:(CGFloat)price afterPoint:(int)position {
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];;
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

@end
