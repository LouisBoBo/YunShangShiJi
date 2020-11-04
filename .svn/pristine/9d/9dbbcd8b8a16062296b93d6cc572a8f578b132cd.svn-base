//
//  MemberNumberViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/3/8.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "MemberNumberViewController.h"
#import "GlobalTool.h"
#import "MyMD5.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "NavgationbarView.h"

@interface MemberNumberViewController ()

@end

@implementation MemberNumberViewController
{
    NSString *_memnumber;
    NSString *_memword;
    NSString *_passtime;
    
    UILabel *_timelable;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatNavgationView];
    
    [self creatMainView];
    
    [self requestHttp];
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

-(void)creatNavgationView
{
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, Height_NavBar)];
    headview.image=[UIImage imageNamed:@"导航背景"];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
//    [backbtn setImage:[UIImage imageNamed:@"返回按钮_高亮"] forState:UIControlStateHighlighted];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, headview.frame.size.width, 40);
    titlelable.center=CGPointMake(kScreenWidth/2, headview.frame.size.height/2+10);
    titlelable.text= @"会员卡";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.size.height-1, kScreenWidth, 1)];
    line.backgroundColor=lineGreyColor;
    [headview addSubview:line];
}

- (void)creatMainView
{
    NSArray *titlearr = @[@"卡号:      ",@"激活码:      "];
    
    CGFloat space = 50;
    CGFloat titlleYY=0;
    for(int i =0;i<titlearr.count;i++)
    {
        UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(60, 100+space*i, kScreenWidth - 2*60, 30)];
        titlelable.text = titlearr[i];
        titlelable.tag = 1000+i;
        titlelable.textAlignment = NSTextAlignmentCenter;
        titlelable.font = [UIFont systemFontOfSize:ZOOM(51)];
        [self.view addSubview:titlelable];
        
        UILabel *linelable = [[UILabel alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(titlelable.frame), kScreenWidth - 2*60, 2)];
        linelable.backgroundColor = kTitleColor;
        [self.view addSubview:linelable];
        
        if(i==1)
        {
            titlleYY = CGRectGetMaxY(linelable.frame);
        }
    }
    
    _timelable = [[UILabel alloc]initWithFrame:CGRectMake(0, titlleYY+10, kScreenWidth, 30)];
    _timelable.textAlignment = NSTextAlignmentCenter;
    _timelable.textColor = tarbarrossred;
    _timelable.text = @"";
    _timelable.font = [UIFont systemFontOfSize:ZOOM(47)];
    [self.view addSubview:_timelable];
    
    //交易没有成功就不显示有效期时间
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *ismember = [userdefaul objectForKey:USER_MEMBER];
    
}

- (void)refreshMainview
{
    UILabel *numberlab = (UILabel*)[self.view viewWithTag:1000];
    numberlab.text = [NSString stringWithFormat:@"卡号: %@",_memnumber];
    
    UILabel *wordlab = (UILabel*)[self.view viewWithTag:1001];
    wordlab.text = [NSString stringWithFormat:@"激活码: %@",_memword];
    
    NSString *time = [MyMD5 getTimeToShowWithTimestampHour:_passtime];
    
    if([time hasPrefix:@"1970"])
    {
        _timelable.hidden = YES;
    }
    _timelable.text =[NSString stringWithFormat:@"有效期至: %@",time];
}

- (void)requestHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    
    url=[NSString stringWithFormat:@"%@vip/queryMyVipCard?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    
    NSString *URL=[MyMD5 authkey:url];
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        NSString *message;
        if (responseObject!=nil) {
            
            
            NSString *statue = responseObject[@"status"];
            if(statue.intValue == 1)
            {
                _memnumber = [NSString stringWithFormat:@"%@",responseObject[@"card_no"]];
                _memword = [NSString stringWithFormat:@"%@",responseObject[@"plaintext"]];
                _passtime = [NSString stringWithFormat:@"%@",responseObject[@"time"]];
                
                [self refreshMainview];
                
            }else{
                message = responseObject[@"message"];
            }
        }else{
            message = @"网络异常";
        }
        
        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        [mentionview showLable:message Controller:self];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [MBProgressHUD hideHUDForView:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];

}

- (void)leftBarButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
