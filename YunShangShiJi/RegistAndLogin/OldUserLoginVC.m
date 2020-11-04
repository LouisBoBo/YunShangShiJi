//
//  OldUserLoginVC.m
//  YunShangShiJi
//
//  Created by yssj on 16/9/22.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "OldUserLoginVC.h"
#import "GlobalTool.h"
#import "NavgationbarView.h"
#import "FindPasswordViewController.h"
#import "AppDelegate.h"
//#import "referenceViewController.h"
#import "ShopCarManager.h"
#import "TFHomeViewController.h"
#import "TFShoppingViewController.h"

#import "MymineViewController.h"
#import "HTTPTarbarNum.h"
#import "SearchTypeViewController.h"
#import "NewShoppingCartViewController.h"
#import "TFIntimateCircleVC.h"
#import "TopicPublicModel.h"
@interface OldUserLoginVC ()<UITextFieldDelegate>
{
    UIView *_bigview;
    //登录呢称
    UITextField *_NameFild;
    //登录密码
    UITextField *_PassWordFild;
    UIImageView *_logseeimage; //登录是否可看按钮
    BOOL _logissee;

    UIButton *logbtn;//登录按钮

    NavgationbarView *_mentionview;//提示框
    //是否是邮箱
    BOOL EmailOK;
    //是否是手机号码
    BOOL isCorrect;

}
@end

@implementation OldUserLoginVC

- (void)viewWillAppear:(BOOL)animated
{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app removeNotification];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    _mentionview = [[NavgationbarView alloc]init];


    [self setNavigationView];
    [self setMainView];
}
// 登录流程修改（3.3.9）
-(void)setNavigationView{
    UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2-90, 25, 180, 30)];
    title.centerY = View_CenterY(headview);
    title.font = kNavTitleFontSize;
    title.textColor=kMainTitleColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.text=@"老用户登录";
    [headview addSubview:title];
    
}
-(void)setMainView{
    _bigview=[[UIView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kScreenHeight-Height_NavBar)];
    _bigview.backgroundColor = RGBCOLOR_I(244, 245, 246);
    [self.view addSubview:_bigview];

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

    [_bigview addSubview:backview];
    [_bigview addSubview:logbtn];
    [_bigview addSubview:losspassbtn];

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
    if(range.length>0) {//是邮箱
        EmailOK=[self isValidateEmail:phoneStr];
        if(EmailOK!=YES){
            [_mentionview showLable:@"输入邮箱不合法,请重新设置" Controller:self];
            return;
        }
    }else{//是手机号码
        isCorrect = [self isValidateMobile:phoneStr];
        if (isCorrect) { //是手机号码");
        }   else {//不是手机号码");
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
#pragma mark - +++++++++++++++++++++网络部分+++++++++++++++++++++

#pragma mark 手机/邮箱/网络请求登录
-(void)loginHttp
{
    // 1.创建网络请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *Password=[MyMD5 md5:_PassWordFild.text];
    
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *devicetoken = [userdefaul objectForKey:DECICETOKEN];
    
    NSString *url = [NSString stringWithFormat:@"%@user/login?version=%@&account=%@&pwd=%@&device=2&deviceToken=%@", [NSObject baseURLStr],VERSION,_NameFild.text,Password,devicetoken];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *URL=[MyMD5 authkey:url];
    [MBProgressHUD showMessage:@"正在验证登录" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        MyLog(@"token=%@,\nresponseObject = %@ ",responseObject[@"token"],responseObject);

        NSString *str = responseObject[@"status"];
        if ( str.intValue == 1) {
            
            //发送登录成功通知 只在详情用到
            NSNotification *notification=[NSNotification notificationWithName:@"zeroOrderChange" object:@"zeroOrderChange"];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            [Login doLogin:responseObject];
            
            [MBProgressHUD hideHudForView:self.view];
            [self.view endEditing:YES];
            
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
            
            //保存unionid
            NSString *unionid = [NSString stringWithFormat:@"%@",responseObject[@"userinfo"][@"unionid"]];
            if(unionid !=nil && ![unionid isEqual:[NSNull null]] && ![unionid isEqualToString:@"<null>"])
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
            
            
            //保存hobby
            if (![responseObject[@"userinfo"][@"hobby"]isEqual:[NSNull null]] && ![responseObject[@"userinfo"][@"hobby"]isEqualToString:@"0"]) {
                [userdefaul setObject:responseObject[@"userinfo"][@"hobby"] forKey:USER_HOBBY];
                
            }else
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:USER_HOBBY];
            
            //保存分类用户
            NSString *userclassify = [NSString stringWithFormat:@"%@",responseObject[@"userType"]];
            if(userclassify !=nil && ![userclassify isEqual:[NSNull null]])
            {
                [userdefaul setObject:userclassify forKey:USER_CLASSIFY];
            }

            //---%@",responseObject[@"userinfo"][@"nickname"]);
            NSString *User_id = [ud objectForKey:USER_ID];
            
            
            // begin 赵官林 2016.5.30
            if (IsRongCloub) {
                // 登录融云
                [[DataManager sharedManager] updateRcToken];
            } else {
                //登录环信
                [self loginHuanxing:user_id Withword:Password];
            }
            // end
            
            //H5赚钱金额
            NSString *h5money = [NSString stringWithFormat:@"%@",responseObject[@"userinfo"][@"h5money"]];
            [DataManager sharedManager].h5money = h5money.floatValue;
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
            
            
        } else if (str.intValue == 101)//请选择标签
        {
            NSString *user_id=[NSString stringWithFormat:@"%@",responseObject[@"userinfo"][@"user_id"]];
            
            //+++++++保存当前用户登录信息+++++++
            NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
            //            [ud setObject:_NameFild.text forKey:USER_NAME];
            [ud setObject:_PassWordFild.text forKey:USER_PASSWORD];
            [ud setObject:@"user" forKey:USER_INFO];
            
            [ud setObject:responseObject[@"userinfo"][@"nickname"] forKey:USER_NAME];
            [ud setObject:responseObject[@"userinfo"][@"is_member"] forKey:USER_MEMBER];
            [ud setObject:responseObject[@"userinfo"][@"code_type"] forKey:CODE_TYPE];
            
            if (![responseObject[@"store"] isEqual:[NSNull null]]) {
                [ud setObject:responseObject[@"store"][@"realm"] forKey:USER_REALM];
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
            
        }
        /*
        else if (str.intValue==1051){
            
            NSString *token = responseObject[@"token"];
            NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
            
            //+++++++保存当前用户登录信息+++++++
            NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
            //            [ud setObject:_NameFild.text forKey:USER_NAME];
            [ud setObject:_PassWordFild.text forKey:USER_PASSWORD];
            [ud setObject:@"user" forKey:USER_INFO];
            
            [ud setObject:responseObject[@"userinfo"][@"nickname"] forKey:USER_NAME];
            [ud setObject:responseObject[@"userinfo"][@"is_member"] forKey:USER_MEMBER];
            
            [ud setObject:responseObject[@"userinfo"][@"code_type"] forKey:CODE_TYPE];
            if (![responseObject[@"store"] isEqual:[NSNull null]]) {
                [ud setObject:responseObject[@"store"][@"user_id"] forKey:USER_ID];
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
            
//            referenceViewController *refrence = [[referenceViewController alloc]init];
//            refrence.array=[NSArray arrayWithArray:_headArray];
//            refrence.nameArray=[NSArray arrayWithArray:_NameArray];
//            [self.navigationController pushViewController:refrence animated:YES];
        }
        */
        else {
            
            [MBProgressHUD hideHudForView:self.view];
            
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
    if(imei.length < 10 && macip.length <10){
        url=[NSString stringWithFormat:@"%@user/update_userinfo?version=%@&token=%@&imei=%@&mac=%@",[NSObject baseURLStr],VERSION,token,IMEI,MAC];
    }else{
        if(imei.length < 10){
            url=[NSString stringWithFormat:@"%@user/update_userinfo?version=%@&token=%@&imei=%@",[NSObject baseURLStr],VERSION,token,IMEI];
        }else if (macip.length <10){
            url=[NSString stringWithFormat:@"%@user/update_userinfo?version=%@&token=%@&mac=%@",[NSObject baseURLStr],VERSION,token,MAC];
        }
    }
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
                if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            if(str.intValue==1)    {
                MyLog(@"上传成功");
            }else{
                MyLog(@"上传失败");
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //网络连接失败");
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"保存失败,请重试!" Controller:self];
        [[Animation shareAnimation] stopAnimationAt:self.view];
    }];
    
}
#pragma mark - +++++++++++++++++++++环信登录注册+++++++++++++++++++++
#pragma mark 环信登录
- (void)loginHuanxing:(NSString*)userid Withword:(NSString*)password
{
    MyLog(@"user_id = %@ Password =%@",userid,password);
    //判断是否登录
//    BOOL isAutoLogin = [[EaseMob sharedInstance].chatManager isAutoLoginEnabled];
//    if (!isAutoLogin) {//环信登录
//        [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:userid password:password completion:^(NSDictionary *loginInfo, EMError *error) {
//            if (!error ) {//环信登陆成功");
//                [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
//                EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
//            }
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
-(void)textFieldDidChange :(UITextField *)theTextField{
    
    if(_NameFild.text.length >0 && _PassWordFild.text.length >0)
    {
        logbtn.backgroundColor = RGBCOLOR_I(228, 75, 131);
        
    }
    
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

#pragma mark - +++++++++++++++++++++状态更改+++++++++++++++++++++
- (void)addTableBarViewControllers:(NSString *)st
{
    ///同步购物车数据
    [ShopCarManager loadDataNetwork];
    
    [MyMD5 changeMemberPriceRate];
    NSMutableArray *muArr = [NSMutableArray arrayWithArray:Mtarbar.viewControllers];
    
//    TFShoppingViewController *newHome = [[TFShoppingViewController alloc] init];
////    newHome.type = nil;
////    newHome.isFirst = YES;
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
        if (self.oldmyLoginBlock!=nil) {
            self.oldmyLoginBlock();
        }
    }
}

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
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self back:nil];
}
#pragma mark 返回上一视图
-(void)back:(UIButton*)btn
{
    [self.view endEditing:YES];
    
//    if ((self.navigationController.viewControllers.firstObject == self) || (self.presentedViewController)) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    } else {
//        // 跳转到首页
//        if (Mtarbar.selectedIndex==4||[self.loginStatue isEqualToString:@"10030"]) {
//            Mtarbar.selectedIndex=1;
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        } else
            [self.navigationController popViewControllerAnimated:YES];
//    }
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
