//
//  UserIDCardVC.m
//  YunShangShiJi
//
//  Created by yssj on 16/8/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "UserIDCardVC.h"

@interface UserIDCardVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *backgroundScrollView;
@property (nonatomic, strong) UITextField *UserMoneyCard;
@property (nonatomic, strong) UITextField *UserName;
@property (nonatomic, strong) UITextField *UserIDNum;
@property (nonatomic, strong) UITextField *UserPhone;
@property (nonatomic, strong) UITextField *UserAddress;
@property(nonatomic,strong)UITextField *message;

@end

@implementation UserIDCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];

    [super setNavigationItemLeft:@"身份验证"];
    
}

- (void)createUI
{
    //使用 通知  监听键盘出现
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //监听键盘消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    CGFloat Margin_lr = ZOOM(62);
    CGFloat H_textField = ZOOM(112);
    CGFloat Margin_ud = ZOOM(45);
    
    _backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7)];
    [self.view addSubview:_backgroundScrollView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.view addGestureRecognizer:tap];
    
    CGFloat leftSpace=0; CGFloat leftViewWidth=ZOOM(350);
    NSArray *textArr=@[@" 卡号",@" 持卡人",@" 身份证",@" 手机号",@" 收款人省／市"];
    NSArray *placeholderArr=@[@"输入银行卡号",@"银行卡户名",@"持卡人对应身份证号",@"银行预留手机号",@"收款人省／市"];
    _UserMoneyCard=[[UITextField alloc]init];
    _UserMoneyCard.borderStyle=UITextBorderStyleRoundedRect;
    _UserMoneyCard.font=[UIFont systemFontOfSize:ZOOM(48)];
    _UserMoneyCard.delegate=self;
    _UserMoneyCard.returnKeyType = UIReturnKeyNext;
    _UserMoneyCard.placeholder=placeholderArr[0];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(leftSpace, 0, leftViewWidth, H_textField)];
    label1.text=textArr[0];
    label1.font=[UIFont systemFontOfSize:ZOOM(48)];
    _UserMoneyCard.leftView=label1;
    _UserMoneyCard.leftViewMode = UITextFieldViewModeAlways;
    [_backgroundScrollView addSubview:_UserMoneyCard];
    
    _UserName=[[UITextField alloc]init];
    _UserName.borderStyle=UITextBorderStyleRoundedRect;
    _UserName.font=[UIFont systemFontOfSize:ZOOM(48)];
    _UserName.delegate=self;
    _UserName.returnKeyType = UIReturnKeyNext;
    _UserName.placeholder=placeholderArr[1];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(leftSpace, 0, leftViewWidth, H_textField)];
    label2.text=textArr[1];
    label2.font=[UIFont systemFontOfSize:ZOOM(48)];
    _UserName.leftView=label2;
    _UserName.leftViewMode = UITextFieldViewModeAlways;
    [_backgroundScrollView addSubview:_UserName];
    
    _UserIDNum=[[UITextField alloc]init];
    _UserIDNum.borderStyle=UITextBorderStyleRoundedRect;
    _UserIDNum.font=[UIFont systemFontOfSize:ZOOM(48)];
    _UserIDNum.delegate=self;
    _UserIDNum.returnKeyType = UIReturnKeyNext;
    _UserIDNum.placeholder=placeholderArr[2];
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(leftSpace, 0, leftViewWidth, H_textField)];
    label3.text=textArr[2];
    _UserIDNum.leftView=label3;
    label3.font=[UIFont systemFontOfSize:ZOOM(48)];
    _UserIDNum.leftViewMode = UITextFieldViewModeAlways;
    [_backgroundScrollView addSubview:_UserIDNum];
    
    UILabel *remind=[[UILabel alloc]init];
    remind.font=[UIFont systemFontOfSize:ZOOM(48)];
    [remind setAttributedText:[NSMutableString getOneColorInLabel:@"为了您的账户信息安全，身份证号必须正确填写，平台将与银行预留信息进行比对，错误将直接导致提现失败，身份信息严格加密处理，仅用于银行验证" ColorString:@"身份证号必须正确填写" Color:tarbarrossred fontSize:ZOOM(48) ]];
    remind.numberOfLines=0;
    [_backgroundScrollView addSubview:remind];
    
    _UserPhone=[[UITextField alloc]init];
    _UserPhone.borderStyle=UITextBorderStyleRoundedRect;
    _UserPhone.font=[UIFont systemFontOfSize:ZOOM(48)];
    _UserPhone.delegate=self;
    _UserPhone.returnKeyType = UIReturnKeyNext;
    _UserPhone.placeholder=placeholderArr[3];
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(leftSpace, 0, leftViewWidth, H_textField)];
    label4.text=textArr[3];
    label4.font=[UIFont systemFontOfSize:ZOOM(48)];
    _UserPhone.leftView=label4;
    _UserPhone.leftViewMode = UITextFieldViewModeAlways;
    [_backgroundScrollView addSubview:_UserPhone];
    
    _UserAddress=[[UITextField alloc]init];
    _UserAddress.borderStyle=UITextBorderStyleRoundedRect;
    _UserAddress.font=[UIFont systemFontOfSize:ZOOM(48)];
    _UserAddress.delegate=self;
    _UserAddress.returnKeyType = UIReturnKeyNext;
    _UserAddress.placeholder=placeholderArr[4];
    UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake(leftSpace, 0, leftViewWidth, H_textField)];
    label5.text=textArr[4];
    label5.font=[UIFont systemFontOfSize:ZOOM(48)];
    _UserAddress.leftView=label5;
    _UserAddress.leftViewMode = UITextFieldViewModeAlways;
    [_backgroundScrollView addSubview:_UserAddress];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blackColor]];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundScrollView addSubview:btn];
    
    kSelfWeak;
    [_UserMoneyCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(ZOOM(10)));
        make.centerX.equalTo(_backgroundScrollView);
        make.left.equalTo(@(Margin_lr));
        make.right.equalTo(@(-Margin_lr));
        make.height.equalTo(@(H_textField));
    }];
    [_UserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.UserMoneyCard.mas_bottom).offset(ZOOM(10)+Margin_ud);
        make.centerX.equalTo(weakSelf.UserMoneyCard);
        make.width.equalTo(weakSelf.UserMoneyCard);
        make.height.equalTo(weakSelf.UserMoneyCard);
    }];
    [_UserIDNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.UserName.mas_bottom).offset(ZOOM(10)+Margin_ud);
        make.centerX.equalTo(weakSelf.UserMoneyCard);
        make.width.equalTo(weakSelf.UserMoneyCard);
        make.height.equalTo(weakSelf.UserMoneyCard);
    }];
    [remind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.UserIDNum.mas_bottom).offset(ZOOM(10)+Margin_ud);
        make.centerX.equalTo(weakSelf.UserMoneyCard);
        make.width.equalTo(weakSelf.UserMoneyCard);
        make.height.mas_equalTo(@([NSString heightWithString:remind.text font:[UIFont systemFontOfSize:ZOOM(48)] constrainedToWidth:kScreenWidth]));
    }];
    [_UserPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(remind.mas_bottom).offset(ZOOM(10)+Margin_ud);
        make.centerX.equalTo(weakSelf.UserMoneyCard);
        make.width.equalTo(weakSelf.UserMoneyCard);
        make.height.equalTo(weakSelf.UserMoneyCard);
    }];
    [_UserAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.UserPhone.mas_bottom).offset(ZOOM(10)+Margin_ud);
        make.centerX.equalTo(weakSelf.UserMoneyCard);
        make.width.equalTo(weakSelf.UserMoneyCard);
        make.height.equalTo(weakSelf.UserMoneyCard);
    }];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.UserAddress.mas_bottom).offset(ZOOM(10)+Margin_ud);
        make.centerX.equalTo(weakSelf.UserMoneyCard);
        make.width.equalTo(weakSelf.UserMoneyCard);
        make.height.equalTo(weakSelf.UserMoneyCard);
    }];
    
    
}

#pragma mark - UITextField
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.message=textField;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
}

- (void)tapClick:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.8 animations:^{
        self.backgroundScrollView.contentOffset = CGPointMake(0, 0);
    }];
}
-(void)btnClick{
    
}

#pragma mark - keyboard
- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    CGPoint rootViewPoint = [[self.message superview] convertPoint:self.message.frame.origin toView:self.view];
    CGFloat height =rootViewPoint.y -keyboardFrame.origin.y;
    
    if (height>0)
    {
        [UIView animateWithDuration:animationDuration
                         animations:^{
                             _backgroundScrollView.frame=CGRectMake(0,_backgroundScrollView.frame.origin.y-height-kNavigationheightForIOS7, kApplicationWidth, _backgroundScrollView.frame.size.height);
                             
                         }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         _backgroundScrollView.frame=CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7);
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
