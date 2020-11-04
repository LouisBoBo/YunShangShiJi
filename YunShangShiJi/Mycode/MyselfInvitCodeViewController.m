//
//  MyselfInvitCodeViewController.m
//  YunShangShiJi
//
//  Created by hebo on 2019/7/25.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "MyselfInvitCodeViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+NJ.h"
#import "VitalityTaskPopview.h"
@interface MyselfInvitCodeViewController ()
@property (nonatomic , strong) VitalityTaskPopview *vitaliview;
@property (nonatomic , assign) BOOL has_parent_id;
@end

@implementation MyselfInvitCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.has_parent_id = YES;
    
    [self creatNavagationView];
    [self creatMainView];
    [self getuserHttp];
}

- (void)creatNavagationView
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"邀请码";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
}
- (void)creatMainView
{
    UITapGestureRecognizer *wenhaotap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wenhao:)];
    self.codeWenhao.userInteractionEnabled = YES;
    [self.codeWenhao addGestureRecognizer:wenhaotap];
    
    self.codeTextview.layer.borderColor = kTextColor.CGColor;
    self.codeTextview.layer.borderWidth = 0.5;
    self.codeTextview.layer.cornerRadius = 5;
    
    self.submitBtn.layer.cornerRadius = 5;
    [self.submitBtn addTarget:self action:@selector(submitCode:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
    self.mycodeLab.text = [NSString stringWithFormat:@"我的邀请码:%@",user_id];
    
    self.mycodeCopy.text = @"点击复制";
    self.mycodeCopy.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(copycode:)];
    [self.mycodeCopy addGestureRecognizer:tap];
    
}
-(void)submitCode:(UIButton*)sender
{
    if(self.codeTextview.text.length == 0 ||[self.codeTextview.text isEqualToString:@""])
    {
        [MBProgressHUD show:@"请输入邀请码" icon:nil view:self.view];
        return;
    }
    
    [self submitcodeHttp];
}
//获取是否有上级
-(void)getuserHttp
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSString *url=[NSString stringWithFormat:@"%@user/query_userinfo?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject!=nil) {
            if([responseObject[@"status"] integerValue] == 1)//提交成功
            {
                NSString *parent_id = [NSString stringWithFormat:@"%@",responseObject[@"userinfo"][@"parent_id"]];
                self.has_parent_id = (parent_id.length >0 && ![parent_id isEqualToString:@"(null)"] && ![parent_id isEqual:[NSNull null]]);
                [self refreshUI];
            }
        }else{
            [MBProgressHUD show:responseObject[@"message"] icon:nil view:self.view];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //检测失败");
    }];
    
}
- (void)refreshUI
{
    if(self.has_parent_id)
    {
        self.titleLab.hidden = YES;
        self.codeTitle.hidden = YES;
        self.codeWenhao.hidden = YES;
        self.codeTextview.hidden = YES;
        self.submitBtn.hidden = YES;
    }else{
        self.codeTitle.hidden = NO;
        self.codeWenhao.hidden = NO;
        self.codeTextview.hidden = NO;
        self.submitBtn.hidden = NO;
    }
}
//提交邀请码
-(void)submitcodeHttp
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSString *url=[NSString stringWithFormat:@"%@user/setReferee?version=%@&token=%@&userid=%@&parent_id=%@",[NSObject baseURLStr],VERSION,token,user_id,self.codeTextview.text];
    
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject!=nil) {
           if([responseObject[@"status"] integerValue] == 1)//提交成功
           {
               [MBProgressHUD show:@"提交成功" icon:nil view:self.view];
           }else{
               [MBProgressHUD show:@"提交失败" icon:nil view:self.view];
           }
        }else{
            [MBProgressHUD show:responseObject[@"message"] icon:nil view:self.view];
        }
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //检测失败");
    }];
    
}

//复制邀请码
-(void)copycode:(UITapGestureRecognizer*)tap
{
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
    
    pab.string = [NSString stringWithFormat:@"%@",user_id];
    
    if (pab == nil){
        [MBProgressHUD showError:@"复制失败"];
    }else{
        [MBProgressHUD showSuccess:@"已复制"];
    }
}

//什么是邀请码
-(void)wenhao:(UITapGestureRecognizer*)tap
{
    [self setVitalityPopMindView:CodeInvite_what];
}
#pragma mark *********************弹框***********************
- (void)setVitalityPopMindView:(VitalityType)type
{
    
    self.vitaliview = [[VitalityTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) VitalityType:type valityGrade:0 YidouCount:0];
    
    __weak VitalityTaskPopview *view = self.vitaliview;
    view.oneYuanDiKou = [DataManager sharedManager].OneYuan_count;
    
    kWeakSelf(self);
    view.tapHideMindBlock = ^{
        
    };
    view.rightHideMindBlock = ^(NSString *title) {
       
    };
    view.leftHideMindBlock = ^(NSString*title){
        
    };
    
    [self.view addSubview:self.vitaliview];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
