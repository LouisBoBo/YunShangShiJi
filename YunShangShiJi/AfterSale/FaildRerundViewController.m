//
//  FaildRerundViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/10/29.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "FaildRerundViewController.h"
#import "GlobalTool.h"

@interface FaildRerundViewController ()

@end

@implementation FaildRerundViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    backbtn.frame=CGRectMake(10, 25, 15, 25);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"退款失败";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];

}

-(void)back:(UIButton*)sender
{
    [self .navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
