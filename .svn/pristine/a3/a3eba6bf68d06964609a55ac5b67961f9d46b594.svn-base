//
//  CFActivityDetailToPayVC.m
//  YunShangShiJi
//
//  Created by YF on 2017/6/21.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "CFActivityDetailToPayVC.h"
#import "MyOrderViewController.h"
#import "BubbleView.h"
#import "GuideLuckModel.h"

@interface CFActivityDetailToPayVC ()
{
    BubbleView *bubbleV;
    UILabel *timeLabel;
    UIButton *bottomBtn;
    NSInteger _timeout;         //倒计时
}
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CFActivityDetailToPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];

    [self httpGetTime];

    [self setNavigationItemLeft:@"活动详情"];
    [self setUI];
    

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self BubbleUI];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [bubbleV removeFromSuperview];
    bubbleV = nil;
}
//获取倒计时 
- (void)httpGetTime {
    [GuideLuckModel getGuideLuckHttpSuccess:^(id data) {
        GuideLuckModel *model = data;
        if (model.status==1) {
            double time = ([model.data[@"end_date"]doubleValue]-model.now.doubleValue)/1000;
            [self changeTime:time];
        }

    }];
}
- (void)changeTime:(double)time {
    _timeout = time;
    _timer = [NSTimer weakTimerWithTimeInterval:1.0 target:self userInfo:nil repeats:YES block:^(CFActivityDetailToPayVC *target, NSTimer *timer) {
        if(target -> _timeout <= 0){ //倒计时结束，关闭
            [target.timer invalidate];
            target.timer = nil;
            target -> timeLabel.text = @"马上去付款";
            target -> bottomBtn.userInteractionEnabled=NO;
            target -> timeLabel.layer.backgroundColor = kbackgrayColor.CGColor;
        } else {
            NSInteger minute = target -> _timeout/60;
            NSInteger seconds = target -> _timeout%60;
            NSString *strTime = [NSString stringWithFormat:@"马上去付款 %02ld:%02ld", (long)minute, (long)seconds];
            target -> timeLabel.text=strTime;
            target -> _timeout--;
        }
    }];
}
- (void)setUI {
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar-ZOOM6(120))];
    img.image=[UIImage imageNamed:@"guide-detail"];
    [self.view addSubview:img];


    timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), kScreenHeight-ZOOM6(100), kScreenWidth-ZOOM6(40), ZOOM6(80))];
    timeLabel.textColor=[UIColor whiteColor];
    timeLabel.layer.cornerRadius = 5;
    timeLabel.layer.backgroundColor=tarbarrossred.CGColor;
    timeLabel.textAlignment=NSTextAlignmentCenter;
    timeLabel.font=kFont6px(36);
    timeLabel.text = @"马上去付款";
    [self.view addSubview:timeLabel];

    bottomBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    bottomBtn.backgroundColor = tarbarrossred;
//    [bottomBtn setTintColor:[UIColor whiteColor]];
//    bottomBtn.layer.cornerRadius = 5;
//    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
//    NSString *title = @"马上去集赞";
//    [getyibtn setTitle:title forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(topay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];

    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kScreenHeight-ZOOM6(100));
        make.left.offset(ZOOM6(20));
        make.right.offset(-ZOOM6(20));
        make.height.equalTo(@ZOOM6(80));
    }];

}
- (void)topay {
    MyOrderViewController *myorder=[[MyOrderViewController alloc]init];
    myorder.tag=1000;
    myorder.status1=@"1";
    myorder.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:myorder animated:YES];
}

#pragma mark *********************气泡**********************
- (void)BubbleUI
{
    if(!bubbleV)
    {
        bubbleV = [[BubbleView alloc] initWithFrame:CGRectMake(ZOOM6(20), 100, (int)ZOOM6(450), (int)(ZOOM6(72) + ZOOM6(20)) * 2)];
        bubbleV.tag = 898989;
        [self.view addSubview:bubbleV];
        [bubbleV startScroll];
        [bubbleV getData];
    }
}

@end
