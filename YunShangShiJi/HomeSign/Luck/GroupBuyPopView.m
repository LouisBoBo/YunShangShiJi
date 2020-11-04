//
//  GroupBuyPopView.m
//  YunShangShiJi
//
//  Created by YF on 2017/7/13.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "GroupBuyPopView.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MyMD5.h"

@interface leastTimeLabel : UIView
@property (nonatomic, strong) UILabel *minute;
@property (nonatomic, strong) UILabel *seconds;
@end
@implementation leastTimeLabel
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"剩余";
        label.textColor = [UIColor whiteColor];
        label.font = kFont6px(24);
        [self addSubview:label];
        UILabel *minute = [[UILabel alloc]init];
//        minute.text = @"剩余";
        minute.textColor = [UIColor whiteColor];
        minute.backgroundColor = tarbarrossred;
        minute.textAlignment = NSTextAlignmentCenter;
        minute.font = [UIFont boldSystemFontOfSize:ZOOM6(36)];
        [self addSubview:minute];
        UILabel *minuteLabel = [[UILabel alloc]init];
        minuteLabel.text = @"分";
        minuteLabel.textColor = [UIColor whiteColor];
        minuteLabel.font = kFont6px(24);
        [self addSubview:minuteLabel];
        UILabel *seconds = [[UILabel alloc]init];
//        seconds.text = @"剩余";
        seconds.textColor = [UIColor whiteColor];
        seconds.backgroundColor = tarbarrossred;
        seconds.textAlignment = NSTextAlignmentCenter;
        seconds.font = [UIFont boldSystemFontOfSize:ZOOM6(36)];
        [self addSubview:seconds];
        UILabel *secondsLabel = [[UILabel alloc]init];
        secondsLabel.text = @"秒";
        secondsLabel.textColor = [UIColor whiteColor];
        secondsLabel.font = kFont6px(24);
        [self addSubview:secondsLabel];

        _minute = minute;
        _seconds = seconds;

        [minuteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        [minute mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(minuteLabel.mas_left).offset(-ZOOM6(10));
            make.centerY.equalTo(self);
            make.width.height.offset(ZOOM6(60));
        }];
        [seconds mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(minuteLabel.mas_right).offset(ZOOM6(10));
            make.centerY.equalTo(self);
            make.width.height.equalTo(minute);
        }];
        [secondsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(seconds.mas_right).offset(ZOOM6(10));
            make.top.equalTo(minuteLabel);
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(minute.mas_left).offset(-ZOOM6(10));
            make.top.equalTo(minuteLabel);
        }];
    }
    return self;
}
@end


@interface GroupBuyPopView()
{
    UIImageView *topImg;
    UILabel *titleLabel;
    UILabel *subText;
    UILabel *giftRemind;
    UILabel *codeTitle;
    NSTimer *_timer; //计时器
}
@property (nonatomic, assign) GroupBuyPopType popType;
@property (nonatomic, strong) leastTimeLabel *timeView;
@end

@implementation GroupBuyPopView

- (instancetype)initWithFrame:(CGRect)frame popType:(GroupBuyPopType)popType {
    self=[super initWithFrame:frame];
    if (self) {
//        UIButton *btn=[[UIButton alloc]initWithFrame:self.bounds];
//        [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:btn];

        _popType = popType;

        if (popType == GroupBuyPopType1) {
            [self creatPopView1];
        }else if (popType == GroupBuyPopType3 || popType == GroupBuyPopType4 || popType == GroupBuyPopType9) {
            [self creatPopView3];
        }else if (popType == OneIndianaMinute)
        {
            [self creatPopView2];
        }else if (popType == OneIndianaWinning || popType == OneIndianaNotwinning)
        {
            [self creatPopView4];
        }else if (popType == OneIndianaSuccess)
        {
            [self creatPopView5];
        }else if (popType == GroupBuyPopType7) {
            [self creatPopView7];
        }
        else if (popType == GroupBuySuccess) {
            [self creatPopView6];
        }
        else if (popType == AddCardMemberType)
        {
            [self creatPopView9];
        }
        else
            [self creatPopView2];

    }
    return self;
}
- (void)creatPopView1 {
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"成功"]];
    [self addSubview:img];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:ZOOM6(36)];
    titleLabel.text = @"开团成功";
    [self addSubview:titleLabel];
    subText = [[UILabel alloc]init];
    subText.textColor = [UIColor whiteColor];
    subText.numberOfLines=0;
    [self addSubview:subText];
    UIButton *wxFriend = [UIButton buttonWithType:UIButtonTypeCustom]
    ;
    [wxFriend setImage:[UIImage imageNamed:@"icon_weinxinqun"] forState:UIControlStateNormal];
    UIButton *wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wxBtn setImage:[UIImage imageNamed:@"朋友圈-1"] forState:UIControlStateNormal];
    [wxFriend addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [wxBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    wxFriend.tag = 1;
    wxBtn.tag = 2;
    [self addSubview:wxFriend];
    [self addSubview:wxBtn];
    UILabel *wxFriendLabel = [[UILabel alloc]init];
    wxFriendLabel.textColor = [UIColor whiteColor];
    wxFriendLabel.font = kFont6px(24);
    wxFriendLabel.text = @"微信好友";
    wxFriendLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:wxFriendLabel];
    UILabel *wxLabel = [[UILabel alloc]init];
    wxLabel.textColor = [UIColor whiteColor];
    wxLabel.font = kFont6px(24);
    wxLabel.text = @"微信群";
    wxLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:wxLabel];
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setImage:[UIImage imageNamed:@"task_icon_close60X60"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dismissBtn];


    [wxFriend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kScreenHeight/2);
        make.left.offset(kScreenWidth/2-ZOOM6(140));
        make.width.height.offset(ZOOM6(100));
    }];
    [wxFriendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wxFriend.mas_bottom).offset(ZOOM6(20));
        make.left.width.equalTo(wxFriend);
    }];
    [wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wxFriend.mas_right).offset(ZOOM6(80));
        make.top.width.height.equalTo(wxFriend);
    }];
    [wxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(wxBtn);
        make.top.equalTo(wxFriendLabel);
    }];
    [subText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wxFriend.mas_top).offset(-ZOOM6(80));
        make.centerX.equalTo(self);
        make.width.offset(kScreenWidth-ZOOM6(100)*2);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(subText.mas_top).offset(-ZOOM6(15));
        make.centerX.equalTo(self).offset(ZOOM6(23));
    }];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(titleLabel.mas_left).offset(-ZOOM6(10));
        make.width.height.offset(ZOOM6(46));
        make.top.equalTo(titleLabel);
    }];
    [dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wxLabel.mas_bottom).offset(ZOOM6(80));
        make.centerX.equalTo(self);
        make.width.height.offset(ZOOM6(60));
    }];
}
- (void)creatPopView5 {
    
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"成功"]];
    [self addSubview:img];
    
    titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:ZOOM6(36)];
    titleLabel.text = @"参与成功";
    [self addSubview:titleLabel];
    
    codeTitle = [[UILabel alloc]init];
    codeTitle.textColor = [UIColor whiteColor];
    codeTitle.font = [UIFont boldSystemFontOfSize:ZOOM6(30)];
    codeTitle.textAlignment = NSTextAlignmentCenter;
    codeTitle.numberOfLines = 0;
    [self addSubview:codeTitle];

    subText = [[UILabel alloc]init];
    subText.textColor = [UIColor whiteColor];
    subText.font = [UIFont boldSystemFontOfSize:ZOOM6(30)];
    subText.numberOfLines = 0;
    [self addSubview:subText];
    
    UIButton *wxFriend = [UIButton buttonWithType:UIButtonTypeCustom]
    ;
    [wxFriend setImage:[UIImage imageNamed:@"微信好友"] forState:UIControlStateNormal];
    UIButton *wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wxBtn setImage:[UIImage imageNamed:@"icon_weinxinqun"] forState:UIControlStateNormal];
    [wxFriend addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [wxBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    wxFriend.tag = 1;
    wxBtn.tag = 2;
    [self addSubview:wxFriend];
    [self addSubview:wxBtn];
    
    UILabel *wxFriendLabel = [[UILabel alloc]init];
    wxFriendLabel.textColor = [UIColor whiteColor];
    wxFriendLabel.font = kFont6px(24);
    wxFriendLabel.text = @"微信";
    wxFriendLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:wxFriendLabel];
    UILabel *wxLabel = [[UILabel alloc]init];
    wxLabel.textColor = [UIColor whiteColor];
    wxLabel.font = kFont6px(24);
    wxLabel.text = @"微信群";
    wxLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:wxLabel];
    
    UILabel *bottomlab = [[UILabel alloc]init];
    bottomlab.textColor = [UIColor whiteColor];
    bottomlab.numberOfLines = 0;
    bottomlab.font = [UIFont boldSystemFontOfSize:ZOOM6(30)];
    NSString *text = [[NSUserDefaults standardUserDefaults]objectForKey:@"shareText2"];
    bottomlab.text = text;
    [self addSubview:bottomlab];

    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setImage:[UIImage imageNamed:@"task_icon_close60X60"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dismissBtn];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset((kScreenHeight-ZOOM6(700))/2);
        make.centerX.equalTo(self).offset(ZOOM6(23));
        make.height.offset(ZOOM6(46));
    }];

    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(titleLabel.mas_left).offset(-ZOOM6(10));
        make.width.height.offset(ZOOM6(46));
        make.top.equalTo(titleLabel);
    }];

    [codeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(ZOOM6(20));
        make.centerX.equalTo(self);
        make.height.offset(ZOOM6(30));
    }];
    
    [subText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeTitle.mas_bottom).offset(ZOOM6(30));
        make.left.offset(ZOOM6(100));
        make.height.offset(ZOOM6(120));
        make.width.offset(kScreenWidth-ZOOM6(100)*2);
    }];
    
    [wxFriend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subText.mas_bottom).offset(ZOOM6(60));
        make.left.offset(kScreenWidth/2-ZOOM6(140));
        make.width.height.offset(ZOOM6(100));
    }];
    [wxFriendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wxFriend.mas_bottom).offset(ZOOM6(20));
        make.left.width.equalTo(wxFriend);
    }];
    
    [wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wxFriend.mas_right).offset(ZOOM6(80));
        make.top.width.height.equalTo(wxFriend);
    }];
    [wxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(wxBtn);
        make.top.equalTo(wxFriendLabel);
    }];
    
    [bottomlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wxLabel.mas_bottom).offset(ZOOM6(40));
        make.centerX.equalTo(self);
        make.height.offset(ZOOM6(40));
    }];
    [dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomlab.mas_bottom).offset(ZOOM6(80));
        make.centerX.equalTo(self);
        make.width.height.offset(ZOOM6(60));
    }];
}

- (void)creatPopView2 {
    topImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"成功"]];
    [self addSubview:topImg];
    titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:ZOOM6(36)];
    titleLabel.text = @"恭喜你,拼团成功";
    [self addSubview:titleLabel];
    subText = [[UILabel alloc]init];
    subText.textColor = [UIColor whiteColor];
    subText.numberOfLines=0;
    subText.font = kFont6px(32);
    [self addSubview:subText];
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setImage:[UIImage imageNamed:@"task_icon_close60X60"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dismissBtn];

    [subText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(self).offset(-ZOOM6(40));
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(subText.mas_top).offset(-ZOOM6(15));
        make.centerX.equalTo(self).offset(ZOOM6(23));
    }];
    [topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(titleLabel.mas_left).offset(-ZOOM6(10));
        make.width.height.offset(ZOOM6(46));
        make.top.equalTo(titleLabel);
    }];
    [dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subText.mas_bottom).offset(ZOOM6(80));
        make.centerX.equalTo(self);
        make.width.height.offset(ZOOM6(60));
    }];
}
- (void)creatPopView3 {
    topImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"miyou_icon_close"]];
    [self addSubview:topImg];
    titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:ZOOM6(36)];
//    titleLabel.text = @"恭喜你,拼团成功";
    [self addSubview:titleLabel];
    subText = [[UILabel alloc]init];
    subText.textColor = [UIColor whiteColor];
    subText.numberOfLines=0;
    subText.font = kFont6px(28);
//    subText.textAlignment = NSTextAlignmentCenter;
    [self addSubview:subText];
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setImage:[UIImage imageNamed:@"task_icon_close60X60"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dismissBtn];

    UIImageView *gift = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"拼团_gift"]];
    gift.userInteractionEnabled = YES;
    [self addSubview:gift];
    giftRemind = [[UILabel alloc]init];
    giftRemind.textAlignment = NSTextAlignmentCenter;
    giftRemind.font = kFont6px(28);
    giftRemind.textColor = [UIColor whiteColor];
    giftRemind.numberOfLines = 3;
    [giftRemind setAttributedText:[NSString getOneColorInLabel:@"今日又更新了7个任务，\n共计60元现金等你拿哦。" strs:@[@"7",@"60元"] Color:[UIColor yellowColor] font:[UIFont boldSystemFontOfSize:ZOOM6(28)]]];
    [gift addSubview:giftRemind];
    
//    UIButton *tixianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [tixianBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    tixianBtn.backgroundColor = [UIColor yellowColor];
//    [tixianBtn setTitle:@"去提现" forState:UIControlStateNormal];
//    [tixianBtn setTitleColor:RGBA(249, 81, 67, 1) forState:UIControlStateNormal];
//    tixianBtn.layer.cornerRadius = 3;
//    tixianBtn.tag = 55;
//    [gift addSubview:tixianBtn];
    
    UIButton *moneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moneyBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    moneyBtn.backgroundColor = [UIColor yellowColor];
    [moneyBtn setTitle:@"去领钱" forState:UIControlStateNormal];
    [moneyBtn setTitleColor:RGBA(249, 81, 67, 1) forState:UIControlStateNormal];
    moneyBtn.layer.cornerRadius = 3;
    moneyBtn.tag = 5;
    [gift addSubview:moneyBtn];

    [subText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.offset(self.height/5);
//        make.width.equalTo(self).offset(-ZOOM6(40));
        make.width.offset(kScreenWidth-ZOOM6(100)*2);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(subText.mas_top).offset(-ZOOM6(15));
        make.centerX.equalTo(self).offset(ZOOM6(23));
    }];
    [topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(titleLabel.mas_left).offset(-ZOOM6(10));
        make.width.height.offset(ZOOM6(46));
        make.top.equalTo(titleLabel);
    }];
    [gift mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subText.mas_bottom).offset(ZOOM6(40));
        make.centerX.equalTo(self);
        make.height.offset(ZOOM6(548));
        make.width.offset(ZOOM6(482));
    }];
    [dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(gift.mas_bottom).offset(ZOOM6(40));
        make.centerX.equalTo(self);
        make.width.height.offset(ZOOM6(60));
    }];
    [giftRemind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(ZOOM6(190));
        make.left.offset(ZOOM6(60));
        make.right.offset(-ZOOM6(60));
    }];
//    [tixianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(giftRemind.mas_bottom).offset(ZOOM6(30));
//        make.centerX.equalTo(gift);
//        make.width.offset(ZOOM6(280));
//        make.height.offset(ZOOM6(80));
//    }];
    
    [moneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(giftRemind.mas_bottom).offset(ZOOM6(40));
        make.centerX.equalTo(gift);
        make.width.offset(ZOOM6(280));
        make.height.offset(ZOOM6(80));
    }];
}

- (void)creatPopView6 {
    
    subText = [[UILabel alloc]init];
    subText.textColor = [UIColor whiteColor];
    subText.numberOfLines=0;
    subText.font = kFont6px(28);
    [self addSubview:subText];
    
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setImage:[UIImage imageNamed:@"task_icon_close60X60"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dismissBtn];
    
    UIImageView *gift = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"拼团_gift"]];
    gift.userInteractionEnabled = YES;
    [self addSubview:gift];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = @"恭喜拼单成功";
    titleLab.font = kFont6px(32);
    titleLab.textColor = [UIColor whiteColor];
    [gift addSubview:titleLab];
    
    giftRemind = [[UILabel alloc]init];
    giftRemind.textAlignment = NSTextAlignmentCenter;
    giftRemind.font = kFont6px(28);
    giftRemind.textColor = [UIColor whiteColor];
    giftRemind.numberOfLines = 3;
    [giftRemind setAttributedText:[NSString getOneColorInLabel:[NSString stringWithFormat:@"现在可以去开启\n%@元提现啦!",@"20"] strs:@[@"20"] Color:[UIColor yellowColor] font:[UIFont boldSystemFontOfSize:ZOOM6(32)]]];
    [gift addSubview:giftRemind];
    
    UIButton *tixianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tixianBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    tixianBtn.backgroundColor = [UIColor yellowColor];
    [tixianBtn setTitle:@"去提现" forState:UIControlStateNormal];
    [tixianBtn setTitleColor:RGBA(249, 81, 67, 1) forState:UIControlStateNormal];
    tixianBtn.layer.cornerRadius = 3;
    tixianBtn.tag = 55;
    [gift addSubview:tixianBtn];
    
    [subText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.offset(self.height/4);
        make.width.offset(kScreenWidth-ZOOM6(100)*2);
    }];
    
    [gift mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subText.mas_bottom).offset(ZOOM6(40));
        make.centerX.equalTo(self);
        make.height.offset(ZOOM6(548));
        make.width.offset(ZOOM6(482));
    }];
    [dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(gift.mas_bottom).offset(ZOOM6(40));
        make.centerX.equalTo(self);
        make.width.height.offset(ZOOM6(60));
    }];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(ZOOM6(200));
        make.left.offset(ZOOM6(60));
        make.right.offset(-ZOOM6(60));
    }];
    
    [giftRemind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(ZOOM6(250));
        make.left.offset(ZOOM6(60));
        make.right.offset(-ZOOM6(60));
    }];
    [tixianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(giftRemind.mas_bottom).offset(ZOOM6(30));
        make.centerX.equalTo(gift);
        make.width.offset(ZOOM6(280));
        make.height.offset(ZOOM6(80));
    }];
    
}
- (void)creatPopView4 {
    topImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Oneyuan_gift"]];
    [self addSubview:topImg];
    
    titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:ZOOM6(36)];
    [self addSubview:titleLabel];
    
    subText = [[UILabel alloc]init];
    subText.textColor = [UIColor whiteColor];
    subText.numberOfLines=0;
    subText.font = kFont6px(28);
    subText.textAlignment = NSTextAlignmentCenter;
    [self addSubview:subText];
    
    UIButton *moneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moneyBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [moneyBtn setTitle:@"查看余额" forState:UIControlStateNormal];
    [moneyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    moneyBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    moneyBtn.layer.borderWidth = 1;
    moneyBtn.tag = 6;
    [self addSubview:self.mymoneyBtn=moneyBtn];

    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setImage:[UIImage imageNamed:@"task_icon_close60X60"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dismissBtn];
    
    
    [topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset((kScreenHeight-ZOOM6(700))/2);
        make.left.offset((kScreenWidth-ZOOM6(300))/2);
        make.width.height.offset(ZOOM6(300));
    }];

    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImg.mas_bottom);
        make.left.offset(ZOOM6(40));
        make.width.offset(kScreenWidth-2*ZOOM6(40));
        make.height.offset(ZOOM6(20));
    }];

    [subText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(ZOOM6(24));
        make.left.offset(ZOOM6(40));
        make.width.offset(kScreenWidth-2*ZOOM6(40));
        make.height.mas_greaterThanOrEqualTo(ZOOM6(80));
    }];
    
    [moneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subText.mas_bottom).offset(ZOOM6(50));
        make.centerX.equalTo(self);
        make.width.offset(ZOOM6(280));
        make.height.offset(ZOOM6(80));
    }];

    [dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyBtn.mas_bottom).offset(ZOOM6(80));
        make.centerX.equalTo(self);
        make.width.height.offset(ZOOM6(60));
    }];
}
- (void)creatPopView7 {
    titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:ZOOM6(36)];
    titleLabel.text = @"拼团人数已满,请立即付款！";
    [self addSubview:titleLabel];

    _timeView = [[leastTimeLabel alloc]init];
    [self addSubview:_timeView];

    UIButton *moneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moneyBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [moneyBtn setTitle:@"去付款" forState:UIControlStateNormal];
    moneyBtn.titleLabel.font = kFont6px(32);
    [moneyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    moneyBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    moneyBtn.layer.borderWidth = 1;
    moneyBtn.tag = 7;
    [self addSubview:moneyBtn];

    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setImage:[UIImage imageNamed:@"task_icon_close60X60"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dismissBtn];

    [_timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(self).offset(-ZOOM6(40));
        make.height.offset(ZOOM6(60));
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_timeView.mas_top).offset(-ZOOM6(40));
        make.centerX.equalTo(self);
    }];


    [moneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeView.mas_bottom).offset(ZOOM6(80));
        make.centerX.equalTo(self);
        make.width.offset(ZOOM6(240));
        make.height.offset(ZOOM6(80));
    }];

    [dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyBtn.mas_bottom).offset(ZOOM6(80));
        make.centerX.equalTo(self);
        make.width.height.offset(ZOOM6(60));
    }];
}
- (void)creatPopView8 {

    titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:ZOOM6(36)];
    titleLabel.numberOfLines = 0;
    titleLabel.text = @"很遗憾，该团你并未在指定时间内付款，本次拼团已失效，谢谢你的参与。";
    [self addSubview:titleLabel];

    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setImage:[UIImage imageNamed:@"task_icon_close60X60"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dismissBtn];

    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(self).offset(-ZOOM6(180));
    }];
    [dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(ZOOM6(80));
        make.centerX.equalTo(self);
        make.width.height.offset(ZOOM6(60));
    }];
}
- (void)creatPopView9{
    
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setImage:[UIImage imageNamed:@"task_icon_close60X60"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dismissBtn];
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/member_HongBao.png"]]]];
    CGFloat image_w = kScreen_Width*0.85;
    CGFloat image_h = image.size.height*kScreen_Width/750;
    
    UIImageView *gift = [[UIImageView alloc]initWithImage:image];
    gift.userInteractionEnabled = YES;
    gift.contentMode = UIViewContentModeScaleAspectFill;
    gift.userInteractionEnabled = YES;
    [self addSubview:gift];
    
    UITapGestureRecognizer *addcardTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addcardClick:)];
    [gift addGestureRecognizer:addcardTap];
    
    [gift mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.height.offset(image_h);
        make.width.offset(image_w);
    }];
    [dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(gift.mas_bottom).offset(ZOOM6(60));
        make.centerX.equalTo(self);
        make.width.height.offset(ZOOM6(60));
    }];
}
- (void)countDownTime {
    int minute1 = (int)(_timeout%(60*60))/60;
    int seconds1 = (int)_timeout%60;
    _timeView.minute.text = [NSString stringWithFormat:@"%d",minute1];//@"8";
    _timeView.seconds.text = [NSString stringWithFormat:@"%d",seconds1];//@"58";

    if ([_timer isValid]) {
        [_timer invalidate];
    }
    kSelfWeak;
    _timer = [NSTimer weakTimerWithTimeInterval:1.0 target:self userInfo:nil repeats:YES block:^(id target, NSTimer *timer) {
        kSelfStrong;
        if(strongSelf -> _timeout<=0){ //倒计时结束，关闭
            [strongSelf -> _timer invalidate];
            strongSelf -> _timer = nil;
            [strongSelf dismiss];
            if (strongSelf.timeOutBlock) {
                strongSelf.timeOutBlock();
            }
//            [strongSelf.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//            [strongSelf creatPopView8];
        } else {
            int minute = (int)(strongSelf -> _timeout%(60*60))/60;
            int seconds = (int)strongSelf -> _timeout%60;
            strongSelf -> _timeView.minute.text = [NSString stringWithFormat:@"%d",minute];//@"8";
            strongSelf -> _timeView.seconds.text = [NSString stringWithFormat:@"%d",seconds];//@"58";
            strongSelf -> _timeout--;
        }
    }];
}

- (void)btnClick:(UIButton *)sender {
    if (self.btnBlok) {
        self.btnBlok(sender.tag);
    }
    [self dismiss];
}
- (void)addcardClick:(UITapGestureRecognizer*)tap
{
    if (self.btnBlok) {
        self.btnBlok(tap.view.tag);
    }
    [self dismiss];
}
- (void)show {

    UIViewController *topVC = [self appRootViewController];
    [topVC.view addSubview:self];

    if (self.popType == GroupBuyPopType1) {

        //还差%@人，赶快邀请好友来参团吧
        [subText setAttributedText:[NSString getOneColorInLabel:[NSString stringWithFormat:@"还差%@人，拼团成功后即可免费领商品，快邀请好友一起来免费领商品吧！",self.num] ColorString:self.num Color:tarbarrossred fontSize:ZOOM6(40)]];
    }else if (self.popType == GroupBuyPopType2) {
        titleLabel.text = @"恭喜你，拼团成功！";
        subText.text = @"商家正在努力发货，请耐心等待！";
        subText.textAlignment = NSTextAlignmentCenter;
    }else if (self.popType == GroupBuyPopType7) {
        [self countDownTime];
    }
    else {
        [topImg setImage:[UIImage imageNamed:@"miyou_icon_close"]];

        if (self.popType == GroupBuyPopType3) {
            NSString *str = [NSString stringWithFormat:@"今日又更新了%@个任务，\n共计%@现金等你拿哦。",self.taskNum,self.moneyNum];
            str = @"衣蝠为您准备\n了20元可提现\n现金红包";
            if(self.taskNum != nil && self.moneyNum != nil)
            {
                [giftRemind setAttributedText:[NSString getOneColorInLabel:str strs:@[self.taskNum,self.moneyNum] Color:[UIColor yellowColor] font:[UIFont boldSystemFontOfSize:ZOOM6(40)]]];
            }
            titleLabel.text = @"拼团未成功！";
            subText.text = @"因在规定时间内参团人数不足，您的免费领拼团未成功，本次免费领资格失效。下次再来吧。";
            giftRemind.font = [UIFont systemFontOfSize:ZOOM6(40)];
        }else if (self.popType == GroupBuyPopType4) {
            NSString *str = [NSString stringWithFormat:@"今日又更新了%@个任务，\n共计%@现金等你拿哦。",self.taskNum,self.moneyNum];
            [giftRemind setAttributedText:[NSString getOneColorInLabel:str strs:@[self.taskNum,self.moneyNum] Color:[UIColor yellowColor] font:[UIFont boldSystemFontOfSize:ZOOM6(28)]]];
            titleLabel.text = @"拼团未成功！";
            subText.text = @"很遗憾，你的拼团未能在时效内达到付款人数，本次拼团未能成功。拼团费会在5-7个工作日内原路退回至支付账号。谢谢您的参与。";//@"很遗憾,你的拼团未能在时效内达到付款人数,\n本次拼团未能成功。拼团费会在5-7个工\n作日内原路退回至支付账号。谢谢您的参与。";
        }else if (self.popType == GroupBuyPopType9) {
            NSString *str = [NSString stringWithFormat:@"今日又更新了%@个任务，\n共计%@现金等你拿哦。",self.taskNum,self.moneyNum];
            [giftRemind setAttributedText:[NSString getOneColorInLabel:str strs:@[self.taskNum,self.moneyNum] Color:[UIColor yellowColor] font:[UIFont boldSystemFontOfSize:ZOOM6(28)]]];
            titleLabel.text = @"拼团未成功！";
            subText.text = @"很遗憾，该团你并未在指定时间内付款，本次拼团已失效。谢谢您的参与。";
        }
        else if (self.popType == GroupBuyPopType5) {
            titleLabel.text = @"很遗憾，人数已满！";
            subText.text = @"你参与的拼团已达到拼团人数哦，去尝试自己开个团吧。";
        }
        else if (self.popType == GroupBuyPopType6) {
            titleLabel.text = @"很遗憾，已过期！";
            subText.text = @"你参与的拼团已过期，去尝试自己开个团吧。";
        }
        else if (self.popType == OneIndianaNotwinning)
        {
            
            [topImg setImage:[UIImage imageNamed:@"Oneyuan_gift"]];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = @"开奖啦！";
            
            self.mymoneyBtn.layer.borderWidth = 0;
            self.mymoneyBtn.userInteractionEnabled = NO;
            [self.mymoneyBtn setTitle:@"再接再厉哦~说不定下一个中奖的就是你哦~" forState:UIControlStateNormal];
            self.mymoneyBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(24)];
            [self.mymoneyBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.offset(kScreenWidth);
            }];
            
            subText.textAlignment = NSTextAlignmentCenter;
            
            NSString *newstr = [DataManager sharedManager].duobaoMessage;
            NSArray *duobaoArr = [newstr componentsSeparatedByString:@"^"];
            if(duobaoArr.count >=3)
            {
                subText.text = [NSString stringWithFormat:@"您参与的第%@期提现抽奖开奖啦！\n中奖号码为：%@\n中奖者:%@",duobaoArr[0],duobaoArr[1],duobaoArr[2]];
            }
            
        }
        else if (self.popType == OneIndianaMinute)
        {
            titleLabel.text = @"马上开奖！";
            subText.textAlignment = NSTextAlignmentCenter;
            subText.text = @"请勿离开！您参加的一元抽奖马上开奖~";
        }else if (self.popType == OneIndianaWinning)
        {
            [topImg setImage:[UIImage imageNamed:@"Oneyuan_gift"]];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = @"恭喜您，中奖啦!";
            subText.textAlignment = NSTextAlignmentCenter;
            subText.text = @"50元提现额度已发放至您的帐户，\n快到钱包查看吧！";
        }else if (self.popType == OneIndianaSuccess)
        {
            titleLabel.text = @"参与成功";
            NSString *codes = [[NSUserDefaults standardUserDefaults]objectForKey:@"OneIndiana"];
            NSString *text = [[NSUserDefaults standardUserDefaults]objectForKey:@"shareText1"];
            codeTitle.text = [NSString stringWithFormat:@"抽奖号为：%@",codes];
            subText.text = [NSString stringWithFormat:@"%@",text];
        }else if (self.popType == GroupBuySuccess)
        {
            
            if(self.moneyNum != nil)
            {
                [giftRemind setAttributedText:[NSString getOneColorInLabel:[NSString stringWithFormat:@"现在可以去开启\n%@元提现啦!",self.moneyNum] strs:@[self.moneyNum] Color:[UIColor yellowColor] font:[UIFont boldSystemFontOfSize:ZOOM6(32)]]];
            }
        }

    }

    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];

    self.alpha = 0;

    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
    }];

}

- (void)close {
    [self dismiss];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{

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

#pragma mark 获取夺宝开奖信息
- (NSString*)getduobaoStatueHttp
{
    NSString *mentionstring = @"";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSString *url=[NSString stringWithFormat:@"%@treasures/getMsg?version=%@&token=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]];
    
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        NSString*status = responseObject[@"status"];
        if (responseObject !=nil && ![responseObject isEqual:[NSNull null]] && status.intValue==1){
            
            NSString *datastr = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
            NSArray *dataArr = [NSArray arrayWithObject:responseObject[@"data"]];
            if(dataArr.count && datastr.length >0)
            {
                NSString *sss = [NSString stringWithFormat:@"%@",responseObject[@"data"][0]];
                NSArray *dataArray = [sss componentsSeparatedByString:@"^"];
                if(dataArray.count >= 7)
                {
                    NSString *sss = [NSString stringWithFormat:@"%@",responseObject[@"data"][0]];
                    NSArray *dataArray = [sss componentsSeparatedByString:@"^"];
                    if(dataArray.count >= 7)
                    {
                        NSMutableString *sstt = [NSMutableString stringWithFormat:@"%@",dataArray[0]];
                        
                        //中奖类型 0：一分夺宝 1：1元夺宝 2：拼团夺宝
                        NSString *indianatype = [NSMutableString stringWithFormat:@"%@",dataArray[7]];
                        if([sstt isEqualToString:@"true"] && indianatype.intValue == 1)//中奖
                        {
                            
                       
                        }
                    }
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    return mentionstring;
}



@end
