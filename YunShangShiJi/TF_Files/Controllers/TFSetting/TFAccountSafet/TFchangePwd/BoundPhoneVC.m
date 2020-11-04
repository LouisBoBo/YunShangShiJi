//
//  BoundPhoneVC.m
//  YunShangShiJi
//
//  Created by zgl on 16/8/24.
//  Copyright © 2016年 ios-1. All rights reserved.
//  绑定手机

#import "BoundPhoneVC.h"
#import "GlobalTool.h"
#import "YFShareModel.h"
#import "MBProgressHUD+NJ.h"
#import "TFCashSuccessViewController.h"
#import "SelectHobbyViewController.h"

@interface BoundPhoneVC ()<UITextFieldDelegate> {
    BOOL _pcLoading; //是否正在请求验证码（防止连续点击）
    BOOL _cLoading;  //是否正在绑定
    BOOL _isPhoneCode; //手机验证界面
    NSString *phoneText;
    UIView *fileView;
    UILabel *label;
    UITextField *passwordField;
}

@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UITextField *codesField;
@property (nonatomic, strong) UITextField *imageCodeField;
@property (nonatomic, strong) UIButton *timeBtn;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) NSString *otherToken;
@property (nonatomic, strong) UIImageView *pictureCodeView;
@end

@implementation BoundPhoneVC

- (void)dealloc {

    NSLog(@"%@释放了", self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBackWithTitle:@"绑定手机"];
    self.view.backgroundColor = kBackgroundColor;
    _pcLoading = NO;
    _cLoading = NO;

    if (self.type == BoundPhoneType_NewUser) {
        _isPhoneCode = YES;
    }
    [self setUI];

    if (self.type == BoundPhoneType_NewUser) {
        _timeBtn.enabled = NO;
        __block int time = 120;
        if (_timer == nil) {
            _timer = [NSTimer weakTimerWithTimeInterval:1 target:self userInfo:nil repeats:YES block:^(BoundPhoneVC *target, NSTimer *timer) {
                if (time < 0) {
                    [target.timer invalidate];
                    target.timer = nil;
                    target.timeBtn.enabled = YES;
                    [target.timeBtn setTitle:@"120秒" forState:UIControlStateNormal];
                } else {
                    [target.timeBtn setTitle:[NSString stringWithFormat:@"%d秒", time] forState:UIControlStateNormal];
                    time--;
                }
            }];
        }
    }
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
    _isPhoneCode = NO;
    [self setUI];
    self.phoneField.text = phoneText;
    [self httpGetCodeView:self.phoneField.text];
}
- (void)getPicture:(UITapGestureRecognizer*)tap
{
    [self httpGetCodeView:self.phoneField.text];
}

- (void)setUI
{
    [label removeFromSuperview];
    [fileView removeFromSuperview];
    [_submitBtn removeFromSuperview];
    
//    CGFloat viewHeigh = _isPhoneCode?(ZOOMPT(50)+2):(ZOOMPT(100)+3);
    CGFloat viewHeigh = ZOOMPT(100)+3;

    fileView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar + ZOOMPT(50), self.view.width,viewHeigh)];
    fileView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:fileView];
    
    label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:ZOOMPT(14)];
    label.textColor = [UIColor colorWithWhite:125/255.0 alpha:1];
    label.text = @"为了您的个人账户安全请及时绑定手机";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ZOOMPT(15));
        make.bottom.equalTo(fileView.mas_top).offset(ZOOMPT(-10));
    }];
    
    if(_isPhoneCode)
    {
        _codesField = [[UITextField alloc] initWithFrame:CGRectMake(ZOOMPT(15), 1, fileView.width - ZOOMPT(130), ZOOMPT(50))];
        _codesField.textColor = [UIColor colorWithWhite:62/255.0 alpha:1];
        _codesField.font = [UIFont systemFontOfSize:ZOOMPT(15)];
        _codesField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:162/255.0 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:ZOOMPT(15)]}];
        _codesField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codesField.keyboardType = UIKeyboardTypeNumberPad;
        _codesField.delegate = self;
        [fileView addSubview:_codesField];
        
        UIView *Line = [[UIView alloc] initWithFrame:CGRectMake(_codesField.right, _codesField.top + ZOOMPT(10), 1, ZOOMPT(50)-ZOOMPT(20))];
        Line.backgroundColor = kTableLineColor;
        [fileView addSubview:Line];

        _timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _timeBtn.frame = CGRectMake(_codesField.right, _codesField.top, ZOOMPT(100), ZOOMPT(50));
        [_timeBtn setTitleColor:tarbarrossred forState:UIControlStateSelected];
        [_timeBtn setTitleColor:[UIColor colorWithWhite:168/255.0 alpha:1] forState:UIControlStateNormal];
        [_timeBtn setTitle:@"获取验证码" forState:UIControlStateSelected];
        [_timeBtn setTitle:@"获取验证码" forState:UIControlStateSelected|UIControlStateHighlighted];
        [_timeBtn setTitle:@"120秒" forState:UIControlStateNormal];
        _timeBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOMPT(15)];
        [_timeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _timeBtn.selected = YES;
        [fileView addSubview:_timeBtn];

        passwordField = [[UITextField alloc] initWithFrame:CGRectMake(ZOOMPT(15),_codesField.bottom + 1, fileView.width - ZOOMPT(30), ZOOMPT(50))];
        passwordField.textColor = [UIColor colorWithWhite:62/255.0 alpha:1];
        passwordField.font = [UIFont systemFontOfSize:ZOOMPT(15)];
        passwordField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请设置登录密码（6-12位）" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:162/255.0 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:ZOOMPT(15)]}];
        passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        //        _imageCodeField.keyboardType = UIKeyboardTypeNumberPad;
//        passwordField.delegate = self;
        passwordField.secureTextEntry=YES;
        [fileView addSubview:passwordField];

        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fileView.width, 1)];
        topLine.backgroundColor = kTableLineColor;
        [fileView addSubview:topLine];

        UIView *centerLine = [[UIView alloc] initWithFrame:CGRectMake(ZOOMPT(15), ZOOMPT(50)+1, fileView.width - ZOOMPT(30), 1)];
        centerLine.backgroundColor = kTableLineColor;
        [fileView addSubview:centerLine];

        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, ZOOMPT(100)+2, fileView.width, 1)];
        bottomLine.backgroundColor = kTableLineColor;
        [fileView addSubview:bottomLine];
        
    }else{
        _phoneField = [[UITextField alloc] initWithFrame:CGRectMake(ZOOMPT(15), 1, fileView.width - ZOOMPT(30), ZOOMPT(50))];
        _phoneField.textColor = [UIColor colorWithWhite:62/255.0 alpha:1];
        _phoneField.font = [UIFont systemFontOfSize:ZOOMPT(15)];
        _phoneField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"手机号" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:162/255.0 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:ZOOMPT(15)]}];
        _phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneField.delegate = self;
        [fileView addSubview:_phoneField];
        
        _imageCodeField = [[UITextField alloc] initWithFrame:CGRectMake(ZOOMPT(15),_phoneField.bottom + 1, fileView.width - ZOOMPT(130), ZOOMPT(50))];
        _imageCodeField.textColor = [UIColor colorWithWhite:62/255.0 alpha:1];
        _imageCodeField.font = [UIFont systemFontOfSize:ZOOMPT(15)];
        _imageCodeField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入图片验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:162/255.0 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:ZOOMPT(15)]}];
        _imageCodeField.clearButtonMode = UITextFieldViewModeWhileEditing;
//        _imageCodeField.keyboardType = UIKeyboardTypeNumberPad;
        _imageCodeField.delegate = self;
        [fileView addSubview:_imageCodeField];
        
        
        //验证码图片
//        self.codeView = [[PooCodeView alloc] initWithFrame:CGRectMake(kApplicationWidth-ZOOM6(30)-100 ,CGRectGetMinY(_imageCodeField.frame)+ZOOMPT(10), 100, ZOOMPT(30))];
//        self.codeView.layer.cornerRadius = CGRectGetHeight(self.codeView.frame)/2;
//        [fileView addSubview:self.codeView];
        
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fileView.width, 1)];
        topLine.backgroundColor = kTableLineColor;
        [fileView addSubview:topLine];
        
        UIView *centerLine = [[UIView alloc] initWithFrame:CGRectMake(ZOOMPT(15), ZOOMPT(50)+1, fileView.width - ZOOMPT(30), 1)];
        centerLine.backgroundColor = kTableLineColor;
        [fileView addSubview:centerLine];
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, ZOOMPT(100)+2, fileView.width, 1)];
        bottomLine.backgroundColor = kTableLineColor;
        [fileView addSubview:bottomLine];
        
        //验证码图片
        [fileView addSubview:self.pictureCodeView];
        self.pictureCodeView.layer.cornerRadius = ZOOM6(30);
        self.pictureCodeView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getPicture:)];
        [self.pictureCodeView addGestureRecognizer:tap];
        [self.pictureCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(ZOOM6(250));
            make.right.equalTo(fileView.mas_right).offset(-ZOOMPT(15));
            make.top.equalTo(centerLine.mas_top).offset(ZOOM6(20));
            make.height.mas_equalTo(ZOOM6(60));
        }];
    }
    
    _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitBtn.frame = CGRectMake(ZOOMPT(15), fileView.bottom + ZOOMPT(25), fileView.width - ZOOMPT(30), ZOOMPT(44));
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _isPhoneCode?[_submitBtn setTitle:@"立即绑定" forState:UIControlStateNormal]:[_submitBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_submitBtn setBackgroundImage:[UIImage imageWithColor:RGBA(183,184,186,1)] forState:UIControlStateNormal];
    [_submitBtn setBackgroundImage:[UIImage imageWithColor:tarbarrossred] forState:UIControlStateSelected];
    _submitBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOMPT(18)];
    _submitBtn.selected = YES;
    _submitBtn.enabled = NO;
    [_submitBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _submitBtn.layer.cornerRadius = 5;
    _submitBtn.layer.masksToBounds = YES;
    [self.view addSubview:_submitBtn];

}

- (void)leftBarButtonItemPressed
{
    if(_isPhoneCode&&_type==BoundPhoneType_Normal)
    {
        _isPhoneCode = NO;
        [self setUI];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:_otherToken forKey:USER_TOKEN];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _otherToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_TOKEN];
    
}
#pragma mark - 按钮点击
- (void)btnClick:(UIButton *)sender {
    [self.view endEditing:YES];
    if (_phoneField.text.length < 11 && self.type == BoundPhoneType_Normal) {
        [MBProgressHUD show:@"请填写正确的手机号" icon:nil view:nil];
        return;
    }
    
    if(!_isPhoneCode)
    {
#pragma mark 判断图片验证码
        
//        //  判读验证码
//        //    if ([_yanzhengfild.text isEqualToString:self.codeView.changeString])
//        if(self.imageCodeField.text.length!=0 && [self.imageCodeField.text compare:_codeView.changeString
//                                                                           options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame)
//        {
//            
//        }
//        else
//        {
//            CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
//            anim.repeatCount = 1;
//            anim.values = @[@-20, @20, @-20];
//            [_codeView.layer addAnimation:anim forKey:nil];
//            [self.imageCodeField.layer addAnimation:anim forKey:nil];
//            return;
//        }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:_otherToken forKey:USER_TOKEN];
    
    if (sender == _timeBtn) {
        if (_pcLoading == NO) {
            [self httpGetBindingPhoneCode];
            _pcLoading = YES;
        }
    } else {
        if(_isPhoneCode)
        {
            if (_cLoading == NO) {
                if ([self validatePassword:passwordField.text]&&passwordField.text.length>=6&&passwordField.text.length<=12) {
                    [self httpbindingChecKCode];
                    _cLoading = YES;
                }else
                    [MBProgressHUD show:passwordField.text.length?@"密码格式不正确":@"请设置登录密码" icon:nil view:nil];

            }
        }else{
            if (_pcLoading == NO) {
                [self httpGetBindingPhoneCode];
                _pcLoading = YES;
            }
        }
    }
}

#pragma mark - 网络请求
//新绑定手机号获取验证码-7
- (void)httpGetBindingPhoneCode {
    [YFShareModel getPhoneCodeWithPhone:_phoneField.text codetype:@"7" vcode:self.imageCodeField.text success:^(YFShareModel *data) {
        _pcLoading = NO;
        if (data.status == 1) {

            if(_isPhoneCode == NO) {
                _isPhoneCode = YES;
                [self setUI];
                //如果2分钟没有离开这个界面返回上一界面
                [self performSelector:@selector(automatic) withObject:nil afterDelay:121.0];
            }

            [_timeBtn setTitle:@"重新获取" forState:UIControlStateSelected];
            _timeBtn.enabled = NO;
            __block int time = 120;
            if (_timer == nil) {
                _timer = [NSTimer weakTimerWithTimeInterval:1 target:self userInfo:nil repeats:YES block:^(BoundPhoneVC *target, NSTimer *timer) {
                    if (time < 0) {
                        [target.timer invalidate];
                        target.timer = nil;
                        target.timeBtn.enabled = YES;
                        [target.timeBtn setTitle:@"120秒" forState:UIControlStateNormal];
                    } else {
                        [target.timeBtn setTitle:[NSString stringWithFormat:@"%d秒", time] forState:UIControlStateNormal];
                        time--;
                    }
                }];
            }
        } else {
            [MBProgressHUD show:data.message icon:nil view:nil];
        }
    }];
}

- (void)httpbindingChecKCode {

    NSString *str = _codesField.text;
    if (passwordField.text.length) {
        str = [str stringByAppendingFormat:@"&pwd=%@",passwordField.text];
    }
    kWeakSelf(self);
    [YFShareModel getCheckCodeWithCode:str success:^(YFShareModel *data) {
        _cLoading = NO;
        if (data.status == 1) {
            [MBProgressHUD showSuccess:data.message];
            if([weakself.comefrom isEqualToString:@"推荐"])
            {
                [weakself recommendToHobby];
            }else if ([weakself.comefrom isEqualToString:@"余额红包"]){
                [weakself performSelector:@selector(backRedMoneyView) withObject:nil afterDelay:1.0];
            } else{
                [[NSUserDefaults standardUserDefaults] setObject:_phoneField.text forKey:USER_PHONE];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"isOneBuy" object:nil];
                [weakself performSelector:@selector(goToAffirmOrderView) withObject:nil afterDelay:1];
                
                [[NSUserDefaults standardUserDefaults] setObject:_otherToken forKey:USER_TOKEN];
            }
            
        } else {
            [MBProgressHUD show:data.message icon:nil view:nil];
            
        }
    }];
}
//精选推荐过来的去设置喜好
- (void)recommendToHobby
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *hobby = [user objectForKey:USER_HOBBY];
    
    if(hobby.length > 8)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        SelectHobbyViewController *hobby = [[SelectHobbyViewController alloc]init];
        hobby.comefrom = self.comefrom;
        hobby.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:hobby animated:YES];
        return;
    }
}
//订单过来的
- (void)goToAffirmOrderView {
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:NSClassFromString(@"LoginViewController")]) {
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }
    }
    
    //完成绑定
    TFCashSuccessViewController *tavc = [[TFCashSuccessViewController alloc] init];
    tavc.index = VCType_BindPhoneSuccess;
    [self.navigationController pushViewController:tavc animated:YES];
}
//余额红包过来的
- (void)backRedMoneyView
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:NSClassFromString(@"ShopDetailViewController")]) {
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }else if ([controller isKindOfClass:NSClassFromString(@"OrderTableViewController")]) {
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }else if ([controller isKindOfClass:NSClassFromString(@"NewShoppingCartViewController")]) {
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }
    }
    
    //完成绑定
    TFCashSuccessViewController *tavc = [[TFCashSuccessViewController alloc] init];
    tavc.index = VCType_BindPhoneSuccess;
    [self.navigationController pushViewController:tavc animated:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableString *text = [NSMutableString stringWithString:textField.text];
    [text replaceCharactersInRange:range withString:string];
    if (textField == _phoneField) {
        textField.text = [text substringToIndex:MIN(11, text.length)];
    } else {
        textField.text = [text substringToIndex:MIN(4, text.length)];
    }
    
    if(textField == _phoneField && textField.text.length ==11)
    {
        phoneText = textField.text;
        [self httpGetCodeView:textField.text];
    }
    
    if ((_phoneField.text.length == 11 && _imageCodeField.text.length == 4) || _codesField.text.length == 4) {
        _submitBtn.enabled = YES;
    } else {
        _submitBtn.enabled = NO;
    }
    
    //设置光标位置
    UITextPosition *beginningDocument = textField.beginningOfDocument;
    UITextPosition *end = [textField positionFromPosition:beginningDocument offset:range.location];
    UITextPosition *start = [textField positionFromPosition:end offset:string.length]?:textField.endOfDocument;
    textField.selectedTextRange = [textField textRangeFromPosition:start toPosition:start];
    return NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    _submitBtn.enabled = NO;
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIImageView *)pictureCodeView
{
    if(!_pictureCodeView)
    {
        _pictureCodeView = [UIImageView new];
        _pictureCodeView.clipsToBounds = YES;
        _pictureCodeView.layer.cornerRadius = ZOOM6(30);
    }
    return _pictureCodeView;
}

- (BOOL)validatePassword:(NSString *)password
{
    NSPredicate *passTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regular_loginPwd];
    return [passTest evaluateWithObject:password];
}
@end
