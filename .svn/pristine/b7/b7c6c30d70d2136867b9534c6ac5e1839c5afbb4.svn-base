//
//  TFRedDetailViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 16/3/30.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFMeSendRedViewController.h"
//#import "PaystyleViewController.h"
#import "TFPayStyleViewController.h"

@interface TFMeSendRedViewController () <UITextViewDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITextField *phoneField;
@property (nonatomic, strong)UITextField *codeField;
@property (nonatomic, strong)UIButton *codeBtn;
@property (nonatomic, strong)UITextField *numberField;
@property (nonatomic, strong)UITextField *moneyNumberField;
@property (nonatomic, strong)UIButton *setBtn;
@property (nonatomic, strong)UITextView *voiceTextView;
@property (nonatomic, strong)UIView *backgroundView;
@property (nonatomic, strong)UILabel *moneyLab;
@property (nonatomic, strong)UIButton *okBtn;

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSourceArray;

@property (nonatomic, strong)UIScrollView *backgroundScrollView;
@property (nonatomic, strong)UILabel *promptLabel;

@property (nonatomic, strong)NSIndexPath *indexPathFlag;

@property (nonatomic, copy)NSString *redCode;   //红包编号
@property (nonatomic, copy)NSString *redPrice;     //金额

@end

@implementation TFMeSendRedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setNavigationItemLeft:@"我要发红包"];
    
    [self createUI];
    
}

- (void)createUI
{
    [self.view addSubview:self.backgroundScrollView];
    
    CGFloat M_ud = ZOOM(84);
    CGFloat M_lr = ZOOM(48);
    CGFloat W = kScreenWidth-2*M_lr;
    CGFloat H_textField = ZOOM(120);
    
    CGFloat M_text = 3;
    CGFloat F_radius = 3;
    
    //输入手机号码
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(M_lr, M_ud, W, H_textField)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.cornerRadius = F_radius;
    backgroundView.layer.masksToBounds = YES;
//    [self.backgroundScrollView addSubview:backgroundView];
    
    UITextField *phoneField = [[UITextField alloc] initWithFrame:CGRectMake(M_text, 0, W-M_text, H_textField)];
    phoneField.placeholder = @"输入手机号码";
    phoneField.font = kFont6px(32);
    phoneField.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:_phoneField = phoneField];
    
    //验证码
    UIView *backgroundView2 = [[UIView alloc] initWithFrame:CGRectMake(M_lr, M_ud+CGRectGetMaxY(backgroundView.frame), W-ZOOM(280)+5, H_textField)];
    backgroundView2.backgroundColor = [UIColor whiteColor];
    backgroundView2.layer.cornerRadius = F_radius;
    backgroundView2.layer.masksToBounds = YES;
//    [self.backgroundScrollView addSubview:backgroundView2];
    
    
    UITextField *codeField = [[UITextField alloc] initWithFrame:CGRectMake(M_text, 0, CGRectGetWidth(backgroundView2.frame)-M_text, H_textField)];
    codeField.placeholder = @"验证码";
    codeField.font = kFont6px(32);
    codeField.backgroundColor = [UIColor whiteColor];
    [backgroundView2 addSubview:_codeField = codeField];
    
    //获取验证码
    UIButton *codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    codeBtn.frame = CGRectMake(kScreenWidth-M_lr-ZOOM(280), M_ud+CGRectGetMaxY(backgroundView.frame), ZOOM(280), H_textField);
    [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [codeBtn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateNormal];
    [codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    codeBtn.titleLabel.font = kFont6px(32);
    [codeBtn addTarget:self action:@selector(getCodeClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.backgroundScrollView addSubview:_codeBtn = codeBtn];
    
    //红包个数
    UIView *backgroundView3 = [[UIView alloc] initWithFrame:CGRectMake(M_lr, M_ud, W, H_textField)];
    backgroundView3.backgroundColor = [UIColor whiteColor];
    backgroundView3.layer.cornerRadius = F_radius;
    backgroundView3.layer.masksToBounds = YES;
    [self.backgroundScrollView addSubview:backgroundView3];
    
    UILabel *redCountLab = [[UILabel alloc] initWithFrame:CGRectMake(M_text, 0, ZOOM(200), H_textField)];
    redCountLab.text = @"红包个数";
    redCountLab.font = kFont6px(32);
//    redCountLab.backgroundColor = COLOR_RANDOM;
    [backgroundView3 addSubview:redCountLab];
    
    UILabel *numberLab = [[UILabel alloc] initWithFrame:CGRectMake(W- M_text-ZOOM(60), 0, ZOOM(60), H_textField)];
    numberLab.text = @"个";
    numberLab.font = kFont6px(32);
    numberLab.textAlignment = NSTextAlignmentRight;
//    numberLab.backgroundColor = COLOR_RANDOM;
    [backgroundView3 addSubview:numberLab];
    
    UITextField *numberField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(redCountLab.frame), 0, W-CGRectGetMaxX(redCountLab.frame)-CGRectGetWidth(numberLab.frame)-M_text, H_textField)];
    numberField.textAlignment = NSTextAlignmentRight;
//    numberField.text = @"0";
    numberField.delegate = self;
//    numberField.backgroundColor = COLOR_RANDOM;
    [backgroundView3 addSubview:_numberField = numberField];
    
    //金额
    UIView *backgroundView4 = [[UIView alloc] initWithFrame:CGRectMake(M_lr, M_ud+CGRectGetMaxY(backgroundView3.frame), W, H_textField)];
    backgroundView4.backgroundColor = [UIColor whiteColor];
    backgroundView4.layer.cornerRadius = F_radius;
    backgroundView4.layer.masksToBounds = YES;
    [self.backgroundScrollView addSubview:backgroundView4];
    
    UILabel *moneyCountLab = [[UILabel alloc] initWithFrame:CGRectMake(M_text, 0, ZOOM(180), H_textField)];
    moneyCountLab.text = @"总金额";
    moneyCountLab.font = kFont6px(32);
    //    redCountLab.backgroundColor = COLOR_RANDOM;
    [backgroundView4 addSubview:moneyCountLab];
    
    UILabel *moneyNumberLab = [[UILabel alloc] initWithFrame:CGRectMake(W- M_text-ZOOM(60), 0, ZOOM(60), H_textField)];
    moneyNumberLab.text = @"元";
    moneyNumberLab.font = kFont6px(32);
    moneyNumberLab.textAlignment = NSTextAlignmentRight;
//    moneyNumberLab.backgroundColor = COLOR_RANDOM;
    [backgroundView4 addSubview:moneyNumberLab];
    
    
    UIImageView *pImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(moneyCountLab.frame), (H_textField-ZOOM(60))*0.5, ZOOM(60), ZOOM(60))];
    pImageView.image = [UIImage imageNamed:@"拼手气"];
    [backgroundView4 addSubview:pImageView];
    
    
    UITextField *moneyNumberField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pImageView.frame), 0, W-CGRectGetMaxX(pImageView.frame)-CGRectGetWidth(moneyNumberLab.frame)-M_text, H_textField)];
    moneyNumberField.textAlignment = NSTextAlignmentRight;
//    moneyNumberField.backgroundColor = COLOR_RANDOM;
    moneyNumberField.delegate = self;
//    moneyNumberField.text = @"0";
//    moneyNumberField.keyboardType = UIKeyboardTypeNumberPad;
    [backgroundView4 addSubview:_moneyNumberField = moneyNumberField];

    //期望匹配度
    UIView *backgroundView5 = [[UIView alloc] initWithFrame:CGRectMake(M_lr, M_ud+CGRectGetMaxY(backgroundView4.frame), W, H_textField*3)];
    backgroundView5.backgroundColor = [UIColor whiteColor];
    backgroundView5.layer.cornerRadius = F_radius;
    backgroundView5.layer.masksToBounds = YES;
    [self.backgroundScrollView addSubview:backgroundView5];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(M_text, 0, ZOOM(250), H_textField)];
    titleLab.text = @"期望匹配度";
    titleLab.font = kFont6px(32);
//    titleLab.backgroundColor = COLOR_RANDOM;
    [backgroundView5 addSubview:titleLab];
    
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setBtn.frame = CGRectMake(W- M_text-ZOOM(200), 0, ZOOM(200), H_textField);
    [setBtn setTitle:@"50%" forState:UIControlStateNormal];
    [setBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    setBtn.titleLabel.font = kFont6px(32);
    setBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    
    [setBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView5 addSubview:_setBtn = setBtn];
    
    
    NSString *st = @"比如系统语音匹配度达到50%,就能成功领取红包";
    CGSize size_st = [st boundingRectWithSize:CGSizeMake(W-M_text*2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(46)]} context:nil].size;
    
    UILabel *detailLab = [[UILabel alloc] initWithFrame:CGRectMake(M_text, CGRectGetMaxY(titleLab.frame), W-M_text*2, size_st.height)];
    detailLab.text = st;
    detailLab.font = kFont6px(32);
    detailLab.numberOfLines = 0;
    detailLab.textColor = RGBCOLOR_I(167,167,167);
//    detailLab.backgroundColor = COLOR_RANDOM;
    [backgroundView5 addSubview:detailLab];

    //语音文字
    UIView *backgroundView6 = [[UIView alloc] initWithFrame:CGRectMake(M_lr, M_ud+CGRectGetMaxY(backgroundView5.frame), W, H_textField*2.5)];
    backgroundView6.backgroundColor = [UIColor whiteColor];
    backgroundView6.layer.cornerRadius = F_radius;
    backgroundView6.layer.masksToBounds = YES;
    [self.backgroundScrollView addSubview:backgroundView6];
    
    
    NSString *st1 = @"请输入语音文字5-100个汉字";
    CGSize size_st1 = [st1 boundingRectWithSize:CGSizeMake(W-M_text*2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(48)]} context:nil].size;
    
    
    UITextView *voiceTextView = [[UITextView alloc] initWithFrame:CGRectMake(M_text, 5, W-2*M_text, CGRectGetHeight(backgroundView6.frame))];
    voiceTextView.delegate = self;
    [backgroundView6 addSubview:_voiceTextView = voiceTextView];
    
    UILabel *pLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size_st1.width, size_st1.height)];
    pLab.text = st1;
    pLab.numberOfLines = 0;
    pLab.font = kFont6px(32);
    pLab.textColor = RGBCOLOR_I(167,167,167);
    pLab.userInteractionEnabled = NO;
    [voiceTextView addSubview: _promptLabel = pLab];
    
    UILabel *moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(M_lr, CGRectGetMaxY(backgroundView6.frame)+ZOOM(80), W, ZOOM(280))];
    moneyLab.text = [NSString stringWithFormat:@"¥%.2f", [moneyNumberField.text floatValue]];
    moneyLab.font = kFont6px(96);
    moneyLab.textAlignment = NSTextAlignmentCenter;
//    moneyLab.backgroundColor = COLOR_ROSERED;
    [self.backgroundScrollView addSubview:_moneyLab = moneyLab];
    
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(M_lr, CGRectGetMaxY(moneyLab.frame)+M_ud, W, H_textField*1.25);
    [okBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:236/255.0 green:121/255.0 blue:125/255.0 alpha:1]] forState:UIControlStateSelected];
    [okBtn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateNormal];
    okBtn.userInteractionEnabled = NO;
    okBtn.selected = YES;
    okBtn.layer.cornerRadius = F_radius;
    okBtn.layer.masksToBounds = YES;
    okBtn.titleLabel.font = kFont6px(34);
    [okBtn setTitle:@"塞钱进红包" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(okBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundScrollView addSubview:_okBtn = okBtn];
    
    self.backgroundScrollView.contentSize = CGRectGetMaxY(okBtn.frame)+ZOOM(80)>=CGRectGetHeight(self.backgroundScrollView.frame)?CGSizeMake(0, CGRectGetMaxY(okBtn.frame)+ZOOM(80)):CGSizeMake(0, CGRectGetHeight(self.backgroundScrollView.frame));
    
//    if (CGRectGetMaxY(moneyLab.frame)>CGRectGetHeight(self.backgroundScrollView.frame)) {
//        self.backgroundScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(moneyLab.frame));
//    } else {
//        
//        self.backgroundScrollView.contentSize = CGSizeMake(0, CGRectGetHeight(self.backgroundScrollView.frame));
//    }
    
}

- (void)getCodeClick:(UIButton *)sender
{
    LogFunc;
}

- (void)btnClick:(UIButton *)sender
{
    LogFunc;
    [self.view endEditing:YES];
    
    [self showView];
}

- (void)okBtnClick:(UIButton *)sender
{
    LogFunc;
    
    if ([self.moneyNumberField.text isEqualToString:@"0"]) {
        [MBProgressHUD showError:@"总金额不能为0"];
        return;
    }
    
    BOOL redCountBl = [self isString:self.numberField.text toCompString:@"0123456789"];
    
    if (redCountBl == YES) {
        if ([self.numberField.text hasPrefix:@"0"]) {
            [MBProgressHUD showError:@"请正确输入红包个数"];
            return;
        } else if ([self.numberField.text intValue]>50) {
            [MBProgressHUD showError:@"最大红包数为50"];
            return;
        }
    } else {
        [MBProgressHUD showError:@"请正确输入红包个数"];
        return;
    }
    
    BOOL moneyCountBl = [self isString:self.moneyNumberField.text toCompString:@".1234567890"];
    if (moneyCountBl == YES) {
        if ([self.moneyNumberField.text hasPrefix:@"."]||[self.moneyNumberField.text hasSuffix:@"."]) {
            [MBProgressHUD showError:@"请正确输入金额"];
            return;
        } else if ([self.moneyNumberField.text intValue]>1000) {
            [MBProgressHUD showError:@"最大红包金额为1000"];
            return;
        }
    } else {
        [MBProgressHUD showError:@"请正确输入金额"];
        return;
    }
    
    BOOL voiceTextViewBl = !self.voiceTextView.text.length == 0;
    if (voiceTextViewBl == NO) {
        [MBProgressHUD showError:@"请输入语音文字"];
        return;
    }
    
    //text: %@", self.voiceTextView.text);

    
    if ([TFPublicClass stringContainsEmoji:self.voiceTextView.text]) { /**< Emoji表情 */
        [MBProgressHUD showError:@"不能输入Emoji表情"];
        return;
    }
    
//    if (![TFPublicClass judgeChineseString:self.voiceTextView.text]) { /**< 除了Emoji之外 */
//        [MBProgressHUD showError:@"请输入汉字"];
//        return;
//    }
    
    if (self.voiceTextView.text.length <5||self.voiceTextView.text.length>100) {
        [MBProgressHUD showError:@"请输入5-100个汉字"];
        return;
    }
    
    double singleMoney = 0;
    
    if ([self.numberField.text doubleValue]!=0 && [self.moneyNumberField.text doubleValue]!=0) {
        
        singleMoney = [self.moneyNumberField.text doubleValue]/[self.numberField.text doubleValue];
        
    }
    if (singleMoney>200) {
        [MBProgressHUD showError:@"单个红包金额不能大于200元"];
        return;
    } else if (singleMoney<0.01) {
        [MBProgressHUD showError:@"单个红包金额不能小于0.01元"];
        return;
    }
    
    //支付
    //支付");
    self.redPrice = [NSString stringWithFormat:@"%f",[self.moneyNumberField.text doubleValue]];
    
    [self httpGetRedCode];
    
}

- (void)httpGetRedCode
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    //匹配度
    NSString *st = [NSString stringWithFormat:@"%f",[[self.setBtn.titleLabel.text substringToIndex:self.setBtn.titleLabel.text.length-1] doubleValue]/100.0f];
    
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@redPacket/sendRedPacket?token=%@&uid=%@&difficulty=%@&content=%@&amount=%@&count=%@&version=%@", [NSObject baseURLStr], token, self.unionid,st, self.voiceTextView.text,self.moneyNumberField.text,self.numberField.text, VERSION];
    
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        //发红包 = %@", responseObject);
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {

                self.redCode = [NSString stringWithFormat:@"%@", responseObject[@"rp_id"]];
                
                TFPayStyleViewController *pVC = [[TFPayStyleViewController alloc] init];
                pVC.fromType = @"我要发红包";
                pVC.price = self.redPrice.doubleValue;
                pVC.order_code = self.redCode;
                pVC.unionid = self.unionid;
                [self.navigationController pushViewController:pVC animated:YES];

                
            } else {
                NavgationbarView *nv = [[NavgationbarView alloc] init];
                [nv showLable:responseObject[@"message"] Controller:self];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
    }];
}
- (void)tapClick:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

#pragma mark - textField
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.moneyNumberField) {
        self.moneyLab.text = [NSString stringWithFormat:@"¥%@",textField.text];
    }
    
    [self judgeOkBtn];
}

#pragma mark - TextView Delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self.promptLabel setHidden:YES];
    
    if (kDevice_Is_iPhone4) {
        [self.backgroundScrollView setContentOffset:CGPointMake(0, 150) animated:YES];
    } else if (kDevice_Is_iPhone5) {
        [self.backgroundScrollView setContentOffset:CGPointMake(0, 60) animated:YES];
    }
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text length] == 0) {
        [self.promptLabel setHidden:NO];
    } else{
        [self.promptLabel setHidden:YES];
    }
    
    [self judgeOkBtn];
}

- (void) textViewDidChange:(UITextView *)textView{
    if ([textView.text length] == 0) {
        [self.promptLabel setHidden:NO];
    } else{
        [self.promptLabel setHidden:YES];
    }

    [self judgeOkBtn];
}

- (void)judgeOkBtn
{
    if ([self.numberField.text isEqualToString:@"0"]) {
        self.okBtn.selected = YES;
        return;
    }
    if ([self.moneyNumberField.text isEqualToString:@"0"]) {
        self.okBtn.selected = YES;
        return;
    }
    if (self.voiceTextView.text.length == 0) {
        self.okBtn.selected = YES;
        return;
    }
    self.okBtn.userInteractionEnabled = YES;
    self.okBtn.selected = NO;
}

- (UIScrollView *)backgroundScrollView
{
    if (_backgroundScrollView == nil) {
        _backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7)];
        _backgroundScrollView.backgroundColor = [UIColor colorWithRed:254/255.0 green:249/255.0 blue:244/255.0 alpha:1];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [_backgroundScrollView addGestureRecognizer:tapGR];
    }
    return _backgroundScrollView;
}

- (void)showView
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [window addSubview:_backgroundView = backgroundView];
    
//    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTapGR:)];
//    [backgroundView addGestureRecognizer:tapGR];
    
    self.backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundView.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
    } completion:^(BOOL finish) {
        
    }];
    
    [self.backgroundView addSubview:self.tableView];
    
    self.tableView.transform = CGAffineTransformMakeScale(0.25, 0.25);
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
    }];

}
#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSourceArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ZOOM(150);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    NSString *st = self.dataSourceArray[indexPath.row];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if ([st isEqualToString:[self.setBtn.titleLabel.text substringToIndex:self.setBtn.titleLabel.text.length-1]]) {
        cell.backgroundColor = [UIColor colorWithRed:207/255.0 green:228/255.0 blue:250/255.0 alpha:1];
        self.indexPathFlag = indexPath;
    }
    
    cell.textLabel.text = self.dataSourceArray[indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *st = self.dataSourceArray[indexPath.row];
    NSString *stt = @"%";
    
    [self.setBtn setTitle:[NSString stringWithFormat:@"%@%@",st,stt]forState:UIControlStateNormal];
//    [self.backgroundView removeFromSuperview];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:self.indexPathFlag];
    cell.backgroundColor = [UIColor whiteColor];
    
    [self.tableView reloadData];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finish) {
        [self.backgroundView removeFromSuperview];

    }];

}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        
        CGFloat M_lr = ZOOM(150);
        CGFloat M_ud = ZOOM(240);
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(M_lr, M_ud, kScreenWidth-2*M_lr, kScreenHeight-2*M_ud)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (void)backgroundViewTapGR:(UITapGestureRecognizer *)sender
{
//    [self.backgroundView removeFromSuperview];
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finish) {
        [self.backgroundView removeFromSuperview];
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (NSMutableArray *)dataSourceArray
{
    if (_dataSourceArray == nil) {
        _dataSourceArray = [NSMutableArray array];
        
        for (int i= 1; i<=10; i++) {
            NSString *st = [NSString stringWithFormat:@"%d", i*10];
            [_dataSourceArray addObject:st];
        }
        
    }
    
    return _dataSourceArray;
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
