//
//  NewUserBoundPhoneVC.m
//  YunShangShiJi
//
//  Created by yssj on 16/9/23.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "NewUserBoundPhoneVC.h"
#import "TFCodePhoneViewController.h"
#import "YFShareModel.h"

#import "BoundPhoneVC.h"


@interface NewUserBoundPhoneVC ()<UITextFieldDelegate> {
    NSArray *sectionArr;
    NSArray *btnArr;
    
    NSString *selectOne;
    NSString *selectTwo;
    NSString *selectThree;
    NSString *selectFour;
    NSString *selectFive;

    
    UIView *titleView;
    UIView *ScrContainer;
    
    BOOL _pcLoading; //是否正在请求验证码（防止连续点击）
    BOOL _cLoading;  //是否正在绑定
    
}
//@property (nonatomic, strong)UITextField *inputField;

@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UITextField *codesField;
@property (nonatomic, strong) UIButton *timeBtn;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) NSString *otherToken;

@property (nonatomic, strong) UIImageView *pictureCodeView;

@end

@implementation NewUserBoundPhoneVC



- (void)viewWillAppear:(BOOL)animated {
    _otherToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_TOKEN];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [super setNavigationItemLeft:@"绑定手机"];
    _pcLoading = NO;
    _cLoading = NO;
    
    sectionArr=@[@"1.最爱",@"2.年龄段",@"3.定价",@"4.您的职业",@"5.每月买衣服会花多少钱"];
    btnArr=@[@[@"韩系",@"欧系",@"日系"],
                      @[@"18岁以下",@"18-23岁",@"23-28岁",@"28岁以上"],
                      @[@"实惠",@"小资",@"轻奢"],
                      @[@"我是学生",@"职场新人",@"时尚宝妈",@"丽质白领"],
                      @[@"0-200元",@"200-500元",@"500-1000元",@"1000元以上"]];
    
    [self setNavigationView];

    
    [self setScrollView];

}
- (void)setNavigationView {
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.image=[UIImage imageNamed:@"导航背景"];
    [self.view addSubview:headview];
    
    self.navigationView.backgroundColor = [UIColor whiteColor];
    
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    //    [backbtn setImage:[UIImage imageNamed:@"返回按钮_高亮"] forState:UIControlStateHighlighted];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, headview.frame.size.width, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text= @"绑定手机";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment= NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    /*
    UILabel *rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-ZOOM(62)-100, 25, 100, 30)];
    rightLabel.text=@"下一步";
    rightLabel.font = [UIFont systemFontOfSize:ZOOM6(32)];
    rightLabel.textColor=RGBCOLOR_I(125, 125, 125);
    rightLabel.textAlignment = NSTextAlignmentRight;
    [headview addSubview:rightLabel];
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(kScreenWidth-ZOOM(42)-100, 25, 100, 30);
    [rightBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:rightBtn];
    */
}

- (void)createUI {
    
    /*
    CGFloat ud_Margin = ZOOM(50);
    CGFloat lr_Margin = ZOOM(62);
    CGFloat textField_H = ZOOM(114);
    
    self.inputField = [[UITextField alloc] initWithFrame:CGRectMake(lr_Margin,  64+ud_Margin, kScreenWidth-2*lr_Margin, textField_H)];
    self.inputField.font = [UIFont systemFontOfSize:ZOOM(48)];
    self.inputField.placeholder = @"输入您要绑定的手机号";
    [self.inputField setValue:[UIFont systemFontOfSize:ZOOM(48)] forKeyPath:@"_placeholderLabel.font"];
    
    self.inputField.borderStyle = UITextBorderStyleRoundedRect;
    self.inputField.keyboardType = UIKeyboardTypeNumberPad;

    self.inputField.delegate = self;
    [self.view addSubview:self.inputField];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ZOOM(300), self.inputField.frame.size.height)];
    label.font = [UIFont systemFontOfSize:ZOOM(48)];
    label.textColor = RGBCOLOR_I(34,34,34);
    label.text = @"手机号码";
    self.inputField.leftView = label;
    self.inputField.leftViewMode = UITextFieldViewModeAlways;
    
    */
    titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , self.view.width-ZOOM(62)*2,ZOOMPT(100)+3+ZOOM6(20))];
    titleView.backgroundColor = [UIColor whiteColor];
    [ScrContainer addSubview:titleView];
    
    _phoneField = [[UITextField alloc] initWithFrame:CGRectMake(0, 1, titleView.width, ZOOMPT(50))];
    _phoneField.textColor = [UIColor colorWithWhite:62/255.0 alpha:1];
    _phoneField.font = [UIFont systemFontOfSize:ZOOMPT(15)];
    _phoneField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"手机号" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:162/255.0 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:ZOOMPT(15)]}];
    _phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneField.delegate = self;
    [titleView addSubview:_phoneField];
    
    _codesField = [[UITextField alloc] initWithFrame:CGRectMake(0,_phoneField.bottom + 1, titleView.width - ZOOM6(250)-ZOOMPT(20), ZOOMPT(50))];
    _codesField.textColor = [UIColor colorWithWhite:62/255.0 alpha:1];
    _codesField.font = [UIFont systemFontOfSize:ZOOMPT(15)];
    _codesField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:162/255.0 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:ZOOMPT(15)]}];
    _codesField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    _codesField.keyboardType = UIKeyboardTypeNumberPad;
    _codesField.delegate = self;
    [titleView addSubview:_codesField];

    /*
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
    [titleView addSubview:_timeBtn];
    */
    //验证码图片
    [titleView addSubview:self.pictureCodeView];
//    self.pictureCodeView.backgroundColor = DRandomColor;
//    self.pictureCodeView.layer.cornerRadius = ZOOM6(30);
    self.pictureCodeView.frame = CGRectMake(titleView.right-ZOOM6(250)-ZOOMPT(15), _codesField.top+ZOOMPT(10), ZOOM6(250), ZOOMPT(30));
    self.pictureCodeView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getPicture:)];
    [self.pictureCodeView addGestureRecognizer:tap];
    
//    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, titleView.width, 1)];
//    topLine.backgroundColor = kTableLineColor;
//    [titleView addSubview:topLine];
    
    UIView *centerLine = [[UIView alloc] initWithFrame:CGRectMake(0, ZOOMPT(50)+1, titleView.width , 1)];
    centerLine.backgroundColor = kTableLineColor;
    [titleView addSubview:centerLine];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(-ZOOM(62), ZOOMPT(100)+2, self.view.width, ZOOM6(20))];
    bottomLine.backgroundColor = kTableLineColor;
    [titleView addSubview:bottomLine];
    
    UIView *Line = [[UIView alloc] initWithFrame:CGRectMake(_pictureCodeView.left-ZOOMPT(10), _codesField.top + ZOOMPT(10), 1, ZOOMPT(50)-ZOOMPT(20))];
    Line.backgroundColor = kTableLineColor;
    [titleView addSubview:Line];
    
}
- (void)setScrollView {
    CGFloat lrMargin=ZOOM(62);
    CGFloat hMargin=ZOOM(32);
    CGFloat vMargin=ZOOM(100);
    CGFloat headH=ZOOM(80);
    CGFloat SH=ZOOM(100);
    CGFloat bottomHeight=ZOOM(200);
    
    CGFloat sectionFontSize=ZOOM6(30);
    CGFloat FontSize=ZOOM6(28);
    
//    UIScrollView *ScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(lrMargin, CGRectGetMaxY(titleView.frame)+hMargin, kScreenWidth-lrMargin*2, kScreenHeight-CGRectGetMaxY(titleView.frame)-hMargin-bottomHeight)];
    UIScrollView *ScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar-bottomHeight)];
    ScrollView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:ScrollView];

    
//    UIButton *bottomBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    bottomBtn.frame=CGRectMake(lrMargin, kScreenHeight-bottomHeight+hMargin, kScreenWidth-lrMargin*2, bottomHeight-hMargin*2);
//    bottomBtn.backgroundColor=tarbarrossred;
//    bottomBtn.layer.cornerRadius=3;
//    [bottomBtn setTitle:@"完成绑定" forState:UIControlStateNormal];
//    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [bottomBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:bottomBtn];
    
    _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitBtn.frame=CGRectMake(lrMargin, kScreenHeight-bottomHeight+hMargin, kScreenWidth-lrMargin*2, bottomHeight-hMargin*2);
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitBtn setTitle:@"完成绑定" forState:UIControlStateNormal];
    [_submitBtn setBackgroundImage:[UIImage imageWithColor:RGBA(183,184,186,1)] forState:UIControlStateNormal];
    [_submitBtn setBackgroundImage:[UIImage imageWithColor:tarbarrossred] forState:UIControlStateSelected];
    _submitBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOMPT(18)];
    _submitBtn.selected = YES;
    _submitBtn.enabled = NO;
//    [_submitBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];btnClick
    [_submitBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    _submitBtn.layer.cornerRadius = 3;
    _submitBtn.layer.masksToBounds = YES;
    [self.view addSubview:_submitBtn];
    
    ScrContainer = [UIView new];
    [ScrollView addSubview:ScrContainer];
//    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyborad)];
//    [ScrContainer addGestureRecognizer:tap];
    
    [self setupForDismissKeyboard];
    
    [ScrContainer mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(ScrollView);
        make.edges.equalTo(ScrollView).with.insets(UIEdgeInsetsMake(0,lrMargin,0,-lrMargin));
        make.width.equalTo(ScrollView.mas_width).offset(-lrMargin*2);
    }];
    
    [self createUI];

    
    UILabel *title=[[UILabel alloc]init];
    title.text=@"为了衣蝠能精准推荐美衣,您还需要选择以下内容";
    title.textColor=kTextGreyColor;
//    title.textAlignment=NSTextAlignmentCenter;
    title.numberOfLines=0;
    title.font=[UIFont systemFontOfSize:sectionFontSize];
    [ScrContainer addSubview:title];
    
    UIView *line=[[UIView alloc]init];
    line.backgroundColor=kTableLineColor;
    [ScrContainer addSubview:line];

    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(ScrContainer);
        make.top.equalTo(titleView.mas_bottom).offset(hMargin);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ScrollView);
        make.width.equalTo(ScrollView.mas_width);
        make.top.equalTo(title.mas_bottom).offset(hMargin);
        make.height.offset(1);
    }];

    
    UIView *lastView=line;
    for (int i=0; i<sectionArr.count; i++) {
        UILabel *sectionLabel=[[UILabel alloc]init];
        sectionLabel.text=sectionArr[i];
        sectionLabel.font=[UIFont systemFontOfSize:sectionFontSize];
        [ScrContainer addSubview:sectionLabel];
        
        [sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastView.mas_bottom).offset(hMargin);
            make.left.mas_equalTo(title.mas_left);
        }];
        
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat w = 0;
        CGFloat h = 0;
        w = (kScreenWidth-lrMargin*2-hMargin*2)/3;

        NSArray *btnTitleArr=btnArr[i];
        for (NSString *BtnTitle in btnTitleArr) {
            NSInteger index=[btnTitleArr indexOfObject:BtnTitle];
            x=(index%3)*(hMargin+w);
            y = headH+vMargin;
            h = SH;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:BtnTitle forState:UIControlStateNormal];
            [btn setTitleColor:COLOR_ROSERED forState:UIControlStateSelected];
            [btn setTitleColor:RGBACOLOR_F(0.5,0.5,0.5,0.6) forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:FontSize];
            btn.tag = 100*i+index+1;
            
            UIImage *btnSelectImage = [UIImage  imageNamed:@"筛选_选中.png"];
            CGSize  btnSelectImageSize = btnSelectImage.size;
            UIImage *btnSelectImageTemp = [btnSelectImage  stretchableImageWithLeftCapWidth:btnSelectImageSize.width*0.5  topCapHeight:btnSelectImageSize.height*0.5];
            [btn  setBackgroundImage:btnSelectImageTemp  forState:UIControlStateSelected];
            
            UIImage *btnNormalImage = [UIImage  imageNamed:@"筛选_未选中.png"];
            CGSize  btnNormalImageSize = btnNormalImage.size;
            UIImage *btnNormalImageTemp = [btnNormalImage  stretchableImageWithLeftCapWidth:btnNormalImageSize.width*0.5  topCapHeight:btnNormalImageSize.height*0.5];
            [btn  setBackgroundImage:btnNormalImageTemp  forState:UIControlStateNormal];
          
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [ScrContainer addSubview:btn];
            
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                if (index/3) {
                    make.top.equalTo(lastView.mas_bottom).offset(hMargin);
                }else
                    make.top.equalTo(sectionLabel.mas_bottom).offset(hMargin);
                make.left.offset(x);
                make.width.offset(w);
                make.height.offset(h);
            }];
            
            lastView=btn;
        }
    }
    
    
    [ScrContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
}
- (void)btnClick:(UIButton *)sender {
    [self.view endEditing:YES];
    [[NSUserDefaults standardUserDefaults] setObject:_otherToken forKey:USER_TOKEN];
    
//    if (sender == _timeBtn) {
    if (sender == _submitBtn) {
        if (_pcLoading == NO) {
            if (selectTwo.integerValue==4&&selectFour.integerValue==3) {
                [MBProgressHUD show:@"活动已结束" icon:nil view:nil];
                [self performSelector:@selector(leftBarButtonClick) withObject:nil afterDelay:1];
                return;
            }
            [self httpGetBindingPhoneCode];
            _pcLoading = YES;
        }
    }else{
        for (int i = 0; i<[btnArr[sender.tag/100]count]; i++) {
            UIButton *btn = (UIButton *)[ScrContainer viewWithTag:100*(sender.tag/100)+i+1];
            if (btn.tag!=sender.tag) {
                btn.selected = NO;
            }
        }
        sender.selected = !sender.selected;
        
        switch (sender.tag/100) {
            case 0:
                selectOne = sender.selected ? [NSString stringWithFormat:@"%zd",sender.tag%100] :nil;
                break;
            case 1:
                selectTwo = sender.selected ? [NSString stringWithFormat:@"%zd",sender.tag%100] :nil;
                break;
            case 2:
                selectThree = sender.selected ? [NSString stringWithFormat:@"%zd",sender.tag%100] :nil;
                break;
            case 3:
                selectFour = sender.selected ? [NSString stringWithFormat:@"%zd",sender.tag%100] :nil;
                break;
            case 4:
                selectFive = sender.selected ? [NSString stringWithFormat:@"%zd",sender.tag%100] :nil;
                break;
            default:
                break;
        }
        [self changeBottomBtn];
        
    }
}
- (void)bottomBtnClick:(UIButton *)sender{
    [self.view endEditing:YES];
    if (_phoneField.text.length < 11) {
        [MBProgressHUD show:@"请填写正确的手机号" icon:nil view:nil];
        return;
    }

    if (selectTwo.integerValue==4&&selectFour.integerValue==3) {
        [MBProgressHUD show:@"活动已结束" icon:nil view:nil];
        [self performSelector:@selector(leftBarButtonClick) withObject:nil afterDelay:1];
        return;
    }
//    if ([self validateMobile:self.phoneField.text]) {
//        [self httpBindingPhone]; //绑定手机号
        if (_cLoading == NO) {
            [self httpbindingChecKCode];
            _cLoading = YES;
        }
        
//    } else {
//        [MBProgressHUD showError:@"请输入正确的手机号"];
//    }
}
- (void)getPicture:(UIGestureRecognizer *)tap {
    [self httpGetCodeView:_phoneField.text];
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
#pragma mark - 网络请求
//新绑定手机号获取验证码-7
- (void)httpGetBindingPhoneCode {
    kSelfWeak;
    //传入图形验证码
    [YFShareModel getPhoneCodeWithPhone:_phoneField.text codetype:@"7" vcode:_codesField.text success:^(YFShareModel *data) {
//    [YFShareModel WXGetPhoneCodeWithPhone:phoneAndCode codetype:@"7" success:^(YFShareModel *data) {
        _pcLoading = NO;
        if (data.status == 1) {
            BoundPhoneVC *vc = [[BoundPhoneVC alloc]init];
            vc.type = BoundPhoneType_NewUser;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            /*
            [_timeBtn setTitle:@"重新获取" forState:UIControlStateSelected];
            _timeBtn.enabled = NO;
            __block int time = 120;
            if (_timer == nil) {
                _timer = [NSTimer weakTimerWithTimeInterval:1 target:self userInfo:nil repeats:YES block:^(NewUserBoundPhoneVC *target, NSTimer *timer) {
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
            */
        } else {
            [MBProgressHUD show:data.message icon:nil view:nil];
        }
    }];
}

- (void)httpbindingChecKCode {
    [YFShareModel getUserCheckCodeWithCode:_codesField.text Age:selectTwo success:^(YFShareModel *data) {
        _cLoading = NO;
        if (data.status == 1) {
            [MBProgressHUD showSuccess:data.message];
            [[NSUserDefaults standardUserDefaults] setObject:_phoneField.text forKey:USER_PHONE];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"isOneBuy" object:nil];
            
            [self performSelector:@selector(leftBarButtonClick) withObject:nil afterDelay:1];
            
            [[NSUserDefaults standardUserDefaults] setObject:_otherToken forKey:USER_TOKEN];
        } else {
            [MBProgressHUD show:data.message icon:nil view:nil];
        }
    }];
}
- (void)httpBindingPhone
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *phone = self.phoneField.text;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@user/checkPhone?version=%@&phone=%@&token=%@",[NSObject baseURLStr],VERSION,phone,token];
    
    NSString *URL = [MyMD5 authkey:urlStr];
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                if ([responseObject[@"bool"] boolValue] == NO) {
                    TFCodePhoneViewController *tcvc = [[TFCodePhoneViewController alloc] init];
                    tcvc.headTitle = @"绑定手机";
                    tcvc.index = 1;
                    //                tcvc.labelStr = @"验证码";
                    tcvc.phone = self.phoneField.text;
                    [self.navigationController pushViewController:tcvc animated:YES];
                } else {
                    [MBProgressHUD showError:@"该手机号已被绑定"];
                }
            } else {
                
//                if ([responseObject[@"status"] intValue] == 50) {
//                    //正确
//                    TFSetPaymentPasswordViewController *tovc = [[TFSetPaymentPasswordViewController alloc] init];
//                    tovc.index = 0;
//                    [self.navigationController pushViewController:tovc animated:YES];
//                } else {
                    [MBProgressHUD showError:responseObject[@"message"]];
//                }
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
}

- (void)changeBottomBtn{
    if (_phoneField.text.length == 11 && _codesField.text.length
        && selectFive && selectFour && selectThree &&selectTwo && selectOne) {
        _submitBtn.enabled = YES;
    } else {
        _submitBtn.enabled = NO;
    }
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField==_codesField) {
        [self changeBottomBtn];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField==_codesField) {
        return YES;
    }
    NSMutableString *text = [NSMutableString stringWithString:textField.text];
    [text replaceCharactersInRange:range withString:string];

    if(textField == _phoneField && text.length ==11 && string.length) {
        [self httpGetCodeView:text];
    }

    if (textField == _phoneField) {
        textField.text = [text substringToIndex:MIN(11, text.length)];
    } else {
        textField.text = [text substringToIndex:MIN(4, text.length)];
    }
    
    [self changeBottomBtn];
//    if (_phoneField.text.length == 11 && _codesField.text.length == 4) {
//        _submitBtn.enabled = YES;
//    } else {
//        _submitBtn.enabled = NO;
//    }
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
- (void)hideKeyborad {
    [self.view endEditing:YES];
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
