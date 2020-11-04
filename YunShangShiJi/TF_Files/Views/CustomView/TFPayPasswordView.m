//
//  TFPayPasswordView.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/15.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFPayPasswordView.h"

@interface TFPayPasswordView ()

@property (nonatomic, strong)UILabel *moneyLabel;

@end

@implementation TFPayPasswordView
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        [self viewInit];
    }
    return self;
}

- (void)viewInit
{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
//    self.alpha = 0.4;
    self.whiteView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth-ZOOM(957))/2, CGRectGetHeight(self.frame)-ZOOM(729)-ZOOM(650)-ZOOM(33), ZOOM(957), ZOOM(650))];
    
//    self.whiteView.center = CGPointMake(CGRectGetWidth(self.frame)/2.0, CGRectGetHeight(self.frame)/2.0-yy);
    
    self.whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.whiteView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.whiteView.frame.size.width, ZOOM(150))];
//    label.backgroundColor = [UIColor yellowColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"请输入支付密码";
    label.tag = 8888;
    label.textColor = RGBCOLOR_I(34,34,34);
    label.font = [UIFont systemFontOfSize:ZOOM(50)];
    [self.whiteView addSubview:label];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, label.frame.origin.y+label.frame.size.height+1, self.whiteView.frame.size.width, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.whiteView addSubview:lineView];
    
    self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, lineView.frame.origin.y, self.whiteView.frame.size.width, ZOOM(120))];
//    self.moneyLabel.backgroundColor = [UIColor redColor];
    self.moneyLabel.textColor = tarbarrossred;
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.whiteView addSubview:self.moneyLabel];
    
    for (int i = 0; i<6; i++) {
        CGFloat w = ZOOM(120);
        CGFloat h = ZOOM(120);
        
        CGFloat x = ((CGRectGetWidth(self.whiteView.frame))-w*6-5*3)/2.0+i*ZOOM(120)+i*3;
        CGFloat y = self.moneyLabel.frame.origin.y+self.moneyLabel.frame.size.height;

        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [self.whiteView addSubview:view];
        view.tag = 200+i;
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        tf.textAlignment = NSTextAlignmentCenter;
        tf.secureTextEntry = YES;
        tf.font = [UIFont systemFontOfSize:38];
        tf.keyboardType = UIKeyboardTypeNumberPad;
        tf.tag = 300+i;
        tf.enabled = NO;
        tf.borderStyle = UITextBorderStyleNone;
        
        tf.layer.masksToBounds = YES;
        tf.layer.cornerRadius = 0;
        tf.layer.borderWidth = 1;
        tf.layer.borderColor = [RGBCOLOR_I(220,220,220) CGColor];
        
        [self.textFeildArr addObject:tf];
        [view addSubview:tf];
    }
//    UIView *view = (UIView *)[self.whiteView viewWithTag:200];
    
    self.pwdField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.pwdField.secureTextEntry = YES;
    self.pwdField.font = [UIFont systemFontOfSize:42];
    self.pwdField.keyboardType = UIKeyboardTypeNumberPad;
    self.pwdField.delegate = self;
    self.pwdField.borderStyle = UITextBorderStyleBezel;
    self.pwdField.hidden = YES;
    [self.pwdField becomeFirstResponder];
    [self addSubview:self.pwdField];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(CGRectGetWidth(self.whiteView.frame)/2.0-ZOOM(33)-ZOOM(120)*2.5, CGRectGetHeight(self.whiteView.frame)-ZOOM(120)-ZOOM(67), ZOOM(120)*2.5, ZOOM(120));
    self.cancelBtn.backgroundColor = RGBCOLOR_I(22,22,22);
    self.cancelBtn.tag = 100;
    self.cancelBtn.titleLabel.font = kFont6px(32);
    [self.cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.whiteView addSubview:self.cancelBtn];
    
    self.okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.okBtn.frame = CGRectMake(CGRectGetWidth(self.whiteView.frame)/2.0+ZOOM(33), CGRectGetHeight(self.whiteView.frame)-ZOOM(120)-ZOOM(67), ZOOM(120)*2.5, ZOOM(120));
    self.okBtn.backgroundColor = COLOR_ROSERED;
    self.okBtn.tag = 101;
    [self.okBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.okBtn.titleLabel.font = kFont6px(32);
    _okBtn.userInteractionEnabled=YES;
    [self.okBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.whiteView addSubview:self.okBtn];
}

- (void)btnClick:(UIButton *)sender
{
    
    
    
    if (sender.tag == 100) {
        [self removeFromSuperview];
        
        
        NSNotification *notification=[NSNotification notificationWithName:@"buyfail" object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
//        if (self.dismissBlock!=nil) {
//            self.dismissBlock();
//        }
        
        
    } else if (sender.tag == 101&&[self.pwdField.text length]==6) {
        self.pwd = self.pwdField.text;
        _okBtn.userInteractionEnabled=NO;
        [self httpCheckPwd];
    } else if (sender.tag == 101&&[self.pwdField.text length]!=6) {
        [MBProgressHUD showError:@"密码长度为6位"];
    }
}

#pragma mark - 网络验证支付密码
- (void)httpCheckPwd
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *oldMD5 = [MyMD5 md5:self.pwd];
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/ckPwd?pwd=%@&token=%@&version=%@",[NSObject baseURLStr],oldMD5,token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        _okBtn.userInteractionEnabled=YES;
        if (responseObject!=nil) {
//            NSString *message = responseObject[@"message"];
//            if ([responseObject[@"pwdflag"] intValue] == 0) {
//                if (self.successBlock!=nil) {
//                    self.successBlock(self.pwd);
//                    [self removeFromSuperview];
//                }
//            }
//            else {
//                if ([responseObject[@"pwdflag"] intValue]==1){
//                    message=pwdflagString1;
//                }else if ([responseObject[@"pwdflag"] intValue]==2){
//                    message=pwdflagString2;
//                }else if ([responseObject[@"pwdflag"] intValue]==3){
//                    message=pwdflagString3;
//                }
//                self.failBlock(message);
//                [self removeFromSuperview];
//            }
            
            if ([responseObject[@"status"] intValue] == 1) {
                if (self.successBlock!=nil) {
                    self.successBlock(self.pwd);
                    [self removeFromSuperview];
                }
            } else if ([responseObject[@"status"] intValue] == 2){
//                [MBProgressHUD showError:@"密码错误"];

                self.failBlock(responseObject[@"message"]);
                [self removeFromSuperview];
            } else {
                
//                [MBProgressHUD showError:responseObject[@"message"]];
                
                if (self.failBlock!=nil) {
                    self.failBlock(responseObject[@"message"]);
                    [self removeFromSuperview];
                }
            }
            
        }
        
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
           [self removeFromSuperview];
    }];
    
}

- (void)returnPayResultSuccess:(paySuccessBlock)succssBlock withFail:(payFailBlock)failBlock withTitle:(NSString*)title
{
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    [window addSubview:self];
    
    self.successBlock = succssBlock;
    self.failBlock = failBlock;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f元",self.money.floatValue];

    UILabel *lable=(UILabel*)[self viewWithTag:8888];
    lable.text = title;

}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    if (range.location>=6) {
        return NO;
    } else {
        if ([string length] == 1) {
            ((UITextField *)[self.textFeildArr objectAtIndex:[textField.text length]]).text = string;
        } else {
            ((UITextField *)[self.textFeildArr objectAtIndex:[textField.text length]-1]).text = string;
        }
    }
    return YES;
}


- (void)doNext:(NSString *)string
{
    //string = %@",string);
}
- (NSMutableArray *)textFeildArr
{
    if (_textFeildArr == nil) {
        _textFeildArr = [[NSMutableArray alloc] init];
    }
    return _textFeildArr;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
