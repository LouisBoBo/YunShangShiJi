//
//  ExchangeCodeViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/10/16.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "ExchangeCodeViewController.h"
#import "ExchangeInvitViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "NavgationbarView.h"
#import "LoginViewController.h"
@interface ExchangeCodeViewController ()
{
    UITextField *_textfild;
}
@end

@implementation ExchangeCodeViewController

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
    titlelable.text=@"兑换邀请码";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    [self creatView];

}
- (void)creatView
{
    
    self.titlelable.font = [UIFont systemFontOfSize:ZOOM(48)];
    
    self.textView.layer.borderWidth=1;
    self.textView.layer.cornerRadius=3;
    self.textView.layer.borderColor = kBackgroundColor.CGColor;
    
    _textfild = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, self.textView.frame.size.width-20, 30)];
    _textfild.placeholder = @"邀请码";
    _textfild.backgroundColor = [UIColor clearColor];
    [self.textView addSubview:_textfild];
    
    self.exchangebtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(57)];
    
}

- (void)exchangeHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    
    NSString *token = [user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@inviteCode/inviteCodeGetCoupon?version=%@&token=%@&inviteCode=%@",[NSObject baseURLStr],VERSION,token,_textfild.text];
    
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            NSString *message = responseObject[@"message"];
            
            if(str.intValue==1)
            {
                
                
                ExchangeInvitViewController * exchange = [[ExchangeInvitViewController alloc]init];
                exchange.changestatue=@"success";
                [self.navigationController pushViewController:exchange animated:YES];
                
            }
            else if(str.intValue == 10030){//没登录状态
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                
                LoginViewController *login=[[LoginViewController alloc]init];
                
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }

            else{
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
                
                ExchangeInvitViewController * exchange = [[ExchangeInvitViewController alloc]init];
                exchange.changestatue=@"fail";
                [self.navigationController pushViewController:exchange animated:YES];
                
                
            }

        }
        
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        
    }];
    
}


-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (IBAction)exchangbtn:(id)sender {
    
    if(_textfild.text.length >1)
    {
        [self exchangeHttp];
    }
    else{
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"验证码不能为空" Controller:self];
    }
    
    
    
}
@end
