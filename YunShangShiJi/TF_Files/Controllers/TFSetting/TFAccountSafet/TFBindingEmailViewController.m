//
//  TFBindingEmailViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/9/2.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBindingEmailViewController.h"
#import "TFAccountSafeViewController.h"


@interface TFBindingEmailViewController ()<UITextFieldDelegate>
{
    //计时器
    NSTimer *_timer;
    //计时
    int _count;

    UIButton *btn;
}

@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)UITextField *checkCodeField;
@end

@implementation TFBindingEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super setNavigationItemLeft:@"绑定邮箱"];
    
    _count = kWaitTime;
    
    [self createUI];
}

- (void)createUI
{
    CGFloat lr_Margin = ZOOM(62);
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(lr_Margin, kNavigationheightForIOS7+ZOOM(45), kScreenWidth-lr_Margin*2, ZOOM(114))];
    tf.borderStyle = UITextBorderStyleNone;
    tf.layer.borderWidth = 1;
    tf.layer.borderColor = [RGBCOLOR_I(220,220,220) CGColor];
    tf.layer.masksToBounds = YES;
    tf.layer.cornerRadius = 3;
    tf.placeholder = @"请输入您要绑定的邮箱号";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ZOOM(300), tf.frame.size.height)];
    label.font = [UIFont systemFontOfSize:ZOOM(48)];
    label.textColor = RGBCOLOR_I(34,34,34);
    label.text = [NSString stringWithFormat:@" 邮箱号码"];
    tf.leftView = label;
    tf.leftViewMode = UITextFieldViewModeAlways;

    self.textField = tf;
    [self.view addSubview:self.textField];
    
    self.checkCodeField = [[UITextField alloc] initWithFrame:CGRectMake(lr_Margin,  self.textField.bottom+ZOOM(67), ZOOM(580), tf.frame.size.height)];
    self.checkCodeField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.checkCodeField];
    self.checkCodeField.keyboardType = UIKeyboardTypeNumberPad;
    self.checkCodeField.delegate = self;
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ZOOM(180), self.checkCodeField.frame.size.height)];
    label2.text = @" 验证码";
    label2.font = [UIFont systemFontOfSize:ZOOM(48)];
    self.checkCodeField.leftView = label2;
    self.checkCodeField.leftViewMode = UITextFieldViewModeAlways;
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake( self.checkCodeField.right+ZOOM(29), self.checkCodeField.frame.origin.y, kScreenWidth-self.checkCodeField.frame.origin.x-self.checkCodeField.frame.size.width-lr_Margin-ZOOM(29), self.checkCodeField.frame.size.height);
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    btn.tag = 100;
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:ZOOM(48)];
    btn.layer.cornerRadius = ZOOM(15);
    btn.layer.masksToBounds = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = COLOR_ROSERED;
    [btn addTarget:self action:@selector(getVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(lr_Margin, _checkCodeField.frame.origin.y+_checkCodeField.frame.size.height+ZOOM(67), tf.bounds.size.width, ZOOM(120));
    sureBtn.backgroundColor=tarbarrossred;
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"退出账号框"] forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"退出账号框高亮"] forState:UIControlStateHighlighted];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.tintColor = [UIColor whiteColor];
    [self.view addSubview:sureBtn];
    
}
//获取 验证码按钮
- (void)getVerificationCode:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if ([self validateEmail:self.textField.text]) {
//        if (sender.selected == YES) {
            [self checkEmail];
//        }
    }
    
}
- (void)btnClick
{
    if ([self validateEmail:self.textField.text]&&_checkCodeField.text.length!=0&&![_checkCodeField.text isEqualToString:@""]) {
        //请求数据
        [self httpBinDingEmail];
    } else if(_checkCodeField.text.length==0||[_checkCodeField.text isEqualToString:@""]){
        
        [MBProgressHUD showError:@"请输入验证码"];
    }else
        [MBProgressHUD showError:@"请正确输入邮箱账号"];

}
-(void)checkEmail
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@user/checkEmail?version=%@&token=%@&email=%@",[NSObject baseURLStr],VERSION,token,self.textField.text];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //%@",responseObject);
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1&&[responseObject[@"bool"] intValue] != 1) {
                
                btn.backgroundColor = RGBACOLOR_F(0.5,0.5,0.5,0.6);
                btn.userInteractionEnabled = NO;
                if ([_timer isValid]) {
                    [_timer invalidate];
                }
                _count = kWaitTime;
                _timer = [NSTimer weakTimerWithTimeInterval:1.0f target:self selector:@selector(calTime) userInfo:nil repeats:YES];
                
                [self httpEmailRequest];
                
                
            } else if ([responseObject[@"status"] intValue] ==1 && [responseObject[@"bool"] intValue] == 1) {
                [MBProgressHUD showError:@"该邮箱已被绑定"];
            } else if ([responseObject[@"status"] intValue] !=1) {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
                
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络请求失败,请检查网络设置"];
    }];
}
/*****************   获取验证码后绑定邮箱   ****************/
-(void)httpBinDingEmail
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];

    NSString *urlStr = [NSString stringWithFormat:@"%@user/checkEmailCode?version=%@&token=%@&code=%@",[NSObject baseURLStr],VERSION,token,_checkCodeField.text];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //%@",responseObject);
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1) {
                
                [MBProgressHUD showSuccess:@"绑定邮箱成功!"];
                
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[TFAccountSafeViewController class]]) {
                        [self.navigationController popToViewController:controller animated:YES];
                    }
                }
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络请求失败,请检查网络设置"];
    }];
}
/*****************   获取验证码   ****************/
- (void)httpEmailRequest
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    /**
     http://183.61.166.16:8080/cloud-api/get_emailactivate_code?version=V1.0&email=41224%40163.com&authKey=1AF4B33C24C9AE1ADECD3327BCBA512B
     
     http://183.61.166.16:8080/cloud-api/get_emailactivate_code?version=V1.0&email=962442630@qq.com&authKey=9F630319A7E37EF260FDBCC6A5AE0292
     */
    NSString *urlStr = [NSString stringWithFormat:@"%@user/get_email_code?version=%@&email=%@&token=%@&codetype=7",[NSObject baseURLStr],VERSION,self.textField.text,token];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            //%@",responseObject);
            
            if ([responseObject[@"status"] intValue] == 1) {
                //            [MBProgressHUD showSuccess:responseObject[@"message"]];
                //            [self.navigationController popViewControllerAnimated:YES];
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络请求失败,请检查网络设置"];
    }];
    
}
#pragma mark - 计时函数
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
    }
}

//重写父类的方法
- (void)viewWillAppear:(BOOL)animated
{
    Myview.hidden = YES;

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
