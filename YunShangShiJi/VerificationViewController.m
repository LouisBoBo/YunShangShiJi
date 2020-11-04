//
//  VerificationViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/10.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//  **********目前没有用到弃用************

#import "VerificationViewController.h"
#import "NewPasswordViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "GlobalTool.h"
#import "MyMD5.h"
#import "FindPasswordViewController.h"
#import "NavgationbarView.h"
@interface VerificationViewController ()

@end

@implementation VerificationViewController
{
    //验证码输入框
    UITextField *_codefild;
    //验证码按钮
    UILabel *_yanzhengBtn;
    //code
    NSString *_code;
    //验证码
    NSString *_verifyCode;
    
    NSTimer * _deadTimer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
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
    titlelable.frame=CGRectMake(0, 0, 120, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"输入验证码";
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
   
    [self creatView];

    [self getclick];
    
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
    UIImageView *passView=[[UIImageView alloc]initWithFrame:CGRectMake(30, 100, kApplicationWidth-180, 40)];
    passView.image=[UIImage imageNamed:@""];
    _codefild=[[UITextField alloc]initWithFrame:CGRectMake(20, passView.frame.origin.y, 180, 35)];
    _codefild.borderStyle = UITextBorderStyleRoundedRect;
    _codefild.keyboardType = UIKeyboardTypeNumberPad;
    [_codefild becomeFirstResponder];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, _codefild.frame.size.height)];
    label.text = @"  验证码";
    label.font = [UIFont systemFontOfSize:16];
    _codefild.leftView = label;
    _codefild.leftViewMode = UITextFieldViewModeAlways;
    
    _codefild.delegate=self;
    
    passView.userInteractionEnabled=YES;

    _yanzhengBtn = [[UILabel alloc]init];

    //验证码
    _yanzhengBtn.frame=CGRectMake(210, passView.frame.origin.y, kScreenWidth-_codefild.frame.size.width - _codefild.frame.origin.x - 30, _codefild.frame.size.height);
    _yanzhengBtn.backgroundColor=[UIColor colorWithRed:255/255.f green:63/255.f blue:139/255.f alpha:1];
    _yanzhengBtn.layer.cornerRadius=3.5;
    _yanzhengBtn.layer.masksToBounds=YES;
    
    _yanzhengBtn.text = @"获取验证码";
    _yanzhengBtn.textAlignment = NSTextAlignmentCenter;
    _yanzhengBtn.textColor=[UIColor whiteColor];
    _yanzhengBtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getclick)];
    [_yanzhengBtn addGestureRecognizer:tap];
    //获取验证码
    UIButton *loginbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginbtn.frame=CGRectMake(20, _yanzhengBtn.frame.origin.y+_yanzhengBtn.frame.size.height+40, kApplicationWidth-40, 40);
    [loginbtn setBackgroundColor:[UIColor blackColor]];
    
    [loginbtn setTitle:@"下一步" forState:UIControlStateNormal];
    loginbtn.titleLabel.font=kTitleFontSize;
    loginbtn.tintColor=[UIColor whiteColor];
    [loginbtn addTarget:self action:@selector(putclick:) forControlEvents:UIControlEventTouchUpInside];

    //提示
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(30, loginbtn.frame.origin.y+loginbtn.frame.size.height+10, 120, 20)];
    lable.text=@"验证码2分钟内有效";
    lable.textColor=[UIColor grayColor];
    lable.font=kStatementFontSize;
    [self.view addSubview:lable];
    
    [self.view addSubview:passView];
    [self.view addSubview:_codefild];
    [self.view addSubview:_yanzhengBtn];
    [self.view addSubview:loginbtn];
    
    
}
#pragma mark 获取验证码
-(void)getclick
{
    //获取");
    
    [self httpGetCode];
}
#pragma mark 网络请求获取验证码
- (void)httpGetCode
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    // 1.创建网络请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *phoneorEmail=[NSString stringWithFormat:@"%@",self.phoneAndemail];
    NSString *codeurl;
    if(self.isPhone)
    {
        codeurl=[NSString stringWithFormat:@"%@user/get_phone_code?version=%@&phone=%@&codetype=2&token=%@&vcode=%@",[NSObject baseURLStr],VERSION,phoneorEmail,token,self.vcode];
    }
    if(self.isEmail)
    {
        codeurl=[NSString stringWithFormat:@"%@user/get_email_code?version=%@&email=%@&codetype=2",[NSObject baseURLStr],VERSION,phoneorEmail];
    }
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    NSString *Posturl=[MyMD5 authkey:codeurl];
    //Posturl %@",Posturl);
    
    [MBProgressHUD showMessage:@"正在获取验证码" afterDeleay:0 WithView:self.view];
    [manager POST:Posturl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *str = responseObject[@"status"];
            
            _verifyCode = [NSString stringWithFormat:@"%@",responseObject[@"verify_code"]];
            // 输入错误
            if ( str.intValue == 2) {
                //%@", responseObject[@"message"]);
                NSString *originerrorStr = responseObject[@"message"];
                
                //            NSString *errorStr = [NSString string];
                //
                //            if ([originerrorStr isEqualToString:@"请填写正确的手机号."]) {
                //
                //                errorStr = @"对不起,请输入正确的手机号码";
                //
                //            }
                //            if ([originerrorStr isEqualToString:@"该手机号已被注册."]) {
                //
                //                errorStr = @"对不起，此手机号已经注册过了";
                //            }
                //            if ([originerrorStr isEqualToString:@"注册帐号出错，请重新注册."]) {
                //
                //                errorStr = @"生成验证码失败, 有可能是网络原因";
                //            }
                //            if ([originerrorStr isEqualToString:@"发送过于频繁请稍后再发."]) {
                //
                //                errorStr = @"对不起，此号码验证码创建频繁，请稍后再试";
                //
                //            }
                //
                //            if ([originerrorStr isEqualToString:@"您当天可以发送的短信次数超过."]) {
                //
                //                errorStr = @"对不起，今天发送的信息次数过多，请稍后再试";
                //
                //            }
                //            if ([originerrorStr isEqualToString:@"发送注册码出错."]) {
                //
                //                errorStr = @"对不起，生成验证码失败，请稍后再试";
                //
                //            }
                //
                //            if ([originerrorStr isEqualToString:@"验证码类型有误."]) {
                //
                //                errorStr = @"对不起，生成验证码失败，请稍后再试";
                //
                //            }
                
                [MBProgressHUD hideHUDForView:self.view];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:originerrorStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alertView show];
                
            }  else {
                
                // 输入正确
                // 字典装模型
                NSString *correStr = responseObject[@"message"];
                //%@", correStr);
                
                [MBProgressHUD hideHUDForView:self.view];
                _code =_codefild.text;
                
                if ([self.countDownTimer isValid]) {
                    [self.countDownTimer invalidate];
                }
                
                NSTimer * countDownTimer = [NSTimer weakTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethord) userInfo:nil repeats:YES];
                
                self.countDownTimer = countDownTimer;
                self.secondsCountDown = 120;
                
                
            }

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //aaaaaa==%@", error.localizedDescription);
        [MBProgressHUD hideHUDForView:self.view];
    }];
    
    
    
}
#pragma mark 验证码倒计时
- (void)timerFireMethord
{
    
    self.secondsCountDown --;
    NSString *correStr = [NSString stringWithFormat:@"已发送验证码短信到%@，请注意查收", _codefild.text];
    
    _yanzhengBtn.backgroundColor = kBackgroundColor;
//    [_yanzhengBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_yanzhengBtn setEnabled:NO];
//    [_yanzhengBtn setTitle:[NSString stringWithFormat:@"%d秒", self.secondsCountDown] forState:UIControlStateNormal];
    _yanzhengBtn.userInteractionEnabled=NO;
    _yanzhengBtn.text=[NSString stringWithFormat:@"%ds后重新获取", self.secondsCountDown];
    
    if (self.secondsCountDown == 0) {
        self.secondsCountDown = 120;
//        [_yanzhengBtn setEnabled:YES];
        _yanzhengBtn.userInteractionEnabled=YES;
//        [_yanzhengBtn setTitle:@"点击重发" forState:UIControlStateNormal];
        
        _yanzhengBtn.backgroundColor=[UIColor colorWithRed:255/255.f green:63/255.f blue:139/255.f alpha:1];
        
//        [_yanzhengBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_yanzhengBtn setText:@"点击重发"];
        [self.countDownTimer invalidate];
        
    }
    
}





#pragma mark 提交
-(void)putclick:(UIButton*)sender
{
    if(_codefild.text.length<1)
    {
//        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"验证码输入不能为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//        [alter show];
        
        NavgationbarView *bar = [[NavgationbarView alloc] init];
        [bar showLable:@"验证码输入不能为空" Controller:self];
        
        return;
    }
    
    
    
    
    //提交");
    //%@-------%@",_codefild.text,_verifyCode);
    
//    if(![_codefild.text isEqualToString:_verifyCode])
//    {
//        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"验证码输入不正确，请重新输入" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alter show];  
//        return;
//        
//    }
    
        //获取验证码有效期及页面跳转
        [self GetCodeAvalueTime];
    
    
    
}

#pragma mark - 获取验证码有效期
- (void)GetCodeAvalueTime
{
    
    // 1.创建网络请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *phoneorEmail=[NSString stringWithFormat:@"%@",self.phoneAndemail];
    NSString *submiturl;
    
     NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    //http://{ip:port}/{proeject}/user/checkAuthCode?version=V1.0&phone=
    //http://{ip:port}/{proeject}/user/checkEmailAuthCode
    if(self.isPhone)
    {
        submiturl=[NSString stringWithFormat:@"%@user/checkAuthCode?version=%@&code=%@&phone=%@",[NSObject baseURLStr],VERSION,_codefild.text,phoneorEmail];
        
    }
    if(self.isEmail)
    {
        submiturl=[NSString stringWithFormat:@"%@user/checkEmailAuthCode?version=%@&email=%@&code=%@&codetype=2",[NSObject baseURLStr],VERSION,phoneorEmail,_codefild.text];
    }
    
    NSString *Posturl=[MyMD5 authkey:submiturl];
    //%@",Posturl);
    [MBProgressHUD showHUDAddTo:self.view  animated:YES];
    [manager POST:Posturl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            //%@",responseObject[@"message"]);
            //%@",responseObject);
//            NSDictionary *response = (NSDictionary *)responseObject;
            if ([responseObject[@"status"] isEqualToString:@"1"]) {
                //界面跳转
                NewPasswordViewController *newword=[[NewPasswordViewController alloc]init];
                newword.code=_codefild.text;
                newword.phoneAndEmail=self.phoneAndemail;
                [self.navigationController pushViewController:newword animated:YES];
            }
            else
            {
//                NavgationbarView *bar = [[NavgationbarView alloc] init];
//                [bar showLable:response[@"message"] Controller:self];
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //failure");
         [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
}

-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark -输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location>=4) {
        return NO;
    } else {
        return YES;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
