//
//  RedXuanfuHongBao.m
//  YunShangShiJi
//
//  Created by hebo on 2019/1/22.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "RedXuanfuHongBao.h"
#import "OneYuanModel.h"
#import "vipInfoModel.h"
@implementation RedXuanfuHongBao

- (instancetype)initWithFrame:(CGRect)frame isShouYeThree:(BOOL)isShouYeThree
{
    if(self = [super initWithFrame:frame])
    {
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
        self.isShouYeThree = isShouYeThree;
        self.isNewUser = token.length > 10 ? NO:YES;
        self.is_vip = 0;
        if(token.length > 10)
        {
            [vipInfoModel addUserVipOrderSuccess:^(id data) {
                vipInfoModel *model = data;
                self.is_vip = model.isVip ? model.isVip:0;
                [self creatHongBaoview];
            }];
        }else{
            [self creatHongBaoview];
        }
    }
    
    return self;
}

- (void)creatHongBaoview
{
    self.xuanfuHongbaoview = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    self.xuanfuHongbaoview.backgroundColor = [UIColor clearColor];
    if(self.isShouYeThree)
    {
        [self.xuanfuHongbaoview setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/small-signRedHongBao.png"]]]] forState:UIControlStateNormal];
    }else{
        if(self.is_vip == 0)
        {
            [self.xuanfuHongbaoview setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/smallRedHongbao_nintymoney.png"]]]] forState:UIControlStateNormal];
        }else{
            [self.xuanfuHongbaoview setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/smallRedHongbao_hundredmoney.png"]]]] forState:UIControlStateNormal];
        }
    }
   
    [self.xuanfuHongbaoview addTarget:self action:@selector(lingClick:) forControlEvents:UIControlEventTouchUpInside];

    [self creatAnimation2];
    
    [self addSubview:self.xuanfuHongbaoview];
}
- (void)refreshXuanfuImage
{
    [vipInfoModel addUserVipOrderSuccess:^(id data) {
        vipInfoModel *model = data;
        self.is_vip = model.isVip ? model.isVip:0;
        if(self.is_vip == 0)
        {
            [self.xuanfuHongbaoview setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/smallRedHongbao_nintymoney.png"]]]] forState:UIControlStateNormal];
        }else{
            [self.xuanfuHongbaoview setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/smallRedHongbao_hundredmoney.png"]]]] forState:UIControlStateNormal];
        }
    }];
}
//左右晃动
- (void)creatAnimation
{
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    shake.fromValue = [NSNumber numberWithFloat:-3];
    shake.toValue = [NSNumber numberWithFloat:3];
    shake.duration = 0.2;//执行时间
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = 100000;//次数
    [self.xuanfuHongbaoview.layer addAnimation:shake forKey:@"shakeAnimation"];
    self.xuanfuHongbaoview.alpha = 1.0;
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{
        //self.infoLabel.alpha = 0.0; //透明度变0则消失
    } completion:nil];
}

//上下跳动
- (void)creatAnimation1
{
    CGFloat duration = 1.f;
    
    CGFloat height = 7.f;
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    CGFloat currentTy = self.xuanfuHongbaoview.transform.ty;
    animation.duration = duration;
    animation.values = @[@(currentTy), @(currentTy - height/4), @(currentTy-height/4*2), @(currentTy-height/4*3), @(currentTy - height), @(currentTy-height/4*3), @(currentTy -height/4*2), @(currentTy - height/4), @(currentTy)];
    animation.keyTimes = @[ @(0), @(0.025), @(0.085), @(0.2), @(0.5), @(0.8), @(0.915), @(0.975), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = HUGE_VALF;
    [self.xuanfuHongbaoview.layer addAnimation:animation forKey:@"kViewShakerAnimationKey"];
}

//摇摆动画
- (void)creatAnimation2
{
    CABasicAnimation *momAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    momAnimation.fromValue = [NSNumber numberWithFloat:-0.2];
    momAnimation.toValue = [NSNumber numberWithFloat:0.2];
    momAnimation.duration = 0.4;
    momAnimation.repeatCount = CGFLOAT_MAX;
    momAnimation.autoreverses = YES;
    momAnimation.delegate = self;
    momAnimation.removedOnCompletion=NO;
    momAnimation.fillMode=kCAFillModeForwards;
    [self.xuanfuHongbaoview.layer addAnimation:momAnimation forKey:@"animateLayer"];
}
//缩放动画
- (void)creatAnimation3
{
    CABasicAnimation*animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue=[NSNumber numberWithFloat:0.8];
    animation.toValue=[NSNumber numberWithFloat:1.1];
    animation.autoreverses=YES;
    animation.repeatCount= CGFLOAT_MAX;
    animation.duration= 0.5;//不设置时候的话，有一个默认的缩放时间.
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    [self.xuanfuHongbaoview.layer addAnimation:animation forKey:@"animateLayer"];
}

//组合动画
- (void)creatGroupAnimation
{
    CABasicAnimation *momAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    momAnimation.fromValue = [NSNumber numberWithFloat:-0.2];
    momAnimation.toValue = [NSNumber numberWithFloat:0.2];
    momAnimation.duration = 0.4;
    momAnimation.repeatCount = CGFLOAT_MAX;
    momAnimation.autoreverses = YES;
    momAnimation.delegate = self;
    
    CABasicAnimation*animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue=[NSNumber numberWithFloat:0.8];
    animation.toValue=[NSNumber numberWithFloat:1.1];
    animation.autoreverses=YES;
    animation.repeatCount= CGFLOAT_MAX;
    animation.duration= 0.5;//不设置时候的话，有一个默认的缩放时间.
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    
    CAAnimationGroup *groupAnnimation = [CAAnimationGroup animation];
    groupAnnimation.duration = 2;
    groupAnnimation.autoreverses = YES;
    groupAnnimation.animations = @[momAnimation, animation];
    groupAnnimation.repeatCount = MAXFLOAT;
    
    //开演
    [self.xuanfuHongbaoview.layer addAnimation:groupAnnimation forKey:@"groupAnnimation"];
}

- (void)lingClick:(UIButton*)sender
{
    if(self.lingHongBaoBlock)
    {
        self.lingHongBaoBlock(self.isNewUser);
    }
}
@end
