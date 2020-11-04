//
//  ChangeDetailViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/7/14.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "ChangeDetailViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "NavgationbarView.h"
#import "MyMD5.h"
#import "DXAlertView.h"
#import "AftersaleViewController.h"
#import "LoginViewController.h"
//#import "ChatListViewController.h"
#import "RerundViewController.h"

@interface ChangeDetailViewController ()
{
    //计时器 天 时 分 秒
    NSString *_day;
    NSString *_hour;
    NSString *_min;
    NSString *_sec;
    
    NSString *_lasttime;

}
@end

@implementation ChangeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
    titlelable.text=self.titlestring;
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
//    
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
//    [self creatview:self.dic];//待审核
    
    if (_orderModel==nil) {
        [self creatview:_dic];
    }else
        [self changViewInformation:_orderModel];

    
//    [self requestHttp];
    
    if([self.titlestring isEqualToString:@"退货详情"])
    {
    
    }else if ([self.titlestring isEqualToString:@"换货详情"])
    {
    
    }else if ([self.titlestring isEqualToString:@"退款详情"])
    {
        
    }

}

-(void)tomessage:(UIButton*)sender
{
    // begin 赵官林 2016.5.26 跳转到消息列表
    [self presentChatList];
    // end
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
    if ([self.navigationController.viewControllers[self.navigationController.viewControllers.count-2] isKindOfClass:[RerundViewController class]]&&
        [self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    if ([self.navigationController.viewControllers[self.navigationController.viewControllers.count-2] isKindOfClass:[RerundViewController class]] &&
        [self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

/*
#pragma mark 查看详情网络请求
-(void)requestHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    
    NSString *url=[NSString stringWithFormat:@"%@returnShop/findOne?version=%@&token=%@&order_code=%@",[NSObject baseURLStr],VERSION,token,self.ordercode];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        //responseObject is %@",responseObject);
        
        if (responseObject!=nil) {
            NSString *message;
            NSString *str=[NSString stringWithFormat:@"%@",responseObject[@"status"]];
            if(str.intValue==1)
            {
                NSDictionary *dic=responseObject[@"returnShop"];
                NSString *statue=dic[@"status"];
                if(statue.intValue==1)
                {
                    [self creatview:dic];//待审核
                }else{
                    [self creatPassview:dic];//审核通过
                }
            }else{
                
                
            }
            
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
    }];
    


}
*/
#pragma mark 撤消售后
-(void)cancleHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    //id  %@  %@",_orderModel.ID,_dic[@"id"]);
    NSString *url;
    if (_orderModel==nil) {
        url=[NSString stringWithFormat:@"%@returnShop/escReturn?version=%@&token=%@&id=%@",[NSObject baseURLStr],VERSION,token,_dic[@"id"]];
    }else
        url=[NSString stringWithFormat:@"%@returnShop/escReturn?version=%@&token=%@&id=%@",[NSObject baseURLStr],VERSION,token,_orderModel.ID];

    
    NSString *URL=[MyMD5 authkey:url];
    
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        //responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *message;
            NSString *str=[NSString stringWithFormat:@"%@",responseObject[@"status"]];
            if(str.intValue==1)
            {
                message=@"撤消成功";
                [MBProgressHUD showSuccess:message];
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[AftersaleViewController class]]) {
                        [self.navigationController popToViewController:controller animated:YES];
                    }
                }
                //撤消售后返回上一视图
//                [self.navigationController popViewControllerAnimated:YES];
                
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
                
                message=responseObject[@"message"];
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
    }];


}

#pragma mark 创建视图
-(void)changViewInformation:(OrderModel *)model
{
    NSString *addtime;
    
    NSString *time = [NSString stringWithFormat:@"%@",model.add_time];
    //    if (dic[@"add_time"]!=nil && [NSString stringWithFormat:@"%@",dic[@"add_time"]].length!=0 && ![dic[@"add_time"]isEqualToString:@"<null>"] ) {
    if (time !=nil && ![time isEqualToString:@"<null>"]) {
        addtime=[MyMD5 getTimeToShowWithTimestamp:[NSString stringWithFormat:@"%@",model.add_time]];
    }else{
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
        addtime=[formatter stringFromDate:[NSDate date]];
    }
    
    //addtime   %@",addtime);
    
    if([self.titlestring isEqualToString:@"退货详情"])
    {
        
        self.timelable.text=[NSString stringWithFormat:@"退货时间:%@",addtime];
        self.titlelable.text=@"申请退货";
        self.statuelable.text=@"你申请了退货/退款";
        [self.statuebtn setTitle:@"取消退货/退款" forState:UIControlStateNormal];
        
        if(model.cause !=nil)
        {
            self.causelable.text=[NSString stringWithFormat:@"退货原因:%@",model.cause];
        }
    }else if ([self.titlestring isEqualToString:@"换货详情"])
    {
        
        self.timelable.text=[NSString stringWithFormat:@"换货时间:%@",addtime];
        self.titlelable.text=@"申请换货";
        self.statuelable.text=@"你申请了换货";
        [self.statuebtn setTitle:@"取消换货" forState:UIControlStateNormal];
        
        
        if(model.cause !=nil)
        {
            self.causelable.text=[NSString stringWithFormat:@"换货原因:%@",model.cause];
        }
        
    }else if ([self.titlestring isEqualToString:@"退款详情"])
    {
        self.timelable.text=[NSString stringWithFormat:@"退款时间:%@",addtime];
        self.titlelable.text=@"申请退款";
        self.statuelable.text=@"你申请了退款";
        [self.statuebtn setTitle:@"取消退款" forState:UIControlStateNormal];
        
        if(model.cause !=nil)
        {
            self.causelable.text=[NSString stringWithFormat:@"退款原因:%@",model.cause];
        }
        
    }
    
    [self.statuebtn addTarget:self action:@selector(cnacleclick:) forControlEvents:UIControlEventTouchUpInside];
//    self.statuebtn.hidden=model.shop_from.integerValue==-2?YES:NO;
    
    self.pricelable.text=[NSString stringWithFormat:@"订单金额(包邮):¥%.2f",[model.money doubleValue]];
    self.codelable.text=[NSString stringWithFormat:@"订单号:%@", model.order_code];
    
    
    self.shangjia.text=@"等待商家处理";

    
    
    
    //时间计时器
    NSString *timestring=[NSString stringWithFormat:@"%@",model.lasttime];
    _lasttime=timestring;
    
    [NSTimer weakTimerWithTimeInterval:0.1f target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    
    
    
    self.addtime.text=[NSString stringWithFormat:@"%@",addtime];
    
    self.statuelable.textColor=kTextGreyColor;
    self.addtime.textColor=kTextGreyColor;
    self.causelable.textColor=kTextGreyColor;
    self.timego.textColor=kTextGreyColor;
    
    
    
    [self fontAndSize];
}
#pragma mark 创建视图
-(void)creatview:(NSDictionary*)dic
{
    NSString *addtime;

    NSString *time = [NSString stringWithFormat:@"%@",dic[@"add_time"]];
//    if (dic[@"add_time"]!=nil && [NSString stringWithFormat:@"%@",dic[@"add_time"]].length!=0 && ![dic[@"add_time"]isEqualToString:@"<null>"] ) {
    if (time !=nil && ![time isEqualToString:@"<null>"]) {
       addtime=[MyMD5 getTimeToShowWithTimestamp:[NSString stringWithFormat:@"%@",dic[@"add_time"]]];
    }else{

        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
        addtime=[formatter stringFromDate:[NSDate date]];
    }
    
    //addtime   %@",addtime);
    
    if([self.titlestring isEqualToString:@"退货详情"])
    {
        
        self.timelable.text=[NSString stringWithFormat:@"退货时间:%@",addtime];
        self.titlelable.text=@"申请退货";
        self.statuelable.text=@"你申请了退货/退款";
        [self.statuebtn setTitle:@"取消退货/退款" forState:UIControlStateNormal];
        
        if(dic[@"cause"] !=nil)
        {
            self.causelable.text=[NSString stringWithFormat:@"退货原因:%@",dic[@"cause"]];
        }
    }else if ([self.titlestring isEqualToString:@"换货详情"])
    {
        
        self.timelable.text=[NSString stringWithFormat:@"换货时间:%@",addtime];
        self.titlelable.text=@"申请换货";
        self.statuelable.text=@"你申请了换货";
        [self.statuebtn setTitle:@"取消换货" forState:UIControlStateNormal];
        
        
        if(dic[@"cause"] !=nil)
        {
            self.causelable.text=[NSString stringWithFormat:@"换货原因:%@",dic[@"cause"]];
        }

    }else if ([self.titlestring isEqualToString:@"退款详情"])
    {
        self.timelable.text=[NSString stringWithFormat:@"退款时间:%@",addtime];
        self.titlelable.text=@"申请退款";
        self.statuelable.text=@"你申请了退款";
        [self.statuebtn setTitle:@"取消退款" forState:UIControlStateNormal];
        
        if(dic[@"cause"] !=nil)
        {
            self.causelable.text=[NSString stringWithFormat:@"退款原因:%@",dic[@"cause"]];
        }

    }
    
    [self.statuebtn addTarget:self action:@selector(cnacleclick:) forControlEvents:UIControlEventTouchUpInside];
//    self.statuebtn.hidden=[dic[@"order_shop_id"]integerValue]==-2?YES:NO;
    self.pricelable.text=[NSString stringWithFormat:@"订单金额(包邮):¥%.2f",[dic[@"shop_price"] doubleValue]];
    self.codelable.text=[NSString stringWithFormat:@"订单号:%@",dic[@"order_code"]];
    
    
    self.shangjia.text=@"等待商家处理";
    self.timego.text=dic[@""];
  
   
    
    //时间计时器
    NSString *timestring=[NSString stringWithFormat:@"%@",dic[@"last_time"]];
    _lasttime=timestring;
    
    [NSTimer weakTimerWithTimeInterval:0.1f target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];

    
    
    self.addtime.text=[NSString stringWithFormat:@"%@",addtime];
    
    self.statuelable.textColor=kTextGreyColor;
    self.addtime.textColor=kTextGreyColor;
    self.causelable.textColor=kTextGreyColor;
    self.timego.textColor=kTextGreyColor;
    
    
    
    [self fontAndSize];
}
-(void)fontAndSize
{
    
    self.blackView.frame=CGRectMake(0, _blackView.frame.origin.y, _blackView.frame.size.width, 88+ZOOM(10)*3+ZOOM(50)*2);
    self.titlelable.frame=CGRectMake(ZOOM(62), ZOOM(50), self.titlelable.frame.size.width, self.titlelable.frame.size.height);
    self.pricelable.frame=CGRectMake(ZOOM(62), CGRectGetMaxY(_titlelable.frame)+ZOOM(10), self.pricelable.frame.size.width, self.pricelable.frame.size.height);;
    self.codelable.frame=CGRectMake(ZOOM(62), CGRectGetMaxY(_pricelable.frame)+ZOOM(10), self.codelable.frame.size.width, self.codelable.frame.size.height);;
    self.timelable.frame=CGRectMake(ZOOM(62), CGRectGetMaxY(_codelable.frame)+ZOOM(10), self.timelable.frame.size.width, self.timelable.frame.size.height);;
    
    
    self.shangjia.frame=CGRectMake(ZOOM(62), CGRectGetMaxY(_blackView.frame)+ZOOM(62), self.shangjia.frame.size.width, self.shangjia.frame.size.height);;
    self.timego.frame=CGRectMake(ZOOM(62),CGRectGetMaxY(_shangjia.frame)+ZOOM(10), kApplicationWidth-ZOOM(62)*2, self.timego.frame.size.height);;
    self.statuebtn.frame=CGRectMake(ZOOM(62), CGRectGetMaxY(_timego.frame)+ZOOM(120), kApplicationWidth-ZOOM(62)*2, self.statuebtn.frame.size.height);;
    self.statuelable.frame=CGRectMake(ZOOM(62), CGRectGetMaxY(_statuebtn.frame)+ZOOM(120), self.statuelable.frame.size.width, self.statuelable.frame.size.height);;
    self.addtime.frame=CGRectMake(kApplicationWidth-self.addtime.frame.size.width-ZOOM(62),CGRectGetMinY(_statuelable.frame), self.addtime.frame.size.width, self.addtime.frame.size.height);;
    self.causelable.frame=CGRectMake(ZOOM(62), CGRectGetMaxY(_statuelable.frame)+ZOOM(10), self.causelable.frame.size.width, self.causelable.frame.size.height);
    
    
    self.titlelable.font=[UIFont systemFontOfSize:ZOOM(50)];
    self.pricelable.font=[UIFont systemFontOfSize:ZOOM(46)];
    self.codelable.font=[UIFont systemFontOfSize:ZOOM(46)];
    self.timelable.font=[UIFont systemFontOfSize:ZOOM(46)];
    self.shangjia.font=[UIFont systemFontOfSize:ZOOM(50)];
    self.timego.font=[UIFont systemFontOfSize:ZOOM(46)];
    self.statuebtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(50)];
    self.statuelable.font=[UIFont systemFontOfSize:ZOOM(46)];
    self.addtime.font=[UIFont systemFontOfSize:ZOOM(46)];
    self.causelable.font=[UIFont systemFontOfSize:ZOOM(46)];
}
-(void)creatPassview:(NSDictionary*)dic
{


}



//.倒计时的实现
- (void)timerFireMethod:(NSTimer *)timer
{
    
    NSString *timestring=[NSString stringWithFormat:@"%@",_lasttime];
    NSString *time=[MyMD5 getTimeToShowWithTimestamp:timestring];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    NSDate *compareDate=[formatter dateFromString:time];//目标时间
    
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDate *today = [NSDate date];//当前时间
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *d = [calendar components:unitFlags fromDate:today toDate:compareDate options:0];//计算时间差
    
    _day=[NSString stringWithFormat:@"%d",[d day]];
    _hour=[NSString stringWithFormat:@"%d",[d hour]];
    _min=[NSString stringWithFormat:@"%d",[d minute]];
    _sec=[NSString stringWithFormat:@"%d",[d second]];
    
    
    self.timego.text=[NSString stringWithFormat:@"商家在%@天%@小时%@分%@秒内未处理,将自动同意.",_day,_hour,_min,_sec];
}


-(void)cnacleclick:(UIButton*)sender
{
    [self cancleHttp];//撤消售后

    /*
    NSString *str;
    
    NSString *title=sender.titleLabel.text;
    if([title isEqualToString:@"取消退货/退款"])
    {
        str=@"亲,确认取消退货/退款吗?";
        
    }else if ([title isEqualToString:@"取消换货"])
    {
        str=@"亲,确认取消换货吗?";
    }else if ([title isEqualToString:@"取消退款"])
    {
        str=@"亲,确认取消退款吗?";
    }
    
    
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:str contentText:@"撤消后,将不能再次申请哦!" leftButtonTitle:@"取消" rightButtonTitle:@"确认"];
    [alert show];
    alert.leftBlock = ^() {
        //left button clicked");//取消
        
    };
    alert.rightBlock = ^() {
        //right button clicked");//确认
        
        [self cancleHttp];//撤消售后

    };
    alert.dismissBlock = ^() {
        //Do something interesting after dismiss block");
    };

    
    */
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)back
{
//    AskforSaleViewController *askfor=[[AskforSaleViewController alloc]init];
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[AftersaleViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    
//    [self.navigationController pushViewController:askfor animated:YES];
    
//    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
}
@end
