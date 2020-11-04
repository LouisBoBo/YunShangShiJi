//
//  AccountSafeViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/20.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "AccountSafeViewController.h"
#import "LoginViewController.h"
#import "AFNetworking.h"
#import "GlobalTool.h"
#import "MyMD5.h"
@interface AccountSafeViewController ()

@end

@implementation AccountSafeViewController
{
    //数据源
    NSMutableArray *_dataArray;
    //headtitle
    NSArray *_headArray;
    //列表
    UITableView *_Mytableview;
    
    //上次登录时间
    NSString *_logintime;
    UILabel *_lable;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray=[NSMutableArray array];
    _headArray=[NSArray array];
    
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
    titlelable.text=@"帐户安全";
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    //网络请求
    [self creatHttp];
    
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
#pragma mark 网络请求
-(void)creatHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@loginRecord/lastLogin?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //responseObject is %@",responseObject);
        
//        responseObject = [NSDictionary changeType:responseObject];

    
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            if(str.intValue==1)//检测成功
            {
                _logintime=responseObject[@"loginTime"];
                NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
                [user setObject:_logintime forKey:LOGIN_TIME];
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
            
            [_Mytableview reloadData];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
    }];


}
#pragma mark 数据源
-(void)creatData
{
    _headArray=@[@"",@"帐号及信息完整性",@"登录及访问历史",@"安全贴士"];
    
    NSArray *arr1=@[@"手机用户",@"最后一次访问时间"];
    NSArray *arr2=@[@"登录密码",@"绑定手机",@"绑定邮箱",@"其它绑定"];
    NSArray *arr3=@[@"登录设备"];
    NSArray *arr4=@[@"安全贴士"];
    _dataArray=[NSMutableArray arrayWithObjects:arr1,arr2,arr3,arr4, nil];
    
}
-(void)creaTableView
{
    _Mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight-Height_NavBar) style:UITableViewStyleGrouped];
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
    return 0;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //is %@",_headArray[section]);
    
    return _headArray[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
        NSArray *arr=_dataArray[indexPath.section];
        if(arr)
        {
            
            cell.textLabel.text=arr[indexPath.row];
            if(indexPath.section==0)
            {
                //获取当前用户
                NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
                NSString *name=[user objectForKey:USER_NAME];
                NSString *phone=[user objectForKey:USER_PHONE];
                NSString *email=[user objectForKey:USER_EMAIL];
                
                if(indexPath.row==0)
                {
                    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth-200, 0, 180, 40)];
                    if(name!=nil)
                    {
                        lable.text=name;
                    }
                    if(phone!=nil)
                    {
                        lable.text=phone;
                    }
                    if(email!=nil)
                    {
                        lable.text=email;
                    }
                    lable.textAlignment=NSTextAlignmentRight;
                    lable.font=kNavigationItemFontSize;
                    [cell addSubview:lable];
                    
                }else{

                   
                    if(_logintime!=nil)
                    {
                        [_lable removeFromSuperview];
                         _lable=[[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth-150, 0, 130, 40)];
                        _lable.text=[NSString stringWithFormat:@"%@",_logintime];
                        
                    }else{
                         [_lable removeFromSuperview];
                        _lable=[[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth-150, 0, 130, 40)];
                        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
                        NSString *logintime=[user objectForKey:LOGIN_TIME];
                        _lable.text=[NSString stringWithFormat:@"%@",logintime];

                    }

                    _lable.textAlignment=NSTextAlignmentRight;
                    _lable.font=kNavigationItemFontSize;
                    [cell addSubview:_lable];
                }
            }else{
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
