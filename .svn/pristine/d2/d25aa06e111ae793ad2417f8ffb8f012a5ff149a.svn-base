//
//  PersonalizedViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/9/21.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "PersonalizedViewController.h"
#import "GlobalTool.h"
#import "MyTabBarController.h"
#import "AddAdressViewController.h"
#import "KeyboardTool.h"
#import "AFNetworking.h"
#import "NavgationbarView.h"
#import "LoginViewController.h"
#import "MyMD5.h"

@interface PersonalizedViewController ()<KeyboardToolDelegate>
{
    UIButton *_finishbtn;
    NSString *_oldpersonSign;
}
@end

@implementation PersonalizedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"个性签名";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    //完成
    _finishbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _finishbtn.frame=CGRectMake(kApplicationWidth-65, 20, 60, 40);
    _finishbtn.centerY = View_CenterY(headview);
    _finishbtn.hidden = NO;
    [_finishbtn setTitle:@"完成" forState:UIControlStateNormal];
    _finishbtn.titleLabel.font = kNavTitleFontSize;
    _finishbtn.tintColor=[UIColor blackColor];
    [_finishbtn addTarget:self action:@selector(finishSave:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:_finishbtn];

    
    [self creatView];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}

-(void)creatView
{
    self.TextView.layer.borderWidth=1;
    self.TextView.layer.cornerRadius =5;
    self.TextView.textColor =kTextColor;
    self.TextView.font = [UIFont systemFontOfSize:ZOOM(48)];
    self.TextView.layer.borderColor = kBackgroundColor.CGColor;
    self.TextView.delegate=self;
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *person_sign=[user objectForKey:USER_PERSON_SIGN];
    
    if(person_sign)
    {
        self.TextView.text=person_sign;
        
        _oldpersonSign = [NSString stringWithFormat:@"%@",person_sign];
        
    }
    
    
    KeyboardTool *tool = [KeyboardTool keyboardTool];
    tool.delegate = self;
    tool.frame=CGRectMake(0, tool.frame.origin.y, kScreenWidth, 40);
    self.TextView.inputAccessoryView = tool;

}

//键盘
- (void)keyboardTool:(KeyboardTool *)keyboardTool itemClick:(KeyboardToolItemType)itemType
{
    
    if (itemType == KeyboardToolItemTypePrevious) { // 上一个
        //----上一个----");
    } else if (itemType == KeyboardToolItemTypeNext) { // 下一个
        //----下一个----");
    } else { // 完成
        //----完成----");
        
        [self.view endEditing:YES];
    }
    

}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:_oldpersonSign])
    {
//        _finishbtn.hidden = NO;
        textView.text = @"";
    }
//    else{
//        _finishbtn.hidden = YES;
//    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([MyMD5 asciiLengthOfString:self.TextView.text]>50){
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"签名最多50个字符" Controller:self];
    }
    
    if(textView.text.length==0)
    {
        textView.text = _oldpersonSign;
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)finishSave:(UIButton*)sender
{
    MyLog(@"保存");
    
    [self.view endEditing:YES];
    
    if(self.TextView.text.length==0)
    {
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"内容不能为空" Controller:self];
    }else if ([MyMD5 asciiLengthOfString:self.TextView.text]>50){
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"签名最多50个字符" Controller:self];
    }
    else{
        
        if([self.TextView.text isEqualToString:_oldpersonSign])
        {
            NavgationbarView *nv = [[NavgationbarView alloc] init];
            [nv showLable:@"没有修改内容，暂不能提交" Controller:self];
            
            return;

        }
        [self saveHttp];
    }
    
}

-(void)saveHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *userID = [user objectForKey:USER_ID];
    
    NSString *url=[NSString stringWithFormat:@"%@user/update_userinfo?version=%@&token=%@&user_id=%@&person_sign=%@",[NSObject baseURLStr],VERSION,token,userID,self.TextView.text];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            if(str.intValue==1)
            {
                message=@"保存成功";
                
                [user setObject:self.TextView.text forKey:USER_PERSON_SIGN];
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
                
                [self performSelector:@selector(back) withObject:self afterDelay:1];
            }
            else if(str.intValue == 10030){//没登录状态
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                LoginViewController *login=[[LoginViewController alloc]init];
                
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }
            
            else{
                message=@"保存失败";
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"保存失败,请重试!" Controller:self];


        [[Animation shareAnimation] stopAnimationAt:self.view];
    }];
    
    
}


-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
