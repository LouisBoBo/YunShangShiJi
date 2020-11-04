//
//  AboutUsViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/24.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "AboutUsViewController.h"
#import "GlobalTool.h"
@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
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
    titlelable.text=@"关于我们";
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    [self creatView];

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

-(void)creatView
{
    UIView *discriptionview=[[UIView alloc]initWithFrame:CGRectMake(10, 74, kApplicationWidth-20, 200)];
    discriptionview.layer.borderWidth=1;
    discriptionview.layer.cornerRadius=3;
    discriptionview.layer.borderColor=kBackgroundColor.CGColor;
    [self.view addSubview:discriptionview];
    
    UILabel *discriptionlable=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, kApplicationWidth-40, 180)];
    discriptionlable.numberOfLines=0;
    discriptionlable.text=@"啡畅春园 赭要时最可悲黑暗 辊雷哥百 百 都要坚持eow0ewuefo  赤杰";
    [discriptionview addSubview:discriptionlable];
    
}

-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
