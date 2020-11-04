//
//  TFSecurityVerificationViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/17.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFSecurityVerificationViewController.h"
#import "TFCashSuccessViewController.h"

@interface TFSecurityVerificationViewController () <UITextFieldDelegate>
@property (nonatomic, strong)UITextField *inputField;
@end

@implementation TFSecurityVerificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super setNavigationItemLeft:self.headTitle];
    
    [self createUI];
}

- (void)createUI
{
    
    CGFloat lr_Margin = ZOOM(62);
//    CGFloat ud_Margin = ZOOM(50);

    self.inputField = [[UITextField alloc] initWithFrame:CGRectMake(lr_Margin, kNavigationheightForIOS7+ZOOM(30), kScreenWidth-2*lr_Margin, ZOOM(114))];
    self.inputField.placeholder = self.plaStr;
    self.inputField.borderStyle = UITextBorderStyleRoundedRect;
    self.inputField.keyboardType = UIKeyboardTypeNumberPad;
    self.inputField.secureTextEntry = YES;
    self.inputField.delegate = self;
    [self.view addSubview:self.inputField];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ZOOM(300), self.inputField.frame.size.height)];
    label.font = [UIFont systemFontOfSize:ZOOM(48)];
//    label.textColor = RGBCOLOR_I(220,220,220);
    label.text = [NSString stringWithFormat:@"  %@",self.leftStr];
    self.inputField.leftView = label;
    self.inputField.leftViewMode = UITextFieldViewModeAlways;
    
    CGFloat btn_H = ZOOM(120);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(lr_Margin,  self.inputField.bottom+btn_H, self.inputField.frame.size.width, btn_H);
    btn.tag = 100;
    btn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框高亮"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location>=6) {
        return NO;
    } else {
        return YES;
    }
}

- (void)btnClick:(UIButton *)sender
{
    if (self.index == 2||self.index == 1) {
        if (self.inputField.text.length == 6) {
            [self httpCheck];
        } else {
            [MBProgressHUD showError:@"密码长度为6位"];
        }
    }
}

- (void)httpCheck
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *pwd = [MyMD5 md5:self.inputField.text];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@user/checkPaymentPassword?version=%@&token=%@&pwd=%@",[NSObject baseURLStr],VERSION,token,pwd];
    
    NSString *URL = [MyMD5 authkey:urlStr];
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                //完成绑定
                TFCashSuccessViewController *tavc = [[TFCashSuccessViewController alloc] init];
                tavc.index = VCType_BindPhoneSuccess;
                
                if(pwd.length >10)
                {
                    [ud setObject:pwd forKey:OTHER_PASSWORD];
                }
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
