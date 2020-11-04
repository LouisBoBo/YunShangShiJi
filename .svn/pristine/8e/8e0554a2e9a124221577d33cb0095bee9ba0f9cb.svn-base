//
//  ShareBuyViewController.m
//  YunShangShiJi
//
//  Created by yssj on 15/8/5.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "ShareBuyViewController.h"
#import "GlobalTool.h"
#import "AffirmOrderViewController.h"

@interface ShareBuyViewController ()

@end

@implementation ShareBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavigationView];
    [self setMainView];
    
}

-(void)setNavigationView
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //    headview.image=[UIImage imageNamed:@"u265"];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    backbtn.frame=CGRectMake(10, 20, 40, 40);
    backbtn.centerY = View_CenterY(headview);
    backbtn.tintColor = [UIColor blackColor];
    //    backbtn.contentMode=UIViewContentModeScaleAspectFit;
    //    [backbtn setBackgroundImage:[UIImage imageNamed:@"u267"] forState:UIControlStateNormal];
    [backbtn setImage:[UIImage imageNamed:@"u267"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"分享购买";
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
}

-(void)setMainView
{
    UIImageView *smileView = [[UIImageView alloc]initWithFrame:CGRectMake(kApplicationWidth/2-40, 150, 80, 60)];
    smileView.image = [UIImage imageNamed:@"表情"];
    [self.view addSubview:smileView];
    
    UILabel *thanksLabel = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2-150, smileView.frame.origin.y+smileView.frame.size.height+30, 300, 50)];
    thanksLabel.text = @"亲爱的感谢惠顾哦！";
    thanksLabel.textColor = tarbarrossred;
    [thanksLabel setFont:[UIFont systemFontOfSize:30]];
    thanksLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:thanksLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(kApplicationWidth/2-100, thanksLabel.frame.origin.y+thanksLabel.frame.size.height +30,200, 50 );
    [btn setTitle:@"只要再轻轻点一下" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:19]];
    btn.tintColor = [UIColor blackColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel *remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2-150,  btn.frame.origin.y+btn.frame.size.height, 300, 50)];
    remindLabel.text = @"25元大洋就挣到啦!";
    remindLabel.textColor = tarbarrossred;
    [remindLabel setFont:[UIFont systemFontOfSize:19]];
    remindLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:remindLabel];
    
    for (int i=0; i<3; i++) {
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        shareBtn.frame = CGRectMake(i*kApplicationWidth/3+35, kApplicationHeight-150, 60, 60);
        shareBtn.tag = 3000+i;
        [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            [shareBtn setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
        }else if (i==1){
            [shareBtn setBackgroundImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
        }else{
            [shareBtn setBackgroundImage:[UIImage imageNamed:@"默默"] forState:UIControlStateNormal];
        }
        [self.view addSubview:shareBtn];
        
    }
    
}
/**
 *   25大洋到手
 */
-(void)btnClick:(UIButton * )sender
{
    
}
/**
 *   qq、微信、陌陌
 */
-(void)shareClick:(UIButton*)sender
{
    
}
-(void)back:(UIButton*)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    Myview.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    Myview.hidden=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
