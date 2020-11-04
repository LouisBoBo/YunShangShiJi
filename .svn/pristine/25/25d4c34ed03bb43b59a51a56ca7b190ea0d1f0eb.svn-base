//
//  TFLoginView.m
//  YunShangShiJi
//
//  Created by 云商 on 15/11/20.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "TFLoginView.h"
#import "GlobalTool.h"

@interface TFLoginView ()

@property (nonatomic, strong)UIImage *headImage;
@property (nonatomic, copy)NSString *content;

@property (nonatomic, copy)NSString *upTitle;
@property (nonatomic, copy)NSString *downTitle;

@property (nonatomic, strong) UIButton *upBtn;
@property (nonatomic, strong) UIButton *downBtn;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *contentLabel;

@end


@implementation TFLoginView


- (id)initWithHeadImage:(UIImage *)headImage contentText:(NSString *)content upButtonTitle:(NSString *)upTitle downButtonTitle:(NSString *)downTitle
{
    if (self = [super init]) {
        
        if (content == nil) {
            self.content = @"一键注册只需5秒，购物更方便哦!";
        } else {
            self.content = content;
        }
        
        
        if (upTitle == nil) {
            self.upTitle = @"一键注册衣蝠";
        } else {
            self.upTitle = upTitle;
        }
        
        if (downTitle == nil) {
            self.downTitle = @"使用已有衣蝠帐号";
        } else {
            self.downTitle = downTitle;
        }
        
        if (headImage == nil) {
            self.headImage = [UIImage imageNamed:@"loginIcon"];
        } else {
            self.headImage = headImage;
        }
        
        
        
        
        CGFloat M_lr = ZOOM(100);
        CGFloat H = ZOOM(877);
        
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        
        //        self.backgroundColor = [RGBCOLOR_I(137,137,137) colorWithAlphaComponent:0.8];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRClicK:)];
        [self addGestureRecognizer:tap];
        
        //        self.layer.borderWidth = 1;
        //        self.layer.borderColor = [[UIColor blackColor] CGColor];
        //        self.frame = CGRectMake(M_lr, 0, kScreenWidth-2*M_lr, H);
        //        self.center = CGPointMake(kScreenWidth*0.5, kScreenHeight*0.5);
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, CGRectGetWidth(self.frame)-2*M_lr, H)];
        backView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        backView.center = CGPointMake(CGRectGetWidth(self.frame)*0.5, CGRectGetHeight(self.frame)*0.5);
        //        backView.tag = 1234;
        backView.layer.borderWidth = 1;
        backView.layer.borderColor = [[UIColor blackColor] CGColor];
        backView.layer.cornerRadius = ZOOM(50);
        //
        //        backView.transform = CGAffineTransformMakeScale(0.05, 0.05);
        //        backView.alpha = 0;
        
        [self addSubview:_backgroundView = backView];
        
        
        CGFloat W_H = ZOOM(220);
        CGFloat M = ZOOM(80);
        
        CGFloat W_back = CGRectGetWidth(self.backgroundView.frame);
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake((W_back-W_H)*0.5, M, W_H, W_H)];
        iv.image = self.headImage;
        //        iv.backgroundColor = [UIColor blackColor];
        [self.backgroundView addSubview:_headImageView = iv];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iv.frame)+M, W_back, ZOOM(67))];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.font = kFont6px(28);
        contentLabel.text = self.content;
        [self.backgroundView addSubview:_contentLabel = contentLabel];
        
        UIButton *upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        upBtn.frame = CGRectMake(M, CGRectGetMaxY(contentLabel.frame)+ZOOM(67), W_back-M*2, W_H*0.5);
        [upBtn setTitle:self.upTitle forState:UIControlStateNormal];
        [upBtn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateNormal];
        upBtn.layer.cornerRadius = 5;
        upBtn.layer.masksToBounds = YES;
        upBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
        [upBtn addTarget:self action:@selector(upBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.backgroundView addSubview:_upBtn = upBtn];
        
        
        UIButton *downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        downBtn.frame = CGRectMake(M, CGRectGetMaxY(self.upBtn.frame)+ZOOM(67), W_back-M*2, W_H*0.5);
        [downBtn setTitle:self.downTitle forState:UIControlStateNormal];
        [downBtn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateNormal];
        downBtn.layer.cornerRadius = 5;
        downBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
        downBtn.layer.masksToBounds = YES;
        
        [downBtn addTarget:self action:@selector(downBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.backgroundView addSubview:_downBtn = downBtn];
        
        UIButton *cancalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancalBtn.frame = CGRectMake(CGRectGetWidth(self.backgroundView.frame)-ZOOM(80)-ZOOM(16), ZOOM(16), ZOOM(80), ZOOM(80));
        [cancalBtn setImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
        
        [cancalBtn addTarget:self action:@selector(cancalBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.backgroundView addSubview:cancalBtn];
        
        
        _backgroundView.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _backgroundView.alpha = 0;
        
        
    }
    
    return self;
    
}

- (void)tapGRClicK:(UITapGestureRecognizer *)sender
{
    [self dismissAlert:YES];
}

- (void)cancalBtnClick:(UIButton *)sender
{
    [self dismissAlert:YES];
}

- (void)upBtnClick:(UIButton *)sender
{
    if (self.upBlock!=nil) {
        self.upBlock();
    }
    [self dismissAlert:NO];
}

- (void)downBtnClick:(UIButton *)sender
{
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
    //    UIViewController *topVC = [self appRootViewController];
    
    //    CGFloat M_lr = 20;
    //    CGFloat H = 300;
    //    self.frame = CGRectMake(0, 0, kScreenWidth-2*M_lr, H);
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    //    self.backgroundColor = RGBCOLOR_I(234,234,234);
    
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
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end