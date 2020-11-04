//
//  SettingViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/20.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "SettingViewController.h"
#import "AccountSafeViewController.h"
#import "AboutUsViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MyMD5.h"
@interface SettingViewController ()

@end

@implementation SettingViewController
{
    //数据源
    NSMutableArray *_dataArray;
   
    //列表
    UITableView *_Mytableview;
    
    //网络检测到的版本
    NSString *_httpVersion;
    
    UILabel *_lable;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray=[NSMutableArray array];
   
    //获取应用保存的应用版本
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *version= [user objectForKey:USER_VERSION];
    self.myVersion=version;
    

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
    titlelable.text=@"设置";
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];

    //网络检测是否有新版本
    [self versionsHttp];

    [self creatData];
    [self creaTableView];

}
- (void)viewWillAppear:(BOOL)animated
{
    Myview.hidden=YES;

}
-(void)viewWillDisappear:(BOOL)animated
{
    Myview.hidden=NO;
}

#pragma mark 数据源
-(void)creatData
{
    NSArray *arr1=@[@"个人资料",@"帐户与安全"];
    NSArray *arr2=@[@"消息",@"清理图片缓存",@"开启位置服务"];
    NSArray *arr3=@[@"新版本检测",@"关于我们",@"服务协议",@"意见反馈"];
    
    _dataArray=[NSMutableArray arrayWithObjects:arr1,arr2,arr3, nil];
    
   
}

-(void)versionsHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSString *url=[NSString stringWithFormat:@"%@getVersion?version=%@&type=2",[NSObject baseURLStr],VERSION];
    
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        responseObject = [NSDictionary changeType:responseObject];        
        if (responseObject!=nil) {
            NSString *sss=[NSString stringWithFormat:@"%@",responseObject[@"version_no"]];
            //网络检测到的版本
            if([ sss isEqualToString:@"<null>"])
            {
                
            }else{
                _httpVersion=responseObject[@"version_no"];
            }
            
            
//            NSString *str=responseObject[@"status"];
            if(_httpVersion !=nil)//检测成功
            {
                //保存当前版本
                NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
                [user setObject:responseObject[@"version_no"] forKey:USER_VERSION];
            }
            
            [_Mytableview reloadData];

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //检测失败");
    }];

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
        return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        if(indexPath.row==1)//帐号与安全
        {
            AccountSafeViewController *account=[[AccountSafeViewController alloc]init];
            [self.navigationController pushViewController:account animated:YES];
        }
    }
    
    if(indexPath.section==2)
    {
        if(indexPath.row==1)//关于我们
        {
            AboutUsViewController *aboutus=[[AboutUsViewController alloc]init];
            [self.navigationController pushViewController:aboutus animated:YES];
        }
    }
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
            if(indexPath.section==2)
            {
                if(indexPath.row==0)
                {
                    [_lable removeFromSuperview];
                    _lable=[[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth-150, 2, 120, 40)];
                   
                    if([self.myVersion isEqualToString:_httpVersion])
                    {
                        _lable.text=@"(已是最新版)";
                        
                    }else{
                        if(_httpVersion!=nil)
                        {
                            _lable.text=@"(有新版本)";
                        }else{
                            _lable.text=@"(已是最新版)";
                        }
                    }
                    _lable.textColor=[UIColor redColor];
                    _lable.textAlignment=NSTextAlignmentRight;
                    _lable.font=kNavigationItemFontSize;
                    [cell addSubview:_lable];

                }
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
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
