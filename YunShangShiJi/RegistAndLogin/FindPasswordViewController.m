//
//  FindPasswordViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/10.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "FindPasswordViewController.h"
#import "VerificationViewController.h"
#import "GlobalTool.h"
#import "PooCodeView.h"
#import "KeyboardTool.h"
#import "PooCodeView.h"
#import "GifImageView.h"
#import "UIImage+GIF.h"
#import "NewPasswordViewController.h"
#import "PictureVerificationModel.h"
@interface FindPasswordViewController ()<KeyboardToolDelegate>
{
    dispatch_source_t _timer;
    UIView *backgroundV;
}

@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UITextField *imageCodeField;
@property (nonatomic, strong) UIButton *codeBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, assign) NSInteger timerCount;
@property (nonatomic, assign) BOOL isPhoneCode;
@property (nonatomic, strong) PooCodeView *imageCodeView;
@property (nonatomic, strong) UIImageView *pictureCodeView;
//@property (nonatomic, strong) GifImageView *gifView;
@end

@implementation FindPasswordViewController
{
    //手机或邮箱输入框
    UITextField *_phoneAndEmail;
    //是否是邮箱
    BOOL _EmailOK;
    //是否是手机号码
    BOOL _isCorrect;
    
    UIView *_bigView;
    
    UITextField *_nowTextField;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self oldUI];
    
    [self setupUI];
    
    [self getData];
    
}
#pragma mark - %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

- (void)getData
{
    self.timerCount = 120;
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
        for (UIView *view in self.pictureCodeView.subviews) {
            [view removeFromSuperview];
        }
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ZOOM6(250), ZOOM6(60))];
        [webView setScalesPageToFit: YES];
        [webView setBackgroundColor: [UIColor clearColor]];
        [webView setOpaque: 0];
        [self.pictureCodeView addSubview:webView];
        [webView loadData:data MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL URLWithString:@""]];
        [webView setUserInteractionEnabled:NO];
    }else if ([response.MIMEType containsString:@"text"]) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [MBProgressHUD show:responseObject[@"message"] icon:nil view:self.view];
    }
    
}
- (void)automatic
{
    self.isPhoneCode = NO;
    [self setupUI];
    [self httpGetCodeView:self.inputTextField.text];
}

#pragma mark - setupUI
- (void)setupUI
{
    [backgroundV removeFromSuperview];
    
    self.view.backgroundColor = RGBCOLOR_I(244, 244, 244);
    [self setNavigationItemLeft:@"找回密码"];

    CGFloat lr_Margin = ZOOM6(30);
    CGFloat ll_Margin = ZOOM6(220);
    CGFloat H = ZOOM6(100);
    
    backgroundV = [UIView new];
    backgroundV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundV];
    
    if(self.isPhoneCode)
    {
        [self.imageCodeField removeFromSuperview];
        [self.imageCodeView removeFromSuperview];
        [self.pictureCodeView removeFromSuperview];
        
        [backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.navigationView.mas_bottom).offset(30);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(H);
        }];

        /**< 验证码 */
        [self.view addSubview:self.codeTextField];
        [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(backgroundV);
            make.left.equalTo(backgroundV.mas_left).offset(lr_Margin);
            make.right.equalTo(backgroundV.mas_right).offset(-ll_Margin);
            make.height.mas_equalTo(H);
        }];
       
        UIView *lineV = [UIView new];
        [self.view addSubview:lineV];
        lineV.backgroundColor = RGBCOLOR_I(244, 244, 244);
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(backgroundV.mas_bottom).offset(-1);
            make.left.right.equalTo(self.codeTextField);
            make.height.mas_equalTo(1);
        }];
        
        /**< 按钮 */
        [self.view addSubview:self.codeBtn];
        [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(ZOOM6(200));
            make.right.equalTo(backgroundV.mas_right);
            make.top.equalTo(backgroundV.mas_top);
            make.bottom.equalTo(backgroundV);
        }];
        
        UIView *vetV = [UIView new];
        vetV.backgroundColor = RGBCOLOR_I(244, 244, 244);
        [backgroundV addSubview:vetV];
        [vetV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.codeBtn.mas_left);
            make.top.equalTo(self.codeBtn.mas_top).offset(10);
            make.bottom.equalTo(self.codeBtn.mas_bottom).offset(-10);
            make.width.mas_equalTo(1);
        }];
        
        
    }else{
        
        [backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.navigationView.mas_bottom).offset(30);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(H*2);
        }];

        /**< 手机/邮箱输入 */
        [self.view addSubview:self.inputTextField];
        [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(backgroundV);
            make.left.equalTo(backgroundV.mas_left).offset(lr_Margin);
            make.right.equalTo(backgroundV.mas_right).offset(-lr_Margin);
            make.height.mas_equalTo(H);
        }];

        UIView *lineV = [UIView new];
        [self.view addSubview:lineV];
        lineV.backgroundColor = RGBCOLOR_I(244, 244, 244);
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.inputTextField.mas_bottom);
            make.left.right.equalTo(self.inputTextField);
            make.height.mas_equalTo(1);
        }];

        /**< 图片验证码 */
        [self.view addSubview:self.imageCodeField];
        [self.imageCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineV.mas_bottom);
            make.left.equalTo(backgroundV.mas_left).offset(lr_Margin);
            make.right.equalTo(backgroundV.mas_right).offset(-ll_Margin);
            make.height.mas_equalTo(H);
        }];
        

        UIView *vetV = [UIView new];
        vetV.backgroundColor = RGBCOLOR_I(244, 244, 244);
        [backgroundV addSubview:vetV];
        [vetV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.imageCodeField.mas_left).offset(10);
            make.top.equalTo(self.imageCodeField.mas_top).offset(10);
            make.bottom.equalTo(self.imageCodeField.mas_bottom).offset(-10);
            make.width.mas_equalTo(1);
        }];
        
        //验证码图片
//        [self.view addSubview:self.imageCodeView];
//        self.imageCodeView.layer.cornerRadius = ZOOM6(30);
//        [self.imageCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(ZOOM6(200));
//            make.right.equalTo(backgroundV.mas_right).offset(-lr_Margin);
//            make.top.equalTo(lineV.mas_top).offset(ZOOM6(20));
//            make.height.mas_equalTo(ZOOM6(60));
//        }];
        
        [self.view addSubview:self.pictureCodeView];
        self.pictureCodeView.layer.cornerRadius = ZOOM6(30);
        self.pictureCodeView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getPicture:)];
        [self.pictureCodeView addGestureRecognizer:tap];
        [self.pictureCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(ZOOM6(250));
            make.right.equalTo(backgroundV.mas_right).offset(-lr_Margin);
            make.top.equalTo(lineV.mas_top).offset(ZOOM6(20));
            make.height.mas_equalTo(ZOOM6(60));
        }];
    }
    
    /**< 下一步 */
    [self.view addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(lr_Margin);
        make.right.equalTo(self.view.mas_right).offset(-lr_Margin);
        make.top.equalTo(backgroundV.mas_bottom).offset(30);
        make.height.mas_equalTo(H);
    }];
    
}

- (void)getPicture:(UITapGestureRecognizer*)tap
{
    [self httpGetCodeView:self.inputTextField.text];
}
- (void)codeBtnClick:(UIButton *)sender
{
    NSString *inputText = self.inputTextField.text;
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    
    if (sender.selected == NO) {
        
        if (!inputText.length) {
            [nv showLable:@"请输入正确的手机号/邮箱" Controller:self];
            return;
        }
        
        NSRange rang = [inputText rangeOfString:@"@"];
        if (rang.length>=1) { /**< 邮箱 */
            // 验证邮箱
            BOOL isEmail = [self isValidateEmail:inputText];
            if (isEmail) {
                [self httpGetCodeisPhone:NO];
            } else {
                [nv showLable:@"请输入正确的邮箱" Controller:self];
                return;
            }
            
        } else { /**< 手机号 */
            BOOL isPhone = [self isValidateMobile:inputText];
            if (isPhone) {
                [self httpGetCodeisPhone:YES];
            } else {
                [nv showLable:@"请输入正确的手机号" Controller:self];
                return;
            }
            
        }
    }else{
        [nv showLable:@"请稍后再试" Controller:self];
    }
}

- (void)timerOut
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    [nv showLable:@"验证码已过期，请重新获取" Controller:self];
    self.codeBtn.userInteractionEnabled = YES;
    [self.codeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    self.codeBtn.selected = NO;
}

- (void)updateCodeBtnStatus:(NSString *)timeString
{
    self.codeBtn.userInteractionEnabled = NO;
    self.codeBtn.selected = YES;
    [self.codeBtn setTitle:timeString forState:UIControlStateSelected];
}

- (void)nextBtnClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    NSString *inputText = self.inputTextField.text;
    NSString *codeText = self.codeTextField.text;
    
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    if (!inputText.length) {
        [nv showLable:@"请输入正确的手机号/邮箱" Controller:self];
        return;
    }
    
    if(self.isPhoneCode)
    {
        if (!codeText.length) {
            [nv showLable:@"请输入正确验证码" Controller:self];
            return;
        }
        
        if (!self.timerCount && [self.codeBtn.currentTitle isEqualToString:@"重新获取"]) {
            [nv showLable:@"验证码已过期，请重新获取" Controller:self];
            return;
        }

    }else{
#pragma mark 判断图片验证码
        
//        //  判读验证码
//        //    if ([_yanzhengfild.text isEqualToString:self.codeView.changeString])
//        if(self.imageCodeField.text.length!=0 && [self.imageCodeField.text compare:self.imageCodeView.changeString
//                                                               options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame)
//        {
//            
//        }
//        else
//        {
//            CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
//            anim.repeatCount = 1;
//            anim.values = @[@-20, @20, @-20];
//            [self.imageCodeView.layer addAnimation:anim forKey:nil];
//            [self.imageCodeField.layer addAnimation:anim forKey:nil];
//            return;
//        }
    }
    
    NSRange rang = [inputText rangeOfString:@"@"];
    if (rang.length>=1) { /**< 邮箱 */
        // 验证邮箱
        BOOL isEmail = [self isValidateEmail:inputText];
        if (isEmail) {

            if(self.isPhoneCode)
            {
                [self httpCheckisPhone:NO];
            }else{
                [self codeBtnClick:self.codeBtn];
            }

        } else {
            [nv showLable:@"请输入正确的邮箱" Controller:self];
        }
    } else { /**< 手机号 */
        BOOL isPhone = [self isValidateMobile:inputText];
        if (isPhone) {
            if(self.isPhoneCode)
            {
                [self httpCheckisPhone:YES];
            }else{
            
                [self codeBtnClick:self.codeBtn];
                
            }
            
        } else {
            [nv showLable:@"请输入正确的手机号" Controller:self];
        }
    }
}
#pragma mark - 获取验证码
- (void)httpGetCodeisPhone:(BOOL)isPhone
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    NSString *kApi;
    NSDictionary *parameter;
    BOOL isToken;
    if (isPhone) {
        kApi = kApi_user_get_phone_code;
        parameter = @{@"phone": self.inputTextField.text, @"codetype": @"2" ,@"vcode":self.imageCodeField.text};
        isToken = YES;
    } else {
        kApi = kApi_user_get_email_code;
        parameter = @{@"email": self.inputTextField.text, @"codetype": @"2"};
        isToken = NO;
    }
    
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi parameter:parameter caches:NO cachesTimeInterval:0*TFMinute token:isToken success:^(id data, Response *response) {
        MyLog(@"data: %@", data);
        [nv showLable:response.message Controller:self];
        if (response.status == 1) {
            
            self.isPhoneCode = YES;
            [self setupUI];
            //如果2分钟没有离开这个界面返回上一界面
            [self performSelector:@selector(automatic) withObject:nil afterDelay:121.0];
            
            self.codeBtn.selected = YES;
            [self startTimer:120 action:@selector(updateCodeBtnStatus:) withTimeOut:@selector(timerOut)];
            
        } else {
            
            self.codeBtn.userInteractionEnabled = YES;
            [self.codeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
            self.codeBtn.selected = NO;
        }
        
    } failure:^(NSError *error) {
        [nv showLable:@"验证码发送失败" Controller:self];
    }];
    
    
}

#pragma mark - 修改
- (void)httpCheckisPhone:(BOOL)isPhone
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    NSString *codeText = self.codeTextField.text;
    NSString *inputText = self.inputTextField.text;
    NSString *kApi;
    NSDictionary *parameter;
    if (isPhone) {
        kApi = kApi_user_checkAuthCode;
        parameter = @{@"code": codeText, @"phone": inputText};
    } else {
        kApi = kApi_user_checkEmailAuthCode;
        parameter = @{@"code": codeText, @"email": inputText, @"codetype": @"2"};
    }
    
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi parameter:parameter caches:NO cachesTimeInterval:0*TFMinute token:NO success:^(id data, Response *response) {
        MyLog(@"data: %@", data);
//        [nv showLable:response.message Controller:self];
        [MBProgressHUD show:response.message icon:nil view:self.view];
        if (response.status == 1) { // 进入修改页面
            [self stopTimer];
            NewPasswordViewController *passwordVC =[[NewPasswordViewController alloc]init];
            passwordVC.code = self.codeTextField.text;
            passwordVC.phoneAndEmail = self.inputTextField.text;
            [self.navigationController pushViewController:passwordVC animated:YES];
        }
        
    } failure:^(NSError *error) {
        //[self stopTimer];
        [nv showLable:@"网络开小差啦，请检查网络" Controller:self];
    }];
}

- (void)startTimer:(double)timeCount action:(SEL)sel withTimeOut:(SEL)selOut
{
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
    __block double timeOut = timeCount-1;
    double delayInSeconds = 1.0;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    _timer = timer;
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0), delayInSeconds*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        if(timeOut < 0){ //倒计时结束，关闭
            dispatch_source_cancel(timer);
            _timer = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSelector:selOut withObject:nil afterDelay:0.0];
            });
        } else{
            
            self.timerCount = timeOut;
            //            int hours = timeOut / 3600;
            //int minutes = (int)timeOut % 3600/ 60;
            //int seconds = (int)timeOut % 60;
            NSString *stringTime = [NSString stringWithFormat:@"%ld秒",(long)self.timerCount];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSelector:sel withObject:stringTime afterDelay:0.0];
            });
            timeOut--;
        }
    });
    dispatch_resume(timer);
}

- (void)stopTimer
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        dispatch_async(dispatch_get_main_queue(), ^{
            _timer = nil;
        });
    }
    
    self.codeBtn.userInteractionEnabled = YES;
    [self.codeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    self.codeBtn.selected = NO;
}

- (UITextField *)inputTextField
{
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.backgroundColor = [UIColor whiteColor];
        _inputTextField.borderStyle = UITextBorderStyleNone;
        _inputTextField.placeholder = @"手机号";
        _inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inputTextField.font = kFont6px(30);
        _inputTextField.delegate = self;
    }
    return _inputTextField;
}

- (UITextField *)codeTextField
{
    if (!_codeTextField) {
        _codeTextField = [[UITextField alloc] init];
        _codeTextField.backgroundColor = [UIColor whiteColor];
        _codeTextField.borderStyle = UITextBorderStyleNone;
        _codeTextField.placeholder = @"验证码";
        _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codeTextField.delegate = self;
        _codeTextField.font = kFont6px(30);
    }
    return _codeTextField;
}

- (UITextField *)imageCodeField
{
    if(!_imageCodeField)
    {
        _imageCodeField = [[UITextField alloc] init];
        _imageCodeField.backgroundColor = [UIColor whiteColor];
        _imageCodeField.borderStyle = UITextBorderStyleNone;
        _imageCodeField.placeholder = @"请输入图片验证码";
        _imageCodeField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _imageCodeField.delegate = self;
        _imageCodeField.font = kFont6px(30);
    }
    return _imageCodeField;
}
- (UIButton *)codeBtn
{
    if (!_codeBtn) {
        _codeBtn = [UIButton new];
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeBtn setTitleColor:COLOR_ROSERED forState:UIControlStateNormal];
        [_codeBtn setTitleColor:RGBCOLOR_I(168, 168, 168) forState:UIControlStateSelected];
        _codeBtn.titleLabel.font = kFont6px(30);
        [_codeBtn addTarget:self action:@selector(codeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeBtn;
}

- (PooCodeView *)imageCodeView
{
    if(!_imageCodeView)
    {
        _imageCodeView = [PooCodeView new];
        _imageCodeView.clipsToBounds = YES;
        _imageCodeView.layer.cornerRadius = CGRectGetHeight(self.imageCodeView.frame)/2;
    }
    return _imageCodeView;
}
- (UIImageView *)pictureCodeView
{
    if(!_pictureCodeView)
    {
        _pictureCodeView = [UIImageView new];
        _pictureCodeView.clipsToBounds = YES;
        _pictureCodeView.layer.cornerRadius = CGRectGetHeight(self.imageCodeView.frame)/2;
    }
    return _pictureCodeView;
}
- (UIButton *)nextBtn
{
    if (!_nextBtn) {
        _nextBtn = [UIButton new];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [_nextBtn setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_I(195, 195, 195)] forState:UIControlStateSelected];
        [_nextBtn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.layer.masksToBounds = YES;
        _nextBtn.layer.cornerRadius = ZOOM6(8);
        _nextBtn.selected = YES;
        _nextBtn.userInteractionEnabled = !_nextBtn.selected;
    }
    return _nextBtn;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{

    NSString *oldText = textField.text;
    NSString *currInputText = [NSString stringWithFormat:@"%@%@", textField.text, string];
    
    if(self.isPhoneCode)
    {
        if (textField == self.codeTextField) {
            if (currInputText.length>0) { // 输入
                self.nextBtn.userInteractionEnabled = YES;
                self.nextBtn.selected = NO;
            }
        }

    }else{
        if (textField == self.inputTextField) {
            //如果是11位且是手机号码 获取图片验证码
            if(currInputText.length == 11 && [self isValidateMobile:currInputText] && string.length){
                [self httpGetCodeView:currInputText];
            }

            if (currInputText.length>0 && self.imageCodeField.text.length) { // 输入
                self.nextBtn.userInteractionEnabled = YES;
                self.nextBtn.selected = NO;
            }
        }

        if (textField == self.imageCodeField) {
            
            if (currInputText.length>0 && self.inputTextField.text.length) { // 输入
                self.nextBtn.userInteractionEnabled = YES;
                self.nextBtn.selected = NO;
            }
        }

    }
    
    if ((currInputText.length == oldText.length && range.location == 0)) { // 删除
        self.nextBtn.userInteractionEnabled = NO;
        self.nextBtn.selected = YES;
    }
    
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    
    if (textField == self.inputTextField || textField == self.codeTextField || textField == self.imageCodeField) {
        self.nextBtn.userInteractionEnabled = NO;
        self.nextBtn.selected = YES;
    }
    return YES;
}

- (void)leftBarButtonClick
{
    if(self.isPhoneCode)
    {
        self.codeBtn.userInteractionEnabled = YES;
        self.codeBtn.selected = NO;
        self.isPhoneCode = NO;
        [self setupUI];
    }else{
        [super leftBarButtonClick];
        [self stopTimer];
    }
}

#pragma mark - %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


- (void)oldUI
{
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [center addObserver:self selector:@selector(   keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
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
    titlelable.text=@"找回密码";
    titlelable.textColor=kMainTitleColor;
    titlelable.font = kNavTitleFontSize;
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
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    _nowTextField = textField;
}


- (void)keyboardShow:(NSNotification *)notf
{
    
    NSDictionary *userInfo = notf.userInfo;
    
    CGRect keyboardFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    
    CGRect textFrame = _nowTextField.frame;
    
    CGFloat y = CGRectGetMaxY(textFrame) - CGRectGetMinY(keyboardFrame);
    //%f %f",CGRectGetMaxY(textFrame),CGRectGetMinY(keyboardFrame));
    
    //    if (CGRectGetMaxY(textFrame) >= CGRectGetMinY(keyboardFrame)) {
    if (y + 64.0f> 0) {
        
        CGFloat y = CGRectGetMinY(keyboardFrame) - CGRectGetMaxY(textFrame);
        CGRect frame = _bigView.frame;
        frame.origin.y = y;
        
        _bigView.frame = frame;
    }
}

- (void)keyboardHide:(NSNotification *)notf
{
    
    CGRect frame = _bigView.frame;
    frame.origin.y = 64;
    _bigView.frame = frame;
}

-(void)creatView
{
    CGFloat space= ZOOM(150);
    _bigView = [[UIView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth-60, kApplicationHeight-Height_NavBar)];
    [self.view addSubview:_bigView];
    //提示
    UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(space, 20, kApplicationWidth-2*space, 20)];
    titlelable.text=@"使用已注册的邮箱或手机号码找回密码";
    titlelable.font=[UIFont systemFontOfSize:ZOOM(45)];
    titlelable.textColor=[UIColor grayColor];
    [_bigView addSubview:titlelable];
    
    //手机号码邮箱
//    UIImageView *NameView=[[UIImageView alloc]initWithFrame:CGRectMake(30, 60, kApplicationWidth-60, 40)];
//    NameView.image=[UIImage imageNamed:@""];
    _phoneAndEmail=[[UITextField alloc]initWithFrame:CGRectMake(space, titlelable.frame.origin.y+titlelable.frame.size.height+20, _bigView.frame.size.width-10, 30)];
//    _phoneAndEmail.backgroundColor = [UIColor lightGrayColor];
    _phoneAndEmail.placeholder=@"请输入手机号码/邮箱";
    _phoneAndEmail.font = [UIFont systemFontOfSize:ZOOM(50)];
    _phoneAndEmail.delegate = self;
    [_bigView addSubview:_phoneAndEmail];
//    NameView.userInteractionEnabled=YES;
    
    UILabel *lableline=[[UILabel alloc]initWithFrame:CGRectMake(space,_phoneAndEmail.frame.origin.y+_phoneAndEmail.frame.size.height, kApplicationWidth-2*space, 2)];
    lableline.backgroundColor=kBackgroundColor;
    [_bigView addSubview:lableline];
    
    //验证码
//    UIImageView *passView=[[UIImageView alloc]initWithFrame:CGRectMake(30, lableline.frame.origin.y+lableline.frame.size.height+20, lableline.frame.size.width-100, 40)];
//    passView.image=[UIImage imageNamed:@""];
    self.input=[[UITextField alloc]initWithFrame:CGRectMake(space, lableline.frame.origin.y+lableline.frame.size.height+20, lableline.frame.size.width-10, 30)];
    self.input.delegate = self;
    self.input.placeholder=@"验证码";
    self.input.keyboardType=UIKeyboardTypeASCIICapable;
    self.input.font = [UIFont systemFontOfSize:ZOOM(50)];
    [_bigView addSubview:self.input];
//    passView.userInteractionEnabled=YES;
    
    UILabel *lableline1=[[UILabel alloc]initWithFrame:CGRectMake(space,_input.frame.origin.y+_input.frame.size.height, lableline.frame.size.width, 2)];
    lableline1.backgroundColor=kBackgroundColor;
    [_bigView addSubview:lableline1];
    
    //验证码图片
    self.codeView = [[PooCodeView alloc] initWithFrame:CGRectMake(kApplicationWidth- ZOOM(150)-90 , lableline.frame.origin.y +10, 90, 40)];
    [_bigView addSubview:self.codeView];
    
    
    //获取验证码
    UIButton *loginbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginbtn.frame=CGRectMake(space, _input.frame.origin.y+_input.frame.size.height+40, kApplicationWidth-2*space, ZOOM(110));
//    [loginbtn setBackgroundImage:[UIImage imageNamed:@"完成注册"] forState:UIControlStateNormal];
    [loginbtn setBackgroundColor:[UIColor blackColor]];
    [loginbtn setTitle:@"下一步" forState:UIControlStateNormal];
    loginbtn.tintColor=[UIColor whiteColor];
    loginbtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(50)];
    [loginbtn addTarget:self action:@selector(getclick:) forControlEvents:UIControlEventTouchUpInside];

//    [_bigView addSubview:NameView];
//    [_bigView addSubview:passView];
    [_bigView addSubview:loginbtn];
    
    KeyboardTool *tool = [KeyboardTool keyboardTool];
    tool.delegate = self;
    tool.frame=CGRectMake(0, tool.frame.origin.y, kScreenWidth, 40);
    _phoneAndEmail.inputAccessoryView = tool;
    self.input.inputAccessoryView = tool;

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

#pragma mark 获取验证码
-(void)getclick:(UIButton*)sender
{
    //ok");
    //判读手机号码或邮箱

    if ([_phoneAndEmail.text length]<1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"手机号码或邮箱输入不能为空,请重新设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    NSString *phoneStr = _phoneAndEmail.text;
    NSRange range;
    range=[phoneStr rangeOfString:@"@"];//用@判读是手机号码还是邮箱
    if(range.length>0)
    {
        //是邮箱
        _EmailOK=[self isValidateEmail:_phoneAndEmail.text];
        
        if(_EmailOK!=YES)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"输入邮箱不合法,请重新设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }

        
    }else{
        //是手机号码
        
            _isCorrect = [self isValidateMobile:phoneStr];
            
            if (_isCorrect) {
                
                //是手机号码");
                
                
            }   else {
                
                //不是手机号码");
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alert show];
                return;
                
            }
    
    
    }

//    //  判读验证码
////    if ([self.input.text isEqualToString:self.codeView.changeString])
//    if([_input.text compare:self.codeView.changeString
//                           options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame)
//    {
//        
//    }
//    else
//    {
//        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
//        anim.repeatCount = 1;
//        anim.values = @[@-20, @20, @-20];
//        [self.codeView.layer addAnimation:anim forKey:nil];
//        [self.input.layer addAnimation:anim forKey:nil];
//        return;
//    }

    
//    [self putin];
    [self toVerificationViewController];
    
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
//邮箱是否合法
-(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

-(void)toVerificationViewController
{
    VerificationViewController *code=[[VerificationViewController alloc]init];
    code.phoneAndemail=_phoneAndEmail.text;
    code.vcode = self.imageCodeField.text;
    if(_EmailOK)//邮箱
    {
        code.isEmail=YES;
    }
    if(_isCorrect)//手机
    {
        code.isPhone=YES;
    }
    code.backBlock = ^{
        
    };
    [self.navigationController pushViewController:code animated:NO];
}
-(void)putin
{
    if ([self.input.text isEqualToString:self.codeView.changeString]) {

        [self toVerificationViewController];
        
    }
    else
    {
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20, @20, @-20];
        [self.codeView.layer addAnimation:anim forKey:nil];
        [self.input.layer addAnimation:anim forKey:nil];
    }
    
}
#pragma mark 返回上一视图
-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.input == textField) {
//        [self putin];
        if (![self.input.text isEqualToString:self.codeView.changeString]) {
            CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
            anim.repeatCount = 1;
            anim.values = @[@-20, @20, @-20];
            [self.codeView.layer addAnimation:anim forKey:nil];
            [self.input.layer addAnimation:anim forKey:nil];
        }else
            [self.view endEditing:YES];

    }else
        [self.view endEditing:YES];
    return YES;
}

#pragma mark *****************新加的图片验证码********************

@end
