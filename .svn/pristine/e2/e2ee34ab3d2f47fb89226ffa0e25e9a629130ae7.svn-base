//
//  MywalletViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/20.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "MywalletViewController.h"
#import "PaypasswordViewController.h"
#import "SalemanageViewController.h"
#import "GlobalTool.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "NavgationbarView.h"
#import "AFNetworking.h"
#import "MyMD5.h"
//#import "ChatViewController.h"
//#import "ChatListViewController.h"
#import "RobotManager.h"
#import "LoginViewController.h"

@interface MywalletViewController ()

@end

@implementation MywalletViewController
{
    //数据源
    NSMutableArray *_dataArray;
    
    //列表
    UITableView *_Mytableview;
    
    //金额
    NSString *_balance;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray=[NSMutableArray array];
    _balance=@"";
    
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
    titlelable.text=@"我的钱包";
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    [self requestHTTP];
    
    [self creatData];
    [self creaTableView];
    
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

-(void)requestHTTP
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    

    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString* url=[NSString stringWithFormat:@"%@wallet/myWallet?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            NavgationbarView *alertview=[[NavgationbarView alloc] init];
            if(statu.intValue==1)//请求成功
            {
                
                _balance=[NSString stringWithFormat:@"%@",responseObject[@"balance"]];
                
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
            
            [_Mytableview reloadData];

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];
    
}

-(void)creatData
{
    NSArray *arr1=@[@"我的余额"];
    NSArray *arr2=@[@"销售管理",@"充值",@"提现",@"资金明细",@"我的卡券"];
    NSArray *arr3=@[@"我的银行卡",@"我的密码"];
    NSArray *arr4=@[@"实名认证"];
    _dataArray=[NSMutableArray arrayWithObjects:arr1,arr2,arr3,arr4, nil];
}
-(void)creaTableView
{
    _Mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight-Height_NavBar+kUnderStatusBarStartY) style:UITableViewStyleGrouped];
    _Mytableview.dataSource=self;
    _Mytableview.delegate=self;
    _Mytableview.sectionHeaderHeight=10;
    [self.view addSubview:_Mytableview];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray[section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if(section==0)
    {
        return 1;
    }
        return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
        NSArray *arr=_dataArray[indexPath.section];
        if(arr)
        {
            
            cell.textLabel.text=arr[indexPath.row];
            if(indexPath.section==0)
            {
                UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth-200, 0, 80, 40)];
                lable.text=[NSString stringWithFormat:@"%@",_balance];
                lable.font=[UIFont systemFontOfSize:30];
                lable.textAlignment=NSTextAlignmentCenter;
                lable.font=kNavigationItemFontSize;
                [cell addSubview:lable];
                    
            }else{
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==1)
    {
        if(indexPath.row==0)//销售管理
        {
            SalemanageViewController *sale=[[SalemanageViewController alloc]init];
            [self.navigationController pushViewController:sale animated:YES];
        }
    }
    if(indexPath.section==2)
    {
        if(indexPath.row==1)//我的密码
        {
            //pwd");
            
            PaypasswordViewController *password=[[PaypasswordViewController alloc]init];
            [self.navigationController pushViewController:password animated:YES];
        }
    }

}

-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)rightBarButtonClick
{
    [self Message];
}

-(void)Message
{
    // begin 赵官林 2016.5.26 跳转到消息列表
    [self presentChatList];
    // end
    
}
@end
