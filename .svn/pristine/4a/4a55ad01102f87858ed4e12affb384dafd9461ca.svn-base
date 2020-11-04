//
//  SaleDetailViewController.m
//  YunShangShiJi
//
//  Created by yssj on 15/9/1.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "SaleDetailViewController.h"
#import "AFNetworking.h"
#import "GlobalTool.h"
#import "MyMD5.h"
#import "NavgationbarView.h"
//#import "ChatViewController.h"
#import "RobotManager.h"
#import "LoginViewController.h"


@interface SaleDetailViewController ()
{
    UILabel *_orderMoney;
    UILabel *_orderNum;
    UILabel *_orderTime;
    
    UILabel *_Name;
    UILabel *_tellPhone;
    UILabel *_zipCode;
    UILabel *_address;

}

@end

@implementation SaleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self requestsaleHttp];
//    [self requestHttp];
    [self creatNavgationView];
    [self creatMainView];
    
    
    [self changeInformation:_orderModel];
}
-(void)viewWillAppear:(BOOL)animated
{
    Myview.hidden=YES;
}

-(void)changeInformation:(OrderModel *)model
{
    _orderMoney.text = [NSString stringWithFormat:@"订单金额(包邮):¥%.2f",[model.money floatValue]];
    _orderNum.text = [NSString stringWithFormat:@"订单号:%@",model.order_code];
    _orderTime.text = [NSString stringWithFormat:@"下单时间:%@",model.add_time];
    _tellPhone.text = [NSString stringWithFormat:@"电话:%@",model.supp_phone];
    _zipCode.text = [NSString stringWithFormat:@"邮编:%@",model.supp_postcode];
    _address.text = [NSString stringWithFormat:@"地址:%@",model.supp_address];
    _Name.text=[NSString stringWithFormat:@"收件人:%@",model.supp_consignee];
    
    self.suppid=[NSString stringWithFormat:@"%@",model.user_id];
}
-(void)creatNavgationView
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    backbtn.frame=CGRectMake(10, 25, 15, 25);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"售后";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
}
-(void)creatMainView
{
    UIView *blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kApplicationWidth, 100)];
    blackView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:blackView];
    
    UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(60), 3, kApplicationWidth, 20)];
    detail.text = [NSString stringWithFormat:@"%@",@"订单详情"];
    detail.font=[UIFont systemFontOfSize:ZOOM(46)];
    detail.textColor = [UIColor whiteColor];
    [blackView addSubview:detail];
    _orderMoney =[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(60), detail.frame.size.height+3, kApplicationWidth-ZOOM(60)-ZOOM(42), 20)];
    _orderMoney.text = [NSString stringWithFormat:@"%@",@"订单金额(包邮):¥"];
    _orderMoney.textColor=[UIColor whiteColor];
    _orderMoney.font=[UIFont systemFontOfSize:ZOOM(40)];
    _orderNum =[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(60),_orderMoney.frame.origin.y+ _orderMoney.frame.size.height+3, kApplicationWidth-ZOOM(60)-ZOOM(42), 20)];
    _orderNum.text = [NSString stringWithFormat:@"%@",@"订单号:"];
    _orderNum.textColor=[UIColor whiteColor];
    _orderNum.font=[UIFont systemFontOfSize:ZOOM(40)];
    _orderTime =[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(60),_orderNum.frame.origin.y+_orderNum.frame.size.height+3, kApplicationWidth-ZOOM(60)-ZOOM(42), 20)];
    _orderTime.text = [NSString stringWithFormat:@"%@",@"下单时间:"];
    _orderTime.textColor=[UIColor whiteColor];
    _orderTime.font=[UIFont systemFontOfSize:ZOOM(40)];
    [blackView addSubview:_orderMoney];
    [blackView addSubview:_orderNum];
    [blackView addSubview:_orderTime];
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, blackView.frame.origin.y+blackView.frame.size.height, kApplicationWidth, 120)];
    whiteView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:whiteView];
    
    _Name = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(60), 10, kApplicationWidth, 20)];
    _tellPhone = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(60),_Name.frame.origin.y+ _Name.frame.size.height+3, kApplicationWidth, 20)];
    _zipCode = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(60), _tellPhone.frame.origin.y+_tellPhone.frame.size.height+3, kApplicationWidth, 20)];
    _address = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(60), _zipCode.frame.origin.y+_zipCode.frame.size.height+3, kApplicationWidth-ZOOM(60)-ZOOM(42), 60)];
    _address.numberOfLines=0;
    _Name.textColor=kTextGreyColor;
    _tellPhone.textColor=kTextGreyColor;
    _zipCode.textColor=kTextGreyColor;
    _address.textColor=kTextGreyColor;
    _Name.font=[UIFont systemFontOfSize:ZOOM(48)];
    _tellPhone.font=[UIFont systemFontOfSize:ZOOM(40)];
    _zipCode.font=[UIFont systemFontOfSize:ZOOM(40)];
    _address.font=[UIFont systemFontOfSize:ZOOM(40)];
    _Name.text = [NSString stringWithFormat:@"%@",@"收件人:"];
    _tellPhone.text = [NSString stringWithFormat:@"%@",@"电话:"];
    _zipCode.text = [NSString stringWithFormat:@"%@",@"邮编:"];
    _address.text = [NSString stringWithFormat:@"%@",@"地址:"];

    [whiteView addSubview:_Name];
    [whiteView addSubview:_tellPhone];
    [whiteView addSubview:_zipCode];
    [whiteView addSubview:_address];
    
    UIButton *connectBuyer = [UIButton buttonWithType:UIButtonTypeCustom];
    connectBuyer.frame = CGRectMake(ZOOM(60), blackView.frame.origin.y+blackView.frame.size.height+10, 100, 30 );
    connectBuyer.backgroundColor = [UIColor blackColor];
    [connectBuyer setTitle:@"联系买家" forState:UIControlStateNormal];
    [connectBuyer setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [connectBuyer addTarget:self action:@selector(connectBuyer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:connectBuyer];

}
-(void)connectBuyer:(UIButton *)btn
{
    [self Message:self.suppid];
}
#pragma mark 查看详情网络请求
-(void)requestsaleHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    
    NSString *url=[NSString stringWithFormat:@"%@returnShop/findOne?version=%@&token=%@&order_code=%@",[NSObject baseURLStr],VERSION,token,self.order_code];
    
    NSString *URL=[MyMD5 authkey:url];
    
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        [MBProgressHUD hideHUDForView:self.view];
        
        if (responseObject!=nil) {
//            responseObject = [NSDictionary changeType:responseObject];

            NSString *message;
            NSString *str=[NSString stringWithFormat:@"%@",responseObject[@"status"]];
            if(str.intValue==1)
            {
                NSDictionary *dic=responseObject[@"returnShop"];
                NSString *statue=dic[@"status"];
                
                _orderMoney.text = [NSString stringWithFormat:@"订单金额(包邮):¥%.2f",[dic[@"money"]floatValue]];
                _orderNum.text = [NSString stringWithFormat:@"订单号:%@",dic[@"order_code"]];
                _orderTime.text = [NSString stringWithFormat:@"下单时间:%@",dic[@"add_time"]];
                _tellPhone.text = [NSString stringWithFormat:@"电话:%@",dic[@"supp_phone"]];
                _zipCode.text = [NSString stringWithFormat:@"邮编:%@",dic[@"supp_postcode"]];
                _address.text = [NSString stringWithFormat:@"地址:%@",dic[@"supp_address"]];
                _Name.text=[NSString stringWithFormat:@"收件人:%@",dic[@"supp_consignee"]];
                
                self.suppid=[NSString stringWithFormat:@"%@",dic[@"user_id"]];
                
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
                
                
            }
            
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
//        [MBProgressHUD hideHUDForView:self.view];
        
    }];
    
    
    
}
#pragma mark 网络请求(买单)
-(void)requestHttp
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    
    NSString *url=[NSString stringWithFormat:@"%@order/getOrderBuyers?version=%@&token=%@&order_code=%@",[NSObject baseURLStr],VERSION,token,self.order_code];
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {

        
        if (responseObject!=nil) {
//            responseObject = [NSDictionary changeType:responseObject];

            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            
            if(str.intValue==1)
            {
                
                _Name.text = [NSString stringWithFormat:@"收件人:%@",responseObject[@"nick_name"]];
                
                
            }
        }
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
}
#pragma mark 聊天
-(void)Message:(NSString*)suppid
{
//    suppid = @"915";
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    suppid = [user objectForKey:PTEID];

    
    // begin 赵官林 2016.5.26
    [self messageWithSuppid:suppid title:nil model:nil detailType:nil imageurl:nil];
    // end
}


-(void)back:(UIButton*)sender
{
    [self .navigationController popViewControllerAnimated:YES];
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
