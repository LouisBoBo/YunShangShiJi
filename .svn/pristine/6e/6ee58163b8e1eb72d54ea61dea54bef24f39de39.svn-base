//
//  TFNickNameViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/6/30.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFNickNameViewController.h"

#import "LoginViewController.h"


@interface TFNickNameViewController ()

@end

@implementation TFNickNameViewController
{
    NSString  *_oldname;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super setNavigationItemLeft:@"昵称"];
    
    [self setupUI];
    

}




#pragma mark - 创建UI

- (void)setupUI
{
    
    CGFloat lr_Margin = ZOOM(62);

    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(lr_Margin, kNavigationheightForIOS7+ZOOM(45), kScreenWidth-lr_Margin*2, ZOOM(114))];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    //先从本地读取用户名
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *name=[userdefaul objectForKey:USER_NAME];
    tf.placeholder = name;
    _oldname = [NSString stringWithFormat:@"%@",name];
    tf.tag = 200;
    [self.view addSubview:tf];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(lr_Margin,  tf]+ZOOM(120), tf.bounds.size.width, ZOOM(120));
//    [btn setTitle:@"保存" forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(48)];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框"] forState:UIControlStateNormal];
//    [self.view addSubview:btn];
//    [btn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [self.navigationView addSubview:btn];
    [btn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_ROSERED forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    ESWeak(self, weakSelf);
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.navigationView).offset(10);
        make.right.equalTo(weakSelf.navigationView.mas_right).offset(-5);
        make.size.mas_equalTo(CGSizeMake(80, 44));
    }];
    
    
}

- (void)saveBtnClick
{
    [self.view endEditing:YES];
    
    UITextField *tf = (UITextField *)[self.view viewWithTag:200];
    
     tf.text = [tf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if(tf.text.length == 0)
    {
        [MBProgressHUD showError:@"昵称不能为空"];
        return;
    }else{
        if ([MyMD5 asciiLengthOfString:tf.text]<2||[MyMD5 asciiLengthOfString:tf.text]>8) {
            [MBProgressHUD showError:@"请输入2-8个字符的昵称"];
            return;
        }
//        BOOL result= [self judgeName:tf.text];
//        if(result == NO)
//        {
//            return;
//        }
    }
        
    
    if (tf.text.length!=0) {
        if([tf.text isEqualToString:_oldname])
        {
            NavgationbarView *nv = [[NavgationbarView alloc] init];
            [nv showLable:@"没有修改内容，暂不能提交" Controller:self];
            
            return;
        }
        
        NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
        NSString *token = [userdefaul objectForKey:USER_TOKEN];
        //1.将昵称存到服务器
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString *urlStr = [NSString stringWithFormat:@"%@user/update_userinfo?nickname=%@&version=%@&token=%@",[NSObject baseURLStr],tf.text,VERSION,token];
        
        NSString *URL = [MyMD5 authkey:urlStr];
        //
        [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
            //
            responseObject = [NSDictionary changeType:responseObject];
            if (responseObject!=nil) {
     
                if ([responseObject[@"status"] intValue]==1) {
                 
                    [userdefaul setObject:tf.text forKey:USER_NAME];
                    [userdefaul synchronize];
                    [MBProgressHUD showSuccess:@"修改成功"];
                  
                    
                    NSNotification *noti = [NSNotification notificationWithName:@"changeNickName" object:nil];
                    [[NSNotificationCenter defaultCenter] postNotification:noti];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    
                    [MBProgressHUD showError:responseObject[@"message"]];

                    
                }

            }
            
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //修改失败
            [MBProgressHUD showError:@"网络请求失败,请检查网络设置"];
        }];
    } else {
        [MBProgressHUD showError:@"不能为空"];
    }
}

-(BOOL)judgeName:(NSString*)name
{
    if(name){
        for (int i=0; i<name.length; i++) {
            NSRange range=NSMakeRange(i,1);
            NSString *subString=[name substringWithRange:range];
            const char *cString=[subString UTF8String];
            if(name.length<2||name.length>8){
                NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                [mentionview showLable:@"昵称不要输入低于2个或高于8个字符" Controller:self];
                return NO;
            }
            
//            if (strlen(cString)==3)
//            {
//                //昵称是汉字");
//                if(name.length<2||name.length>4){
//                    
//                    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
//                    [mentionview showLable:@"不要输入低于2个或者高于4个汉字" Controller:self];
//                    
//                    return NO;
//                }
//            }else if(strlen(cString)==1)
//            {
//                //昵称是字母");
//                if(name.length<2||name.length>8){
//                    
//                    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
//                    [mentionview showLable:@"不要输入低于2个或者高于8个字符" Controller:self];
//                    
//                    return NO;
//                }
//            }
        }
        return YES;
    }
    
    return NO;
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
