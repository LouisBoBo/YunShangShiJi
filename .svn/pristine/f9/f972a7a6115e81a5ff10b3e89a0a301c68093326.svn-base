//
//  TFSetPaymentPasswordViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/7.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFSetPaymentPasswordViewController.h"
#import "TFAccountSafeViewController.h"
#import "TFMyWalletViewController.h"
//#import "PaystyleViewController.h"
#import "TFPayStyleViewController.h"
#import "MyOrderViewController.h"
#import "NavgationbarView.h"
#define NUMBERS @"0123456789"

@interface TFSetPaymentPasswordViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)UILabel *naviLabel;

@end

@implementation TFSetPaymentPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.index == 0) {
        [super setNavigationItemLeft:@"设置支付密码"];
    } else if (self.index == 1) {
        [super setNavigationItemLeft:@"支付密码"];
    } else if (self.index == 2) {
        [super setNavigationItemLeft:@"手机验证"];
    }
    // Do any additional setup after loading the view.
    [self createUI];
}
#pragma mark - 创建UI
- (void)createUI
{
    NSArray *titleArr = [NSArray arrayWithObjects:@{@"tit":@"支付密码",@"pla":@"6位数字支付密码"},@{@"tit":@"确认密码",@"pla":@"再次输入支付密码"},@"保存", nil];
    
    CGFloat lr_Margin = ZOOM(62);
    
    CGFloat udbtn_Margin = ZOOM(120);
    CGFloat textField_H = ZOOM(114);
    
    for (int i = 0; i<titleArr.count; i++) {
        if (i!=2) {
            UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(lr_Margin, kNavigationheightForIOS7+ZOOM(20)+i*textField_H+i*lr_Margin, kScreenWidth-lr_Margin*2, textField_H)];
            tf.borderStyle = UITextBorderStyleRoundedRect;
            tf.placeholder = [titleArr[i] objectForKey:@"pla"];
            tf.font = [UIFont systemFontOfSize:ZOOM(48)];
            tf.keyboardType = UIKeyboardTypeNumberPad;
            tf.secureTextEntry = YES;
            tf.delegate = self;
            tf.tag = 200+i;
//            if (i!=2) {
//                tf.returnKeyType = UIReturnKeyNext;
//            } else {
//                tf.returnKeyType = UIReturnKeyDone;
//            }
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ZOOM(300), tf.frame.size.height)];
            label.font = [UIFont systemFontOfSize:ZOOM(48)];
            label.text = [NSString stringWithFormat:@"  %@",[titleArr[i] objectForKey:@"tit"]];
            tf.leftView = label;
            tf.leftViewMode = UITextFieldViewModeAlways;
            [self.view addSubview:tf];
        } else {
            
            UITextField *t = (UITextField *)[self.view viewWithTag:200+i-1];
            CGFloat btn_H = ZOOM(120);
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

            btn.frame = CGRectMake(lr_Margin,  t.bottom+udbtn_Margin, kScreenWidth-lr_Margin*2, btn_H);
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
            [btn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框高亮"] forState:UIControlStateHighlighted];
            [self.view addSubview:btn];
        }
    }
}
- (void)saveBtnClick:(UIButton *)sender
{
    UITextField *tf1 = (UITextField *)[self.view viewWithTag:200];
    UITextField *tf2 = (UITextField *)[self.view viewWithTag:201];
    
    //tf1 = %@, tf2 = %@", tf1.text, tf2.text);
    
    if ((tf1.text.length == 6)&&(tf2.text.length == 6)&&([tf1.text isEqualToString:tf2.text])) {
        BOOL bl = [self isString:tf1.text toCompString:NUMBERS];
        if (bl) {
            if (self.index == 0) {           //设置支付密码
                [self httpSetPassword];
            } else if (self.index == 1) {    //通过原支付密码修改支付密码
                [self httpChangePwd];
            } else if (self.index == 2){     //通过验证码修改支付密码
                [self httpCodeChangePwd];
            }
        } else {
            [MBProgressHUD showError:@"支付密码为数字"];
        }
    } else if ((tf1.text.length == 0)||(tf2.text.length == 0)) {
        [MBProgressHUD showError:@"请输入修改的支付密码"];
    } else if ((tf1.text.length != 6)||(tf2.text.length != 6)) {
        [MBProgressHUD showError:@"支付密码只能是6位数字哦"];
    } else if ((tf1.text.length == 6)&&(tf2.text.length == 6)&&(![tf1.text isEqualToString:tf2.text])) {
        [MBProgressHUD showError:@"两次输入不一致"];
    } else {
        [MBProgressHUD showError:@"格式不正确"];
    }
}

- (void)httpCodeChangePwd
{
    
    UITextField *tf1 = (UITextField *)[self.view viewWithTag:200];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *code = self.checkCode;
    NSString *payment_pwdMD5 = [MyMD5 md5:tf1.text];
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/upWalletPwdBySms?payment_pwd=%@&code=%@&token=%@&version=%@",[NSObject baseURLStr],payment_pwdMD5,code,token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
//    //URzL = %@",URL);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
//        MyLog(@"验证码修改支付密码: %@",responseObject);
        
        if (responseObject!=nil) {
            NSString *message=responseObject[@"message"];
            if ([responseObject[@"pwdflag"] intValue] == 0&&[responseObject[@"status"]intValue]==1) {
                [MBProgressHUD showSuccess:@"修改成功"];
                if ([self.navigationController.viewControllers[self.navigationController.viewControllers.count-2] isKindOfClass:[TFPayStyleViewController class]]) {
                    
                    [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count] animated:YES];
                    return ;
                }
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[TFAccountSafeViewController class]]||[controller isKindOfClass:[TFMyWalletViewController class]]||[controller isKindOfClass:[TFPayStyleViewController class]]||[controller isKindOfClass:[MyOrderViewController class]]) {
                        [self.navigationController popToViewController:controller animated:YES];
                    }
                }
                
            } else {
                if ([responseObject[@"pwdflag"] intValue]==1){
                    message=pwdflagString1;
                }else if ([responseObject[@"pwdflag"] intValue]==2){
                    message=pwdflagString2;
                }else if ([responseObject[@"pwdflag"] intValue]==3){
                    message=pwdflagString3;
                }
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
    
}


- (void)httpChangePwd
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    UITextField *tf1 = (UITextField *)[self.view viewWithTag:200];
    
        //发起请求
    NSString *oldpwdMD5 = [MyMD5 md5:self.oldPwd];
    NSString *newpwdMd5 = [MyMD5 md5:tf1.text];
    
//    if([self.oldPwd isEqualToString:tf1.text])
//    {
//        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
//        [mentionview showLable:@"不能与原支付密码相同" Controller:self];
//        return;
//    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/wallet/upWalletPwd?old_pwd=%@&payment_pwd=%@&token=%@&version=%@",[NSObject baseURLStr],oldpwdMD5,newpwdMd5,token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        //通过原支付密码修改支付密码: %@", responseObject);
        
        if (responseObject!=nil) {
            NSString *message=responseObject[@"message"];
            if ([responseObject[@"pwdflag"] intValue] == 0&&[responseObject[@"status"]intValue]==1) {
                [MBProgressHUD showSuccess:@"修改成功"];
                
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[TFAccountSafeViewController class]]||[controller isKindOfClass:[TFMyWalletViewController class]]||[controller isKindOfClass:[TFPayStyleViewController class]]||[controller isKindOfClass:[MyOrderViewController class]]) {
                        [self.navigationController popToViewController:controller animated:YES];
                    }
                }
            } else {
                if ([responseObject[@"pwdflag"] intValue]==1){
                    message=pwdflagString1;
                }else if ([responseObject[@"pwdflag"] intValue]==2){
                    message=pwdflagString2;
                }else if ([responseObject[@"pwdflag"] intValue]==3){
                    message=pwdflagString3;
                }
                [MBProgressHUD showError:message];
            }
        }
        

        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }];
}

- (void)httpSetPassword
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    UITextField *tf1 = (UITextField *)[self.view viewWithTag:200];
    UITextField *tf2 = (UITextField *)[self.view viewWithTag:201];
    if ([tf1.text isEqualToString:tf2.text]) {
        NSString *pwMD5 = [MyMD5 md5:tf1.text];
        NSString *urlStr = [NSString stringWithFormat:@"%@wallet/setWalletPwd?token=%@&version=%@&payment_pwd=%@",[NSObject baseURLStr],token,VERSION,pwMD5];
        NSString *URL = [MyMD5 authkey:urlStr];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            MyLog(@"设置支付密码: %@",__func__,responseObject);
            responseObject = [NSDictionary changeType:responseObject];
            if (responseObject!=nil) {
                if ([responseObject[@"status"] intValue] == 1) {
                    [MBProgressHUD showSuccess:@"设置成功"];
                    
                    [self.view endEditing:YES];
                    NSNotification *notification =[NSNotification notificationWithName:@"setpasswordsuccess" object:nil userInfo:nil];
                    
                    //通过通知中心发送通知
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                    
                } else {
                    [MBProgressHUD showError:responseObject[@"message"]];
                }
            }
            
 
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
            NavgationbarView *nv = [[NavgationbarView alloc] init];
            [nv showLable:@"网络连接失败,请检查网络设置" Controller:self];
        }];
    } else if (![tf1.text isEqualToString:tf2.text]) {
        [MBProgressHUD showError:@"两次密码输入不一致"];
    } else if (tf1.text.length == 0||tf2.text.length == 0) {
        [MBProgressHUD showError:@"不能为空"];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (range.location>=6) {
        return NO;
    }
    return YES;
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
