//
//  OrderDetailViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/27.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//
#import "IndianaDetailViewController.h"
#import "OrderDetailViewController.h"
#import "OrderDetailTableViewCell.h"
#import "OrderDetailModel.h"
#import "GoodsDetailViewController.h"
#import "ShopDetailViewController.h"
#import "SpecialShopDetailViewController.h"
#import "LogisticsViewController.h"
#import "MoneyGoViewController.h"
#import "EvaluateViewController.h"
#import "RefundAndReturnViewController.h"
#import "TFEvaluationOrderViewController.h"
#import "TFAdditionalEvaluationViewController.h"
#import "OrderTableViewCell.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "NavgationbarView.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AppDelegate.h"
#import "DShareManager.h"
#import "UPPayPlugin.h"
#import "Order.h"
#import "DataSigner.h"
//#import "PaystyleViewController.h"
#import "TFPayStyleViewController.h"
#import "DXAlertView.h"
//#import "ChatViewController.h"
#import "RobotManager.h"
#import "TFPayPasswordView.h"
//#import "ChatListViewController.h"
#import "payRequsestHandler.h"
#import "TFChangePaymentPasswordViewController.h"

#import "BuySuccessViewController.h"
#import "PayFailedViewController.h"
#import "IntelligenceViewController.h"
#import "TFSetPaymentPasswordViewController.h"
#import "ShopDetailViewController.h"

#import "NewShoppingCartViewController.h"
#import "MyOrderViewController.h"
//#import "ComboShopDetailViewController.h"
#import "TFNoviceTaskView.h"
#import "TFDailyTaskView.h"
#import "LoginViewController.h"
#import "GroupBuyDetailVC.h"
#import "OneLuckdrawViewController.h"
#import "FinishTaskPopview.h"
#import "MakeMoneyViewController.h"
#import "ContactKefuViewController.h"
@interface OrderDetailViewController ()<AfterslaeDelegate,UIAlertViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
//整个界面滑动视图
@property (weak, nonatomic) IBOutlet UIScrollView *Myscrollview;
//联系卖家
@property (weak, nonatomic) IBOutlet UIButton *servicebtn;
//拨打电话
@property (weak, nonatomic) IBOutlet UIButton *phonebtn;
//商品列表
@property (weak, nonatomic) IBOutlet UIView *ShopView;
//订单头
@property (weak, nonatomic) IBOutlet UIView *HeadView;
//买家信息
@property (weak, nonatomic) IBOutlet UIView *InfoView;
//订单信息
@property (weak, nonatomic) IBOutlet UIView *OrderView;
//订单费用
@property (weak, nonatomic) IBOutlet UILabel *Orderfee;
//运费
@property (weak, nonatomic) IBOutlet UILabel *Yunfee;
//店铺名
@property (weak, nonatomic) IBOutlet UILabel *Storename;
//运费
@property (weak, nonatomic) IBOutlet UILabel *freight;
//实付金额
@property (weak, nonatomic) IBOutlet UILabel *Payfee;
//下单时间
@property (weak, nonatomic) IBOutlet UILabel *ordertime;
//卖家名字
@property (weak, nonatomic) IBOutlet UILabel *Sellname;
//订单号
@property (weak, nonatomic) IBOutlet UILabel *Ordercode;
//支付单号
@property (weak, nonatomic) IBOutlet UILabel *Paycode;
//交易时间
//@property (weak, nonatomic) IBOutlet UILabel *Paytime;
@property (weak, nonatomic) IBOutlet UILabel *Consignee;
@property (weak, nonatomic) IBOutlet UILabel *Phone;
@property (weak, nonatomic) IBOutlet UILabel *Address;
@property (weak, nonatomic) IBOutlet UIImageView *addressImg;

@property (weak, nonatomic) IBOutlet UILabel *shoujianren;
@property (weak, nonatomic) IBOutlet UILabel *yunfei;
@property (weak, nonatomic) IBOutlet UILabel *shifufei;

@property (strong, nonatomic)  UIPickerView *myPicker;
@property (strong, nonatomic)  UIView *pickerBgView;
@property (strong, nonatomic) UIView *maskView;

@property (nonatomic, strong)UIImageView *animationView;
@property (nonatomic, strong)FinishTaskPopview *bonusview;



@end

@implementation OrderDetailViewController
{
    //商品列表
    UITableView *_ShopTableView;
    //商品列表数据源
//    NSMutableArray *_ShopArray;
    
//    OrderDetailModel *_Orderdetailmodel;
    
    ShopDetailModel *_logisticsModel;
    NSMutableArray *_logisticsArray;

    long indextag;

    UILabel *_timelab;
    UILabel *_addresslab;
    
    NSArray *pickerArray;
    
    UILabel *payTime;
    UILabel *payTimeTitle;
    UIButton *button1;
    UIButton *button2;
    
    int secondsTime;
    NSTimer *secondsTimer;
    
    NSString *phoneNum;       //电话号码
}
-(void)dealloc
{
    [secondsTimer invalidate];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    phoneNum = @"4008884224";
    
    _logisticsArray=[NSMutableArray array];
    
    pickerArray = [NSArray arrayWithObjects:@"卖家缺货",@"信息填写错误，重新拍",@"我不想买了",@"同城见面交易",@"拍错了",@"其它原因", nil];
    [self creatPickerView];

    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    headview.backgroundColor=[UIColor whiteColor];
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(toBack) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"订单详情";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
//    UIButton *searchbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    searchbtn.frame=CGRectMake(kApplicationWidth - 40, 30, 25, 25);
//    searchbtn.tintColor=[UIColor blackColor];
//    [searchbtn setImage:[UIImage imageNamed:@"设置"]  forState:UIControlStateNormal];
//    searchbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [searchbtn addTarget:self action:@selector(toMessage:) forControlEvents:UIControlEventTouchUpInside];
//    [headview addSubview:searchbtn];
    
    
    //获得所有DB中未读消息数量
//    NSInteger unReadMessageCount=[[EaseMob sharedInstance].chatManager loadTotalUnreadMessagesCountFromDatabase];
//    
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

    //滑动视图
//    self.Myscrollview.contentSize=CGSizeMake(0, kApplicationHeight*2);
    self.Myscrollview.pagingEnabled=NO;
    
    
//    [self httpPhone];
    
//    [self requestHttp];

    if (![self.orderModel.logi_code isEqual:[NSNull null]]&&self.orderModel.logi_code.length!=0) {
        [self GetlogHttp:self.orderModel.logi_code :self.orderModel.logi_name];
    }
    
    //创建视图
    [self creatView];
    
    self.statue.font =[UIFont systemFontOfSize:ZOOM(50)];
    self.Orderfee.font =[UIFont systemFontOfSize:ZOOM(46)];
    self.Yunfee.font = [UIFont systemFontOfSize:ZOOM(46)];
    self.ordertime.font =[UIFont systemFontOfSize:ZOOM(46)];
    self.shoujianren.font =[UIFont systemFontOfSize:ZOOM(50)];
    self.Phone.font=[UIFont systemFontOfSize:ZOOM(50)];
    self.Consignee.font = [UIFont systemFontOfSize:ZOOM(50)];
    self.Address.font = [UIFont systemFontOfSize:ZOOM(46)];
    self.yunfei.font = [UIFont systemFontOfSize:ZOOM(46)];
    self.shifufei.font = [UIFont systemFontOfSize:ZOOM(46)];
    self.freight.font = [UIFont systemFontOfSize:ZOOM(46)];
    self.Payfee.font =[UIFont systemFontOfSize:ZOOM(46)];
    

    //如果是普通订单支付成功 弹支付成功框
    if(self.comefromPaySuccess && self.orderModel != nil)
    {
        if(self.orderModel.shopsArray.count)
        {
            ShopDetailModel *model = self.orderModel.shopsArray[0];
            NSString *shop_price = model.shop_price;
            [self setTaskPopMindView:OrderDetail_paySuccess Value:shop_price Title:nil Rewardvalue:nil Rewardnum:0];
        }
    }
}

- (void)setTaskPopMindView:(TaskPopType)type Value:(NSString*)value Title:(NSString*)title Rewardvalue:(NSString*)rewardValue Rewardnum:(int)num
{
    if(self.bonusview)
    {
        [self.bonusview removeFromSuperview];
        self.bonusview = nil;
    }
    
    self.bonusview = [[FinishTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) TaskType:type TaskValue:value Title:title RewardValue:rewardValue RewardNumber:num Rewardtype:nil];
    
    kSelfWeak;
    self.bonusview.tapHideMindBlock = ^{
        
        [weakSelf.bonusview remindViewHiden];
    };
    
    self.bonusview.leftHideMindBlock = ^(NSString *title) {
        if(type == OrderDetail_paySuccess)
        {
            MakeMoneyViewController *vc = [[MakeMoneyViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
    self.bonusview.balanceHideMindBlock = ^(NSInteger tag){
        [weakSelf.bonusview remindViewHiden];
    };
    
    [self.view addSubview:self.bonusview];
}
#pragma mark 信息
-(void)toMessage:(UIButton*)sender
{
    // begin 赵官林 2016.5.26 跳转到消息列表
    [self presentChatList];
    // end
}



- (void)sharetishi
{
    //配置分享平台信息
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app shardk];
    
    [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:nil WithShareType:@"index"];
}


-(void)startactive
{
    UIImageView *shareimage = (UIImageView*)[self.view viewWithTag:7171];
    [shareimage removeFromSuperview];
    
    UIView *pigview =[self creatKickbackAnimationwithDurtime:1];
    [self.view addSubview:pigview];
}

#pragma mark 分享动画
- (UIView*)creatKickbackAnimationwithDurtime:(int)time
{
    UIView *animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY)];
    animationView.backgroundColor = [UIColor clearColor];
    animationView.alpha = 1;
    animationView.tag = 888;
    
    [self.view addSubview:animationView];
    
    [self.view bringSubviewToFront:animationView];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY)];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    iv.center = CGPointMake(animationView.center.x, animationView.frame.size.height/2);
    
    iv.tag = 778;
    iv.userInteractionEnabled=YES;
    iv.layer.cornerRadius=iv.frame.size.width/2;
    [animationView addSubview:_animationView = iv];
    
    NSMutableArray *anArr = [NSMutableArray array];
    
    for (int i = 1 ; i<30; i++) {
        NSString *gStr = [NSString stringWithFormat:@"%@%d",@"share00",i+20];
        
        NSString *file = [[NSBundle mainBundle] pathForResource:gStr ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:file];
        [anArr addObject:image];
    }
    iv.animationImages = anArr;    //动画图片数组
    iv.animationDuration = 1.5;      //执行一次完整动画所需的时长
    iv.animationRepeatCount = time;   //无限
    [iv startAnimating];
    
    
    [self performSelector:@selector(removehareImage) withObject:nil afterDelay:1.7];
    
    return animationView;
    
}

- (void)removehareImage
{
    UIView *animationView=(UIView*)[self.view viewWithTag:888];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        animationView.frame =CGRectMake(kApplicationWidth+20,animationView.frame.origin.y, animationView.frame.size.width, animationView.frame.size.height);
        
        
    } completion:^(BOOL finished) {
        
        [animationView removeFromSuperview];
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
    
    if ( self.orderModel.status.intValue==1&&_orderModel.lasttime.doubleValue>_orderModel.requestNow_time.doubleValue) {
         [self httpGetNowTime];
    }
   
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
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
            //responseObject = [NSDictionary changeType:responseObject];
            NSString *message=responseObject[@"message"];
            if([responseObject[@"status"]intValue]==1) {
                if (secondsTimer!=nil) {
                    [secondsTimer invalidate];
                }
                payTimeTitle.hidden=NO;
                secondsTime=[_orderModel.lasttime doubleValue]/1000-[responseObject[@"now"] doubleValue]/1000;
                payTime.text=[NSString stringWithFormat:@"%@",[self payTimeLeftFromDate]];
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
        [UIView animateWithDuration:0.3 animations:^{
            button1.alpha=0;
            [button1 removeFromSuperview];
            [payTime removeFromSuperview];
            [payTimeTitle removeFromSuperview];
            [button2 setTitle:@"删除订单" forState:UIControlStateNormal];
            button2.frame=CGRectMake(kApplicationWidth-80-ZOOM(60), 5, 80, 30);
        }];
        
        [self postNotification];
    }else{
        payTime.text=[NSString stringWithFormat:@"%@",[self payTimeLeftFromDate]];
        secondsTime--;
    }
}

#pragma mark 删除订单
-(void)deleteHttp:(NSString*)ordercoder
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *url=[NSString stringWithFormat:@"%@order/delOrder?version=%@&token=%@&order_code=%@",[NSObject baseURLStr],VERSION,token,ordercoder];
    NSString *URL=[MyMD5 authkey:url];
    
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation]createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation]stopAnimationAt:self.view];
        
        //responseObject is %@",responseObject);
        
        if (responseObject!=nil) {
            //responseObject = [NSDictionary changeType:responseObject];
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(str.intValue==1){
                message=@"订单删除成功";
                [self postNotification];
                [self.navigationController popViewControllerAnimated:YES];
            }else if (str.intValue==10030) {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_TOKEN];
                LoginViewController *login=[[LoginViewController alloc]init];
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }
            else{
                message=@"订单删除失败";
            }
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation]stopAnimationAt:self.view];
    }];
}

#pragma mark 确认收货
-(void)ShouhuoHttp:(NSString*)ordercode withPwd:(NSString*)pwd
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *passwd=[MyMD5 md5:pwd];
    NSString *url=[NSString stringWithFormat:@"%@order/affirmOrder?version=%@&token=%@&order_code=%@&pwd=%@",[NSObject baseURLStr],VERSION,token,ordercode,passwd];
    NSString *URL=[MyMD5 authkey:url];
    
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation]createAnimationAt:self.view];

    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation]stopAnimationAt:self.view];

        //responseObject is %@",responseObject);
        
        if (responseObject!=nil) {
           // responseObject = [NSDictionary changeType:responseObject];
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            
            if(str.intValue==1){
                message=@"收货成功";
                [mentionview showLable:message Controller:self];
                [self performSelector:@selector(popViewControllerAnimated) withObject:self afterDelay:1.5];
            }else if (str.intValue==10030){
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_TOKEN];
                LoginViewController *login=[[LoginViewController alloc]init];
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
            }
            else{
                message=@"收货失败";
                [mentionview showLable:message Controller:self];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
    
    
}
-(void)popViewControllerAnimated
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 取消订单
-(void)CancelHttp:(NSString*)ordercoder Index:(NSInteger)index Explain:(NSString *)explain
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    //    NSString *url=[NSString stringWithFormat:@"%@order/escOrder?version=v1.0&token=%@&order_code=%@end_explain=%@",[NSObject baseURLStr],token,ordercoder,explain];
    
    NSString *url;
    if (self.orderModel.shop_from.intValue==4||self.orderModel.shop_from.intValue==6) {
        url=[NSString stringWithFormat:@"%@treasures/escOrder?version=%@&token=%@&order_code=%@&end_explain=%@",[NSObject baseURLStr],VERSION,token,ordercoder,explain];
    }else
        url=[NSString stringWithFormat:@"%@order/escOrder?version=%@&token=%@&order_code=%@",[NSObject baseURLStr],VERSION,token,ordercoder];
    
    NSString *URL=[MyMD5 authkey:url];
    
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation]createAnimationAt:self.view];

    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation]stopAnimationAt:self.view];

        //responseObject is %@",responseObject);
        
        if (responseObject!=nil) {
            //responseObject = [NSDictionary changeType:responseObject];
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(str.intValue==1){
                message=@"取消订单成功";
                [self postNotification];
//                [self.navigationController popViewControllerAnimated:YES];
                [self toBack];
            }else if (str.intValue==10030){
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_TOKEN];
                LoginViewController *login=[[LoginViewController alloc]init];
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
            }
            else{
                message=@"取消订单失败";
            }
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation]stopAnimationAt:self.view];
    }];
    
}


#pragma mark 查看物流
-(void)GetlogHttp:(NSString*)logi_code :(NSString*)logi_name
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
//    NSString *url=[NSString stringWithFormat:@"http://www.kuaidi100.com/query?type=%@&postid=%@",logi_name,logi_code];
    NSString *url = [NSString stringWithFormat:@"%@order/expQuery?version=%@&token=%@&nu=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],logi_code];
    NSString *URL=[MyMD5 authkey:url];
    
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
//    [[Animation shareAnimation]createAnimationAt:self.view];

    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation]stopAnimationAt:self.view];

        //responseObject = [NSDictionary changeType:responseObject];
        //responseObject is %@",responseObject);
        NSString *str=responseObject[@"status"];
        NSString *message=responseObject[@"message"];
//        NSString *codenumber=responseObject[@"com"];
        
        NSString *codenumber=responseObject[@"data"];
        if(codenumber !=nil && [responseObject[@"data"]count]!=0)
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
            
//            for(NSDictionary *dic in responseObject[@"data"])
            for(NSDictionary *dic in responseObject[@"data"][0][@"lastResult"][@"data"]) {
                ShopDetailModel *Logisticsmodel=[[ShopDetailModel alloc]init];
                Logisticsmodel.context=dic[@"context"];
                Logisticsmodel.ftime=dic[@"ftime"];
                Logisticsmodel.time=dic[@"time"];
                
                [_logisticsArray addObject:Logisticsmodel];
            }
          if(_logisticsArray.count){
              ShopDetailModel *model=_logisticsArray[0];
              _addresslab.text=model.context;
              _timelab.text=model.ftime;
          }
        }else if(str.intValue!=1){
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation]stopAnimationAt:self.view];
    }];
}

#pragma mark 延长收货
-(void)ExtendHttp:(NSString*)ordercoder
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *url=[NSString stringWithFormat:@"%@order/extension?version=%@&token=%@&order_code=%@",[NSObject baseURLStr],VERSION,token,ordercoder];
    NSString *URL=[MyMD5 authkey:url];
    
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation]createAnimationAt:self.view];

    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation]stopAnimationAt:self.view];

        //responseObject is %@",responseObject);
        
        if (responseObject!=nil) {
           // responseObject = [NSDictionary changeType:responseObject];
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(str.intValue==1){
                message=@"延长收货成功";
                [self.navigationController popViewControllerAnimated:YES];
            }else if (str.intValue==10030){
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_TOKEN];
                LoginViewController *login=[[LoginViewController alloc]init];
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
            }
            else{
                message=@"延长收货失败";
            }
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation]stopAnimationAt:self.view];

    }];
    
    
    
}

-(void)creatView
{
    self.Myscrollview.frame=CGRectMake(0, self.Myscrollview.frame.origin.y, kApplicationWidth,kApplicationHeight-Height_NavBar-20+kUnderStatusBarStartY);
    self.Myscrollview.backgroundColor=[UIColor whiteColor];

    //订单头
    self.HeadView.frame=CGRectMake(self.HeadView.frame.origin.x, self.HeadView.frame.origin.y, kApplicationWidth, 88+ZOOM(50)*2+ZOOM(10)*3);
    self.statue.frame = CGRectMake(ZOOM(62), ZOOM(50), _statue.frame.size.width, 25);
    self.Orderfee.frame = CGRectMake(ZOOM(62),CGRectGetMaxY(_statue.frame)+ZOOM(10), _Orderfee.frame.size.width, 21);
    self.Yunfee.frame = CGRectMake(ZOOM(62), CGRectGetMaxY(_Orderfee.frame)+ZOOM(10), _Yunfee.frame.size.width, 21);
    self.ordertime.frame = CGRectMake(ZOOM(62),CGRectGetMaxY(_Yunfee.frame)+ZOOM(10), _ordertime.frame.size.width, 21);
    
    CGFloat tablefootHeigh=0;
    CGFloat logistViewHeigh=0;
    
    if ([_orderModel.orderShopStatus intValue]==0 && _orderModel.orderShopStatus!=nil) {
        switch ([_orderModel.status intValue]) {
            case 1:
                
//                if (_orderModel.pay_status.intValue==1) {
//                    [_statue setText:@"支付中"];
//                }
//                else if ([self compareWithAnotherDay:_orderModel]==-1){
//                    [_statue setText:@"已过期"];
//                }else{
//
//                    [_statue setText:@"待付款"];
//                }
                
                [_statue setText:@"待付款"];
                break;
            case 2:
                if (_orderModel.whether_prize.intValue==2) {
                    [_statue setText:@"申请发货中"];
                }else
                    [_statue setText:@"待发货"];
                break;
            case 3:
                [_statue setText:@"待收货"];
                break;
            case 4:
                [_statue setText:@"待评价"];
                break;
            case 5:
                [_statue setText:@"已评价"];
                break;
            case 6:
                if(_orderModel.shop_from.intValue == 10)
                {
                    [_statue setText:@"免费领未点中"];
                }else
                    [_statue setText:@"交易成功"];
                break;
            case 7:
                [_statue setText:@"延长收货"];
                break;
            case 9:
                if(_orderModel.shop_from.intValue == 13)
                {
                    [_statue setText:@"订单关闭"];
                }else
                    [_statue setText:@"取消订单"];
                break;
            case 10:
                [_statue setText:@"订单已过期"];
                break;
            case 11:
                [_statue setText:@"拼团中"];
                break;
            case 12:
//                [_statue setText:@"待疯抢"];
                [_statue setText:@"免费领"];
                break;
            case 13:
                [_statue setText:@"拼团失败"];
                break;
            case 14:
                [_statue setText:@"免费领未点中"];
                break;
            case 15:
                [_statue setText:@"拼团中"];
                break;
            case 16:
                [_statue setText:@"拼团关闭"];
                break;
            case 17://中奖订单 预中间显示
                if (_orderModel.whether_prize.intValue==2) {
                    [_statue setText:@"申请发货中"];
                }
//                if(_orderModel.new_free == 1)
//                {
//                    [_statue setText:@"未中奖"];
//                }
                break;
            case 21:
                [_statue setText:@"分享中"];
                break;
            default:
                break;
        }
    }else if (_orderModel.orderShopStatus.intValue == 4)
    {
        if (_orderModel.shop_from.intValue==10) {
            [_statue setText:@"免费领未点中"];
        }else
            [_statue setText:@"交易成功"];
    }
    else{
        
        NSMutableString *string = [[NSMutableString alloc]init];
        switch ([_orderModel.change intValue]) {
            case 1:
                [string appendString:@"换货"];
                break;
            case 2:
                [string appendString:@"退货"];
                break;
            case 3:
                [string appendString:@"退款"];
                break;
        }
        switch ([_orderModel.orderShopStatus intValue]) {
            case 1:
                [string appendString:@"处理中"];
                break;
            case 2:
                [string appendString:@"被拒绝"];
                break;
            case 3:
                [string appendString:@"已成功"];
                break;
            case 4:
                [string appendString:@"已取消"];
                break;
            default:
                break;
        }
        
        [_statue setText:string];//显示换货状态，通过商品的status 和change字段来判断s
    }

    if (_orderModel.status.integerValue==3||_orderModel.status.integerValue==4||_orderModel.status.integerValue==5||_orderModel.status.integerValue==6||_orderModel.status.integerValue==7) {
        
        if ((_orderModel.shop_from.intValue==4||_orderModel.shop_from.intValue==6||(_orderModel.change.intValue==3&&_orderModel.orderShopStatus.intValue==3))&&_orderModel.status.integerValue==6) {
            logistViewHeigh=0;
        }else
            logistViewHeigh=90;
    }

    self.Myscrollview.frame=CGRectMake(0, Height_NavBar, kApplicationWidth,kScreenHeight-Height_NavBar-logistViewHeigh);


    if (_orderModel.shop_from.intValue==4||_orderModel.shop_from.intValue==6){
        switch (_orderModel.issue_status.intValue) {
            case 0:
                [_statue setText:@"参与中"];
                break;
            case 1:
                [_statue setText:@"退款"];
                break;
            case 2:
                [_statue setText:@"退款"];
                break;
            case 3:
                [_statue setText:@"中奖"];
                break;
            case 4:
                [_statue setText:@"未中奖"];
                break;
            default:
                break;
        }
    }
    if ([self compareWithAnotherDay:_orderModel]==-1&&(_orderModel.shop_from.intValue==4||_orderModel.shop_from.intValue==6)){
        [_statue setText:@"已过期"];
    }

    if (self.orderModel.shop_from.intValue==1) {
        self.Orderfee.text=[NSString stringWithFormat:@"订单金额:¥%.2f",[self.orderModel.order_price floatValue]];
    }else
        self.Orderfee.text=[NSString stringWithFormat:@"订单金额(包邮):¥%.2f",[self.orderModel.order_price floatValue]];
    self.Yunfee.text=[NSString stringWithFormat:@"订单号:%@",self.orderModel.order_code];
    
    NSString *timestr=[MyMD5 getTimeToShowWithTimestamp:self.orderModel.add_time];
    self.ordertime.text=[NSString stringWithFormat:@"下单时间:%@",timestr];
    self.shoujianren.text=[NSString stringWithFormat:@"收件人:%@",self.orderModel.consignee];
    self.Phone.text=[NSString stringWithFormat:@"%@",self.orderModel.phone];
    self.Address.text=[NSString stringWithFormat:@"收货地址:%@",self.orderModel.address];

    
    NSString * labelStr = [NSString stringWithFormat:@"%@",_Address.text];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(46)]};
    CGSize textSize = [labelStr boundingRectWithSize:CGSizeMake(kApplicationWidth-CGRectGetMaxX(_addressImg.frame)-5-ZOOM(62), 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
        
    self.addressImg.frame=CGRectMake(ZOOM(62), ZOOM(62), self.addressImg.frame.size.width, self.addressImg.frame.size.height);
    self.shoujianren.frame=CGRectMake(CGRectGetMaxX(_addressImg.frame)+5, _addressImg.frame.origin.y, _shoujianren.frame.size.width, _shoujianren.frame.size.height);
    self.Phone.frame=CGRectMake(kApplicationWidth-ZOOM(62)-_Phone.frame.size.width, _addressImg.frame.origin.y, self.Phone.frame.size.width, self.Phone.frame.size.height);
    self.Address.frame=CGRectMake(CGRectGetMaxX(_addressImg.frame)+5, CGRectGetMaxY(_shoujianren.frame)+ZOOM(10), kApplicationWidth-CGRectGetMaxX(_addressImg.frame)-5-ZOOM(62), textSize.height);

    
    self.InfoView.frame=CGRectMake(self.InfoView.frame.origin.x, CGRectGetMaxY(_HeadView.frame), kApplicationWidth, 21+textSize.height+ZOOM(10)+ZOOM(62)*2);
    self.infoViewLine.frame=CGRectMake(0, _InfoView.frame.size.height-1, kApplicationWidth, 1);
    //物流信息
    UIView *logisticView=[[UIView alloc]initWithFrame:CGRectMake(0, self.InfoView.frame.origin.y+self.InfoView.frame.size.height, kApplicationWidth, logistViewHeigh)];
    UITapGestureRecognizer *logisttap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(logistclick:)];
    [logisticView addGestureRecognizer:logisttap];
    logisticView.userInteractionEnabled=YES;
    logisticView.hidden=YES;
    [self.Myscrollview addSubview:logisticView];

    UILabel *logisticlab=[[UILabel alloc]initWithFrame:CGRectMake(50, 10, kApplicationWidth-50, 25)];
    logisticlab.text=@"物流信息";
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(60), 32, 20, 20)];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.image=[UIImage imageNamed:@"椭圆-23"];
    UIImageView *imageview1=[[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(83), 32, 2, 50)];
    imageview1.image=[UIImage imageNamed:@"矩形-31"];
    [logisticView addSubview:imageview1];
    [logisticView addSubview:imageview];
    _addresslab=[[UILabel alloc]initWithFrame:CGRectMake(50, 32, kApplicationWidth-50, 25)];
    _addresslab.text=@"物流信息";
    _addresslab.textColor=kGreenColor;
    _addresslab.font=[UIFont systemFontOfSize:ZOOM(40)];
    _timelab=[[UILabel alloc]initWithFrame:CGRectMake(50, 55, kApplicationWidth-50, 25)];
    _timelab.text=@"物流信息";
     _timelab.textColor=kGreenColor;
    _timelab.font=[UIFont systemFontOfSize:ZOOM(40)];
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, logistViewHeigh, kApplicationWidth, 1)];
    line.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [logisticView addSubview:logisticlab];
    [logisticView addSubview:_addresslab];
    [logisticView addSubview:_timelab];
    [logisticView addSubview:line];
    
    
    CGFloat shopHeigh=ZOOM(400);
    CGFloat tableviewHeigh;
    if (self.orderModel.shop_from.intValue==1||self.orderModel.shop_from.intValue==4||self.orderModel.shop_from.intValue==6) {
        tableviewHeigh=shopHeigh+30+ZOOM(62)+ZOOM(32);
    }else
        tableviewHeigh=shopHeigh*self.orderModel.shopsArray.count+30+ZOOM(62)+ZOOM(32);
    //在商品列表创建列表视图
    _ShopTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth,tableviewHeigh) style:UITableViewStylePlain];
    _ShopTableView.dataSource=self;
    _ShopTableView.delegate=self;
    _ShopTableView.rowHeight=ZOOM(400);
    _ShopTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _ShopTableView.bounces = NO;
    [self.ShopView addSubview:_ShopTableView];
    [_ShopTableView registerNib:[UINib nibWithNibName:@"OrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    

    CGFloat shopviewHeigh=tableviewHeigh;
    //商品列表
    self.ShopView.frame=CGRectMake(self.ShopView.frame.origin.x, CGRectGetMaxY(logisticView.frame)+ZOOM(32), kApplicationWidth,shopviewHeigh);
    
    UIView *tabelfootview=[[UIView alloc]initWithFrame:CGRectMake(0, ZOOM(62), kApplicationWidth, 30+ZOOM(62))];
    UILabel *totallable=[[UILabel alloc]initWithFrame:CGRectMake(0, ZOOM(62), kApplicationWidth-20, 30)];
    
//    totallable.text=[NSString stringWithFormat:@"共%ld件商品  实付:¥%.2f",self.orderModel.shopsArray.count,self.orderModel.order_price.floatValue];
    if (_orderModel.shop_from.intValue==4||_orderModel.shop_from.intValue==6) {
        totallable.text=[NSString stringWithFormat:@"共1件商品   实付:¥%.2f",_orderModel.order_price.floatValue];
    }
    else if (self.orderModel.shop_from.intValue==1) {
        totallable.text=[NSString stringWithFormat:@"共%@件商品   实付:¥%.2f(含运费:¥%.2f)",self.orderModel.shop_num,self.orderModel.order_price.floatValue,self.orderModel.postage.floatValue];
    }
//    else if (self.orderModel.shop_from.intValue==10)//一元购订单
//    {
//        totallable.text=[NSString stringWithFormat:@"共%@件商品   实付:¥%.2f",self.orderModel.shop_num,[DataManager sharedManager].app_value];
//    }
    else
        totallable.text=[NSString stringWithFormat:@"共%@件商品   实付:¥%.2f",self.orderModel.shop_num,self.orderModel.order_price.floatValue];
    
    totallable.font=[UIFont systemFontOfSize:ZOOM(46)];
    totallable.textAlignment=NSTextAlignmentRight;
    [tabelfootview addSubview:totallable];
    
//    UIButton *salebtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    salebtn.frame=CGRectMake(kApplicationWidth-90, 0, 80, 30);
//    [salebtn setTitle:btntitle forState:UIControlStateNormal];
//    [salebtn addTarget:self action:@selector(saleclick:) forControlEvents:UIControlEventTouchUpInside];
//    salebtn.backgroundColor=[UIColor blackColor];
//    salebtn.tintColor=[UIColor whiteColor];
//    [tabelfootview addSubview:salebtn];

    _ShopTableView.tableFooterView=tabelfootview;

    //订单信息
    self.OrderView.frame=CGRectMake(self.ShopView.frame.origin.x, self.ShopView.frame.origin.y+shopviewHeigh+tablefootHeigh, kApplicationWidth, ZOOM(62)*4+ZOOM(32)+42+30);

    self.yunfei.frame=CGRectMake(ZOOM(62), ZOOM(62), self.yunfei.frame.size.width, self.yunfei.frame.size.height);
    self.shifufei.frame=CGRectMake(ZOOM(62), ZOOM(62)+ZOOM(32)+self.yunfei.frame.size.height, self.shifufei.frame.size.width, self.shifufei.frame.size.height);
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.shifufei.frame.origin.y+_shifufei.frame.size.height+ZOOM(62), kApplicationWidth, 1)];
    line1.backgroundColor=lineGreyColor;
    [self.OrderView addSubview:line1];
    
    if (self.orderModel.shop_from.intValue==1) {
        self.freight.text=[NSString stringWithFormat:@"¥%.2f",self.orderModel.postage.floatValue];
    }else
        self.freight.text=[NSString stringWithFormat:@"¥%.2f",self.orderModel.free.floatValue];
    
    self.Payfee.text=[NSString stringWithFormat:@"¥%.2f",self.orderModel.order_price.floatValue];
//    if (self.orderModel.shop_from.intValue==10)//一元购订单
//    {
//        self.Payfee.text=[NSString stringWithFormat:@"¥%.2f",[DataManager sharedManager].app_value];
//    }
    self.Ordercode.text=[NSString stringWithFormat:@"%@",self.orderModel.order_code];
    self.Paycode.text=@"";
//    self.Paytime.text=[NSString stringWithFormat:@"%@",self.orderModel.add_time];
    
    self.freight.frame=CGRectMake(kApplicationWidth-ZOOM(62)-self.freight.frame.size.width,ZOOM(62), self.freight.frame.size.width, self.freight.frame.size.height);
    self.Payfee.frame=CGRectMake(kApplicationWidth-ZOOM(62)-self.Payfee.frame.size.width, ZOOM(62)+self.freight.frame.size.height+ZOOM(32), self.Payfee.frame.size.width, self.Payfee.frame.size.height);
    self.servicebtn.frame = CGRectMake(ZOOM(62),line1.frame.origin.y+ZOOM(62), (kScreenWidth-3*(ZOOM(61)))/2, 30);
    self.phonebtn.frame = CGRectMake(kApplicationWidth-ZOOM(62)-_servicebtn.frame.size.width,line1.frame.origin.y+ZOOM(62), (kScreenWidth-3*(ZOOM(61)))/2, 30);
    
    self.servicebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.phonebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.servicebtn.layer.borderWidth=1;
    self.servicebtn.layer.borderColor=lineGreyColor.CGColor;
    self.phonebtn.layer.borderWidth=1;
    self.phonebtn.layer.borderColor=lineGreyColor.CGColor;
    //下面带有提醒功能的视图
    UIView *foorview=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-40+kUnderStatusBarStartY, kApplicationWidth, 40)];
    foorview.hidden=NO;
    foorview.backgroundColor=[UIColor whiteColor];
    
    //提示按钮
    button1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.frame=CGRectMake(kApplicationWidth-80-ZOOM(60), 5, 80, 30);
    button1.titleLabel.font = [UIFont systemFontOfSize:ZOOM(46)];
    button1.tintColor=[UIColor whiteColor];
    button1.backgroundColor=[UIColor blackColor];
    
    button2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame=CGRectMake(kApplicationWidth-80*2-ZOOM(60)-10, 5, 80, 30);
    button2.titleLabel.font = [UIFont systemFontOfSize:ZOOM(46)];
    button2.tintColor=[UIColor whiteColor];
    button2.backgroundColor=[UIColor blackColor];
    
    
    button1.hidden=NO;
    button2.hidden=NO;

    
    NSString *statue=self.orderModel.status;
    
    if(statue.intValue == 12)
    {
        button1.frame=CGRectMake(kApplicationWidth-100-ZOOM(60), 5, 100, 30);
        button1.titleLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
        button1.tintColor=[UIColor whiteColor];
        button1.backgroundColor=[UIColor redColor];
    }
    
    if(statue.intValue==1){
        if ([self compareWithAnotherDay:_orderModel]==-1) {
            [button1 setTitle:@"删除订单" forState:UIControlStateNormal];
            button2.hidden=YES;
        }else{
            [button1 setTitle:@"付款" forState:UIControlStateNormal];
            [button2 setTitle:@"取消订单" forState:UIControlStateNormal];
        }

    }else if (statue.intValue==2)
    {
        if (_orderModel.pay_status.intValue==1&&[_orderModel.orderShopStatus intValue]==0 && _orderModel.orderShopStatus!=nil&&_orderModel.status.intValue==1) {
            [button1 setTitle:@"付款" forState:UIControlStateNormal];
            [button2 setTitle:@"取消订单" forState:UIControlStateNormal];
        }else if(_orderModel.issue_status.intValue==4){
            [button1 setTitle:@"删除订单" forState:UIControlStateNormal];
            button2.hidden=YES;
        }else{
            [button1 setTitle:@"提醒发货" forState:UIControlStateNormal];
            button2.hidden=YES;
        }
    }else if (statue.intValue==3)
    {
        logisticView.hidden=NO;
        [button1 setTitle:@"确认收货" forState:UIControlStateNormal];
        [button2 setTitle:@"查看物流" forState:UIControlStateNormal];
        
    }else if (statue.intValue==4)
    {
        logisticView.hidden=NO;
        [button1 setTitle:@"评价订单" forState:UIControlStateNormal];
        [button2 setTitle:@"删除订单" forState:UIControlStateNormal];
    }else if (statue.intValue==5)
    {
        logisticView.hidden=NO;
        if (_orderModel.shop_from.intValue==4||_orderModel.shop_from.intValue==6) {
             button2.hidden=YES;
            [button1 setTitle:@"删除订单" forState:UIControlStateNormal];
        }else{
            [button1 setTitle:@"追加评价" forState:UIControlStateNormal];
            [button2 setTitle:@"删除订单" forState:UIControlStateNormal];
        }
    }else if (statue.intValue==6)
    {
        logisticView.hidden=NO;
        if (_orderModel.shop_from.intValue==4||_orderModel.shop_from.intValue==6||(_orderModel.change.intValue==3&&_orderModel.orderShopStatus.intValue==3)) {
           logisticView.hidden=YES;
        }
        [button1 setTitle:@"删除订单" forState:UIControlStateNormal];
        button2.hidden=YES;
    }else if (statue.intValue==7)
    {
        logisticView.hidden=NO;
        [button1 setTitle:@"确认收货" forState:UIControlStateNormal];
        [button2 setTitle:@"查看物流" forState:UIControlStateNormal];
        
    }else if (statue.intValue==8)
    {
        [button1 setTitle:@"钱款去向" forState:UIControlStateNormal];
        button2.hidden=YES;
    }else if (statue.intValue==9)
    {
        [button1 setTitle:@"删除订单" forState:UIControlStateNormal];
        button2.hidden=YES;
    }
    else if (statue.intValue==11)
    {
        [button1 setTitle:@"邀请好友拼团" forState:UIControlStateNormal];
        button2.hidden=YES;
    }else if (statue.intValue==12)
    {
        [button1 setTitle:@"会员免费领" forState:UIControlStateNormal];
        button2.hidden=YES;
    }else if (statue.intValue==13)
    {
        [button1 setTitle:@"删除订单" forState:UIControlStateNormal];
        button2.hidden=YES;
    }else if (statue.intValue==14)
    {
        [button1 setTitle:@"删除订单" forState:UIControlStateNormal];
        button2.hidden=YES;
    }
    else
    {
        [button1 setTitle:@"删除订单" forState:UIControlStateNormal];
        button2.hidden=YES;
    }

    
    [button1 addTarget:self action:@selector(click22:) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(click22:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:foorview];
    [foorview addSubview:button1];
    [foorview addSubview:button2];
    
    if ([button1.titleLabel.text isEqualToString:@"付款"]) {
        payTimeTitle=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(60), 5, 150, 15)];
        payTimeTitle.text=@"付款剩余时间";
        payTimeTitle.font=[UIFont systemFontOfSize:ZOOM(35)];
        payTimeTitle.textColor=[UIColor grayColor];
        payTimeTitle.hidden=YES;
        [foorview addSubview:payTimeTitle];
        
        payTime=[[UILabel alloc]initWithFrame:CGRectMake(payTimeTitle.frame.origin.x, CGRectGetMaxY(payTimeTitle.frame), payTimeTitle.frame.size.width, payTimeTitle.frame.size.height)];
        payTime.textColor=tarbarrossred;
        payTime.font=[UIFont systemFontOfSize:ZOOM(40)];
//        payTime.text=[NSString stringWithFormat:@"%@",[self payTimeLeftFromDate]];
        
        [foorview addSubview:payTime];
//        [self timerThread];
    }
    
    //第二页分割线
//    UILabel *linelable=[[UILabel alloc]initWithFrame:CGRectMake(5, self.OrderView.frame.origin.y+self.OrderView.frame.size.height+ZOOM(62), 100, 1)];
//    linelable.backgroundColor=[UIColor darkTextColor];
//    [self.Myscrollview addSubview:linelable];
    
//    UILabel *linelable1=[[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth-105, self.OrderView.frame.origin.y+self.OrderView.frame.size.height+25, 100, 1)];
//    linelable1.backgroundColor=[UIColor darkTextColor];
//    [self.Myscrollview addSubview:linelable1];
    
//    UILabel *headlable=[[UILabel alloc]initWithFrame:CGRectMake(105, self.OrderView.frame.origin.y+self.OrderView.frame.size.height+25-15, kApplicationWidth-210, 30)];
   
//    headlable.text=@"你可能喜欢的宝贝";
//    headlable.backgroundColor=[UIColor groupTableViewBackgroundColor];
//    headlable.textAlignment=NSTextAlignmentCenter;
//    headlable.font=[UIFont systemFontOfSize:12];
//    [self.Myscrollview addSubview:headlable];
//    [headlable bringSubviewToFront:self.view];
    
    self.Myscrollview.contentSize=CGSizeMake(0, self.HeadView.frame.size.height+self.InfoView.frame.size.height+self.ShopView.frame.size.height+self.OrderView.frame.size.height+logistViewHeigh+64);

}

-(NSString *)payTimeLeftFromDate
{
    int cha=secondsTime;
    NSString *str=[[NSString alloc]init];

    if (cha/86400>0){
        str=[str stringByAppendingFormat:@"%ld天",(long)cha/86400];
        cha=cha%86400;
    }
    if (cha/3600>0) {
        str=[str stringByAppendingFormat:@"%ld时",(long)cha/3600];
        cha=cha%3600;
    }
    if (cha/60>0) {
        str=[str stringByAppendingFormat:@"%ld分",(long)cha/60];
    }
     str=[str stringByAppendingFormat:@"%ld秒",(long)cha%60];
    return str;
}

-(int)compareWithAnotherDay:(ShopDetailModel *)model
{
     return model.lasttime.doubleValue<=model.requestNow_time.doubleValue?-1:0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.orderModel.shop_from.intValue==1||self.orderModel.shop_from.intValue==4||self.orderModel.shop_from.intValue==6)
        return 1;
    return self.orderModel.shopsArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.orderModel.shop_from.intValue==1)
    {
        [self showHint:@"商品已下架"];
        
//        ComboShopDetailViewController *detail=[[ComboShopDetailViewController alloc] initWithNibName:@"ComboShopDetailViewController" bundle:nil];
//        detail.shop_code = self.orderModel.bak;
//        detail.stringtype=@"订单详情";
//        detail.hidesBottomBarWhenPushed=YES;
//        [self.navigationController pushViewController:detail animated:YES];
    }else if(self.orderModel.shop_from.intValue==2)
    {
//        OrderDetailModel *model=self.orderModel.shopsArray[indexPath.row];
//        ComboShopDetailViewController *detail=[[ComboShopDetailViewController alloc] initWithNibName:@"ComboShopDetailViewController" bundle:nil];
//        detail.shop_code = model.shop_code;
//        detail.detailType=@"会员商品";
//        detail.hidesBottomBarWhenPushed=YES;
//        [self.navigationController pushViewController:detail animated:YES];
    }else if(self.orderModel.shop_from.intValue==3)
    {
    
    }else if(self.orderModel.shop_from.intValue==4||self.orderModel.shop_from.intValue==6){
        [self showHint:@"请在签到界面抽奖记录中进行查看"];
    }
    else{
        OrderDetailModel *model=self.orderModel.shopsArray[indexPath.row];
        
        //    ShopDetailViewController *shopdetail=[[ShopDetailViewController alloc]init];
        ShopDetailViewController *shopdetail=[[ShopDetailViewController alloc]initWithNibName:@"ShopDetailViewController" bundle:nil];
        OrderTableViewCell *cell = (OrderTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        shopdetail.bigimage=cell.headimage.image;
        shopdetail.shop_code=model.shop_code;
        shopdetail.stringtype = self.orderModel.shop_from.intValue==5||self.orderModel.shop_from.intValue==7?@"活动商品": @"订单详情";
        shopdetail.isNOFightgroups = self.orderModel.shop_from.intValue==5;
        shopdetail.browseCount = -1;
        [self.navigationController pushViewController:shopdetail animated:YES];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell=[[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    if (self.orderModel.shop_from.intValue==4||self.orderModel.shop_from.intValue==6) {
        [cell refreshIndianaData:self.orderModel];
        cell.groupBuyImg.hidden = YES;
        cell.zeroLabel.hidden=YES;
        cell.color_size.hidden=YES;
    }
    else if (self.orderModel.shop_from.intValue==1) {
        [cell refreshZeroData:self.orderModel];
        cell.groupBuyImg.hidden = YES;
        cell.zeroLabel.hidden=NO;
        cell.color_size.hidden=YES;
    }else{
        ShopDetailModel *model=self.orderModel.shopsArray[indexPath.row];
        [cell refreshData3:model];
        cell.groupBuyImg.hidden = self.orderModel.shop_from.integerValue!=7;
        cell.zeroLabel.hidden=YES;
        cell.color_size.hidden=NO;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)Addcircle:(NSInteger)index
{
    OrderDetailModel *model=self.orderModel.shopsArray[index];
    RefundAndReturnViewController *refund=[[RefundAndReturnViewController alloc]init];
    refund.shop_id=model.ID;
    refund.order_code=model.order_code;
    [self.navigationController pushViewController:refund animated:YES];
    
}

#pragma mark 申请售后
-(void)saleclick:(UIButton*)sender
{
    NSString *change=self.orderModel.change;
    
    if([sender.titleLabel.text isEqualToString:@"退款"])
    {
        MyLog(@"退款");
        
        if(change.intValue==0){
            RefundAndReturnViewController *refund=[[RefundAndReturnViewController alloc]init];
            refund.orderPrice=self.orderModel.order_price;
            refund.ordermodel=self.orderModel;
            [self.navigationController pushViewController:refund animated:YES];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"亲,你已申请不能再次申请了!" Controller:self];
        }
    }else if ([sender.titleLabel.text isEqualToString:@"申请售后"])
    {
        MyLog(@"申请售后");
        if(change.intValue==0) {
            RefundAndReturnViewController *refund=[[RefundAndReturnViewController alloc]init];
            refund.orderPrice=self.orderModel.order_price;
            refund.ordermodel=self.orderModel;
            [self.navigationController pushViewController:refund animated:YES];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"亲,你已申请不能再次申请了!" Controller:self];
        }
        
    }

}

#pragma mark 查看物流
-(void)logistclick:(UITapGestureRecognizer*)tap
{
    LogisticsViewController *logistics=[[LogisticsViewController alloc]init];
    //%@",_orderModel.logi_name);
    logistics.Ordermodel=self.orderModel;
    [self.navigationController pushViewController:logistics animated:YES];
}


#pragma mark 付款

-(void)toBack
{
    
    MyLog(@"self.navigationController.viewControllers=%@",self.navigationController.viewControllers);
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[IndianaDetailViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }
        else if ([controller isKindOfClass:[ShopDetailViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }
        else if ([controller isKindOfClass:[SpecialShopDetailViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }
        else if ([controller isKindOfClass:[MyOrderViewController class]]){
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }
        else if ([controller isKindOfClass:[NewShoppingCartViewController class]]  &&
                 ![self.navigationController.viewControllers[self.navigationController.viewControllers.count-2] isKindOfClass:[MyOrderViewController class]]){
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }
        else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark ---------------------- 提醒发货

-(void)RemindDelivery:(NSString*)ordercoder
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *url=[NSString stringWithFormat:@"%@order/urgeSuppShipments?version=%@&token=%@&order_code=%@",[NSObject baseURLStr],VERSION,token,ordercoder];
    NSString *URL=[MyMD5 authkey:url];
    
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        if (responseObject!=nil) {
            //responseObject = [NSDictionary changeType:responseObject];
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            NSString *flag=responseObject[@"falg"];
            
            if(str.intValue==1) {
                message=@"提醒发货成功";
                if (flag.intValue==2) {
                    message=@"亲，提醒太频繁了，不要那么着急嘛";
                }
            }
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
}



#pragma mark ==============  creatpickerView
-(void)creatPickerView
{
    self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0;
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
    
     self.pickerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight -180, kScreenWidth, 200)];
    self.pickerBgView.backgroundColor = [UIColor whiteColor];
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    selectBtn.frame = CGRectMake(self.pickerBgView.frame.size.width-ZOOM(182), 0, ZOOM(120), ZOOM(120));
    [selectBtn setTitle:@"完成" forState:UIControlStateNormal];
    selectBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
    [selectBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(ensure:) forControlEvents:UIControlEventTouchUpInside];
    [self.pickerBgView addSubview:selectBtn];
    
    self.myPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, selectBtn.frame.origin.y+selectBtn.frame.size.height, kApplicationWidth, self.pickerBgView.frame.size.height - selectBtn.frame.size.height  )];
    self.myPicker.dataSource = self;
    self.myPicker.delegate = self;
    self.myPicker.showsSelectionIndicator = YES;
    [self.myPicker selectRow:2 inComponent:0 animated:NO];
    [self.pickerBgView addSubview:self.myPicker];
    
}
#pragma mark - private method
- (void)showMyPicker{
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.pickerBgView];
    self.maskView.alpha = 0;
    self.pickerBgView.frame = CGRectMake(0, kApplicationHeight -180, kScreenWidth, 200);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.3;
        self.pickerBgView.frame = CGRectMake(0, kApplicationHeight -180, kScreenWidth, 200);
        
    }];
}

- (void)hideMyPicker {
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0;
        self.pickerBgView.frame = CGRectMake(0, kScreenHeight, self.pickerBgView.frame.size.width, self.pickerBgView.frame.size.height);
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self.pickerBgView removeFromSuperview];
    }];
}
- (void)ensure:(UIButton *)sender {
    
    [self hideMyPicker];
    
    NSInteger row=[self.myPicker selectedRowInComponent:0];   //    获取选中的列中的所在的行
    NSString *value=[pickerArray objectAtIndex:row];        //    然后是获取这个行中的值，就是数组中的值
    [self CancelHttp:self.orderModel.order_code Index:indextag Explain:value];
    
}

-(void)postNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshOrder" object:nil];
}
-(void)payPassWordView:(NSString *)ordercoder withOrderPrice:(NSString *)orderprice
{
    TFPayPasswordView *view = [[TFPayPasswordView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.money = [NSString stringWithFormat:@"%.2f",orderprice.floatValue];
    [self.view addSubview:view];
    
    
    [view returnPayResultSuccess:^(NSString *pwd) {
        
        //密码验证成功");
        [self ShouhuoHttp:ordercoder withPwd:pwd];

    } withFail:^(NSString *error){
        //                    [MBProgressHUD showError:error];
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"温馨提示" contentText:error leftButtonTitle:@"重新输入" rightButtonTitle:@"忘记密码"];
        [alert show];
        alert.leftBlock = ^() {
            [self payPassWordView:ordercoder withOrderPrice:orderprice];
        };
        alert.rightBlock = ^() {
            TFChangePaymentPasswordViewController *tsvc= [[TFChangePaymentPasswordViewController alloc] init];
            [self.navigationController pushViewController:tsvc animated:YES];
            
        };
    } withTitle:@"请确认收货"];
}
-(void)click22:(UIButton*)sender
{
    [self postNotification];
    
    if([sender.titleLabel.text isEqualToString:@"取消订单"])
    {
        if (_orderModel.pay_status.intValue==1&&[_orderModel.orderShopStatus intValue]==0 && _orderModel.orderShopStatus!=nil&&_orderModel.status.intValue==1) {
            [MBProgressHUD showError:@"此订单未返回支付状态，暂时无法取消"];
            return;
        }
        indextag=sender.tag/10000-1;

        [self showMyPicker];

    }else if ([sender.titleLabel.text isEqualToString:@"退款"])
    {
        RefundAndReturnViewController *refund=[[RefundAndReturnViewController alloc]init];
        refund.orderPrice=self.orderModel.order_price;
        refund.ordermodel=self.orderModel;
        [self.navigationController pushViewController:refund animated:YES];
        
        
    }else if ([sender.titleLabel.text isEqualToString:@"查看物流"])
    {
        
        LogisticsViewController *logistics=[[LogisticsViewController alloc]init];
        logistics.Ordermodel=self.orderModel;
        [self.navigationController pushViewController:logistics animated:YES];
        
    }else if ([sender.titleLabel.text isEqualToString:@"查看物流"])
    {
        LogisticsViewController *logistics=[[LogisticsViewController alloc]init];
        logistics.Ordermodel=self.orderModel;
        [self.navigationController pushViewController:logistics animated:YES];
        
    }
    if([sender.titleLabel.text isEqualToString:@"朋友代付"])
    {
        
    }else if ([sender.titleLabel.text isEqualToString:@"延长收货"])
    {
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"确认延长收货时间吗?" contentText:@"每笔订单只能延长一次哦!" leftButtonTitle:@"取消" rightButtonTitle:@"确认"];
        [alert show];
        alert.leftBlock = ^() {
            //left button clicked");//取消
        };
        alert.rightBlock = ^() {
            //right button clicked");//确认
            
            [self ExtendHttp:self.orderModel.order_code];
        };
        alert.dismissBlock = ^() {
            //Do something interesting after dismiss block");
        };
        
    }else if ([sender.titleLabel.text isEqualToString:@"删除订单"])
    {
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"温馨提示" contentText:@"亲，真的要删除此订单吗!" leftButtonTitle:@"取消" rightButtonTitle:@"确认"];
        [alert show];
        
        alert.leftBlock = ^() {
        };
        alert.rightBlock = ^() {
            [self deleteHttp:self.orderModel.order_code];
        };
        alert.dismissBlock = ^() {
        };
        
    }else if ([sender.titleLabel.text isEqualToString:@"联系卖家"])
    {
//         NSString *suppid=[NSString stringWithFormat:@"%@",self.orderModel.suppid];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString* suppid = [user objectForKey:PTEID];
        
//        NSString *suppid=[NSString stringWithFormat:@"%@",@"915"];
        [self Message:suppid];
        
    }
    if([sender.titleLabel.text isEqualToString:@"付款"])
    {
        //夺宝订单 都可以付款  无需判断了
        /*
        if((_orderModel.shop_from.intValue==4||_orderModel.shop_from.intValue==6)&&![_orderModel.issue_endtime isEqual:[NSNull null]]){
            if (_orderModel.issue_endtime.doubleValue<=_orderModel.requestNow_time.doubleValue) {
                [MBProgressHUD showError:@"此夺宝活动已开奖，暂时无法操作"];
                return;
            }
        }
       else
*/
           if (_orderModel.pay_status.intValue==1&&[_orderModel.orderShopStatus intValue]==0 && _orderModel.orderShopStatus!=nil&&_orderModel.status.intValue==1) {
            [MBProgressHUD showError:@"此订单未返回支付状态，暂时无法操作"];
            return;
        }
        //%@",self.navigationController.viewControllers);
        if (![self.navigationController.viewControllers[self.navigationController.viewControllers.count-2] isKindOfClass:[MyOrderViewController class]]) {
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[TFPayStyleViewController class]]) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                    
                }
            }
        }
        
        TFPayStyleViewController *paystyle=[[TFPayStyleViewController alloc]init];
        NSString *str = [self.Payfee.text substringFromIndex:1];
        paystyle.price = str.floatValue;
        paystyle.order_code=self.orderModel.order_code;
//        paystyle.shop_from = self.orderModel.shop_from;
        paystyle.shop_from = self.orderModel.shop_from.intValue==6 ? @"4" :self.orderModel.shop_from;
        paystyle.lasttime=self.orderModel.lasttime;
        paystyle.urlcount=@"1";
        paystyle.shopmodel=self.orderModel;
//        MyLog(@"%@",self.orderModel.remain_money);
        paystyle.fromType=@"订单列表按钮";
        //存储当前支付的shopcode
        NSUserDefaults *users=[NSUserDefaults standardUserDefaults];
        [users setObject:self.orderModel.shop_code forKey:SHOP_CODE];
        [users setObject:self.orderModel.shop_pic forKey:SHOP_PIC];
        [users setObject:self.orderModel.kickback forKey:KICKBACK];
        
        [self.navigationController pushViewController:paystyle animated:YES];
    }else if ([sender.titleLabel.text isEqualToString:@"提醒发货"])
    {
        if (_orderModel.pay_status.intValue==1&&[_orderModel.orderShopStatus intValue]==0 && _orderModel.orderShopStatus!=nil&&_orderModel.status.intValue==1) {
            [MBProgressHUD showError:@"此订单未返回支付状态，暂时无法提醒发货"];
            return;
        }
        [self RemindDelivery:self.orderModel.order_code];
        
    }else if ([sender.titleLabel.text isEqualToString:@"确认收货"])
    {
        for (ShopDetailModel *shopModel in _orderModel.shopsArray) {
            //            if(shopModel.orderShopStatus.intValue !=1 && !(shopModel.orderShopStatus.intValue==3 && shopModel.change.intValue==3))
            if(shopModel.orderShopStatus.intValue !=1 &&!(shopModel.orderShopStatus.intValue==3 && shopModel.change.intValue==2)&& !(shopModel.orderShopStatus.intValue==3 && shopModel.change.intValue==3) && shopModel.status.intValue!=5)
            {
                
                [self payPassWordView:self.orderModel.order_code withOrderPrice:self.orderModel.order_price];
                
                break;
            }else{
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:@"商品售后处理中" Controller:self];
            }
        }

    }else if ([sender.titleLabel.text isEqualToString:@"评价订单"] || [sender.titleLabel.text isEqualToString:@"追加评价"])
    {
        if ([sender.titleLabel.text isEqualToString:@"评价订单"]) {
            //评价订单");
            for (ShopDetailModel *shopModel in _orderModel.shopsArray) {
//                if(shopModel.orderShopStatus.intValue !=1 && !(shopModel.orderShopStatus.intValue==3 && shopModel.change.intValue==3))
                 if(shopModel.orderShopStatus.intValue !=1 &&!(shopModel.orderShopStatus.intValue==3 && shopModel.change.intValue==2)&& !(shopModel.orderShopStatus.intValue==3 && shopModel.change.intValue==3) && shopModel.status.intValue!=5)
                {
                    TFEvaluationOrderViewController *evaluate = [[TFEvaluationOrderViewController alloc] init];
                    evaluate.Ordermodel=_orderModel;
                    [self.navigationController pushViewController:evaluate animated:YES];
                    return;
                }else{
                    NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                    [mentionview showLable:@"商品售后处理中，不能评价" Controller:self];
                }
            }
            
//            TFEvaluationOrderViewController *evaluate = [[TFEvaluationOrderViewController alloc] init];
//            evaluate.Ordermodel=self.orderModel;
//            [self.navigationController pushViewController:evaluate animated:YES];
            
        } else {
            for (ShopDetailModel *shopModel in _orderModel.shopsArray) {
//                if(shopModel.orderShopStatus.intValue !=1 && !(shopModel.orderShopStatus.intValue==3 && shopModel.change.intValue==3))
                 if(shopModel.orderShopStatus.intValue !=1 &&!(shopModel.orderShopStatus.intValue==3 && shopModel.change.intValue==2)&& !(shopModel.orderShopStatus.intValue==3 && shopModel.change.intValue==3) ){
                    TFAdditionalEvaluationViewController *tavc = [[TFAdditionalEvaluationViewController alloc] init];
                    tavc.Ordermodel = self.orderModel;
                    [self.navigationController pushViewController:tavc animated:YES];
                    return;
                }else{
                    NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                    [mentionview showLable:@"商品售后处理中，不能评价" Controller:self];
                }
            }

        }
    }else if ([sender.titleLabel.text isEqualToString:@"钱款去向"])
    {
        MoneyGoViewController *moneygo=[[MoneyGoViewController alloc]init];
        [self.navigationController pushViewController:moneygo animated:YES];
    }else if ([sender.titleLabel.text isEqualToString:@"邀请好友拼团"] || [sender.titleLabel.text isEqualToString:@"免费领未点中"])
    {
        //去拼团详情
        if([DataManager sharedManager].opengroup == 1)//开团
        {
            [DataManager sharedManager].opengroutSuccess = 1;//开团成功
        }else if ([DataManager sharedManager].opengroup == 2)//参团
        {
            [DataManager sharedManager].opengroutSuccess = 4;//参团成功
        }
        
        GroupBuyDetailVC *fightvc = [[GroupBuyDetailVC alloc] init];
        [self.navigationController pushViewController:fightvc animated:YES];
        
    }else if ([sender.titleLabel.text isEqualToString:@"会员免费领"]){
        OneLuckdrawViewController *oneluck = [OneLuckdrawViewController new];
        oneluck.comefrom = @"newbie";
        oneluck.order_code = self.order_code;
        [self.navigationController pushViewController:oneluck animated:YES];
    }

}

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alter show];
}

-(void)toPaySuccessAndShare:(NSString *)price
{
    BuySuccessViewController *successpay=[[BuySuccessViewController alloc]init];
    successpay.shopprice=price;
    [self.navigationController pushViewController:successpay animated:YES];
    
//    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(toshare:) userInfo:nil repeats:NO];
}
-(void)toshare:(NSTimer*)timer
{
    IntelligenceViewController *intell=[[IntelligenceViewController alloc]init];
    [self.navigationController pushViewController:intell animated:YES];
    
}

-(void)toPayFailed
{
    PayFailedViewController *faild=[[PayFailedViewController alloc]init];
    [self.navigationController pushViewController:faild animated:YES];
    
}

#pragma  mark - *****************请求电话号码
-(void)httpPhone
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSString *url=[NSString stringWithFormat:@"%@order/getSuppPhone?version=%@&token=%@&supp_id=%@",[NSObject baseURLStr],VERSION,token,self.orderModel.suppid];
    NSString *URL=[MyMD5 authkey:url];
    [manager GET:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject!=nil) {
            
            //responseObject = [NSDictionary changeType:responseObject];
            phoneNum = responseObject[@"phone"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
}

#pragma mark 聊天
-(void)Message:(NSString*)suppid
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    suppid = [user objectForKey:PTEID];

    // begin 赵官林 2016.5.26（功能：联系客服）
    // [self messageWithSuppid:suppid title:nil model:nil detailType:nil imageurl:nil];
    // end
    
    ContactKefuViewController *contact = [[ContactKefuViewController alloc]init];
    contact.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:contact animated:YES];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0) {//打电话
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNum]]];
    }
}

//联系卖家
- (IBAction)connectSeller:(UIButton *)sender {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString* suppid = [user objectForKey:PTEID];
    [self Message:suppid];
}
//拨打电话
- (IBAction)callPhone:(UIButton *)sender {
    if(phoneNum !=nil && ![phoneNum isEqual:[NSNull null]]) {
        UIActionSheet *phonesheet=[[UIActionSheet alloc]initWithTitle:@"联系卖家" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:@"%@",phoneNum], nil];
        [phonesheet showInView:self.view];
    }else{
        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        [mentionview showLable:@"抱歉,没有卖家电话" Controller:self];
    }
}

#pragma mark === UIPickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickerArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [pickerArray objectAtIndex:row];
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel * myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 180, 40)];
    myView.text = [pickerArray objectAtIndex:row];
    myView.textAlignment = NSTextAlignmentCenter;
    myView.font = [UIFont systemFontOfSize:ZOOM(45)];
    myView.backgroundColor = [UIColor clearColor];
    return myView;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

@end
/*
 
 -(void)timerThread
 {
 //    NSDate *fromDate=_orderModel.requestNow_time?[NSDate dateWithTimeIntervalSince1970:[_orderModel.requestNow_time doubleValue]/1000]:[NSDate dateWithTimeIntervalSince1970:[_orderModel.add_time doubleValue]/1000];
 //    secondsTime=[self timerTimeFromDate:fromDate toDate:[NSDate dateWithTimeIntervalSince1970:[_orderModel.lasttime doubleValue]/1000]];
 secondsTime=[_orderModel.lasttime doubleValue]/1000-[_orderModel.requestNow_time doubleValue]/1000;
 __block int timeout=secondsTime; //倒计时时间
 dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
 dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
 dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
 dispatch_source_set_event_handler(_timer, ^{
 if(timeout<=0){ //倒计时结束，关闭
 dispatch_source_cancel(_timer);
 
 dispatch_async(dispatch_get_main_queue(), ^{
 //设置界面的按钮显示 根据自己需求设置
 //                payTime.text=[NSString stringWithFormat:@"%@",[self payTimeLeft:[NSDate dateWithTimeIntervalSince1970:[_orderModel.lasttime doubleValue]/1000]]];
 //                payTime.text=@"0分0秒";
 [UIView animateWithDuration:0.3 animations:^{
 button1.alpha=0;
 [button1 removeFromSuperview];
 [payTime removeFromSuperview];
 [payTimeTitle removeFromSuperview];
 [button2 setTitle:@"删除订单" forState:UIControlStateNormal];
 button2.frame=CGRectMake(kApplicationWidth-80-ZOOM(60), 5, 80, 30);
 }];
 
 [self postNotification];
 });
 }else{
 
 dispatch_async(dispatch_get_main_queue(), ^{
 //设置界面的按钮显示 根据自己需求设置
 payTime.text=[NSString stringWithFormat:@"%@",[self payTimeLeftFromDate]];
 });
 timeout--;
 secondsTime--;
 
 }
 });
 dispatch_resume(_timer);
 }
 
 
 */
