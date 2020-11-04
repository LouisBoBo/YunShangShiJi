//
//  FriendSharePopview.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/11/1.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "FriendSharePopview.h"
#import "GlobalTool.h"

@interface FriendSharePopview ()<CAAnimationDelegate>

@property (nonatomic, strong)UIImage *headImage;
@property (nonatomic, copy)NSString *content;

@property (nonatomic, copy)NSString *upTitle;
@property (nonatomic, copy)NSString *downTitle;

@property (nonatomic, assign)CGFloat raward;

@property (nonatomic, strong) UIButton *upBtn;
@property (nonatomic, strong) UIButton *downBtn;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation FriendSharePopview

- (id)initWithHeadImage:(UIImage *)headImage
            contentText:(NSString *)content
          upButtonTitle:(NSString *)upTitle
        downButtonTitle:(NSString *)downTitle
             RawardType:(FriendShareType)type Raward:(CGFloat)raward;
{
    if (self = [super init]) {
        
        UIImage *newimage ;
        NSString *newtext ;
        NSString *newuptitle ;
        NSString *newdowntitle ;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancalBtnClick:)];
        [self addGestureRecognizer:tap];
        
        if(type == FriendShare_success)
        {
            newimage = [UIImage imageNamed:@"icon_weizhongjiang"];
            newtext = @"分享3个好友，拿到150元成功率\n高达98%";
            newuptitle = @"继续分享";
            newdowntitle = @"我也要去赚赚赚";
        }
        
        self.content = newtext;
        self.upTitle = newuptitle;
        self.downTitle = newdowntitle;
        self.headImage = newimage;
        self.raward = raward;
        
        
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        CGFloat M_lr = (CGRectGetWidth(self.frame)-ZOOM6(570))/2;
        CGFloat H = ZOOM6(660);
        
        CGFloat space = 0;
        UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr, (CGRectGetHeight(self.frame)-H)/2+space, CGRectGetWidth(self.frame)-2*M_lr, H)];
        backView.userInteractionEnabled = YES;
        backView.backgroundColor = [UIColor whiteColor];
        backView.layer.cornerRadius = 5;
        [self addSubview:_backgroundView = backView];
        
        
        CGFloat W_H = ZOOM(220);
        CGFloat M = ZOOM6(70);
        CGFloat W_back = CGRectGetWidth(self.backgroundView.frame);
        
        //headimage
        UIImageView *headimageview = [[UIImageView alloc]initWithFrame:CGRectMake((W_back - ZOOM6(250))/2, ZOOM6(60), ZOOM6(60), ZOOM6(60))];
        headimageview.image = [UIImage imageNamed:@"成功"];
        [self.backgroundView addSubview:headimageview];
        
        //head
        UIButton *headbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        headbtn.frame = CGRectMake(CGRectGetMaxX(headimageview.frame), ZOOM6(65), ZOOM6(200), ZOOM6(50));
        [headbtn setTintColor:RGBCOLOR_I(62, 62, 62)];
        headbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
        [self.backgroundView addSubview:headbtn];
        
        //title
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headimageview.frame)+ZOOM6(30), W_back, ZOOM6(70))];
        contentLabel.numberOfLines = 0;
        contentLabel.text = self.content;
        contentLabel.textColor = RGBCOLOR_I(125, 125, 125);
        contentLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        [self.backgroundView addSubview:_contentLabel = contentLabel];
        
        //上按钮
        UIButton *upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        upBtn.frame = CGRectMake(M, CGRectGetMaxY(contentLabel.frame)+ZOOM6(40), W_back-M*2, W_H*0.5);
        [upBtn setTitle:self.upTitle forState:UIControlStateNormal];
        [upBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        upBtn.layer.cornerRadius = 5;
        upBtn.layer.masksToBounds = YES;
        [upBtn setBackgroundImage:[UIImage imageWithColor:tarbarrossred] forState:UIControlStateNormal];
        upBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(32)];
        [upBtn addTarget:self action:@selector(upBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backgroundView addSubview:_upBtn = upBtn];
        
        UILabel *linelab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(100), CGRectGetMaxY(self.upBtn.frame)+ZOOM6(50), W_back-2*ZOOM6(100), 0.5)];
        linelab.backgroundColor = tarbarrossred;
        [self.backgroundView addSubview:linelab];
        
        UILabel *linestrlab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(220), CGRectGetMaxY(self.upBtn.frame)+ZOOM6(30), W_back-2*ZOOM6(220), ZOOM6(40))];
        linestrlab.backgroundColor = [UIColor whiteColor];
        linestrlab.text = @"赚钱提示";
        linestrlab.font = [UIFont systemFontOfSize:ZOOM6(24)];
        linestrlab.textAlignment = NSTextAlignmentCenter;
        linestrlab.textColor = tarbarrossred;
        [self.backgroundView addSubview:linestrlab];
        
        UILabel *discriptionlab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(50), CGRectGetMaxY(linestrlab.frame)+ZOOM6(20), W_back-2*ZOOM6(50), ZOOM6(70))];
        discriptionlab.text = @"80%的人已完成今天全部任务\n领到20元奖励哦~";
        discriptionlab.textAlignment = NSTextAlignmentCenter;
        discriptionlab.font = [UIFont systemFontOfSize:ZOOM6(28)];
        discriptionlab.textColor = RGBCOLOR_I(125, 125, 125);
        discriptionlab.numberOfLines = 0;
        [self.backgroundView addSubview:discriptionlab];
        
        //下按钮
        UIButton *downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        downBtn.frame = CGRectMake(M, CGRectGetMaxY(discriptionlab.frame)+ZOOM(60), W_back-M*2, W_H*0.5);
        [downBtn setTitleColor:tarbarrossred forState:UIControlStateNormal];
        [downBtn setTitle:self.downTitle forState:UIControlStateNormal];
        downBtn.layer.cornerRadius = 5;
        downBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(32)];
        downBtn.layer.masksToBounds = YES;
        downBtn.layer.borderWidth = 1;
        downBtn.layer.borderColor = tarbarrossred.CGColor;
        [downBtn addTarget:self action:@selector(downBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backgroundView addSubview:_downBtn = downBtn];
        
        //关闭按钮
        UIButton *cancalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancalBtn.frame = CGRectMake(CGRectGetWidth(self.backgroundView.frame)-ZOOM(80)-ZOOM(30), ZOOM(30), ZOOM(80), ZOOM(80));
        [cancalBtn setImage:[UIImage imageNamed:@"TFWXWithdrawals_weixintixian_close_icon@2x"] forState:UIControlStateNormal];
        [cancalBtn addTarget:self action:@selector(cancalBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backgroundView addSubview:cancalBtn];
        
        if(type == FriendShare_success)
        {
            [headbtn setTitle:[NSString stringWithFormat:@"%@",@"分享成功!"] forState:UIControlStateNormal];
        }
        
        _backgroundView.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _backgroundView.alpha = 0;
        
    }
    
    return self;
}

- (CAAnimation *)animationRotate
{
    CATransform3D rotationTransform  = CATransform3DMakeRotation(M_PI, 0, -1, 0);
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.toValue        = [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration        = 0.3;
    animation.autoreverses    = YES;
    animation.cumulative    = YES;
    animation.repeatCount    = 2;
    animation.beginTime        = 0.1;
    animation.delegate        = self;
    
    return animation;
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(self.headBlock)
    {
        self.headBlock();
    }
    
    [self dismissAlert:NO];
    
}
- (void)buttonAnimation:(id) sender{
    
    UIButton *theButton = sender;
    CAAnimation* myAnimationRotate    = [self animationRotate];
    
    CAAnimationGroup *m_pGroupAnimation    = [CAAnimationGroup animation];
    m_pGroupAnimation.delegate = self;
    m_pGroupAnimation.removedOnCompletion = NO;
    m_pGroupAnimation.duration             = 1;
    m_pGroupAnimation.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    m_pGroupAnimation.repeatCount         = 1;//FLT_MAX;  //"forever";
    m_pGroupAnimation.fillMode            = kCAFillModeForwards;
    m_pGroupAnimation.animations             = [NSArray arrayWithObjects:myAnimationRotate, nil];
    
    [theButton.layer addAnimation:m_pGroupAnimation forKey:@"animationRotate"];
}

- (void)tapGRClicK:(UITapGestureRecognizer *)sender
{
    [self dismissAlert:YES];
}

- (void)cancalBtnClick:(UIButton *)sender
{
    [self dismissAlert:YES];
}

- (void)headclick:(UIButton *)sender
{
    sender.userInteractionEnabled = NO;
    
    UIButton *theButton = sender;
    CAAnimation* myAnimationRotate    = [self animationRotate];
    
    CAAnimationGroup *m_pGroupAnimation    = [CAAnimationGroup animation];
    m_pGroupAnimation.delegate = self;
    m_pGroupAnimation.removedOnCompletion = NO;
    m_pGroupAnimation.duration             = 1;
    m_pGroupAnimation.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    m_pGroupAnimation.repeatCount         = 1;//FLT_MAX;  //"forever";
    m_pGroupAnimation.fillMode             = kCAFillModeForwards;
    m_pGroupAnimation.animations             = [NSArray arrayWithObjects:myAnimationRotate, nil];
    
    [theButton.layer addAnimation:m_pGroupAnimation forKey:@"animationRotate"];
}

- (void)upBtnClick:(UIButton *)sender
{
    sender.userInteractionEnabled = NO;
    if (self.upBlock!=nil) {
        self.upBlock();
    }
    [self dismissAlert:NO];
}

- (void)downBtnClick:(UIButton *)sender
{
    sender.userInteractionEnabled = NO;
    if (self.downBlock!= nil) {
        self.downBlock();
    }
    [self dismissAlert:NO];
}


- (void)dismissAlert:(BOOL)animation
{
    
    if (animation) {
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0;
            self.backgroundView.transform = CGAffineTransformMakeScale(0.25, 0.25);
            self.backgroundView.alpha = 0;
        } completion:^(BOOL finish) {
            if (self.dismissBlock!=nil) {
                self.dismissBlock();
                [self removeFromSuperview];
            } else {
                [self removeFromSuperview];
            }
        }];
    } else {
        if (self.dismissBlock!=nil) {
            self.dismissBlock();
            [self removeFromSuperview];
        } else {
            [self removeFromSuperview];
        }
    }
}

- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.center = CGPointMake(kScreenWidth*0.5, kScreenHeight*0.5);
    [window addSubview:self];
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        self.backgroundView.transform = CGAffineTransformMakeScale(1, 1);
        self.backgroundView.alpha = 1;
    } completion:^(BOOL finish) {
        
    }];
    
}

- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

@end
