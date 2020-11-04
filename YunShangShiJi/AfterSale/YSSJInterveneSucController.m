//
//  YSSJInterveneSucController.m
//  YunShangShiJi
//
//  Created by yssj on 16/3/30.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YSSJInterveneSucController.h"
//#import "ChatListViewController.h"
#import "InterveneDetailViewController.h"
#import "AftersaleViewController.h"

#define label1String @"您已成功提交申请"
#define label2String @"请耐心等待平台审核"

@interface YSSJInterveneSucController ()

@end

@implementation YSSJInterveneSucController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItemLeft:@"申请平台介入"];
    
    UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-40, kScreenHeight/2-80, 80, 80)];
    imgView.image=[UIImage imageNamed:@"平台介入成功"];
    imgView.contentMode=UIViewContentModeScaleAspectFit;
    [self.view addSubview:imgView];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame)+ZOOM(32), kScreenWidth, 30)];
    label1.text=label1String;
    label1.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label1];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame), kScreenWidth, 30)];
    label2.text=label2String;
    label2.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label2];
    
    
}
-(void)leftBarButtonClick
{
    for (UIViewController *view in self.navigationController.viewControllers) {
        if ([view isKindOfClass:[AftersaleViewController class]]) {
            [self.navigationController popToViewController:view animated:YES];
            return;
        }
    }
}
-(void)rightBarButtonClick{
    // begin 赵官林 2016.5.26 跳转到消息列表
    [self presentChatList];
    // end
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
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
