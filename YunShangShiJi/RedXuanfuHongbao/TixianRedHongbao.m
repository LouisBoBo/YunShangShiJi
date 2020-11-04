//
//  TixianRedHongbao.m
//  YunShangShiJi
//
//  Created by hebo on 2019/1/22.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "TixianRedHongbao.h"
#import "OneYuanModel.h"
#import "hongBaoModel.h"
@implementation TixianRedHongbao
- (instancetype)initWithFrame:(CGRect)frame Nextpop:(double)lastTime
{
    if(self = [super initWithFrame:frame])
    {
        [self creaPopview];
    }
    
    return self;
}

- (void)creaPopview
{
    _SharePopview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    
    _SharePopview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _SharePopview.userInteractionEnabled = YES;
    
    CGFloat invitcodeYY = (kScreenHeight - ZOOM6(1000))/2+ZOOM6(30);
    CGFloat ShareInvitationCodeViewHeigh = ZOOM6(843);
    
    //弹框最底层
    _shareInvitationBackView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(30), invitcodeYY, kScreenWidth-ZOOM(30)*2, ShareInvitationCodeViewHeigh)];
    [_SharePopview addSubview:_shareInvitationBackView];
    
    //弹框内容
    _ShareInvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM6(50), 0, CGRectGetWidth(_shareInvitationBackView.frame)-ZOOM6(50)*2, ShareInvitationCodeViewHeigh)];
    _ShareInvitationCodeView.layer.cornerRadius = 5;
    _ShareInvitationCodeView.clipsToBounds = YES;
    _ShareInvitationCodeView.backgroundColor = [UIColor clearColor];
    [_shareInvitationBackView addSubview:_ShareInvitationCodeView];
    
    
    //关闭按钮
    CGFloat btnwidth = ZOOM6(50);
    _canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _canclebtn.frame=CGRectMake(CGRectGetWidth(_ShareInvitationCodeView.frame)-btnwidth, 0, btnwidth, btnwidth);
    [_canclebtn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/task_icon_close.png"]]]] forState:UIControlStateNormal];
    _canclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    _canclebtn.layer.cornerRadius=btnwidth/2;
    [_canclebtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    [_ShareInvitationCodeView addSubview:_canclebtn];
    
    self.bigImageview = [[UIImageView alloc]initWithFrame:CGRectMake(0,ZOOM6(60), CGRectGetWidth(_ShareInvitationCodeView.frame), CGRectGetHeight(_ShareInvitationCodeView.frame)-ZOOM6(60))];
    if(self.isNewUser)
    {
        [self.bigImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/newredhongbao_Junefreeling.png"]]];
    }else{
        self.bigImageview.image = [UIImage imageNamed:@"fifty_hongbao.png"];
    }
    self.bigImageview.image = [UIImage imageNamed:@"newestredhongbao_getnewuser_ninetymoney.png"];
    
    self.bigImageview.userInteractionEnabled = YES;
    [_ShareInvitationCodeView addSubview:self.bigImageview];
    
    CGFloat width = ZOOM6(200);
    self.lingButton = [[UIImageView alloc]init];
    self.lingButton.frame = CGRectMake((CGRectGetWidth(_ShareInvitationCodeView.frame)-width)/2, CGRectGetHeight(_ShareInvitationCodeView.frame)*0.65, width, width);
    self.lingButton.image = [UIImage imageNamed:@"ling_hongbao.png"];
    self.lingButton.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lingClick:)];
    [self.lingButton addGestureRecognizer:tap];
    [_ShareInvitationCodeView addSubview:self.lingButton];
    
    
    _shareInvitationBackView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _shareInvitationBackView.alpha = 0.5;
    _SharePopview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [UIView animateWithDuration:0.5 animations:^{
        
        _SharePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        _shareInvitationBackView.transform = CGAffineTransformMakeScale(1, 1);
        _shareInvitationBackView.alpha = 1;
        
    } completion:^(BOOL finish) {
        
    }];
    
    [self addSubview:_SharePopview];
    
    [self creatAnimation3];
}

- (void)lingClick:(UITapGestureRecognizer*)sender
{
    [self remindViewHiden];
//    [self getMiniShareData];
    
    if(self.lingHongBaoBlock)
    {
        self.lingHongBaoBlock(self.isNewUser);
    }
}
- (void)cancleClick
{
    if(self.closeHongBaoBlack)
    {
        self.closeHongBaoBlack(self.homePage3ElastTime);
    }
    [self remindViewHiden];
}
#pragma mark 弹框消失
- (void)remindViewHiden
{
    [UIView animateWithDuration:0.5 animations:^{
        
        _SharePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        _shareInvitationBackView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        _shareInvitationBackView.alpha = 0;
        
    } completion:^(BOOL finish) {
        
        [self removeFromSuperview];
    }];
    
}

//缩放动画
- (void)creatAnimation3
{
    CABasicAnimation*animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    animation.toValue=[NSNumber numberWithFloat:1.2];
    animation.autoreverses=YES;
    animation.repeatCount= CGFLOAT_MAX;
    animation.duration= 0.5;//不设置时候的话，有一个默认的缩放时间.
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    [self.lingButton.layer addAnimation:animation forKey:@"animateLayer"];
}

- (void)getMiniShareData
{
    NSString *URL= [NSString stringWithFormat:@"%@paperwork/paperwork.json",[NSObject baseURLStr_Upy]];
    NSURL *httpUrl=[NSURL URLWithString:URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpUrl];
    request.timeoutInterval = 3;
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *title = @"我刚领的一个红包也分你一个，帮我提现就能拿钱哦~";
            NSString *pic = @"/small-iconImages/heboImg/shareBigImage_new.jpg";
            if (responseObject[@"wxcx_share_links"] != nil ){
                
                if(responseObject[@"wxcx_share_links"][@"title"] != nil)
                {
                    title = [NSString stringWithFormat:@"%@",responseObject[@"wxcx_share_links"][@"title"]];
                    pic = [NSString stringWithFormat:@"%@",responseObject[@"wxcx_share_links"][@"icon"]];
                }
            }
            [self minishareto_xcx:title Pic:pic];
        }
    }
}
- (void)minishareto_xcx:(NSString*)title Pic:(NSString*)pic
{
    MiniShareManager *minishare = [MiniShareManager share];
    
    NSString *sharetitle = title;
    NSString *image = [NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],pic];
    NSString *path  = @"/pages/shouye/redHongBao?shouYePage=ThreePage";
    
    minishare.delegate = self;
    [minishare shareAppWithType:MINIShareTypeWeixiSession Image:image Title:sharetitle Discription:nil WithSharePath:path];
    
    kWeakSelf(self);
    minishare.MinishareFail = ^{
        if(weakself.lingHongBaoBlock)
        {
            weakself.lingHongBaoBlock(self.isNewUser);
        }
    };
}
- (void)remindViewDisapper
{
    [self removeFromSuperview];
}
@end
