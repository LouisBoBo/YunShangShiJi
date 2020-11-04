//
//  PayFailedViewController.m
//  YunShangShiJi
//
//  Created by yssj on 15/8/6.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "PayFailedViewController.h"
#import "AffirmOrderViewController.h"
#import "MyOrderViewController.h"
#import "GlobalTool.h"
#import "ShopDetailViewController.h"



@interface PayFailedViewController ()

@end

@implementation PayFailedViewController

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
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 125)];
    //    headview.image=[UIImage imageNamed:@"u265"];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(kApplicationWidth/2-60, IS_IPHONE_X?40:20, 120, 40);
    titlelable.text=@"收银台";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, IS_IPHONE_X?40:20, 46, 46);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    

    
    UIImageView *payView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 85, 28, 21)];
    payView.image = [UIImage imageNamed:@"快捷支付"];
//    [headview addSubview:payView];
    
    UILabel* noteLabel = [[UILabel alloc] init];
    noteLabel.frame = CGRectMake(payView.frame.origin.x + payView.frame.size.width +10, payView.frame.origin.y, 200, 25);
    noteLabel.textColor = [UIColor lightGrayColor];
    noteLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"快捷支付 安全可靠 便利快捷"];
    NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@" "].location);
    [noteStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(48)]} range:redRange];
    [noteLabel setAttributedText:noteStr] ;
    [noteLabel sizeToFit];
//    [headview addSubview:noteLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.size.height-1, kApplicationWidth, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
//    [headview addSubview:line];
    
}
/**
 *  主界面
 */
-(void)setMainView
{
    UIImageView *smileView = [[UIImageView alloc]initWithFrame:CGRectMake(kApplicationWidth/2-20, 200, 40, 40)];
    //    smileView.center = CGPointMake(kApplicationWidth/2, 100);
    smileView.image = [UIImage imageNamed:@"失败"];
    [self.view addSubview:smileView];
    
    UILabel *thanksLabel = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2-150, smileView.frame.origin.y+smileView.frame.size.height+10, 300, 50)];
    thanksLabel.text = @"抱歉!付款失败!";
    thanksLabel.textColor = [UIColor blackColor];
    [thanksLabel setFont:[UIFont systemFontOfSize:ZOOM(60)]];
    thanksLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:thanksLabel];
    
    
    UILabel *remindLabel = [[UILabel alloc]initWithFrame:CGRectMake((kApplicationWidth-200)/2,  thanksLabel.frame.origin.y+thanksLabel.frame.size.height -20, 200, 50)];
    remindLabel.text = @"此银行卡签约快捷支付(含卡通)可使用快捷支付付款";
    remindLabel.numberOfLines=0;
    remindLabel.textColor = [UIColor lightGrayColor];
    [remindLabel setFont:[UIFont systemFontOfSize:ZOOM(38)]];
    remindLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:remindLabel];
    
    UIButton *otherPayBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    otherPayBtn.frame = CGRectMake(30,  remindLabel.frame.origin.y+remindLabel.frame.size.height, kApplicationWidth-60, 40);
    [otherPayBtn setTitle:@"选择其他方式付款" forState:UIControlStateNormal];
    [otherPayBtn addTarget:self action:@selector(otherPayClick:) forControlEvents:UIControlEventTouchUpInside];
    [otherPayBtn setTintColor:[UIColor blackColor]];
    [otherPayBtn.titleLabel setFont:[UIFont systemFontOfSize:ZOOM(42)]];
    otherPayBtn.layer.borderWidth = 1;
//    otherPayBtn.layer.cornerRadius = 5;
    [self.view addSubview:otherPayBtn];
    
    
    UIButton *backToPayBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backToPayBtn.frame = CGRectMake(30,  otherPayBtn.frame.origin.y+otherPayBtn.frame.size.height+20, kApplicationWidth-60, 40);
    [backToPayBtn setTitle:@"返回我的快捷支付" forState:UIControlStateNormal];
    [backToPayBtn addTarget:self action:@selector(backToPayClick:) forControlEvents:UIControlEventTouchUpInside];
    [backToPayBtn setTintColor:[UIColor blackColor]];
    [backToPayBtn.titleLabel setFont:[UIFont systemFontOfSize:ZOOM(42)]];
    backToPayBtn.layer.borderWidth = 1;
//    backToPayBtn.layer.cornerRadius = 5;
//    [self.view addSubview:backToPayBtn];

}
/**
 *  选择其他方式付款
 */
-(void)otherPayClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  返回我的快捷支付"
 */
-(void)backToPayClick:(UIButton *)sender
{
    
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
    for(UIViewController *vc in self.navigationController.viewControllers)
    {
        if([vc isKindOfClass:[ShopDetailViewController class]]){
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }else if ([vc isKindOfClass:[MyOrderViewController class]]){
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
        
    }
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
