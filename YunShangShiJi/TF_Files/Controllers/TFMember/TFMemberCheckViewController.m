//
//  TFMemberCheckViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 16/2/26.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFMemberCheckViewController.h"
#import "TFMemberShopStoreViewController.h"

@interface TFMemberCheckViewController ()



@end

@implementation TFMemberCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItemLeft:@"会员验证"];
    
    [self createUI];
}

- (void)createUI
{
    NSArray *ploArr = [NSArray arrayWithObjects:@"至尊会员卡号", @"密码", nil];
    
    CGFloat M_ud = ZOOM(320);
    
    CGFloat M_lr = ZOOM(120);
    CGFloat H_textField = ZOOM(100);
    
    CGFloat M_ud_textField = ZOOM(33);
    
    for (int i = 0; i<ploArr.count; i++) {
        CGFloat W = kScreenWidth-2*M_lr;
        CGFloat X = M_lr;
        CGFloat Y = M_ud+i*H_textField+i*M_ud_textField;
        
        
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(X, Y, W, H_textField)];
        tf.borderStyle = UITextBorderStyleNone;
        tf.placeholder = ploArr[i];
        
        
        [tf setValue:[UIFont boldSystemFontOfSize:ZOOM(45)] forKeyPath:@"_placeholderLabel.font"];
//        tf.textColor = RGBCOLOR_I(220,220,220);
        
        tf.font = [UIFont systemFontOfSize:ZOOM(50)];
        
        if (i == ploArr.count-1) {
            tf.secureTextEntry = YES;
        }
        
        tf.tag = 200+i;
        
        [self.view addSubview:tf];
        
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(X, Y+H_textField+1, W, 2)];
        lineView.backgroundColor = RGBCOLOR_I(220,220,220);
        [self.view addSubview:lineView];
        
    }
    
    UITextField *tf = (UITextField *)[self.view viewWithTag:200+1];
    
    CGFloat H_btn = ZOOM(130);
    CGFloat M_ud_btn = ZOOM(180);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(M_lr, CGRectGetMaxY(tf.frame)+M_ud_btn, CGRectGetWidth(tf.frame), H_btn);
    
    btn.titleLabel.textColor = [UIColor whiteColor];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    
//    [btn setBackgroundColor:[UIColor blackColor]];
    
    [btn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框高亮"] forState:UIControlStateHighlighted];
    
    [self.view addSubview:btn];
}

- (void)submitBtnClick
{
    UITextField *tf1 = (UITextField *)[self.view viewWithTag:200];
    UITextField *tf2 = (UITextField *)[self.view viewWithTag:201];
    
    NSString *card_no = tf1.text;
    NSString *password = tf2.text;
    
    if (card_no == nil) {
        [MBProgressHUD showError:@"卡号不能为空"];
        return;
    }
    if (password == nil) {
        [MBProgressHUD showError:@"密码不能为空"];
        return;
    }
    
    [self httpCommitInfomation];
    
}

- (void)httpCommitInfomation
{
    
    UITextField *tf1 = (UITextField *)[self.view viewWithTag:200];
    UITextField *tf2 = (UITextField *)[self.view viewWithTag:201];
    
    NSString *card_no = tf1.text;
    NSString *password = tf2.text;
    
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@vip/submitting?version=%@&token=%@&card_no=%@&password=%@",[NSObject baseURLStr], VERSION, token, card_no, password];
    
    NSString *URL=[MyMD5 authkey:urlStr];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        NSString *status=responseObject[@"status"];
        
        //会员验证: %@",responseObject);
        
        if(status.intValue == 1) {
            
            NSString *is_member = [NSString stringWithFormat:@"%@", responseObject[@"is_member"]];
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:is_member forKey:USER_MEMBER];
            [MyMD5 changeMemberPriceRate];
            [MBProgressHUD showSuccess:@"会员验证成功,快去购买商品吧"];
            
            [self performSelector:@selector(gotoTheMemberShops) withObject:nil afterDelay:1];
            
        } else {
            [MBProgressHUD showError:responseObject[@"message"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];


}

- (void)gotoTheMemberShops
{
    TFMemberShopStoreViewController *tssVC = [[TFMemberShopStoreViewController alloc] init];
    [self.navigationController pushViewController:tssVC animated:YES];
    
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
