//
//  TFAddBankCardViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/8.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFAddBankCardViewController.h"
#import "TFBankListViewController.h"
#import "HZAreaPickerView.h"
#import "YiFuUserInfoManager.h"
#define CardNumbers @"0123456789"
#define PersonNUmbers @"0123456789xX"
#define PhoneNumbers @"0123456789"

@interface TFAddBankCardViewController () <UITextFieldDelegate,HZAreaPickerDelegate>

@property (nonatomic, strong) UIButton *nextBtn;

@property (strong, nonatomic) HZAreaPickerView *locatePicker;
@property (strong, nonatomic)NSString *provinceID;
@property (strong, nonatomic)NSString *cityID;

@property (strong, nonatomic)NSString *provinceName;
@property (strong, nonatomic)NSString *cityName;

@property (nonatomic, strong)UIScrollView *backgroundScrollView;
@property (nonatomic, strong)UILabel *addressLabel;


@property (nonatomic, strong)UIButton *addressBtn;

@property (nonatomic, assign)BOOL bankNOFlag;
@property (nonatomic, assign)BOOL nameFlag;
@property (nonatomic, assign)BOOL idenfFlag;
@property (nonatomic, assign)BOOL phoneFlag;
@property (nonatomic, assign)BOOL adddessFlag;
@property (nonatomic, assign)BOOL emailFlag;
@property (nonatomic, assign)BOOL bankNameFlag;

@end

@implementation TFAddBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super setNavigationItemLeft:self.navigationTitle];
    
    [self setupUI];
    
}
#pragma mark - 创建UI
- (void)setupUI
{
    //使用 通知  监听键盘出现
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //监听键盘消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7+5, kScreenWidth, kScreenHeight-kNavigationheightForIOS7-5)];
//    self.backgroundScrollView.bounces = NO;
    self.backgroundScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.backgroundScrollView];
    
//    NSArray *titleArr = [NSArray arrayWithObjects:@{@"tit":@"卡号",@"pla":@"输入银行卡号"},@{@"tit":@"持卡人",@"pla":@"银行卡户名"},@{@"tit":@"身份证",@"pla":@"持卡人对应身份证号"},@"身份信息严格加密处理,仅用于银行验证",@{@"tit":@"手机号",@"pla":@"银行预留手机号"},@"收款人省/市", @{@"tit":@"收款人邮箱",@"pla":@""},@{@"tit":@"支行名称",@"pla":@""}, nil];
    
    NSArray *titleArr = [NSArray arrayWithObjects:
                         @{@"tit":@"卡号",@"pla":@"输入银行卡号"},
                         @{@"tit":@"持卡人",@"pla":@"银行卡户名"},
//                         @{@"tit":@"身份证",@"pla":@"持卡人对应身份证号"},
//                         @"为了您的账户信息安全，身份证号必须正确填写，平台将与银行预留信息进行比对，错误将直接导致提现失败，身份信息严格加密处理，仅用于银行验证。",
                         @{@"tit":@"手机号",@"pla":@"银行预留手机号"},
                         @"仅支持绑定借记卡。",
                         nil];

    
    CGFloat l_margin = ZOOM(62);
    
    for (int i = 0; i<titleArr.count; i++) {
        if (i<3) {
            UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(l_margin, i*(35)+i*(20), kScreenWidth-2*l_margin, (35))];
            tf.borderStyle = UITextBorderStyleNone;
            tf.delegate = self;
            tf.layer.masksToBounds =  YES;
            tf.layer.borderWidth = 1;
            tf.layer.borderColor = [RGBCOLOR_I(220,220,220) CGColor];
            tf.layer.cornerRadius = 3;

            tf.placeholder = [titleArr[i] objectForKey:@"pla"];
            tf.returnKeyType = UIReturnKeyNext;
//            [tf setValue:[UIFont boldSystemFontOfSize:ZOOM(50)] forKeyPath:@"_placeholderLabel.font"];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ZOOM(300), tf.frame.size.height)];
            
            label.text = [NSString stringWithFormat:@"  %@",[titleArr[i] objectForKey:@"tit"]];
            label.font = kFont6px(34);
            tf.leftView = label;
            tf.leftViewMode =  UITextFieldViewModeAlways;
            tf.tag = 200+i;
            [self.backgroundScrollView addSubview:tf];
        } else if (i == 3) {
            UITextField *tf = (UITextField *)[self.backgroundScrollView viewWithTag:202];
            
            NSString *text = titleArr[i];
            NSString *subString = @"身份证号必须正确填写";
            NSRange range = [text rangeOfString:subString];
            
            CGSize stringSize = [text getSizeWithFont:kFont6px(28) constrainedToSize:CGSizeMake(kScreenWidth-l_margin*2, 1000)];
            NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:text];
            [attrText addAttribute:NSForegroundColorAttributeName value:COLOR_ROSERED range:range];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(l_margin, tf.bottom+(10), stringSize.width, stringSize.height)];
//            label.text = titleArr[i];
            label.textColor = RGBACOLOR_F(0.5,0.5,0.5,0.7);
            label.attributedText = attrText;
            label.tag = 200+i;
            label.numberOfLines = 0;
            label.font = kFont6px(28);
            [self.backgroundScrollView addSubview:label];
        } else if (i >= 4) {
            UILabel *label = (UILabel *)[self.backgroundScrollView viewWithTag:203];
            
            CGRect frame = CGRectMake(l_margin, label.frame.origin.y+label.frame.size.height+(i-3)*20+(i-4)*35, kScreenWidth-2*l_margin, (35));
            
            if (i == 5) {
                
                UIView *backview = [[UIView alloc]initWithFrame:frame];
                backview.layer.borderWidth = 1;
                backview.layer.borderColor = [RGBCOLOR_I(220,220,220) CGColor];
                backview.layer.cornerRadius = ZOOM(15);
                [self.backgroundScrollView addSubview:backview];
                
                UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ZOOM(320), CGRectGetHeight(backview.frame))];
                label2.text = [NSString stringWithFormat:@"  %@",titleArr[i]];
                label2.textAlignment = NSTextAlignmentLeft;
                label2.font = kFont6px(34);
                [backview addSubview:label2];
                
                self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame), 0, CGRectGetWidth(backview.frame)-CGRectGetMaxX(label2.frame), CGRectGetHeight(backview.frame))];
                self.addressLabel.tag = 200+i;
                self.addressLabel.font = kFont6px(32);
                self.addressLabel.numberOfLines = 0;
                
                
                [backview addSubview:self.addressLabel];
                
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(0, 0, backview.frame.size.width, backview.frame.size.height);
                [backview addSubview:_addressBtn = btn];
                
                
                [btn addTarget:self action:@selector(addressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
            } else {
                
                UITextField *tf = [[UITextField alloc] initWithFrame:frame];
                tf.borderStyle = UITextBorderStyleNone;
                tf.delegate = self;
                tf.returnKeyType = UIReturnKeyNext;
                tf.layer.masksToBounds =  YES;
                tf.layer.borderWidth = 1;
                tf.layer.borderColor = [RGBCOLOR_I(220,220,220) CGColor];
                tf.layer.cornerRadius = 3;
                
                tf.placeholder = [titleArr[i] objectForKey:@"pla"];
//                [tf setValue:[UIFont boldSystemFontOfSize:ZOOM(50)] forKeyPath:@"_placeholderLabel.font"];
                UILabel *llabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ZOOM(300), tf.frame.size.height)];
                llabel.font = kFont6px(34);
                llabel.text = [NSString stringWithFormat:@"  %@",[titleArr[i] objectForKey:@"tit"]];
                tf.leftView = llabel;
                tf.leftViewMode =  UITextFieldViewModeAlways;
                tf.tag = 200+i;
                
                if (i == titleArr.count-1) {
                    tf.returnKeyType = UIReturnKeyDone;
                }
                
                [self.backgroundScrollView addSubview:tf];
            }

        }
    }

    
    UITextField *tf = (UITextField *)[self.backgroundScrollView viewWithTag:202];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake( tf.frame.origin.x, CGRectGetMaxY(tf.frame)+20+60, kScreenWidth-2*tf.frame.origin.x, ZOOM(110));
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    btn.titleLabel.font = kFont6px(34);
    [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框高亮"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(startNextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundScrollView addSubview:_nextBtn = btn];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake((kScreenWidth-(150))/2, btn.frame.origin.y+btn.frame.size.height+(20), (150), (30));
    [btn2 setTitle:@"查看支持的银行" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:(16)];
    [btn2 addTarget:self action:@selector(findBankBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundScrollView addSubview:btn2];
    
    self.backgroundScrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(btn2.frame));
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
    [self.backgroundScrollView addGestureRecognizer:tap];
    
    
    if ([self.navigationTitle isEqualToString:@"完善身份验证"]) {
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"您这张银行卡有未完善的信息,请完善后再提现" Controller:self];
        
        UITextField *bankNO = (UITextField *)[self.backgroundScrollView viewWithTag:200];   //银行卡号
        UITextField *name = (UITextField *)[self.backgroundScrollView viewWithTag:201];     //持卡人
        UITextField *idenf = (UITextField *)[self.backgroundScrollView viewWithTag:202];    //身份证
        UITextField *phone = (UITextField *)[self.backgroundScrollView viewWithTag:204];    //手机号
        UITextField *email = (UITextField *)[self.backgroundScrollView viewWithTag:206];    //邮箱
        UITextField *bankName = (UITextField *)[self.backgroundScrollView viewWithTag:207]; //银行名称
        
        if (self.bModel.bank_no!=nil) {
            bankNO.text = [NSString stringWithFormat:@"**%@", self.bModel.bank_no];
            bankNO.userInteractionEnabled = NO;
            
            self.bankNOFlag = YES;
        }
        
        if (self.bModel.name!=nil) {
            name.text = [NSString stringWithFormat:@"%@", self.bModel.name];
//            name.userInteractionEnabled = NO;
//            self.nameFlag = YES;
        }
        
        if (self.bModel.identity!=nil) {
            idenf.text = [NSString stringWithFormat:@"%@", self.bModel.identity];
//            idenf.userInteractionEnabled = NO;
//            self.idenfFlag = YES;
        }
        
        if (self.bModel.phone!=nil) {
            phone.text = [NSString stringWithFormat:@"%@", self.bModel.phone];
//            phone.userInteractionEnabled = NO;
//            self.phoneFlag = YES;
        }
        
        if (self.bModel.e_main!=nil) {
            email.text = [NSString stringWithFormat:@"%@", self.bModel.e_main];
//            email.userInteractionEnabled = NO;
//            self.emailFlag = YES;
        }
        
        if (self.bModel.branch_name!=nil) {
            bankName.text = [NSString stringWithFormat:@"%@", self.bModel.branch_name];
//            bankName.userInteractionEnabled = NO;
//            self.bankNameFlag = YES;
        }
        
        if (self.bModel.province!=nil && self.bModel.city !=nil) {
            self.addressLabel.text = [NSString stringWithFormat:@"%@  %@", self.bModel.province, self.bModel.city];
            
            self.provinceID = [NSString stringWithFormat:@"%@",self.bModel.province_id];
            self.cityID = [NSString stringWithFormat:@"%@",self.bModel.city_id];
            self.provinceName = [NSString stringWithFormat:@"%@",self.bModel.province];
            self.cityName = [NSString stringWithFormat:@"%@",self.bModel.city];
//            self.addressBtn.userInteractionEnabled = NO;
//            self.adddessFlag = YES;
        }
        
    }

}

- (void)addressBtnClick:(UIButton *)sender
{
    //省/市");
    [self.view endEditing:YES];
    
    [self cancelLocatePicker];
    
    self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAddress delegate:self];
    
    [self.locatePicker showInView:self.view];
    
}

#pragma mark - HZAreaPicker delegate
-(void)doneClick:(HZAreaPickerView *)picker
{
    /************  改变地址   **********/
    self.addressLabel.text = [NSString stringWithFormat:@"%@   %@", picker.locate.state, picker.locate.city];
    
    self.provinceName = picker.locate.state;
    self.cityName = picker.locate.city;
    
    self.provinceID = picker.locate.stateID;
    self.cityID = picker.locate.cityID;
    
    //pID = %@, cID = %@", self.provinceID, self.cityID);

}

-(void)cancelLocatePicker
{
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
}

- (void)tapGR:(UITapGestureRecognizer *)sender
{
//    //tap");
    [self.view endEditing:YES];
}

// 防止用户狂点
- (void)startNextBtnClick
{
//    MyLog(@"点击");
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(nextBtnClick)object:nil];
    [self performSelector:@selector(nextBtnClick)withObject:nil afterDelay:0.5f];
}

- (void)nextBtnClick
{
//    NSLog(@"执行");
    UITextField *bankNO = (UITextField *)[self.backgroundScrollView viewWithTag:200]; //银行卡号
    UITextField *name = (UITextField *)[self.backgroundScrollView viewWithTag:201];  //持卡人
    UITextField *phone = (UITextField *)[self.backgroundScrollView viewWithTag:202];  //手机号
    
    UITextField *idenf = (UITextField *)[self.backgroundScrollView viewWithTag:204];  //身份证
    UITextField *email = (UITextField *)[self.backgroundScrollView viewWithTag:206];  //邮箱
    UITextField *bankName = (UITextField *)[self.backgroundScrollView viewWithTag:207];  //银行名称
    
    
    if (bankNO.text.length == 0) {
        [MBProgressHUD showError:@"银行卡号不能为空!"];
        return;
    }
    if (name.text.length == 0) {
        [MBProgressHUD showError:@"银行卡户名不能为空!"];
        return;
    }
//    if (idenf.text.length == 0) {
//        [MBProgressHUD showError:@"身份证号码不能为空!"];
//        return;
//    }
    if (phone.text.length == 0) {
        [MBProgressHUD showError:@"手机号码不能为空!"];
        return;
    }
//    if (self.addressLabel.text.length == 0) {
//        [MBProgressHUD showError:@"省市区不能为空!"];
//        return;
//    }
//    if (email.text.length == 0) {
//        [MBProgressHUD showError:@"邮箱不能为空!"];
//        return;
//    }
//    if (bankName.text.length == 0) {
//        [MBProgressHUD showError:@"支行名称不能为空!"];
//        return;
//    }
    
    if ([TFPublicClass stringContainsEmoji:bankNO.text] || [TFPublicClass stringContainsEmoji:name.text]|| [TFPublicClass stringContainsEmoji:idenf.text]|| [TFPublicClass stringContainsEmoji:phone.text]|| [TFPublicClass stringContainsEmoji:email.text]|| [TFPublicClass stringContainsEmoji:bankName.text]) {
        [MBProgressHUD showError:@"不支持Emoji表情符号!"];
        return;
    }
    
    
    BOOL bankNOBl = [self isString:bankNO.text toCompString:CardNumbers];
    BOOL nameBl = ![name.text isEqualToString:@""];
    BOOL idenfBl = [idenf.text isIdCard];
    BOOL phoneBl = [self isString:phone.text toCompString:PhoneNumbers];
    
//    BOOL bankNameBl = ![bankName.text isEqualToString:@""];
//    BOOL emailBl = [self validateEmail:email.text];
    BOOL cityBl = self.addressLabel.text.length != 0;
    
//    //city = %@, cityBl = %d", self.addressLabel.text,cityBl);
    
    if ([self.navigationTitle isEqualToString:@"身份验证"]) {
        
        if (bankNOBl&&nameBl&&phoneBl) {
            //输入信息详细
            self.nextBtn.enabled = NO;
            [self httpAddCard];
            return;
        }
        if (!bankNOBl) {
            [MBProgressHUD showError:@"请输入正确的银行卡号"];
            return;
        }
        if (!nameBl) {
            [MBProgressHUD showError:@"请输入银行卡户名"];
            return;
        }
//        if (!idenfBl) {
//            [MBProgressHUD showError:@"请输入正确的身份证号码"];
//            return;
//        }
        if (!phoneBl) {
            [MBProgressHUD showError:@"请输入正确的手机号码"];
            return;
        }
//        else if (!emailBl) {
//            [MBProgressHUD showError:@"请输入收款人邮箱"];
//        }
//        if (!cityBl) {
//            [MBProgressHUD showError:@"请选择收款人省市"];
//            return;
//        }
//        else if (!bankNameBl)
//        {
//            [MBProgressHUD showError:@"请输入支行名称"];
//        }
//        else {
//            [MBProgressHUD showError:@"输入有误,请检查后重新输入"];
//            return;
//        }
    } else if ([self.navigationTitle isEqualToString:@"完善身份验证"]) {
        
        if (nameBl&&phoneBl) {
            //输入信息详细
            self.nextBtn.enabled = NO;
            [self httpUpdateMyBank];
            return;
        }
        if (!nameBl) {
            [MBProgressHUD showError:@"请输入银行卡户名"];
            return;
        }
//        if (!idenfBl) {
//            [MBProgressHUD showError:@"请输入正确的身份证号码"];
//            return;
//        }
        if (!phoneBl) {
            [MBProgressHUD showError:@"请输入正确的手机号码"];
            return;
        }
//        else if (!emailBl)
//        {
//            [MBProgressHUD showError:@"请正确输入收款人邮箱"];
//        }
//        if (!cityBl) {
//            [MBProgressHUD showError:@"请选择收款人省市"];
//            return;
//        }
//        else if (!bankNameBl) {
//            [MBProgressHUD showError:@"请输入支行名称"];
//        }
//        else {
//            [MBProgressHUD showError:@"输入有误,请检查后重新输入"];
//            return;
//        }
    }
}
#pragma mark - 修改银行卡信息
- (void)httpUpdateMyBank
{
//    UITextField *tf1 = (UITextField *)[self.backgroundScrollView viewWithTag:200];  //银行卡号
    UITextField *tf2 = (UITextField *)[self.backgroundScrollView viewWithTag:201];  //持卡人
    UITextField *tf3 = (UITextField *)[self.backgroundScrollView viewWithTag:202];  //手机号
    
//    UITextField *tf4 = (UITextField *)[self.backgroundScrollView viewWithTag:204];  //手机号
//    UITextField *tf5 = (UITextField *)[self.backgroundScrollView viewWithTag:206];  //邮箱
//    UITextField *tf6 = (UITextField *)[self.backgroundScrollView viewWithTag:207];  //银行名称
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
//    NSString *bank_no = tf1.text;
    NSString *identity = tf3.text;
    NSString *name = tf2.text;
    NSString *phone = tf3.text;
//    NSString *email = tf5.text;
//    NSString *bankName = tf6.text;
    
//    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/updateMyBankCard?token=%@&version=%@&identity=%@&name=%@&phone=%@&branch_name=%@&e_main=%@&province_id=%@&province=%@&city_id=%@&city=%@&id=%@",[NSObject baseURLStr],token,@"V1.26",identity,name,phone, bankName, email, self.provinceID, self.provinceName,self.cityID, self.cityName, self.bModel.ID];
    
//    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/updateMyBankCard?token=%@&version=%@&identity=%@&name=%@&phone=%@&province_id=%@&province=%@&city_id=%@&city=%@&id=%@",[NSObject baseURLStr],token,VERSION,identity,name,phone, self.provinceID, self.provinceName,self.cityID, self.cityName, self.bModel.ID];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/updateMyBankCard?token=%@&version=%@&name=%@&phone=%@&id=%@",[NSObject baseURLStr],token,VERSION,name,phone,self.bModel.ID];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        self.nextBtn.enabled = YES;
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                [MBProgressHUD showSuccess:@"修改成功"];
                
                [self saveUserIdenfToDBWithUserIdenf:identity];
                
                [NSTimer weakTimerWithTimeInterval:1 target:self selector:@selector(wait:) userInfo:nil repeats:NO];
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        self.nextBtn.enabled = YES;
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];

}
#pragma mark - 保存身份证信息
- (void)saveUserIdenfToDBWithUserIdenf:(NSString *)idenf
{
    YiFuUserInfo *user = [[YiFuUserInfo alloc] init];
    user.userId = [NSNumber numberWithInteger:[[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID] integerValue]];
    user.userIdenf = idenf;
    [YiFuUserInfoManager insertUserInfo:user];
}

#pragma mark - 绑定银行卡
- (void)httpAddCard
{
    UITextField *tf1 = (UITextField *)[self.backgroundScrollView viewWithTag:200];  //银行卡号
    UITextField *tf2 = (UITextField *)[self.backgroundScrollView viewWithTag:201];  //持卡人
    UITextField *tf3 = (UITextField *)[self.backgroundScrollView viewWithTag:202];  //手机号
    
    
    UITextField *tf4 = (UITextField *)[self.backgroundScrollView viewWithTag:204];  //手机号
    UITextField *tf5 = (UITextField *)[self.backgroundScrollView viewWithTag:206];  //邮箱
    UITextField *tf6 = (UITextField *)[self.backgroundScrollView viewWithTag:207];  //银行名称
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *bank_no = tf1.text;
    NSString *identity = tf3.text;
    NSString *name = tf2.text;
    NSString *phone = tf3.text;
    NSString *email = tf5.text;
    NSString *bankName = tf6.text;
    NSString *imei = [[NSUserDefaults standardUserDefaults] objectForKey:USER_UUID];
//    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/addMyBankCard?token=%@&version=%@&bank_no=%@&identity=%@&name=%@&phone=%@&branch_name=%@&e_main=%@&province_id=%@&province=%@&city_id=%@&city=%@&mac=0&imei=%@",[NSObject baseURLStr],token,VERSION,bank_no,identity,name,phone, bankName, email, self.provinceID, self.provinceName,self.cityID, self.cityName, imei];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/addMyBankCard?token=%@&version=%@&bank_no=%@&name=%@&phone=%@&mac=0&imei=%@",[NSObject baseURLStr],token,VERSION,bank_no,name,phone, imei];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        self.nextBtn.enabled = YES;
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                [MBProgressHUD showSuccess:@"绑定成功"];

                [self saveUserIdenfToDBWithUserIdenf:identity];
                
                [NSTimer weakTimerWithTimeInterval:1 target:self selector:@selector(wait:) userInfo:nil repeats:NO];
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }

        }
        
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          
          self.nextBtn.enabled = YES;
          NavgationbarView *mentionview=[[NavgationbarView alloc]init];
          [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];

}

- (void)findBankBtnClick
{
    TFBankListViewController *tbvc = [[TFBankListViewController alloc] init];
    [self.navigationController pushViewController:tbvc animated:YES];
}

#pragma mark - textField

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag < 207) {
    //注销当前文本为第一响应者 (此时无文本编辑，键盘会自动收起)
//        [textField resignFirstResponder];
    //成为第一响应者，（让键盘出来）
    //        [textField becomeFirstResponder];
    UITextField *tf;
    if (textField.tag == 202||textField.tag == 204) {
        tf = (UITextField *)[self.backgroundScrollView viewWithTag:textField.tag+2];
    } else {
        tf = (UITextField *)[self.backgroundScrollView viewWithTag:textField.tag+1];
    }

    //再让其成为第一响应者 , (此时自动弹出键盘)
    [tf becomeFirstResponder];
    } else if (textField.tag == 207){
        [self.view endEditing:YES];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //tag = %d",(int)textField.tag);
    if ((textField.tag == 200)||(textField.tag == 201)) {
        [UIView animateWithDuration:0.8 animations:^{
            self.backgroundScrollView.contentOffset = CGPointMake(0, 0);
        }];
    } else if (textField.tag == 202) {
        if (kDevice_Is_iPhone4) {
            [UIView animateWithDuration:0.8 animations:^{
                self.backgroundScrollView.contentOffset = CGPointMake(0, 80);
            }];
        } else if (kDevice_Is_iPhone5||kDevice_Is_iPhone6||kDevice_Is_iPhone6Plus) {
            [UIView animateWithDuration:0.8 animations:^{
                self.backgroundScrollView.contentOffset = CGPointMake(0, 0);
            }];
        }
    }  else if (textField.tag == 204) {
        if (kDevice_Is_iPhone4||kDevice_Is_iPhone5) {
            [UIView animateWithDuration:0.8 animations:^{
                self.backgroundScrollView.contentOffset = CGPointMake(0, 200);
            }];
        } else if (kDevice_Is_iPhone6||kDevice_Is_iPhone6Plus) {
            [UIView animateWithDuration:0.8 animations:^{
                self.backgroundScrollView.contentOffset = CGPointMake(0, 60);
            }];
        }
    } else if (textField.tag == 206) {
        if (kDevice_Is_iPhone4||kDevice_Is_iPhone5) {
            [UIView animateWithDuration:0.8 animations:^{
                self.backgroundScrollView.contentOffset = CGPointMake(0, 300);
            }];
        } else if (kDevice_Is_iPhone6||kDevice_Is_iPhone6Plus) {
            [UIView animateWithDuration:0.8 animations:^{
                self.backgroundScrollView.contentOffset = CGPointMake(0, 180);
            }];
        }
    } else if (textField.tag == 207) {
        
        if (kDevice_Is_iPhone4) {
            [UIView animateWithDuration:0.8 animations:^{
                self.backgroundScrollView.contentOffset = CGPointMake(0, 360);
            }];
        } else if (kDevice_Is_iPhone5) {
            [UIView animateWithDuration:0.8 animations:^{
                self.backgroundScrollView.contentOffset = CGPointMake(0, 300);
            }];
        } else if (kDevice_Is_iPhone6||kDevice_Is_iPhone6Plus) {
            [UIView animateWithDuration:0.8 animations:^{
                self.backgroundScrollView.contentOffset = CGPointMake(0, 240);
            }];
        }
    }
    return YES;
}


#pragma mark - 键盘出现和消失
//键盘出现
- (void)keyboardWillShow:(NSNotification *)noti
{
    //键盘高度
    //    CGFloat keyboardHeight = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
}

//键盘消失,其他坐标归位
- (void)keyboardWillHide:(NSNotification *)noti
{
    self.backgroundScrollView.contentOffset = CGPointMake(0, 0);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)wait:(NSTimer *)timer
{
    [self.navigationController popViewControllerAnimated:YES];
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
