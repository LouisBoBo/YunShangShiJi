//
//  PhoneRegistViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/10.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "PhoneRegistViewController.h"
#import "AFNetworking.h"
#import "LoginViewController.h"
#import "SubmitViewController.h"
#import "MymineViewController.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "GlobalTool.h"
#import "AppDelegate.h"
#import "Tools.h"
#import "CommonCrypto/CommonDigest.h"
#import "KeyboardTool.h"
#import "MyMD5.h"
#import "UserInfo.h"
#import "NavgationbarView.h"

#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/ISSQZoneApp.h>

@interface PhoneRegistViewController ()<KeyboardToolDelegate>

@end

@implementation PhoneRegistViewController
{
    CGFloat _otherLoginY;

    
    //邮箱输入
    UITextField *_Emailfild;
    //呢称输入
    UITextField *_namefild;
    //密码
    UITextField *_passwordfild;
    //验证码输入
    UITextField *_yanzhengfild;
    //是否显示密码
    UISwitch *_lightswitch;
    //协议按钮
    UIButton *_xieyibtn;
    BOOL _Statue;
    
    //第三方登录类型
    NSString *usertype;
    
    NSMutableArray *_headArray;
    NSMutableArray *_NameArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headArray=[NSMutableArray array];
    _NameArray=[NSMutableArray array];
    
    [self OpenDb];
    
    [self creatData:@"0"];
    
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
    titlelable.text=@"邮箱注册";
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

    for(int i=0;i<4;i++)
    {
        CGFloat Width;
        UIImageView *pubimg=[[UIImageView alloc]init];
        
        if(i==0)
        {
            Width=60;
            
            pubimg.frame=CGRectMake(30, 40*i+90, kApplicationWidth-Width, 30);
            _Emailfild=[[UITextField alloc]initWithFrame:CGRectMake(5, 0, kApplicationWidth-Width, 30)];
            _Emailfild.placeholder=@"输入邮箱";
            _Emailfild.userInteractionEnabled=YES;
            
            UILabel *lableline=[[UILabel alloc]initWithFrame:CGRectMake(0, _Emailfild.frame.origin.y+_Emailfild.frame.size.height+5, kApplicationWidth-60, 2)];
            lableline.backgroundColor=kBackgroundColor;
            [pubimg addSubview:lableline];
            [pubimg addSubview:_Emailfild];
            
        }else if (i==1)
        {
             Width=60;
            pubimg.frame=CGRectMake(30, 40*i+90, kApplicationWidth-Width, 30);
            _namefild=[[UITextField alloc]initWithFrame:CGRectMake(5, 0, kApplicationWidth-Width, 30)];
            _namefild.userInteractionEnabled=YES;
            _namefild.placeholder=@"输入昵称";
            
            UILabel *lableline=[[UILabel alloc]initWithFrame:CGRectMake(0, _namefild.frame.origin.y+_namefild.frame.size.height+5, kApplicationWidth-60, 2)];
            lableline.backgroundColor=kBackgroundColor;
            [pubimg addSubview:lableline];

            [pubimg addSubview:_namefild];
           
            
        }else if (i==2)
        {
            Width=140;
            pubimg.frame=CGRectMake(30, 40*i+90, kApplicationWidth-Width, 30);
            _passwordfild=[[UITextField alloc]initWithFrame:CGRectMake(5, 0, kApplicationWidth-Width, 30)];
            _passwordfild.userInteractionEnabled=YES;
            _passwordfild.placeholder=@"输入密码";
            _passwordfild.secureTextEntry=YES;
            
            UILabel *lableline=[[UILabel alloc]initWithFrame:CGRectMake(0, _passwordfild.frame.origin.y+_passwordfild.frame.size.height+5, kApplicationWidth-60, 2)];
            lableline.backgroundColor=kBackgroundColor;
            [pubimg addSubview:lableline];

            [pubimg addSubview:_passwordfild];
            
            
            _lightswitch=[[UISwitch alloc]initWithFrame:CGRectMake(kApplicationWidth-90, 40*i+90, 100, 20)];
            [_lightswitch addTarget:self action:@selector(mima) forControlEvents:UIControlEventValueChanged];
            [_lightswitch setOn:YES];
            [self.view addSubview:_lightswitch];
        }else{

            Width=160;
            pubimg.frame=CGRectMake(30, 40*i+90, kApplicationWidth-Width, 30);
            _yanzhengfild=[[UITextField alloc]initWithFrame:CGRectMake(5, 0, kApplicationWidth-Width, 30)];
            _yanzhengfild.userInteractionEnabled=YES;
            _yanzhengfild.placeholder=@"验证码";
            
            UILabel *lableline=[[UILabel alloc]initWithFrame:CGRectMake(0, _yanzhengfild.frame.origin.y+_yanzhengfild.frame.size.height+5, kApplicationWidth-60, 2)];
            lableline.backgroundColor=kBackgroundColor;
            [pubimg addSubview:lableline];

            [pubimg addSubview:_yanzhengfild];
            
            //验证码图片
            self.codeView = [[PooCodeView alloc] initWithFrame:CGRectMake(kApplicationWidth-120 , 40*i+90, 90, 30)];
            [self.view addSubview:self.codeView];
        }
        
        
        pubimg.image=[UIImage imageNamed:@""];
        pubimg.userInteractionEnabled=YES;
        [self.view addSubview:pubimg];
        
    }
    
    //同意协议
    _xieyibtn=[[UIButton alloc]initWithFrame:CGRectMake(30, 250, 16, 16)];
    _Statue=YES;
    _xieyibtn.layer.cornerRadius=8;
    [_xieyibtn setBackgroundImage:[UIImage imageNamed:@"协议"] forState:UIControlStateNormal];
    [_xieyibtn addTarget:self action:@selector(xieyi:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_xieyibtn];
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(50, 250, 150, 15)];
    lable.text=@"同意衣蝠服务协议";
    lable.font = [UIFont systemFontOfSize:ZOOM(44)];
    lable.textColor=kTextGreyColor;
    lable.font=kStatementFontSize;
    [self.view addSubview:lable];
    
    //完成注册
    UIButton *loginbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginbtn.frame=CGRectMake(30, lable.frame.origin.y+lable.frame.size.height+10, kApplicationWidth-60, 40);
   
    
    [loginbtn setBackgroundColor:[UIColor blackColor]];
    [loginbtn setTitle:@"完成注册" forState:UIControlStateNormal];
    loginbtn.tintColor=[UIColor whiteColor];
    loginbtn.titleLabel.font=kTitleFontSize;
    [loginbtn addTarget:self action:@selector(finishclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginbtn];
    
    //手机注册
    UIButton *losspassbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    losspassbtn.frame=CGRectMake(100, loginbtn.frame.origin.y+loginbtn.frame.size.height+40, kApplicationWidth-200, 20);
    [losspassbtn setTitle:@"手机注册" forState:UIControlStateNormal];
    [losspassbtn addTarget:self action:@selector(phoneRegist:) forControlEvents:UIControlEventTouchUpInside];
    losspassbtn.tintColor=kTextGreyColor;
    [self.view addSubview:losspassbtn];
    
    //提示
    UILabel *labl=[[UILabel alloc]initWithFrame:CGRectMake(30, losspassbtn.frame.origin.y+losspassbtn.frame.size.height+5, kApplicationWidth-60, 20)];
    labl.text=@"没有收到验证码？使用第三方账号一键登录。";
    labl.font=[UIFont systemFontOfSize:13];
//    [self.view addSubview:labl];
    
    
    KeyboardTool *tool = [KeyboardTool keyboardTool];
    tool.delegate = self;
    tool.frame=CGRectMake(0, tool.frame.origin.y, kScreenWidth, 40);
    _Emailfild.inputAccessoryView = tool;
    _namefild.inputAccessoryView = tool;
    _passwordfild.inputAccessoryView=tool;
    _yanzhengfild.inputAccessoryView=tool;
    
    _otherLoginY=375;
    //第三方登录
    [self creatOtherLogin];

}

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

#pragma mark 是否显示密码
-(void)mima
{
    //是否显示密码");
    if(_lightswitch.on)
    {
        //on");
        _passwordfild.secureTextEntry=YES;
        
    }else{
        //off");
        _passwordfild.secureTextEntry=NO;
    }
}

#pragma mark 第三方登录
-(void)creatOtherLogin
{
    //第三方登录
    UILabel *lableline=[[UILabel alloc]initWithFrame:CGRectMake(0, _otherLoginY, kApplicationWidth, 1)];
    lableline.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    lable.center=CGPointMake(kApplicationWidth/2, _otherLoginY);
    lable.text=@"第三方帐号登录";
    lable.textColor=kTextGreyColor;
    lable.font=kTextFontSize;
    lable.backgroundColor=[UIColor whiteColor];
    lable.textAlignment=NSTextAlignmentCenter;
    
    for(int i=0;i<3;i++)
    {
        UIButton *otherLoginbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        otherLoginbtn.frame=CGRectMake(80*i+(kApplicationWidth-220)/2, lableline.frame.origin.y+30, 60, 60);
        otherLoginbtn.layer.cornerRadius=30;
        if(i==0)
        {
            [otherLoginbtn setBackgroundImage:[UIImage imageNamed:@"u279.jpg"] forState:UIControlStateNormal];
            otherLoginbtn.tag=1000;
        }
        if(i==1)
        {
            [otherLoginbtn setBackgroundImage:[UIImage imageNamed:@"u281.jpg"] forState:UIControlStateNormal];
            otherLoginbtn.tag=2000;
        }
        if(i==2)
        {
            [otherLoginbtn setBackgroundImage:[UIImage imageNamed:@"u283.jpg"] forState:UIControlStateNormal];
            otherLoginbtn.tag=3000;
        }
        [otherLoginbtn addTarget:self action:@selector(otherLogin:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:otherLoginbtn];
    }
//    [self.view addSubview:lableline];
    [self.view addSubview:lable];
    
}

#pragma mark 第三方登录
-(void)otherLogin:(UIButton*)sender
{
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app shardk];
    
    //ok");
    if(sender.tag==1000)
    {
        //QQ");
        [self shareSdkWithAutohorWithType:ShareTypeQQSpace];
        usertype=@"1";
    }else if(sender.tag==2000)
    {
        //WX");
        [self shareSdkWithAutohorWithType:ShareTypeWeixiFav ];
        usertype=@"2";
    }else{
        //WB");
        [self shareSdkWithAutohorWithType:ShareTypeSinaWeibo ];
        usertype=@"3";
    }
}

#pragma mark 第三方登录
- (void)shareSdkWithAutohorWithType:(ShareType)type
{
    // 取消授权
    [ShareSDK cancelAuthWithType:type];
    
    
    // 开始授权
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
    [app setIsAllowWebAuthorize:YES];
    
    
    [ShareSDK getUserInfoWithType:type
                      authOptions:authOptions
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               if (result)
                               {
                                   
                                   //ffffffffff%@",[userInfo nickname]);
                                   //%@", [userInfo profileImage]);
                                   
                                   //uid--------%@", [userInfo uid]);
                                   
                                   
                                   id<ISSPlatformCredential> credential = [ShareSDK getCredentialWithType:type];
                                   
                                   
                                   //                                   //token------%@", [credential token]);
                                   
                                   //token--- %@", [credential token]);
                                   
                                   
                                   
                                   //上传第三方用户登录信息到服务器
                                   
                                   AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
                                   NSMutableDictionary *patamatrs=[NSMutableDictionary dictionary];
                                   
                                   NSString *nickname = [[userInfo nickname] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                                   NSString *url=[NSString stringWithFormat:@"%@user/userLogin?version=%@&wx_openid=%@&nickname=%@&pic=%@&token=%@&usertype=%d&device=2&type=7",[NSObject baseURLStr],VERSION,[userInfo uid],nickname,[userInfo profileImage],[credential token],usertype.intValue
                                                  ];
                                   NSString *URL=[MyMD5 authkey:url];
                                   //URL IS %@",URL);
                                   
                                   [MBProgressHUD showMessage:@"授权成功正在为你登录" afterDeleay:0 WithView:self.view];
                                   [manager POST:URL parameters:patamatrs success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       //responseObject is %@",responseObject);
                                       
//                                       responseObject = [NSDictionary changeType:responseObject];
                                       if (responseObject!=nil) {
                                           NSString *str=responseObject[@"status"];
                                           NSString *token=responseObject[@"token"];
                                           if(str.intValue==1)
                                           {
                                               //上传信息成功");
                                               [MBProgressHUD hideHUDForView:self.view];
                                               
                                               //保存当前用户登录/注册信息
                                               NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                                               [userdefaul setObject:[userInfo nickname] forKey:USER_NAME];
                                               [userdefaul setObject:token forKey:USER_TOKEN];
                                               [userdefaul setObject:[userInfo uid] forKey:USER_ID];
                                               [userdefaul setObject:@"user" forKey:USER_INFO];
                                               [userdefaul setObject:usertype forKey:USER_TYPE];
                                               
                                               
                                               //第三方登录成功就跳转到首页
                                               Mtarbar.selectedIndex=0;
                                               
                                               MymineViewController *mine=[[MymineViewController alloc]init];
                                               [self.navigationController pushViewController:mine animated:YES];
                                               
                                           }else{
                                               [MBProgressHUD hideHUDForView:self.view];
                                               
                                               //上传信息失败");
                                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:responseObject[@"message"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                               
                                               [alertView show];
                                           }
                                           

                                       }
                                       
                                       
                                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                       
                                       [MBProgressHUD hideHUDForView:self.view];

                                       NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                                       [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
                                       
                                   }];
                                   
                                   
                               }
                               
                               
                               
                               NSString *errorStr = [NSString stringWithFormat:@"%@", [error errorDescription]];
                               if ([errorStr isEqualToString:@"尚未授权"]) {
                                   
                                   
                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"对不起，授权不成功，请重新授权" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                   
                                   [alertView show];
                                   
                                   
                               }
                               
                               
                               
                           }];
    
    
    
    
}


#pragma mark 手机注册
-(void)phoneRegist:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark 完成注册
-(void)finishclick:(UIButton*)sender
{
    // 判读邮箱
    BOOL EmailOK=[self isValidateEmail:_Emailfild.text];
    
    if ([_Emailfild.text length]<1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"邮箱输入不能为空,请重新设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    if(EmailOK!=YES)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"输入邮箱不合法,请重新设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    // 判读姓名
    if ([_namefild.text length]<1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"昵称输入不能为空,请重新设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if ([_namefild.text length]>10) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"昵称不能超过10个汉字" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    
    if ([[Tools share] stringContainsEmoji:_namefild.text]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"昵称暂不支持表情字符" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    // 判读密码
    
    if ([_passwordfild.text length]<1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"密码输入不能为空,请重新设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if ([_passwordfild.text length]>0 && [_passwordfild.text length]<6) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"密码长度不能小于六位,请重新设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    if ([_passwordfild.text length]>10) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"密码长度过长,请重新设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if ([[Tools share] stringContainsEmoji:_passwordfild.text]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"密码暂不支持表情字符" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    //  判读验证码
    if ([_yanzhengfild.text isEqualToString:self.codeView.changeString])
    {

    }
    else
    {
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20, @20, @-20];
        [self.codeView.layer addAnimation:anim forKey:nil];
        [_yanzhengfild.layer addAnimation:anim forKey:nil];
        return;
    }


    //是否同意协议
    if(_Statue!=YES)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请同意衣蝠服务协议" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if(_Statue==YES)
    {
        
        [self requestHttp];
        
    }
}
//邮箱是否合法
-(BOOL)isValidateEmail:(NSString *)email

{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}
#pragma mark 获取验证码

#pragma mark 协议
-(void)xieyi:(UIButton*)sender
{
//    //协议");
//    
//    sender.selected=!sender.selected;
//    if (!sender.selected) {
//        [_xieyibtn setBackgroundImage:[UIImage imageNamed:@"同意协议"] forState:UIControlStateNormal];
//    }
//    else{
//        [_xieyibtn setBackgroundImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
//    }
//    
//
}
- (void)xieyiclick:(UITapGestureRecognizer*)tap
{
     MyLog(@"phoneOK");
}

#pragma mark 邮箱注册网络请求
-(void)requestHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSString *Password=[self md5:_passwordfild.text];
    Password=[Password uppercaseString];
    NSString *url=[NSString stringWithFormat:@"%@user/registerMailUser?version=%@&email=%@&nickname=%@&pwd=%@&device=2&type=7",[NSObject baseURLStr],VERSION,_Emailfild.text,_namefild.text,Password];
    //URL IS %@",url);
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    NSString *URL = [MyMD5 authkey:url];
    [MBProgressHUD showMessage:@"正在为你注册" afterDeleay:0 WithView:self.view];
    //URL IS %@",URL);
    [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //responseObject IS %@",responseObject);
        
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *str = responseObject[@"status"];
            //STR is %@",str);
            if(str.intValue==1)
            {
                [MBProgressHUD hideHUDForView:self.view];
                
                //APP注册成功就注册环信
                
//                [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:_Emailfild.text password:_passwordfild.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
//                    if (!error) {
//                        //环信注册成功");
//                        
//                        
//                        //环信登录
//                        [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:_Emailfild.text password:_passwordfild.text completion:^(NSDictionary *loginInfo, EMError *error) {
//                            if (!error && loginInfo) {
//                                //环信登陆成功");
//                                
//                                [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
//                            }
//                        } onQueue:nil];
//                        
//                    }
//                } onQueue:nil];
                
                
                
                NSString *token=[NSString stringWithFormat:@"%@",responseObject[@"token"]];
                
                SubmitViewController *sub=[[SubmitViewController alloc]init];
                sub.array=[NSArray arrayWithArray:_headArray];
                sub.nameArray=[NSArray arrayWithArray:_NameArray];
                [self.navigationController pushViewController:sub animated:NO];
                
                //保存当前登录用户的信息
                
                NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                [userdefaul setObject:_namefild.text forKey:USER_NAME];
                [userdefaul setObject:_passwordfild.text forKey:USER_PASSWORD];
                [userdefaul setObject:_Emailfild.text forKey:USER_EMAIL];
                [userdefaul setObject:@"user" forKey:USER_INFO];
                [userdefaul setObject:token forKey:USER_TOKEN];
                
                
            }else{
                [MBProgressHUD hideHUDForView:self.view];
                NSString *message=responseObject[@"message"];
                UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alter show];
            }

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
         [MBProgressHUD hideHUDForView:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
    
 
}

- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}

- (void)closeDB
{
    if (AttrcontactDB) {
        sqlite3_close(AttrcontactDB);
        AttrcontactDB = 0x00;
        
    }
    
}

-(BOOL)OpenDb
{
    if(AttrcontactDB)
    {
        return YES;
    }
    
    BOOL result=NO;
    
    /*根据路径创建数据库并创建一个表contact(id nametext addresstext phonetext)*/
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    
    _databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"attr.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //    if ([filemgr fileExistsAtPath:_databasePath] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        if (sqlite3_open(dbpath, &AttrcontactDB)==SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt;
            //            if([self.Sqlitetype isEqualToString:@"attr"])
            {
                sql_stmt = "CREATE TABLE IF NOT EXISTS ATTDB(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT,PHONE TEXT)";
            }
            //            if([self.Sqlitetype isEqualToString:@"type"])
            {
                
                sql_stmt = "CREATE TABLE IF NOT EXISTS TYPDB(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT,PHONE TEXT)";
            }
            //            if([self.Sqlitetype isEqualToString:@"tag"])
            {
                sql_stmt = "CREATE TABLE IF NOT EXISTS TAGDB(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT,PHONE TEXT)";
            }
            
            if (sqlite3_exec(AttrcontactDB, sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK) {
                
                result= YES;
            }
        }
        else
        {
            result= NO;
        }
    }
    
    
    return YES;
}

-(void)creatData:(NSString*)str
{
    if([self OpenDb])
    {
        
        const char *dbpath = [_databasePath UTF8String];
        sqlite3_stmt *statement;
        
        if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT id,name,phone from TAGDB where address=\"%@\"",str];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    
                    NSString *ID= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    NSString *name = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    
                    NSMutableDictionary *dictionary=[NSMutableDictionary dictionary];
                    
                    [dictionary setObject:ID forKey:name];
                    
                    
                    [_headArray addObject:dictionary];
                    [_NameArray addObject:name];
                    
                    
                }
                
                sqlite3_finalize(statement);
                
            }
            
            
            sqlite3_close(AttrcontactDB);
        }
        
    }
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
