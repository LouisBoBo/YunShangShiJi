//
//  MyjifenViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/21.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "MyjifenViewController.h"
#import "JifenShopViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "GlobalTool.h"
#import "MyMD5.h"
#import "NavgationbarView.h"
#import "LoginViewController.h"
@interface MyjifenViewController ()

@end

@implementation MyjifenViewController
{
    
    NSArray *_dataArray;
    //列表
    UITableView *_mytableView;
    
    //总积分
    NSString *_integral;
    //近一个月进账
    NSString *_income;
    //近一个月支出
    NSString *_expense;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
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
    titlelable.text=@"我的积分";
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    [self requestHttp];
//    [self creatView];


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
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self creatView];
}
-(void)requestHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString* url=[NSString stringWithFormat:@"%@wallet/getIntegral?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            if(statu.intValue==1)//请求成功
            {
                _integral=[NSString stringWithFormat:@"%@",responseObject[@"integral"]];
                _income=[NSString stringWithFormat:@"%@",responseObject[@"income"]];
                _expense=[NSString stringWithFormat:@"%@",responseObject[@"expense"]];
            }
            else if(statu.intValue == 10030){//没登录状态
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                LoginViewController *login=[[LoginViewController alloc]init];
                
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }
            
            else{
                
            }
            
            [_mytableView reloadData];
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];

}

-(void)qiandaoRequestHttp:(NSInteger)tag
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString* url=[NSString stringWithFormat:@"%@wallet/everydaySign?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            if(statu.intValue==1)//请求成功
            {
                message=@"签到成功";
                
                UIButton *button=(UIButton*)[self.view viewWithTag:tag];
                [button setTitle:@"今日已签到" forState:UIControlStateNormal];
                
            }else{
                message=@"今日已签到";
            }
            
            NavgationbarView *MentionView=[[NavgationbarView alloc]init];
            [MentionView showLable:message Controller:self];
        }
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];


}

#pragma mark 主界面
-(void)creatView
{
    UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 64, kApplicationWidth, 110)];
//    [self.view addSubview:headview];
    
    UILabel *totallable=[[UILabel alloc]initWithFrame:CGRectMake(50, 10, 60, 30)];
    totallable.text=@"总积分";
    headview.backgroundColor=[UIColor whiteColor];
    [headview addSubview:totallable];
    
    UILabel *jifenlable=[[UILabel alloc]initWithFrame:CGRectMake(totallable.frame.origin.x+totallable.frame.size.width+30, 10, 60, 30)];
    jifenlable.text=_integral;
    jifenlable.font=[UIFont systemFontOfSize:20];
    [headview addSubview:jifenlable];
    
    UIButton *qiandaobtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    qiandaobtn.frame=CGRectMake(jifenlable.frame.origin.x+jifenlable.frame.size.width+20, 10, 80, 30);
    qiandaobtn.tag=1111;
    [qiandaobtn setTitle:@"每日签到" forState:UIControlStateNormal];
    qiandaobtn.tintColor=[UIColor redColor];
    [qiandaobtn addTarget:self action:@selector(qiandao:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:qiandaobtn];
    
    UILabel *linelable=[[UILabel alloc]initWithFrame:CGRectMake(0, totallable.frame.origin.y+totallable.frame.size.height+10, kApplicationWidth, 1)];
    linelable.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [headview addSubview:linelable];
    
    int k=0;
    CGFloat widh=kApplicationWidth/2;
    for(int j=0;j<2;j++)
    {
        for(int i=0;i<2;i++)
        {
            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(widh*i, linelable.frame.origin.y+10+20*j, kApplicationWidth/2, 20)];
            if(k==2)
            {
                lable.text=@"近一个月进账";
            }
            if(k==3)
            {
                 lable.text=@"近一个月支出";
            }
            if(k==0)
            {
                lable.text=_income;
            }
            if(k==1)
            {
                 lable.text=_expense;
            }
            lable.textAlignment=NSTextAlignmentCenter;
            [headview addSubview:lable];
            k++;
        }
       
    }
    
    [self creatData];
    //列表
    _mytableView=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight-Height_NavBar+kUnderStatusBarStartY-40)];
    _mytableView.delegate=self;
    _mytableView.dataSource=self;
    _mytableView.rowHeight=60;
    _mytableView.separatorStyle = UITableViewCellAccessoryNone;
    [self.view addSubview:_mytableView];
    
    _mytableView.tableHeaderView=headview;
    
    //积分商城
    UIButton *jifenbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    jifenbtn.frame=CGRectMake(30, kApplicationHeight-35+kUnderStatusBarStartY, kApplicationWidth-60, 30);
    [jifenbtn setTitle:@"积分商城" forState:UIControlStateNormal];
    jifenbtn.tintColor=[UIColor whiteColor];
    [jifenbtn setBackgroundImage:[UIImage imageNamed:@"u265"] forState:UIControlStateNormal];
    [jifenbtn addTarget:self action:@selector(jifenbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:jifenbtn];
}
-(void)creatData
{
    _dataArray=@[@"完善注册信息",@"设置个人头像为自拍",@"认证手机号",@"认证邮箱",@"关注微信公众号",@"关注QQ空间",@"打分鼓励我们"];
}

#pragma mark 签到
-(void)qiandao:(UIButton*)sender
{
    [self qiandaoRequestHttp:sender.tag];
}
-(void)jifenbtn:(UIButton*)sender
{
    //jifen");
    JifenShopViewController *jifen=[[JifenShopViewController alloc]init];
    [self.navigationController pushViewController:jifen animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake((kApplicationWidth-20)/2, 5, 20, 20)];
    imageview.image=[UIImage imageNamed:@""];
    imageview.clipsToBounds=YES;
    imageview.layer.cornerRadius=10;
    [cell addSubview:imageview];
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake((kApplicationWidth-150)/2, 30, 150, 25)];
    lable.text=_dataArray[indexPath.row];
    lable.font=[UIFont systemFontOfSize:15];
    lable.textColor=kTextGreyColor;
    lable.textAlignment=NSTextAlignmentCenter;
    [cell addSubview:lable];
    
    
//    cell.textLabel.text=_dataArray[indexPath.row];
//
//    UIImage *image=[UIImage imageNamed:@"u839.jpg"];
//    cell.imageView.image=image;
//        
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
