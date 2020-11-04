//
//  RawardRedPopview.m
//  YunShangShiJi
//
//  Created by ios-1 on 2016/12/17.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "RawardRedPopview.h"
#import "GlobalTool.h"

@interface RawardRedPopview ()<CAAnimationDelegate>

@property (nonatomic, strong)UIImage *headImage;
@property (nonatomic, copy)NSString *content;

@property (nonatomic, copy)NSString *upTitle;
@property (nonatomic, copy)NSString *downTitle;

@property (nonatomic, assign)CGFloat raward;
@property (nonatomic, assign)NSInteger cashorEdu;

@property (nonatomic, strong) UIButton *upBtn;
@property (nonatomic, strong) UIButton *downBtn;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation RawardRedPopview

- (id)initWithHeadImage:(UIImage *)headImage
            contentText:(NSString *)content
          upButtonTitle:(NSString *)upTitle
        downButtonTitle:(NSString *)downTitle
             RawardType:(RawardRedType)type Raward:(CGFloat)raward CashorEdu:(NSInteger)cash;
{
    if (self = [super init]) {
        
        UIImage *newimage ;
        NSString *newtext ;
        NSString *newuptitle ;
        NSString *newdowntitle ;
        
        if(type == RawardRed_fail)
        {
            newimage = [UIImage imageNamed:@"icon_weizhongjiang"];
            newtext = @"呀，糟糕，\n没抓住红包溜走了";
            newuptitle = @"再抽一次";
            newdowntitle = @"暂时离开";
        }else if (type == Rawardfive_order_fail)
        {
            newimage = [UIImage imageNamed:@"icon_weizhongjiang"];
            newtext = @"呀，糟糕，\n没抓住红包溜走了";
            newuptitle = @"再抽一次";
        }
        else if (type == RawardRed_success)
        {
            if(cash == 0)//额度
            {
                newtext = [NSString stringWithFormat:@"%.2f元提现额度已经添加至你的可提现帐户，下单商品交易成功后即可自动解冻并提现哦~",raward];
            }else if (cash == 1)//现金
            {
                newtext = [NSString stringWithFormat:@"本次抽中了%.2f元余额，已添加至你的账户中。",raward];
            }
            
            newuptitle = @"继续抽提现额度";
            newdowntitle = @"";
            
        }else if (type == Rawardfive_order_success)
        {
            newtext = [NSString stringWithFormat:@"%.2f元余额红包已经添加至你的帐户余额。",raward];
            newuptitle = @"继续抽奖";
        }
        else if (type == RawardRed_open)
        {
            newimage = [UIImage imageNamed:@"luck-chai"];
            newtext = @"哇喔~抽中了一个红包\n\n点击折红包可以获得随机提现额度";
        }else if (type == Rawardfive_order_open)
        {
            newimage = [UIImage imageNamed:@"luck-chai"];
            newtext = @"哇喔~抽中了一个红包\n\n点击折红包可以获得随机余额红包";
        }else if (type == RawardMondayRed_success)
        {
            newimage = [UIImage imageNamed:@"mandy_chai hongbao"];
            newtext = [NSString stringWithFormat:@"%.2f元提现额度已经添加至你的可提现账户，待到今日下单商品交易完结（不可退款退货）后，即可自动解冻并体现哦~",raward];
            newuptitle = @"继续抽提现额度";
            newdowntitle = @"";
        }else if (type == RawardRed_order_open)
        {
            newimage = [UIImage imageNamed:@"md_chai"];
        }

        self.content = newtext;
        self.upTitle = newuptitle;
        self.downTitle = newdowntitle;
        self.headImage = newimage;
        self.raward = raward;
        self.cashorEdu = cash;
                
        
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        CGFloat M_lr = (CGRectGetWidth(self.frame)-ZOOM6(570))/2;
        CGFloat H = ZOOM6(726);
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRClicK:)];
//        [self addGestureRecognizer:tap];
        CGFloat space = type==RawardMondayRed_success?ZOOM6(50):0;
        UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr, (CGRectGetHeight(self.frame)-H)/2+space, CGRectGetWidth(self.frame)-2*M_lr, H)];
        backView.userInteractionEnabled = YES;
        backView.backgroundColor = RGBCOLOR_I(237, 73, 88);
        backView.layer.cornerRadius = 5;
        [self addSubview:_backgroundView = backView];
        

        CGFloat W_H = ZOOM(220);
        CGFloat M = ZOOM6(70);
        CGFloat W_back = CGRectGetWidth(self.backgroundView.frame);
        
        //headimage
        UIImageView *headimageview = [[UIImageView alloc]initWithFrame:CGRectMake((W_back - ZOOM6(250))/2, -ZOOM6(100), ZOOM6(250), ZOOM6(250))];
        headimageview.hidden = YES;
        headimageview.image = self.headImage;
        [self.backgroundView addSubview:headimageview];
        
        //head
        UIButton *headbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        headbtn.frame = CGRectMake((W_back - ZOOM6(100))/2, ZOOM6(100), ZOOM6(100), ZOOM6(100));
        [self.backgroundView addSubview:headbtn];
        
        //title
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headbtn.frame)+M, W_back, ZOOM6(100))];
        contentLabel.numberOfLines = 0;
        contentLabel.text = self.content;
        contentLabel.textColor = [UIColor whiteColor];
        [self.backgroundView addSubview:_contentLabel = contentLabel];
        
        //上按钮
        UIButton *upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        upBtn.frame = CGRectMake(M, CGRectGetMaxY(contentLabel.frame)+ZOOM6(80), W_back-M*2, W_H*0.5);
        [upBtn setTitle:self.upTitle forState:UIControlStateNormal];
        [upBtn setTitleColor:RGBCOLOR_I(237, 73, 88) forState:UIControlStateNormal];
        upBtn.layer.cornerRadius = 5;
        upBtn.layer.masksToBounds = YES;
        [upBtn setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_I(253, 204, 33)] forState:UIControlStateNormal];
        upBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
        [upBtn addTarget:self action:@selector(upBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backgroundView addSubview:_upBtn = upBtn];
        
        //下按钮
        UIButton *downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        downBtn.frame = CGRectMake(M, CGRectGetMaxY(self.upBtn.frame)+ZOOM(67), W_back-M*2, W_H*0.5);
        [downBtn setTitleColor:RGBCOLOR_I(237, 73, 88) forState:UIControlStateNormal];
        [downBtn setTitle:self.downTitle forState:UIControlStateNormal];
        downBtn.layer.cornerRadius = 5;
        downBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
        downBtn.layer.masksToBounds = YES;
        [downBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [downBtn addTarget:self action:@selector(downBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backgroundView addSubview:_downBtn = downBtn];
        
        //关闭按钮
        UIButton *cancalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancalBtn.frame = CGRectMake(CGRectGetWidth(self.backgroundView.frame)-ZOOM(80)-ZOOM(16), ZOOM(16), ZOOM(80), ZOOM(80));
        [cancalBtn setImage:[UIImage imageNamed:@"luck-icon_close-"] forState:UIControlStateNormal];
        [cancalBtn addTarget:self action:@selector(cancalBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backgroundView addSubview:cancalBtn];
        
        if(type == RawardRed_success)
        {
            headbtn.frame = CGRectMake((W_back - ZOOM6(200))/2, ZOOM6(130), ZOOM6(250), ZOOM6(100));
            [headbtn setTitle:[NSString stringWithFormat:@"%.2f元",self.raward] forState:UIControlStateNormal];
            headbtn.tintColor = RGBCOLOR_I(253, 204, 33);
            headbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(60)];
            
            contentLabel.frame =CGRectMake(ZOOM6(70), CGRectGetMaxY(headbtn.frame)+ZOOM6(30), W_back - ZOOM6(70)*2, ZOOM6(120));
            contentLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
            
            backView.frame = CGRectMake(M_lr, (CGRectGetHeight(self.frame)-H)/2+space, CGRectGetWidth(self.frame)-2*M_lr, H-ZOOM6(100));
            downBtn.hidden = YES;
        }else if (type == RawardRed_fail || type == Rawardfive_order_fail)
        {
            if(type == Rawardfive_order_fail)
            {
                backView.frame = CGRectMake(M_lr, (CGRectGetHeight(self.frame)-H)/2+space, CGRectGetWidth(self.frame)-2*M_lr, H-ZOOM6(110));
                downBtn.hidden = YES;
            }
            headbtn.frame = CGRectMake((W_back - ZOOM6(100))/2, ZOOM6(100), ZOOM6(100), ZOOM6(100));
            [headbtn setBackgroundImage:self.headImage forState:UIControlStateNormal];
            
            contentLabel.frame =CGRectMake(ZOOM6(70), CGRectGetMaxY(headbtn.frame)+ZOOM6(30), W_back - ZOOM6(70)*2, ZOOM6(100));
            contentLabel.textAlignment = NSTextAlignmentCenter;
            contentLabel.font = [UIFont systemFontOfSize:ZOOM6(40)];
            
            NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:contentLabel.text];
            [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(40)] range:NSMakeRange(0, contentLabel.text.length)];
            [contentLabel setAttributedText:mutable];

        }else if(type == RawardRed_open || type == Rawardfive_order_open){
            backView.image = [UIImage imageNamed:@"luck-hongbao"];
            
            headbtn.frame = CGRectMake((W_back - ZOOM6(150))/2, ZOOM6(254), ZOOM6(150), ZOOM6(150));
            [headbtn setBackgroundImage:self.headImage forState:UIControlStateNormal];
            [headbtn addTarget:self action:@selector(headclick:) forControlEvents:UIControlEventTouchUpInside];
            

            contentLabel.frame =CGRectMake(ZOOM6(60), CGRectGetMaxY(headbtn.frame)+ZOOM6(30), W_back - ZOOM6(60)*2, ZOOM6(150));
            contentLabel.textAlignment = NSTextAlignmentCenter;
            contentLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
        
            NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:contentLabel.text];
            NSString *text = @"哇喔~抽中了一个红包";
            [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(40)] range:NSMakeRange(0, text.length)];
            [contentLabel setAttributedText:mutable];

            upBtn.hidden = YES;
            downBtn.hidden = YES;
            
        }else if (type == RawardMondayRed_success || type == Rawardfive_order_success)
        {

            backView.frame = CGRectMake(M_lr, (CGRectGetHeight(self.frame)-H)/2+space, CGRectGetWidth(self.frame)-2*M_lr, H-ZOOM6(110));
            downBtn.hidden = YES;
            headimageview.hidden = NO;

            headbtn.frame = CGRectMake((W_back - ZOOM6(400))/2, ZOOM6(130), ZOOM6(400), ZOOM6(100));
            [headbtn setTitle:[NSString stringWithFormat:@"%.2f元",self.raward] forState:UIControlStateNormal];
            headbtn.tintColor = RGBCOLOR_I(253, 204, 33);
            headbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(60)];
            
            contentLabel.frame =CGRectMake(ZOOM6(70), CGRectGetMaxY(headbtn.frame), W_back - ZOOM6(70)*2, ZOOM6(200));
            contentLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];

        }
        else if (type == RawardRed_order_open)
        {
            [cancalBtn setImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
            
            backView.backgroundColor = [UIColor clearColor];
            backView.image = [UIImage imageNamed:@"guide-hongbao-"];
            
            headbtn.frame = CGRectMake((W_back - ZOOM6(150))/2, ZOOM6(454), ZOOM6(150), ZOOM6(150));
            [headbtn setBackgroundImage:self.headImage forState:UIControlStateNormal];
            [headbtn addTarget:self action:@selector(headclick:) forControlEvents:UIControlEventTouchUpInside];
            
            upBtn.hidden = YES;
            downBtn.hidden = YES;
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
