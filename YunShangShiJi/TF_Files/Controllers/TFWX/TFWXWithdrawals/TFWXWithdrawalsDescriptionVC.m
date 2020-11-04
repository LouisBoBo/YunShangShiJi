
//
//  TFWXWithdrawalsDescriptionVC.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/10/13.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFWXWithdrawalsDescriptionVC.h"
#import "TFWXWithdrawalsCheckVC.h"
#import "TFWithdrawCashViewController.h"


#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/ISSQZoneApp.h>
#import "WXApi.h"
#import "AppDelegate.h"
#import "YiFuUserInfoManager.h"
@interface TFWXWithdrawalsDescriptionVC () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *idefTextField;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation TFWXWithdrawalsDescriptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItemLeft:@"微信提现说明"];
    
    [self setData];
    
//    [self setupUI:];
}

- (void)setData
{
    [self httpData];
}
- (void)httpData
{
    if (self.isIdenf) {
        [self setupUIwithNameAndIdenf];
    } else {
        [self setupUIwithName];
    }
}

- (void)setupUIwithName
{
    self.view.backgroundColor = RGBCOLOR_I(243, 243, 243);
    
    UIView *backgroundV = [UIView new];
    backgroundV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundV];
    
    CGFloat padding = ZOOM6(30);
    
    [backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(Height_NavBar+ZOOM6(10));
        make.left.right.equalTo(self.view);
    }];
    
    UILabel *lab1 = [[UILabel alloc] init];
    lab1.textColor = COLOR_ROSERED;
    lab1.text = @"*";
    //    lab1.textAlignment = NSTextAlignmentCenter;
    lab1.font = [UIFont systemFontOfSize:ZOOM6(30)];
    [backgroundV addSubview:lab1];
    
    NSString *text = @"微信规定提现必须核实微信用户名，为了保证提现成功，所以每次微信提现都需要对姓名和微信进行同时验证，请输入微信用户姓名，点击“微信验证”完成提现喔～";
    UILabel *textLab = [UILabel new];
    textLab.textColor = RGBA(168, 168, 168, 1);
    //    desLabel.attributedText = attString;
    textLab.attributedText = [NSString attributedSourceString:text targetString:@"对姓名和微信进行同时验证" addAttributes:@{NSForegroundColorAttributeName: COLOR_ROSERED}];
    textLab.numberOfLines = 0;
    textLab.font = [UIFont systemFontOfSize:ZOOM6(30)];
    [backgroundV addSubview:textLab];
    textLab.preferredMaxLayoutWidth = kScreen_Width-2*padding;
    [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundV.mas_top).offset(ZOOM6(50));
        make.left.equalTo(backgroundV.mas_left).offset(padding);
        make.right.equalTo(backgroundV.mas_right).offset(-padding);
    }];
    
    [backgroundV addSubview:self.nameTextField];
    /**< 布局 */
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textLab.mas_bottom).offset(ZOOM6(30));
        make.right.equalTo(backgroundV.mas_right).offset(-padding);
        make.height.mas_equalTo(ZOOM6(100));
        make.left.equalTo(lab1.mas_right);
        make.bottom.equalTo(backgroundV.mas_bottom).offset(-ZOOM6(50));
    }];
    
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundV).offset(padding);
        make.centerY.equalTo(self.nameTextField.mas_centerY);
        make.width.mas_equalTo(ZOOM6(40));
    }];
    
    [self.view addSubview:self.nextBtn];
    [self.nextBtn setTitle:@"微信验证" forState:UIControlStateNormal];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(padding);
        make.right.equalTo(self.view.mas_right).offset(-padding);
        make.top.equalTo(backgroundV.mas_bottom).offset(ZOOM6(70));
        make.height.mas_equalTo(ZOOM6(100));
    }];

}

- (void)setupUIwithNameAndIdenf
{
    self.view.backgroundColor = RGBCOLOR_I(243, 243, 243);
    
    UIView *backgroundV = [UIView new];
    backgroundV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundV];
    
    CGFloat padding = ZOOM6(30);
    
    [backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(Height_NavBar+ZOOM6(10));
        make.left.right.equalTo(self.view);
    }];
    
    
    [backgroundV addSubview:self.nameTextField];
    
    [backgroundV addSubview:self.idefTextField];
    
    UILabel *lab1 = [[UILabel alloc] init];
    lab1.textColor = COLOR_ROSERED;
    lab1.text = @"*";
//    lab1.textAlignment = NSTextAlignmentCenter;
    lab1.font = [UIFont systemFontOfSize:ZOOM6(30)];
    [backgroundV addSubview:lab1];
    
    UILabel *lab2 = [[UILabel alloc] init];
    lab2.textColor = COLOR_ROSERED;
    lab2.text = @"*";
//    lab2.textAlignment = NSTextAlignmentCenter;
    lab2.font = [UIFont systemFontOfSize:ZOOM6(30)];
    [backgroundV addSubview:lab2];
    
    UIView *lineV = [[UIView alloc] init];
    lineV.backgroundColor = RGBCOLOR_I(240, 240, 240);
    [backgroundV addSubview:lineV];
    
//    NSString *text = @"为了你的账户信息安全，身份证号必须正确填写，平台将用于微信绑定银行卡信息进行验证，错误信息将会导致提现失败，身份证信息进行严格的加密处理，仅用于微信验证";
     NSString *text = @"请填写你的真实姓名验证微信或银行卡提现账号";
    
    UILabel *desLabel = [[UILabel alloc] init];
    desLabel.textColor = RGBA(168, 168, 168, 1);
//    desLabel.attributedText = attString;
    desLabel.attributedText = [NSString attributedSourceString:text targetString:@"身份证号必须正确填写" addAttributes:@{NSForegroundColorAttributeName: COLOR_ROSERED}];
    desLabel.numberOfLines = 0;
    desLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    [backgroundV addSubview:desLabel];
    
    /**< 布局 */
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundV).offset(ZOOM6(45));
        make.right.equalTo(backgroundV.mas_right).offset(-padding);
        make.height.mas_equalTo(ZOOM6(100));
        make.left.equalTo(lab1.mas_right);
    }];
    
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundV).offset(padding);
        make.centerY.equalTo(self.nameTextField.mas_centerY);
        make.width.mas_equalTo(ZOOM6(40));
    }];
    
    [self.idefTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameTextField.mas_bottom).offset(padding);
        make.right.equalTo(backgroundV.mas_right).offset(-padding);
        make.height.mas_equalTo(ZOOM6(0));
        make.left.equalTo(lab2.mas_right);
    }];
    
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab1.mas_left);
        make.centerY.equalTo(self.idefTextField.mas_centerY);
        make.width.mas_equalTo(ZOOM6(0));
    }];
    
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.idefTextField.mas_bottom).offset(padding);
        make.left.right.equalTo(backgroundV);
        make.height.mas_equalTo(1);
    }];
    
    desLabel.preferredMaxLayoutWidth = kScreen_Width-2*padding;
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineV.mas_bottom).offset(padding);
        make.bottom.equalTo(backgroundV.mas_bottom).offset(-padding);
        make.left.equalTo(backgroundV.mas_left).offset(padding);
        make.right.equalTo(backgroundV.mas_right).offset(-padding);
    }];
    
    [self.view addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(padding);
        make.right.equalTo(self.view.mas_right).offset(-padding);
        make.top.equalTo(backgroundV.mas_bottom).offset(ZOOM6(40));
        make.height.mas_equalTo(ZOOM6(100));
    }];
}

- (void)nextBtnClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    NSString *nameText = self.nameTextField.text;
    NSString *idefText = self.idefTextField.text;
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    if (!nameText.length) {
        [nv showLable:@"请输入姓名" Controller:self];
        return;
    }
    
    if ([nameText containsEmoji]) {
        [nv showLable:@"不能输入Emoji表情" Controller:self];
        return;
    }
    if (self.isIdenf) { // 下一页验证
//        if (!idefText.length) {
//            [nv showLable:@"请输入身份证号" Controller:self];
//            return;
//        }
//        if (![idefText isIdCard]) {
//            [nv showLable:@"请正确输入身份证号" Controller:self];
//            return;
//        }
//        if ([idefText containsEmoji]) {
//            [nv showLable:@"不能输入Emoji表情" Controller:self];
//            return;
//        }

//        [self saveUserIdenfToDBWithUserIdenf:idefText];
        
        TFWXWithdrawalsCheckVC *vc = [[TFWXWithdrawalsCheckVC alloc] init];
        vc.money = self.money;
        vc.nameText = nameText;
        vc.idenfText = idefText;
        [self.navigationController pushViewController:vc animated:YES];
    } else { // 验证
        
        [self shareSdkWithAutohorWithTypeGetOpenID];
    }
}

#pragma mark - 保存身份证信息
- (void)saveUserIdenfToDBWithUserIdenf:(NSString *)idenf
{
    YiFuUserInfo *user = [[YiFuUserInfo alloc] init];
    user.userId = [NSNumber numberWithInteger:[[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID] integerValue]];
    user.userIdenf = idenf;
    [YiFuUserInfoManager insertUserInfo:user];
}


- (void)httpCheckData:(NSString *)WXUid
{
    NSDictionary *parameter = @{@"money": [NSString stringWithFormat:@"%f", self.money],
                          
                          @"collect_name": self.nameTextField.text,
                          @"collect_bank_code": WXUid,
                          @"message": @"微信提现"};
    
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    NSArray *messageArray = @[
                              @"提现申请成功",
                              @"支行为空",
                              @"市id为空",
                              @"省id为空",
                              @"b类用户申请提现的金额不足,非抽奖和回佣的金额",
                              @"提现金额不能大于最高提现金额或者小于最低提现金额",
                              @"未找到该银行卡"];
    
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_wallet_wxDepositAdd parameter:parameter caches:NO cachesTimeInterval:0*TFMinute token:YES success:^(id data, Response *response) {
        MyLog(@"data: %@", data);
        
        if (response.status == 1) {
            NSString *flagString = [NSString stringWithFormat:@"%@", data[@"flag"]];
            if ([flagString length]) {
                int flag = [data[@"flag"] intValue];
                if (flag != 0 && flag <= messageArray.count-1) {
                    
                    if (flag != 4 && flag != 5) {
                        [nv showLable:messageArray[flag] Controller:self];
                    } else {
                        [self popToWithDrawalsViewControllerMoney:[data[@"money"] doubleValue] checkPopType:WXCheckPopTypeFailure];
                    }
                    
                } else if (flag == 0) {
                    
                    double money = [data[@"money"] doubleValue];
                    WXCheckPopType type;
                    if (self.money == money) {
                        type = WXCheckPopTypeSuccess;
                    } else if (self.money - money>0) {
                        type = WXCheckPopTypeSuccessFailure;
                    }
                    
                    [self popToWithDrawalsViewControllerMoney:[data[@"money"] doubleValue] checkPopType:type];
                }
            }
        } else {
            [nv showLable:data[@"message"] Controller:self];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)popToWithDrawalsViewControllerMoney:(double)wxMoney checkPopType:(WXCheckPopType)popType
{
    for (UIViewController *viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[TFWithdrawCashViewController class]]) {
            TFWithdrawCashViewController *vc = (TFWithdrawCashViewController *)viewController;
            vc.WXwithDrawMoney = wxMoney;
            vc.wxCheckPopType = popType;
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString *oldText = textField.text;
    NSString *currInputText = [NSString stringWithFormat:@"%@%@", textField.text, string];
//    MyLog(@"oldText:%@ currInputText: %@ <%@>", oldText, currInputText, NSStringFromRange(range));
    if (textField == self.nameTextField) {


//        if (self.isIdenf) {
//            if (currInputText.length>0 && self.idefTextField.text.length) { // 输入
//                self.nextBtn.userInteractionEnabled = YES;
//                self.nextBtn.selected = NO;
//            }
//
//        } else {
//            if (currInputText.length>0) { // 输入
//                self.nextBtn.userInteractionEnabled = YES;
//                self.nextBtn.selected = NO; // 红色
//            }
//        }
        
        if (currInputText.length>0) { // 输入
            self.nextBtn.userInteractionEnabled = YES;
            self.nextBtn.selected = NO; // 红色
        }
    }
    
//    if (textField == self.idefTextField) {
//        if (currInputText.length>0 && self.nameTextField.text.length) { // 输入
//            self.nextBtn.userInteractionEnabled = YES;
//            self.nextBtn.selected = NO;
//        }
//
//    }
    
//    if ((currInputText.length == oldText.length && range.location == 0)) { // 删除
//        self.nextBtn.userInteractionEnabled = NO;
//        self.nextBtn.selected = YES; // 灰色
//    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    
//    if (self.isIdenf) {
//        if (textField == self.nameTextField || textField == self.idefTextField) {
//            self.nextBtn.userInteractionEnabled = NO;
//            self.nextBtn.selected = YES;
//        }
//    } else {
//        if (textField == self.nameTextField) {
//            self.nextBtn.userInteractionEnabled = NO;
//            self.nextBtn.selected = YES;
//        }
//    }

    return YES;
}

- (UITextField *)nameTextField
{
    if (!_nameTextField) {
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, ZOOM6(100))];
        
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.borderStyle = UITextBorderStyleNone;
        _nameTextField.font = [UIFont systemFontOfSize:ZOOM6(30)];
        _nameTextField.delegate = self;
        _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameTextField.layer.borderWidth = 1;
        _nameTextField.layer.borderColor = [RGBCOLOR_I(240, 240, 240) CGColor];
        _nameTextField.layer.masksToBounds = YES;
        _nameTextField.layer.cornerRadius = ZOOM6(8);
        _nameTextField.placeholder = @"姓名";
        _nameTextField.leftView = paddingView;
        _nameTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _nameTextField;
}

- (UITextField *)idefTextField
{
    if (!_idefTextField) {
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, ZOOM6(100))];
        _idefTextField = [[UITextField alloc] init];
        _idefTextField.borderStyle = UITextBorderStyleNone;
        _idefTextField.font = [UIFont systemFontOfSize:ZOOM6(30)];
        _idefTextField.delegate = self;
        _idefTextField.layer.borderWidth = 1;
        _idefTextField.layer.borderColor = [RGBCOLOR_I(240, 240, 240) CGColor];
        _idefTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _idefTextField.layer.masksToBounds = YES;
        _idefTextField.layer.cornerRadius = ZOOM6(8);
        _idefTextField.placeholder = @"身份证";
        _idefTextField.leftView = paddingView;
        _idefTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _idefTextField;
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)shareSdkWithAutohorWithTypeGetOpenID
{
    
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
                               if (result) {
                                   
                                       NSString *nickName = [NSString stringWithFormat:@"%@",[userInfo nickname]];
                                       NSString *headImgUrl = [NSString stringWithFormat:@"%@", [userInfo profileImage]];
                                       
                                       NSString *WXuid = [userInfo uid];
                                       
                                       NSString *unionid = [NSString stringWithFormat:@"%@",[userInfo sourceData][@"unionid"]];
                                   
                                   if (WXuid.length) {
                                       [self httpCheckData:WXuid];
                                   } else {
                                       NavgationbarView *nv = [[NavgationbarView alloc] init];
                                       [nv showLable:@"请允许获取您的公开信息，再重新尝试" Controller:self];
                                   }
                                   
                                   
                               }
                               
                               NSString *errorStr = [NSString stringWithFormat:@"%@", [error errorDescription]];
                               if ([errorStr isEqualToString:@"尚未授权"]) {
                                   
                                   //失败,错误码:%ld,错误描述%@",(long)[error errorCode],[error errorDescription]);
                                   
                               }
                               
                           }];
    
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
