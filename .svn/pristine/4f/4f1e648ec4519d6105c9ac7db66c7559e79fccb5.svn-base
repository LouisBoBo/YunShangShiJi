//
//  PaystyleViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/7/25.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "PaystyleViewController.h"
#import "GlobalTool.h"
#import "CircleTableViewCell.h"
#import "PayStyleTableViewCell.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "MyMD5.h"
#import "NavgationbarView.h"
#import "BuySuccessViewController.h"
#import "PayFailedViewController.h"
#import "TFPayPasswordView.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "payRequsestHandler.h"
#import "ShopDetailModel.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AppDelegate.h"
#import "DShareManager.h"
#import "UPPayPlugin.h"
#import "AppDelegate.h"

#import "TFChangePaymentPasswordViewController.h"
#import "MyOrderViewController.h"
#import "DXAlertView.h"
#import "TFSetPaymentPasswordViewController.h"
#import "OrderDetailViewController.h"
#import "OrderTableViewController.h"
#import "OrderTableViewController1.h"
#import "LoginViewController.h"
#import "TFMemberSuccessViewController.h"
#import "TFMemberShopStoreViewController.h"
#import "TFVoiceRedViewController.h"
#import "TFAlreadySendRedViewController.h"
#import "TFMemberCheckViewController.h"
#import "AffirmOrderViewController1.h"
#define KBtn_width        200
#define KBtn_height       80
#define KXOffSet          (self.view.frame.size.width - KBtn_width) / 2
#define KYOffSet          80

#define kVCTitle          @"TN测试"
#define kBtnFirstTitle    @"获取订单，开始测试"
#define kWaiting          @"正在获取TN,请稍后..."
#define kNote             @"提示"
#define kConfirm          @"确定"
#define kErrorNet         @"网络错误"
#define kResult           @"支付结果：%@"


#define kMode             @"01"
#define kConfigTnUrl      @"http://202.101.25.178:8080/sim/app.jsp?user=%@"
#define kNormalTnUrl      @"http://202.101.25.178:8080/sim/gettn"


@interface PaystyleViewController () <DShareManagerDelegate>
{
    UITableView *_mytableview;
    
    NSMutableArray *_DataArray;
    
    UILabel *_pricelable;
    
    UIButton *_oldBtn;
    
    NSString *_style;
    
    ShopDetailModel *_shopmodel;
    
    NSArray *imgArray;
    NSArray *titleArray;
    NSArray *payStyleArray;
    
    NSTimer *secondsTimer;
    int secondsTime;
}
@end

@implementation PaystyleViewController

+(BuySuccessViewController*)sharedManager
{
    static BuySuccessViewController *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[BuySuccessViewController alloc] init];
        assert(sharedManager != nil);
    });
    return sharedManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //监听支付通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Paystyle:) name:@"Paystyle" object:nil];
    //监听支付成功回调通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buysuccess:) name:@"buysuccess" object:nil];
    //监听支付失败回调通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyfail:) name:@"buyfail" object:nil];
    
    //设置支付密码成功监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setpasswordsuccess:) name:@"setpasswordsuccess" object:nil];
    
    
    _DataArray=[NSMutableArray array];

    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 64)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"支付方式";
    titlelable.font=[UIFont systemFontOfSize:ZOOM(57)];
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    for(ShopDetailModel *model in self.sortArray)//批量付款的如果有签到包邮的订单就不显示余额支付
    {
        if(model.shop_from.intValue==3)
        {
            self.p_type = @"5";
            self.shop_from = @"3";
        }else if (model.shop_from.intValue==4)
        {
            self.p_type = @"5";
            self.shop_from = @"4";
        }
        
    }
    
    if(self.shop_from.intValue == 3||self.shop_from.intValue==4)
    {
        self.p_type = @"5";
        
    }
    
    imgArray = self.p_type.integerValue==5 ? @[@"微信支付-1",@"支付宝支付"] : @[@"余额支付",@"微信支付-1",@"支付宝支付"];
    titleArray = self.p_type.integerValue==5 ? @[@"微信支付",@"支付宝支付"]:@[@"余额支付",@"微信支付",@"支付宝支付"];
    payStyleArray= self.p_type.integerValue==5 ? @[@"2",@"1"] : @[@"0",@"2",@"1"];
    _style=payStyleArray[0];

    
    [self creatView];
    
    if ([_order_code hasPrefix:@"G"]) {
        _urlcount=@"2";

    }else
        _urlcount=@"1";
    if (_urlcount.intValue==1&&_requestOrderDetail!=1) {
        [self OrderdetailHttp];
    }
    
    
    if (_lasttime!=nil) {
        [self httpGetNowTime];
    }
}
-(void)postNotification
{
    if (_requestOrderDetail==1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshOrder" object:nil];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
    
}
-(void)viewDidAppear:(BOOL)animated
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}


-(void)creatView
{
    _mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kApplicationWidth, kApplicationHeight-64+kUnderStatusBarStartY)];
    _mytableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    _mytableview.delegate=self;
    _mytableview.dataSource=self;
    _mytableview.rowHeight=50;
    [self.view addSubview:_mytableview];
    

    
    [_mytableview registerNib:[UINib nibWithNibName:@"PayStyleTableViewCell" bundle:nil] forCellReuseIdentifier:@"styleCell"];
    NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:0];
    [_mytableview selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
//    _style=@"1";
//    UIButton *btn = (UIButton *)[self.view viewWithTag:1001];
//    btn.selected = YES;
    
    UIView *footview=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 50)];
    footview.backgroundColor=[UIColor whiteColor];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 1)];
    line.backgroundColor = lineGreyColor;
    [footview addSubview:line];
    
    //付款
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(kApplicationWidth-80-ZOOM(62), 5, 80, 40);
    [button setTitle:@"付款" forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:ZOOM(50)];
//    button.layer.cornerRadius=5;
    button.tintColor=[UIColor whiteColor];
    [button setBackgroundColor:tarbarrossred];
    [button addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *pricelab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(62), 5, 50, 40)];
    pricelab.text = @"支付:";
    pricelab.font=[UIFont systemFontOfSize:ZOOM(50)];
    pricelab.textColor = tarbarrossred;
    [footview addSubview:pricelab];
    
    [self.view addSubview:footview];
    [footview addSubview:button];
    
    _pricelable=[[UILabel alloc]init];
    _pricelable.frame=CGRectMake(pricelab.frame.origin.x+pricelab.frame.size.width, 5, 150, 40);
    _pricelable.text = [NSString stringWithFormat:@"¥%.2f",self.price.floatValue] ;
    _pricelable.font=[UIFont systemFontOfSize:ZOOM(50)];
    _pricelable.textColor= tarbarrossred;
    _pricelable.textAlignment=NSTextAlignmentLeft;
    
    [footview addSubview:_pricelable];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return imgArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _style=payStyleArray[indexPath.row];
    for (int i=0; i<imgArray.count; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:i+1000];
        btn.selected = NO;
        if (i == indexPath.row) {
            btn.selected = YES;
        }
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PayStyleTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"styleCell"];
    if(!cell)
    {
        cell=[[PayStyleTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"styleCell"];
    }
    cell.headimge.image=[UIImage imageNamed:imgArray[indexPath.row]];
    cell.title.text=titleArray[indexPath.row];
    cell.selectBtn.selected = indexPath.row==0 ?YES : NO;
    
    
    cell.selectBtn.tag = indexPath.row+1000;
    
    return cell;
}



#pragma mark 获取订单详情数据
- (void)OrderdetailHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    url=[NSString stringWithFormat:@"%@order/getOrderDetial?version=%@&order_code=%@&token=%@",[NSObject baseURLStr],VERSION,self.order_code,token];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation]createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation]stopAnimationAt:self.view];
        
        MyLog(@"%@",responseObject);
        
        if (responseObject!=nil) {
            
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            NSDictionary *dic=responseObject[@"order"];
        
            if(statu.intValue==1)
            {
                ShopDetailModel *model=[[ShopDetailModel alloc]init];
                model.add_time=dic[@"add_time"];
                model.address=dic[@"address"];
                model.back=dic[@"back"];
                model.consignee=dic[@"consignee"];
                model.free=dic[@"free"];
                model.lasttime=dic[@"last_time"];
                model.user_id=dic[@"user_id"];
                model.order_pic=dic[@"order_pic"];
                model.phone=dic[@"phone"];
                model.message=dic[@"order_name"];
                model.status=dic[@"status"];
                model.order_code=dic[@"order_code"];
                model.order_name=dic[@"order_name"];
                model.order_price=dic[@"order_price"];
                model.shop_num=dic[@"shop_num"];
                model.address=dic[@"address"];
                model.consignee=dic[@"consignee"];
                model.phone=dic[@"phone"];
                model.logi_code=dic[@"logi_code"];
                model.logi_name=dic[@"logi_name"];
                model.change=dic[@"change"];
                model.suppid=dic[@"supp_id"];
                model.kickback=dic[@"kickBack"];
                
                model.bak=dic[@"bak"];
                model.shop_from=dic[@"shop_from"];
                model.postage=dic[@"postage"];
                model.postcode=dic[@"postcode"];
                
                model.local_time=[NSDate date];
                model.requestNow_time=responseObject[@"now"];
                
                NSArray *brr=responseObject[@"orderShops"];
                for(NSDictionary *dicc in brr)
                {
                    ShopDetailModel *shopmodel=[[ShopDetailModel alloc]init];
                    shopmodel.shop_color=dicc[@"color"];
                    shopmodel.ID=dicc[@"id"];
                    shopmodel.order_code=dicc[@"order_code"];
                    shopmodel.shop_code=dicc[@"shop_code"];
                    shopmodel.shop_name=dicc[@"shop_name"];
                    shopmodel.shop_num=dicc[@"shop_num"];
                    shopmodel.shop_pic=dicc[@"shop_pic"];
                    shopmodel.def_pic=dicc[@"shop_pic"];
                    shopmodel.shop_price=dicc[@"shop_price"];
                    model.shop_se_price=dic[@"shop_price"];
                    shopmodel.shop_size=dicc[@"size"];
                    shopmodel.supp_id=dicc[@"supp_id"];
                    
                    shopmodel.lasttime=dic[@"last_time"];
                    shopmodel.orderShopStatus=dicc[@"status"];
                    shopmodel.change=dicc[@"change"];
                    shopmodel.status=dic[@"status"];
                    
                    model.orderShopStatus=dicc[@"status"];
                    model.change=dicc[@"change"];
                    model.status=dic[@"status"];
                    
                    [model.shopsArray addObject:shopmodel];
                    
                    model.shop_code=shopmodel.shop_code;
                    
                }
                
                _shopmodel=model;
                
                
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
                
//                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
//                [mentionview showLable:message Controller:self];
            }
            
           
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation]stopAnimationAt:self.view];
        
    }];


}
#pragma mark 验证是否设置了支付密码
-(void)setPwdHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    url=[NSString stringWithFormat:@"%@wallet/ckSetPwd?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation]createAnimationAt:self.view];

    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation]stopAnimationAt:self.view];

        //
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            if(statu.intValue==1)//验证成功用我的钱包支付
            {
                //            [self walletPayHttp];
                
            }else{//验证失败提醒用户设置支付密码
                
                UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"" message:@"你还没有设置钱包支付密码，是否设置？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"YES", nil];
                [alter show];
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation]stopAnimationAt:self.view];

    }];
    
}







//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [alter show];
    
}

- (void)showAlertWait
{
    mAlert = [[UIAlertView alloc] initWithTitle:kWaiting message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [mAlert show];
    UIActivityIndicatorView* aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    aiv.center = CGPointMake(mAlert.frame.size.width / 2.0f - 15, mAlert.frame.size.height / 2.0f + 10 );
    [aiv startAnimating];
    [mAlert addSubview:aiv];
    
}

- (void)showAlertMessage:(NSString*)msg
{
    mAlert = [[UIAlertView alloc] initWithTitle:kNote message:msg delegate:nil cancelButtonTitle:kConfirm otherButtonTitles:nil, nil];
    [mAlert show];
    
}
- (void)hideAlert
{
    if (mAlert != nil)
    {
        [mAlert dismissWithClickedButtonIndex:0 animated:YES];
        mAlert = nil;
    }
}



-(void)back
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"buyfail" object:nil];

    if ([self.fromType isEqualToString:@"我要发红包"]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
//    BOOL bl = NO;
        NSArray *viewControllers = self.navigationController.viewControllers;
        for (int i = 1; i<viewControllers.count; i++) {

            UIViewController *viewController = viewControllers[i];
            if ([viewController isKindOfClass:[self class]]) {
                if ([viewControllers[i-1] isKindOfClass:[MyOrderViewController class]]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
            }
            if ([viewController isKindOfClass:[self class]]) {
                if ([viewControllers[i-1] isKindOfClass:[OrderDetailViewController class]]) {
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
            }
            
        }
        
        if (_urlcount.intValue==1&&_requestOrderDetail!=1) {
            OrderDetailViewController *order=[[OrderDetailViewController alloc]init];
            order.orderModel= _shopmodel;
            [self.navigationController pushViewController:order animated:YES];
        } else{
            MyOrderViewController *myorder=[[MyOrderViewController alloc]init];
            myorder.status1=[NSString stringWithFormat:@"1"];
            myorder.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:myorder animated:YES];
           
        }
    }
    
//    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)httpGetNowTime
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSString *url=[NSString stringWithFormat:@"%@order/getNow?version=%@&token=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]];
    NSString *URL=[MyMD5 authkey:url];
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        if (responseObject!=nil) {
            NSString *message=responseObject[@"message"];
            if([responseObject[@"status"]intValue]==1) {
         
                secondsTime=[_lasttime doubleValue]/1000-[responseObject[@"now"] doubleValue]/1000;
                secondsTimer=[NSTimer weakTimerWithTimeInterval:1.0 target:self selector:@selector(timerMethod:) userInfo:nil repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:secondsTimer forMode:UITrackingRunLoopMode];
            }else{
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [self httpGetNowTime];
    }];
    
    
}
- (void)timerMethod:(NSTimer*)theTimer
{
    if (secondsTime <= 0) {
        [secondsTimer invalidate];
   
    }else{
        
        secondsTime--;
    }
}
- (void)pay
{
     if (secondsTime <= 0&&_lasttime!=nil) {
         [self showHint:@"您已错过付款时间"];
         return;
    }
    [MobClick event:SHOP_PAY];
    
    NSUserDefaults *userdefaul =[NSUserDefaults standardUserDefaults];
    [userdefaul setObject:[NSString stringWithFormat:@"%@",self.price] forKey:PAY_PRICE];
    
    if(_style.intValue==0){//自己的钱包来支付--支付前验证改用户是否设置了支付密码
        [self httpIsSetPwd];
    }else if (_style.intValue==2) {//微信支付
        if ([self.fromType isEqualToString:@"我要发红包"]) {
            [self httpRedPacketWeixin];
        } else {
            [self WeixinHttp];
        }
    }else if (_style.intValue==1) {//支付宝支付
        [self payorder];
    }

    
    
}
#pragma mark - 在使用微信和支付宝支付成功后.调此接口,表示已经支付成功
-(void)httpPayResurt
{
    NSString *url;
    
     if (_urlcount.intValue>=2) {
         url=[NSString stringWithFormat:@"%@order/updatePayStatusList?version=%@&token=%@&gcode=%@&buy_type=%@",[NSObject baseURLStr_Pay],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],_order_code,_style];
     }else
         url=[NSString stringWithFormat:@"%@order/updatePayStatus?version=%@&token=%@&order_code=%@&buy_type=%@",[NSObject baseURLStr_Pay],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],_order_code,_style];
    
    NSString *URL=[MyMD5 authkey:url];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject!=nil) {
            //responseObject = %@   %@", responseObject,responseObject[@"message"]);
     
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(void)httpGetPayCode
{
//    NSString *url;
    
//    NSString *pay_type;//1支付宝2微信
//    if ([_style isEqualToString:@"2"]) {//0余额支付,2微信支付,1支付宝支付,
//        pay_type=@"2";
//    }else if ([_style isEqualToString:@"3"])
//        pay_type=@"1";
    
    [[NSUserDefaults standardUserDefaults ]setObject:_style forKey:PAY_TYPE];
    [[NSUserDefaults standardUserDefaults ]setObject:_order_code forKey:PAY_ORDERCODE];
    [[NSUserDefaults standardUserDefaults ]setObject:_urlcount forKey:PAY_NUM];
    /*
    if (_urlcount.intValue>=2) {
        url=[NSString stringWithFormat:@"%@treasures/getPayCodeList?version=%@&token=%@&g_code=%@&pay_type=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],_order_code,pay_type];
    }else
        url=[NSString stringWithFormat:@"%@treasures/getPayCode?version=%@&token=%@&order_code=%@&pay_type=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],_order_code,pay_type];
    
    NSString *URL=[MyMD5 authkey:url];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject!=nil) {
           MyLog(@"responseObject = %@   %@", responseObject,responseObject[@"message"]);
            
//            [[NSUserDefaults standardUserDefaults ]setObject:responseObject[@"data"] forKey:PAY_CODE];
            
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    */
}
#pragma mark 支付成功回调
-(void)buysuccess:(NSNotification*)note
{
    [self postNotification];
    if ([self.fromType isEqualToString:@"我要发红包"]) {
        [self httpThirdPartyPayToRedCallback];
    } else {
    
        if(self.shop_from.intValue == 2)
        {
            NSString *ismember = @"2";
            [[NSUserDefaults standardUserDefaults] setObject:ismember forKey:USER_MEMBER];
            [MyMD5 changeMemberPriceRate];
            TFMemberSuccessViewController *member = [[TFMemberSuccessViewController alloc]init];
            [self.navigationController pushViewController:member animated:YES];
            return;
            
        }
        else{
            
            [self httpPayResurt];
            if (self.shop_from.intValue==4) {
                [self httpGetPayCode];
            }
            
            BuySuccessViewController *successpay=[[BuySuccessViewController alloc]init];
            successpay.shopprice=_price;
            successpay.shopArray=self.sortArray;
            successpay.orderCode = self.order_code;
            successpay.p_type = self.p_type;
            successpay.shop_from = self.shop_from;
            [self.navigationController pushViewController:successpay animated:YES];
            
        }

    }
    
    
    
}
-(void)judgeOrderCount
{
    NSArray *viewControllers = self.navigationController.viewControllers;
    for (int i = 1; i<viewControllers.count; i++) {
        
        UIViewController *viewController = viewControllers[i];
        if ([viewController isKindOfClass:[self class]]) {
            if ([viewControllers[i-1] isKindOfClass:[MyOrderViewController class]]) {
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
        }
        if ([viewController isKindOfClass:[self class]]) {
            if ([viewControllers[i-1] isKindOfClass:[OrderDetailViewController class]]) {
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
        }
        
    }
    if (_urlcount.intValue==1&&_requestOrderDetail!=1) {
        OrderDetailViewController *order=[[OrderDetailViewController alloc]init];
        order.orderModel= _shopmodel;
        [self.navigationController pushViewController:order animated:YES];
    } else{
        MyOrderViewController *myorder=[[MyOrderViewController alloc]init];
        myorder.status1=[NSString stringWithFormat:@"1"];
        myorder.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:myorder animated:YES];
    }
}
- (void)buyfail:(NSNotification*)note
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"buyfail" object:nil];

    //-------------");
    if ([self.fromType isEqualToString:@"我要发红包"]) {
        [self httpThirdPartyPayToRedFail];
    } else {
        
        
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[AffirmOrderViewController class]]||[controller isKindOfClass:[AffirmOrderViewController1 class]]) {
                
                [self judgeOrderCount];
                return;
                
            }else if ([controller isKindOfClass:[OrderTableViewController class]]||[controller isKindOfClass:[OrderTableViewController1 class]]){
                [self judgeOrderCount];
                return;
                
            }else if ([controller isKindOfClass:[TFMemberShopStoreViewController class]])
            {
                [self.navigationController popToViewController:controller animated:YES];
                return;
            }
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }
    
    

}
/*
#pragma mark 支付结果回调
-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                //支付成功－PaySuccess，retcode = %d", resp.errCode);
                
                
//                [self gotobuySuccess];
                
                
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                //错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
    
    
}

*/




/**
 *  |-----------------------------------------------------------|
 *  |                                                           |
 *  |                     支付跳转修改                            |
 *  |                                                           |
 *  |-----------------------------------------------------------|
 */
/*
-(void)Paystyle:(NSNotification*)note
{
    
    NSDictionary *dic = note.userInfo;
    
    NSString *style=[dic objectForKey:@"style"];
//    _orderPrice = [dic objectForKey:@"money"];
    
    if(style.intValue==0)//自己的钱包来支付--支付前验证改用户是否设置了支付密码
    {
        
        [self httpIsSetPwd];
        
        
    }else if (style.intValue==2)//微信支付
    {
        if ([self.fromType isEqualToString:@"我要发红包"]) {
            [self httpRedPacketWeixin];
        } else {
             [self WeixinHttp];
        }

        
    }else if (style.intValue==1)//支付宝支付
    {
        [self payorder];
    }
}
*/
#pragma mark 设置支付密码成功
-(void)setpasswordsuccess:(NSNotification*)note
{
    TFPayPasswordView *view = [[TFPayPasswordView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [view.pwdField becomeFirstResponder];

    view.money = [NSString stringWithFormat:@"%.2f",_price.floatValue];
    [self.view addSubview:view];
    [view returnPayResultSuccess:^(NSString *pwd) {
        //密码验证成功");
        
        if ([self.fromType isEqualToString:@"我要发红包"]) {
            [self httpMyWalletPayToRed:pwd];
        } else {
            [self walletPayHttp:pwd];
        }
        
    } withFail:^(NSString *error){
        
//        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
//        [mentionview showLable:error Controller:self];
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"温馨提示" contentText:error leftButtonTitle:@"重新输入" rightButtonTitle:@"忘记密码"];
        [alert show];
        alert.leftBlock = ^() {
            [self httpIsSetPwd];
        };
        alert.rightBlock = ^() {
            TFChangePaymentPasswordViewController *tsvc= [[TFChangePaymentPasswordViewController alloc] init];
            [self.navigationController pushViewController:tsvc animated:YES];
            
        };
    } withTitle:@"请输入支付密码"];
    
//    view.dismissBlock = ^(){
//        [self back];
//    };
}

#pragma mark 检查是否设置过支付密码
- (void)httpIsSetPwd
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/ckSetPwd?token=%@&version=%@",[NSObject baseURLStr],token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    

    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];

        
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                
                if ([responseObject[@"flag"] intValue] == 1) { //没设置
                    
                    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"温馨提示" contentText:@"亲，你还没有设置支付密码请设置!" leftButtonTitle:@"取消" rightButtonTitle:@"确认"];
                    [alert show];
                    alert.leftBlock = ^() {
                        //left button clicked");//取消
                    };
                    alert.rightBlock = ^() {
                        //right button clicked");//确认
                        
                        //进入设置支付密码页面
                        TFSetPaymentPasswordViewController *tsvc= [[TFSetPaymentPasswordViewController alloc] init];
                        [self.navigationController pushViewController:tsvc animated:YES];
                        
                    };
                    alert.dismissBlock = ^() {
                        //Do something interesting after dismiss block");
                    };
                    
                    
                    
                } else if ([responseObject[@"flag"] intValue] == 2) { //设置过了
                    
//                    //++++++++++++++");
                    
                    TFPayPasswordView *view = [[TFPayPasswordView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                    [view.pwdField becomeFirstResponder];
                    view.money = [NSString stringWithFormat:@"%.2f",_price.floatValue];
                    [self.view addSubview:view];
                    
                    [view returnPayResultSuccess:^(NSString *pwd) {
                        //密码验证成功");
                        
                        if ([self.fromType isEqualToString:@"我要发红包"]) {
                            [self httpMyWalletPayToRed:pwd];
                        } else {
                            [self walletPayHttp:pwd];
                        }
                    } withFail:^(NSString *error){
                        
//                        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
//                        [mentionview showLable:error Controller:self];
                        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"温馨提示" contentText:error leftButtonTitle:@"重新输入" rightButtonTitle:@"忘记密码"];
                        [alert show];
                        alert.leftBlock = ^() {
                            [self httpIsSetPwd];
                        };
                        alert.rightBlock = ^() {
                            TFChangePaymentPasswordViewController *tsvc= [[TFChangePaymentPasswordViewController alloc] init];
                            [self.navigationController pushViewController:tsvc animated:YES];
                            
                        };
                    } withTitle:@"请输入支付密码"];
                    

                    
                }
                
                
                
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
}
#pragma mark 用自己的钱包支付
-(void)walletPayHttp:(NSString *)pwd
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSString *Password=[MyMD5 md5:pwd];
    
    if(_urlcount.intValue==1)
    {
        url=[NSString stringWithFormat:@"%@order/walletPayOrder?version=%@&order_code=%@&token=%@&pwd=%@",[NSObject baseURLStr],VERSION,self.order_code,token,Password];
    }else if (_urlcount.intValue>=2)
    {
        
        url=[NSString stringWithFormat:@"%@order/walletPayOrderList?version=%@&g_code=%@&token=%@&pwd=%@",[NSObject baseURLStr],VERSION,self.order_code,token,Password];
        
    }
    
    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [[Animation shareAnimation]createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation]stopAnimationAt:self.view];
        
        //responseObject walletPayOrderList is %@",responseObject);
        MyLog(@"shop_from = %@",_shopmodel.shop_from);
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *pwdflag=responseObject[@"pwdflag"];
            NSString *message=responseObject[@"message"];
            if(pwdflag.intValue==0&&statu.intValue==1)//请求成功
            {
                message=@"恭喜你，支付成功！";
                [self postNotification];
                if(self.shop_from.intValue == 2)
                {
                    NSString *ismember = @"2";
                    [[NSUserDefaults standardUserDefaults] setObject:ismember forKey:USER_MEMBER];
                    [MyMD5 changeMemberPriceRate];
                    TFMemberSuccessViewController *member = [[TFMemberSuccessViewController alloc]init];
                    [self.navigationController pushViewController:member animated:YES];
                    
                    return ;
                }else{

                    BuySuccessViewController *successpay=[[BuySuccessViewController alloc]init];
                    successpay.shopprice=_price;
                    successpay.shopArray=self.sortArray;
                    successpay.orderCode = self.order_code;
                    successpay.p_type = self.p_type;
                    successpay.shop_from = self.shop_from;
                    
                    [self.navigationController pushViewController:successpay animated:YES];
                }
                
            }
            else{
                if (pwdflag.intValue==1){
                    message=pwdflagString1;
                }else if (pwdflag.intValue==2){
                    message=pwdflagString2;
                }else if (pwdflag.intValue==3){
                    message=pwdflagString3;
                }
                [[Animation shareAnimation]stopAnimationAt:self.view];
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
                
                
                [NSTimer weakTimerWithTimeInterval:3 target:self selector:@selector(toback) userInfo:nil repeats:NO];
                
            }
            
        }
    
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation]stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
    }];
}

- (void)toback
{
    MyLog(@"钱包支付失败");
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[AffirmOrderViewController class]]||[controller isKindOfClass:[AffirmOrderViewController1 class]]) {
            
            [self judgeOrderCount];
            return;
            
        }else if ([controller isKindOfClass:[OrderTableViewController class]]||[controller isKindOfClass:[OrderTableViewController1 class]]){
            [self judgeOrderCount];
            return;
            
        }else if ([controller isKindOfClass:[TFMemberShopStoreViewController class]])
        {
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    

}
#pragma mark 网络请求获取微信支付prepay_id
-(void)WeixinHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    if(_urlcount.intValue >1)
    {
        url=[NSString stringWithFormat:@"%@wxpay/appUinifiedOrderList?version=%@&order_code=%@&token=%@&order_name=%@",[NSObject baseURLStr_Pay],VERSION,self.order_code,token,@"我的"];
    }else{
        url=[NSString stringWithFormat:@"%@wxpay/appUinifiedOrder?version=%@&order_code=%@&token=%@&order_name=%@",[NSObject baseURLStr_Pay],VERSION,self.order_code,token,@"我的"];
        
    }
    //    url=[NSString stringWithFormat:@"%@wxpay/uinifiedOrder?version=V1.0&order_code=%@&token=%@&order_name=%@",[NSObject baseURLStr],self.order_code,token,@"我的"];
    
    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation]createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation]stopAnimationAt:self.view];
        
        //
        
        if (responseObject!=nil) {
            
            NSMutableDictionary *dic=responseObject[@"xml"];
            
            if(dic)
            {
                [self Winpay:dic Orderno:self.order_code];
            }

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation]stopAnimationAt:self.view];
    }];
    
}
#pragma mark 微信支付++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//微信支付
-(void)Winpay:(NSMutableDictionary*)dic Orderno:(NSString*)orderno
{
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app weixinArgumentHttp];
    
    //pay");
    
    //{{{
    //本实例只是演示签名过程， 请将该过程在商户服务器上实现
    
    //创建支付签名对象
    payRequsestHandler *req = [payRequsestHandler alloc] ;
    //初始化支付签名对象
    
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    
    NSString *appid = [userdefaul objectForKey:APP_ID];
    NSString *mchid = [userdefaul objectForKey:MCH_ID];
    
    MyLog(@"appid=%@ mchid=%@",appid,mchid);
    
    [req init:[userdefaul objectForKey:APP_ID] mch_id:[userdefaul objectForKey:MCH_ID]];
    //设置密钥
    [req setKey:[userdefaul objectForKey:PARTNER_ID]];

    
    //}}}

    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay_demo :dic :orderno];
    
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
        [self alert:@"提示信息" msg:debug];
        
        
        //%@\n\n",debug);
    }else{
        //%@\n\n",[req getDebugifo]);
        //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        [WXApi sendReq:req];
    }
    
}
#pragma mark 支付宝支付
-(void)payorder
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [app zhifubaoArgumentHttp:self.order_code];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSString *partner = [ud objectForKey:PAY_PARTNER];
    NSString *seller = [ud objectForKey:PAY_SELLER];
    NSString *privateKey = [ud objectForKey:PAY_PRIVATE_KEY];
    NSString *payurl = [ud objectForKey:PAY_URL];
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
#if 0
    NSString *partner = @"2088911598493391";
    NSString *seller = @"yssj@91kwd.com";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAL7stj/CKUfmbQPogHn9DZtEuxLwSAy9FHsao0USmqRrbvAkMg+DMMhh9dSqHUCuN1DExbgAvhHto9jnsznh27vcFfMikdaGBZqUB1Te4I3fMhirbeSPdbGVE7AMOqvJq/girZDhJ6ieMQXC5+YuUQQT+ovzKvkNUjpvkKKl+a7ZAgMBAAECgYAvbK8MgVcts/AKU3tuUcxKcDUjzCmpeGIY/hHmO2vMQZ9p6SPCNK0uaR7eN29SvLOizW3recu8ulHDtDIRw6eHwT8YbRDwd9qBW58GnL1d8PfC6uw+/7f+YoHTkqrNIZvD1adDJJjyX9NSH662xyITuzpaL5NXbpYKYn8IVKWOvQJBAO++V2djL3pxH67L583EAdlGV39JzP21oMxCRqRCuVTS0DjcRjg/lG4cEW69t3sIN+V2+8pnULBBmO5xP1o41XsCQQDL3u8PPxvoIm7xHWLZSQpLv4EILG2O94ddXETmGWIeZ8AVzRCKHTN0ShOvmNZnCEbelBWb/pkIM4LYrVzqkdq7AkAQ+yhxuELKp2yZEvROTM3ct/DGoVGVvuGu1hru05MRAQWioWeP4GEBE5fggiuW2VQsOqtHAN5kPaE5cmgMWe41AkEAxhtIKoSk1ZpAPETV/VcgjiL1e7/QZpDaFTrIKOCZm/otigHPBKcDjQk+v+/AyDYex8MWjJOGmZWUnIE6PSamaQJBAKDxW+KJN3ihQx8NwU/wKKuPZe4hhtZNJ39VhzLUwhoYdrPXipoPT8qHnlVz73WSPesizGvGHTBLZWyeZy6iahI=";
#endif
    
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 || [seller length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    //    ShopDetailModel *model=self.shopmodel;
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    //    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.tradeNO =[NSString stringWithFormat:@"%@",self.order_code];
    //    order.productName = model.content; //商品标题
    //    order.productDescription = model.shop_name; //商品描述
    //    NSString* shop_price=@"0.01";
    
    if(! _price)
    {
        _price=@"0";
    }
    
    order.amount = [NSString stringWithFormat:@"%.2f",[_price floatValue]]; //商品价格
    
    order.productName = @"云商世纪"; //商品标题
    order.productDescription = @"云商世纪"; //商品描述
    //    order.notifyURL =  @"http://183.61.166.16:9090/cloud-api/alipay/appNotify "; //回调URL
    
    if ([self.fromType isEqualToString:@"我要发红包"]) {
        order.notifyURL = [NSString stringWithFormat:@"%@alipay/appNotifyHb",payurl];
        
    } else {
        
        if(_urlcount.intValue > 1)
        {
            
            order.notifyURL = [NSString stringWithFormat:@"%@alipay/appNotifyList",payurl];
        }else{
            
            order.notifyURL = [NSString stringWithFormat:@"%@alipay/appNotify",payurl];
        }

        
        
        
    }
    
    
    
    
    //    order.notifyURL = [NSString stringWithFormat:@"%@alipay/appNotify",[NSObject baseURLStr]];
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"YunShangShiJi";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    //orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            //reslut = %@",resultDic);
        }];
    }
}

#pragma mark - ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#pragma mark - 用自己余额付款红包
- (void)httpMyWalletPayToRed:(NSString *)pwd
{
    //http://{ip:port}/{proeject}/
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *ppwd = [MyMD5 md5:pwd];
    NSString *urlStr = [NSString stringWithFormat:@"%@redPacket/walletPay?token=%@&version=%@&rp_id=%@&pwd=%@",[NSObject baseURLStr],token,VERSION,self.order_code,ppwd];
    NSString *URL = [MyMD5 authkey:urlStr];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //余额支付红包 = %@", responseObject);
        
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                
                
                for (UIViewController *viewController in self.navigationController.viewControllers) {
                    if ([viewController isKindOfClass:[TFVoiceRedViewController class]]) {
                        [self.navigationController popToViewController:viewController animated:YES];
                    }
                }
                
//                [self.navigationController popViewControllerAnimated:YES];
                
                [self httpGetRedPacketShareLink];
                
            } else {
                NavgationbarView *nv = [[NavgationbarView alloc] init];
                [nv showLable:responseObject[@"message"] Controller:self];
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - 微信支付
- (void)httpRedPacketWeixin
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    

    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *url = [NSString stringWithFormat:@"%@wxpay/uinifiedHd?token=%@&hcode=%@&version=%@",[NSObject baseURLStr_Pay], token, self.order_code, VERSION];
    
    NSString *URL=[MyMD5 authkey:url];

    [[Animation shareAnimation]createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation]stopAnimationAt:self.view];
        //红包微信支付 = %@",responseObject);
        
        if (responseObject!=nil) {
            NSMutableDictionary *dic=responseObject[@"xml"];
            if(dic) {
                [self Winpay:dic Orderno:self.order_code];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation]stopAnimationAt:self.view];
    }];
}

#pragma mark - 第三方红包支付成功回调后台
//支付成功
- (void)httpThirdPartyPayToRedCallback
{
    for (UIViewController *viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[TFVoiceRedViewController class]]) {
            [self.navigationController popToViewController:viewController animated:YES];
        }
    }
    
    [self httpGetRedPacketShareLink];
}

//支付失败
- (void)httpThirdPartyPayToRedFail
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    [nv showLable:@"红包支付失败" Controller:self];
}

#pragma mark - 获取红包分享链接
- (void)httpGetRedPacketShareLink
{
    //http://{ip:port}/{proeject}/
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@redPacket/getShareRedPacketLink?token=%@&version=%@&rp_id=%@",[NSObject baseURLStr],token,VERSION,self.order_code];
    NSString *URL = [MyMD5 authkey:urlStr];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //红包分享链接 = %@", responseObject);
        
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate shardk];
                
                DShareManager *ds   = [DShareManager share];
                ds.delegate         = self;
                
                NSString *link = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"link"]];
                NSString *title = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"name"]];
                NSString *content   = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"content"]];
                NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"red_packet" ofType:@"png"];
                [ds shareAppWithType:ShareTypeWeixiSession withLinkShareType:@"我要发红包" withLink:link andImagePath:imagePath andTitle:title andContent:content];
            } else {
                NavgationbarView *nv = [[NavgationbarView alloc] init];
                [nv showLable:responseObject[@"message"] Controller:self];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)DShareManagerStatus:(SHARESTATE)shareStatus withType:(NSString *)type
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    if ([type isEqualToString:@"我要发红包"]) {

        if (shareStatus == STATE_SUCCESS) {
            [nv showLable:@"分享成功" Controller:self];
            
            for (UIViewController *viewController in self.navigationController.viewControllers) {
                if ([viewController isKindOfClass:[TFVoiceRedViewController class]]) {
                    [self.navigationController popToViewController:viewController animated:YES];
                }
            }
            
        } else if (shareStatus == STATE_FAILED) {
            
            [nv showLable:@"分享失败" Controller:self];
        } else if (shareStatus == STATE_CANCEL) {
            
//            [nv showLable:@"分享取消" Controller:self];
        }
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
