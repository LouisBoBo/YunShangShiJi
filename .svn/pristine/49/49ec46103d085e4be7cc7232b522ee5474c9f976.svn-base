//
//  RefunddetailViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/24.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "RefunddetailViewController.h"
#import "GlobalTool.h"
@interface RefunddetailViewController ()

@end

@implementation RefunddetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"退款成功";
    titlelable.textColor=[UIColor whiteColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    [self creatview];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    Myview.hidden=YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    Myview.hidden=NO;
}

-(void)creatview
{
    self.Myscrollview.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.refundtitle.textColor=tarbarrossred;

}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
