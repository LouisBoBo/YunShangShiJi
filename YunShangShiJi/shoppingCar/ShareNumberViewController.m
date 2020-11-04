//
//  ShareNumberViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/10/9.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "ShareNumberViewController.h"
#import "GlobalTool.h"
@interface ShareNumberViewController ()

@end

@implementation ShareNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationView];
    
    [self creatmainView];
}

-(void)setNavigationView
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //    headview.image=[UIImage imageNamed:@"u265"];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"智能分享";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
}

- (void)creatmainView
{
//    self.imageview.image = [UIImage imageNamed:@""];
    
    self.titlelable.text=@"亲爱的，你今天的分享次数已经全部使用了哦！本单会直接结算回佣给您，祝你购物愉快。";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}

-(void)back:(UIButton*)sender
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
//    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
