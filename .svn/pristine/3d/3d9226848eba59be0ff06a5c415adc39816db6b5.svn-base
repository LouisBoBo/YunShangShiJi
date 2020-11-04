//
//  TFIntegralExplainViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/16.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFIntegralExplainViewController.h"
//#import "ChatViewController.h"
//#import "ChatListViewController.h"
@interface TFIntegralExplainViewController ()

@end

@implementation TFIntegralExplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItemLeft:@"我的积分"];
    [self createUI];
}

- (void)createUI
{
    CGFloat Margin_lr = ZOOM(62);
    CGFloat Margin_ud = ZOOM(50);
    CGFloat Margin_uud = ZOOM(50);
    CGFloat H_l = ZOOM(67);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(Margin_lr, kNavigationheightForIOS7, kScreenWidth, ZOOM(180))];
    label.text = @"积分赚取方式";
    label.font = kFont6px(34);
    [self.view addSubview:label];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0,  label.bottom+Margin_ud, kScreenWidth, 1)];
    lineView1.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView1];
    //1.
    NSArray *titArr1 = [NSArray arrayWithObjects:@"1.每日签到",@"• 5-10-15-25-50-100-200", nil];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(Margin_lr,  lineView1.bottom+Margin_ud, kScreenWidth-Margin_ud, H_l)];
    label2.text = titArr1[0];
    label2.font = kFont6px(32);
    [self.view addSubview:label2];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(Margin_lr,  label2.bottom+Margin_uud, kScreenWidth-2*Margin_lr, H_l)];
    label3.text =titArr1[1];
    label3.font = kFont6px(32);
    label3.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label3];
//    CGSize size = [titArr1[1] boundingRectWithSize:CGSizeMake(kScreenWidth- label3]-Margin_lr, ZOOM(1000)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFont6px(32)} context:nil].size;
//    
//    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake( label3]+5, label3.frame.origin.y, size.width, size.height)];
//    label4.numberOfLines = 0;
//    label4.text = titArr1[1];
//    label4.font = kFont6px(32);
//    [self.view addSubview:label4];
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0,  label3.bottom+ZOOM(50), kScreenWidth, 1)];
    lineView2.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView2];

    //2.
    NSArray *titArr2 = [NSArray arrayWithObjects:@"2.做任务（新用户）",@"• 完善注册信息 50",@"• 设置个人头像为自拍 50",@"• 认证手机号 50",@"• 认证邮箱 50",@"• 打分鼓励我们 50", nil];
    
    for (int i = 0; i<titArr2.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(Margin_lr,  lineView2.bottom+Margin_uud*(i+1)+i*H_l, kScreenWidth-2*Margin_lr, H_l)];
        label.text = titArr2[i];
        label.font = kFont6px(32);
        [self.view addSubview:label];
    }
}

-(void)rightBarButtonClick
{
    [self Message];
}

#pragma mark 消息盒子
-(void)Message
{
    //begin 赵官林 2016.5.26 跳转到消息列表
    [self presentChatList];
    //end
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
