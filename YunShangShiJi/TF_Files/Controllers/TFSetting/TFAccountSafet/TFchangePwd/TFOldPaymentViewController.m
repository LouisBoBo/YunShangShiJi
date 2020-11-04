//
//  TFOldPaymentViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/14.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFOldPaymentViewController.h"
#import "TFSetPaymentPasswordViewController.h"

//#define NUMBERS @"0123456789" 
#import "TFCodePhoneViewController.h"
@interface TFOldPaymentViewController () <UITextFieldDelegate>


@end

@implementation TFOldPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super setNavigationItemLeft:self.headTitle];
    
    [self createUI];
}

- (void)createUI
{
    CGFloat ud_Margin = ZOOM(50);
    CGFloat lr_Margin = ZOOM(62);
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(lr_Margin, kNavigationheightForIOS7, kScreenWidth-lr_Margin, lr_Margin)];
    self.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    self.titleLabel.textColor = RGBCOLOR_I(152,152,152);
    self.titleLabel.text = self.labelStr;
    [self.view addSubview:self.titleLabel];
    if (self.labelStr!=nil) {
        self.titleLabel.hidden = NO;
    } else {
        self.titleLabel.hidden = YES;
    }
    
    CGFloat textField_H = ZOOM(114);
    
    self.inputField = [[UITextField alloc] initWithFrame:CGRectMake(lr_Margin,  self.titleLabel.bottom+ud_Margin, kScreenWidth-2*lr_Margin, textField_H)];
    self.inputField.font = [UIFont systemFontOfSize:ZOOM(48)];
    self.inputField.placeholder = self.plaStr;
    if (self.index == 1) {
        [self.inputField setValue:[UIFont systemFontOfSize:ZOOM(48)] forKeyPath:@"_placeholderLabel.font"];
    }
    self.inputField.borderStyle = UITextBorderStyleRoundedRect;
    self.inputField.keyboardType = UIKeyboardTypeNumberPad;
    if (self.index == 0) { //原支付密码
        self.inputField.secureTextEntry = YES;
    }
    self.inputField.delegate = self;
    [self.view addSubview:self.inputField];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ZOOM(300), self.inputField.frame.size.height)];
    label.font = [UIFont systemFontOfSize:ZOOM(48)];
    label.textColor = RGBCOLOR_I(34,34,34);
    label.text = [NSString stringWithFormat:@"  %@",self.leftStr];
    self.inputField.leftView = label;
    self.inputField.leftViewMode = UITextFieldViewModeAlways;
    
    CGFloat btn_H = ZOOM(120);
    CGFloat ud_Margin1 = ZOOM(250);
    
    if (self.index == 0) {
        ud_Margin1 = ZOOM(150);
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

    btn.frame = CGRectMake(lr_Margin, self.inputField.frame.origin.y+self.inputField.frame.size.height+ud_Margin1, self.inputField.frame.size.width, btn_H);
    btn.tag = 100;
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框高亮"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

#pragma mark - 下一步
- (void)btnClick:(UIButton *)sender
{
    if (self.index == 0) {
        if (self.inputField.text.length == 6) {
            [self httpCheckPwd];
        } else {
            [MBProgressHUD showError:@"输入格式不正确"];
        }
    } else if (self.index == 1) {
        if ([self validateMobile:self.inputField.text]) {
            [self httpBindingPhone]; //绑定手机号
        } else {
            [MBProgressHUD showError:@"请输入正确的手机号"];
        }
    
    } else if (self.index == 2) {
        if ([self validateMobile:self.inputField.text]&&![self.oldPhone isEqualToString:self.inputField.text]) { //输入的是手机号
            [self httpCheckPhoneNumber];
        } else if (![self validateMobile:self.inputField.text]){
            [MBProgressHUD showError:@"请输入正确的手机号"];
        } else if ([self.oldPhone isEqualToString:self.inputField.text]){
            [MBProgressHUD showError:@"新的手机号需与旧手机号不同"];
        } else {
            [MBProgressHUD showError:@"输入有误"];
        }
    }
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.index == 0) {
        if (range.location>=6) {
            return NO;
        }
    } else if (self.index == 1||self.index == 2) {
        if (range.location>=11) {
            return NO;
        }
    }
    return YES;
}

- (void)httpBindingPhone
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *phone = self.inputField.text;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@user/checkPhone?version=%@&phone=%@&token=%@",[NSObject baseURLStr],VERSION,phone,token];
    
    NSString *URL = [MyMD5 authkey:urlStr];
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                if ([responseObject[@"bool"] boolValue] == NO) {
                    TFCodePhoneViewController *tcvc = [[TFCodePhoneViewController alloc] init];
                    tcvc.headTitle = @"绑定手机";
                    tcvc.index = 1;
                    //                tcvc.labelStr = @"验证码";
                    tcvc.phone = self.inputField.text;
                    [self.navigationController pushViewController:tcvc animated:YES];
                } else {
                    [MBProgressHUD showError:@"该手机号已被绑定"];
                }
            } else {

                if ([responseObject[@"status"] intValue] == 50) {
                    //正确
                    TFSetPaymentPasswordViewController *tovc = [[TFSetPaymentPasswordViewController alloc] init];
                    tovc.index = 0;
                    [self.navigationController pushViewController:tovc animated:YES];
                } else {
                    [MBProgressHUD showError:responseObject[@"message"]];
                }
            }

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
}

- (void)httpCheckPhoneNumber
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *phone = self.inputField.text;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@user/checkPhone?version=%@&phone=%@&token=%@",[NSObject baseURLStr],VERSION,phone,token];
    
    NSString *URL = [MyMD5 authkey:urlStr];
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                if ([responseObject[@"bool"] boolValue] == NO) {
                    TFCodePhoneViewController *tcvc = [[TFCodePhoneViewController alloc] init];
                    tcvc.headTitle = @"更换绑定手机";
                    tcvc.index = 2;
                    tcvc.labelStr = @"请输入收到的短信验证码";
                    tcvc.phone = self.inputField.text;
                    [self.navigationController pushViewController:tcvc animated:YES];
                } else {
                    [MBProgressHUD showError:@"该手机号已被绑定"];
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


- (void)httpCheckPwd
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *oldMD5 = [MyMD5 md5:self.inputField.text];
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/ckPwd?pwd=%@&token=%@&version=%@",[NSObject baseURLStr],oldMD5,token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            /*
            if ([responseObject[@"pwdflag"] intValue] == 0) {
                //正确
                TFSetPaymentPasswordViewController *tovc = [[TFSetPaymentPasswordViewController alloc] init];
                tovc.index = 1;
                tovc.oldPwd = self.inputField.text;
                [self.navigationController pushViewController:tovc animated:YES];
                
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
             */
            
            if ([responseObject[@"status"] intValue] == 1) {
                //正确
                TFSetPaymentPasswordViewController *tovc = [[TFSetPaymentPasswordViewController alloc] init];
                tovc.index = 1;
                tovc.oldPwd = self.inputField.text;
                [self.navigationController pushViewController:tovc animated:YES];
                
            } else if ([responseObject[@"status"] intValue] == 2){
                [MBProgressHUD showError:responseObject[@"message"]];
            } else if ([responseObject[@"status"] intValue] == 3){
                [MBProgressHUD showError:@"错误次数已达上限"];
            }

        }
        
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
         
         NavgationbarView *mentionview=[[NavgationbarView alloc]init];
         [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
    
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
