//
//  TFDailyTaskView.m
//  YunShangShiJi
//
//  Created by 云商 on 15/12/9.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "TFDailyTaskView.h"
 
#import "GlobalTool.h"
#import "TFNoviceTaskView.h"
#import "WTFAlertView.h"

#define AnimationTime 0.35

@interface TFDailyTaskView ()

@property (nonatomic, strong)UIView *backgroundView;
@property (nonatomic, strong)UIImageView *animationImageView;

@property (nonatomic, strong)UIView *dailyProgressOne;
@property (nonatomic, strong)UIView *dailyProgressTwo;
@property (nonatomic, strong)UIView *dailyProgressThree;

@property (nonatomic, strong)UIView *dailyProgressFour_one;
@property (nonatomic, strong)UIView *dailyProgressFour_two;

@property (nonatomic, strong)UIView *dailyProgressFive_one;
@property (nonatomic, strong)UIView *dailyProgressFive_two;

@property (nonatomic, strong)UIView *dailyProgressSix_one;
@property (nonatomic, strong)UIView *dailyProgressSix_two;

@property (nonatomic, strong)UIView *dailyProgressSeven_one;
@property (nonatomic, strong)UIView *dailyProgressSeven_two;

@property (nonatomic, strong)UIView *dailyProgressEight_one;
@property (nonatomic, strong)UIView *dailyProgressEight_two;
@property (nonatomic, strong)UIView *dailyProgressEight_Three;


@end


@implementation TFDailyTaskView
- (instancetype)init
{
    if (self = [super init]) {
        //
    }
    return self;
}

- (void)showWithType:(NSString *)type
{
    //    UIViewController *topVC = [self appRootViewController];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    //    //topVC = %@\n topVC.subviews = %@", topVC, topVC.view.subviews);
    
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.center = CGPointMake(kScreenWidth*0.5, kScreenHeight*0.5);
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    backgroundView.center = CGPointMake(kScreenWidth*0.5, kScreenHeight*0.5);
    //    backgroundView.backgroundColor = COLOR_RANDOM;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self addSubview:_backgroundView = backgroundView];
    
    //    //\n = %@\n = %@\n = %@", topVC, topVC.view, topVC.view.subviews);
    
    //    if (kIOSVersions>=8.0) {
    //        if ([topVC isKindOfClass:[UIAlertController class]]) {
    //            UIAlertController *altCt = (UIAlertController *)topVC;
    //            [altCt dismissViewControllerAnimated:NO completion:^{
    //
    for (UIView *view in window.subviews) {
        if ([view isKindOfClass:[TFNoviceTaskView class]]||[view isKindOfClass:[TFDailyTaskView class]]||[view isKindOfClass:[WTFAlertView class]]) {
            //                        [view removeFromSuperview];
            return;
        }
    }
    //
    //                [self showWithSubType:type];
    //            }];
    //            return;
    //        }
    //    }
    
    
    
    //    else if (kIOSVersions<8.0 && kIOSVersions>=7.0) {
    //
    //        [topVC dismissViewControllerAnimated:NO completion:^{
    //            [self showWithSubType:type];
    //        }];
    //        return;
    //    }
    for (UIView *view in window.subviews) {
        if ([view isKindOfClass:[TFNoviceTaskView class]]||[view isKindOfClass:[TFDailyTaskView class]]||[view isKindOfClass:[WTFAlertView class]]) {
            
            //            return;
            //            [view removeFromSuperview];
        }
    }
    
    [window addSubview:self];
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
    } completion:^(BOOL finish) {
        
    }];
    
    [self showNextType:type];
}

- (void)showWithSubType:(NSString *)type
{
    //    UIViewController *topVC = [self appRootViewController];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    for (UIView *view in window.subviews) {
        if ([view isKindOfClass:[TFNoviceTaskView class]]||[view isKindOfClass:[TFDailyTaskView class]]) {
            
            //            return;
            //            [view removeFromSuperview];
        }
    }
    
    [window addSubview:self];
    [self showNextType:type];
}


- (void)showNextType:(NSString *)type
{
//    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if ([type isEqualToString:@"1"]) {
        [self.backgroundView addSubview:self.dailyProgressOne];
//        [UIView animateWithDuration:AnimationTime animations:^{
//            self.dailyProgressOne.transform = CGAffineTransformMakeScale(1, 1);
//            self.dailyProgressOne.alpha = 1;
//        } completion:^(BOOL finish) {
//            
//        }];
        [self showViewAnimation:self.dailyProgressOne];
    } else if ([type isEqualToString:@"2"]) {
        [self.backgroundView addSubview:self.dailyProgressTwo];

        [self showViewAnimation:self.dailyProgressTwo];
    } else if ([type isEqualToString:@"3"]) {
        [self.backgroundView addSubview:self.dailyProgressThree];

        [self showViewAnimation:self.dailyProgressThree];
    } else if ([type isEqualToString:@"4_1"]) {
        [self.backgroundView addSubview:self.dailyProgressFour_one];

        [self showViewAnimation:self.dailyProgressFour_one];
    } else if ([type isEqualToString:@"4_2"]) {
        [self.backgroundView addSubview:self.dailyProgressFour_two];

        [self showViewAnimation:self.dailyProgressFour_two];
    } else if ([type isEqualToString:@"5_1"]) {
        [self.backgroundView addSubview:self.dailyProgressFive_one];

        [self showViewAnimation:self.dailyProgressFive_one];
    } else if ([type isEqualToString:@"5_2"]) {
        [self.backgroundView addSubview:self.dailyProgressFive_two];

        [self showViewAnimation:self.dailyProgressFive_two];
    } else if ([type isEqualToString:@"6_1"]) {
        
        [self.backgroundView addSubview:self.dailyProgressSix_one];

        [self showViewAnimation:self.dailyProgressSix_one];
    } else if ([type isEqualToString:@"6_2"]) {
        [self.backgroundView addSubview:self.dailyProgressSix_two];

        [self showViewAnimation:self.dailyProgressSix_two];
    } else if ([type isEqualToString:@"7_1"]) {
        [self.backgroundView addSubview:self.dailyProgressSeven_one];

        [self showViewAnimation:self.dailyProgressSeven_one];
    } else if ([type isEqualToString:@"7_2"]) {
        [self.backgroundView addSubview:self.dailyProgressSeven_two];

        [self showViewAnimation:self.dailyProgressSeven_two];
    } else if ([type isEqualToString:@"8_1"]) {
        [self.backgroundView addSubview:self.dailyProgressEight_one];

        [self showViewAnimation:self.dailyProgressEight_one];
    } else if ([type isEqualToString:@"8_2"]) {
        [self.backgroundView addSubview:self.dailyProgressEight_two];

        [self showViewAnimation:self.dailyProgressEight_two];
    } else if ([type isEqualToString:@"8_3"]) {
        [self.backgroundView addSubview:self.dailyProgressEight_Three];

        [self showViewAnimation:self.dailyProgressEight_Three];
    } else if ([type isEqualToString:@""]) {
        
    }
    
    
}

#pragma mark - 关闭
- (void)closeClick:(UIButton *)sender
{
    NSInteger type = sender.tag-1000;
    [UIView animateWithDuration:AnimationTime animations:^{
        self.backgroundView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        self.alpha = 0;
    } completion:^(BOOL finish) {
        [self removeFromSuperview];
        if (self.closeBlock!=nil) {
            self.closeBlock(type);
        }
    }];
}

#pragma mark - 确定
- (void)nextBtnClick:(UIButton *)sender
{
    NSInteger type = sender.tag;
    
    [UIView animateWithDuration:AnimationTime animations:^{
        self.backgroundView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        self.alpha = 0;
    } completion:^(BOOL finish) {
        if (self.myBlock!=nil) {
            self.myBlock(type);
            [self removeFromSuperview];
        }
    }];
}

- (void)returnClick:(clickBlock)myBlock withCloseBlock:(closeBlock)closeBlock
{
    self.myBlock = myBlock;
    self.closeBlock = closeBlock;
}

- (void)dismissAlert
{
    [UIView animateWithDuration:AnimationTime animations:^{
        self.transform = CGAffineTransformMakeScale(0.25, 0.25);
        self.alpha = 0;
    } completion:^(BOOL finish) {
        [self removeFromSuperview];
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

#pragma mark - 美衣上新/现在去看看吧 
- (UIView *)dailyProgressOne
{
    if (_dailyProgressOne == nil) {
        _dailyProgressOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        UIImage *img = [UIImage imageNamed:@"每日流程1_1"];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        
        CGFloat scale = img.size.height/img.size.width;
        
        CGFloat H = scale*W;
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        [_dailyProgressOne addSubview:backgroundView];
        
        //        _dailyProgressTwo.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(10), ZOOM(40), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        
        btn1.tag = 1000+1;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [backgroundView addSubview:btn1];
        
        UIImage *btn_img = [UIImage imageNamed:@"每日流程1_2"];
        CGFloat scale_btn = btn_img.size.height/btn_img.size.width;
        CGFloat M_lr_btn = ZOOM(160);
        CGFloat W_btn2 = CGRectGetWidth(iv.frame)-M_lr_btn*2;
        CGFloat H_btn2 = W_btn2*scale_btn;
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake((CGRectGetWidth(backgroundView.frame)-W_btn2)*0.5+ZOOM(20), CGRectGetMaxY(iv.frame)-H_btn2-ZOOM(33), W_btn2, H_btn2);
        btn2.tag = 1;
        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setImage:btn_img forState:UIControlStateNormal];
        [backgroundView addSubview:btn2];
        
        
        //        _dailyProgressTwo.backgroundColor = COLOR_RANDOM;
        _dailyProgressOne.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _dailyProgressOne.alpha = 0;
    }
    return _dailyProgressOne;
}

#pragma mark - 每天养成好习惯/点我分享得50积分
- (UIView *)dailyProgressTwo
{
    if (_dailyProgressTwo == nil) {
        _dailyProgressTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        UIImage *img = [UIImage imageNamed:@"每日流程2_1"];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        
        CGFloat scale = img.size.height/img.size.width;
        
        CGFloat H = scale*W;
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        [_dailyProgressTwo addSubview:backgroundView];
        
        //        _dailyProgressTwo.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        UIImage *btn_img = [UIImage imageNamed:@"每日流程2_2"];
        CGFloat scale_btn = btn_img.size.height/btn_img.size.width;
        CGFloat M_lr_btn = ZOOM(160);
        CGFloat W_btn2 = CGRectGetWidth(iv.frame)-M_lr_btn*2;
        CGFloat H_btn2 = W_btn2*scale_btn;

        //        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        //        btn2.frame = CGRectMake((CGRectGetWidth(backgroundView.frame)-W_btn2)*0.5, CGRectGetMaxY(iv.frame)-H_btn2*0.5-ZOOM(160), W_btn2, H_btn2);
        //        btn2.tag = 2;
        //        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //        [btn2 setImage:btn_img forState:UIControlStateNormal];
        //        [backgroundView addSubview:btn2];
        
        UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(backgroundView.frame)-W_btn2)*0.5, CGRectGetMaxY(iv.frame)-H_btn2*0.5-ZOOM(160), W_btn2, H_btn2)];
        iv2.image = btn_img;
        iv2.userInteractionEnabled = YES;
        [backgroundView addSubview:iv2];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(0, 0, CGRectGetWidth(backgroundView.frame), CGRectGetHeight(backgroundView.frame));
        btn2.tag = 2;
        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //        [btn2 setImage:btn_img forState:UIControlStateNormal];
        [backgroundView addSubview:btn2];
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(10), ZOOM(180), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        
        btn1.tag = 1000+2;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [backgroundView addSubview:btn1];
        
        //        _dailyProgressTwo.backgroundColor = COLOR_RANDOM;
        _dailyProgressTwo.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _dailyProgressTwo.alpha = 0;
    }
    return _dailyProgressTwo;
}

#pragma mark - 每天养成好习惯/点我分享得50积分
- (UIView *)dailyProgressThree
{
    if (_dailyProgressThree == nil) {
        _dailyProgressThree = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        UIImage *img = [UIImage imageNamed:@"每日流程3_1"];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        
        CGFloat scale = img.size.height/img.size.width;
        
        CGFloat H = scale*W;
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        [_dailyProgressThree addSubview:backgroundView];
        
        //        _dailyProgressTwo.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        
        
        UIImage *btn_img = [UIImage imageNamed:@"每日流程3_2"];
        CGFloat scale_btn = btn_img.size.height/btn_img.size.width;
        CGFloat M_lr_btn = ZOOM(160);
        CGFloat W_btn2 = CGRectGetWidth(iv.frame)-M_lr_btn*2;
        CGFloat H_btn2 = W_btn2*scale_btn;
        
//        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn2.frame = CGRectMake((CGRectGetWidth(backgroundView.frame)-W_btn2)*0.5, CGRectGetMaxY(iv.frame)-H_btn2*0.5-ZOOM(160), W_btn2, H_btn2);
//        btn2.tag = 3;
//        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [btn2 setImage:btn_img forState:UIControlStateNormal];
//        [backgroundView addSubview:btn2];

        UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(backgroundView.frame)-W_btn2)*0.5, CGRectGetMaxY(iv.frame)-H_btn2*0.5-ZOOM(160), W_btn2, H_btn2)];
        iv2.image = btn_img;
        iv2.userInteractionEnabled = YES;
        [backgroundView addSubview:iv2];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(0, 0, CGRectGetWidth(backgroundView.frame), CGRectGetHeight(backgroundView.frame));
        btn2.tag = 3;
        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //        [btn2 setImage:btn_img forState:UIControlStateNormal];
        [backgroundView addSubview:btn2];
        
        
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(10), ZOOM(67), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        
        btn1.tag = 1000+3;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [backgroundView addSubview:btn1];
        
        
        //        _dailyProgressTwo.backgroundColor = COLOR_RANDOM;
        _dailyProgressThree.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _dailyProgressThree.alpha = 0;
    }
    return _dailyProgressThree;
}

#pragma mark - 分享美衣给朋友们看看
- (UIView *)dailyProgressFour_one
{
    if (_dailyProgressFour_one == nil) {
        _dailyProgressFour_one = [[UIView alloc] init];
        
        UIImage *img2 = [UIImage imageNamed:@"每日流程41_2"];
        CGFloat W_iv2 = ZOOM(320);
        CGFloat scale2 = img2.size.height/img2.size.width;
        CGFloat H_iv2 = scale2*W_iv2;
        
        UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-W_iv2-10, 20, W_iv2, H_iv2)];
        iv2.image = img2;
        iv2.userInteractionEnabled = YES;
        [_dailyProgressFour_one addSubview:_animationImageView = iv2];
        
        NSArray *animationArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"每日流程41_2"], [UIImage imageNamed:@"每日流程41_3"], nil];
        _animationImageView.animationImages = animationArr;
        _animationImageView.animationDuration = 1;      //执行一次完整动画所需的时长
        _animationImageView.animationRepeatCount = 0;   //无限
        [_animationImageView startAnimating];
        
        UIImage *img = [UIImage imageNamed:@"每日流程41_1"];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W_iv = kScreenWidth-M_lr*2;
        CGFloat scale = img.size.height/img.size.width;
        //        _userProgressFive_one.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        CGFloat H_iv = scale*W_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr, CGRectGetMaxY(iv2.frame)+H_ud_iv, W_iv, H_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [_dailyProgressFour_one addSubview:iv];
        
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetMaxX(iv.frame)-W_H_btn1-ZOOM(33), CGRectGetMinY(iv.frame), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        [_dailyProgressFour_one addSubview:btn1];
        btn1.tag = 1000+41;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(kScreenWidth-60, 20, 60, 44);
        //        shareBtn.backgroundColor = COLOR_RANDOM;
        shareBtn.tag = 41;
        [shareBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_dailyProgressFour_one addSubview:shareBtn];
        
        _dailyProgressFour_one.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _dailyProgressFour_one.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _dailyProgressFour_one.alpha = 0;
    }
    
    return _dailyProgressFour_one;
}

#pragma mark - 更换模版/50积分奖励哦
- (UIView *)dailyProgressFour_two
{
    if (_dailyProgressFour_two == nil) {
        
//        _dailyProgressFour_two = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//
//
//        UIImage *img = [UIImage imageNamed:@"每日流程42_1"];
//        CGFloat M_lr = ZOOM(67);
//        CGFloat W = kScreenWidth-2*M_lr;
//        CGFloat scale = img.size.height/img.size.width;
//        CGFloat H = scale*W;
//
//        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
//        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
//        [_dailyProgressFour_two addSubview:backgroundView];
//
////        _dailyProgressFour_two.backgroundColor = COLOR_RANDOM;
//
//        CGFloat M_lr_iv = ZOOM(10);
//        CGFloat H_ud_iv = scale*M_lr_iv;
//
//        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
//        iv.image = img;
//        iv.userInteractionEnabled = YES;
//        [backgroundView addSubview:iv];
//
//        UIButton *backgroundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        backgroundBtn.frame = CGRectMake(0, 0, CGRectGetWidth(backgroundView.frame), CGRectGetHeight(backgroundView.frame));
//        backgroundBtn.tag = 42;
//        [backgroundBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//
//        [backgroundView addSubview:backgroundBtn];
//
//
//        CGFloat W_H_btn1 = ZOOM(67)*2;
//        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn1.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(87), ZOOM(33), W_H_btn1, W_H_btn1);
//        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
//        [backgroundView addSubview:btn1];
//
//        btn1.tag = 1000+42;
//        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
//
//        _dailyProgressFour_two.transform = CGAffineTransformMakeScale(0.05, 0.05);
//        _dailyProgressFour_two.alpha = 0;
        
        _dailyProgressFour_two = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        UIImage *img = [UIImage imageNamed:@"每日流程42_1"];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        
        CGFloat scale = img.size.height/img.size.width;
        
        CGFloat H = scale*W;
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        [_dailyProgressFour_two addSubview:backgroundView];
        
        //        _dailyProgressTwo.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(55), ZOOM(40), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        
        btn1.tag = 1000+42;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [backgroundView addSubview:btn1];
        
        UIImage *btn_img = [UIImage imageNamed:@"每日流程42_2"];
        CGFloat scale_btn = btn_img.size.height/btn_img.size.width;
        CGFloat M_lr_btn = ZOOM(160);
        CGFloat W_btn2 = CGRectGetWidth(iv.frame)-M_lr_btn*2;
        CGFloat H_btn2 = W_btn2*scale_btn;
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake((CGRectGetWidth(backgroundView.frame)-W_btn2)*0.5-ZOOM(10), CGRectGetMaxY(iv.frame)-H_btn2, W_btn2, H_btn2);
        btn2.tag = 42;
        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setImage:btn_img forState:UIControlStateNormal];
        [backgroundView addSubview:btn2];
        
        _dailyProgressFour_two.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _dailyProgressFour_two.alpha = 0;
        
    }
    return _dailyProgressFour_two;
    
}

#pragma mark - 分享美衣给朋友们看看
- (UIView *)dailyProgressFive_one
{
    if (_dailyProgressFive_one == nil) {
        _dailyProgressFive_one = [[UIView alloc] init];
        
        UIImage *img2 = [UIImage imageNamed:@"每日流程51_2"];
        CGFloat W_iv2 = ZOOM(320);
        CGFloat scale2 = img2.size.height/img2.size.width;
        CGFloat H_iv2 = scale2*W_iv2;
        
        UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-W_iv2-10, 20, W_iv2, H_iv2)];
        iv2.image = img2;
        iv2.userInteractionEnabled = YES;
        
        [_dailyProgressFive_one addSubview:_animationImageView = iv2];
        
        NSArray *animationArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"每日流程51_2"], [UIImage imageNamed:@"每日流程51_3"], nil];
        _animationImageView.animationImages = animationArr;
        _animationImageView.animationDuration = 1;      //执行一次完整动画所需的时长
        _animationImageView.animationRepeatCount = 0;   //无限
        [_animationImageView startAnimating];
        
        UIImage *img = [UIImage imageNamed:@"每日流程51_1"];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W_iv = kScreenWidth-M_lr*2;
        CGFloat scale = img.size.height/img.size.width;
        //        _userProgressFive_one.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        CGFloat H_iv = scale*W_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr, CGRectGetMaxY(iv2.frame)+H_ud_iv, W_iv, H_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [_dailyProgressFive_one addSubview:iv];
        
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetMaxX(iv.frame)-W_H_btn1, CGRectGetMinY(iv.frame)+H_iv*0.25, W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        [_dailyProgressFive_one addSubview:btn1];
        btn1.tag = 1000+51;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(kScreenWidth-60, 20, 60, 44);
        //        shareBtn.backgroundColor = COLOR_RANDOM;
        shareBtn.tag = 51;
        [shareBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_dailyProgressFive_one addSubview:shareBtn];
        
        _dailyProgressFive_one.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _dailyProgressFive_one.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _dailyProgressFive_one.alpha = 0;
        
    }
    return _dailyProgressFive_one;
}

#pragma mark - 发布公告/50积分奖励哦
- (UIView *)dailyProgressFive_two
{
    if (_dailyProgressFive_two == nil) {
        _dailyProgressFive_two = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        UIImage *img = [UIImage imageNamed:@"每日流程52_1"];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        
        CGFloat scale = img.size.height/img.size.width;
        
        CGFloat H = scale*W;
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        [_dailyProgressFive_two addSubview:backgroundView];
        
        //        _dailyProgressTwo.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(45), ZOOM(15), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        
        btn1.tag = 1000+52;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [backgroundView addSubview:btn1];
        
        UIImage *btn_img = [UIImage imageNamed:@"每日流程52_2"];
        CGFloat scale_btn = btn_img.size.height/btn_img.size.width;
        CGFloat M_lr_btn = ZOOM(160);
        CGFloat W_btn2 = CGRectGetWidth(iv.frame)-M_lr_btn*2;
        CGFloat H_btn2 = W_btn2*scale_btn;
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake((CGRectGetWidth(backgroundView.frame)-W_btn2)*0.5+ZOOM(33), CGRectGetMaxY(iv.frame)-H_btn2-ZOOM(25), W_btn2, H_btn2);
        btn2.tag = 52;
        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setImage:btn_img forState:UIControlStateNormal];
        [backgroundView addSubview:btn2];
        
        
        //        _dailyProgressTwo.backgroundColor = COLOR_RANDOM;
        _dailyProgressFive_two.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _dailyProgressFive_two.alpha = 0;
        
        
    }
    return _dailyProgressFive_two;
}

#pragma mark - 分享美衣给朋友们看看
- (UIView *)dailyProgressSix_one
{
    if (_dailyProgressSix_one == nil) {
        _dailyProgressSix_one = [[UIView alloc] init];
        
        UIImage *img2 = [UIImage imageNamed:@"每日流程61_2"];
        CGFloat W_iv2 = ZOOM(320);
        CGFloat scale2 = img2.size.height/img2.size.width;
        CGFloat H_iv2 = scale2*W_iv2;
        
        UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-W_iv2-10, 20, W_iv2, H_iv2)];
        iv2.image = img2;
        iv2.userInteractionEnabled = YES;
        [_dailyProgressSix_one addSubview:_animationImageView = iv2];
        
        NSArray *animationArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"每日流程61_2"], [UIImage imageNamed:@"每日流程61_3"], nil];
        _animationImageView.animationImages = animationArr;
        _animationImageView.animationDuration = 1;      //执行一次完整动画所需的时长
        _animationImageView.animationRepeatCount = 0;   //无限
        [_animationImageView startAnimating];
        
        UIImage *img = [UIImage imageNamed:@"每日流程61_1"];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W_iv = kScreenWidth-M_lr*2;
        CGFloat scale = img.size.height/img.size.width;
        //        _userProgressFive_one.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        CGFloat H_iv = scale*W_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr, CGRectGetMaxY(iv2.frame)+H_ud_iv, W_iv, H_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [_dailyProgressSix_one addSubview:iv];
        
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetMaxX(iv.frame)-W_H_btn1, CGRectGetMinY(iv.frame), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        [_dailyProgressSix_one addSubview:btn1];
        btn1.tag = 1000+61;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(kScreenWidth-60, 20, 60, 44);
        //        shareBtn.backgroundColor = COLOR_RANDOM;
        shareBtn.tag = 61;
        [shareBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_dailyProgressSix_one addSubview:shareBtn];
        
        _dailyProgressSix_one.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _dailyProgressSix_one.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _dailyProgressSix_one.alpha = 0;
        
    }
    return _dailyProgressSix_one;
}

#pragma mark - 轮播图/50积分奖励哦
- (UIView *)dailyProgressSix_two
{
    if (_dailyProgressSix_two == nil) {
        _dailyProgressSix_two = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        UIImage *img = [UIImage imageNamed:@"每日流程62_1"];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        
        CGFloat scale = img.size.height/img.size.width;
        
        CGFloat H = scale*W;
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        [_dailyProgressSix_two addSubview:backgroundView];
        
        //        _dailyProgressTwo.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(65), ZOOM(40), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        
        btn1.tag = 1000+62;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [backgroundView addSubview:btn1];
        
        UIImage *btn_img = [UIImage imageNamed:@"每日流程62_2"];
        CGFloat scale_btn = btn_img.size.height/btn_img.size.width;
        CGFloat M_lr_btn = ZOOM(160);
        CGFloat W_btn2 = CGRectGetWidth(iv.frame)-M_lr_btn*2;
        CGFloat H_btn2 = W_btn2*scale_btn;
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake((CGRectGetWidth(backgroundView.frame)-W_btn2)*0.5-ZOOM(10), CGRectGetMaxY(iv.frame)-H_btn2, W_btn2, H_btn2);
        btn2.tag = 62;
        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setImage:btn_img forState:UIControlStateNormal];
        [backgroundView addSubview:btn2];
        
        _dailyProgressSix_two.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _dailyProgressSix_two.alpha = 0;
        
        
    }
    return _dailyProgressSix_two;
}

#pragma mark - 分享美衣给朋友们看看
- (UIView *)dailyProgressSeven_one
{
    if (_dailyProgressSeven_one == nil) {
        _dailyProgressSeven_one = [[UIView alloc] init];
        
        UIImage *img2 = [UIImage imageNamed:@"每日流程71_2"];
        CGFloat W_iv2 = ZOOM(320);
        CGFloat scale2 = img2.size.height/img2.size.width;
        CGFloat H_iv2 = scale2*W_iv2;
        
        UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-W_iv2-10, 20, W_iv2, H_iv2)];
        iv2.image = img2;
        iv2.userInteractionEnabled = YES;
        
        [_dailyProgressSeven_one addSubview:_animationImageView = iv2];
        
        NSArray *animationArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"每日流程71_2"], [UIImage imageNamed:@"每日流程71_3"], nil];
        _animationImageView.animationImages = animationArr;
        _animationImageView.animationDuration = 1;      //执行一次完整动画所需的时长
        _animationImageView.animationRepeatCount = 0;   //无限
        [_animationImageView startAnimating];
        
        UIImage *img = [UIImage imageNamed:@"每日流程71_1"];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W_iv = kScreenWidth-M_lr*2;
        CGFloat scale = img.size.height/img.size.width;
        //        _userProgressFive_one.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        CGFloat H_iv = scale*W_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr, CGRectGetMaxY(iv2.frame)+H_ud_iv, W_iv, H_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [_dailyProgressSeven_one addSubview:iv];
        
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetMaxX(iv.frame)-W_H_btn1, CGRectGetMinY(iv.frame)+H_iv*0.25, W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        [_dailyProgressSeven_one addSubview:btn1];
        btn1.tag = 1000+71;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(kScreenWidth-60, 20, 60, 44);
        //        shareBtn.backgroundColor = COLOR_RANDOM;
        shareBtn.tag = 71;
        [shareBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_dailyProgressSeven_one addSubview:shareBtn];
        
        _dailyProgressSeven_one.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _dailyProgressSeven_one.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _dailyProgressSeven_one.alpha = 0;
        
    }
    return _dailyProgressSeven_one;
}

#pragma mark - 更新店主最爱/50积分奖励哦
- (UIView *)dailyProgressSeven_two
{
    if (_dailyProgressSeven_two == nil) {
        _dailyProgressSeven_two = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        UIImage *img = [UIImage imageNamed:@"每日流程72_1"];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        
        CGFloat scale = img.size.height/img.size.width;
        
        CGFloat H = scale*W;
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        [_dailyProgressSeven_two addSubview:backgroundView];
        
        //        _dailyProgressTwo.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(10), ZOOM(160), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        
        btn1.tag = 1000+72;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [backgroundView addSubview:btn1];
        
        UIImage *btn_img = [UIImage imageNamed:@"每日流程72_2"];
        CGFloat scale_btn = btn_img.size.height/btn_img.size.width;
        CGFloat M_lr_btn = ZOOM(160);
        CGFloat W_btn2 = CGRectGetWidth(iv.frame)-M_lr_btn*2;
        CGFloat H_btn2 = W_btn2*scale_btn;
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake((CGRectGetWidth(backgroundView.frame)-W_btn2)*0.5, CGRectGetMaxY(iv.frame)-H_btn2*0.5-ZOOM(130), W_btn2, H_btn2);
        btn2.tag = 72;
        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setImage:btn_img forState:UIControlStateNormal];
        [backgroundView addSubview:btn2];
        
        
        //        _dailyProgressTwo.backgroundColor = COLOR_RANDOM;
        _dailyProgressSeven_two.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _dailyProgressSeven_two.alpha = 0;
        
        
    }
    return _dailyProgressSeven_two;
}

#pragma mark - 分享美衣给朋友们看看
- (UIView *)dailyProgressEight_one
{
    if (_dailyProgressEight_one == nil) {
        _dailyProgressEight_one = [[UIView alloc] init];
        
        UIImage *img2 = [UIImage imageNamed:@"每日流程81_2"];
        CGFloat W_iv2 = ZOOM(320);
        CGFloat scale2 = img2.size.height/img2.size.width;
        CGFloat H_iv2 = scale2*W_iv2;
        
        UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-W_iv2-10, 20, W_iv2, H_iv2)];
        iv2.image = img2;
        iv2.userInteractionEnabled = YES;
        [_dailyProgressEight_one addSubview:_animationImageView = iv2];
        
        NSArray *animationArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"每日流程81_2"], [UIImage imageNamed:@"每日流程81_3"], nil];
        _animationImageView.animationImages = animationArr;
        _animationImageView.animationDuration = 1;      //执行一次完整动画所需的时长
        _animationImageView.animationRepeatCount = 0;   //无限
        [_animationImageView startAnimating];
        
        UIImage *img = [UIImage imageNamed:@"每日流程81_1"];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W_iv = kScreenWidth-M_lr*2;
        CGFloat scale = img.size.height/img.size.width;
        //        _userProgressFive_one.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        CGFloat H_iv = scale*W_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr, CGRectGetMaxY(iv2.frame)+H_ud_iv, W_iv, H_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [_dailyProgressEight_one addSubview:iv];
        
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetMaxX(iv.frame)-W_H_btn1, CGRectGetMinY(iv.frame)+H_iv*0.25, W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        [_dailyProgressEight_one addSubview:btn1];
        btn1.tag = 1000+81;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(kScreenWidth-60, 20, 60, 44);
        //        shareBtn.backgroundColor = COLOR_RANDOM;
        shareBtn.tag = 81;
        [shareBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_dailyProgressEight_one addSubview:shareBtn];
        
        _dailyProgressEight_one.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _dailyProgressEight_one.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _dailyProgressEight_one.alpha = 0;
        
    }
    return _dailyProgressEight_one;
}

#pragma mark - 衣蝠上新/点我去购物
- (UIView *)dailyProgressEight_two
{
    if (_dailyProgressEight_two == nil) {
        _dailyProgressEight_two = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        UIImage *img = [UIImage imageNamed:@"每日流程82_1"];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        
        CGFloat scale = img.size.height/img.size.width;
        
        CGFloat H = scale*W;
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        [_dailyProgressEight_two addSubview:backgroundView];
        
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(65), ZOOM(40), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        
        btn1.tag = 1000+82;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [backgroundView addSubview:btn1];
        
        UIImage *btn_img = [UIImage imageNamed:@"每日流程82_2"];
        
        CGFloat scale_btn = btn_img.size.height/btn_img.size.width;
        CGFloat M_lr_btn = ZOOM(160);
        CGFloat W_btn2 = CGRectGetWidth(iv.frame)-M_lr_btn*2;
        CGFloat H_btn2 = W_btn2*scale_btn;
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //        //x = %f, y = %f, w = %f, h = %f",(CGRectGetWidth(backgroundView.frame)-W_btn2)*0.5-ZOOM(10), CGRectGetMaxY(iv.frame)-H_btn2, W_btn2, H_btn2);
        
        btn2.frame = CGRectMake((CGRectGetWidth(backgroundView.frame)-W_btn2)*0.5-ZOOM(10), CGRectGetMaxY(iv.frame)-H_btn2, W_btn2, H_btn2);
        
        btn2.tag = 82;
        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setImage:btn_img forState:UIControlStateNormal];
        [backgroundView addSubview:btn2];
        
        _dailyProgressEight_two.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _dailyProgressEight_two.alpha = 0;
        
    }
    return _dailyProgressEight_two;
}

- (UIView *)dailyProgressEight_Three
{
    if (_dailyProgressEight_Three == nil) {
        _dailyProgressEight_Three = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        UIImage *img = [UIImage imageNamed:@"新手流程8_1"];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        
        CGFloat scale = img.size.height/img.size.width;
        
        CGFloat H = scale*W;
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        [_dailyProgressEight_Three addSubview:backgroundView];
        
        //        _dailyProgressTwo.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(10), ZOOM(40), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        
        btn1.tag = 1000+83;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [backgroundView addSubview:btn1];
        
        UIImage *btn_img = [UIImage imageNamed:@"新手流程8_2"];
        CGFloat scale_btn = btn_img.size.height/btn_img.size.width;
        CGFloat M_lr_btn = ZOOM(160);
        CGFloat W_btn2 = CGRectGetWidth(iv.frame)-M_lr_btn*2;
        CGFloat H_btn2 = W_btn2*scale_btn;
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake((CGRectGetWidth(backgroundView.frame)-W_btn2)*0.5+ZOOM(30), CGRectGetMaxY(iv.frame)-H_btn2-ZOOM(33), W_btn2, H_btn2);
        btn2.tag = 83;
        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setImage:btn_img forState:UIControlStateNormal];
        [backgroundView addSubview:btn2];
        
        
        //        _dailyProgressTwo.backgroundColor = COLOR_RANDOM;
        _dailyProgressEight_Three.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _dailyProgressEight_Three.alpha = 0;
        
    }
    return _dailyProgressEight_Three;
}

- (void)showViewAnimation:(UIView *)animationV
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        animationV.transform = CGAffineTransformMakeScale(1, 1);
        animationV.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
