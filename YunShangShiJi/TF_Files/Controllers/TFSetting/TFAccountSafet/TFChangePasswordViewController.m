//
//  TFChangePasswordViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/1.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFChangePasswordViewController.h"
#import "LoginViewController.h"
#import "MyMD5.h"


@interface TFChangePasswordViewController ()



@end

@implementation TFChangePasswordViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super setNavigationItemLeft:@"修改密码"];
    
    [self createUI];
    
}

#pragma mark - 创建UI
- (void)createUI
{
    CGFloat ud_Margin = ZOOM(50);
    CGFloat lr_Margin = ZOOM(62);
    CGFloat H = ZOOM(120);
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"当前密码",@"新密码",@"确认新密码",@"确认提交", nil];
    for (int i = 0; i<4; i++) {
        if (i!=3) {
            UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(lr_Margin, kNavigationheightForIOS7+ZOOM(40)+i*H+i*ud_Margin, kScreenWidth-lr_Margin*2, H)];
            tf.borderStyle = UITextBorderStyleRoundedRect;
            tf.placeholder = titleArr[i];
            tf.font = [UIFont systemFontOfSize:ZOOM(48)];
            tf.secureTextEntry = YES;
            tf.tag = 200+i;
//            tf.textAlignment = NSTextAlignmentCenter;
            if (i!=2) {
                tf.returnKeyType = UIReturnKeyNext;
            } else {
                tf.returnKeyType = UIReturnKeyDone;
            }
            [self.view addSubview:tf];
        } else {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(lr_Margin, kNavigationheightForIOS7+ZOOM(40)+i*H+i*ud_Margin+ZOOM(120), kScreenWidth-lr_Margin*2, ZOOM(120));
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
            [btn addTarget:self action:@selector(commitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框高亮"] forState:UIControlStateHighlighted];
            [self.view addSubview:btn];
        }
    }
}
-(BOOL)IsChinese:(NSString *)str {
    for(int i=0; i< [str length];i++)
    { int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        { return YES;
        }
    } return NO;
}

- (void)commitBtnClick:(UIButton *)sender
{
    UITextField *tf1 = (UITextField *)[self.view viewWithTag:200];
    UITextField *tf2 = (UITextField *)[self.view viewWithTag:201];
    UITextField *tf3 = (UITextField *)[self.view viewWithTag:202];
    
    //tf1 = %@, tf2 = %@, tf3 = %@", tf1.text, tf2.text, tf3.text);
    
    NSString *tf1_text = tf1.text;
    NSString *tf2_text = tf2.text;
    NSString *tf3_text = tf3.text;
    
    if (tf1_text.length == 0) {
        [MBProgressHUD showError:@"请输入原始密码!"];
        return;
    } else if (tf2_text.length == 0) {
        [MBProgressHUD showError:@"请输入新密码!"];
        return;
    } else if (tf3_text.length == 0) {
        [MBProgressHUD showError:@"请确认新密码!"];
        return;
    }
    
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    NSString *oldPassword = [ud objectForKey:USER_PASSWORD];
    
//    if ([oldPassword isEqualToString:tf1.text]&&[tf2.text isEqualToString:tf3.text]&&!(tf2.text.length>16||tf2.text.length<6)){  //密码匹配
    if ([tf2.text isEqualToString:tf3.text]&&!(tf2.text.length>16||tf2.text.length<6)){  //密码匹配

    
        
//        BOOL passBl = [self validatePassword:tf2.text]&&![self IsChinese:tf2.text];
        
        BOOL passBl = !([MyMD5 asciiLengthOfString:tf2.text]<6||[MyMD5 asciiLengthOfString:tf2.text]>16)&&![self IsChinese:tf2.text];

        if (passBl == YES) {
            //1.把密码发给服务器
            NSString *token = [ud objectForKey:USER_TOKEN];
            
//            NSString *oldPWMD5 = [MyMD5 md5:oldPassword];   //原始密码MD5加密
            NSString *oldPWMD5 = [MyMD5 md5:tf1.text];   //原始密码MD5加密
            NSString *newPWMD5 = [MyMD5 md5:tf2.text];      //新密码MD5加密
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            
            NSString *urlStr = [NSString stringWithFormat:@"%@/user/updatePwd?version=%@&pwd=%@&newPwd=%@&token=%@",[NSObject baseURLStr],VERSION,oldPWMD5,newPWMD5,token];
            NSString *URL = [MyMD5 authkey:urlStr];
            [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                responseObject = [NSDictionary changeType:responseObject];
                //修改登录密码: %@", responseObject);
                
                if (responseObject!=nil) {
                    if ([responseObject[@"status"] intValue]==1) {  //修改成功
                        [MBProgressHUD showSuccess:@"修改成功,请重新登录"];
                        //2.新密码存在本地
                        [ud setObject:tf2.text forKey:USER_PASSWORD];
                        [ud synchronize];
                        //3.回到上一级页面
                        //                [self.navigationController popViewControllerAnimated:YES]; //回到上一页
                        //重新登录
                        [self performSelector:@selector(login) withObject:nil afterDelay:0.5];
                        
                        
                    } else {
                        [MBProgressHUD showError:responseObject[@"message"]];
                    }
                    
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [MBProgressHUD showError:@"网络错误,请检查网络连接"];
            }];
        } else {
            [MBProgressHUD showError:@"密码为6-16个英文、数字字符"];
        }
    }
//    else if (![oldPassword isEqualToString:tf1.text]) {
//        [MBProgressHUD showError:@"当前密码不匹配,请重新输入"];
//    }
    else if (![tf2.text isEqualToString:tf3.text]) {
        [MBProgressHUD showError:@"两次密码输入不一致,请重新输入"];
    } else if ([MyMD5 asciiLengthOfString:tf2.text]<6||[MyMD5 asciiLengthOfString:tf2.text]>16) {
        [MBProgressHUD showError:@"密码为6-16个英文、数字"];
    }
}

#pragma mark -转向登陆页面
- (void)login
{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *User_id = [ud objectForKey:USER_ID];
    
    [ud removeObjectForKey:USER_TOKEN];
    [ud removeObjectForKey:USER_PHONE];
    [ud removeObjectForKey:USER_PASSWORD];
    [ud removeObjectForKey:USER_NAME];
    [ud removeObjectForKey:USER_EMAIL];
    [ud removeObjectForKey:USER_INFO];
    [ud removeObjectForKey:USER_ID];
    [ud removeObjectForKey:USER_REALM];
    [ud removeObjectForKey:USER_ARRER];
    [ud removeObjectForKey:USER_BIRTHDAY];
    //删除头像
    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),User_id];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:aPath error:nil];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    //回到登陆页面
    LoginViewController *login=[[LoginViewController alloc]init];
    login.tag= 1000;
    [self.navigationController pushViewController:login animated:YES];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
