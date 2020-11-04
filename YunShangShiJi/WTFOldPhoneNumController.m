//
//  WTFOldPhoneNumController.m
//  YunShangShiJi
//
//  Created by yssj on 16/2/29.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "WTFOldPhoneNumController.h"
#import "WTFNewPhoneNumController.h"

@interface WTFOldPhoneNumController ()
{
    UITextField *SecurityCode;
    UITextField *imageCodeFild;
    UIImageView *pictureCodeView;
    UIButton *sendCodeBtn;
}
@property(nonatomic, assign) int secondsCountDown;
@property(nonatomic, strong) NSTimer *countDownTimer;
@end

@implementation WTFOldPhoneNumController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self setNavigationItemLeft:@"验证原手机号"];
    [self creatMainView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self httpGetCodeView:_oldPhoneNum];
}
-(void)tapGseAction
{
    [self.view endEditing:YES];
}

#pragma mark 图片验证码
- (void)httpGetCodeView:(NSString*)phone {
    
    NSString *IMEI = [[NSUserDefaults standardUserDefaults] objectForKey:USER_UUID];
    NSString *url = [NSString stringWithFormat:@"%@vcode/getVcode?version=%@&phone=%@&imei=%@",[NSObject baseURLStr],VERSION,phone,IMEI];
    NSString *URL=[MyMD5 authkey:url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    request.timeoutInterval = 3;
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    if ([response.MIMEType containsString:@"image"]) {
        for (UIView *view in pictureCodeView.subviews) {
            [view removeFromSuperview];
        }
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ZOOM6(250), ZOOM6(60))];
        [webView setScalesPageToFit: YES];
        [webView setBackgroundColor: [UIColor clearColor]];
        [webView setOpaque: 0];
        [pictureCodeView addSubview:webView];
        [webView loadData:data MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL URLWithString:@""]];
        [webView setUserInteractionEnabled:NO];
    }else if ([response.MIMEType containsString:@"text"]) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [MBProgressHUD show:responseObject[@"message"] icon:nil view:self.view];
    }
}
- (void)getPicture:(UITapGestureRecognizer*)tap
{
    [self httpGetCodeView:_oldPhoneNum];
}

-(void)creatMainView
{
    UIScrollView *myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar)];
    //%f",kScreenHeight);
    myScrollView.contentSize=CGSizeMake(kScreenWidth, kScreenHeight>=568?kScreenHeight-Height_NavBar:500);
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGseAction)];
    [myScrollView addGestureRecognizer:tapGes];
    myScrollView.keyboardDismissMode  = UIScrollViewKeyboardDismissModeOnDrag;
    
    [self.view addSubview:myScrollView];
    
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 1)];
    topLine.backgroundColor=lineGreyColor;
    [myScrollView addSubview:topLine];
    
    UILabel *oldPhoneNum=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topLine.frame)+20, kScreenWidth, 30)];
    oldPhoneNum.textAlignment=NSTextAlignmentCenter;
    oldPhoneNum.textColor=tarbarrossred;
    oldPhoneNum.text=[NSString stringWithFormat:@"当前手机号 : %@****%@",[_oldPhoneNum substringToIndex:3],[_oldPhoneNum substringWithRange:NSMakeRange(_oldPhoneNum.length-4, 4)]];
    [myScrollView addSubview:oldPhoneNum];
    
    UILabel *remindLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(oldPhoneNum.frame)+10, kScreenWidth, 30)];
    remindLabel.textAlignment=NSTextAlignmentCenter;
    remindLabel.textColor=kTextColor;
    remindLabel.text=@"更换后，下次登录可使用新手机号登录";
    [myScrollView addSubview:remindLabel];
    
    UIView *Line1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(remindLabel.frame)+20, kScreenWidth, 1)];
    Line1.backgroundColor=lineGreyColor;
    [myScrollView addSubview:Line1];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), CGRectGetMaxY(Line1.frame), 100, 50)];
    label1.text=@"原手机号";
    [myScrollView addSubview:label1];
    UILabel *oldPhoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), CGRectGetMaxY(Line1.frame), kScreenWidth, 50)];
    oldPhoneLabel.textColor=kTextColor;
    oldPhoneLabel.text=[NSString stringWithFormat:@"%@****%@",[_oldPhoneNum substringToIndex:3],[_oldPhoneNum substringWithRange:NSMakeRange(_oldPhoneNum.length-4, 4)]];
    [myScrollView addSubview:oldPhoneLabel];
    
    UIView *Line2 = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(62), CGRectGetMaxY(label1.frame), kScreenWidth, 1)];
    Line2.backgroundColor=lineGreyColor;
    [myScrollView addSubview:Line2];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), CGRectGetMaxY(Line2.frame), 100, 50)];
    label2.text=@"图片验证码";
    [myScrollView addSubview:label2];
    
    imageCodeFild=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame), CGRectGetMaxY(Line2.frame), kScreenWidth, 50)];
    imageCodeFild.textColor=kTextColor;
    imageCodeFild.placeholder=@"图片验证码";
    [myScrollView addSubview:imageCodeFild];
    
    pictureCodeView = [[UIImageView alloc]init];
    pictureCodeView.frame=CGRectMake(kScreenWidth-15-ZOOM6(250), CGRectGetMaxY(Line2.frame)+10, ZOOM6(250), 30);
    [myScrollView addSubview:pictureCodeView];
    pictureCodeView.layer.cornerRadius = ZOOM6(30);
    pictureCodeView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getPicture:)];
    [pictureCodeView addGestureRecognizer:tap];
    
    UIView *Line3 = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(62), CGRectGetMaxY(label2.frame), kScreenWidth, 1)];
    Line3.backgroundColor=lineGreyColor;
    [myScrollView addSubview:Line3];

    
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), CGRectGetMaxY(Line3.frame), 80, 50)];
    label3.text=@"验证码";
    [myScrollView addSubview:label3];
    SecurityCode=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame), CGRectGetMaxY(Line3.frame), kScreenWidth, 50)];
    SecurityCode.textColor=kTextColor;
    SecurityCode.placeholder=@"输入验证码";
    [myScrollView addSubview:SecurityCode];
    
    sendCodeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    sendCodeBtn.frame=CGRectMake(kScreenWidth-ZOOM(62)-100, CGRectGetMaxY(Line3.frame)+5, 100, 40);
    sendCodeBtn.backgroundColor=tarbarrossred;
    [sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [sendCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendCodeBtn addTarget:self action:@selector(sendCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside ];
    [myScrollView addSubview:sendCodeBtn];
    
    UIView *Line4 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label3.frame), kScreenWidth, 1)];
    Line4.backgroundColor=lineGreyColor;
    [myScrollView addSubview:Line4];
    
    UIButton *nextBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame=CGRectMake(label1.frame.origin.x, CGRectGetMaxY(Line4.frame)+20, kScreenWidth-ZOOM(62)*2, 50);
    nextBtn.backgroundColor=[UIColor blackColor];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [myScrollView addSubview:nextBtn];
    
//    UIButton *phoneMissBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    phoneMissBtn.frame=CGRectMake(label1.frame.origin.x, CGRectGetMaxY(nextBtn.frame), kScreenWidth-ZOOM(62)*2, 50);
//    [phoneMissBtn setTitle:@"原手机号码丢失?" forState:UIControlStateNormal];
//    [phoneMissBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [phoneMissBtn addTarget:self action:@selector(phoneMissBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [myScrollView addSubview:phoneMissBtn];
    
    UILabel *illustration=[[UILabel alloc]initWithFrame:CGRectMake(label1.frame.origin.x, CGRectGetMaxY(nextBtn.frame)+ZOOM(62)+20, nextBtn.frame.size.width, 100)];
    illustration.numberOfLines=0;
    illustration.textColor=kTextColor;
    illustration.text=@"说明\n修改绑定手机后，原手机不能用于登录；您可以使用更换后到手机号进行登录";
    [myScrollView addSubview:illustration];
    
}
-(void)sendCodeBtnClick:(UIButton *)sender
{
    _secondsCountDown=120;
    [self httpSendOldPhoneCode];
}
-(void)nextBtnClick:(UIButton *)sender
{
    [self httpCheckOldPhoneCode];
//    WTFNewPhoneNumController *view=[[WTFNewPhoneNumController alloc]init];
//    view.oldPhoneNum=_oldPhoneNum;
//    [self.navigationController pushViewController:view animated:YES];
}
//-(void)phoneMissBtnClick:(UIButton *)sender
//{
//    
//}

#pragma mark 验证码倒计时
- (void)timerFireMethord
{
    
    self.secondsCountDown --;
    
    sendCodeBtn.userInteractionEnabled=NO;
    [sendCodeBtn setTitle:[NSString stringWithFormat:@"%ds后重发", self.secondsCountDown] forState:UIControlStateNormal];
    
    if (self.secondsCountDown == 0)
    {
        //倒计时结束自动刷新图片验证码
        [self httpGetCodeView:_oldPhoneNum];
        
        [self.countDownTimer invalidate];
        sendCodeBtn.userInteractionEnabled=YES;
        [sendCodeBtn setTitle:@"获取验证码"forState:UIControlStateNormal];
        
    }
    
}

#pragma mark - 发送旧手机短信验证码接口
- (void)httpSendOldPhoneCode
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@user/old_code?version=%@&token=%@&vcode=%@",[NSObject baseURLStr],VERSION,token,imageCodeFild.text];
    NSString *URL = [MyMD5 authkey:urlStr];
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        //
        MyLog(@"responseObject = %@",responseObject);
        if (responseObject!=nil) {
            if ([responseObject[@"status"]integerValue]==1) {
                if ([self.countDownTimer isValid]) {
                    [self.countDownTimer invalidate];
                }
                self.countDownTimer = [NSTimer weakTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethord) userInfo:nil repeats:YES];
            }else
                [MBProgressHUD showError:responseObject[@"message"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络开小差啦,请检查网络"];
        [MBProgressHUD hideHUDForView:self.view];
    }];
}
#pragma mark - 验证旧手机短信验证码
- (void)httpCheckOldPhoneCode
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@user/checkOldCode?version=%@&token=%@&phone=%@&code=%@",[NSObject baseURLStr],VERSION,token,_oldPhoneNum,SecurityCode.text];
    NSString *URL = [MyMD5 authkey:urlStr];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        //
        if (responseObject!=nil) {
            if ([responseObject[@"status"]integerValue]==1) {
                WTFNewPhoneNumController *view=[[WTFNewPhoneNumController alloc]init];
                view.oldPhoneNum=_oldPhoneNum;
                [self.navigationController pushViewController:view animated:YES];
            }else
                [MBProgressHUD showError:responseObject[@"message"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络开小差啦,请检查网络"];
    }];
}


-(void)dealloc
{
    [self.countDownTimer invalidate];
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
