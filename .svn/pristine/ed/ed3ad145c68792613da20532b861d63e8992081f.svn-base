//
//  TFWXWithdrawalsCheckVC.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/10/13.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFWXWithdrawalsCheckVC.h"
#import "TFPopBackgroundView.h"
#import "TFWithdrawCashViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/ISSQZoneApp.h>
#import "WXApi.h"
#import "AppDelegate.h"


@interface TFWXWithdrawalsCheckVC () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *nameTextField;

@property (nonatomic, strong) UIButton *nextBtn;
@end

@implementation TFWXWithdrawalsCheckVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItemLeft:@"微信提现说明"];
    
    [self setupUI];
 
//    NSArray *cardIdArray = @[@"511702198807288390",
//                             @"511702198506123795",
//                             @"511702197008231350",
//                             @"511702197004241850",
//                             @"511702199002221492",
//                             @"451025198608159537",
//                             @"451025198905264798",
//                             @"532628198704244638",
//                             @"532628198006157350",
//                             @"45102519760724935X",
//                             
//                             @"511702197409284963",
//                             @"51170219870626850X",
//                             @"511702197506159005",
//                             @"511702198307271621",
//                             @"522635198307222381",
//                             @"522635197707179947",
//                             @"532628197009199228",
//                             @"332621680413871",
//                             @"110105710923582",
//                             @"411525197807172924"];
//    
//    for (int i = 0; i<cardIdArray.count; i++) {
//        NSString *cardId = cardIdArray[i];
//        MyLog(@"isCardId: %d", [cardId isIdCard]);
//    }
    
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1",
                             @"2",
                             @"3",
                             @"4",
                             @"5",
                             @"6",
                             @"7",
                             @"8",
                             @"9",
                             @"10", nil];
    MyLog(@"array: %@", array);
}

- (void)setupUI
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
    
    UIImageView *imageV = [UIImageView new];
    imageV.image = [UIImage imageNamed:@"TFWXWithdrawals_weixintixian_weixin_icon"];
    [backgroundV addSubview:imageV];
    
    UILabel *wxLabel = [UILabel new];
    wxLabel.text = @"微信";
    wxLabel.textAlignment = NSTextAlignmentCenter;
    wxLabel.font = kFont6px(30);
    wxLabel.textColor = RGBCOLOR_I(168, 168, 168);
    [backgroundV addSubview:wxLabel];
    
    UIView *lineV = [[UIView alloc] init];
    lineV.backgroundColor = RGBCOLOR_I(240, 240, 240);
    [backgroundV addSubview:lineV];
    
    NSString *text = @"为了保证每次提现的准确，所以每次微信提现都需要进行微信验证，点击“微信验证”且成功后才能提现喔~";
    UILabel *textLabel = [UILabel new];
//    textLabel.textColor = RGBA(168, 168, 168, 1);
//    textLabel.attributedText = [NSString attributedSourceString:text targetString:@"微信验证" addAttributes:@{NSForegroundColorAttributeName: COLOR_ROSERED}];
    textLabel.textColor = RGBCOLOR_I(62, 62, 62);
    textLabel.text = text;
    textLabel.numberOfLines = 0;
    textLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    [backgroundV addSubview:textLabel];
    
    /**< 布局 */
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundV.mas_top).offset(ZOOM6(50));
        make.centerX.equalTo(backgroundV.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(ZOOM6(160), ZOOM6(160)));
    }];
    
    wxLabel.preferredMaxLayoutWidth = kScreen_Width-2*padding;
    [wxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV.mas_bottom).offset(ZOOM6(20));
        make.left.right.equalTo(backgroundV);
    }];
    
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wxLabel.mas_bottom).offset(ZOOM6(50));
        make.left.right.equalTo(backgroundV);
        make.height.mas_equalTo(1);
    }];
    
    textLabel.preferredMaxLayoutWidth = kScreen_Width-2*padding;
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineV.mas_bottom).offset(padding);
        make.left.equalTo(backgroundV.mas_left).offset(padding);
        make.right.equalTo(backgroundV.mas_right).offset(-padding);
        make.bottom.equalTo(backgroundV.mas_bottom).offset(-padding);
    }];
    
    [self.view addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(padding);
        make.right.equalTo(self.view.mas_right).offset(-padding);
        make.top.equalTo(backgroundV.mas_bottom).offset(ZOOM6(70));
        make.height.mas_equalTo(ZOOM6(100));
    }];

}

- (void)nextBtnClick:(UIButton *)sender
{
    [self shareSdkWithAutohorWithTypeGetOpenID];
    // 验证完成返回提现页面
//    [self popToWithDrawalsViewController];
}

- (void)httpCheckData:(NSString *)WXUid
{
    NSString *uuid = [[NSUserDefaults standardUserDefaults] objectForKey:USER_UUID];
    
    NSDictionary *parameter = @{@"money": [NSString stringWithFormat:@"%f", self.money],
                                
                                @"collect_name": self.nameText,
                                @"identity": self.idenfText,
                                @"collect_bank_code": WXUid,
                                @"message": @"微信提现",
                                @"mac": @"0",
                                @"imei": uuid};
    
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
                    
                    if (flag != 4 && flag != 5) { // 弹提示
                        [nv showLable:messageArray[flag] Controller:self];
                    } else { // 弹失败
                        [self popToWithDrawalsViewControllerMoney:[data[@"money"] doubleValue] checkPopType:WXCheckPopTypeFailure];
                    }
                    
                } else if (flag == 0) { // 提现成功
                    
                    double money = [data[@"money"] doubleValue];
                    WXCheckPopType type;
                    // 根据金额判断全部成功， 还是部分成功
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
    if (textField == self.nameTextField) {
        if (currInputText.length>0) { // 输入
            self.nextBtn.userInteractionEnabled = YES;
            self.nextBtn.selected = NO;
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
    
    if (textField == self.nameTextField) {
        self.nextBtn.userInteractionEnabled = NO;
        self.nextBtn.selected = YES;
    }
    return YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
//    [self popView];
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

- (UIButton *)nextBtn
{
    if (!_nextBtn) {
        _nextBtn = [UIButton new];
        [_nextBtn setTitle:@"微信验证" forState:UIControlStateNormal];
        
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [_nextBtn setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_I(195, 195, 195)] forState:UIControlStateSelected];
        [_nextBtn setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_I(91, 189, 20)] forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.layer.masksToBounds = YES;
        _nextBtn.layer.cornerRadius = ZOOM6(8);
    }
    return _nextBtn;
}


- (void)shareSdkWithAutohorWithTypeGetOpenID
{
    //向微信注册
    //    [WXApi registerApp:@"wx8c5fe3e40669c535" withDescription:@"demo 2.0"];
    
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
