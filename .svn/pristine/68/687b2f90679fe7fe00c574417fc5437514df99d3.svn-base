//
//  referenceViewController.m
//  YunShangShiJi
//
//  Created by yssj on 15/10/13.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "referenceViewController.h"
#import "SubmitViewController.h"
#import "NavgationbarView.h"

#import "TFHomeViewController.h"


#import "ShopStoreViewController.h"
#import "MymineViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

@interface referenceViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)UITextField *inputField;
@property (nonatomic, strong)UILabel *titleLabel;

@end

@implementation referenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super setNavigationItemLeft:@"推荐人"];
    self.navigationController.interactivePopGestureRecognizer.enabled=YES;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [self.view addGestureRecognizer:tap];
    
    [self createUI];
}
-(void)tapClick
{
    [self.view endEditing:YES];
}
- (void)createUI
{
    CGFloat ud_Margin = ZOOM(50);
    CGFloat lr_Margin = ZOOM(62);
    
    
    CGFloat textField_H = ZOOM(114);
    
    self.inputField = [[UITextField alloc] initWithFrame:CGRectMake(lr_Margin, 64+ self.titleLabel.bottom+ud_Margin, kScreenWidth-2*lr_Margin, textField_H)];
    self.inputField.font = [UIFont systemFontOfSize:ZOOM(48)];
    self.inputField.placeholder = @" 请填写推荐人信息...";
    self.inputField.borderStyle = UITextBorderStyleRoundedRect;
    self.inputField.keyboardType=UIKeyboardTypeNumberPad;
    self.inputField.delegate = self;
    [self.view addSubview:self.inputField];
    
    
    CGFloat btn_H = ZOOM(120);
    CGFloat ud_Margin1 = ZOOM(250);
    

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(lr_Margin, self.inputField.frame.origin.y+self.inputField.frame.size.height+ud_Margin1, self.inputField.frame.size.width, btn_H);
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框高亮"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    /**************  跳过此选项  *************/
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextBtn.frame=CGRectMake(kApplicationWidth-ZOOM(300)-ZOOM(62), kApplicationHeight-30,ZOOM(300), 30);
    [nextBtn setTintColor:tarbarrossred];
    [nextBtn setTitle:@"跳过此选项 >" forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
    [nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    
}
-(void)nextBtnClick:(UIButton *)sender
{
    [self toSubmitView];
}
#pragma mark - 下一步
- (void)btnClick:(UIButton *)sender
{
    [self httpRefrence];
}
/*****************   推荐人  ****************/
-(void)httpRefrence
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString*token=[user objectForKey:FAIL_TOKEN];
    NSString *url=[NSString stringWithFormat:@"%@/user/setReferee?version=%@&token=%@&parent_id=%@",[NSObject baseURLStr],VERSION,token,_inputField.text];
    NSString *URL=[MyMD5 authkey:url];

    [[Animation shareAnimation]createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[ Animation shareAnimation]stopAnimationAt:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *message=responseObject[@"message"];
            NSString *str=responseObject[@"status"];
            
            if (str.intValue==101) {
                
                //            [self toSubmitView];
                [self rootviewcontroller];
                
            }else if(str.intValue == 10030){//没登录状态
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                
                LoginViewController *login=[[LoginViewController alloc]init];
                
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }

            else{
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
            }

        }
        
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [[Animation shareAnimation]stopAnimationAt:self.view];
        

        
    }];
}
#pragma mark 修改rootviewcontroller
-(void)rootviewcontroller
{
    Mtarbar.selectedIndex=1;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
/****************   跳转喜好标签  *****************/
-(void)toSubmitView
{
    SubmitViewController *submit=[[SubmitViewController alloc]init];
    
    submit.array=[NSArray arrayWithArray:_array];
    submit.nameArray=[NSArray arrayWithArray:_nameArray];
    [self.navigationController pushViewController:submit animated:YES];
}


- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string  // return NO to not change text
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (toBeString.length > 9 && range.length!=1){
        textField.text = [toBeString substringToIndex:9];
        return NO;
        
    }
    return YES;
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
