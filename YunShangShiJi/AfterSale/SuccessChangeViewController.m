//
//  SuccessChangeViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/7/17.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "SuccessChangeViewController.h"
#import "GlobalTool.h"
#import "MyMD5.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "ShopDetailModel.h"
#import "TFPayPasswordView.h"
#import "NavgationbarView.h"
#import "CancleViewController.h"
#import "AftersaleViewController.h"
#import "logistTableViewCell.h"
#import "LoginViewController.h"
//#import "ChatListViewController.h"
#import "DXAlertView.h"
#import "TFChangePaymentPasswordViewController.h"

@interface SuccessChangeViewController ()
{
    UITableView *_logistTableview;
    NSMutableArray *_logistDataArray;
    
    ShopDetailModel *_logisticsModel;

}
@end

@implementation SuccessChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _logistDataArray= [NSMutableArray array];

    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=self.titlestr;
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];

//    UIButton *searchbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    searchbtn.frame=CGRectMake(kApplicationWidth - 40, 30, 25, 25);
//    searchbtn.tintColor=[UIColor blackColor];
//    [searchbtn setImage:[UIImage imageNamed:@"设置"]  forState:UIControlStateNormal];
//    searchbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [searchbtn addTarget:self action:@selector(tomessage:) forControlEvents:UIControlEventTouchUpInside];
//    [headview addSubview:searchbtn];
    
//    NSInteger unReadMessageCount=[[EaseMob sharedInstance].chatManager loadTotalUnreadMessagesCountFromDatabase];
//    UILabel *messagecount=[[UILabel alloc]initWithFrame:CGRectMake(20, -10, 20, 20)];
//    messagecount.text=[NSString stringWithFormat:@"%ld",(long)unReadMessageCount];
//    messagecount.font=[UIFont systemFontOfSize:15];
//    messagecount.textColor=[UIColor whiteColor];
//    messagecount.backgroundColor=tarbarYellowcolor;
//    messagecount.clipsToBounds=YES;
//    messagecount.layer.cornerRadius=10;
//    messagecount.textAlignment=NSTextAlignmentCenter;
//    if(unReadMessageCount !=0)
//    {
//        [searchbtn addSubview:messagecount];
//    }
    
    [self changeInformation:_orderModel];


    //物流信息
//    NSString *expressid=self.dic[@"express_id"];
//    if(expressid isEqualToString:@"<null>")
//    {
//        NSArray *idarr=[expressid componentsSeparatedByString:@":"];
//    
//        if(idarr)
//        {
//            [self GetlogHttp:@"880216312723868737" :@"yuantong"];//也死了
//        }
//    }
//    dic[@"logi_code"];dic[@"logi_name"]
    [self GetlogHttp:_orderModel.logi_code :_orderModel.logi_name];//也死了
    
//    [self creatView];
    [self fontAndSize];
    
}
-(void)tomessage:(UIButton*)sender
{
    //begin 赵官林 2016.5.26 跳转到消息列表
    [self presentChatList];
    //end
}
-(void)fontAndSize
{
    _heattitle.frame=CGRectMake(ZOOM(62), _heattitle.frame.origin.y, _heattitle.frame.size.width, _heattitle.frame.size.height);
    _moneylab.frame=CGRectMake(ZOOM(62), _moneylab.frame.origin.y, _moneylab.frame.size.width, _moneylab.frame.size.height);
    _timelab.frame=CGRectMake(ZOOM(62), _timelab.frame.origin.y, _timelab.frame.size.width, _timelab.frame.size.height);
    _codelab.frame=CGRectMake(ZOOM(62), _codelab.frame.origin.y, _codelab.frame.size.width, _codelab.frame.size.height);
    _intfotitle.frame=CGRectMake(ZOOM(62), _intfotitle.frame.origin.y, _intfotitle.frame.size.width, _intfotitle.frame.size.height);
    _congist.frame=CGRectMake(ZOOM(62), _congist.frame.origin.y, _congist.frame.size.width, _congist.frame.size.height);
    _phone.frame=CGRectMake(ZOOM(62), _phone.frame.origin.y, _phone.frame.size.width, _phone.frame.size.height);
    _postcode.frame=CGRectMake(ZOOM(62), _postcode.frame.origin.y, _postcode.frame.size.width, _postcode.frame.size.height);
    _address.frame=CGRectMake(ZOOM(62), _address.frame.origin.y,kApplicationWidth-ZOOM(62)*2, _address.frame.size.height);
    _logisticclde.frame=CGRectMake(ZOOM(62), _logisticclde.frame.origin.y, _logisticclde.frame.size.width, _logisticclde.frame.size.height);
    _logistFollow.frame=CGRectMake(ZOOM(62), _logistFollow.frame.origin.y, _logistFollow.frame.size.width, _logistFollow.frame.size.height);
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}

-(void)GetlogHttp:(NSString*)logi_code :(NSString*)logi_name
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    
//    NSString *url=[NSString stringWithFormat:@"http://www.kuaidi100.com/query?type=%@&postid=%@",logi_name,logi_code];
    NSString *url = [NSString stringWithFormat:@"%@order/expQuery?version=%@&token=%@&nu=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],logi_code];

    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        //responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
//            if(responseObject[@"com"] !=nil)
            if(responseObject[@"data"] !=nil && [responseObject[@"data"]count]!=0)

            {
                ShopDetailModel *model=[[ShopDetailModel alloc]init];
                model.codenumber=responseObject[@"codenumber"];
                model.com=responseObject[@"com"];
                model.companytype=responseObject[@"companytype"];
                model.condition=responseObject[@"condition"];
                model.ischeck=responseObject[@"ischeck"];
                model.nu=responseObject[@"nu"];
                model.state=responseObject[@"state"];
                model.logisstatus=responseObject[@"status"];
                model.updatetime=responseObject[@"updatetime"];
                
                _logisticsModel=model;
                
//                for(NSDictionary *dic in responseObject[@"data"])
                for(NSDictionary *dic in responseObject[@"data"][0][@"lastResult"][@"data"])
                {
                    ShopDetailModel *Logisticsmodel=[[ShopDetailModel alloc]init];
                    Logisticsmodel.context=dic[@"context"];
                    Logisticsmodel.ftime=dic[@"ftime"];
                    Logisticsmodel.time=dic[@"time"];
                    
                    [_logistDataArray addObject:Logisticsmodel];
                }
                
               
            }else if ([responseObject[@"data"]count]==0){
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:@"暂无物流信息" Controller:self];
            }
            else{
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:responseObject[@"message"] Controller:self];
            }
            
            [_logistTableview reloadData];

        }
        else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:responseObject[@"message"] Controller:self];
        }
            
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
    }];
    
    
}

#pragma mark 确认收货
-(void)ShouhuoHttp:(NSString*)ordercode withPwd:(NSString *)pwd
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *passwd=[MyMD5 md5:pwd];
    
    NSString *url;
    if ([self.heattitle.text isEqualToString: @"商家换货物流"]) {
        url=[NSString stringWithFormat:@"%@returnShop/affirmShop?version=%@&token=%@&id=%@",[NSObject baseURLStr],VERSION,token,_orderModel.ID];
    }else
        url=[NSString stringWithFormat:@"%@order/affirmOrder?version=%@&token=%@&order_code=%@&pwd=%@",[NSObject baseURLStr],VERSION,token,ordercode,passwd];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
       // responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(str.intValue==1)
            {
//                message=@"收货成功";
                
//                CancleViewController *cancle=[[CancleViewController alloc]init];
//                cancle.titlestring=self.titlestr;
////                cancle.dic=self.dic;
//                cancle.orderModel=_orderModel;
//                [self.navigationController pushViewController:cancle animated:YES];
                
                [self.navigationController popViewControllerAnimated:YES];
                
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
                
//                message=@"收货失败";
                
            }
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
    }];
    
    
}

-(void)changeInformation:(OrderModel *)model
{
    
    self.moneylab.text=[NSString stringWithFormat:@"订单金额(包邮):¥%.2f",model.money.floatValue];
    self.codelab.text=[NSString stringWithFormat:@"订单号:%@",model.order_code];
    
    
    if(self.statues.intValue==10)//向商家发货
    {
        NSString *str;
        
        if([self.titlestr isEqualToString:@"退货详情"])
        {
            str=@"退货";
        }else{
            str=@"换货";
        }
        
        NSString *applytime=[MyMD5 getTimeToShowWithTimestamp:model.add_time];
        self.timelab.text=[NSString stringWithFormat:@"%@时间:%@",str,applytime];
        self.logisticclde.text=[NSString stringWithFormat:@"商家收货物流单号:%@",_orderModel.logi_code];
        
        self.congist.text=[NSString stringWithFormat:@"收件人:%@",model.supp_consignee];
        self.phone.text=[NSString stringWithFormat:@"电话:%@",model.supp_phone];
        self.postcode.text=[NSString stringWithFormat:@"邮编:%@",model.supp_postcode];
        self.address.text=[NSString stringWithFormat:@"地址:%@",model.supp_address];
    }else{
        self.heattitle.text=@"商家换货物流";
        
        NSString *applytime=[MyMD5 getTimeToShowWithTimestamp:model.add_time];
        self.timelab.text=[NSString stringWithFormat:@"确认收货时间:%@",applytime];
        self.logisticclde.text=[NSString stringWithFormat:@"商家换货物流单号:%@",_orderModel.logi_code];
        
        self.buyerinfoview.frame=CGRectMake(0, self.buyerinfoview.frame.origin.y, kApplicationWidth, 55);
        self.intfotitle.text=@"商家已发货";
        self.congist.text=@"商家已收到你的换货商品,换货已发出";
        self.congist.textColor=kTextGreyColor;
        
        
    }
    
    self.logisticview.frame=CGRectMake(0, self.buyerinfoview.frame.origin.y+self.buyerinfoview.frame.size.height, kApplicationWidth, self.logisticview.frame.size.height);
    
    //分割线
    for(int i=0;i<2;i++)
    {
        UILabel *linelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0+39*i, kApplicationWidth, 1)];
        linelable.backgroundColor=kBackgroundColor;
        [self.logisticview addSubview:linelable];
    }
    
    [self creatTableview];

}
/*
-(void)creatView
{
    
    self.moneylab.text=[NSString stringWithFormat:@"订单金额(包邮):¥%@",self.dic[@"money"]];
    self.codelab.text=[NSString stringWithFormat:@"订单号:%@",self.dic[@"order_code"]];
    
    
    if(self.statues.intValue==10)//向商家发货
    {
        NSString *str;
        
        if([self.titlestr isEqualToString:@"退货详情"])
        {
            str=@"退货";
        }else{
            str=@"换货";
        }
        
        NSString *applytime=[MyMD5 getTimeToShowWithTimestamp:self.dic[@"add_time"]];
        self.timelab.text=[NSString stringWithFormat:@"%@时间:%@",str,applytime];
        self.logisticclde.text=[NSString stringWithFormat:@"商家收货物流单号:%@",self.dic[@"return_code"]];
    
        self.congist.text=[NSString stringWithFormat:@"收件人:%@",self.dic[@"supp_consignee"]];
        self.phone.text=[NSString stringWithFormat:@"电话:%@",self.dic[@"supp_phone"]];
        self.postcode.text=[NSString stringWithFormat:@"邮编:%@",self.dic[@"supp_postcode"]];
        self.address.text=[NSString stringWithFormat:@"地址:%@",self.dic[@"supp_address"]];
    }else{
        self.heattitle.text=@"商家换货物流";
        
        NSString *applytime=[MyMD5 getTimeToShowWithTimestamp:self.dic[@"add_time"]];
        self.timelab.text=[NSString stringWithFormat:@"确认收货时间:%@",applytime];
        self.logisticclde.text=[NSString stringWithFormat:@"商家换货物流单号:%@",self.dic[@"return_code"]];
        
        self.buyerinfoview.frame=CGRectMake(0, self.buyerinfoview.frame.origin.y, kApplicationWidth, 55);
        self.intfotitle.text=@"商家已发货";
        self.congist.text=@"商家已收到你的换货商品,换货已发出";
        self.congist.textColor=kTextGreyColor;
        
       
    }
    
    self.logisticview.frame=CGRectMake(0, self.buyerinfoview.frame.origin.y+self.buyerinfoview.frame.size.height, kApplicationWidth, self.logisticview.frame.size.height);
    
    //分割线
    for(int i=0;i<2;i++)
    {
        UILabel *linelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0+39*i, kApplicationWidth, 1)];
        linelable.backgroundColor=kBackgroundColor;
        [self.logisticview addSubview:linelable];
    }
    
#if 0
    //物流列表
    
    CGFloat shopHeigh=40;
    CGFloat tableviewHeigh=shopHeigh*_logistDataArray.count;
    //在商品列表创建列表视图
    _logistTableview=[[UITableView alloc]initWithFrame:CGRectMake(0, self.logisticview.frame.origin.y+40, kApplicationWidth,tableviewHeigh) style:UITableViewStylePlain];
    _logistTableview.dataSource=self;
    _logistTableview.delegate=self;
    _logistTableview.rowHeight=40;
    [self.Myscrollview addSubview:_logistTableview];

    self.Myscrollview.contentSize=CGSizeMake(0, self.headview.frame.size.height+self.buyerinfoview.frame.size.height+tableviewHeigh+50);
    
#endif
}
*/
-(void)creatTableview
{
    //物流列表
    
    CGFloat shopHeigh=40;
    CGFloat tableviewHeigh=shopHeigh*_logistDataArray.count;
    //在商品列表创建列表视图
    _logistTableview=[[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_logisticview.frame), kApplicationWidth,kScreenHeight-CGRectGetMaxY(_logisticview.frame)-40) style:UITableViewStylePlain];
    _logistTableview.dataSource=self;
    _logistTableview.delegate=self;
    _logistTableview.rowHeight=55;
    _logistTableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_logistTableview registerNib:[UINib nibWithNibName:@"logistTableViewCell" bundle:nil] forCellReuseIdentifier:@"logistcell"];
    [self.view addSubview:_logistTableview];
    
    CGFloat footviewHeigh;
    
    if(self.statues.intValue==10)
    {
        footviewHeigh=0;
    }else{
        footviewHeigh=50;
    }
    
    UIView *footview=[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-footviewHeigh, kApplicationWidth,footviewHeigh)];
    
    UIButton *okbutton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    okbutton.frame=CGRectMake(20, 5, kApplicationWidth-40, 40);
    [okbutton setTitle:@"确认收货" forState:UIControlStateNormal];
    [okbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okbutton setBackgroundColor:[UIColor blackColor]];
    
    [footview addSubview:okbutton];
    
    [okbutton addTarget:self action:@selector(shouhuo:) forControlEvents:UIControlEventTouchUpInside];
    
    if(self.statues.intValue==10)
    {

    }else{
//         _logistTableview.tableFooterView=footview;
        [self.view addSubview:footview];
    }

//    self.Myscrollview.contentSize=CGSizeMake(0, self.headview.frame.size.height+self.buyerinfoview.frame.size.height+_logistTableview.frame.size.height);
}

-(void)shouhuo:(UIButton*)sender
{
    if ( [self.heattitle.text isEqualToString: @"商家换货物流"]) {
         [self ShouhuoHttp:_orderModel.order_code withPwd:@""];
        return;
    }
    [self payPassWordView:_orderModel.order_code withOrderPrice:_orderModel.order_price];
    
    /*
    TFPayPasswordView *view = [[TFPayPasswordView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.money = [NSString stringWithFormat:@"%@元",_orderModel.order_price];

    [self.view addSubview:view];
//    [view returnPayResultSuccess:^(NSString *pwd) {
//        //密码验证成功");
//        [self ShouhuoHttp:self.dic[@"order_code"]];
//        //        [self performSelector:@selector(ShouhuoHttp:) withObject:self.dic[@"order_code"] afterDelay:1];
//    } withFail:^{
//        //密码验证失败");
//    }];
    
    [view returnPayResultSuccess:^(NSString *pwd) {
        
        //密码验证成功");
        [self ShouhuoHttp:_orderModel.order_code withPwd:pwd];
        
    } withFail:^(NSString *error){
        
//        [MBProgressHUD showError: error];
        

    } withTitle:@"请输入支付密码"];
    */


}
-(void)payPassWordView:(NSString *)ordercoder withOrderPrice:(NSString *)orderprice
{
    TFPayPasswordView *view = [[TFPayPasswordView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.money = [NSString stringWithFormat:@"%.2f",orderprice.floatValue];
    [self.view addSubview:view];
    
    
    [view returnPayResultSuccess:^(NSString *pwd) {
        
        //密码验证成功");
        //        [self ShouhuoHttp:ordercoder withPwd:pwd Index:0];
        [self ShouhuoHttp:ordercoder withPwd:pwd];
        
    } withFail:^(NSString *error){
        //                    [MBProgressHUD showError:error];
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"温馨提示" contentText:error leftButtonTitle:@"重新输入" rightButtonTitle:@"忘记密码"];
        [alert show];
        alert.leftBlock = ^() {
            //                        [self httpIsSetPwd];
            [self payPassWordView:ordercoder withOrderPrice:orderprice];
        };
        alert.rightBlock = ^() {
            TFChangePaymentPasswordViewController *tsvc= [[TFChangePaymentPasswordViewController alloc] init];
            [self.navigationController pushViewController:tsvc animated:YES];
            
        };
    } withTitle:@"请确认收货"];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopDetailModel *model=_logistDataArray[indexPath.row];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)]};
    CGSize textSize = [model.context boundingRectWithSize:CGSizeMake(kScreenWidth-ZOOM(80)*2, 100) options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return  textSize.height+35;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _logistDataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    logistTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"logistcell"];
    if(!cell)
    {
        cell=[[logistTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"logistcell"];
    }
    ShopDetailModel *model=_logistDataArray[indexPath.row];
    
    if (indexPath.row ==0) {
        cell.textlabel.textColor = tarbarrossred;
        cell.detail.textColor = tarbarrossred;
        cell.img.frame=CGRectMake(ZOOM(60)-5/2, cell.img.frame.origin.y, 25, 25);
        cell.img.image=[UIImage imageNamed:@"椭圆-23"];
    }
    else
    {
        cell.textlabel.textColor = kTextColor;
        cell.detail.textColor = kTextColor;
        cell.img.frame=CGRectMake(ZOOM(60), cell.img.frame.origin.y, 20, 20);
        cell.img.image=[UIImage imageNamed:@"椭圆"];
        
    }

    cell.textlabel.text=[NSString stringWithFormat:@"%@",model.context];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)]};
    CGSize textSize = [model.context boundingRectWithSize:CGSizeMake(kScreenWidth-ZOOM(80)*2, 100) options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    cell.textlabel.frame=CGRectMake(cell.textlabel.frame.origin.x, cell.textlabel.frame.origin.y, cell.textlabel.frame.size.width, textSize.height);
    cell.detail.frame=CGRectMake(cell.detail.frame.origin.x, CGRectGetMaxY(cell.textlabel.frame), cell.detail.frame.size.width, cell.detail.frame.size.height);
    cell.textlabel.font=[UIFont systemFontOfSize:ZOOM(40)];
    cell.detail.font=[UIFont systemFontOfSize:ZOOM(36)];
    cell.detail.text=[NSString stringWithFormat:@"%@",model.time];
    cell.img2.frame=CGRectMake(cell.img2.frame.origin.x, cell.img2.frame.origin.y, cell.img2.frame.size.width, 60);

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)back
{
//    [self.navigationController popViewControllerAnimated:YES];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[AftersaleViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }

}
@end
