//
//  DeliveryViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/5/29.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "DeliveryViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "NavgationbarView.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "AddAdressViewController.h"
#import "HZAreaPickerView.h"
#import "LoginViewController.h"
@interface DeliveryViewController ()
{
    UIView *_backView;
    UILabel *_namelable;
    UILabel *_phonelable;
    UILabel *_codelable;
    UILabel *_arealable;
    UILabel *_streetlable;
    UILabel *_detailelable;
    
    NSString * _stateID;
    NSString * _cityID;
    NSString * _arreaID;
    NSString * _streetID;
}
@end

@implementation DeliveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    _stateID=[NSString stringWithFormat:@"%@",self.model.province];
    _cityID=[NSString stringWithFormat:@"%@",self.model.city];
    _arreaID=[NSString stringWithFormat:@"%@",self.model.area];
    _streetID=[NSString stringWithFormat:@"%@",self.model.street];
    

    
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.image=[UIImage imageNamed:@"u265"];
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
    titlelable.text=@"收货地址";
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(kApplicationWidth-50, 20, 40, 40);
    button.centerY = View_CenterY(headview);
    [button setTitle:@"修改" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:button];

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
    _backView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, kApplicationWidth, 240)];
    _backView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_backView];
    
    NSArray *titlearr=@[@"收货人",@"手机号码",@"邮政编码",@"所在地区",@"街道",@"详细地址"];

    //通过地址ID查询确切地址
    NSMutableString *addressString=[NSMutableString string];
    [addressString appendString:[NSString stringWithFormat:@"%@",self.model.province]];
    [addressString appendString:@"_"];
    [addressString appendString:[NSString stringWithFormat:@"%@",self.model.city]];
    [addressString appendString:@"_"];
    [addressString appendString:[NSString stringWithFormat:@"%@",self.model.area]];
    if(self.model.street)
    {
        [addressString appendString:@"_"];
        [addressString appendString:[NSString stringWithFormat:@"%@",self.model.street]];
    }
    
    //查询地区
    HZAreaPickerView *pickview=[[HZAreaPickerView alloc]init];
    [pickview fromIDgetAddress:addressString];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *adress=[userdefaul objectForKey:ORDER_STATE_CITY_AREA];
    NSString *street= [userdefaul objectForKey:ORDER_STREET];
    NSArray *contentarr=@[[NSString stringWithFormat:@"%@",self.model.consignee],
                          [NSString stringWithFormat:@"%@",self.model.phone],
                          [NSString stringWithFormat:@"%@",self.model.postcode],
                          [NSString stringWithFormat:@"%@",adress],
                          [NSString stringWithFormat:@"%@",street],
                          [NSString stringWithFormat:@"%@",self.model.address]];
    
    
    for(int i=0;i<6;i++)
    {
        //头
        UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(10, 5+40*i, 100, 30)];
        titlelable.text=titlearr[i];
        [_backView addSubview:titlelable];
        
        //内容
        UILabel *contentlable=[[UILabel alloc]initWithFrame:CGRectMake(120, 5+40*i, kApplicationWidth-130, 30)];
        contentlable.text=contentarr[i];
        [_backView addSubview:contentlable];
        
        //分界线
        UILabel *linelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 40*(i+1), kApplicationWidth, 1)];
        linelable.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_backView addSubview:linelable];
        
    }

    UIView *delateview=[[UIView alloc]initWithFrame:CGRectMake(-5, _backView.frame.origin.y+_backView.frame.size.height+20, kApplicationWidth+10, 40)];
    delateview.layer.borderWidth=0.5;
    delateview.backgroundColor=[UIColor whiteColor];
    delateview.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(delate:)];
    [delateview addGestureRecognizer:tap];
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 120, 30)];
    lable.text=@"删除收货地址";
    lable.textColor=[UIColor redColor];
    [delateview addSubview:lable];
    [self.view addSubview:delateview];
    
    UIView *footview=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 50)];
    
    UILabel *linelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 0.5)];
    linelable.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [footview addSubview:linelable];
    
    UIButton *addbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    addbtn.frame=CGRectMake(100, 10, kApplicationWidth-200, 30);
    addbtn.backgroundColor=tarbarYellowcolor;
    addbtn.layer.cornerRadius=15;
    [addbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addbtn setTitle:@"设置成默认地址" forState:UIControlStateNormal];
    [addbtn addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:addbtn];
    
    [self.view addSubview:footview];

}

-(void)delate:(UITapGestureRecognizer*)tap
{
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"确定删除收货地址?此操作不可逆!" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil];
    action.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [action showInView:self.view];
}

#pragma mark 删除收货地址
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        //删除");
        [self deleateHttp];
    }
}

#pragma mark 设置成默认地址
-(void)setting:(UIButton*)sender
{

    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *ID=[NSString stringWithFormat:@"%@",self.model.addressid];
    
    NSString *url=[NSString stringWithFormat:@"%@address/update?version=%@&token=%@&is_default=1&id=%@",[NSObject baseURLStr],VERSION,token,ID];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            if(str.intValue==1)
            {
                message=@"设置成默认地址成功";
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
                message=@"设置成默认地址失败";
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
        
    }];
 
}
-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)change:(UIButton*)sender
{
    //修改");
    AddAdressViewController *change=[[AddAdressViewController alloc]init];
    change.typestring=@"修改";
    change.model=self.model;
    [self.navigationController pushViewController:change animated:YES];
}

#pragma mark 删除收货地址
-(void)deleateHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *ID=[NSString stringWithFormat:@"%@",self.model.addressid];
    NSString *is_default=[NSString stringWithFormat:@"%@",self.model.is_default];
    
    NSString *url=[NSString stringWithFormat:@"%@address/delete?version=%@&token=%@&id=%@&is_default=%@",[NSObject baseURLStr],VERSION,token,ID,is_default];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            if(str.intValue==1)
            {
                message=@"删除收货地址成功";
            }else{
                message=@"删除收货地址失败";
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
        
    }];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
