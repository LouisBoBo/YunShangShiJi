//
//  ILSMLAlertView.m
//  MoreLikers
//
//  Created by xiekw on 13-9-9.
//  Copyright (c) 2013年 谢凯伟. All rights reserved.
//

#import "DXAlertView.h"
#import <QuartzCore/QuartzCore.h>
#import "GlobalTool.h"

#define kAlertWidth ([[UIScreen mainScreen] bounds].size.width-(ZOOM(100)*2))
#define kAlertHeight ZOOM(450)

@interface DXAlertView ()
{
    BOOL _leftLeave;
}

@property (nonatomic, strong) UILabel *alertTitleLabel;

@property (nonatomic, strong) UIView *backImageView;

@end

@implementation DXAlertView

+ (CGFloat)alertWidth
{
    return kAlertWidth;
}

+ (CGFloat)alertHeight
{
    return kAlertHeight;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#define kTitleYOffset 15.0f
#define kTitleHeight 25.0f

#define kContentOffset 30.0f
#define kBetweenLabelOffset 20.0f

+(DXAlertView *)shareWTF
{
    static DXAlertView *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[DXAlertView alloc] init];
        }
    });
    return instance;
}
-(UILabel *)alertTitleLabel
{
    if (_alertTitleLabel==nil) {
        _alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kTitleYOffset, kAlertWidth, kTitleHeight)];
         [self addSubview:self.alertTitleLabel];
    }
    return _alertTitleLabel;
}
-(UILabel *)alertContentLabel
{
    if (_alertContentLabel==nil) {
        self.alertContentLabel = [[UILabel alloc] init];
        [self addSubview:_alertContentLabel];
    }
    return _alertContentLabel;
}
-(UIButton *)leftBtn
{
    if (_leftBtn==nil) {
        self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.leftBtn];
    }
    return _leftBtn;
}
-(UIButton *)rightBtn
{
    if (_rightBtn==nil) {
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.rightBtn];
    }
    return _rightBtn;
}
- (void)setWithTitle:(NSString *)title
         contentText:(NSString *)content
     leftButtonTitle:(NSString *)leftTitle
    rightButtonTitle:(NSString *)rigthTitle
{
    self.backgroundColor = [UIColor whiteColor];
    self.alertTitleLabel.font = [UIFont systemFontOfSize:ZOOM(54)];
    self.alertTitleLabel.textColor = [UIColor colorWithRed:56.0/255.0 green:64.0/255.0 blue:71.0/255.0 alpha:1];
    self.alertTitleLabel.textColor = kTitleColor;
//    [self addSubview:self.alertTitleLabel];
    
    CGFloat contentLabelWidth = kAlertWidth - 16;
    self.alertContentLabel.frame =CGRectMake((kAlertWidth - contentLabelWidth) * 0.5,title ? CGRectGetMaxY(self.alertTitleLabel.frame) : kAlertHeight/3-ZOOM(70), contentLabelWidth, ZOOM(120));
    self.alertContentLabel.numberOfLines = 0;
    self.alertContentLabel.textAlignment = self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.alertContentLabel.textColor = [UIColor colorWithRed:127.0/255.0 green:127.0/255.0 blue:127.0/255.0 alpha:1];
    self.alertContentLabel.textColor = kTitleColor;
    self.alertContentLabel.font = [UIFont systemFontOfSize:ZOOM(54)];
//    [self addSubview:self.alertContentLabel];
    
    CGRect leftBtnFrame;
    CGRect rightBtnFrame;
#define kSingleButtonWidth 160.0f
#define kCoupleButtonWidth ZOOM(350)
#define kButtonHeight ZOOM(120)
#define kButtonBottomOffset ZOOM(30)
    if (!leftTitle) {
        rightBtnFrame = CGRectMake((kAlertWidth - kSingleButtonWidth) * 0.5, kAlertHeight - kButtonBottomOffset - kButtonHeight, kSingleButtonWidth, kButtonHeight);
        
        self.rightBtn.frame = rightBtnFrame;
        
    }else {
        leftBtnFrame = CGRectMake(kAlertWidth*0.5-kButtonBottomOffset-kCoupleButtonWidth, kAlertHeight - kButtonBottomOffset*2 - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
        rightBtnFrame = CGRectMake(kAlertWidth*0.5+kButtonBottomOffset, kAlertHeight - kButtonBottomOffset*2 - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
//        self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBtn.frame = leftBtnFrame;
        self.rightBtn.frame = rightBtnFrame;
    }
    
    self.rightBtn.backgroundColor=[UIColor blackColor];
    self.leftBtn.backgroundColor=[UIColor blackColor];
    
    
    [self.rightBtn setTitle:rigthTitle forState:UIControlStateNormal];
    [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = self.rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:ZOOM(40)];
    [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    

    
    self.alertTitleLabel.text = title;
    self.alertContentLabel.text = content;

    
    self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [appRootVC.view addSubview:self];
    
}
- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle
{
    if (self = [super init]) {
//        self.layer.cornerRadius = 5.0;
        
//        [[UIScreen mainScreen] bounds].size.width-ZOOM(67)*2
        
        self.backgroundColor = [UIColor whiteColor];
        self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kTitleYOffset, kAlertWidth, kTitleHeight)];
        self.alertTitleLabel.font = [UIFont systemFontOfSize:ZOOM(54)];
        self.alertTitleLabel.textColor = [UIColor colorWithRed:56.0/255.0 green:64.0/255.0 blue:71.0/255.0 alpha:1];
        self.alertTitleLabel.textColor = kTitleColor;
        [self addSubview:self.alertTitleLabel];
        
        CGFloat contentLabelWidth = kAlertWidth - 16;
        self.alertContentLabel = [[UILabel alloc] initWithFrame:CGRectMake((kAlertWidth - contentLabelWidth) * 0.5,title ? CGRectGetMaxY(self.alertTitleLabel.frame) : kAlertHeight/3-ZOOM(70), contentLabelWidth, ZOOM(120))];
        self.alertContentLabel.numberOfLines = 0;
        self.alertContentLabel.textAlignment = self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.alertContentLabel.textColor = [UIColor colorWithRed:127.0/255.0 green:127.0/255.0 blue:127.0/255.0 alpha:1];
        self.alertContentLabel.textColor = kTitleColor;
        self.alertContentLabel.font = [UIFont systemFontOfSize:ZOOM(54)];
        [self addSubview:self.alertContentLabel];
        
        CGRect leftBtnFrame;
        CGRect rightBtnFrame;
#define kSingleButtonWidth 160.0f
#define kCoupleButtonWidth ZOOM(350)
#define kButtonHeight ZOOM(120)
#define kButtonBottomOffset ZOOM(30)
        if (!leftTitle) {
            rightBtnFrame = CGRectMake((kAlertWidth - kSingleButtonWidth) * 0.5, kAlertHeight - kButtonBottomOffset - kButtonHeight, kSingleButtonWidth, kButtonHeight);
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightBtn.frame = rightBtnFrame;
            
        }else {
            leftBtnFrame = CGRectMake(kAlertWidth*0.5-kButtonBottomOffset-kCoupleButtonWidth, kAlertHeight - kButtonBottomOffset*2 - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
            rightBtnFrame = CGRectMake(kAlertWidth*0.5+kButtonBottomOffset, kAlertHeight - kButtonBottomOffset*2 - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
            self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.leftBtn.frame = leftBtnFrame;
            self.rightBtn.frame = rightBtnFrame;
        }
        
//        [self.rightBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:87.0/255.0 green:135.0/255.0 blue:173.0/255.0 alpha:1]] forState:UIControlStateNormal];
//        [self.leftBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:227.0/255.0 green:100.0/255.0 blue:83.0/255.0 alpha:1]] forState:UIControlStateNormal];
        
        self.rightBtn.backgroundColor=[UIColor blackColor];
        self.leftBtn.backgroundColor=[UIColor blackColor];
        
        
        [self.rightBtn setTitle:rigthTitle forState:UIControlStateNormal];
        [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        self.leftBtn.titleLabel.font = self.rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:ZOOM(40)];
        [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//        self.leftBtn.layer.masksToBounds = self.rightBtn.layer.masksToBounds = YES;
//        self.leftBtn.layer.cornerRadius = self.rightBtn.layer.cornerRadius = 3.0;
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        
        self.alertTitleLabel.text = title;
        self.alertContentLabel.text = content;
        
//        UIButton *xButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [xButton setImage:[UIImage imageNamed:@"btn_close_normal.png"] forState:UIControlStateNormal];
//        [xButton setImage:[UIImage imageNamed:@"btn_close_selected.png"] forState:UIControlStateHighlighted];
//        xButton.frame = CGRectMake(kAlertWidth - 32, 0, 32, 32);
//        [self addSubview:xButton];
//        [xButton addTarget:self action:@selector(dismissAlert) forControlEvents:UIControlEventTouchUpInside];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}

- (void)leftBtnClicked:(id)sender
{
    [UIView animateWithDuration:0.25f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeScale(0.2, 0.2);
        self.backImageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    } completion:^(BOOL finish) {
        [super removeFromSuperview];
        _leftLeave = YES;
        [self dismissAlert];
        if (self.leftBlock) {
            self.leftBlock();
        }
    }];
}

- (void)rightBtnClicked:(id)sender
{
    [UIView animateWithDuration:0.25f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeScale(0.2, 0.2);
        self.backImageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    } completion:^(BOOL finish) {
        [super removeFromSuperview];
        _leftLeave = NO;
        [self dismissAlert];
        if (self.rightBlock) {
            self.rightBlock();
        }
    }];
 
}

- (void)show
{
    UIViewController *topVC = [self appRootViewController];
//    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, - kAlertHeight - 30, kAlertWidth, kAlertHeight);
    
    self.frame = CGRectMake(ZOOM(100), - kAlertHeight - 30, kAlertWidth, kAlertHeight);
    
    self.center = CGPointMake(self.center.x, CGRectGetHeight(topVC.view.frame)*0.5);
//    self.backgroundColor = [UIColor yellowColor];
    
    [topVC.view addSubview:self];
}

- (void)dismissAlert
{
    [self removeFromSuperview];
    if (self.dismissBlock) {
        self.dismissBlock();
    }
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


- (void)removeFromSuperview
{
    [self.backImageView removeFromSuperview];
    self.backImageView = nil;
//    UIViewController *topVC = [self appRootViewController];
//    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, CGRectGetHeight(topVC.view.bounds)+40, kAlertWidth, kAlertHeight);
    

    
//    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        self.frame = afterFrame;
//        if (_leftLeave) {
//            self.transform = CGAffineTransformMakeRotation(-M_1_PI / 1.5);
//        }else {
//            self.transform = CGAffineTransformMakeRotation(M_1_PI / 1.5);
//        }
//        
//    } completion:^(BOOL finished) {
//        [super removeFromSuperview];
//    }];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];

    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
//        self.backImageView.backgroundColor = [UIColor blackColor];
//        self.backImageView.alpha = 0.6f;
        self.backImageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - kAlertHeight) * 0.5, kAlertWidth, kAlertHeight);
    self.frame = afterFrame;
    self.transform = CGAffineTransformMakeScale(0.2, 0.2);
    [UIView animateWithDuration:0.25f  animations:^{
        self.backImageView.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        self.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finish) {
        
    }];
    
//    self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
//    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - kAlertHeight) * 0.5, kAlertWidth, kAlertHeight);
//    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        self.transform = CGAffineTransformMakeRotation(0);
//        self.frame = afterFrame;
//    } completion:^(BOOL finished) {
//    }];
    [super willMoveToSuperview:newSuperview];
}

@end

@implementation UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
