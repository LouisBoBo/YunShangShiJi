//
//  YFAlertView.m
//  YunShangShiJi
//
//  Created by YF on 2017/7/21.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "YFAlertView.h"
#import "GlobalTool.h"

@interface YFAlertView() {
    UIView *alertView;
    UIButton *dismissBtn;
    UILabel *titleLabel;
    UILabel *detailLabel;
    UIImageView *topImg;
}
@end

@implementation YFAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}

// 赚钱任务 弹框
- (void)creatUI {
    alertView = [[UIView alloc]init];
    alertView.backgroundColor = [UIColor whiteColor];
//    alertView.alpha = 0.5;
    alertView.layer.cornerRadius=3;
    [self addSubview:alertView];
    UIImageView *headImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"赚钱引导_头部"]];
    [alertView addSubview:headImg];

    UIScrollView *scrollView = [[UIScrollView alloc]init];
    [alertView addSubview:scrollView];

    UIView *ScrContainer = [UIView new];
    [scrollView addSubview:ScrContainer];

    titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = kMainTitleColor;
    titleLabel.numberOfLines=0;
    titleLabel.font = [UIFont boldSystemFontOfSize:ZOOM6(30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [ScrContainer addSubview:titleLabel];
    UILabel *subTitle = [[UILabel alloc]init];
    subTitle.textColor = kSubTitleColor;
//    subTitle.text = @"小TIPS";
    subTitle.textAlignment = NSTextAlignmentCenter;
    subTitle.font = [UIFont boldSystemFontOfSize:ZOOM6(24)];
    [ScrContainer addSubview:subTitle];
    detailLabel = [[UILabel alloc]init];
    detailLabel.textColor = kSubTitleColor;
    detailLabel.numberOfLines=0;
    detailLabel.font = [UIFont boldSystemFontOfSize:ZOOM6(24)];
//    detailLabel.textAlignment = NSTextAlignmentCenter;
    [ScrContainer addSubview:detailLabel];

    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom]
    ;
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.backgroundColor=[UIColor whiteColor];
    leftBtn.layer.cornerRadius = 3;
    leftBtn.layer.borderColor = tarbarrossred.CGColor;
    leftBtn.layer.borderWidth = 1;
    [leftBtn setTitle:@"立即去做任务" forState:UIControlStateNormal];
    [leftBtn setTitleColor:tarbarrossred forState:UIControlStateNormal];
    rightBtn.backgroundColor=tarbarrossred;
    rightBtn.layer.cornerRadius = 3;
    [rightBtn setTitle:@"去0元购衣" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.tag = 1;
    rightBtn.tag = 2;
    [alertView addSubview:leftBtn];
//    [alertView addSubview:rightBtn];

    dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setImage:[UIImage imageNamed:@"task_icon_close60X60"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(alertTopView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dismissBtn];


    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self).offset(ZOOM6(105));
//        make.centerX.equalTo(self);
        make.center.equalTo(self);
        make.width.offset(ZOOM6(600));
        make.height.mas_greaterThanOrEqualTo(ZOOM6(550));
    }];
    [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.offset(-ZOOM6(20));
//        make.bottom.equalTo(alertView.mas_top).offset(2);
        make.width.equalTo(alertView.mas_width).offset(ZOOM6(35));
        make.height.offset(ZOOM6(210));
    }];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.offset(0);
        make.top.equalTo(headImg.mas_bottom).offset(ZOOM6(60));
        make.centerX.equalTo(alertView);
        make.bottom.equalTo(leftBtn.mas_top).offset(-ZOOM6(60));
        make.width.equalTo(alertView).offset(-ZOOM6(60));
    }];

//    [@[leftBtn,rightBtn] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:ZOOM6(240) leadSpacing:ZOOM6(40) tailSpacing:ZOOM6(40)];
//    [@[leftBtn,rightBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(alertView.mas_bottom).offset(-ZOOM6(50));
//        make.height.offset(ZOOM6(80));
//    }];
    
//    [leftBtn mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:ZOOM6(240) leadSpacing:ZOOM6(40) tailSpacing:ZOOM6(40)];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(alertView.mas_bottom).offset(-ZOOM6(50));
        make.height.offset(ZOOM6(80));
        make.left.mas_equalTo(ZOOM6(60));
        make.width.mas_equalTo(ZOOM6(600)-ZOOM6(120));
    }];
    
    [dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(alertView.mas_bottom).offset(ZOOM6(60));
        make.width.height.offset(ZOOM6(60));
        make.centerX.equalTo(self);
    }];
    [ScrContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
        make.bottom.equalTo(detailLabel.mas_bottom);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(ScrContainer);
        make.bottom.equalTo(subTitle.mas_top).offset(-ZOOM6(40));
    }];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(ScrContainer);
    }];
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(detailLabel.mas_top).offset(-ZOOM6(14));
        make.right.left.equalTo(ScrContainer);
    }];

}


- (void)creatTopBtn {
    UIButton *btn=[[UIButton alloc]initWithFrame:self.bounds];
    [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];

    topImg = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-ZOOM6(30)-ZOOM6(334), ZOOM6(96), ZOOM6(334), ZOOM6(212))];
    topImg.image = [UIImage imageNamed:@"赚钱引导_按钮"];
    [self addSubview:topImg];

    topImg.transform = CGAffineTransformMakeScale(0.3, 0.3);

    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        topImg.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {

    }];
}
//弹出蒙层  顶部引导显示
- (void)alertTopView {

    [UIView animateWithDuration:0.5 animations:^{
        alertView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        alertView.alpha = 0;
        dismissBtn.alpha = 0;
    } completion:^(BOOL finish) {
        [dismissBtn removeFromSuperview];
        [alertView removeFromSuperview];
        [self creatTopBtn];
    }];

}
- (void)btnClick:(UIButton *)sender {
    if (sender.tag==2) {
        //首次点击弹出0元购弹框
        BOOL zeroshoppong_isfirst = [[NSUserDefaults standardUserDefaults] boolForKey:ZEROSHOPPINGHOMEMENTION];
        if(!zeroshoppong_isfirst)
        {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ZEROSHOPPINGHOMEMENTION];
            
            if(self.home_zeroshoppingBlock)
            {
                self.home_zeroshoppingBlock();
            }
            [self dismiss];
        }else{
            [self alertTopView];
        }
        
    }else{
        if (self.btnBlok) {
            self.btnBlok(sender.tag);
        }
        [self dismiss];
    }
}

- (void)show {


    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];

    for (UIView *view in keyWindow.subviews) {
        if ([view isKindOfClass:[self class]]) {
            return;
        }
    }
    
    UIViewController *topVC = [keyWindow topViewControllerWithRootViewController:keyWindow.rootViewController];
    if (![topVC isKindOfClass:NSClassFromString(@"TFShoppingViewController")]) {
        return;
    }
    UIViewController *vc = [self appRootViewController];
    [vc.view addSubview:self];




//    titleLabel.text = @"衣蝠赚钱小任务今日又更新了7个任务，\n共计60元现金等你来拿哦。";
//    detailLabel.text = @"1、完成全部任务奖励余额与提现现金。\n2、0元购美衣活动需要每日完成全部任务才能申请保底提现。\n3、完成全部任务很重要，记得每天完成哦。";
    detailLabel.text = @"";
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = ZOOM6(20);// 字体的行间距
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 };
    titleLabel.attributedText = [[NSAttributedString alloc] initWithString:self.titleStr attributes:attributes];

//    titleLabel.text = self.titleStr;

    alertView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    dismissBtn.alpha=0;

    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        alertView.transform = CGAffineTransformMakeScale(1, 1);
        alertView.alpha = 1;
        dismissBtn.alpha = 1;
    } completion:^(BOOL finished) {

    }];
}

- (void)dismiss {

    [UIView animateWithDuration:0.5 animations:^{

        self.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        alertView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        topImg.alpha = 0;
        alertView.alpha = 0;
        dismissBtn.alpha = 0;
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

@end
