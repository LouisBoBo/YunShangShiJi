//
//  LoginViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/9.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "LoginViewController.h"
#import "GlobalTool.h"
#import "SubmitViewController.h"
#import "FindPasswordViewController.h"
#import "PhoneRegistViewController.h"
#import "MymineViewController.h"
#import "ShopStoreViewController.h"
#import "MyTabBarController.h"
#import "AppDelegate.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "Tools.h"
#import "UserInfo.h"
#import "CommonCrypto/CommonDigest.h"


#import "MyMD5.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "KeyboardTool.h"
#import "NavgationbarView.h"
#import "SubmitViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/ISSQZoneApp.h>
#import "SubmitViewController.h"
#import "Animation.h"
#import "TFSalePurchaseViewController.h"
#import "UIImageView+WebCache.h"
#import "TFUserProtocolViewController.h"
#import "CollocationVC.h"
#import "TFHomeViewController.h"
#import "referenceViewController.h"
#import "AllCommentsViewController.h"
#import "TFOldPaymentViewController.h"

#import "HTTPTarbarNum.h"
#import "FMDBUserInfoManager.h"
#import "TFShoppingViewController.h"
#import <RongIMKit/RCIM.h>
#import "ShopCarManager.h"
#import "BoundPhoneVC.h"
#import "TFPopBackgroundView.h"

#import "OldUserLoginVC.h"
#import "NewUserBoundPhoneVC.h"
#import "GoldCouponsManager.h"
#import "GoldCouponModel.h"
#import "SearchTypeViewController.h"
#import "NewShoppingCartViewController.h"
#import "TFIntimateCircleVC.h"
#import "TopicPublicModel.h"

#define BF(w)  ((1.1)*((w)*(kScreenWidth)/320))



@interface LoginViewController ()<KeyboardToolDelegate>
@property (nonatomic, weak) UITextField *nowTextField;
@property (nonatomic, copy) NSString *openid;
@property (nonatomic, copy) NSString *unionid;

@property (nonatomic, strong) UIView *webCodeView;

@end

@implementation LoginViewController
{
    UIView *_bigview;
    UIView *newRegistView;    //最新手机注册界面
    UIView *oldRegistView;
    UIButton *_loginbtn;
    UIButton *_registbtn;
    CGFloat _otherLoginY;
    
    //邮箱输入
    UITextField *_Emailfild;

    UILabel *_navLabel;
    //登录呢称
    UITextField *_NameFild;
    //登录密码
    UITextField *_PassWordFild;
    //手机输入
    UITextField *_phonefild;
    //验证码输入
    UITextField *_yanzhengfild;
    UITextField *phoneCodeNum;
    //呢称输入
    UITextField *_namefild;
    //密码输入
    UITextField *_passwordfild;
    //获取验证码按钮
    UILabel *_yanzhengBtn;
    //服务器返回的验证码
    NSString *_codestr;
    
    //显示密码开关
    UISwitch *_lightswitch;
    
    //保存用户信息
    NSMutableArray *_userArray;
    //是否是邮箱
    BOOL EmailOK;
    //是否是手机号码
    BOOL isCorrect;
    
    //第三方登录类型
    NSString *usertype;
    
    NSMutableArray *_headArray;
    NSMutableArray *_NameArray;
    
    
    const char *_sql_stmt;
    
    NSString *_yanzhengcode;
    
    NavgationbarView *_mentionview;//提示框
    
    UIButton *logbtn;//登录按钮
    UIButton *registbtn;//手机注册按键
    UIButton *emailRigstbtn; //手机注册按钮
    UIButton *loginrigstbtn;//手机注册、手机注册切换按钮
    UIButton *phoneNextBtn;//下一步
    
    UIImageView *_logseeimage; //登录是否可看按钮
    BOOL _logissee;
    
    UIImageView *_phoneseeimage; //手机注册是否可看按钮
    BOOL _phoneissee;
    
    UIImageView *_emailseeimage; //邮箱注册是否可看按钮
    BOOL _emailissee;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //初始化为隐藏底栏-页面5个主页控制器设置为NO

    }
    return self;
}
-(void)dealloc{

    [self.countDownTimer invalidate];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidLoad {
    
    //loginViewcontroller");
    [super viewDidLoad];
    
    _mentionview = [[NavgationbarView alloc]init];
    
    //启动次数时间归0
    NSDate *date = [NSDate date];
    
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:NowDate];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",1] forKey:NumberCount];

    self.view.backgroundColor = RGBCOLOR_I(244, 245, 246);
    _userArray=[NSMutableArray array];
    _headArray=[NSMutableArray array];
    _NameArray=[NSMutableArray array];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [center addObserver:self selector:@selector(   keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    self.navigationController.navigationBar.hidden=YES;
    
    
   NSNumber *number = [[NSUserDefaults standardUserDefaults]objectForKey:USER_LoginType];
    if (number.integerValue==2) {
        [self creatHeadView];
        [self creatfootView];
    }else{
        [self setNavigationView];   // 登录流程修改（3.3.9）
        [self setMainView];
    }

    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouye:) name:@"shouye" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BindingPhoneSuccess) name:@"isOneBuy" object:nil];
    
    [self addChangeBaseURLGesture];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:RongCloub_Token];
    [ud removeObjectForKey:USER_HEADPIC];
    [ud removeObjectForKey:USER_REALM];
    [ud removeObjectForKey:USER_INFO];
    [ud removeObjectForKey:USER_PHONE];
    [ud removeObjectForKey:USER_NAME];
    [ud removeObjectForKey:USER_ADDRESS];
    [ud removeObjectForKey:USER_EMAIL];
    [ud removeObjectForKey:USER_PASSWORD];
    [ud removeObjectForKey:USER_TOKEN];
    [ud removeObjectForKey:USER_ARRER];
    [ud removeObjectForKey:USER_BIRTHDAY];
    [ud removeObjectForKey:USER_HOBBY];
    [ud removeObjectForKey:USER_ID];
    [ud removeObjectForKey:USER_TYPE];
    [ud removeObjectForKey:USER_VERSION];
    [ud removeObjectForKey:USER_QUESTION];
    [ud removeObjectForKey:USER_QUESTION];
    [ud removeObjectForKey:USER_MEMBER];
    [ud removeObjectForKey:CODE_TYPE];
    [ud removeObjectForKey:UNION_ID];
    [ud removeObjectForKey:USER_AllCount];
    [ud removeObjectForKey:USER_WX_HEADPIC];
    [ud removeObjectForKey:@"RedMoneyLeastNum"];
    [ud removeObjectForKey:isShowNoviceTaskView6];
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"RFTCart"];//用于刷新tabbar的购物车
    [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"TOPICMESSAGE"];//msg  消息计数
    [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"messageCountView"];//msg 消息计数条
    
    [ud synchronize];
    
    [Mtarbar hideBadgeOnItemIndex:0];
    [Mtarbar hideBadgeOnItemIndex:3];
    [Mtarbar hideBadgeOnItemIndex:4];
    Myview.hidden=YES;
    
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app removeNotification];
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_TOKEN];

    if([self.loginStatue isEqualToString:@"10030"])
    {
        MyLog(@"设备挤掉");
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud removeObjectForKey:USER_TOKEN];
//        [self createPopView];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
    [MBProgressHUD hideHUDForView:self.view];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark - +++++++++++++++++++++界面部分+++++++++++++++++++++
// 登录流程修改（3.3.9）
-(void)setNavigationView{
    UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, Height_NavBar-44, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];

    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2-90, Height_NavBar-40, 180, 30)];
    title.centerY = View_CenterY(headview);
    title.font = kNavTitleFontSize;
    title.textColor=kMainTitleColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.text=@"微信授权";
    [headview addSubview:title];
    
    UILabel *rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-ZOOM(42)-100, Height_NavBar-40, 100, 30)];
    rightLabel.centerY = View_CenterY(headview);
    rightLabel.text=@"老用户登录";
    rightLabel.font = [UIFont systemFontOfSize:ZOOM6(32)];
    rightLabel.textColor=RGBCOLOR_I(125, 125, 125);
    rightLabel.textAlignment = NSTextAlignmentRight;
    [headview addSubview:rightLabel];
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(kScreenWidth-ZOOM(42)-100, Height_NavBar-40, 100, 30);
    rightBtn.centerY = View_CenterY(headview);
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:rightBtn];
}

-(void)rightBtnClick{
    
//        TFOldPaymentViewController *view = [[TFOldPaymentViewController alloc] init];
//        view.headTitle = @"绑定手机";
//        view.leftStr = @"手机号码";
//        view.plaStr = @"输入您要绑定的手机号";
//        view.index = 1;
//    NewUserBoundPhoneVC *view=[[NewUserBoundPhoneVC alloc]init];
    
    OldUserLoginVC *view=[[OldUserLoginVC alloc]init];
    view.loginStatue=self.loginStatue;
    
    kSelfWeak;
    view.oldmyLoginBlock =^{
        if (weakSelf.myLoginBlock!=nil) {
            weakSelf.myLoginBlock();
        }
    };

    
//    [view returnClick:self.myLoginBlock withCloseBlock:self.myRegisterBlock];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)setMainView{
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, Height_NavBar+ZOOM6(80), kScreenWidth, 30)];
    title.font = [UIFont systemFontOfSize:ZOOM6(30)];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor=RGBCOLOR_I(125, 125, 125);
    title.text=@"微信授权登录，更安全，更方便";
    [self.view addSubview:title];
    
    UIImageView *WXImage=[[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-ZOOM6(130))/2, ZOOM6(80)+CGRectGetMaxY(title.frame), ZOOM6(130), ZOOM6(130))];
    WXImage.image=[UIImage imageNamed:@"微信授权图标"];
    [self.view addSubview:WXImage];
    
    UIButton *WXBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [WXBtn setBackgroundColor:RGBCOLOR_I(0, 199, 11)];
    [WXBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal|UIControlStateHighlighted];
    [WXBtn setTitle:@"微信授权" forState:UIControlStateNormal];
    WXBtn.frame=CGRectMake(ZOOM(42), ZOOM6(30)+CGRectGetMaxY(WXImage.frame), kScreenWidth-ZOOM(42)*2, ZOOM6(88));
    WXBtn.layer.cornerRadius=3;
    WXBtn.tag=2000;
    [WXBtn addTarget:self action:@selector(otherLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:WXBtn];
    
}
#pragma mark 导航条
-(void)creatHeadView
{
    CGFloat navbarHeight = Height_NavBar;
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, navbarHeight)];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, navbarHeight-52, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    _navLabel = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2-40, navbarHeight-44, 80, 30)];
    _navLabel.centerY = View_CenterY(headview);
    _navLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    _navLabel.textAlignment = NSTextAlignmentCenter;
    [headview addSubview:_navLabel];
    
    headview.userInteractionEnabled=YES;
    
    //邮箱注册、手机注册
    loginrigstbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    loginrigstbtn.frame=CGRectMake(kScreenWidth-ZOOM6(170), navbarHeight-44, ZOOM6(170), 30);
    loginrigstbtn.centerY = View_CenterY(headview);
    [loginrigstbtn setTitle:@"邮箱注册" forState:UIControlStateNormal];
    [loginrigstbtn addTarget:self action:@selector(EmailRegist:) forControlEvents:UIControlEventTouchUpInside];
    loginrigstbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    [loginrigstbtn setTitleColor:kTextGreyColor forState:UIControlStateNormal];
    loginrigstbtn.hidden = YES;
    loginrigstbtn.selected = NO;
    [self.view addSubview:loginrigstbtn];
    [loginrigstbtn bringSubviewToFront:self.view];
    
    
    if(self.tag==1000)
    {
        [self login];
    }
    if(self.tag==2000)
    {
        [self regist];
    }
    
}

#pragma mark 登录界面
-(void)login
{
    if (_loginbtn.selected == YES) {
        return;
    }
    _loginbtn.selected = YES;
    _registbtn.selected = NO;

    loginrigstbtn.hidden=YES;
    _navLabel.text = @"登录";
//    [_loginbtn setTintColor:[UIColor whiteColor]];
    [_loginbtn setBackgroundColor:tarbarrossred];

//    _registbtn.tintColor=tarbarrossred;
    _registbtn.layer.cornerRadius = 3;
    _registbtn.layer.borderColor = tarbarrossred.CGColor;
    _registbtn.layer.borderWidth = 1;
    [_registbtn setBackgroundColor:[UIColor whiteColor]];
    
    [_bigview removeFromSuperview];
    CGFloat navbarHeigh = Height_NavBar;
    _bigview=[[UIView alloc]initWithFrame:CGRectMake(0, navbarHeigh, kApplicationWidth, kApplicationHeight-(ZOOM6(128+kUnderStatusBarStartY))-navbarHeigh)];
    _bigview.backgroundColor = RGBCOLOR_I(244, 245, 246);
    
    [self creatLoginView];
    [self.view addSubview:_bigview];
}
#pragma mark 注册界面
-(void)regist
{

    if (_registbtn.selected == YES) {
        return;
    }
    _registbtn.selected = YES;
    _loginbtn.selected = NO;


    loginrigstbtn.hidden=NO;
    loginrigstbtn.selected = NO;
    
    _navLabel.text = @"手机注册";
//    [_registbtn setTintColor:[UIColor whiteColor]];
    [_registbtn setBackgroundColor:tarbarrossred];
    
//    _loginbtn.tintColor=tarbarrossred;
    _loginbtn.layer.cornerRadius = 3;
    _loginbtn.layer.borderColor = tarbarrossred.CGColor;
    _loginbtn.layer.borderWidth = 1;
    [_loginbtn setBackgroundColor:[UIColor whiteColor]];
    
    [_bigview removeFromSuperview];
    CGFloat navbarHeigh = Height_NavBar;
    _bigview=[[UIView alloc]initWithFrame:CGRectMake(0, navbarHeigh, kApplicationWidth, kApplicationHeight-(ZOOM6(128+kUnderStatusBarStartY))-navbarHeigh)];
    _bigview.backgroundColor = RGBCOLOR_I(244, 245, 246);
    
//    [self creatregistView];
    [self phoneReistNewView];
    [self.view addSubview:_bigview];
}

#pragma mark 登录界面
-(void)creatLoginView
{
    //呢称
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0,ZOOM6(50), kScreenWidth, ZOOM6(200))];
    backview.backgroundColor = [UIColor whiteColor];
    backview.userInteractionEnabled=YES;
    
    _NameFild=[[UITextField alloc]initWithFrame:CGRectMake(ZOOM6(30), ZOOM6(20), backview.frame.size.width-ZOOM6(30)*2, ZOOM6(60))];
    _NameFild.delegate = self;
//    _NameFild.keyboardType = UIKeyboardTypeURL;
    _NameFild.clearButtonMode = UITextFieldViewModeWhileEditing;
    _NameFild.placeholder=@"手机号";
    _NameFild.font = [UIFont systemFontOfSize:ZOOM6(30)];
    _NameFild.textColor = RGBCOLOR_I(62, 62, 62);
    [_NameFild addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [backview addSubview:_NameFild];
    
    
    _PassWordFild=[[UITextField alloc]initWithFrame:CGRectMake(ZOOM6(30), ZOOM6(120), backview.frame.size.width-2*ZOOM6(30)-ZOOM6(50), ZOOM6(60))];
    _PassWordFild.delegate = self;
    _PassWordFild.clearButtonMode = UITextFieldViewModeWhileEditing;
    _PassWordFild.placeholder=@"密码";
    _PassWordFild.font = [UIFont systemFontOfSize:ZOOM6(30)];
    _PassWordFild.secureTextEntry=YES;
    _PassWordFild.textColor = RGBCOLOR_I(62, 62, 62);
    [_PassWordFild addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [backview addSubview:_PassWordFild];
    
    
    UILabel *lableline1=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(30), ZOOM6(100), CGRectGetWidth(backview.frame)-2*ZOOM6(30), 1)];
    lableline1.backgroundColor=kBackgroundColor;
    [backview addSubview:lableline1];
    
    _logseeimage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-ZOOM6(80), CGRectGetMaxY(lableline1.frame)+ZOOM6(25), ZOOM6(50), ZOOM6(50))];
    _logseeimage.userInteractionEnabled = YES;
    _logseeimage.image = [UIImage imageNamed:@"Communal_sgin_yanjing_icon_default"];
    _logissee = NO;
    [backview addSubview:_logseeimage];
    
    UITapGestureRecognizer *seetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(see)];
    [_logseeimage addGestureRecognizer:seetap];
    
    //登录
    logbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    logbtn.frame=CGRectMake(ZOOM6(30), CGRectGetMaxY(backview.frame)+ZOOM6(50), kApplicationWidth-2 *ZOOM6(30), ZOOM6(88));
    [logbtn setBackgroundColor:RGBCOLOR_I(185, 186, 187)];
    logbtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(50)];
    [logbtn setTitle:@"登录" forState:UIControlStateNormal];
    logbtn.tintColor=[UIColor whiteColor];
    logbtn.layer.cornerRadius = 3;
    [logbtn addTarget:self action:@selector(loginclick:) forControlEvents:UIControlEventTouchUpInside];
    
    //忘记密码
    UIButton *losspassbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    losspassbtn.frame=CGRectMake(kScreenWidth-ZOOM6(180),CGRectGetMaxY(logbtn.frame)+ZOOM6(30), ZOOM6(150), 20);
    [losspassbtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    losspassbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    [losspassbtn addTarget:self action:@selector(losspassword:) forControlEvents:UIControlEventTouchUpInside];
    losspassbtn.tintColor=RGBCOLOR_I(125, 125, 125);
    
    
    _otherLoginY=280;
    //第三方登录
    [self creatOtherLogin];
    
    [_bigview addSubview:backview];
    [_bigview addSubview:logbtn];
    [_bigview addSubview:losspassbtn];
    
    
    KeyboardTool *tool = [KeyboardTool keyboardTool];
    tool.delegate = self;
    tool.frame=CGRectMake(0, tool.frame.origin .y, kScreenWidth, 40);
    _NameFild.inputAccessoryView = tool;
    _PassWordFild.inputAccessoryView = tool;
    
}


#pragma mark 手机注册界面

- (void)phoneReistNewView {

    newRegistView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(50)+ZOOM6(300)+ZOOM6(50+88+30)+15)];
    [_bigview addSubview:newRegistView];

    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, ZOOM6(50), kScreenWidth, ZOOM6(200))];
    backview.backgroundColor = [UIColor whiteColor];
    [newRegistView addSubview:backview];

    CGFloat Width = ZOOM6(30);
    CGFloat heigh = ZOOM6(100);
    CGFloat space = ZOOM6(20);

    for(int i=0;i<2;i++)
    {
        UILabel *lableline=[[UILabel alloc]initWithFrame:CGRectMake(Width,heigh*(i+1), kApplicationWidth-2 *Width, 1)];
        lableline.backgroundColor=kBackgroundColor;
        [backview addSubview:lableline];

        if(i==0)
        {
            _phonefild=[[UITextField alloc]initWithFrame:CGRectMake(Width, space+heigh*i, kApplicationWidth- 2*Width, ZOOM6(60))];
            _phonefild.placeholder=@"请输入手机号";
            _phonefild.keyboardType = UIKeyboardTypeNumberPad;
            _phonefild.font = [UIFont systemFontOfSize:ZOOM6(30)];
            _phonefild.clearButtonMode = UITextFieldViewModeWhileEditing;
            _phonefild.userInteractionEnabled=YES;
            _phonefild.delegate = self;
            _phonefild.textColor = RGBCOLOR_I(62, 62, 62);
            [_phonefild addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [backview addSubview:_phonefild];

        }else if (i==1)
        {
            phoneCodeNum=[[UITextField alloc]initWithFrame:CGRectMake(Width, space+heigh*i, kApplicationWidth-2*Width-120, ZOOM6(60))];
            phoneCodeNum.userInteractionEnabled=YES;
            phoneCodeNum.placeholder=@"请输入验证码";
//            phoneCodeNum.keyboardType = UIKeyboardTypeNumberPad;
            phoneCodeNum.clearButtonMode = UITextFieldViewModeWhileEditing;
            phoneCodeNum.font = [UIFont systemFontOfSize:ZOOM6(30)];
            phoneCodeNum.delegate = self;
            phoneCodeNum.textColor = RGBCOLOR_I(62, 62, 62);
            [phoneCodeNum addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            UILabel *labline = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(backview.frame)-ZOOM6(35)-ZOOM6(255), space+heigh*i, 1, ZOOM6(60))];
            labline.backgroundColor=kBackgroundColor;

            //验证码图片
//            self.phoneCodeView = [[PooCodeView alloc] initWithFrame:CGRectMake(kApplicationWidth-ZOOM6(30)-100 , space+heigh*i, 100, ZOOM6(60))];
//            self.phoneCodeView.layer.cornerRadius = CGRectGetHeight(self.phoneCodeView.frame)/2;

            self.webCodeView = [[UIView alloc]initWithFrame:CGRectMake(kApplicationWidth-ZOOM6(30)-ZOOM6(250) , space+heigh*i, ZOOM6(250), ZOOM6(60))];
            [backview addSubview:self.webCodeView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(httpGetCodeView)];
            [self.webCodeView addGestureRecognizer:tap];

            [backview addSubview:labline];
            [backview addSubview:phoneCodeNum];
//            [backview addSubview:self.phoneCodeView];

        }
    }

    phoneNextBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    phoneNextBtn.frame=CGRectMake(ZOOM(30),CGRectGetMaxY(backview.frame)+ZOOM6(100)+ZOOM6(50), kApplicationWidth-2 *ZOOM(30), ZOOM6(88));
    [phoneNextBtn setBackgroundColor:RGBCOLOR_I(196, 197, 198)];
    [phoneNextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    phoneNextBtn.tintColor=[UIColor whiteColor];
    phoneNextBtn.layer.cornerRadius = 3;
    //    emailRigstbtn.enabled = NO;
    phoneNextBtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(50)];
    [phoneNextBtn addTarget:self action:@selector(phoneNextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [newRegistView addSubview:phoneNextBtn];

    /*
    if(kApplicationHeight > 480) {
        _otherLoginY = CGRectGetMaxY(newRegistView.frame)+ZOOM(100);
    }else{
        _otherLoginY=310;
    }

    //第三方登录
    [self creatOtherLogin];
    */
}

- (void)httpGetCodeView {

    NSString *IMEI = [[NSUserDefaults standardUserDefaults] objectForKey:USER_UUID];
    NSString *url = [NSString stringWithFormat:@"%@vcode/getVcode?version=%@&phone=%@&imei=%@",[NSObject baseURLStr],VERSION,_phonefild.text,IMEI];
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

-(void)creatregistView
{
    oldRegistView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, ZOOM6(50)+ZOOM6(300)+ZOOM6(50+88+30)+15)];
//    oldRegistView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.7];
    [_bigview addSubview:oldRegistView];

    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, ZOOM6(50), kScreenWidth, ZOOM6(200))];
    backview.backgroundColor = [UIColor whiteColor];
    [oldRegistView addSubview:backview];
    
    CGFloat Width = ZOOM6(30);
    CGFloat heigh = ZOOM6(100);
    CGFloat space = ZOOM6(20);
    for(int i=0;i<2;i++)
    {
        
        UILabel *lableline=[[UILabel alloc]initWithFrame:CGRectMake(Width,heigh*(i+1), kApplicationWidth-2 *Width, 1)];
        lableline.backgroundColor=kBackgroundColor;
        [backview addSubview:lableline];

        if (i==0)
        {
            
            _yanzhengfild=[[UITextField alloc]initWithFrame:CGRectMake(Width, space+heigh*i, kApplicationWidth- 2 *Width-120, ZOOM6(60))];
            _yanzhengfild.placeholder=@"请输入验证码";
            _yanzhengfild.keyboardType = UIKeyboardTypeNumberPad;
            _yanzhengfild.font = [UIFont systemFontOfSize:ZOOM6(30)];
            _yanzhengfild.clearButtonMode = UITextFieldViewModeWhileEditing;
            _yanzhengfild.delegate = self;
            _yanzhengfild.userInteractionEnabled=YES;
            _yanzhengfild.secureTextEntry=NO;
            _yanzhengfild.textColor = RGBCOLOR_I(62, 62, 62);
            [_yanzhengfild addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            UILabel *labline = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(backview.frame)-ZOOM6(35)-110, space+heigh*i, 1, ZOOM6(60))];
            labline.backgroundColor=kBackgroundColor;
            
            _yanzhengBtn = [[UILabel alloc]init];
            _yanzhengBtn.frame=CGRectMake(CGRectGetWidth(backview.frame)-ZOOM6(30)-110, space+heigh*i, 110, ZOOM6(60));
            _yanzhengBtn.text = @"获取验证码";
            _yanzhengBtn.font = [UIFont systemFontOfSize:ZOOM6(30)];
            _yanzhengBtn.textAlignment = NSTextAlignmentCenter;
            _yanzhengBtn.textColor=tarbarrossred;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yanzheng:)];
            [_yanzhengBtn addGestureRecognizer:tap];
            _yanzhengBtn.userInteractionEnabled = YES;
            _yanzhengBtn.layer.masksToBounds=YES;
            
            [backview addSubview:_yanzhengfild];
            [backview addSubview:_yanzhengBtn];
            [backview addSubview:labline];
            
        }else if (i==1)
        {
            _passwordfild=[[UITextField alloc]initWithFrame:CGRectMake(Width, space+heigh*i, kApplicationWidth-2*Width-ZOOM6(50), ZOOM6(60))];
            _passwordfild.placeholder=@"请设置密码";
            _passwordfild.font = [UIFont systemFontOfSize:ZOOM6(30)];
            _passwordfild.clearButtonMode = UITextFieldViewModeWhileEditing;
            _passwordfild.delegate = self;
            _passwordfild.userInteractionEnabled=YES;
            _passwordfild.secureTextEntry=YES;
            _passwordfild.textColor = RGBCOLOR_I(62, 62, 62);
            [_passwordfild addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            [backview addSubview:_passwordfild];
            
            
            _phoneseeimage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(backview.frame)-ZOOM6(50)-ZOOM6(30), ZOOM6(25)+heigh*i, ZOOM6(50), ZOOM6(50))];
            _phoneseeimage.userInteractionEnabled = YES;
            _phoneseeimage.image = [UIImage imageNamed:@"Communal_sgin_yanjing_icon_default"];
            _phoneissee = NO;
            [backview addSubview:_phoneseeimage];
            
            UITapGestureRecognizer *seetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(see1)];
            [_phoneseeimage addGestureRecognizer:seetap];

        }

    }

    //完成注册
    registbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    registbtn.frame=CGRectMake(ZOOM(30), CGRectGetMaxY(backview.frame)+ZOOM6(100)+ZOOM6(50), kApplicationWidth-2 *ZOOM(30), ZOOM6(88));
    [registbtn setBackgroundColor:RGBCOLOR_I(196, 197, 198)];
    [registbtn setTitle:@"完成注册" forState:UIControlStateNormal];
    registbtn.tintColor=[UIColor whiteColor];
    registbtn.layer.cornerRadius = 3;
    //    registbtn.enabled=NO;
    registbtn.titleLabel.font= [UIFont systemFontOfSize:ZOOM(50)];
    [registbtn addTarget:self action:@selector(finishclick:) forControlEvents:UIControlEventTouchUpInside];
    [oldRegistView addSubview:registbtn];
    
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(30), CGRectGetMaxY(registbtn.frame)+ZOOM6(30), kScreenWidth - 2*ZOOM(30), 15)];
    lable.text=@"*注册即代表同意《衣蝠服务协议》";
    lable.textColor=tarbarrossred;
    lable.font=[UIFont systemFontOfSize:ZOOM6(28)];
    
    lable.userInteractionEnabled = YES;
    
    NSMutableAttributedString *noteStr ;
    
    noteStr = [[NSMutableAttributedString alloc]initWithString:lable.text];
    
    [noteStr addAttribute:NSForegroundColorAttributeName value:RGBCOLOR_I(168, 168, 168) range:NSMakeRange(0, 8)];
    [lable setAttributedText:noteStr];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xieyiclick:)];
    [lable addGestureRecognizer:tap];
    lable.userInteractionEnabled=YES;
    [oldRegistView addSubview:lable];
    

    KeyboardTool *tool = [KeyboardTool keyboardTool];
    tool.delegate = self;
    tool.frame=CGRectMake(0, tool.frame.origin.y, kScreenWidth, 40);
    _phonefild.inputAccessoryView = tool;
    _yanzhengfild.inputAccessoryView = tool;
    _namefild.inputAccessoryView=tool;
    _passwordfild.inputAccessoryView=tool;
    
//
//    if(kApplicationHeight > 480)
//    {
//        _otherLoginY = CGRectGetMaxY(lable.frame)+ZOOM(100);
//
//    }else{
//
//        _otherLoginY=310;
//    }
//
//    //第三方登录
//    [self creatOtherLogin];

}

#pragma mark  邮箱注册界面
-(void)createmailView
{
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, ZOOM6(50), kScreenWidth, ZOOM6(300))];
    backview.backgroundColor = [UIColor whiteColor];
    [_bigview addSubview:backview];
    
    CGFloat Width = ZOOM6(30);
    CGFloat heigh = ZOOM6(100);
    CGFloat space = ZOOM6(20);
    
    for(int i=0;i<3;i++)
    {
        UILabel *lableline=[[UILabel alloc]initWithFrame:CGRectMake(Width,heigh*(i+1), kApplicationWidth-2 *Width, 1)];
        lableline.backgroundColor=kBackgroundColor;
        [backview addSubview:lableline];
        
        if(i==0)
        {
            _Emailfild=[[UITextField alloc]initWithFrame:CGRectMake(Width, space+heigh*i, kApplicationWidth- 2*Width, ZOOM6(60))];
            _Emailfild.placeholder=@"请输入邮箱";
            _Emailfild.font = [UIFont systemFontOfSize:ZOOM6(30)];
            _Emailfild.keyboardType = UIKeyboardTypeEmailAddress;
            _Emailfild.clearButtonMode = UITextFieldViewModeWhileEditing;
            _Emailfild.userInteractionEnabled=YES;
            _Emailfild.delegate = self;
            _Emailfild.textColor = RGBCOLOR_I(62, 62, 62);
            [_Emailfild addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [backview addSubview:_Emailfild];
            
        }else if (i==1)
        {
            _yanzhengfild=[[UITextField alloc]initWithFrame:CGRectMake(Width, space+heigh*i, kApplicationWidth-2*Width-120, ZOOM6(60))];
            _yanzhengfild.userInteractionEnabled=YES;
            _yanzhengfild.placeholder=@"请输入验证码";
            _yanzhengfild.keyboardType = UIKeyboardTypeNumberPad;
            _yanzhengfild.clearButtonMode = UITextFieldViewModeWhileEditing;
            _yanzhengfild.font = [UIFont systemFontOfSize:ZOOM6(30)];
            _yanzhengfild.delegate = self;
            _yanzhengfild.textColor = RGBCOLOR_I(62, 62, 62);
            [_yanzhengfild addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            UILabel *labline = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(backview.frame)-ZOOM6(35)-110, space+heigh*i, 1, ZOOM6(60))];
            labline.backgroundColor=kBackgroundColor;
            
            //验证码图片
            self.codeView = [[PooCodeView alloc] initWithFrame:CGRectMake(kApplicationWidth-ZOOM6(30)-100 , space+heigh*i, 100, ZOOM6(60))];
            self.codeView.layer.cornerRadius = CGRectGetHeight(self.codeView.frame)/2;
            
            [backview addSubview:labline];
            [backview addSubview:_yanzhengfild];
            [backview addSubview:self.codeView];
            
            
        }else if (i==2)
        {
//            _namefild=[[UITextField alloc]initWithFrame:CGRectMake(Width, space+heigh*i, kApplicationWidth-2 *Width, ZOOM6(60))];
//            _namefild.userInteractionEnabled=YES;
//            _namefild.placeholder=@"请输入昵称";
//            _namefild.clearButtonMode = UITextFieldViewModeWhileEditing;
//            _namefild.font = [UIFont systemFontOfSize:ZOOM6(30)];
//            _namefild.delegate = self;
//            _namefild.textColor = RGBCOLOR_I(62, 62, 62);
//            [_namefild addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//            [backview addSubview:_namefild];
            
            _passwordfild=[[UITextField alloc]initWithFrame:CGRectMake(Width, space+heigh*i, kApplicationWidth- 2*Width-ZOOM6(50), ZOOM6(60))];
            _passwordfild.userInteractionEnabled=YES;
            _passwordfild.placeholder=@"请设置密码";
            _passwordfild.clearButtonMode = UITextFieldViewModeWhileEditing;
            _passwordfild.font = [UIFont systemFontOfSize:ZOOM6(30)];
            _passwordfild.secureTextEntry=YES;
            _passwordfild.delegate = self;
            _passwordfild.textColor = RGBCOLOR_I(62, 62, 62);
            [_passwordfild addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [backview addSubview:_passwordfild];
            
            _emailseeimage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(backview.frame)-ZOOM6(50)-ZOOM6(30), ZOOM6(25)+heigh*i, ZOOM6(50), ZOOM6(50))];
            _emailseeimage.userInteractionEnabled = YES;
            _emailseeimage.image = [UIImage imageNamed:@"Communal_sgin_yanjing_icon_default"];
            _emailissee = NO;
            [backview addSubview:_emailseeimage];
            
            UITapGestureRecognizer *seetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(see2)];
            [_emailseeimage addGestureRecognizer:seetap];

        }
//        else{
//            _passwordfild=[[UITextField alloc]initWithFrame:CGRectMake(Width, space+heigh*i, kApplicationWidth- 2*Width-ZOOM6(50), ZOOM6(60))];
//            _passwordfild.userInteractionEnabled=YES;
//            _passwordfild.placeholder=@"请设置密码";
//            _passwordfild.clearButtonMode = UITextFieldViewModeWhileEditing;
//            _passwordfild.font = [UIFont systemFontOfSize:ZOOM6(30)];
//            _passwordfild.secureTextEntry=YES;
//            _passwordfild.delegate = self;
//            _passwordfild.textColor = RGBCOLOR_I(62, 62, 62);
//            [_passwordfild addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//            [backview addSubview:_passwordfild];
//            
//            _emailseeimage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(backview.frame)-ZOOM6(50)-ZOOM6(30), ZOOM6(25)+heigh*i, ZOOM6(50), ZOOM6(50))];
//            _emailseeimage.userInteractionEnabled = YES;
//            _emailseeimage.image = [UIImage imageNamed:@"Communal_sgin_yanjing_icon_default"];
//            _emailissee = NO;
//            [backview addSubview:_emailseeimage];
//            
//            UITapGestureRecognizer *seetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(see2)];
//            [_emailseeimage addGestureRecognizer:seetap];
//            
//        }
    }
    
    CGFloat topheigh;
    CGFloat spaceheigh;
    if(kApplicationHeight > 480)
    {
        topheigh =ZOOM(100);   spaceheigh =ZOOM(30);
    }else{
        topheigh =ZOOM(50);   spaceheigh =5;
    }
    
    //完成注册
    emailRigstbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    emailRigstbtn.frame=CGRectMake(ZOOM(30),CGRectGetMaxY(backview.frame)+ZOOM6(50), kApplicationWidth-2 *ZOOM(30), ZOOM6(88));
    [emailRigstbtn setBackgroundColor:RGBCOLOR_I(196, 197, 198)];
    [emailRigstbtn setTitle:@"完成注册" forState:UIControlStateNormal];
    emailRigstbtn.tintColor=[UIColor whiteColor];
    emailRigstbtn.layer.cornerRadius = 3;
    //    emailRigstbtn.enabled = NO;
    emailRigstbtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(50)];
    [emailRigstbtn addTarget:self action:@selector(mailBoxFinish:) forControlEvents:UIControlEventTouchUpInside];
    [_bigview addSubview:emailRigstbtn];
    
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(30), CGRectGetMaxY(emailRigstbtn.frame)+ZOOM6(30), kScreenWidth - 2*ZOOM(30), 15)];
    lable.text=@"*注册即代表同意《衣蝠服务协议》";
    lable.textColor=tarbarrossred;
    lable.font=[UIFont systemFontOfSize:ZOOM6(28)];
    lable.userInteractionEnabled = YES;
    
    NSMutableAttributedString *noteStr ;
    noteStr = [[NSMutableAttributedString alloc]initWithString:lable.text];
    [noteStr addAttribute:NSForegroundColorAttributeName value:kTextColor range:NSMakeRange(0, 8)];
    [lable setAttributedText:noteStr];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xieyiclick:)];
    [lable addGestureRecognizer:tap];
    lable.userInteractionEnabled=YES;
    
    [_bigview addSubview:lable];
    
    
    KeyboardTool *tool = [KeyboardTool keyboardTool];
    tool.delegate = self;
    tool.frame=CGRectMake(0, tool.frame.origin.y, kScreenWidth, 40);
    _Emailfild.inputAccessoryView = tool;
    _namefild.inputAccessoryView = tool;
    _passwordfild.inputAccessoryView=tool;
    _yanzhengfild.inputAccessoryView=tool;

    /*
    _otherLoginY=375;
    //第三方登录
    [self creatOtherLogin];
    */
}

#pragma mark 第三方登录界面
-(void)creatOtherLogin
{
    UILabel *lableline=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(_bigview.frame)-ZOOM6(250), kApplicationWidth, 1)];
    lableline.backgroundColor=RGBCOLOR_I(196, 197, 198);
    [_bigview addSubview:lableline];
    
    //提示
    UILabel *labl=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(100), CGRectGetMaxY(lableline.frame)-10, kScreenWidth-2*ZOOM6(100), 20)];
    labl.backgroundColor = RGBCOLOR_I(244, 245, 246);
    labl.text=@"使用第三方帐号登录，3秒完成注册";
    labl.textColor=RGBCOLOR_I(125, 125, 125);
    labl.textAlignment = NSTextAlignmentCenter;
    labl.font=[UIFont systemFontOfSize:ZOOM6(28)];
    [_bigview addSubview:labl];
    
    NSMutableAttributedString *noteStr ;
    if(labl.text)
    {
        noteStr = [[NSMutableAttributedString alloc]initWithString:labl.text];
    }
    NSString *ss = @"使用第三方帐号登录，";
    NSString *str = @"3秒完成注册";
    
    [noteStr addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(ss.length, str.length)];
    
    [labl setAttributedText:noteStr];
    
    
    CGFloat height= 0;
    
    BOOL qqBl = NO;
    BOOL wxBl = NO;
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        wxBl = YES;
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
    {
        qqBl = YES;
    }
    
    
    CGFloat WH_btn = kApplicationWidth/6.5;
    
    if (wxBl==YES) {
        UIButton *otherLoginbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        otherLoginbtn.frame = CGRectMake(kApplicationWidth*0.5-WH_btn*0.5, lableline.frame.origin.y+35+height, WH_btn, WH_btn);
        [otherLoginbtn setBackgroundImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
        otherLoginbtn.tag=2000;
        [otherLoginbtn addTarget:self action:@selector(otherLogin:) forControlEvents:UIControlEventTouchUpInside];
        otherLoginbtn.layer.cornerRadius=kApplicationWidth/13;
        
        [_bigview addSubview:otherLoginbtn];
        
        UILabel *namelab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(otherLoginbtn.frame), CGRectGetMaxY(otherLoginbtn.frame)+ZOOM6(20), WH_btn, ZOOM6(24))];
        namelab.text = @"微信登录";
        namelab.textAlignment = NSTextAlignmentCenter;
        namelab.font = [UIFont systemFontOfSize:ZOOM6(24)];
        namelab.textColor = RGBCOLOR_I(125, 125, 125);
        [_bigview addSubview:namelab];
    }
    
    /*
    if (qqBl&&wxBl) {
        CGFloat zoom = (kApplicationWidth-2*ZOOM(60));
        for(int i=0;i<3;i++)
        {
            UIButton *otherLoginbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            otherLoginbtn.frame=CGRectMake(0, lableline.frame.origin.y+35+height, WH_btn, WH_btn);
            otherLoginbtn.center = CGPointMake(ZOOM(60)+zoom/6+i*(zoom/3), lableline.frame.origin.y+kApplicationWidth/12+height+30);
            otherLoginbtn.layer.cornerRadius=kApplicationWidth/13;
            
            UILabel *namelab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(otherLoginbtn.frame), CGRectGetMaxY(otherLoginbtn.frame)+ZOOM6(20), WH_btn, ZOOM6(24))];
            
            namelab.textAlignment = NSTextAlignmentCenter;
            namelab.font = [UIFont systemFontOfSize:ZOOM6(24)];
            namelab.textColor = RGBCOLOR_I(125, 125, 125);
            [_bigview addSubview:namelab];
            
            
            if(i==0)
            {
                [otherLoginbtn setBackgroundImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
                otherLoginbtn.tag=2000;
                namelab.text = @"微信登录";
            }
            if(i==1)
            {
                [otherLoginbtn setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
                otherLoginbtn.tag=1000;
                namelab.text = @"QQ登录";
            }
            if(i==2)
            {
                [otherLoginbtn setBackgroundImage:[UIImage imageNamed:@"微博"] forState:UIControlStateNormal];
                otherLoginbtn.tag=3000;
                namelab.text = @"微博登录";
            }
            [otherLoginbtn addTarget:self action:@selector(otherLogin:) forControlEvents:UIControlEventTouchUpInside];
            
            [_bigview addSubview:otherLoginbtn];
            [_bigview addSubview:namelab];
        }
    }
    else if (qqBl == YES&&wxBl == NO) {
        
        CGFloat lr_margin = ZOOM(120)*0.5;
        
        for(int i=0;i<2;i++)
        {
            UIButton *otherLoginbtn=[UIButton buttonWithType:UIButtonTypeCustom];
            
            UILabel *namelab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(otherLoginbtn.frame), CGRectGetMaxY(otherLoginbtn.frame)+ZOOM6(20), WH_btn, ZOOM6(24))];
            
            namelab.textAlignment = NSTextAlignmentCenter;
            namelab.font = [UIFont systemFontOfSize:ZOOM6(24)];
            namelab.textColor = RGBCOLOR_I(125, 125, 125);
            [_bigview addSubview:namelab];
            
            if(i==0)
            {
                otherLoginbtn.frame = CGRectMake(kApplicationWidth*0.5-WH_btn-lr_margin, lableline.frame.origin.y+35+height, WH_btn, WH_btn);
                [otherLoginbtn setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
                otherLoginbtn.tag=1000;
                namelab.text = @"QQ登录";
            }
            if(i==1)
            {
                otherLoginbtn.frame = CGRectMake(kApplicationWidth*0.5+lr_margin, lableline.frame.origin.y+35+height, WH_btn, WH_btn);
                [otherLoginbtn setBackgroundImage:[UIImage imageNamed:@"微博"] forState:UIControlStateNormal];
                otherLoginbtn.tag=3000;
                namelab.text = @"微博登录";
            }
            [otherLoginbtn addTarget:self action:@selector(otherLogin:) forControlEvents:UIControlEventTouchUpInside];
            otherLoginbtn.layer.cornerRadius=kApplicationWidth/13;
            
            [_bigview addSubview:otherLoginbtn];
        }
    }
    else if (qqBl == NO&&wxBl == YES) {
        
        CGFloat lr_margin = ZOOM(120)*0.5;
        
        for(int i=0;i<2;i++)
        {
            UIButton *otherLoginbtn=[UIButton buttonWithType:UIButtonTypeCustom];
            
            UILabel *namelab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(otherLoginbtn.frame), CGRectGetMaxY(otherLoginbtn.frame)+ZOOM6(20), WH_btn, ZOOM6(24))];
            
            namelab.textAlignment = NSTextAlignmentCenter;
            namelab.font = [UIFont systemFontOfSize:ZOOM6(24)];
            namelab.textColor = RGBCOLOR_I(125, 125, 125);
            [_bigview addSubview:namelab];
            
            if(i==0)
            {
                otherLoginbtn.frame = CGRectMake(kApplicationWidth*0.5-WH_btn-lr_margin, lableline.frame.origin.y+35+height, WH_btn, WH_btn);
                [otherLoginbtn setBackgroundImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
                otherLoginbtn.tag=2000;
                namelab.text = @"微信登录";
            }
            if(i==1)
            {
                otherLoginbtn.frame = CGRectMake(kApplicationWidth*0.5+lr_margin, lableline.frame.origin.y+35+height, WH_btn, WH_btn);
                [otherLoginbtn setBackgroundImage:[UIImage imageNamed:@"微博"] forState:UIControlStateNormal];
                otherLoginbtn.tag=3000;
                namelab.text = @"微博登录";
                
            }
            [otherLoginbtn addTarget:self action:@selector(otherLogin:) forControlEvents:UIControlEventTouchUpInside];
            otherLoginbtn.layer.cornerRadius=kApplicationWidth/13;
            
            [_bigview addSubview:otherLoginbtn];
            
        }
    }
    else if (qqBl == NO&&wxBl == NO) {
        
        UIButton *otherLoginbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        otherLoginbtn.frame = CGRectMake(kApplicationWidth*0.5-WH_btn*0.5, lableline.frame.origin.y+35+height, WH_btn, WH_btn);
        [otherLoginbtn setBackgroundImage:[UIImage imageNamed:@"微博"] forState:UIControlStateNormal];
        otherLoginbtn.tag=3000;
        [otherLoginbtn addTarget:self action:@selector(otherLogin:) forControlEvents:UIControlEventTouchUpInside];
        otherLoginbtn.layer.cornerRadius=kApplicationWidth/13;
        
        [_bigview addSubview:otherLoginbtn];
        
        UILabel *namelab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(otherLoginbtn.frame), CGRectGetMaxY(otherLoginbtn.frame)+ZOOM6(20), WH_btn, ZOOM6(24))];
        namelab.text = @"微博登录";
        namelab.textAlignment = NSTextAlignmentCenter;
        namelab.font = [UIFont systemFontOfSize:ZOOM6(24)];
        namelab.textColor = RGBCOLOR_I(125, 125, 125);
        [_bigview addSubview:namelab];
    }
    */
}

#pragma mark 脚底视图
-(void)creatfootView
{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-ZOOM(128), kApplicationWidth, ZOOM(128)+kUnderStatusBarStartY)];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    
    CGFloat btnwith = (kScreenWidth-3*ZOOM6(30))/2;
    CGFloat btnHeigh = ZOOM6(88);
    
    _loginbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _loginbtn.frame=CGRectMake(ZOOM6(30), (CGRectGetHeight(footView.frame)-btnHeigh)/2, btnwith, btnHeigh);
    [_loginbtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginbtn setTitle:@"登录" forState:UIControlStateSelected];
    [_loginbtn setTitleColor:tarbarrossred forState:UIControlStateNormal];
    [_loginbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    _loginbtn.selected = YES;
//    [_loginbtn setTintColor:[UIColor whiteColor]];
    [_loginbtn setBackgroundColor:tarbarrossred];
    _loginbtn.layer.cornerRadius = 3;
    
    _loginbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(51)];
    
    [_loginbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:_loginbtn];
    
    _registbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _registbtn.frame=CGRectMake(ZOOM6(60)+btnwith, CGRectGetMinY(_loginbtn.frame), btnwith, btnHeigh);
    [_registbtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registbtn setTitle:@"注册" forState:UIControlStateSelected];
    [_registbtn setTitleColor:tarbarrossred forState:UIControlStateNormal];
    [_registbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    _registbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(51)];
//    _registbtn.tintColor=tarbarrossred;
    _registbtn.layer.cornerRadius = 3;
    _registbtn.layer.borderColor = tarbarrossred.CGColor;
    _registbtn.layer.borderWidth = 1;
    
    [_registbtn addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:_registbtn];
    
}

#pragma mark 在别出登录提示框
-(void)createPopView
{
    UIAlertView *altetview = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您已在别处登录~~请重新登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [altetview show];
}


#pragma mark - +++++++++++++++++++++按钮点击事件+++++++++++++++++++++
- (void)phoneNextBtnClick:(UIButton *)sender {
    [self.view endEditing:YES];

    //判读手机号码
    _phonefild.text = [_phonefild.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    NSString *phoneStr = _phonefild.text;

    if (phoneStr.length == 0) {
        [_mentionview showLable:@"亲，手机号不能空" Controller:self];
        return;
    }else {
        BOOL isCorrect = [self isValidateMobile:phoneStr];
        if (isCorrect) {//是手机号码");
        }else {//不是手机号码");
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"请输入正确手机号码" Controller:self];
            return;
        }
    }
    if (phoneCodeNum.text.length==0) {
        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        [mentionview showLable:@"请输入图片验证码" Controller:self];
        return;
    }
    /*
    if(phoneCodeNum.text.length!=0 && [phoneCodeNum.text compare:self.phoneCodeView.changeString
                                                           options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame)
    {

    }
    else
    {
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20, @20, @-20];
        [self.phoneCodeView.layer addAnimation:anim forKey:nil];
        [phoneCodeNum.layer addAnimation:anim forKey:nil];
        return;
    }
    */

    [self httpGetCode:YES];
    /*
     //判读手机
     if ([self isValidateMobile:_phonefild.text]) {

     if ([[[NSUserDefaults standardUserDefaults] objectForKey:USER_GetSwitch] intValue] == 1||[[[NSUserDefaults standardUserDefaults] objectForKey:USER_LoginToWeiXin] intValue] == 1) {
     [self shareSdkWithAutohorWithTypeGetOpenID:@"1"];
     } else {
     [self RegistHttp];
     }
     }
     */
}
#pragma mark -邮箱注册、手机注册切换
-(void)EmailRegist:(UIButton*)sender
{
    sender.selected = !sender.selected;
    if(sender.selected == YES)
    {
        sender.selected = YES;
        _navLabel.text = @"邮箱注册";
        [sender setTitle:@"手机注册" forState:UIControlStateSelected];
        
        //邮箱注册");
        [_bigview removeFromSuperview];
        _bigview=[[UIView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight-(ZOOM6(128+kUnderStatusBarStartY))-Height_NavBar)];
        _bigview.backgroundColor = RGBCOLOR_I(244, 245, 246);
        [self.view addSubview:_bigview];
        
        [self createmailView];
        
    }else{
        
        sender.selected = NO;
        _navLabel.text = @"手机注册";
        [sender setTitle:@"邮箱注册" forState:UIControlStateSelected];
        
        [_bigview removeFromSuperview];
        _bigview=[[UIView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight-(ZOOM6(128+kUnderStatusBarStartY))-Height_NavBar)];
        _bigview.backgroundColor = RGBCOLOR_I(244, 245, 246);
        
//        [self creatregistView];
        [self phoneReistNewView];
        [self.view addSubview:_bigview];
        
        
    }
    
}

#pragma mark 获取验证码
-(void)yanzheng:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
    
    //获取验证码");
    NSString *phoneStr = _phonefild.text;
    
    if (phoneStr.length == 0) {
        
        [_mentionview showLable:@"亲，手机号不能空" Controller:self];
        
        return;
    }
    else {
        
        BOOL isCorrect = [self isValidateMobile:phoneStr];
        
        if (isCorrect) {
            
            //是手机号码");
//            self.secondsCountDown = 120;

            // 获取验证码
//            [self httpGetCode:NO];

            [UIView animateWithDuration:0.25f animations:^{
                newRegistView.frame = CGRectMake(0, newRegistView.y, newRegistView.width, newRegistView.height);
                oldRegistView.frame = CGRectMake(kScreenWidth, oldRegistView.y, oldRegistView.width, oldRegistView.height);
            }];
            [self httpGetCodeView];

        }   else {
            
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"请输入正确手机号码" Controller:self];
            return;
        }
    }
}

#pragma mark 手机注册_完成按钮
-(void)finishclick:(UIButton*)sender
{
    
    [self.view endEditing:YES];
    
    //判读手机号码
    _phonefild.text = [_phonefild.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *phoneStr = _phonefild.text;
    
    if (phoneStr.length == 0) {
        
        [_mentionview showLable:@"亲，手机号不能空" Controller:self];
        
        return;
    }
    else {
        
        BOOL isCorrect = [self isValidateMobile:phoneStr];
        if (isCorrect) {
            
            //是手机号码");
        }   else {
            
            //不是手机号码");
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"请输入正确手机号码" Controller:self];
            return;
        }
        
    }
    
    //判断输入长度
    
    BOOL result = [self judgeCorrect];
    
    if (result == NO)
    {
        return;
    }
    
    MyLog(@"_yanzhengcode = %@  _yanzhengfild=%@",_yanzhengcode,_yanzhengfild.text);
    //判断验证码
    if(_yanzhengfild.text.length == 0 || [_yanzhengfild.text isKindOfClass:[NSNull class]] || [_yanzhengfild.text isEqualToString:@""])
    {
        [_mentionview showLable:@"验证码不能为空,请重新输入" Controller:self];
        return;
    }
    
    

    // 判读邮箱
    
//    if([self isValidateEmail:_Emailfild.text]) {
//        
//        if ([[[NSUserDefaults standardUserDefaults] objectForKey:USER_GetSwitch] intValue] == 1) {
//            [self shareSdkWithAutohorWithTypeGetOpenID:@"2"];
//        } else {
//            [self mailBoxRequestHttp];
//            [self RegistHttp];
//        }
//        
//    }
    //判读手机
    if ([self isValidateMobile:_phonefild.text]) {
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:USER_GetSwitch] intValue] == 1||[[[NSUserDefaults standardUserDefaults] objectForKey:USER_LoginToWeiXin] intValue] == 1) {
            [self shareSdkWithAutohorWithTypeGetOpenID:@"1"];
        } else {
            [self RegistHttp];
        }
    }
    
}

#pragma mark 邮箱注册_完成按钮
- (void)mailBoxFinish:(UIButton*)sender
{
    
    [self.view endEditing:YES];
    
    // 判读邮箱
    
    _Emailfild.text = [_Emailfild.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    BOOL EmailOK=[self isValidateEmail:_Emailfild.text];
    
    if ([_Emailfild.text length]<1) {
        
        [_mentionview showLable:@"邮箱输入不能为空,请重新设置" Controller:self];
        
        return;
    }
    
    if(EmailOK!=YES)
    {
        [_mentionview showLable:@"输入邮箱不合法,请重新设置" Controller:self];
        
        return;
    }
    
    //判断输入长度
    
    if ([self judgeCorrect]==NO) {
        return;
    }
    
    
#pragma mark 判断图片验证码
    
    //  判读验证码
    //    if ([_yanzhengfild.text isEqualToString:self.codeView.changeString])
    if(_yanzhengfild.text.length!=0 && [_yanzhengfild.text compare:self.codeView.changeString
                                                           options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame)
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
    
    //        [self requestSortHttp];
    
    // 判读邮箱
    if([self isValidateEmail:_Emailfild.text]) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:USER_GetSwitch] intValue] == 1||[[[NSUserDefaults standardUserDefaults] objectForKey:USER_LoginToWeiXin] intValue] == 1) {
            [self shareSdkWithAutohorWithTypeGetOpenID:@"2"];
        }else
            [self mailBoxRequestHttp];

//        [self shareSdkWithAutohorWithTypeGetOpenID:@"2"];
    }
    //判读手机
//    if ([self isValidateMobile:_phonefild.text]) {
//        [self shareSdkWithAutohorWithTypeGetOpenID:@"1"];
//    }
    
}

#pragma mark 完成登录
-(void)loginclick:(UIButton*)sender
{
    [self.view endEditing:YES];
    
    
    // 判读昵称
    _NameFild.text = [_NameFild.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([_NameFild.text length]<1) {
        
        [_mentionview showLable:@"手机号不能为空" Controller:self];
        return;
        
    }
    
    
    NSString *phoneStr = _NameFild.text;
    NSRange range;
    range=[phoneStr rangeOfString:@"@"];//用@判读是手机号码还是邮箱
    if(range.length>0)
    {
        //是邮箱
        EmailOK=[self isValidateEmail:phoneStr];
        
        if(EmailOK!=YES)
        {
            [_mentionview showLable:@"输入邮箱不合法,请重新设置" Controller:self];
            return;
        }
        
    }else{
        //是手机号码
        
        isCorrect = [self isValidateMobile:phoneStr];
        
        if (isCorrect) {
            
            //是手机号码");
            
        }   else {
            
            //不是手机号码");
            
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"请输入正确手机号" Controller:self];
            
            return;
            
        }
        
        
    }
    
    // 判读密码
    
    if ([_PassWordFild.text length]<1) {
        
        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        [mentionview showLable:@"密码不能为空" Controller:self];
        
        return;
    }
    
    [self loginHttp];
    
}

#pragma mark 忘记密码
-(void)losspassword:(UIButton*)sender
{
    FindPasswordViewController *find=[[FindPasswordViewController alloc]init];
    [self.navigationController pushViewController:find animated:YES];
}

#pragma mark 用户协议
- (void)xieyiclick:(UITapGestureRecognizer*)tap
{
    MyLog(@"emailOK");
    
    TFUserProtocolViewController *tuvc = [[TFUserProtocolViewController alloc] init];
    tuvc.messagetype = @"注册";
    [self.navigationController pushViewController:tuvc animated:YES];
    
}

#pragma mark 登录时密码是否可看
- (void)see
{
    _logissee = !_logissee;
    
    if(_logissee == NO)
    {   _logseeimage.image = [UIImage imageNamed:@"Communal_sgin_yanjing_icon_default"];
        _PassWordFild.secureTextEntry = YES;
    }else{
        _PassWordFild.secureTextEntry = NO;
        _logseeimage.image = [UIImage imageNamed:@"Communal_sgin_yanjing_icon_Selected-1"];
    }
}

#pragma mark 手机注册时密码是否可看
- (void)see1
{
    _phoneissee = !_phoneissee;
    
    if(_phoneissee == NO)
    {   _phoneseeimage.image = [UIImage imageNamed:@"Communal_sgin_yanjing_icon_default"];
        _passwordfild.secureTextEntry = YES;
    }else{
        _passwordfild.secureTextEntry = NO;
        _phoneseeimage.image = [UIImage imageNamed:@"Communal_sgin_yanjing_icon_Selected-1"];
    }
}

#pragma mark 邮箱注册时密码是否可看
- (void)see2
{
    _emailissee = !_emailissee;
    
    if(_emailissee == NO)
    {   _emailseeimage.image = [UIImage imageNamed:@"Communal_sgin_yanjing_icon_default"];
        _passwordfild.secureTextEntry = YES;
    }else{
        _passwordfild.secureTextEntry = NO;
        _emailseeimage.image = [UIImage imageNamed:@"Communal_sgin_yanjing_icon_Selected-1"];
    }
}

#pragma mark 返回上一视图
-(void)back:(UIButton*)btn
{
    [self.view endEditing:YES];

    if (newRegistView.x!=0) {
        [UIView animateWithDuration:0.25f animations:^{
            newRegistView.frame = CGRectMake(0, newRegistView.y, newRegistView.width, newRegistView.height);
            oldRegistView.frame = CGRectMake(kScreenWidth, oldRegistView.y, oldRegistView.width, oldRegistView.height);
        }];
        phoneCodeNum.text = nil;
        [self httpGetCodeView];
        return;
    }

    if ((self.navigationController.viewControllers.firstObject == self) || (self.presentedViewController)) {
        if ([self.loginStatue isEqualToString:@"10030"]) {
            Mtarbar.selectedIndex=0;
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        // 跳转到首页
        if (Mtarbar.selectedIndex==4||[self.loginStatue isEqualToString:@"10030"]) {
            Mtarbar.selectedIndex=0;
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else
            [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - +++++++++++++++++++++各种验证+++++++++++++++++++++
#pragma mark 邮箱是否合法
-(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

#pragma mark 验证手机号
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

#pragma mark 密码加密
- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

#pragma mark 验证码倒计时
- (void)timerFireMethord
{
    self.secondsCountDown --;
    _yanzhengBtn.userInteractionEnabled=NO;
    [_yanzhengBtn setText:[NSString stringWithFormat:@"%d秒", self.secondsCountDown]];
    _yanzhengBtn.font = [UIFont systemFontOfSize:ZOOM(41)];
    _yanzhengBtn.textColor = kTextColor;
    if (self.secondsCountDown == 0)  {
        [self.countDownTimer invalidate];
        _yanzhengBtn.userInteractionEnabled=YES;
        [_yanzhengBtn setText:@"重新获取"];
        [_yanzhengBtn setTextColor:tarbarrossred];
    }
}

#pragma mark 邮箱完成注册
-(BOOL)IsChinese:(NSString *)str {
    for(int i=0; i< [str length];i++)
    { int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        { return YES;
        }
    } return NO;
}


#pragma mark  判断输入长度
- (BOOL)judgeCorrect
{
//    // 判读昵称
//    if ([_namefild.text length]<1) {
//        
//        [_mentionview showLable:@"昵称输入不能为空,请重新设置" Controller:self];
//        return NO;
//    }
    
    if ([_passwordfild.text length]<1) {
        
        [_mentionview showLable:@"密码输入不能为空,请重新设置" Controller:self];
        return NO;
    }
    
    if ([[Tools share] stringContainsEmoji:_passwordfild.text]) {
        
        [_mentionview showLable:@"密码暂不支持表情字符" Controller:self];
        return NO;
    }
    
    if ([MyMD5 asciiLengthOfString:_passwordfild.text]<6||[MyMD5 asciiLengthOfString:_passwordfild.text]>16) {
        
        [_mentionview showLable:@"密码为6-16个英文、数字字符" Controller:self];
        return  NO;
    }else  if([self IsChinese:_passwordfild.text]){
        //you zhong wen") ;
        
        [_mentionview showLable:@"密码为6-16个英文、数字字符" Controller:self];
        return NO;
    }
    
//    if ([_namefild.text length]>0) {
//        
//        return [self judgeName];
//    }
//    else
//    {
//        return NO;
//    }
    return YES;
}

-(BOOL)judgeName
{
    if(_namefild.text){
        
        NSUInteger lenth= [self charNumber:_namefild.text];
        
        MyLog(@"lenth =%d",(int)lenth);
        
        if(lenth < 2){
            
            [_mentionview showLable:@"昵称不要输入低于2个或高于8个字符" Controller:self];
            return NO;
        }else {
            
            if(lenth >8)
            {
                [_mentionview showLable:@"昵称不要输入低于2个或高于8个字符" Controller:self];
                return NO;
            }
            
        }
        
    }
    return YES;
}

#pragma mark 判断字符串字符个数
-  (int)charNumber:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUTF8StringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUTF8StringEncoding] ;i++) {
        if (*p) {
            if(*p == '\xe4' || *p == '\xe5' || *p == '\xe6' || *p == '\xe7' || *p == '\xe8' || *p == '\xe9')
            {
                strlength--;
            }
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

#pragma mark 判读密码
- (BOOL)validatePassword:(NSString *)password
{
    NSString *passwordRegex = @"^[A-Za-z0-9]{6,16}$";
    NSPredicate *passTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwordRegex];
    return [passTest evaluateWithObject:password];
}

#pragma mark - 获取地址
- (NSArray *)getAddressStateID:(NSNumber *)stateNum withCityID:(NSNumber *)cityNum witAreaID:(NSNumber *)areaNum withStreetID:(NSNumber *)streetNum
{
    NSString *state;
    NSString *city;
    NSString *area;
    NSString *street;
    
    NSArray *stateArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"areatbl" ofType:@"plist"]];
    if ([stateNum intValue]!=0) { //查询省
        for (NSDictionary *dic in stateArr) {
            if ([dic[@"id"] intValue] == [stateNum intValue]) { //找到省
                state = dic[@"state"];
                if ([cityNum intValue]!=0) {
                    NSArray *citiesArr = dic[@"cities"];
                    for (NSDictionary *dic in citiesArr) {
                        if ([dic[@"id"] intValue] == [cityNum intValue]) { //找到市
                            city = dic[@"city"];
                            if ([areaNum intValue]!=0) {
                                NSArray *areasArr = dic[@"areas"];
                                for (NSDictionary *dic in areasArr) {
                                    if ([dic[@"id"] intValue] == [areaNum intValue]) { //找到区
                                        area = dic[@"area"];
                                        if ([streetNum intValue]!=0) {
                                            NSArray *streetsArr = dic[@"streets"];
                                            for (NSDictionary *dic in streetsArr) {
                                                if ([streetNum intValue] == [dic[@"id"] intValue]) { //找到街道
                                                    street = dic[@"street"];
                                                    break;
                                                }
                                            }
                                        }
                                        break;
                                    }
                                }
                            }
                            break;
                        }
                    }
                }
                break;
            }
        }
    }
    if (area!=nil&&street!=nil) {
        return [NSArray arrayWithObjects:state,city,area,street, nil];
    } else if (area!=nil&&street == nil) {
        return [NSArray arrayWithObjects:state,city,area, nil];
    } else if (area ==nil&&street == nil) {
        return [NSArray arrayWithObjects:state,city, nil];
    } else
        return nil;
}

#pragma mark - +++++++++++++++++++++网络部分+++++++++++++++++++++
- (void)loginSuccessDoSomething:(NSDictionary *)responseObject {
    
    //发送登录成功通知 只在详情用到
    NSNotification *notification=[NSNotification notificationWithName:@"zeroOrderChange" object:@"zeroOrderChange"];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    NSString *Password=[MyMD5 md5:_PassWordFild.text];

    [Login doLogin:responseObject];
    
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];

    [userdefaul setObject:@"1" forKey:@"isNoRegistered"];
    NSString *token = responseObject[@"token"];
    
    NSString *user_id=[NSString stringWithFormat:@"%@",responseObject[@"userinfo"][@"user_id"]];
    
    MyLog(@"user_id = %@ Password =%@",user_id,Password);
    
    //+++++++保存当前用户登录信息+++++++
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    
    [ud setObject:_PassWordFild.text forKey:USER_PASSWORD];
    [ud setObject:token forKey:USER_TOKEN];
    [ud setObject:@"user" forKey:USER_INFO];
    
    //            NSDate *date = [NSDate date];
    //            [ud setObject:date forKey:CARTENDDATE];//用于刷新tabbar的购物车
    
    if(![responseObject[@"userinfo"][@"nickname"] isEqual:[NSNull null]]){
        [ud setObject:responseObject[@"userinfo"][@"nickname"] forKey:USER_NAME];
    }
    
    if(![responseObject[@"userinfo"][@"is_member"] isEqual:[NSNull null]]){
        [ud setObject:responseObject[@"userinfo"][@"is_member"] forKey:USER_MEMBER];
    }
    
    if(![responseObject[@"userinfo"][@"code_type"] isEqual:[NSNull null]]){
        [ud setObject:responseObject[@"userinfo"][@"code_type"] forKey:CODE_TYPE];
    }
    
    if(![responseObject[@"userinfo"][@"phone"] isEqual:[NSNull null]]){
        [ud setObject:responseObject[@"userinfo"][@"phone"] forKey:USER_PHONE];
    }
    
    if(![responseObject[@"userinfo"][@"user_id"] isEqual:[NSNull null]]){
        [ud setObject:responseObject[@"userinfo"][@"user_id"] forKey:USER_ID];
    }
    
    if (![responseObject[@"store"] isEqual:[NSNull null]]) {
        //                [ud setObject:responseObject[@"store"][@"user_id"] forKey:USER_ID];
        [ud setObject:responseObject[@"store"][@"realm"] forKey:USER_REALM];
        [ud setObject:responseObject[@"store"][@"s_name"] forKey:STORE_NAME];
    }
    
    //保存会员标识
    NSString *ismember = [NSString stringWithFormat:@"%@",responseObject[@"userinfo"][@"is_member"]];
    
    if(ismember)
    {
        [ud setObject:ismember forKey:USER_MEMBER];
    }
    
    //保存unionid //何波修改2017-9-27
    NSString *unionid = [NSString stringWithFormat:@"%@",responseObject[@"userinfo"][@"unionid"]];
    if(unionid !=nil && ![unionid isEqual:[NSNull null]] && ![unionid containsString:@"<null>"])
    {
        [ud setObject:unionid forKey:UNION_ID];
    }
    
    //保存IMEI
    NSString *imei = [NSString stringWithFormat:@"%@",responseObject[@"userinfo"][@"imei"]];
    if(imei !=nil && ![imei isEqual:[NSNull null]])
    {
        [ud setObject:imei forKey:HTTP_IMEI];
    }
    
    //保存MAC地址
    NSString *macip= [NSString stringWithFormat:@"%@",responseObject[@"userinfo"][@"mac"]];
    
    if([imei isEqual:[NSNull null]] || [macip isEqual:[NSNull null]] ||imei == nil || macip == nil || imei.length < 10 || macip.length <10)
    {
        //如果IMEI MAC 为空就上传给后台
        [self saveIMEI_MACHttpIMEI:imei MAC:macip];
    }
    NSString *unionid1 =responseObject[@"userinfo"][@"unionid"];
    if (self.unionid&&(unionid1 ==nil || [unionid1 isEqual:[NSNull null]])) {
        [self saveIMEI_MACHttpIMEI:@"更新unionid" MAC:nil];
    }
    
    //保存hobby
    if (![responseObject[@"userinfo"][@"hobby"]isEqual:[NSNull null]] && ![responseObject[@"userinfo"][@"hobby"]isEqualToString:@"0"]) {
        [userdefaul setObject:responseObject[@"userinfo"][@"hobby"] forKey:USER_HOBBY];
        
    }else
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:USER_HOBBY];
    
    //保存分类用户
    NSString *userclassify = [NSString stringWithFormat:@"%@",responseObject[@"userType"]];
    if(userclassify !=nil || ![userclassify isEqual:[NSNull null]])
    {
        [ud setObject:userclassify forKey:USER_CLASSIFY];
    }
    
    //---%@",responseObject[@"userinfo"][@"nickname"]);
    NSString *User_id = [ud objectForKey:USER_ID];
    
    
    // begin 赵官林 2016.5.30
//    if (IsRongCloub) {
//        // 登录融云
//        [[DataManager sharedManager] updateRcToken];
//    } else {
//        //登录环信
//        [self loginHuanxing:user_id Withword:Password];
//    }
    // end
    
    [Signmanager SignManarer].signChange = YES;
    
    if(responseObject[@"twofoldness"] !=nil )
    {
        // begin 赵官林 2016.7.1（余额翻倍）
        NSDictionary *twofoldnessDic = responseObject[@"twofoldness"];
        if (twofoldnessDic.count == 0) {
            //未开店
            [DataManager sharedManager].isOligible = NO;
            [DataManager sharedManager].isOpen=NO;
        } else {
            //已开店
            [DataManager sharedManager].isOligible = YES;
            [DataManager sharedManager].isOpen = ((NSNumber *)twofoldnessDic[@"is_open"]).boolValue;
            [DataManager sharedManager].twofoldness = ((NSNumber *)twofoldnessDic[@"twofoldness"]).integerValue;
            [DataManager sharedManager].endDate = ((NSNumber *)twofoldnessDic[@"end_date"]).longLongValue;
        }
        // end
        
    }
    
    //金币金券
    [self getgoldCoupons];
    
    if (responseObject[@"userinfo"][@"pic"]!=[NSNull null]) {
        [ud setObject:responseObject[@"userinfo"][@"pic"] forKey:USER_HEADPIC];
        
        NSString *picURL = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],responseObject[@"userinfo"][@"pic"]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFImageResponseSerializer serializer];
        [manager GET:picURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //                    responseObject = [NSDictionary changeType:responseObject];
            if (responseObject!=nil) {
                //2.缓存图片到沙盒
                NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),User_id];
                NSData *imgData = UIImagePNGRepresentation(responseObject);
                [imgData writeToFile:aPath atomically:YES];
                
                NSNotification *noti = [NSNotification notificationWithName:@"imagenote" object:nil];
                [[NSNotificationCenter defaultCenter] postNotification:noti];
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    }
    
    
    //存储邮箱及手机号+++++++++++++++++++++++++++++++++++++++++++++++++
    if (EmailOK) {
        [ud setObject:_NameFild.text forKey:USER_EMAIL];
    }
    if (isCorrect) {
        [ud setObject:_NameFild.text forKey:USER_PHONE];
    }
    [ud synchronize];
    
    
    
    [self saveUserInfomation:responseObject];
    
    [self addTableBarViewControllers:@"1"];
    
    [self httpGetMisson];
    
    //登录成功后获取用户加喜欢商品
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app getUserLikeHttp];
    [app goFuns];
    
    [HTTPTarbarNum httpGetUserGrade];//何波加的2016-11-18
    [[DataManager sharedManager] getduobaoStatueHttp];//登录成功后查看夺宝获奖信息
}
#pragma mark 手机/邮箱/网络请求登录
-(void)loginHttp
{
    // 1.创建网络请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *Password=[MyMD5 md5:_PassWordFild.text];
    NSString *IMEI =[[NSUserDefaults standardUserDefaults] objectForKey:USER_UUID];
    
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *devicetoken = [userdefaul objectForKey:DECICETOKEN];
    
    EmailOK=[self isValidateEmail:_NameFild.text];
    isCorrect = [self isValidateMobile:_NameFild.text];
    
    NSString *url ;
    
    url = [NSString stringWithFormat:@"%@user/login?version=%@&account=%@&pwd=%@&device=2&deviceToken=%@&imei=%@&mac=%@", [NSObject baseURLStr],VERSION,_NameFild.text,Password,devicetoken,IMEI,IMEI];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *URL=[MyMD5 authkey:url];
    
    kSelfWeak;
    [MBProgressHUD showMessage:@"正在验证登录" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        MyLog(@"responseObject = %@ ",responseObject);
        
        // 判断成不成功
        NSString *str = responseObject[@"status"];
    
        // 成功
        if ( str.intValue == 1) {
            [MBProgressHUD hideHudForView:weakSelf.view];
            [weakSelf.view endEditing:YES];
            NSString *unionid =responseObject[@"userinfo"][@"unionid"];

            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]&&[[[NSUserDefaults standardUserDefaults] objectForKey:USER_LoginToWeiXin] intValue] == 1 && (unionid==nil||[unionid isEqual:[NSNull null]])) {
                [weakSelf shareSdkWithAutohorWithTypeGetOpenID:@"3" dictionary:responseObject];
            }else{
                [weakSelf loginSuccessDoSomething:responseObject];
            }
            
            //H5赚钱金额
            NSString *h5money = [NSString stringWithFormat:@"%@",responseObject[@"userinfo"][@"h5money"]];
            [DataManager sharedManager].h5money = h5money.floatValue;
            [[DataManager sharedManager] getOrderHttp:YES];//引导支付订单
        } else if (str.intValue == 101)//请选择标签
        {
            NSString *user_id=[NSString stringWithFormat:@"%@",responseObject[@"userinfo"][@"user_id"]];
            
            //+++++++保存当前用户登录信息+++++++
            NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
            [ud setObject:_PassWordFild.text forKey:USER_PASSWORD];
            [ud setObject:@"user" forKey:USER_INFO];
            
            [ud setObject:responseObject[@"userinfo"][@"nickname"] forKey:USER_NAME];
            [ud setObject:responseObject[@"userinfo"][@"is_member"] forKey:USER_MEMBER];
            [ud setObject:responseObject[@"userinfo"][@"code_type"] forKey:CODE_TYPE];
            
            if(![responseObject[@"userinfo"][@"user_id"] isEqual:[NSNull null]]){
                [ud setObject:responseObject[@"userinfo"][@"user_id"] forKey:USER_ID];
            }

            if (![responseObject[@"store"] isEqual:[NSNull null]]) {
//                [ud setObject:responseObject[@"store"][@"realm"] forKey:USER_REALM];
                [ud setObject:responseObject[@"store"][@"s_name"] forKey:STORE_NAME];
                [ud setObject:responseObject[@"store"][@"user_id"] forKey:USER_ID];
            }
            
            
            NSString *token = responseObject[@"token"];
            NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
            
            [userdefaul setObject:token forKey:USER_TOKEN];
            
            // begin 赵官林 2016.5.30
            if (IsRongCloub) {
                // 登录融云
                [[DataManager sharedManager] updateRcToken];
            } else {
                //环信注册
                [self registHuanxing:user_id Withword:Password];
            }
            // end
            
            [self rootviewcontroller];
            
        }else if (str.intValue==1051){
            
            NSString *token = responseObject[@"token"];
            NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
            
            //+++++++保存当前用户登录信息+++++++
            NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
            [ud setObject:_PassWordFild.text forKey:USER_PASSWORD];
            [ud setObject:@"user" forKey:USER_INFO];
            
            [ud setObject:responseObject[@"userinfo"][@"nickname"] forKey:USER_NAME];
            [ud setObject:responseObject[@"userinfo"][@"is_member"] forKey:USER_MEMBER];
            
            [ud setObject:responseObject[@"userinfo"][@"code_type"] forKey:CODE_TYPE];
            
            if(![responseObject[@"userinfo"][@"user_id"] isEqual:[NSNull null]]){
                [ud setObject:responseObject[@"userinfo"][@"user_id"] forKey:USER_ID];
            }

            if (![responseObject[@"store"] isEqual:[NSNull null]]) {
//                [ud setObject:responseObject[@"store"][@"user_id"] forKey:USER_ID];
                [ud setObject:responseObject[@"store"][@"realm"] forKey:USER_REALM];
                [ud setObject:responseObject[@"store"][@"s_name"] forKey:STORE_NAME];
            }
            
            [userdefaul setObject:token forKey:FAIL_TOKEN];
            [userdefaul setObject:token forKey:USER_TOKEN];
            
            if (![responseObject[@"store"] isEqual:[NSNull null]]) {
                NSString *user_id=[NSString stringWithFormat:@"%@",responseObject[@"store"][@"user_id"]];
                
                // begin 赵官林 2016.5.30
                if (IsRongCloub) {
                    // 登录融云
                    [[DataManager sharedManager] updateRcToken];
                } else {
                    //环信注册
                    [self registHuanxing:user_id Withword:Password];
                }
                // end
            }
            
            referenceViewController *refrence = [[referenceViewController alloc]init];
            refrence.array=[NSArray arrayWithArray:_headArray];
            refrence.nameArray=[NSArray arrayWithArray:_NameArray];
            [self.navigationController pushViewController:refrence animated:YES];
        }else {
            
            [MBProgressHUD hideHudForView:self.view];
            
            //%@", responseObject[@"message"]);
            
            NSString *errorStr = [NSString stringWithFormat:@"%@", responseObject[@"message"]];
            
#pragma mark -- 可以再这里提醒用户，出错
            
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:errorStr Controller:self];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHudForView:self.view];
        
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    
}

#pragma mark 手机注册网络请求
-(void)RegistHttp
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *devicetoken = [userdefaul objectForKey:DECICETOKEN];
    NSString *IMEI =[userdefaul objectForKey:USER_UUID];
    NSString *IDFA =[userdefaul objectForKey:USER_IDFA];
    
    // 1.创建网络请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *password=[MyMD5 md5:_passwordfild.text];
    
    NSString *url=[NSString stringWithFormat:@"%@user/register?version=%@&account=%@&pwd=%@&deviceToken=%@&imei=%@&device=2&user_type=1&code=%@&mac=%@&idfa=%@",[NSObject baseURLStr],VERSION,_phonefild.text,password,devicetoken,IMEI,_yanzhengfild.text,IMEI,IDFA];
    
    if(self.unionid.length > 10 && self.openid.length > 10)
    {
        url=[NSString stringWithFormat:@"%@user/register?version=%@&account=%@&pwd=%@&deviceToken=%@&imei=%@&device=2&user_type=1&code=%@&wx_openid=%@&unionid=%@&mac=%@&idfa=%@",[NSObject baseURLStr],VERSION,_phonefild.text,password,devicetoken,IMEI,_yanzhengfild.text,self.openid,self.unionid,IMEI,IDFA];
    }

    NSString *Posturl=[MyMD5 authkey:url];
    //posturl2 is %@",Posturl);
    kSelfWeak;
    [MBProgressHUD showMessage:@"请耐心等待"afterDeleay:0 WithView:self.view];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [manager POST:Posturl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            //%@", responseObject);
            NSString *user_id = [NSString stringWithFormat:@"%@",responseObject[@"userinfo"][@"user_id"]];
            NSString *str = responseObject[@"status"];
            
            // 输入错误
            if ( str.intValue == 2) {
                //%@", responseObject[@"message"]);
                
                [MBProgressHUD hideHUDForView:self.view];
                NSString *errorStr = [NSString stringWithFormat:@"%@", responseObject[@"message"]];
                
                [_mentionview showLable:errorStr Controller:self];
                
                return ;
                
            }  else if(str.intValue==1) {

                [weakSelf.countDownTimer invalidate];


                [self addTableBarViewControllers:@"2"];
                
                [self removeNoviceTask];
                
                
                [MBProgressHUD hideHUDForView:self.view];
                
                //APP注册成功就注册环信
                
                [self.view endEditing:YES];
                
                [Login doLogin:responseObject];
                
                //保存当前用户登录/注册信息
                NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                [userdefaul setObject:_passwordfild.text forKey:USER_PASSWORD];
                [userdefaul setObject:_phonefild.text forKey:USER_PHONE];
                [userdefaul setObject:@"user" forKey:USER_INFO];
                [userdefaul setObject:responseObject[@"token"] forKey:USER_TOKEN];
                [userdefaul setObject:responseObject[@"userinfo"][@"user_id"] forKey:USER_ID];
                [userdefaul setObject:responseObject[@"userinfo"][@"is_member"] forKey:USER_MEMBER];
                
                //保存分类用户
                NSString *userclassify = [NSString stringWithFormat:@"%@",responseObject[@"userType"]];
                if(userclassify !=nil || ![userclassify isEqual:[NSNull null]])
                {
                    [userdefaul setObject:userclassify forKey:USER_CLASSIFY];
                }

                
                // begin 赵官林 2016.5.30
                if (IsRongCloub) {
                    // 登录融云
                    [[DataManager sharedManager] updateRcToken];
                } else {
                    //环信注册
                    [self registHuanxing:user_id Withword:password];
                }
                // end
                
                NSString *User_id = [userdefaul objectForKey:USER_ID];
                
                if(![responseObject[@"userinfo"][@"code_type"]isEqual:[NSNull null]])
                {
                    [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"userinfo"][@"code_type"] forKey:CODE_TYPE];
                }
                if (![responseObject[@"userinfo"][@"nickname"]isEqual:[NSNull null]])
                {
                    [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"userinfo"][@"nickname"] forKey:USER_NAME];
                }
                if (![responseObject[@"userinfo"][@"phone"]isEqual:[NSNull null]])
                {
                    [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"userinfo"][@"phone"] forKey:USER_PHONE];
                }

                if(![responseObject[@"store"] isEqual:[NSNull null]])
                {
                    if(![responseObject[@"store"][@"realm"]isEqual:[NSNull null]])
                    {
                        [userdefaul setObject:responseObject[@"store"][@"realm"] forKey:USER_REALM];
                    }
                    
                    if(![responseObject[@"store"][@"s_name"]isEqual:[NSNull null]])
                    {
                        [userdefaul setObject:responseObject[@"store"][@"s_name"] forKey:STORE_NAME];
                    }
                    
                    if(![responseObject[@"store"][@"s_code"]isEqual:[NSNull null]])
                    {
                        [userdefaul setObject:responseObject[@"store"][@"s_code"] forKey:STORE_CODE];
                    }
                    
                }
                
                if (![responseObject[@"userinfo"][@"hobby"]isEqual:[NSNull null]] && ![responseObject[@"userinfo"][@"hobby"]isEqualToString:@"0"]) {
                    [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"userinfo"][@"hobby"] forKey:USER_HOBBY];
                    //%@",responseObject[@"userinfo"][@"hobby"]);
                }else{
                    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:USER_HOBBY];
                }
                
                [self saveUserInfomation:responseObject];
                
                if (responseObject[@"userinfo"][@"pic"]!=[NSNull null]) {
                    [userdefaul setObject:responseObject[@"userinfo"][@"pic"] forKey:USER_HEADPIC];
                    
                    NSString *picURL = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],responseObject[@"userinfo"][@"pic"]];
                    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                    manager.responseSerializer = [AFImageResponseSerializer serializer];
                    
                    [manager GET:picURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        //2.缓存图片到沙盒
                        NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),User_id];
                        NSData *imgData = UIImagePNGRepresentation(responseObject);
                        [imgData writeToFile:aPath atomically:YES];
                        
                        NSNotification *noti = [NSNotification notificationWithName:@"imagenote" object:nil];
                        [[NSNotificationCenter defaultCenter] postNotification:noti];
                        
                        
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       
                    }];
                }
                
                [self httpSendOutOpenID];
                
                [self setNoviceFlag];
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //aaaaaa==%@", error.localizedDescription);
        [MBProgressHUD hideHUDForView:self.view];
        
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    
}

#pragma mark 邮箱注册网络请求
-(void)mailBoxRequestHttp
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *deviceToken =[userdefaul objectForKey:DECICETOKEN];
    NSString *IMEI =[userdefaul objectForKey:USER_UUID];
    NSString *IDFA =[userdefaul objectForKey:USER_IDFA];
    
    MyLog(@"deviceToken=%@IMEI=%@",deviceToken,IMEI);
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSString *Password=[self md5:_passwordfild.text];
    Password=[Password uppercaseString];
    
    NSString *url=[NSString stringWithFormat:@"%@user/register?version=%@&account=%@&pwd=%@&deviceToken=%@&imei=%@&device=2&user_type=2&idfa=%@",[NSObject baseURLStr],VERSION,_Emailfild.text,Password,deviceToken,IMEI,IDFA];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *URL = [MyMD5 authkey:url];
    [MBProgressHUD showMessage:@"正在为你注册" afterDeleay:0 WithView:self.view];
    //URL IS %@",URL);
    [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *str = responseObject[@"status"];
            NSString *user_id = [NSString stringWithFormat:@"%@",responseObject[@"userinfo"][@"user_id"]];
            //STR is %@",str);
            if(str.intValue==1)
            {
                [self addTableBarViewControllers:@"2"];
                [self removeNoviceTask];
                
                [MBProgressHUD hideHUDForView:self.view];
                
                NSString *token=[NSString stringWithFormat:@"%@",responseObject[@"token"]];
                
                
                [Login doLogin:responseObject];
                
                //邮箱注册成功 token = %@", token);
                
                //保存当前登录用户的信息
                
                NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                [userdefaul setObject:_passwordfild.text forKey:USER_PASSWORD];
                [userdefaul setObject:_Emailfild.text forKey:USER_EMAIL];
                [userdefaul setObject:@"user" forKey:USER_INFO];
                [userdefaul setObject:token forKey:USER_TOKEN];
                [userdefaul setObject:responseObject[@"userinfo"][@"user_id"] forKey:USER_ID];
                [userdefaul setObject:responseObject[@"userinfo"][@"is_member"] forKey:USER_MEMBER];
                
                // begin 赵官林 2016.5.30
                if (IsRongCloub) {
                    // 登录融云
                    [[DataManager sharedManager] updateRcToken];
                } else {
                    //环信注册
                    [self registHuanxing:user_id Withword:Password];
                }
                // end
                
                if(![responseObject[@"userinfo"][@"code_type"]isEqual:[NSNull null]])
                {
                    [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"userinfo"][@"code_type"] forKey:CODE_TYPE];
                }
                if (![responseObject[@"userinfo"][@"nickname"]isEqual:[NSNull null]])
                {
                    [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"userinfo"][@"nickname"] forKey:USER_NAME];
                }
                if (![responseObject[@"userinfo"][@"email"]isEqual:[NSNull null]])
                {
                    [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"userinfo"][@"email"] forKey:USER_EMAIL];
                }

                //保存分类用户
                NSString *userclassify = [NSString stringWithFormat:@"%@",responseObject[@"userType"]];
                if(userclassify !=nil || ![userclassify isEqual:[NSNull null]])
                {
                    [userdefaul setObject:userclassify forKey:USER_CLASSIFY];
                }

                if(![responseObject[@"store"] isEqual:[NSNull null]])
                {
                    if(![responseObject[@"store"][@"realm"]isEqual:[NSNull null]])
                    {
                        [userdefaul setObject:responseObject[@"store"][@"realm"] forKey:USER_REALM];
                    }
                    
                    if(![responseObject[@"store"][@"s_name"]isEqual:[NSNull null]])
                    {
                        [userdefaul setObject:responseObject[@"store"][@"s_name"] forKey:STORE_NAME];
                    }
                    
                    if(![responseObject[@"store"][@"s_code"]isEqual:[NSNull null]])
                    {
                        [userdefaul setObject:responseObject[@"store"][@"s_code"] forKey:STORE_CODE];
                    }
                    
                }
                
                if (![responseObject[@"userinfo"][@"hobby"]isEqual:[NSNull null]] && ![responseObject[@"userinfo"][@"hobby"]isEqualToString:@"0"]) {
                    [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"userinfo"][@"hobby"] forKey:USER_HOBBY];
                    //%@",responseObject[@"userinfo"][@"hobby"]);
                }else{
                    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:USER_HOBBY];
                }
                
                [self saveUserInfomation:responseObject];
                
                //保存头像
                NSString *User_id = [userdefaul objectForKey:USER_ID];
                
                
                if (responseObject[@"userinfo"][@"pic"]!=[NSNull null]) {
                    [userdefaul setObject:responseObject[@"userinfo"][@"pic"] forKey:USER_HEADPIC];
                    
                    NSString *picURL = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],responseObject[@"userinfo"][@"pic"]];
                    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                    manager.responseSerializer = [AFImageResponseSerializer serializer];
                    [manager GET:picURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        //2.缓存图片到沙盒
                        NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),User_id];
                        NSData *imgData = UIImagePNGRepresentation(responseObject);
                        [imgData writeToFile:aPath atomically:YES];
                        
                        NSNotification *noti = [NSNotification notificationWithName:@"imagenote" object:nil];
                        [[NSNotificationCenter defaultCenter] postNotification:noti];
                        
                        
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        //                        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
                    }];
                }
                
                [self httpSendOutOpenID];
                
                if (self.unionid) {
                    [self saveIMEI_MACHttpIMEI:@"更新unionid" MAC:nil];
                }
                
                [self setNoviceFlag];
                
            }else{
                [MBProgressHUD hideHUDForView:self.view];
                NSString *message=responseObject[@"message"];
                
                if([message isEqualToString:@"该邮箱已经被注册."])
                {
                    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
                    popView.title = @"注册提示";
                    popView.message = @"该邮箱已被注册啦~";
                    popView.leftText = @"去登录";
                    popView.rightText = @"找回密码";
                    popView.textAlignment = NSTextAlignmentCenter;
                    
                    [popView setCancelBlock:^{
                        
                        [self login];//去登录
                        
                    } withConfirmBlock:^{
                        
                        //找回密码
                        FindPasswordViewController *find=[[FindPasswordViewController alloc]init];
                        [self.navigationController pushViewController:find animated:YES];
                        
                    } withNoOperationBlock:^{
                        
                    }];
                    [popView show];
                    
                    
                }else{
                    [_mentionview showLable:message Controller:self];
                }
                
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    
    
}

#pragma mark 网络获取验证码
- (void)httpGetCode:(BOOL)isNext
{

    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    // 1.创建网络请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    NSString *phone=[NSString stringWithFormat:@"%@",_phonefild.text];
    NSString *codeurl=[NSString stringWithFormat:@"%@user/get_phone_code?version=%@&phone=%@&codetype=1&token=%@&vcode=%@",[NSObject baseURLStr],VERSION,phone,token,phoneCodeNum.text];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *Posturl=[MyMD5 authkey:codeurl];
    //Posturl %@",Posturl);
//    [MBProgressHUD showMessage:@"" afterDeleay:0 WithView:self.view];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [manager POST:Posturl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //%@", responseObject);
        MyLog(@"responseObject = %@",responseObject);
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            [MBProgressHUD hideHUDForView:self.view];

            NSString *str = responseObject[@"status"];
            // 输入错误
            if ( str.intValue == 2) {
                //%@", responseObject[@"message"]);
                NSString *originerrorStr = responseObject[@"message"];
                NSString *errorStr = [NSString string];
                
                if ([originerrorStr isEqualToString:@"请填写正确的手机号"]) {
                    
                    errorStr = @"对不起,请输入正确的手机号码";
                    
                }
                else if ([originerrorStr isEqualToString:@"该手机号已被注册"]) {
                    
                    errorStr = @"对不起，此手机号已经注册过了";
                }
                else if ([originerrorStr isEqualToString:@"注册帐号出错，请重新注册"]) {
                    
                    errorStr = @"生成验证码失败, 有可能是网络原因";
                }
                else if ([originerrorStr isEqualToString:@"发送过于频繁请稍后再发"]) {
                    
                    errorStr = @"对不起，此号码验证码创建频繁，请稍后再试";
                    
                }
                
                else if ([originerrorStr isEqualToString:@"您当天可以发送的短信次数超过"]) {
                    
                    errorStr = @"对不起，今天发送的信息次数过多，请稍后再试";
                    
                }
                else if ([originerrorStr isEqualToString:@"发送注册码出错"]) {
                    
                    errorStr = @"对不起，生成验证码失败，请稍后再试";
                    
                }
                
                else if ([originerrorStr isEqualToString:@"验证码类型有误"]) {
                    
                    errorStr = @"对不起，生成验证码失败，请稍后再试";
                    
                }
                else{

                    errorStr = originerrorStr;
                }

//                if([errorStr isEqualToString:@""])
//                {
//                    errorStr = @"对不起，生成失败，请稍后再试";
//                }

                if([errorStr isEqualToString:@"对不起，此手机号已经注册过了"])
                {
                    
                    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
                    popView.title = @"注册提示";
                    popView.message = @"该手机已被注册啦~";
                    popView.leftText = @"去登录";
                    popView.rightText = @"找回密码";
                    popView.textAlignment = NSTextAlignmentCenter;
                    
                    [popView setCancelBlock:^{
                        
                        [self login];//去登录
                        
                    } withConfirmBlock:^{
                        
                        //找回密码
                        FindPasswordViewController *find=[[FindPasswordViewController alloc]init];
                        [self.navigationController pushViewController:find animated:YES];
                        
                    } withNoOperationBlock:^{
                        
                    }];
                    [popView show];
                    
                    
                }else{
                    [_mentionview showLable:errorStr Controller:self];
                }
                
                
                
            }

            else {

                [MBProgressHUD hideHUDForView:self.view];

                if (isNext) {
                    [self creatregistView];

                    [UIView animateWithDuration:0.25f animations:^{
                        newRegistView.frame = CGRectMake(-kScreenWidth, newRegistView.y, newRegistView.width, newRegistView.height);
                        oldRegistView.frame = CGRectMake(0, oldRegistView.y, oldRegistView.width, oldRegistView.height);
                    }];
                }
#pragma mark - 验证码以后在这改
                // 输入正确
                // 字典装模型
                NSString *correStr = responseObject[@"message"];
                NSString *code= responseObject[@"verify_code"];
                //%@", correStr);
                //验证码is%@",code);
                // 验证码生成成功!
                //            _yanzhengfild.text = code;
                
                if(code)
                {
                    _yanzhengcode = [NSString stringWithFormat:@"%@",code];
                }
                if ([self.countDownTimer isValid]) {
                    [self.countDownTimer invalidate];
                }
                self.secondsCountDown = 120;

                self.countDownTimer = [NSTimer weakTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethord) userInfo:nil repeats:YES];

            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //aaaaaa==%@", error.localizedDescription);
        [MBProgressHUD hideHUDForView:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    
}

#pragma mark 修改用户信息 将微信授权IMEI MAC传给后台
-(void)saveIMEI_MACHttpIMEI:(NSString*)imei MAC:(NSString*)macip
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *IMEI = [user objectForKey:USER_UUID];
    NSString *MAC = [user objectForKey:DECICETOKEN];//用devicetoken代替
    
    NSString *url=[NSString stringWithFormat:@"%@user/update_userinfo?version=%@&token=%@&imei=%@&mac=%@",[NSObject baseURLStr],VERSION,token,IMEI,MAC];
    if ([imei isEqualToString:@"更新unionid"]) {
        if(self.openid.length > 10)
        {
            url=[NSString stringWithFormat:@"%@user/update_userinfo?version=%@&token=%@&unionid=%@&wx_openid=%@",[NSObject baseURLStr],VERSION,token,self.unionid,self.openid];
        }else
            url=[NSString stringWithFormat:@"%@user/update_userinfo?version=%@&token=%@&unionid=%@",[NSObject baseURLStr],VERSION,token,self.unionid];
    }else
    if(imei.length < 10 && macip.length <10)
    {
        url=[NSString stringWithFormat:@"%@user/update_userinfo?version=%@&token=%@&imei=%@&mac=%@",[NSObject baseURLStr],VERSION,token,IMEI,MAC];
    }else{
        if(imei.length < 10){
            url=[NSString stringWithFormat:@"%@user/update_userinfo?version=%@&token=%@&imei=%@",[NSObject baseURLStr],VERSION,token,IMEI];
        }else if (macip.length <10){
            url=[NSString stringWithFormat:@"%@user/update_userinfo?version=%@&token=%@&mac=%@",[NSObject baseURLStr],VERSION,token,MAC];
        }
    }
    
    
    NSString *URL=[MyMD5 authkey:url];
    
    //    [[Animation shareAnimation] createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                MyLog(@"上传成功");
                
                if(self.unionid !=nil && ![self.unionid isEqual:[NSNull null]] && ![self.unionid containsString:@"<null>"])
                {
                     [user setObject:self.unionid forKey:UNION_ID];
                }
            }
            else{
                MyLog(@"上传失败");
                if ([imei isEqualToString:@"更新unionid"]&&self.unionid!=nil) {
                    [NavgationbarView showMessageAndHide:responseObject[@"message"]];
                }
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //网络连接失败");
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"保存失败,请重试!" Controller:self];
        [[Animation shareAnimation] stopAnimationAt:self.view];
    }];
    
}

#pragma mark 获取任务完成情况
- (void)httpGetMisson
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/getIntegral?token=%@&version=%@",[NSObject baseURLStr],token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                NSArray *fulFillArr = responseObject[@"fulfill"];
                if ([fulFillArr containsObject:@"18"]) {
                    [ud setBool:NO forKey:NoviciateTask_18_FLAG];
                } else {
                    [ud setBool:YES forKey:NoviciateTask_18_FLAG];
                }
                
                if ([fulFillArr containsObject:@"22"]) {
                    [ud setBool:NO forKey:NoviciateTask_22_FLAG];
                } else {
                    [ud setBool:YES forKey:NoviciateTask_22_FLAG];
                }
                
                if ([fulFillArr containsObject:@"23"]) {
                    [ud setBool:NO forKey:NoviciateTask_23_FLAG];
                } else {
                    [ud setBool:YES forKey:NoviciateTask_23_FLAG];
                }
                
                if ([fulFillArr containsObject:@"24"]) {
                    [ud setBool:NO forKey:NoviciateTask_24_FLAG];
                } else {
                    [ud setBool:YES forKey:NoviciateTask_24_FLAG];
                }
                
            } else {
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

#pragma mark - +++++++++++++++++++++第三方登录_完成按钮+++++++++++++++++++++
-(void)otherLogin:(UIButton*)sender
{
    
    //向微信注册
    //    [WXApi registerApp:@"wx8c5fe3e40669c535" withDescription:@"demo 2.0"];
    
    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app shardk];
    
    if(sender.tag==1000)
    {
        //QQ");
        [self shareSdkWithAutohorWithType:ShareTypeQQSpace];
        usertype=@"4";
        
    }else if(sender.tag==2000)
    {
        //WX");
        [self shareSdkWithAutohorWithType:ShareTypeWeixiFav];
        usertype=@"5";
    }else{
        //WB");
        [self shareSdkWithAutohorWithType:ShareTypeSinaWeibo];
        usertype=@"6";
    }
}

#pragma mark 第三方登录
-(void)shareSdkWithAutohorWithType:(ShareType)type

{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate shardk];
    
    // 取消授权
    [ShareSDK cancelAuthWithType:type];
    
    
    //    __weak typeof(self) wekSelf =self;
    
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
                                   
                                   id<ISSPlatformCredential> credential = [ShareSDK getCredentialWithType:type];
                                   
                                   MyLog(@"userInfo = %@",[userInfo sourceData]);
                                   //uid = %@", [userInfo uid]);
                                   
                                   NSDictionary *uniondic = (NSDictionary *)[userInfo sourceData];
                                   
                                   //unionid 111111= %@",uniondic[@"unionid"]);
                                   NSString *unionid = [NSString stringWithFormat:@"%@",uniondic[@"unionid"]];
                                   
                                   //如果是微信登录，直接用uid
                                   if (type == ShareTypeWeixiFav) {
                                       self.openid = [userInfo uid];
                                   }
                                   
                                   
                                   [MBProgressHUD showMessage:@"授权成功正在为你登录" afterDeleay:0 WithView:self.view];
                                   
                                   //上传第三方用户登录信息到服务器
                                   
                                   AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
                                   NSMutableDictionary *patamatrs=[NSMutableDictionary dictionary];
                                   
                                   NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
                                   
                                   NSString *IMEI =[user objectForKey:USER_UUID];
                                   NSString *devicetoken = [user objectForKey:DECICETOKEN];
                                   NSString *nickname = [userInfo nickname];
                                   NSString *IDFA =[user objectForKey:USER_IDFA];
                                   
                                   NSString *icon;
                                   if (usertype.intValue == 4) {
                                       icon = [userInfo sourceData][@"figureurl_qq_2"];
                                   } else {
                                       icon = [userInfo profileImage];
                                   }
                                   [[NSUserDefaults standardUserDefaults]setObject:[userInfo profileImage] forKey:USER_WX_HEADPIC];

                                   //1 男 2 女
                                   NSString *url;
                                   if([unionid isEqualToString:@"(null)"] || [unionid isEqual:[NSNull null]])
                                   {
                                       unionid = @"";
                                       MyLog(@"空空");
                                       url=[NSString stringWithFormat:@"%@user/userLogin?version=%@&wx_openid=%@&nickname=%@&pic=%@&token=%@&usertype=%d&device=2&imei=%@&deviceToken=%@&mac=%@&idfa=%@&gender=%zd",[NSObject baseURLStr],VERSION,[userInfo uid],nickname,icon,[credential token],usertype.intValue,IMEI,devicetoken,IMEI,IDFA,[userInfo gender]+1];
                                   }else{
                                       
                                       url=[NSString stringWithFormat:@"%@user/userLogin?version=%@&wx_openid=%@&nickname=%@&pic=%@&token=%@&usertype=%d&device=2&imei=%@&deviceToken=%@&unionid=%@&mac=%@&idfa=%@&gender=%zd",[NSObject baseURLStr],VERSION,[userInfo uid],nickname,icon,[credential token],usertype.intValue,IMEI,devicetoken,unionid,IMEI,IDFA,[userInfo gender]+1];
                                   }
                                   
                                   NSString *URL=[MyMD5 authkey:url];
                                   //URL IS %@",URL);
                                   
                                   [manager POST:URL parameters:patamatrs success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       
                                       
                                       MyLog(@"//第三方登录成功: %@",responseObject);
//                                       responseObject = [NSDictionary changeType:responseObject];
                                       if (responseObject!=nil) {
                                           if (![userInfo gender]){//男的直接返回
                                               [MBProgressHUD show:@"活动已结束，谢谢关注" icon:nil view:nil];
                                               [MBProgressHUD hideHUDForView:self.view];
                                               return ;
                                           }
                                           
                                           [Login doLogin:responseObject];
                                           
                                           
                                           NSString *str=responseObject[@"status"];
                                           NSString *token=responseObject[@"token"];
                                           
                                           //第三方登录成功 token = %@", token);
                                           
                                           //发送登录成功通知 只在详情用到
                                           NSNotification *notification=[NSNotification notificationWithName:@"zeroOrderChange" object:@"zeroOrderChange"];
                                           [[NSNotificationCenter defaultCenter] postNotification:notification];
                                           
                                           NSString *user_id = [NSString stringWithFormat:@"%@",responseObject[@"userinfo"][@"user_id"]];
                                           MyLog(@"user_id = %@",user_id);
                                           
                                           NSString *pwd = [NSString stringWithFormat:@"%@",responseObject[@"pwd"]];
                                           
                                           if(![responseObject[@"userinfo"][@"code_type"]isEqual:[NSNull null]])
                                           {
                                               [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"userinfo"][@"code_type"] forKey:CODE_TYPE];
                                           }
                                           
                                           if(![responseObject[@"userinfo"][@"phone"]isEqual:[NSNull null]])
                                           {
                                               [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"userinfo"][@"phone"] forKey:USER_PHONE];
                                           }
                                           
                                           //保存会员标识
                                           NSString *ismember = [NSString stringWithFormat:@"%@",responseObject[@"userinfo"][@"is_member"]];
                                           if(ismember)
                                           {
                                               [[NSUserDefaults standardUserDefaults] setObject:ismember forKey:USER_MEMBER];
                                               
                                           }
                                           
                                           if (![responseObject[@"userinfo"][@"hobby"] isKindOfClass:[NSNull class]])
                                               
                                           {
                                               [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"userinfo"][@"hobby"] forKey:USER_HOBBY];
                                               
                                               //%@",responseObject[@"userinfo"][@"hobby"]);
                                           }
                                           else
                                           {
                                               [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:USER_HOBBY];
                                           }
                                           
                                           NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                                           NSString *userName=[userInfo nickname].length>8?[[userInfo nickname]substringToIndex:8]:[userInfo nickname];
                                           [userdefaul setObject:userName forKey:USER_NAME];
                                           [userdefaul setObject:icon forKey:USER_HEADPIC];
                                           [userdefaul setObject:token forKey:USER_TOKEN];
                                           [userdefaul setObject:user_id forKey:USER_ID];
                                           [userdefaul setObject:@"user" forKey:USER_INFO];
                                           [userdefaul setObject:usertype forKey:USER_TYPE];
                                           [userdefaul setObject:uniondic[@"unionid"] forKey:UNION_ID];
                                           
                                           //保存IMEI
                                           NSString *imei = [NSString stringWithFormat:@"%@",responseObject[@"userinfo"][@"imei"]];
                                           if(imei !=nil || ![imei isEqual:[NSNull null]])
                                           {
                                               [userdefaul setObject:imei forKey:HTTP_IMEI];
                                           }
                                           
                                           //保存MAC地址
                                           NSString *macip= [NSString stringWithFormat:@"%@",responseObject[@"userinfo"][@"mac"]];
                                           
                                           if([imei isEqual:[NSNull null]] || [macip isEqual:[NSNull null]] ||imei == nil || macip == nil || imei.length < 10 || macip.length <10)
                                           {
                                               //如果IMEI MAC 为空就上传给后台
                                               [self saveIMEI_MACHttpIMEI:imei MAC:macip];
                                           }
                                           
                                           //保存分类用户
                                           NSString *userclassify = [NSString stringWithFormat:@"%@",responseObject[@"userType"]];
                                           if(userclassify !=nil || ![userclassify isEqual:[NSNull null]])
                                           {
                                               [userdefaul setObject:userclassify forKey:USER_CLASSIFY];
                                           }

                                           //H5赚钱金额
                                           NSString *h5money = [NSString stringWithFormat:@"%@",responseObject[@"userinfo"][@"h5money"]];
                                           [DataManager sharedManager].h5money = h5money.floatValue;
                                           [[DataManager sharedManager] getOrderHttp:YES];//引导支付订单
                                           [[DataManager sharedManager] getduobaoStatueHttp];//登录成功后查看夺宝获奖信息
                                           /*
                                           // begin 赵官林 2016.5.30
                                           if (IsRongCloub) {
                                               // 登录融云
                                               [[DataManager sharedManager] updateRcToken];
                                           } else {
                                               //环信注册
                                               NSString *password=[MyMD5 md5:@"123456"];
                                               [self registHuanxing:user_id Withword:password];
                                           }
                                           // end
                                           */
                                           
                                           [HTTPTarbarNum httpGetUserGrade];//何波加的2016-11-18
                                           
                                           //额外分享粉丝提醒
                                           AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                           [app goFuns];
                                        
                                           
                                           //金币金券
                                           [self getgoldCoupons];
                                           
                                           if(pwd.length >10)
                                           {
                                               [userdefaul setObject:pwd forKey:OTHER_PASSWORD];
                                           }
                                           
                                           [userdefaul setObject:responseObject[@"userinfo"][@"is_member"] forKey:USER_MEMBER];
                                           
                                           if (responseObject[@"userinfo"][@"pic"]!=[NSNull null]) {
                                               [userdefaul setObject:responseObject[@"userinfo"][@"pic"] forKey:USER_HEADPIC];
                                               
                                               NSString *picURL = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],responseObject[@"userinfo"][@"pic"]];
                                               AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                                               manager.responseSerializer = [AFImageResponseSerializer serializer];
                                               
                                               [manager GET:picURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                   //2.缓存图片到沙盒
                                                   NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),[userInfo uid]];
                                                   NSData *imgData = UIImagePNGRepresentation(responseObject);
                                                   [imgData writeToFile:aPath atomically:YES];
                                                   
                                                   NSNotification *noti = [NSNotification notificationWithName:@"imagenote" object:nil];
                                                   [[NSNotificationCenter defaultCenter] postNotification:noti];
                                                   
                                                   
                                               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                   //                        //error  %@",error);
                                                   //                        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
                                               }];
                                               
                                           }
                                           if (responseObject[@"userinfo"]!=nil) {
                                               [self saveUserInfomation:responseObject];
                                           }
                                            
                                           NSString *orderToken=responseObject[@"orderToken"];
                                           if (![orderToken isEqual:[NSNull null]]) {
                                               [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"orderToken"] forKey:ORDER_TOKEN];
                                           }else
                                               [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:ORDER_TOKEN];
                                           
                                           if(str.intValue==101)//选择标签页面
                                           {
                                               //上传信息成功");
                                               
                                               //保存当前用户登录/注册信息
                                               NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                                               NSString *userName=[userInfo nickname].length>8?[[userInfo nickname]substringToIndex:8]:[userInfo nickname];
                                               [userdefaul setObject:userName forKey:USER_NAME];
                                               [userdefaul setObject:token forKey:USER_TOKEN];
                                               [userdefaul setObject:[userInfo uid] forKey:USER_ID];
                                               [userdefaul setObject:@"user" forKey:USER_INFO];
                                               [userdefaul setObject:usertype forKey:USER_TYPE];
                                               
                                               if(![responseObject[@"store"] isEqual:[NSNull null]])
                                               {
                                                   if(![responseObject[@"store"][@"realm"]isEqual:[NSNull null]])
                                                   {
                                                       [userdefaul setObject:responseObject[@"store"][@"realm"] forKey:USER_REALM];
                                                   }
                                                   
                                                   if(![responseObject[@"store"][@"s_name"]isEqual:[NSNull null]])
                                                   {
                                                       [userdefaul setObject:responseObject[@"store"][@"s_name"] forKey:STORE_NAME];
                                                   }
                                                   
                                                   if(![responseObject[@"store"][@"s_code"]isEqual:[NSNull null]])
                                                   {
                                                       [userdefaul setObject:responseObject[@"store"][@"s_code"] forKey:STORE_CODE];
                                                   }
                                                   
                                               }
                                               
                                               if (![responseObject[@"userinfo"][@"hobby"]isEqual:[NSNull null]] && ![responseObject[@"userinfo"][@"hobby"]isEqualToString:@"0"]) {
                                                   [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"userinfo"][@"hobby"] forKey:USER_HOBBY];
                                                   //%@",responseObject[@"userinfo"][@"hobby"]);
                                               }else{
                                                   [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:USER_HOBBY];
                                               }
                                               
                                               
                                               
                                               [userdefaul synchronize];
                                               
                                               
                                               //环信注册
                                               NSString *password=[MyMD5 md5:@"123456"];
                                               
                                               [userdefaul setObject:password forKey:USER_PASSWORD];
                                               
//                                               [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:user_id password:password withCompletion:^(NSString *username, NSString *password, EMError *error) {
//                                                   if (!error) {
//
//                                                       //环信注册成功");
//
//                                                       //环信登录
//                                                       [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:user_id  password:password completion:^(NSDictionary *loginInfo, EMError *error) {
//
//                                                           if (!error) {
//                                                               //环信登陆成功");
//
//                                                               [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
//
//                                                           }
//                                                       } onQueue:nil];
//
//                                                   }else{
//                                                       MyLog(@"帐号存在");
//
//                                                       [self loginHuanxing:user_id Withword:password];
//                                                   }
//                                               } onQueue:nil];
                                               
                                               
                                               
                                               
                                               [self addTableBarViewControllers:@"1"];
                                               
                                           }else if(str.intValue==1)//直接到首页
                                           {
                                               
                                               //保存当前用户登录/注册信息
                                               NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                                               NSString *userName=[userInfo nickname].length>8?[[userInfo nickname]substringToIndex:8]:[userInfo nickname];
                                               [userdefaul setObject:userName forKey:USER_NAME];
                                               [userdefaul setObject:icon forKey:USER_HEADPIC];
                                               [userdefaul setObject:token forKey:USER_TOKEN];
                                               [userdefaul setObject:user_id forKey:USER_ID];
                                               [userdefaul setObject:@"user" forKey:USER_INFO];
                                               [userdefaul setObject:usertype forKey:USER_TYPE];
                                               [userdefaul setObject:responseObject[@"userinfo"][@"is_member"] forKey:USER_MEMBER];
                                               
                                               
                                               if(![responseObject[@"store"] isEqual:[NSNull null]])
                                               {
                                                   if(![responseObject[@"store"][@"realm"]isEqual:[NSNull null]])
                                                   {
                                                       [userdefaul setObject:responseObject[@"store"][@"realm"] forKey:USER_REALM];
                                                   }
                                                   
                                                   if(![responseObject[@"store"][@"s_name"]isEqual:[NSNull null]])
                                                   {
                                                       [userdefaul setObject:responseObject[@"store"][@"s_name"] forKey:STORE_NAME];
                                                   }
                                                   
                                                   if(![responseObject[@"store"][@"s_code"]isEqual:[NSNull null]])
                                                   {
                                                       [userdefaul setObject:responseObject[@"store"][@"s_code"] forKey:STORE_CODE];
                                                   }
                                                   
                                               }
                                               
                                               if (![responseObject[@"userinfo"][@"hobby"]isEqual:[NSNull null]] && ![responseObject[@"userinfo"][@"hobby"]isEqualToString:@"0"]) {
                                                   [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"userinfo"][@"hobby"] forKey:USER_HOBBY];
                                                   //%@",responseObject[@"userinfo"][@"hobby"]);
                                               }else{
                                                   [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:USER_HOBBY];
                                               }
                                               
                                               
                                               [userdefaul synchronize];
                                               
                                               //修改root
                                               //                                               [self addTableBarViewControllers:@"1"];
                                               
                                               [self httpGetMisson];
                                               
                                               NSString *phone = (NSString *)responseObject[@"userinfo"][@"phone"];
                                    
                                               if ([phone isEqual:[NSNull null]] || phone.length <= 0) {
                                                   if ([userInfo gender]) {
                                                       [self BindingPhone];
                                                   }else{
                                                       [MBProgressHUD show:@"活动已结束，谢谢关注" icon:nil view:nil];
                                                   }
                                                   
                                               }else
                                                   [self addTableBarViewControllers:@"1"];
                                               //如果是微信
                                               if (type == ShareTypeWeixiFav) {
                                                   [self httpSendOutOpenID];
                                               } else if (type == ShareTypeQQSpace && [[[NSUserDefaults standardUserDefaults] objectForKey:USER_GetSwitch] intValue] == 1) {
                                                   [self shareSdkWithAutohorWithTypeGetOpenID:@"31"];
                                                   
                                               } else if (type == ShareTypeSinaWeibo && [[[NSUserDefaults standardUserDefaults] objectForKey:USER_GetSwitch] intValue] == 1) {
                                                   [self shareSdkWithAutohorWithTypeGetOpenID:@"32"];
                                               }
                                               
                                               
                                               //环信注册
                                               NSString *password=[MyMD5 md5:@"123456"];
                                               [userdefaul setObject:password forKey:USER_PASSWORD];
                                               
//                                               [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:user_id password:password withCompletion:^(NSString *username, NSString *password, EMError *error) {
//                                                   if (!error) {
//
//                                                       //环信注册成功");
//
//                                                       //环信登录
//                                                       [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:user_id  password:password completion:^(NSDictionary *loginInfo, EMError *error) {
//
//                                                           if (!error) {
//                                                               //环信登陆成功");
//
//                                                               [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
//
//                                                           }else{
//                                                               //error is %@",error);
//                                                           }
//                                                       } onQueue:nil];
//
//                                                   }
//                                               } onQueue:nil];
                                               
                                               [MBProgressHUD hideHUDForView:self.view];
                                           }
                                           else{
                                               
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
                                   
                                   //分享失败,错误码:%ld,错误描述%@",(long)[error errorCode],[error errorDescription]);
                                   
                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"对不起，授权不成功，请重新授权" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                   
                                   [alertView show];
                                   
                               }
                               
                           }];
    
}

- (void)httpSendOutOpenID
{
    if (self.unionid!=nil && [[[NSUserDefaults standardUserDefaults] objectForKey:USER_GetSwitch] intValue] == 1) {
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *token = [ud objectForKey:USER_TOKEN];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@user/appDownLog?token=%@&version=%@&uid=%@",[NSObject baseURLStr],token,VERSION,self.unionid];
        
        NSString *URL = [MyMD5 authkey:urlStr];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
            //传openID = %@", responseObject);
            if([responseObject[@"status"] intValue]==1)
            {
                if(self.unionid !=nil && ![self.unionid isEqual:[NSNull null]] && ![self.unionid containsString:@"<null>"])
                {
                    [ud setObject:self.unionid forKey:UNION_ID];
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    }
}

// 获取OpenID
// flag 1.手机注册 2.邮箱注册 3.登录 31.QQ 32.微博
- (void)shareSdkWithAutohorWithTypeGetOpenID:(NSString *)flag {
    [self shareSdkWithAutohorWithTypeGetOpenID:flag dictionary:nil];
}
- (void)shareSdkWithAutohorWithTypeGetOpenID:(NSString *)flag dictionary:(NSDictionary *)dic {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate shardk];
    
    // 取消授权
    [ShareSDK cancelAuthWithType:ShareTypeWeixiFav];
    
    // 开始授权
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
    [app setIsAllowWebAuthorize:YES];
    
    [ShareSDK getUserInfoWithType:ShareTypeWeixiFav
                      authOptions:authOptions
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               /*
                               if (result==NO) {//授权失败
                                   [MBProgressHUD showError:@"授权失败"];
                                   return ;
                               }
                               */
                               if (result)
                               {
                                   
                                   //uid = %@", [userInfo uid]);
                                   //sourceData = %@", [userInfo sourceData]);
                                   //extInfo = %@", [[userInfo credential] extInfo]);
                                   
                                   NSDictionary *uniondic = (NSDictionary *)[userInfo sourceData];
                                   
                                   //unionid********** = %@",uniondic[@"unionid"]);
                                   
                                   self.openid = [userInfo uid];
                                   
                                   
                                   if(uniondic[@"unionid"] !=nil)
                                   {
                                       //何波修改2017-9-27
//                                       NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//                                       [user setObject:uniondic[@"unionid"] forKey:UNION_ID];
                                       self.unionid = [NSString stringWithFormat:@"%@",uniondic[@"unionid"]];
                                   }
                                   [[NSUserDefaults standardUserDefaults]setObject:[userInfo profileImage] forKey:USER_WX_HEADPIC];
                               }
                               
                               //向我们服务器注册
                               if ([flag intValue] == 1) { //手机注册
                                   
                                   [self RegistHttp];
                                   
                               } else if ([flag intValue] == 2) { //邮箱注册
                                   
                                   [self mailBoxRequestHttp];
                                   
                               } else if ([flag intValue] == 31||[flag intValue] == 32) { //第三方注册 QQ //第三方注册 微博
                                   
                                   [self httpSendOutOpenID];
                                   
                               }else if ([flag intValue]==3)//登录
                               {
                                   [self loginSuccessDoSomething:dic];
                               }
                               
                               NSString *errorStr = [NSString stringWithFormat:@"%@", [error errorDescription]];
                               if ([errorStr isEqualToString:@"尚未授权"]) {
                                   
                                   

                               }
                               
                           }];

}
#pragma mark - +++++++++++++++++++++环信登录注册+++++++++++++++++++++
#pragma mark 环信登录
- (void)loginHuanxing:(NSString*)userid Withword:(NSString*)password
{
    MyLog(@"user_id = %@ Password =%@",userid,password);
    
    //判断是否登录
//    BOOL isAutoLogin = [[EaseMob sharedInstance].chatManager isAutoLoginEnabled];
//    if (!isAutoLogin) {
//
//        //环信登录
//        [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:userid password:password completion:^(NSDictionary *loginInfo, EMError *error) {
//            if (!error ) {
//                //环信登陆成功");
//
//                [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
//
//                EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
//            }
//
//        } onQueue:nil];
//    }
    
}

#pragma mark 环信注册
- (void)registHuanxing:(NSString*)userid Withword:(NSString*)password
{
    //环信注册
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    [userdefaul setObject:password forKey:USER_PASSWORD];
    
    MyLog(@"userid = %@",userid);
    
//    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:userid password:password withCompletion:^(NSString *username, NSString *password, EMError *error) {
//        if (!error) {
//            //环信注册成功");
//            //环信登录
//            [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:userid  password:password completion:^(NSDictionary *loginInfo, EMError *error) {
//                
//                if (!error) {
//                    //环信登陆成功");
//                    [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
//                }
//            } onQueue:nil];
//        }else{
//            MyLog(@"帐号存在");
//            
//            [self loginHuanxing:userid Withword:password];
//        }
//    } onQueue:nil];
    
}

#pragma mark - +++++++++++++++++++++UITextFieldDelegate+++++++++++++++++++++
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.nowTextField = textField;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (_yanzhengfild == textField)
    {
        if ([toBeString length] > 10) {
            _yanzhengfild.text = [toBeString substringToIndex:10];
            return NO;
        }
    }
    
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self.view endEditing:YES];

    return YES;
}
-(void)textFieldDidChange :(UITextField *)theTextField{

    if (theTextField == _phonefild && [self isValidateMobile:theTextField.text]) {
        [self httpGetCodeView];
    }
    if(_NameFild.text.length >0 && _PassWordFild.text.length >0)
    {
        logbtn.backgroundColor = RGBCOLOR_I(228, 75, 131);
        
    }
    
    if(_phonefild.text.length >0 && _yanzhengfild.text.length >0 && _passwordfild.text.length >0)
    {
        registbtn.backgroundColor = RGBCOLOR_I(228, 75, 131);
        
    }

    if(_phonefild.text.length >0 && phoneCodeNum.text.length >0 )
    {
        phoneNextBtn.backgroundColor = RGBCOLOR_I(228, 75, 131);
    }

    
    if(_Emailfild.text.length >0 && _yanzhengfild.text.length >0 && _passwordfild.text.length >0)
    {
        emailRigstbtn.backgroundColor = RGBCOLOR_I(228, 75, 131);
        
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - +++++++++++++++++++++状态更改+++++++++++++++++++++
- (void)addTableBarViewControllers:(NSString *)st
{
    ///同步购物车数据
    [ShopCarManager loadDataNetwork];
    
    [MyMD5 changeMemberPriceRate];
    NSMutableArray *muArr = [NSMutableArray arrayWithArray:Mtarbar.viewControllers];
    
//    TFShoppingViewController *newHome = [[TFShoppingViewController alloc] init];
//    newHome.type = nil;
//    newHome.isFirst = YES;
//    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:newHome];
//    [muArr replaceObjectAtIndex:0 withObject:naVC];
    
    if (![self.loginStatue isEqualToString:@"toBack"]) {

        SearchTypeViewController *shopstore1= [[SearchTypeViewController alloc] init];
        UINavigationController *shopstoreNav=[[UINavigationController alloc]initWithRootViewController:shopstore1];
        [muArr replaceObjectAtIndex:1 withObject:shopstoreNav];
        
        TFIntimateCircleVC *inCircleVC = [[TFIntimateCircleVC alloc] init];
        UINavigationController *CartNav=[[UINavigationController alloc]initWithRootViewController:inCircleVC];
        [muArr replaceObjectAtIndex:2 withObject:CartNav];

        NewShoppingCartViewController *shopcart=[[NewShoppingCartViewController alloc]init];
        shopcart.ShopCart_Type = ShopCart_TarbarType;
        
//        MakeMoneyViewController *money = [[MakeMoneyViewController alloc]init];
//        money.MakeMoney_Type = MakeMoney_NTarbarType;
        
        UINavigationController *homeSignNav=[[UINavigationController alloc]initWithRootViewController:shopcart];
        [muArr replaceObjectAtIndex:3 withObject:homeSignNav];

        MymineViewController *mymine=[[MymineViewController alloc]init];
        UINavigationController *mymineNav=[[UINavigationController alloc]initWithRootViewController:mymine];
        [muArr replaceObjectAtIndex:4 withObject:mymineNav];
    }
    Mtarbar.viewControllers = muArr;
    
    [self rootviewcontroller];
    [self changeTabbarCartNum];
    
    
    if ([st intValue] == 1) {
        if (self.myLoginBlock!=nil) {
            self.myLoginBlock();
        }
    } else if ([st intValue] ==2) {
        if (self.myRegisterBlock!=nil) {
            self.myRegisterBlock();
        }
    }
}

#pragma mark - +++++++++++++++++++++生日地址个性签名+++++++++++++++++++++
-(void)saveUserInfomation:(NSDictionary *)responseObject
{
    [MyMD5 changeMemberPriceRate];
    
    if (![responseObject[@"userinfo"][@"v_ident"]isEqual:[NSNull null]]) {
//        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"v_ident"] forKey:USER_V_IDENT];
        [[NSUserDefaults standardUserDefaults]setInteger:[responseObject[@"userinfo"][@"v_ident"]integerValue] forKey:USER_V_IDENT];
    }else
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:USER_V_IDENT];

    
    NSString *orderToken=responseObject[@"orderToken"];
    if (![orderToken isEqual:[NSNull null]]) {
        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"orderToken"] forKey:ORDER_TOKEN];
    }else
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:ORDER_TOKEN];
    
    
    NSString *birthday = responseObject[@"userinfo"][@"birthday"];
    if (![birthday isEqual:[NSNull null]]) {
        
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate* inputDate = [inputFormatter dateFromString:birthday];
        
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setLocale:[NSLocale currentLocale]];
        [outputFormatter setDateFormat:@"yyyy年MM月dd日"];
        NSString *oneDayStr = [outputFormatter stringFromDate:inputDate];
        
        [[NSUserDefaults standardUserDefaults] setObject:oneDayStr forKey:USER_BIRTHDAY];
    }else
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:USER_BIRTHDAY];
    
    
    
    NSString *stateID=responseObject[@"userinfo"][@"province"];
    NSString *cityID=responseObject[@"userinfo"][@"city"];
    if (![stateID isEqual:[NSNull null]] && ![cityID isEqual:[NSNull null]]) {
        NSArray *array=[self getAddressStateID:responseObject[@"userinfo"][@"province"] withCityID:responseObject[@"userinfo"][@"city"] witAreaID:nil withStreetID:nil];
        if(array.count >= 2)
        {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@%@",array[0],array[1]] forKey:USER_ARRER];
        }
    }else
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@""] forKey:USER_ARRER];
    
    if (![responseObject[@"userinfo"][@"person_sign"]isEqual:[NSNull null]]) {
        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"userinfo"][@"person_sign"] forKey:USER_PERSON_SIGN];
    }else
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:USER_PERSON_SIGN];
    
    if(![responseObject[@"userinfo"][@"code_type"]isEqual:[NSNull null]])
    {
        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"userinfo"][@"code_type"] forKey:CODE_TYPE];
    }
    
    if (![responseObject[@"userinfo"][@"hobby"]isEqual:[NSNull null]] && ![responseObject[@"userinfo"][@"hobby"]isEqualToString:@"0"]) {
        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"userinfo"][@"hobby"] forKey:USER_HOBBY];
        //%@",responseObject[@"userinfo"][@"hobby"]);
    }else
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:USER_HOBBY];
    
    
    if (![responseObject[@"store"] isEqual:[NSNull null]]) {
        NSString *storecode=[NSString stringWithFormat:@"%@",responseObject[@"store"][@"s_code"]];
        //保存店铺信息
        [[NSUserDefaults standardUserDefaults] setObject:storecode forKey:STORE_CODE];
    }
    [HTTPTarbarNum httpRedCount];
    [HTTPTarbarNum httpGetUserGrade];
    
}

#pragma mark - +++++++++++++++++++++环境切换+++++++++++++++++++++
- (void)addChangeBaseURLGesture
{
    UIView *changeBaseURLView = [UIView new];
    if (My_DEBUG) {
        [self.view addSubview:changeBaseURLView];
    }
    
    changeBaseURLView.backgroundColor = [UIColor clearColor];
    ESWeakSelf;
    [changeBaseURLView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(__weakSelf.view).offset(20);
        make.centerX.equalTo(__weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(80, 44));
    }];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRClick:)];
    tapGR.numberOfTapsRequired = 3; //3下
    [changeBaseURLView addGestureRecognizer:tapGR];
}

- (void)tapGRClick:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateRecognized) {
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"API选择" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"正式" otherButtonTitles:@"测试", @"欧阳", @"小戴", @"石凯", @"付海", @"敦峰", nil];
        [sheet showWithInView:self.view withBlock:^(NSInteger buttonIndex) {
            //MyLog(@"buttonIndex: %ld", (long)buttonIndex);
            if (buttonIndex!=7) {
                [NSObject changeBaseURLStrToIndex:buttonIndex];
                UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"您已成功切换了API环境，请刷新页面！"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertV showWithBlock:^(NSInteger buttonIndex) {
                    
                }];
            }
        }];
        
    }
}

#pragma mark - +++++++++++++++++++++other+++++++++++++++++++++
#pragma mark 金币金券
- (void)getgoldCoupons
{
    [GoldCouponModel getGoldCoupons:@"twofoldnessGold" success:^(id data) {
        GoldCouponModel *goldmodel = data;
        GoldModel *model= goldmodel.twofoldnessGold;
        if(goldmodel.status == 1){
            if(model.end_date !=0 && model.gid !=0)
            {
                [GoldCouponsManager goldcpManager].gold_end_date = model.end_date;
                
                [GoldCouponsManager goldcpManager].gold_id = model.gid;
                [GoldCouponsManager goldcpManager].gold_is_open = YES;
            }else{
                [GoldCouponsManager goldcpManager].gold_is_open = NO;
            }
        }else{
            [GoldCouponsManager goldcpManager].gold_is_open = NO;
        }
        
    }];
    
    
    [GoldCouponModel getGoldCoupons:@"CpGold" success:^(id data) {
        GoldCouponModel *goldmodel = data;
        GoldcpModel *model = goldmodel.CpGold;
        if(goldmodel.status == 1){
            
            if(model.end_date !=0 && model.c_id !=0)
            {
                [GoldCouponsManager goldcpManager].is_open = YES ;
                [GoldCouponsManager goldcpManager].goldcp_end_date = model.end_date;
                [GoldCouponsManager goldcpManager].c_last_time = model.c_last_time;
                [GoldCouponsManager goldcpManager].c_price = model.c_price;
                [GoldCouponsManager goldcpManager].is_use = model.is_use;
                [GoldCouponsManager goldcpManager].c_id = model.c_id;
            }else{
                [GoldCouponsManager goldcpManager].is_open = NO;
            }
        }else{
            [GoldCouponsManager goldcpManager].is_open = NO;
        }
        
    }];
    
}

#pragma mark 修改rootviewcontroller
-(void)rootviewcontroller
{
    [MyMD5 removeSearchHistory];
    
//    [self reloadSecretFriendViewController];
    
    if ([self.loginStatue isEqualToString:@"toBack"]) {
        
    } else if ([self.loginStatue isEqualToString:@"0"]) {
        Mtarbar.selectedIndex=0;
    } else if ([self.loginStatue isEqualToString:@"4"]){
        Mtarbar.selectedIndex=4;
    } else{
        Mtarbar.selectedIndex=0;
    }
    [self back:nil];
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

-(void)shouye:(NSNotification*)note
{
    Mtarbar.selectedIndex=0;
    
}

-(void)BindingPhoneSuccess
{
    [self addTableBarViewControllers:@"1"];
}
/**
 *  绑定手机
 */
-(void)BindingPhone{
    //    TFOldPaymentViewController *tovc = [[TFOldPaymentViewController alloc] init];
    //    tovc.headTitle = @"绑定手机";
    //    tovc.leftStr = @"手机号码";
    //    tovc.plaStr = @"输入您要绑定的手机号";
    //    tovc.index = 1;
//    BoundPhoneVC *tovc = [[BoundPhoneVC alloc] init];
    
    NSNumber *number = [[NSUserDefaults standardUserDefaults]objectForKey:USER_LoginType];
    if (number.integerValue==2) {
        BoundPhoneVC *tovc = [[BoundPhoneVC alloc] init];
        [self.navigationController pushViewController:tovc animated:YES];
    }else{
        NewUserBoundPhoneVC *view=[[NewUserBoundPhoneVC alloc]init];
        [self.navigationController pushViewController:view animated:YES];
    }
}

- (void)removeNoviceTask
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:NoviciateTaskFive];
    [ud removeObjectForKey:NoviciateTaskSix];
    [ud removeObjectForKey:NoviciateTask_18_FLAG];
    [ud removeObjectForKey:NoviciateTask_22_FLAG];
    [ud removeObjectForKey:NoviciateTask_23_FLAG];
    [ud removeObjectForKey:NoviciateTask_24_FLAG];
}

- (void)setNoviceFlag
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:YES forKey:NoviciateTask_18_FLAG];
    [ud setBool:YES forKey:NoviciateTask_22_FLAG];
    [ud setBool:YES forKey:NoviciateTask_23_FLAG];
    [ud setBool:YES forKey:NoviciateTask_24_FLAG];
}

-(NSString*)filePath
{
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory=[path objectAtIndex:0];
    //%@",documentDirectory);
    return [documentDirectory stringByAppendingPathComponent:FILE_USER];
}



// block异步方法
- (void)asyncUpdatePushOptions:(EMPushNotificationOptions *)options
                    completion:(void (^)(EMPushNotificationOptions *options, EMError *error))completion
                       onQueue:(dispatch_queue_t)aQueue;
{
    
}

- (void)keyboardShow:(NSNotification *)notf
{
    NSDictionary *userInfo = notf.userInfo;
    CGRect keyboardFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    CGRect textFrame = self.nowTextField.frame;
    CGFloat y = CGRectGetMaxY(textFrame) - CGRectGetMinY(keyboardFrame);
    
    if (y + Height_NavBar> 0) {
        CGFloat y = CGRectGetMinY(keyboardFrame) - CGRectGetMaxY(textFrame);
        CGRect frame = _bigview.frame;
        frame.origin.y = y;
        _bigview.frame = frame;
    }
}

- (void)keyboardHide:(NSNotification *)notf
{
    CGRect frame = _bigview.frame;
    frame.origin.y = Height_NavBar;
    _bigview.frame = frame;
}



#pragma mark 小店红点标记
- (void)redMark
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDate * nowDate = [ud objectForKey:MARK_STORE];
    
    if(nowDate)
    {
        NSString *daystr = [MyMD5 compareDate:nowDate];
        
        if([daystr isEqualToString:@"今天"])
        {
            [Mtarbar hideBadgeOnItemIndex:0];
            
        }else if ([daystr isEqualToString:@"昨天"])
        {
            if(Mtarbar.selectedIndex == 0)
            {
                [Mtarbar hideBadgeOnItemIndex:0];
            }else{
                [Mtarbar showBadgeOnItemIndex:0];
            }
            
            [ud removeObjectForKey:MARK_STORE];
        }
    }
    else{
        
        [Mtarbar showBadgeOnItemIndex:0];
    }
    
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


- (void)returnClick:(loginBlock)myLogin withCloseBlock:(registerBlock)myRegister
{
    self.myLoginBlock = myLogin;
    self.myRegisterBlock = myRegister;
}

- (BOOL)isString:(NSString *)Sstring toCompString:(NSString *)CompString
{
    if (Sstring.length!=0) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:CompString] invertedSet];
        NSArray *arrayStr = [Sstring componentsSeparatedByCharactersInSet:cs];
        NSString *tmpStr = [arrayStr componentsJoinedByString:@""];
        BOOL bl = [Sstring isEqualToString:tmpStr];
        return bl;
    } else
        return NO;
}

@end
