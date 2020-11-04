//
//  PaypasswordViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/5/25.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "PaypasswordViewController.h"

#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "NavgationbarView.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "LoginViewController.h"
#import "MyMD5.h"
#import "Tools.h"
@interface PaypasswordViewController ()

@end

@implementation PaypasswordViewController

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
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"支付密码";
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];

    [self Creatview];
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

-(void)Creatview
{
    self.Loginpwdfild.placeholder=@"请输入登录密码";
    self.pwdfild.placeholder=@"请输入密码";
    self.affirmfild.placeholder=@"再次输入密码";
    
    [self.submitbtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark 提交密码设置
-(void)submit:(UIButton*)sender
{
    // 判读密码
    
    if ([self.Loginpwdfild.text length]<1 )//输入登录密码
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"密码输入不能为空,请重新设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    
    if ([self.pwdfild.text length]<1 )//输入密码
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"密码输入不能为空,请重新设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if ([self.pwdfild.text length]>0 && [self.pwdfild.text length]<6)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"密码长度不能小于六位,请重新设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if ([self.pwdfild.text length]>10)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"密码长度过长,请重新设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if ([[Tools share] stringContainsEmoji:self.pwdfild.text])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"密码暂不支持表情字符" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if ([self.affirmfild.text length]<1 )//确认密码
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"密码输入不能为空,请重新设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    NSString *str1=[NSString stringWithFormat:@"%@",self.pwdfild.text];
    NSString *str2=[NSString stringWithFormat:@"%@",self.affirmfild.text];
    
    if(![str1 isEqualToString:str2])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"两次输入的密码不相同" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }

    //发送网络请求
    [self requestHttp];

}

#pragma mark发送网络请求
-(void)requestHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSString *Password=[MyMD5 md5:self.affirmfild.text];
    NSString* url=[NSString stringWithFormat:@"%@wallet/setWalletPwd?version=%@&token=%@&payment_pwd=%@",[NSObject baseURLStr],VERSION,token,Password];
    
    NSString *URL=[MyMD5 authkey:url];
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                
            }
            else if(statu.intValue == 10030){//没登录状态
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                LoginViewController *login=[[LoginViewController alloc]init];
                
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }
            
            else{
                
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }
        
      

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];
    


}


-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
