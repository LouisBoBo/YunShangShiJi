//
//  TFNoviceTaskView.m
//  YunShangShiJi
//
//  Created by 云商 on 15/12/9.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "TFNoviceTaskView.h"
 
#import "GlobalTool.h"
#import "MyMD5.h"
#import "TFDailyTaskView.h"

#import "WTFAlertView.h"

#define signProgressViewTwoString @"签到_2元现金"
#define signProgressViewFiveStrng @"签到_5元现金"
#define signProgressView30String @"30yuanxianjin"

#define AnimationTime 0.35

@interface TFNoviceTaskView ()

@property (nonatomic, strong)UIView *backgroundView;

@property (nonatomic ,strong)UIImageView *animationImageView;


@property (nonatomic, strong)UIView *userProgressOne;
@property (nonatomic, strong)UIView *userProgressTwo;
@property (nonatomic, strong)UIView *userProgressThree;
@property (nonatomic, strong)UIView *userProgressFour;

@property (nonatomic, strong)UIView *userProgressFive_one;
@property (nonatomic, strong)UIView *userProgressFive_two;
@property (nonatomic, strong)UIView *userProgressSix_one;
@property (nonatomic, strong)UIView *userProgressSix_two;
@property (nonatomic, strong)UIView *userProgressSeven_one;
@property (nonatomic, strong)UIView *userProgressSeven_two;
@property (nonatomic, strong)UIView *userProgressEight;

@property (nonatomic, strong)UIView *userProgressNine;
@property (nonatomic, strong)UIView *userProgressTen;

@property (nonatomic, strong)UIView *userProgressEleven;


/************    签到弹出的界面    ***********/
@property (nonatomic,strong)UIView *signProgressViewTwo;
@property (nonatomic,strong)UIView *signProgressViewFive;

@end


@implementation TFNoviceTaskView

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
                        
                        //弹框冲突");
                        
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
    
    if ([type isEqualToString:@"1"]) {
        [self.backgroundView addSubview:self.userProgressOne];
//        [UIView animateWithDuration:AnimationTime animations:^{
//            self.userProgressOne.transform = CGAffineTransformMakeScale(1, 1);
//            self.userProgressOne.alpha = 1;
//        } completion:^(BOOL finish) {
//            //                [_animationImageView startAnimating];
//        }];
//        
        [self showViewAnimation:self.userProgressOne];
    } else if ([type isEqualToString:@"2"]) {
        [self.backgroundView addSubview:self.userProgressTwo];

        [self showViewAnimation:self.userProgressTwo];
    } else if ([type isEqualToString:@"3"]) {
        [self.backgroundView addSubview:self.userProgressThree];
        [self showViewAnimation:self.userProgressThree];
    } else if ([type isEqualToString:@"4"]) {
        [self.backgroundView addSubview:self.userProgressFour];

        [self showViewAnimation:self.userProgressFour];
    } else if ([type isEqualToString:@"5_1"]) {
        [self.backgroundView addSubview:self.userProgressFive_one];
         [self showViewAnimation:self.userProgressFive_one];
    } else if ([type isEqualToString:@"5_2"]) {
        [self.backgroundView addSubview:self.userProgressFive_two];
        [self showViewAnimation:self.userProgressFive_two];
    } else if ([type isEqualToString:@"6_1"]) {
        [self.backgroundView addSubview:self.userProgressSix_one];

        [self showViewAnimation:self.userProgressSix_one];
    } else if ([type isEqualToString:@"6_2"]) {
        [self.backgroundView addSubview:self.userProgressSix_two];

        [self showViewAnimation:self.userProgressSix_two];
    } else if ([type isEqualToString:@"7_1"]) {
        [self.backgroundView addSubview:self.userProgressSeven_one];

        [self showViewAnimation:self.userProgressSeven_one];
    } else if ([type isEqualToString:@"7_2"]) {
        [self.backgroundView addSubview:self.userProgressSeven_two];

         [self showViewAnimation:self.userProgressSeven_two];
    } else if ([type isEqualToString:@"8"]) {
        [self.backgroundView addSubview:self.userProgressEight];

        [self showViewAnimation:self.userProgressEight];
    } else if ([type isEqualToString:@"9"]) {
        [self.backgroundView addSubview:self.userProgressNine];

        [self showViewAnimation:self.userProgressNine];
    } else if ([type isEqualToString:@"10"]) {
        [self.backgroundView addSubview:self.userProgressTen];

         [self showViewAnimation:self.userProgressTen];
    } else if ([type isEqualToString:@"11"]) {
        [self.backgroundView addSubview:self.userProgressEleven];

        [self showViewAnimation:self.userProgressEleven];

    }else if ([type isEqualToString:signProgressViewTwoString]) {
        [self.backgroundView addSubview:self.signProgressViewTwo];

        [self showViewAnimation:self.signProgressViewTwo];
    }else if ([type isEqualToString:signProgressViewFiveStrng]) {
        [self.backgroundView addSubview:self.signProgressViewFive];

        [self showViewAnimation:self.signProgressViewFive];
    }else if ([type isEqualToString:signProgressView30String]) {
        [self.backgroundView addSubview:[self signProgressViewWithImageName:signProgressView30String]];

        [self showViewAnimation:[self signProgressViewWithImageName:signProgressView30String]];
    }
}

- (void)showViewAnimation:(UIView *)animationV
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        animationV.transform = CGAffineTransformMakeScale(1, 1);
        animationV.alpha = 1;
    } completion:^(BOOL finished) {
        
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


#pragma mark - 分享衣蝠给好友得100元大礼包
- (UIView *)userProgressOne
{
    if (_userProgressOne == nil) {
        
        _userProgressOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        UIImage *img = [UIImage imageNamed:@"新手流程1_1"];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        
        CGFloat scale = img.size.height/img.size.width;
        
        CGFloat H = scale*W;
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        [_userProgressOne addSubview:backgroundView];
        
        //        _userProgressOne.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        
        UIImage *btn_img = [UIImage imageNamed:@"新手流程1_2"];
        CGFloat scale_btn = btn_img.size.height/btn_img.size.width;
        CGFloat M_lr_btn = ZOOM(160);
        CGFloat W_btn2 = CGRectGetWidth(iv.frame)-M_lr_btn*2;
        CGFloat H_btn2 = W_btn2*scale_btn;
        
        
//        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn2.frame = CGRectMake((CGRectGetWidth(backgroundView.frame)-W_btn2)*0.5, CGRectGetMaxY(iv.frame)-H_btn2*0.5-M_lr, W_btn2, H_btn2);
//        btn2.tag = 1;
//        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [btn2 setImage:btn_img forState:UIControlStateNormal];
//        [backgroundView addSubview:btn2];
        
        UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(backgroundView.frame)-W_btn2)*0.5, CGRectGetMaxY(iv.frame)-H_btn2*0.5-M_lr, W_btn2, H_btn2)];
        iv2.image = btn_img;
        iv2.userInteractionEnabled = YES;
        [backgroundView addSubview:iv2];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(0, 0, CGRectGetWidth(backgroundView.frame), CGRectGetHeight(backgroundView.frame));
        btn2.tag = 1;
        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [btn2 setImage:btn_img forState:UIControlStateNormal];
        [backgroundView addSubview:btn2];
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(33), ZOOM(67), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        btn1.tag = 1000+1;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:btn1];

        
        _userProgressOne.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _userProgressOne.alpha = 0;
    }
    return _userProgressOne;
}

#pragma mark - 恭喜获得0元购机会
- (UIView *)userProgressTwo
{
    if (_userProgressTwo == nil) {
        
        _userProgressTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        UIImage *img = [UIImage imageNamed:@"新手流程2_1"];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        
        CGFloat scale = img.size.height/img.size.width;
        
        CGFloat H = scale*W;
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        [_userProgressTwo addSubview:backgroundView];
        //        _userProgressTwo.backgroundColor = COLOR_RANDOM;
        
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(33), ZOOM(67), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        [backgroundView addSubview:btn1];
        btn1.tag = 1000+2;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImage *btn_img = [UIImage imageNamed:@"新手流程2_2"];
        CGFloat scale_btn = btn_img.size.height/btn_img.size.width;
        CGFloat M_lr_btn = ZOOM(160);
        CGFloat W_btn2 = CGRectGetWidth(iv.frame)-M_lr_btn*2;
        CGFloat H_btn2 = W_btn2*scale_btn;
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake((CGRectGetWidth(backgroundView.frame)-W_btn2)*0.5, CGRectGetMaxY(iv.frame)-H_btn2*0.5-M_lr, W_btn2, H_btn2);
        btn2.tag = 2;
        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setImage:btn_img forState:UIControlStateNormal];
        [backgroundView addSubview:btn2];
        
        _userProgressTwo.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _userProgressTwo.alpha = 0;
    }
    return _userProgressTwo;
}

#pragma mark - 现在去登录/现在去注册
- (UIView *)userProgressThree
{
    if (_userProgressThree == nil) {
        
        _userProgressThree = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        UIImage *img = [UIImage imageNamed:@"新手流程3_1"];
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        CGFloat scale = img.size.height/img.size.width;
        CGFloat H = scale*W;
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        [_userProgressThree addSubview:backgroundView];
        
        //        _userProgressThree.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(33), ZOOM(67), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        [backgroundView addSubview:btn1];
        btn1.tag = 1000+3;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImage *btn_img = [UIImage imageNamed:@"新手流程3_2"];
        CGFloat scale_btn = btn_img.size.height/btn_img.size.width;
//        CGFloat M_lr_btn = 0;
        CGFloat W_btn2 = CGRectGetWidth(iv.frame)*0.5;
        CGFloat H_btn2 = W_btn2*scale_btn;
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(0, CGRectGetHeight(backgroundView.frame)-H_btn2-ZOOM(10), W_btn2, H_btn2);
        btn2.tag = 3;
        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setImage:btn_img forState:UIControlStateNormal];
        [backgroundView addSubview:btn2];
        
         UIImage *btn_img2 = [UIImage imageNamed:@"新手流程3_3"];
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn3.frame = CGRectMake(W_btn2, CGRectGetHeight(backgroundView.frame)-H_btn2-ZOOM(10), W_btn2, H_btn2);
        btn3.tag = 500+3;
        [btn3 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn3 setImage:btn_img2 forState:UIControlStateNormal];
        [backgroundView addSubview:btn3];
        
        _userProgressThree.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _userProgressThree.alpha = 0;
    }
    return _userProgressThree;
}

#pragma mark - 现在去开店
- (UIView *)userProgressFour
{
    if (_userProgressFour == nil) {
        
        _userProgressFour = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        int week = [[MyMD5 getCurrTimeString:@"week"] intValue];
        
        NSString *bigImgName = [NSString stringWithFormat:@"新手流程4_1_0"];
        NSString *btnImgName = [NSString stringWithFormat:@"新手流程4_2_0"];
        
        switch (week) {
            case 2: {
                bigImgName = [NSString stringWithFormat:@"新手流程4_1_1"];
                btnImgName = [NSString stringWithFormat:@"新手流程4_2_1"];
            }
                break;
                
            case 3: {
                bigImgName = [NSString stringWithFormat:@"新手流程4_1_2"];
                btnImgName = [NSString stringWithFormat:@"新手流程4_2_2"];
            }
                break;
                
            case 4: {
                bigImgName = [NSString stringWithFormat:@"新手流程4_1_3"];
                btnImgName = [NSString stringWithFormat:@"新手流程4_2_3"];
            }
                break;
                
            case 5: {
                bigImgName = [NSString stringWithFormat:@"新手流程4_1_4"];
                btnImgName = [NSString stringWithFormat:@"新手流程4_2_4"];
            }
                break;
            case 6: {
                bigImgName = [NSString stringWithFormat:@"新手流程4_1_5"];
                btnImgName = [NSString stringWithFormat:@"新手流程4_2_5"];
            }
                break;
            case 7: {
                bigImgName = [NSString stringWithFormat:@"新手流程4_1_0"];
                btnImgName = [NSString stringWithFormat:@"新手流程4_2_0"];
            }
                break;
            case 8: {
                bigImgName = [NSString stringWithFormat:@"新手流程4_1_0"];
                btnImgName = [NSString stringWithFormat:@"新手流程4_2_0"];
            }
                break;
                
            default:
                break;
        }
        
        UIImage *img = [UIImage imageNamed:bigImgName];
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        CGFloat scale = img.size.height/img.size.width;
        CGFloat H = scale*W;
        
        //背景view
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        [_userProgressFour addSubview:backgroundView];
        
//        backgroundView.backgroundColor = COLOR_RANDOM;
//        _userProgressFour.backgroundColor = COLOR_RANDOM;
        
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        //背景大图
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        //关闭按钮
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat x_btn = 0;
        CGFloat y_btn = 0;
        
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        [backgroundView addSubview:btn1];
        btn1.tag = 1000+4;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat W_btn2 = 0;
        CGFloat H_btn2 = 0;
        CGFloat x_btn2 = 0;
        CGFloat y_btn2 = 0;
        
        UIImage *btn_img = [UIImage imageNamed:btnImgName];
        CGFloat scale_btn = btn_img.size.height/btn_img.size.width;
        CGFloat M_lr_btn = 0;
        CGFloat M_ud_btn = 0;
        CGFloat M_r_btn = 0;
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.tag = 4;
        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setImage:btn_img forState:UIControlStateNormal];
        [backgroundView addSubview:btn2];
        
        if (week == 7||week == 8) {
            
            x_btn = CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(33);
            y_btn = ZOOM(67);
            
            //确定按钮
            M_lr_btn = ZOOM(160);
            M_ud_btn = ZOOM(67);
            
            W_btn2 = CGRectGetWidth(iv.frame)-M_lr_btn*2;
            H_btn2 = W_btn2*scale_btn;
            
            x_btn2 = (CGRectGetWidth(backgroundView.frame)-W_btn2)*0.5;
            y_btn2 = CGRectGetMaxY(iv.frame)-H_btn2*0.5-M_ud_btn;
            
            
        } else {
            switch (week) {
                case 2: {
                
                    x_btn = CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(33);
                    y_btn = ZOOM(67);
                    
                    //确定按钮
                    M_lr_btn = ZOOM(160);
                    M_ud_btn = ZOOM(160);
                    M_r_btn = ZOOM(180);
                    
                    
                    W_btn2 = CGRectGetWidth(iv.frame)-M_lr_btn*3.8;
                    H_btn2 = W_btn2*scale_btn;
                    
                    x_btn2 = (CGRectGetWidth(backgroundView.frame)-W_btn2)-M_r_btn;
                    y_btn2 = CGRectGetMaxY(iv.frame)-H_btn2-M_ud_btn;
                    
                }
                    break;
                case 3: {
                    x_btn = CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(0);
                    y_btn = 0;
                    
                    //确定按钮
                    M_lr_btn = ZOOM(160);
                    M_ud_btn = ZOOM(70);
                    M_r_btn = ZOOM(180);
                    
                    W_btn2 = CGRectGetWidth(iv.frame)-M_lr_btn*2;
                    H_btn2 = W_btn2*scale_btn;
                    
                    x_btn2 = (CGRectGetWidth(backgroundView.frame)-W_btn2)-M_r_btn;
                    y_btn2 = CGRectGetMaxY(iv.frame)-H_btn2-M_ud_btn;
                    
                }
                    break;
                case 4: {
                    x_btn = CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(0);
                    y_btn = ZOOM(67);
                    
                    //确定按钮
                    M_lr_btn = ZOOM(160);
                    M_ud_btn = ZOOM(160);
                    M_r_btn = ZOOM(180);
                    
                    
                    W_btn2 = CGRectGetWidth(iv.frame)-M_lr_btn*2.5;
                    H_btn2 = W_btn2*scale_btn;
                    
                    x_btn2 = (CGRectGetWidth(backgroundView.frame)-W_btn2)-M_r_btn-ZOOM(30);
                    y_btn2 = CGRectGetMaxY(iv.frame)-H_btn2-M_ud_btn;
                }
                    break;
                case 5: {
                    x_btn = CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(33);
                    y_btn = ZOOM(67);
                    
                    //确定按钮
                    M_lr_btn = ZOOM(160);
                    M_ud_btn = ZOOM(220);
                    M_r_btn = ZOOM(180);
                    
                    
                    W_btn2 = CGRectGetWidth(iv.frame)-M_lr_btn*4.2;
                    H_btn2 = W_btn2*scale_btn;
                    
                    x_btn2 = M_r_btn;
                    y_btn2 = CGRectGetMaxY(iv.frame)-H_btn2-M_ud_btn;
                }
                    break;
                case 6: {
                    x_btn = CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(33);
                    y_btn = ZOOM(0);
                    
                    //确定按钮
                    M_lr_btn = ZOOM(160);
                    M_ud_btn = ZOOM(220);
                    M_r_btn = ZOOM(180);
                    
                    W_btn2 = CGRectGetWidth(iv.frame)-M_lr_btn*4.3;
                    H_btn2 = W_btn2*scale_btn;
                    
                    x_btn2 = M_r_btn-ZOOM(80);
                    y_btn2 = CGRectGetMaxY(iv.frame)-H_btn2-M_ud_btn;
                }
                    break;
                    
                default:
                    break;
            }
            
        }
        
        btn1.frame = CGRectMake( x_btn, y_btn, W_H_btn1, W_H_btn1);
        btn2.frame = CGRectMake( x_btn2, y_btn2, W_btn2, H_btn2);
        
        _userProgressFour.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _userProgressFour.alpha = 0;
    }
    return _userProgressFour;
}

#pragma mark - 首次分享美衣小店
- (UIView *)userProgressFive_one
{
    if (_userProgressFive_one == nil) {
        
        _userProgressFive_one = [[UIView alloc] init];
        
        UIImage *img2 = [UIImage imageNamed:@"新手流程51_2"];
        CGFloat W_iv2 = ZOOM(320);
        CGFloat scale2 = img2.size.height/img2.size.width;
        CGFloat H_iv2 = scale2*W_iv2;
        
        UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-W_iv2-10, 20, W_iv2, H_iv2)];
        iv2.image = img2;
        iv2.userInteractionEnabled = YES;
        [_userProgressFive_one addSubview:_animationImageView = iv2];
        
        NSArray *animationArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"新手流程51_2"], [UIImage imageNamed:@"新手流程51_3"], nil];
        _animationImageView.animationImages = animationArr;
        _animationImageView.animationDuration = 1;      //执行一次完整动画所需的时长
        _animationImageView.animationRepeatCount = 0;   //无限
        [_animationImageView startAnimating];

        
        
        UIImage *img = [UIImage imageNamed:@""];
        
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
        [_userProgressFive_one addSubview:iv];
        
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetMaxX(iv.frame)-W_H_btn1-ZOOM(33), CGRectGetMinY(iv.frame), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        [_userProgressFive_one addSubview:btn1];
        btn1.tag = 1000+51;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(kScreenWidth-60, 20, 60, 44);
//        shareBtn.backgroundColor = COLOR_RANDOM;
        shareBtn.tag = 51;
        [shareBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_userProgressFive_one addSubview:shareBtn];
        
        _userProgressFive_one.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        
//        _userProgressFive_one.backgroundColor = COLOR_RANDOM;
        
        _userProgressFive_one.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _userProgressFive_one.alpha = 0;
    }
    return _userProgressFive_one;
}

#pragma mark - 小店已经开通
- (UIView *)userProgressFive_two
{
    if (_userProgressFive_two == nil) {
        
        _userProgressFive_two = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//        _userProgressFive_two.backgroundColor = COLOR_RANDOM;
        
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        closeBtn.tag = 1000+52;
        [closeBtn addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        [_userProgressFive_two addSubview:closeBtn];

        
        UIImage *img = [UIImage imageNamed:@"新手流程2_1"];
        CGFloat M_lr = ZOOM(67);
        
        CGFloat W = kScreenWidth-2*M_lr;
        CGFloat scale = img.size.height/img.size.width;
        CGFloat H = scale*W;
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        [_userProgressFive_two addSubview:backgroundView];
        
//        backgroundView.backgroundColor = COLOR_RANDOM;

        
        
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        
        UIButton *closeBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn1.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        closeBtn1.tag = 1000+52;
        [closeBtn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:closeBtn1];

        
        UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        nextBtn.frame = CGRectMake(0, 0, CGRectGetWidth(backgroundView.frame), CGRectGetHeight(backgroundView.frame));
        [nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        nextBtn.tag = 52;
        [backgroundView addSubview:nextBtn];
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)-W_H_btn1, 0, W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        [backgroundView addSubview:btn1];
        
        btn1.tag = 1000+52;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _userProgressFive_two.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _userProgressFive_two.alpha = 0;
    }
    return _userProgressFive_two;
}

#pragma mark - 首次分享美衣小店得300积分
- (UIView *)userProgressSix_one
{
    if (_userProgressSix_one == nil) {
        _userProgressSix_one = [[UIView alloc] init];
        UIImage *img2 = [UIImage imageNamed:@"新手流程61_2"];
        CGFloat W_iv2 = ZOOM(320);
        CGFloat scale2 = img2.size.height/img2.size.width;
        CGFloat H_iv2 = scale2*W_iv2;
        
        UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake(ZOOM6(140)+15, kScreenHeight-5-H_iv2, W_iv2, H_iv2)];
//        iv2.image = img2;
        iv2.userInteractionEnabled = YES;
        [_userProgressSix_one addSubview:_animationImageView = iv2];
        
        NSArray *animationArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"新手流程61_2"], [UIImage imageNamed:@"新手流程61_3"], nil];
        _animationImageView.animationImages = animationArr;
        _animationImageView.animationDuration = 1;      //执行一次完整动画所需的时长
        _animationImageView.animationRepeatCount = 0;   //无限
        [_animationImageView startAnimating];
        
        UIImage *img = [UIImage imageNamed:@"新手流程2_1"];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W_iv = kScreenWidth-M_lr*2;
        CGFloat scale = img.size.height/img.size.width;
        //        _userProgressSix_one.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        CGFloat H_iv = scale*W_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr, CGRectGetMinY(iv2.frame)-H_ud_iv-H_iv, W_iv, H_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [_userProgressSix_one addSubview:iv];
        
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetMaxX(iv.frame)-W_H_btn1, CGRectGetMidY(iv.frame)-W_H_btn1, W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        [_userProgressSix_one addSubview:btn1];
        btn1.tag = 1000+61;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(kScreenWidth-60, 20, 60, 44);
//        shareBtn.backgroundColor = COLOR_RANDOM;
        shareBtn.tag = 61;
        [shareBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_userProgressSix_one addSubview:shareBtn];
        
        _userProgressSix_one.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _userProgressSix_one.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _userProgressSix_one.alpha = 0;
    }
    return _userProgressSix_one;
}

#pragma mark - 好友购买可以提现呢
- (UIView *)userProgressSix_two
{
    if (_userProgressSix_two == nil) {
        
        _userProgressSix_two = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
//        _userProgressSix_two.backgroundColor = COLOR_RANDOM;
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        closeBtn.tag = 1000+62;
        [closeBtn addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        [_userProgressSix_two addSubview:closeBtn];
        
        UIImage *img = [UIImage imageNamed:@"新手流程2_1"];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        CGFloat scale = img.size.height/img.size.width;
        CGFloat H = scale*W;

        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5-20);
        [_userProgressSix_two addSubview:backgroundView];
        
//        backgroundView.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        UIButton *closeBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn1.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        closeBtn1.tag = 1000+62;
        [closeBtn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:closeBtn1];
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(80), ZOOM(10), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        [backgroundView addSubview:btn1];
        btn1.tag = 1000+62;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImage *img2 = [UIImage imageNamed:@"新手流程62_2"];
        CGFloat W_iv2 = kScreenWidth*0.5;
        CGFloat scale2 = img2.size.height/img2.size.width;
        CGFloat H_iv2 = scale2*W_iv2;
        
        CGFloat X_iv2 = CGRectGetWidth(backgroundView.frame)-W_iv2;
        CGFloat Y_iv2 = CGRectGetMaxY(backgroundView.frame)+ZOOM(33);
        
        UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake(X_iv2, Y_iv2, W_iv2, H_iv2)];
        iv2.image = img2;
        iv2.userInteractionEnabled = YES;
        [_userProgressSix_two addSubview:iv2];
        
        _userProgressSix_two.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _userProgressSix_two.alpha = 0;
    }
    
    return _userProgressSix_two;
}

#pragma mark - 首次分享美衣小店得300积分
- (UIView *)userProgressSeven_one
{
    if (_userProgressSeven_one == nil) {
        _userProgressSeven_one = [[UIView alloc] init];
        UIImage *img2 = [UIImage imageNamed:@"新手流程71_2"];
        CGFloat W_iv2 = ZOOM(320);
        CGFloat scale2 = img2.size.height/img2.size.width;
        CGFloat H_iv2 = scale2*W_iv2;
        
        UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-W_iv2-10, 20, W_iv2, H_iv2)];
        iv2.image = img2;
        iv2.userInteractionEnabled = YES;
        [_userProgressSeven_one addSubview:_animationImageView = iv2];
        
        NSArray *animationArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"新手流程71_2"], [UIImage imageNamed:@"新手流程71_3"], nil];
        _animationImageView.animationImages = animationArr;
        _animationImageView.animationDuration = 1;      //执行一次完整动画所需的时长
        _animationImageView.animationRepeatCount = 0;   //无限
        [_animationImageView startAnimating];
        
        UIImage *img = [UIImage imageNamed:@""];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W_iv = kScreenWidth-M_lr*2;
        CGFloat scale = img.size.height/img.size.width;
        //        _userProgressSix_one.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        CGFloat H_iv = scale*W_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr, CGRectGetMaxY(iv2.frame)+H_ud_iv, W_iv, H_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [_userProgressSeven_one addSubview:iv];
        
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetMaxX(iv.frame)-W_H_btn1, CGRectGetMidY(iv.frame)-W_H_btn1, W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        [_userProgressSeven_one addSubview:btn1];
        btn1.tag = 1000+71;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(kScreenWidth-60, 20, 60, 44);
//        shareBtn.backgroundColor = COLOR_RANDOM;
        shareBtn.tag = 71;
        [shareBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_userProgressSeven_one addSubview:shareBtn];
        
        _userProgressSeven_one.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _userProgressSeven_one.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _userProgressSeven_one.alpha = 0;
    }
    return _userProgressSeven_one;
}

#pragma mark - 好友购买可以提现呢
- (UIView *)userProgressSeven_two
{
    if (_userProgressSeven_two == nil) {
        
        _userProgressSeven_two = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        UIImage *img = [UIImage imageNamed:@"新手流程2_1"];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        CGFloat scale = img.size.height/img.size.width;
        CGFloat H = scale*W;
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5-20);
        [_userProgressSeven_two addSubview:backgroundView];
        
        //        backgroundView.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(80), ZOOM(10), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        [backgroundView addSubview:btn1];
        btn1.tag = 1000+72;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImage *img2 = [UIImage imageNamed:@"新手流程72_2"];
        CGFloat W_iv2 = kScreenWidth*0.5;
        CGFloat scale2 = img2.size.height/img2.size.width;
        CGFloat H_iv2 = scale2*W_iv2;
        
        CGFloat X_iv2 = CGRectGetWidth(backgroundView.frame)-W_iv2;
        CGFloat Y_iv2 = CGRectGetMaxY(backgroundView.frame)+ZOOM(33);
        
        UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake(X_iv2, Y_iv2, W_iv2, H_iv2)];
        iv2.image = img2;
        iv2.userInteractionEnabled = YES;
        [_userProgressSeven_two addSubview:iv2];
        
        _userProgressSeven_two.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _userProgressSeven_two.alpha = 0;
    }
    
    return _userProgressSeven_two;
}

#pragma mark - 点击直接去积分首页
- (UIView *)userProgressEight
{
    if (_userProgressEight == nil) {
        _userProgressEight = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        UIImage *img = [UIImage imageNamed:@"新手流程8_1"];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        
        CGFloat scale = img.size.height/img.size.width;
        
        CGFloat H = scale*W;
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        [_userProgressEight addSubview:backgroundView];
        
//        _userProgressOne.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(33), ZOOM(67), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        
        btn1.tag = 1000+8;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [backgroundView addSubview:btn1];
        
        UIImage *btn_img = [UIImage imageNamed:@"新手流程8_2"];
        CGFloat scale_btn = btn_img.size.height/btn_img.size.width;
        CGFloat M_lr_btn = ZOOM(160);
        CGFloat W_btn2 = CGRectGetWidth(iv.frame)-M_lr_btn*2;
        CGFloat H_btn2 = W_btn2*scale_btn;
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake((CGRectGetWidth(backgroundView.frame)-W_btn2)*0.5, CGRectGetMaxY(iv.frame)-H_btn2*0.5-M_lr, W_btn2, H_btn2);
        btn2.tag = 8;
        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setImage:btn_img forState:UIControlStateNormal];
        [backgroundView addSubview:btn2];
        
        _userProgressEight.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _userProgressEight.alpha = 0;
    }
    return _userProgressEight;

}

#pragma mark - 给钱也不要/现在去分享
- (UIView *)userProgressNine
{
    if (_userProgressNine == nil) {
        
        _userProgressNine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        UIImage *img = [UIImage imageNamed:@"新手流程2_1"];
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        CGFloat scale = img.size.height/img.size.width;
        CGFloat H = scale*W;
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        [_userProgressNine addSubview:backgroundView];
        
        //        _userProgressThree.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(45), 0, W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        [backgroundView addSubview:btn1];
        btn1.tag = 1000+9;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImage *btn_img = [UIImage imageNamed:@"新手流程9_2"];
        CGFloat scale_btn = btn_img.size.height/btn_img.size.width;
        //        CGFloat M_lr_btn = 0;
        CGFloat W_btn2 = CGRectGetWidth(iv.frame)*0.5;
        CGFloat H_btn2 = W_btn2*scale_btn;
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(ZOOM(10), CGRectGetHeight(backgroundView.frame)-H_btn2-ZOOM(0), W_btn2, H_btn2);
        btn2.tag = 9;
        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setImage:btn_img forState:UIControlStateNormal];
        [backgroundView addSubview:btn2];
        
        UIImage *btn_img2 = [UIImage imageNamed:@"新手流程9_3"];
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn3.frame = CGRectMake(W_btn2, CGRectGetHeight(backgroundView.frame)-H_btn2-ZOOM(0), W_btn2, H_btn2);
        btn3.tag = 500+9;
        [btn3 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn3 setImage:btn_img2 forState:UIControlStateNormal];
        [backgroundView addSubview:btn3];
        
        _userProgressNine.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _userProgressNine.alpha = 0;
    }
    return _userProgressNine;
}

#pragma mark - 点我分享美衣 立得50积分
- (UIView *)userProgressTen
{
    if (_userProgressTen == nil) {
        _userProgressTen = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        UIImage *img = [UIImage imageNamed:@"新手流程2_1"];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        
        CGFloat scale = img.size.height/img.size.width;
        
        CGFloat H = scale*W;
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        [_userProgressTen addSubview:backgroundView];
        
        //        _dailyProgressTwo.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        UIImage *btn_img = [UIImage imageNamed:@"新手流程10_2"];
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
        btn2.tag = 10;
        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //        [btn2 setImage:btn_img forState:UIControlStateNormal];
        [backgroundView addSubview:btn2];
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(10), ZOOM(180), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        
        btn1.tag = 1000+10;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [backgroundView addSubview:btn1];
        
        //        _dailyProgressTwo.backgroundColor = COLOR_RANDOM;
        _userProgressTen.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _userProgressTen.alpha = 0;

    }
    return _userProgressTen;
}

#pragma mark - 去吐槽/不去了
- (UIView *)userProgressEleven
{
    if (_userProgressEleven == nil) {
        
        _userProgressEleven = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        UIImage *img = [UIImage imageNamed:@"新手流程2_1"];
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        CGFloat scale = img.size.height/img.size.width;
        CGFloat H = scale*W;
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        [_userProgressEleven addSubview:backgroundView];
        
        //        _userProgressThree.backgroundColor = COLOR_RANDOM;
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)-W_H_btn1-ZOOM(33), ZOOM(67), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"新手流程x"] forState:UIControlStateNormal];
        [backgroundView addSubview:btn1];
        btn1.tag = 1000+11;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImage *btn_img = [UIImage imageNamed:@"新手流程11_2"];
        CGFloat scale_btn = btn_img.size.height/btn_img.size.width;
        //        CGFloat M_lr_btn = 0;
        CGFloat W_btn2 = CGRectGetWidth(iv.frame)*0.4;
        CGFloat H_btn2 = W_btn2*scale_btn;
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)*0.5-W_btn2, CGRectGetHeight(backgroundView.frame)-H_btn2-ZOOM(80), W_btn2, H_btn2);
        btn2.tag = 11;
        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setImage:btn_img forState:UIControlStateNormal];
        [backgroundView addSubview:btn2];
        
        UIImage *btn_img2 = [UIImage imageNamed:@"新手流程11_3"];
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn3.frame = CGRectMake(CGRectGetWidth(backgroundView.frame)*0.5, CGRectGetHeight(backgroundView.frame)-H_btn2-ZOOM(80), W_btn2, H_btn2);
        btn3.tag = 500+11;
        [btn3 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn3 setImage:btn_img2 forState:UIControlStateNormal];
        [backgroundView addSubview:btn3];
        
        _userProgressEleven.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _userProgressEleven.alpha = 0;
    }
    return _userProgressEleven;
}
#pragma mark - WTF－－－－签到分享领2元现金
- (UIView *)signProgressViewTwo
{
    if (_signProgressViewTwo == nil) {
        _signProgressViewTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        UIImage *img = [UIImage imageNamed:signProgressViewTwoString];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        
        CGFloat scale = img.size.height/img.size.width;
        
        CGFloat H = scale*W;
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        [_signProgressViewTwo addSubview:backgroundView];
        
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        
        UIImage *btn_img = [UIImage imageNamed:@"签到_立即领取"];
        CGFloat scale_btn = btn_img.size.height/btn_img.size.width;
        CGFloat M_lr_btn = ZOOM(200);
        CGFloat W_btn2 = CGRectGetWidth(iv.frame)-M_lr_btn*2;
        CGFloat H_btn2 = W_btn2*scale_btn;
        
        
        UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(backgroundView.frame)-W_btn2)*0.5, CGRectGetMaxY(iv.frame), W_btn2, H_btn2)];
        iv2.image = btn_img;
        iv2.userInteractionEnabled = YES;
        [backgroundView addSubview:iv2];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(0, 0, CGRectGetWidth(iv2.frame), CGRectGetHeight(backgroundView.frame)+CGRectGetHeight(iv2.frame));
        btn2.tag = 10;
        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //        [btn2 setImage:btn_img forState:UIControlStateNormal];
        [backgroundView addSubview:btn2];
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetMaxX(iv.frame)-W_H_btn1-ZOOM(10), ZOOM(10), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"icon_close1"] forState:UIControlStateNormal];
        
        btn1.tag = 1000+10;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [backgroundView addSubview:btn1];
         
        CGRect rect = backgroundView.frame;
        backgroundView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height+CGRectGetHeight(iv2.frame));
        
        //        _dailyProgressTwo.backgroundColor = COLOR_RANDOM;
//        _signProgressViewTwo.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _signProgressViewTwo.alpha = 0;
        
        
    }
    return _signProgressViewTwo;
}
#pragma mark  WTF－－－－签到分享领5元现金
- (UIView *)signProgressViewFive
{
    if (_signProgressViewFive == nil) {
        _signProgressViewFive = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        UIImage *img = [UIImage imageNamed:signProgressViewFiveStrng];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        CGFloat scale = img.size.height/img.size.width;
        
        CGFloat H = scale*W;
        
        

        
//        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, -H, W, H)];
//        backgroundView.backgroundColor = COLOR_RANDOM;
//        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        [_signProgressViewFive addSubview:backgroundView];
        
        [UIView animateWithDuration:1.f delay:(0.15) usingSpringWithDamping:1.0f initialSpringVelocity:15.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        } completion:^(BOOL finished) {
        }];
        
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        UIImage *btn_img = [UIImage imageNamed:@"签到_立即领取"];
        CGFloat scale_btn = btn_img.size.height/btn_img.size.width;
        CGFloat M_lr_btn = ZOOM(200);
        CGFloat W_btn2 = CGRectGetWidth(iv.frame)-M_lr_btn*2;
        CGFloat H_btn2 = W_btn2*scale_btn;

        
        
        UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(backgroundView.frame)-W_btn2)*0.5, CGRectGetMaxY(iv.frame), W_btn2, H_btn2)];
        iv2.image = btn_img;
        iv2.userInteractionEnabled = YES;
        [backgroundView addSubview:iv2];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(CGRectGetMinX(iv2.frame), CGRectGetMinY(iv2.frame), CGRectGetWidth(iv2.frame), CGRectGetHeight(iv2.frame));
        btn2.tag = 10;
        [btn2 addTarget:self action:@selector(signNextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //        [btn2 setImage:btn_img forState:UIControlStateNormal];
//        btn2.backgroundColor = COLOR_ROSERED;
        [backgroundView addSubview:btn2];
        
        backgroundView.tag = 2000;
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetMaxX(iv.frame)-W_H_btn1-ZOOM(10), ZOOM(10), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"icon_close1"] forState:UIControlStateNormal];
        btn1.tag = 1000+10;
        [btn1 addTarget:self action:@selector(signCloseClick:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:btn1];
        
        CGRect rect = backgroundView.frame;
        backgroundView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height+CGRectGetHeight(iv2.frame));
        

//        _signProgressViewFive.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _signProgressViewFive.alpha = 0;
        
    }
    return _signProgressViewFive;
}

#pragma mark - WTF－－－－30元现金
- (UIView *)signProgressViewWithImageName:(NSString *)imageName
{
    if (_signProgressViewTwo == nil) {
        _signProgressViewTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        UIImage *img = [UIImage imageNamed:imageName];
        
        CGFloat M_lr = ZOOM(67);
        CGFloat W = kScreenWidth-2*M_lr;
        
        CGFloat scale = img.size.height/img.size.width;
        
        CGFloat H = scale*W;
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, 0, W, H)];
        backgroundView.center = CGPointMake(backgroundView.center.x, kScreenHeight*0.5);
        [_signProgressViewTwo addSubview:backgroundView];
        
        CGFloat M_lr_iv = ZOOM(10);
        CGFloat H_ud_iv = scale*M_lr_iv;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(M_lr_iv, H_ud_iv, W-2*M_lr_iv, H-2*H_ud_iv)];
        iv.image = img;
        iv.userInteractionEnabled = YES;
        [backgroundView addSubview:iv];
        
        
        UIImage *btn_img = [UIImage imageNamed:@"签到_立即领取"];
        CGFloat scale_btn = btn_img.size.height/btn_img.size.width;
        CGFloat M_lr_btn = ZOOM(200);
        CGFloat W_btn2 = CGRectGetWidth(iv.frame)-M_lr_btn*2;
        CGFloat H_btn2 = W_btn2*scale_btn;
        
        
        UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(backgroundView.frame)-W_btn2)*0.5, CGRectGetMaxY(iv.frame), W_btn2, H_btn2)];
        iv2.image = btn_img;
        iv2.userInteractionEnabled = YES;
        [backgroundView addSubview:iv2];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(0, 0, CGRectGetWidth(iv2.frame), CGRectGetHeight(backgroundView.frame)+CGRectGetHeight(iv2.frame));
        btn2.tag = 10;
        [btn2 addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //        [btn2 setImage:btn_img forState:UIControlStateNormal];
        [backgroundView addSubview:btn2];
        
        CGFloat W_H_btn1 = ZOOM(67)*2;
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(CGRectGetMaxX(iv.frame)-W_H_btn1-ZOOM(10), ZOOM(10), W_H_btn1, W_H_btn1);
        [btn1 setImage:[UIImage imageNamed:@"icon_close1"] forState:UIControlStateNormal];
        
        btn1.tag = 1000+10;
        [btn1 addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [backgroundView addSubview:btn1];
        
        CGRect rect = backgroundView.frame;
        backgroundView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height+CGRectGetHeight(iv2.frame));
        
        //        _dailyProgressTwo.backgroundColor = COLOR_RANDOM;
        //        _signProgressViewTwo.transform = CGAffineTransformMakeScale(0.05, 0.05);
        _signProgressViewTwo.alpha = 0;
        
        
    }
    return _signProgressViewTwo;
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

- (void)signCloseClick:(UIButton *)sender
{
    UIView *bkView = [self.backgroundView viewWithTag:2000];
    
//    [UIView animateWithDuration:1.f delay:(0.15) usingSpringWithDamping:1.0f initialSpringVelocity:15.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
////        bkView.center = CGPointMake(bkView.center.x, kScreenHeight*2);
//    } completion:^(BOOL finished) {
////        [self removeFromSuperview];
////        if (self.closeBlock!=nil) {
////            self.closeBlock(1);
////        }
//
//    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        bkView.center = CGPointMake(bkView.center.x, kScreenHeight*2);
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.closeBlock!=nil) {
            self.closeBlock(1);
        }
    }];
    
}
-(void)signNextBtnClick:(UIButton *)sender
{
    UIView *bkView = [self.backgroundView viewWithTag:2000];

    [UIView animateWithDuration:0.5 animations:^{
        bkView.center = CGPointMake(bkView.center.x, kScreenHeight*2);
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.myBlock!=nil) {
            self.myBlock(1);
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
        [self removeFromSuperview];
        if (self.myBlock!=nil) {
            self.myBlock(type);
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
//    [UIView animateWithDuration:0.5 animations:^{
//        self.transform = CGAffineTransformMakeScale(0.25, 0.25);
//        self.alpha = 0;
//    } completion:^(BOOL finish) {
//        [self removeFromSuperview];
//    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
