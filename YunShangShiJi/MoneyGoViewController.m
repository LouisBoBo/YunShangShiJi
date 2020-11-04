//
//  MoneyGoViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/4.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "MoneyGoViewController.h"
#import "GlobalTool.h"
@interface MoneyGoViewController ()

@end

@implementation MoneyGoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _img1.layer.cornerRadius = _img1.frame.size.height/2;
    _img2.layer.cornerRadius = _img2.frame.size.height/2;
    _img3.layer.cornerRadius = _img3.frame.size.height/2;
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"钱款去向";

    titlelable.textColor=kMainTitleColor;

    titlelable.font=kNavTitleFontSize;

    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
