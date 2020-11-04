//
//  TFCodePhoneViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/14.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//  *************目前没有用到弃用**************

#import "TFCodePhoneViewController.h"
#import "TFCashSuccessViewController.h"
#import "TFSecurityVerificationViewController.h"
#import "TFSetPaymentPasswordViewController.h"
#import "TFAccountSafeViewController.h"

#import "LoginViewController.h"

@interface TFCodePhoneViewController () <UITextFieldDelegate>
{
    //计时器
    NSTimer *_timer;
    //计时
    int _count;

    UITextField *phoneCodeNum;
}
@property (nonatomic, strong)UIView *webCodeView;
@property (nonatomic ,strong)UITextField *checkCodeField;
@property (nonatomic ,strong)UILabel *titleLabel;

@end

@implementation TFCodePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super setNavigationItemLeft:self.headTitle];

    [self createUI];

}

- (void)createUI
{
    
    if (self.index == 2) {
        //
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"关闭" forState:UIControlStateNormal];
        btn.frame = CGRectMake(kScreenWidth-80, 20, 80, 44);
        btn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];;
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(caBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    _count = kWaitTime;
    
    CGFloat lr_Margin = ZOOM(62);
    CGFloat ud_Margin = ZOOM(50);
    
    CGFloat textField_H = ZOOM(114);
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(lr_Margin, kNavigationheightForIOS7, kScreenWidth-lr_Margin, lr_Margin)];
    self.titleLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
    self.titleLabel.textColor = RGBCOLOR_I(152,152,152);
    self.titleLabel.text = self.labelStr;
    [self.view addSubview:self.titleLabel];
    if (self.labelStr!=nil) {
        self.titleLabel.hidden = NO;
    } else {
        self.titleLabel.hidden = YES;
    }
  
    self.checkCodeField = [[UITextField alloc] initWithFrame:CGRectMake(lr_Margin,  self.titleLabel.bottom+ud_Margin, ZOOM(580), textField_H)];
    self.checkCodeField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.checkCodeField];
    self.checkCodeField.keyboardType = UIKeyboardTypeNumberPad;
    self.checkCodeField.delegate = self;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ZOOM(180), self.checkCodeField.frame.size.height)];
    label.text = @"  验证码";
    label.font = [UIFont systemFontOfSize:ZOOM(48)];
    self.checkCodeField.leftView = label;
    self.checkCodeField.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake( self.checkCodeField.right+ZOOM(29), self.checkCodeField.frame.origin.y, kScreenWidth-self.checkCodeField.frame.origin.x-self.checkCodeField.frame.size.width-lr_Margin-ZOOM(29), textField_H);
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    btn.tag = 100;
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:ZOOM(48)];
    btn.layer.cornerRadius = ZOOM(15);
    btn.layer.masksToBounds = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = COLOR_ROSERED;
    [btn addTarget:self action:@selector(getVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    CGFloat btn_H = ZOOM(120);
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(lr_Margin,  btn.bottom+btn_H, kScreenWidth-2*lr_Margin, btn_H);
    btn2.tag = 100;
    [btn2 setTitle:@"下一步" forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"退出账号框"] forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"退出账号框高亮"] forState:UIControlStateHighlighted];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];

    if (_index == 0) { //手机验证  更换支付密码界面

        phoneCodeNum = [[UITextField alloc] initWithFrame:CGRectMake(lr_Margin,  self.titleLabel.bottom+ud_Margin, ZOOM(580), textField_H)];
        phoneCodeNum.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:phoneCodeNum];
//        phoneCodeNum.keyboardType = UIKeyboardTypeNumberPad;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ZOOM(300), self.checkCodeField.frame.size.height)];
        label.text = @"  图片验证码";
        label.font = [UIFont systemFontOfSize:ZOOM(48)];
        phoneCodeNum.leftView = label;
        phoneCodeNum.leftViewMode = UITextFieldViewModeAlways;
        [self.view addSubview:phoneCodeNum];

        self.webCodeView = [[UIView alloc]initWithFrame:CGRectMake( phoneCodeNum.right+ZOOM(29), phoneCodeNum.frame.origin.y, kScreenWidth-phoneCodeNum.frame.origin.x-phoneCodeNum.frame.size.width-lr_Margin-ZOOM(29), textField_H)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(httpGetCodeView)];
        [self.webCodeView addGestureRecognizer:tap];
        [self.view addSubview:self.webCodeView];


        self.checkCodeField.y = phoneCodeNum.bottom+ud_Margin;
        btn.y =  self.checkCodeField.frame.origin.y;
        btn2.y = btn.bottom+btn_H;

         [self httpGetCodeView];
    }
}

- (void)httpGetCodeView {

    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];

    NSString *IMEI = [[NSUserDefaults standardUserDefaults] objectForKey:USER_UUID];
    NSString *url = [NSString stringWithFormat:@"%@vcode/getVcodePwd?version=%@&token=%@&imei=%@",[NSObject baseURLStr],VERSION,token,IMEI];
    NSString *URL=[MyMD5 authkey:url];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    request.timeoutInterval = 3;
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];

    if ([response.MIMEType containsString:@"image"]) {
        for (UIView *view in self.webCodeView.subviews) {
            [view removeFromSuperview];
        }
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ZOOM6(250), ZOOM6(60))];
        [webView setScalesPageToFit: YES];
        [webView setBackgroundColor:[UIColor clearColor]];
        [webView setOpaque: 0];
        [self.webCodeView addSubview:webView];
        [webView loadData:data MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL URLWithString:@""]];
        [webView setUserInteractionEnabled:NO];
    }else if ([response.MIMEType containsString:@"text"]) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [MBProgressHUD show:responseObject[@"message"] icon:nil view:self.view];
    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location>=4) {
        return NO;
    } else {
        return YES;
    }
}


- (void)btnClick:(UIButton *)sender
{
    
    [self.view endEditing:YES];
    
    if (self.checkCodeField.text.length ==4) {
        if (self.index == 0) { //更换支付密码
            [self httpChecKCode];
        } else if (self.index == 2) { //更换绑定手机
        
            [self httpChecKNewPhoneCode]; //检查验证码
//            [self httpIsSetPwd];
        
        } else if (self.index == 1) { //绑定手机
            [self httpbindingChecKCode];
        }
    }
}
//获取 验证码按钮
- (void)getVerificationCode:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        sender.backgroundColor = RGBACOLOR_F(0.5,0.5,0.5,0.6);
        sender.userInteractionEnabled = NO;
        if (self.index == 0) { // 获取更换支付密码的验证码
            //通过服务器获取验证码
            [self httpGetVerificationCode];
        } else if (self.index == 2) { //获取更换手机号时的验证码
            [self httpGetNewPhoneCode];
        } else if (self.index == 1) { //获取新绑定手机号时的验证码
            [self httpGetBindingPhoneCode];
        }
    }
}
//新绑定手机号获取验证码-7
- (void)httpGetBindingPhoneCode
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    UIButton *sender = (UIButton *)[self.view viewWithTag:100];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"%@user/get_phone_code?version=%@&phone=%@&codetype=%@&token=%@",[NSObject baseURLStr],VERSION,self.phone,@"7",token];
    NSString *URL = [MyMD5 authkey:urlStr];
    //
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1) {
                sender.userInteractionEnabled = NO;
                if ([_timer isValid]) {
                    [_timer invalidate];
                }
                _timer = [NSTimer weakTimerWithTimeInterval:1.0f target:self selector:@selector(calTime) userInfo:nil repeats:YES];
            } else {
                [MBProgressHUD showSuccess:responseObject[@"message"]];
                sender.selected = NO;
            }

            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        sender.userInteractionEnabled = YES;
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
}


- (void)httpbindingChecKCode
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *code = self.checkCodeField.text;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@user/checkCode?version=%@&token=%@&code=%@",[NSObject baseURLStr],VERSION,token,code];
    
    NSString *URL = [MyMD5 authkey:urlStr];
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                //弹出验证支付密码页面
//                TFSecurityVerificationViewController *tsvc = [[TFSecurityVerificationViewController alloc] init];
//                tsvc.leftStr = @"支付密码";
//                tsvc.headTitle = @"安全验证";
//                tsvc.plaStr = @"只能是6位数字哦";
//                tsvc.index = 1;
//                [self.navigationController pushViewController:tsvc animated:YES];
                
                [MBProgressHUD showSuccess:responseObject[@"message"]];
                
//                NavgationbarView *nv = [[NavgationbarView alloc] init];
//                [nv showLable:responseObject[@"message"] Controller:self];
                
                NSNotification *notification=[NSNotification notificationWithName:@"isOneBuy" object:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            
                [self performSelector:@selector(goToAffirmOrderView) withObject:nil afterDelay:1];
                
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
          
          NavgationbarView *mentionview=[[NavgationbarView alloc]init];
          [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
}

- (void)goToAffirmOrderView
{
//    BOOL bl = NO;
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[LoginViewController class]]) {
//            [MBProgressHUD hideHUDForView:self.view];
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }
    }
    
    //完成绑定
    TFCashSuccessViewController *tavc = [[TFCashSuccessViewController alloc] init];
    tavc.index = VCType_BindPhoneSuccess;
    [self.navigationController pushViewController:tavc animated:YES];
}


// 关闭
- (void)caBtnClick
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[TFAccountSafeViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}

// 原手机号获取验证码-8
- (void)httpGetNewPhoneCode
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    UIButton *sender = (UIButton *)[self.view viewWithTag:100];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"%@user/get_phone_code?version=%@&phone=%@&codetype=%@&token=%@",[NSObject baseURLStr],VERSION,self.phone,@"8",token];
    NSString *URL = [MyMD5 authkey:urlStr];
    //
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                //按钮不能够点击,开始计时
                sender.userInteractionEnabled = NO;
                if ([_timer isValid]) {
                    [_timer invalidate];
                }
                _timer = [NSTimer weakTimerWithTimeInterval:1.0f target:self selector:@selector(calTime) userInfo:nil repeats:YES];
            } else {
                [MBProgressHUD showSuccess:responseObject[@"message"]];
                sender.selected = NO;
            }

        }
        
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        sender.userInteractionEnabled = YES;
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
         
         NavgationbarView *mentionview=[[NavgationbarView alloc]init];
         [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
}

// 检查 绑定手机 验证码是否正确
- (void)httpChecKNewPhoneCode
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *code = self.checkCodeField.text;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@user/checkCode?version=%@&token=%@&code=%@",[NSObject baseURLStr],VERSION,token,code];
    
    NSString *URL = [MyMD5 authkey:urlStr];
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                //进入下一页
//                TFSecurityVerificationViewController *tsvc = [[TFSecurityVerificationViewController alloc] init];
//                tsvc.leftStr = @"支付密码";
//                tsvc.headTitle = @"安全验证";
//                tsvc.plaStr = @"只能是6位数字哦";
//                tsvc.index = 2;
//                [self.navigationController pushViewController:tsvc animated:YES];
                
                //完成绑定
                TFCashSuccessViewController *tavc = [[TFCashSuccessViewController alloc] init];
                tavc.index = VCType_ChangeBindPhone;
                [self.navigationController pushViewController:tavc animated:YES];
                
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
           
           NavgationbarView *mentionview=[[NavgationbarView alloc]init];
           [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
}
//检查是否设置过支付密码
- (void)httpIsSetPwd
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/ckSetPwd?token=%@&version=%@",[NSObject baseURLStr],token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) { //设置过密码了
                
                if ([responseObject[@"flag"] intValue] == 1) { //没设置
                    //进入设置支付密码页面
                    TFSetPaymentPasswordViewController *tsvc= [[TFSetPaymentPasswordViewController alloc] init];
                    [self.navigationController pushViewController:tsvc animated:YES];
                } else if ([responseObject[@"flag"] intValue] == 2) { //设置过了
                    
                    
                    
                
                }
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
          
          NavgationbarView *mentionview=[[NavgationbarView alloc]init];
          [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
}

// 检查 修改支付 验证码是否正确
- (void)httpChecKCode
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *code = self.checkCodeField.text;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/ckPhoneCode?token=%@&version=%@&code=%@",[NSObject baseURLStr],token,VERSION,code];
    
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MyLog(@"%@",responseObject);
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                //进入下一页
                TFSetPaymentPasswordViewController *tsvc=  [[TFSetPaymentPasswordViewController alloc] init];
                tsvc.index = 2;
                tsvc.checkCode = self.checkCodeField.text;
                [self.navigationController pushViewController:tsvc animated:YES];
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
  
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
}

// 网络获取验证码
- (void)httpGetVerificationCode
{
    UIButton *sender = (UIButton *)[self.view viewWithTag:100];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/get_phone_code?version=%@&token=%@&vcode=%@",[NSObject baseURLStr],VERSION,token,phoneCodeNum.text];
    
    NSString *URL = [MyMD5 authkey:urlStr];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        responseObject = [NSDictionary changeType:responseObject];
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        MyLog(@"%@",responseObject);
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                //按钮不能够点击,开始计时
                sender.userInteractionEnabled = NO;
                if ([_timer isValid]) {
                    [_timer invalidate];
                }
                _timer = [NSTimer weakTimerWithTimeInterval:1.0f target:self selector:@selector(calTime) userInfo:nil repeats:YES];
            } else {
//                [MBProgressHUD showSuccess:responseObject[@"message"]];
                sender.userInteractionEnabled = YES;
                sender.selected = YES;
                sender.backgroundColor = COLOR_ROSERED;

                [nv showLable:responseObject[@"message"] Controller:self];
                sender.selected = NO;
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        sender.userInteractionEnabled = YES;
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
    
}
- (void)calTime
{
    UIButton *sender = (UIButton *)[self.view viewWithTag:100];
    _count--;
    sender.backgroundColor = RGBACOLOR_F(0.5,0.5,0.5,0.4);
    sender.userInteractionEnabled = NO;
    [sender setTitle:[NSString stringWithFormat:@"%d秒",_count] forState:UIControlStateNormal];
    if (_count == 0) {
        _count = kWaitTime;
        sender.userInteractionEnabled = YES;
        sender.backgroundColor = COLOR_ROSERED;
        [sender setTitle:@"点击重发" forState:UIControlStateNormal];
        sender.selected = NO;
        [_timer invalidate];

        [self httpGetCodeView];
        phoneCodeNum.text = nil;
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
