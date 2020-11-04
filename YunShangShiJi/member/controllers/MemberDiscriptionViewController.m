//
//  MemberDiscriptionViewController.m
//  YunShangShiJi
//
//  Created by hebo on 2020/8/14.
//  Copyright © 2020 ios-1. All rights reserved.
//

#import "MemberDiscriptionViewController.h"

@interface MemberDiscriptionViewController ()

@end

@implementation MemberDiscriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationItemLeft:@"会员奖励"];
    [self creatManivew];
}

- (void)creatManivew{
    
    UIScrollView *baseView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    baseView.scrollEnabled = YES;
    baseView.contentSize = CGSizeMake(kScreenWidth, 1000);
    [self.view addSubview:baseView];
    
    UIView *footview = [[UIView alloc]initWithFrame:CGRectZero];
    footview.backgroundColor = tarbarrossred;
    [self.view addSubview:footview];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"快来加入会员打卡计划!";
    titleLab.textAlignment = NSTextAlignmentCenter;
    [baseView addSubview:titleLab];
    
    UIView *discriptionview = [[UIView alloc]init];
    discriptionview.clipsToBounds = YES;
    discriptionview.layer.borderWidth=ZOOM6(5);
    discriptionview.layer.borderColor = tarbarrossred.CGColor;
    [baseView addSubview:discriptionview];
    
    UILabel *dis1 = [[UILabel alloc] init];
    dis1.text = @"本期补贴25万元现金";
    [discriptionview addSubview:dis1];
    
    UILabel *dis2 = [[UILabel alloc] init];
    dis2.text = @"完成打卡返100元奖金|7天";
    [discriptionview addSubview:dis2];
    
    UILabel *dis3 = [[UILabel alloc] init];
    dis3.text = @"快来加入会员打卡计划!";
    [discriptionview addSubview:dis3];
    
    UILabel *dis4 = [[UILabel alloc] init];
    dis4.text = @"快来加入会员打卡计划!";
    [discriptionview addSubview:dis4];
    
    UILabel *dis5 = [[UILabel alloc] init];
    dis5.text = @"快来加入会员打卡计划!";
    [discriptionview addSubview:dis5];
    
    UILabel *dis6 = [[UILabel alloc] init];
    dis6.text = @"快来加入会员打卡计划!";
    [discriptionview addSubview:dis6];
    
    UILabel *footLab = [[UILabel alloc] init];
    footLab.text = @"7天后你将收获";
    footLab.textAlignment = NSTextAlignmentCenter;
    [baseView addSubview:footLab];
    
    UILabel *priceLab = [[UILabel alloc]init];
    priceLab.textColor = kWiteColor;
    priceLab.text = @"全勤分享";
    [footview addSubview:priceLab];
    
    UIButton *confirmBtn = [[UIButton alloc]init];
    [confirmBtn setBackgroundColor:[UIColor redColor]];
    [confirmBtn setTintColor:kWiteColor];
    confirmBtn.clipsToBounds = YES;
    confirmBtn.layer.cornerRadius=ZOOM6(30);
    [confirmBtn setTitle:@"立即成为会员" forState:UIControlStateNormal];
    [footview addSubview:confirmBtn];
    
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(Height_NavBar);
        make.left.equalTo(@0);
        make.width.height.equalTo(self.view);
    }];
    
    [footview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.width.equalTo(self.view);
        make.height.equalTo(@ZOOM6(100));
    }];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baseView).offset(ZOOM6(50));
        make.width.equalTo(baseView);
        make.height.mas_offset(ZOOM6(50));
    }];
    
    [discriptionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).offset(ZOOM6(50));
        make.left.equalTo(titleLab.mas_left).offset(ZOOM6(50));
        make.right.equalTo(titleLab.mas_right).offset(-ZOOM6(50));
        make.height.mas_offset(ZOOM6(550));
    }];
    
    [dis1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(discriptionview.mas_top).offset(ZOOM6(50));
        make.left.mas_equalTo(discriptionview).offset(ZOOM6(20));
        make.width.equalTo(discriptionview);
        make.height.mas_offset(ZOOM6(50));
    }];
    
    [dis2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(discriptionview.mas_top).offset(ZOOM6(50)*2);
        make.left.mas_equalTo(discriptionview).offset(ZOOM6(20));
        make.width.equalTo(discriptionview);
        make.height.mas_offset(ZOOM6(50));
    }];
    
    [dis3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(discriptionview.mas_top).offset(ZOOM6(50)*3);
        make.left.mas_equalTo(discriptionview).offset(ZOOM6(20));
        make.width.equalTo(discriptionview);
        make.height.mas_offset(ZOOM6(50));
    }];
    
    [dis4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(discriptionview.mas_top).offset(ZOOM6(50)*4);
        make.left.mas_equalTo(discriptionview).offset(ZOOM6(20));
        make.width.equalTo(discriptionview);
        make.height.mas_offset(ZOOM6(50));
    }];
    [dis5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(discriptionview.mas_top).offset(ZOOM6(50)*5);
        make.left.mas_equalTo(discriptionview).offset(ZOOM6(20));
        make.width.equalTo(discriptionview);
        make.height.mas_offset(ZOOM6(50));
    }];
    [dis6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(discriptionview.mas_top).offset(ZOOM6(50)*6);
        make.left.mas_equalTo(discriptionview).offset(ZOOM6(20));
        make.width.equalTo(discriptionview);
        make.height.mas_offset(ZOOM6(50));
    }];
    [footLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(discriptionview.mas_bottom).offset(ZOOM6(100));
        make.width.equalTo(baseView);
        make.height.mas_offset(ZOOM6(50));
    }];
    
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.height.equalTo(footview);
        make.width.mas_offset(ZOOM6(300));
    }];
    
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(footview).offset(ZOOM6(20));
        make.left.equalTo(footview.mas_right).offset(-ZOOM6(320));
        make.width.mas_offset(ZOOM6(300));
        make.height.mas_offset(ZOOM6(60));
    }];
}

@end
