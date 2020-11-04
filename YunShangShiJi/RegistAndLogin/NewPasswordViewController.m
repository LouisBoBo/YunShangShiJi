//
//  NewPasswordViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/10.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "NewPasswordViewController.h"
#import "LoginViewController.h"
#import "OldUserLoginVC.h"
#import "MymineViewController.h"
#import "MyTabBarController.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "AFNetworking.h"
#import "KeyboardTool.h"
#import "GlobalTool.h"
#import "Tools.h"
#import "MyMD5.h"
@interface NewPasswordViewController ()<KeyboardToolDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UITextField *nextPasswordField;
@property (nonatomic, strong) UIButton *checkBtn;
@property (nonatomic, strong) UIButton *changeBtn;

@end

@implementation NewPasswordViewController

{
    UITextField *_newpassFild;
    UITextField *_oldpassFild;
    
    //是否是邮箱
    BOOL EmailOK;
    //是否是手机号码
    BOOL isCorrect;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
}
#pragma mark - %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
- (void)setupUI
{
    self.view.backgroundColor = RGBCOLOR_I(244, 244, 244);
    [self setNavigationItemLeft:@"输入新密码"];
    
    CGFloat lr_Margin = ZOOM6(30);
    CGFloat H = ZOOM6(100);
    
    UILabel *headLab = [UILabel new];
    headLab.text = @"验证成功，请输入新密码并妥善保存";
    headLab.font = kFont6px(25);
    headLab.textColor = RGBCOLOR_I(68, 68, 68);
    headLab.backgroundColor = RGBCOLOR_I(244, 244, 244);
    [self.view addSubview:headLab];
    
    [headLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(lr_Margin);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(30);
    }];
    
    UIView *backgroundV = [UIView new];
    backgroundV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundV];
    
    [backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headLab.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(H*2);
    }];
    
    /**< 输入 */
    [self.view addSubview:self.passwordField];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundV);
        make.left.equalTo(backgroundV.mas_left).offset(lr_Margin);
        make.right.equalTo(backgroundV.mas_right).offset(-lr_Margin);
        make.height.mas_equalTo(H);
    }];
    
    UIView *lineV = [UIView new];
    [self.view addSubview:lineV];
    lineV.backgroundColor = RGBCOLOR_I(244, 244, 244);
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordField.mas_bottom);
        make.left.right.equalTo(self.passwordField);
        make.height.mas_equalTo(1);
    }];
    
    [self.view addSubview:self.checkBtn];
    [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ZOOM6(100));
        make.right.equalTo(backgroundV.mas_right);
        make.top.equalTo(lineV.mas_bottom);
        make.bottom.equalTo(backgroundV);
    }];
    
    [self.view addSubview:self.nextPasswordField];
    [self.nextPasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineV.mas_bottom);
        make.left.equalTo(self.passwordField);
        make.right.equalTo(self.checkBtn.mas_left);
        make.height.mas_equalTo(self.passwordField.mas_height);

    }];
    
    [self.view addSubview:self.changeBtn];
    [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(lr_Margin);
        make.right.equalTo(self.view.mas_right).offset(-lr_Margin);
        make.top.equalTo(backgroundV.mas_bottom).offset(30);
        make.height.mas_equalTo(H);
    }];

}

- (void)checkBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.passwordField.secureTextEntry = !sender.selected;
    self.nextPasswordField.secureTextEntry = !sender.selected;
}

- (void)changeBtnClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    NSString *passwordText = self.passwordField.text;
    NSString *nextPassword = self.nextPasswordField.text;
    if (!passwordText.length) {
        [nv showLable:@"请设置6—16位英文、数字字符" Controller:self];
        return;
    }
    if (!nextPassword.length) {
        [nv showLable:@"请输入确认密码" Controller:self];
        return;
    }
    
    if (![passwordText isEqualToString:nextPassword]) {
        [nv showLable:@"两次密码不一致，请重新输入" Controller:self];
        return;
    }
    
    if (passwordText.length>16 || passwordText.length<6) {
        [nv showLable:@"请设置6—16位英文、数字字符" Controller:self];
        return;
    }
    
    BOOL isCheck = [self validatePassword:passwordText];
    if (isCheck) {
        [self httpChangePassword];
    }
    
}

- (BOOL)isPhonechangePassword
{
    BOOL isPhone = NO;
    NSRange rang = [self.phoneAndEmail rangeOfString:@"@"];
    if (rang.length>=1) { /**< 邮箱 */
        isPhone = NO;
    } else {
        isPhone = YES;
    }
    return isPhone;
}

- (void)httpChangePassword
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    BOOL isPhone = [self isPhonechangePassword];
    NSString *kApi;
    NSDictionary *parameter;
    NSString *pwd = [MyMD5 md5:self.passwordField.text];
    if (isPhone) {
        kApi = kApi_user_getRetrievePwd;
        parameter = @{@"phone": self.phoneAndEmail, @"pwd": pwd, @"code":  self.code};
    } else {
        kApi = kApi_user_getRetrievePwdEmail;
        parameter = @{@"user_email": self.phoneAndEmail, @"user_pass": pwd, @"code": self.code};
    }
    
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi parameter:parameter caches:NO cachesTimeInterval:0*TFHour token:NO success:^(id data, Response *response) {
        
        
        if (response.status == 1) {
            [nv showLable:@"设置成功，请用新密码登录" Controller:self];
            //界面跳转
            [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(push) userInfo:nil repeats:NO];
        } else {
            [nv showLable:response.message Controller:self];
        }
        
    } failure:^(NSError *error) {
        [nv showLable:@"网络开小差啦，请检查网络" Controller:self];
    }];
    
}

- (UITextField *)passwordField
{
    if (!_passwordField) {
        _passwordField = [[UITextField alloc] init];
        _passwordField.backgroundColor = [UIColor whiteColor];
        _passwordField.borderStyle = UITextBorderStyleNone;
        _passwordField.placeholder = @"设置6~16位英文、数字字符";
        _passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordField.secureTextEntry = YES;
        _passwordField.font = kFont6px(30);
        _passwordField.delegate = self;
    }
    return _passwordField;
}

- (UITextField *)nextPasswordField
{
    if (!_nextPasswordField) {
        _nextPasswordField = [[UITextField alloc] init];
        _nextPasswordField.backgroundColor = [UIColor whiteColor];
        _nextPasswordField.borderStyle = UITextBorderStyleNone;
        _nextPasswordField.placeholder = @"请再次确认新密码";
        _nextPasswordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nextPasswordField.secureTextEntry = YES;
        _nextPasswordField.delegate = self;
        _nextPasswordField.font = kFont6px(30);
    }
    return _nextPasswordField;
}

- (UIButton *)checkBtn
{
    if (!_checkBtn) {
        _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkBtn setImage:[UIImage imageNamed:@"Communal_sgin_yanjing_icon_Selected"] forState:UIControlStateSelected];
        [_checkBtn setImage:[UIImage imageNamed:@"Communal_sgin_yanjing_icon_default"] forState:UIControlStateNormal];
        _checkBtn.selected = NO;
        //_checkBtn.backgroundColor = COLOR_RANDOM;
        [_checkBtn addTarget:self action:@selector(checkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkBtn;
}

- (UIButton *)changeBtn
{
    if (!_changeBtn) {
        _changeBtn = [UIButton new];
        [_changeBtn setTitle:@"完成修改" forState:UIControlStateNormal];
        
        [_changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [_changeBtn setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_I(195, 195, 195)] forState:UIControlStateSelected];
        [_changeBtn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateNormal];
        [_changeBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _changeBtn.layer.masksToBounds = YES;
        _changeBtn.layer.cornerRadius = ZOOM6(8);
        _changeBtn.selected = YES;
    }
    return _changeBtn;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    
    if (textField == self.passwordField) {
        NSString *currInputText = [NSString stringWithFormat:@"%@%@", self.passwordField.text, string];
        if (currInputText.length>0 && self.nextPasswordField.text.length) { // 输入
            self.changeBtn.userInteractionEnabled = YES;
            self.changeBtn.selected = NO;
        }
        
        if (range.length >= 1 && range.location == 0) { // 删除
            self.changeBtn.userInteractionEnabled = NO;
            self.changeBtn.selected = YES;
        }
    }
    
    if (textField == self.nextPasswordField) {
        NSString *currCodeText = [NSString stringWithFormat:@"%@%@", self.nextPasswordField.text, string];
        if (currCodeText.length>0 && self.passwordField.text.length) { // 输入
            self.changeBtn.userInteractionEnabled = YES;
            self.changeBtn.selected = NO;
        }
        
        if (range.length >= 1 && range.location == 0) { // 删除
            self.changeBtn.userInteractionEnabled = NO;
            self.changeBtn.selected = YES;
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    
    if (textField == self.passwordField || textField == self.nextPasswordField) {
        self.changeBtn.userInteractionEnabled = NO;
        self.changeBtn.selected = YES;
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark - %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
- (void)oldUI
{
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
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"输入新密码";
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    [self creatView];

}

-(void)viewWillAppear:(BOOL)animated
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
    //请输入新密码
    UIImageView *NameView=[[UIImageView alloc]initWithFrame:CGRectMake(30, 100, kApplicationWidth-60, 40)];
    NameView.image=[UIImage imageNamed:@""];
    _oldpassFild=[[UITextField alloc]initWithFrame:CGRectMake(5, 5, NameView.frame.size.width-10, 30)];
    _oldpassFild.placeholder=@"输入新密码";
    _oldpassFild.secureTextEntry=YES;
    [NameView addSubview:_oldpassFild];
    NameView.userInteractionEnabled=YES;
    
    UILabel *lableline=[[UILabel alloc]initWithFrame:CGRectMake(0,40, kApplicationWidth-60, 2)];
    lableline.backgroundColor=kBackgroundColor;
    [NameView addSubview:lableline];
    
    //重新输入密码
    UIImageView *passView=[[UIImageView alloc]initWithFrame:CGRectMake(30, NameView.frame.origin.y+NameView.frame.size.height+20, NameView.frame.size.width, 40)];
    passView.image=[UIImage imageNamed:@""];
    _newpassFild=[[UITextField alloc]initWithFrame:CGRectMake(5, 5, passView.frame.size.width-10, 30)];
    _newpassFild.placeholder=@"确认新密码";
    _newpassFild.secureTextEntry=YES;
    [passView addSubview:_newpassFild];
    passView.userInteractionEnabled=YES;
    
    UILabel *lableline1=[[UILabel alloc]initWithFrame:CGRectMake(0,40, kApplicationWidth-60, 2)];
    lableline1.backgroundColor=kBackgroundColor;
    [passView addSubview:lableline1];
    
    //完成修改
    UIButton *loginbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginbtn.frame=CGRectMake(30, passView.frame.origin.y+passView.frame.size.height+40, kApplicationWidth-60, 40);
//    [loginbtn setBackgroundImage:[UIImage imageNamed:@"完成注册"] forState:UIControlStateNormal];
    
    [loginbtn setBackgroundColor:[UIColor blackColor]];
    [loginbtn setTitle:@"完成修改" forState:UIControlStateNormal];
    loginbtn.titleLabel.font=kTitleFontSize;
    loginbtn.tintColor=[UIColor whiteColor];
    [loginbtn addTarget:self action:@selector(finishChange:) forControlEvents:UIControlEventTouchUpInside];
    
    //提示
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(30, loginbtn.frame.origin.y+loginbtn.frame.size.height+10, 150, 20)];
    lable.text=@"输入你的新密码完成修改";
    lable.textColor=[UIColor grayColor];
    lable.font=kStatementFontSize;
    [self.view addSubview:lable];
    
    
    [self.view addSubview:NameView];
    [self.view addSubview:passView];
    [self.view addSubview:loginbtn];

    KeyboardTool *tool = [KeyboardTool keyboardTool];
    tool.delegate = self;
    tool.frame=CGRectMake(0, tool.frame.origin.y, kScreenWidth, 40);
    _oldpassFild.inputAccessoryView = tool;
    _newpassFild.inputAccessoryView = tool;
}
//键盘
- (void)keyboardTool:(KeyboardTool *)keyboardTool itemClick:(KeyboardToolItemType)itemType
{
    if (itemType == KeyboardToolItemTypePrevious) { // 上一个
        //----上一个----");
    } else if (itemType == KeyboardToolItemTypeNext) { // 下一个
        //----下一个----");
    } else { // 完成
        //----完成----");
        [self.view endEditing:YES];
    }
}

-(void)finishChange:(UIButton*)sender
{
    // 判读密码
    
    if ([_oldpassFild.text length]<1 )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"密码输入不能为空,请重新设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
//    if ([_oldpassFild.text length]>0 && [_oldpassFild.text length]<6)
    if ([_oldpassFild.text length]>0 && [MyMD5 asciiLengthOfString:_oldpassFild.text]<6)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"密码长度不能小于六位,请重新设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
//    if ([_oldpassFild.text length]>10)
    if ([MyMD5 asciiLengthOfString:_oldpassFild.text]>16)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"密码长度过长,请重新设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if ([[Tools share] stringContainsEmoji:_oldpassFild.text])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"密码暂不支持表情字符" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if ([_newpassFild.text length]<1 )
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"密码输入不能为空,请重新设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    NSString *str1=[NSString stringWithFormat:@"%@",_newpassFild.text];
    NSString *str2=[NSString stringWithFormat:@"%@",_oldpassFild.text];
        
    if(![str1 isEqualToString:str2])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"两次输入的密码不相同" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;

    }
    
    //用@判读是手机号码还是邮箱
    NSString *phoneStr = self.phoneAndEmail;
    NSRange range;
    range=[phoneStr rangeOfString:@"@"];
    if(range.length>0)
    {
        //是邮箱
        EmailOK=[self isValidateEmail:phoneStr];
        
        if(EmailOK!=YES)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"输入邮箱不合法,请重新设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
        
    }else{
        //是手机号码
        
        isCorrect = [self isValidateMobile:phoneStr];
        
        if (isCorrect) {
            
            //是手机号码");
            
            
        }   else {
            
            //不是手机号码");
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            return;
            
        }
        
        
    }
    
    _oldpassFild.secureTextEntry=YES;
    _newpassFild.secureTextEntry=YES;
    //网络请求找回密码
    [self findHttp];
    
}

//邮箱是否合法
-(BOOL)isValidateEmail:(NSString *)email

{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

#pragma mark 验证手机号
/*
-(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    //phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}
*/
-(BOOL) isValidateMobile:(NSString *)mobile
{
    //        手机号以13， 15，18开头，八个 \d 数字字符
    //11位数字
    NSString *phoneRegex = @"^\\d{11}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    //phoneTest is %@",phoneTest);
    
    //phoneBl = %d", [phoneTest evaluateWithObject:mobile]);
    return [phoneTest evaluateWithObject:mobile];
}

#pragma mark 网络请求找回密码
-(void)findHttp
{
    // 1.创建网络请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *Password=[MyMD5 md5:_newpassFild.text];
    
    NSString *url ;
    if(EmailOK)//邮箱
    {
        url = [NSString stringWithFormat:@"%@user/getRetrievePwdEmail?version=%@&user_email=%@&user_pass=%@&code=%@", [NSObject baseURLStr],VERSION,self.phoneAndEmail,Password,self.code];
    }
    if(isCorrect)//手机
    {
        url = [NSString stringWithFormat:@"%@user/getRetrievePwd?version=%@&phone=%@&pwd=%@&code=%@", [NSObject baseURLStr],VERSION,self.phoneAndEmail,Password,self.code];
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *URL=[MyMD5 authkey:url];
    //url is %@",URL);
    
    [MBProgressHUD showMessage:@"请耐心等待..." afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            
            NSString *token = responseObject[@"token"];
            //%@", token);
            
            
            // 判断成不成功
            NSString *str = responseObject[@"status"];
            
            // 成功
            if ( str.intValue == 1) {
                [MBProgressHUD hideHUDForView:self.view];
                [MBProgressHUD showSuccess:@"密码修改成功"];
                [self.view endEditing:YES];
                //界面跳转
                [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(push) userInfo:nil repeats:NO];
                
                //            [self.navigationController popToRootViewControllerAnimated:NO];
                
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
            
            else {
                
                //%@", responseObject[@"message"]);
                
                NSString *errorStr = [NSString stringWithFormat:@"亲对不起，%@", responseObject[@"message"]];
                
#pragma mark -- 可以再这里提醒用户，出错
                [MBProgressHUD hideHUDForView:self.view];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:errorStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alertView show];
                
            }
        
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //%@", error.localizedDescription);
        [MBProgressHUD hideHUDForView:self.view];
        
    }];
    

}

#pragma mark -界面跳转
- (void)push
{

    for (UIViewController *view in self.navigationController.viewControllers) {
        if ([view isKindOfClass:[OldUserLoginVC class]]) {
            [self.navigationController popToViewController:view animated:YES];
            return;
        }
    }
    for (UIViewController *view in self.navigationController.viewControllers) {
        if ([view isKindOfClass:[LoginViewController class]]) {
            [self.navigationController popToViewController:view animated:YES];
            return;
        }
    }
//    LoginViewController *login=[[LoginViewController alloc]init];
//    login.tag=1000;
//    login.string=@"找回密码";
//    [self.navigationController pushViewController:login animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}
#pragma mark 返回上一视图
-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
