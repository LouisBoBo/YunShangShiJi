//
//  SellorderViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/7/1.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "SellorderViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "NavgationbarView.h"
#import "MyMD5.h"
//#import "OrderDetailTableViewCell.h"
#import "ShopDetailViewController.h"
#import "OrderTableViewCell.h"
#import "LogisticsViewController.h"

//#import "ComboShopDetailViewController.h"
//#import "ChatViewController.h"
#import "RobotManager.h"

@interface SellorderViewController ()
{
    //商品列表
    UITableView *_ShopTableView;
    //商品列表数据源
//    NSMutableArray *_ShopArray;
    
//    OrderDetailModel *_Orderdetailmodel;
    
    UILabel *_timelab;
    UILabel *_addresslab;
    
    ShopDetailModel *_logisticsModel;
    NSMutableArray *_logisticsArray;


    NSString *phoneNum;             //电话号码
}
@end

@implementation SellorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    _ShopArray=[NSMutableArray array];
    _logisticsArray=[NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"订单详情";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];

//    [self requestHttp];
    
//    [self httpPhone];
    
    if (![self.orderModel.logi_code isEqual:[NSNull null]]&&self.orderModel.logi_code.length!=0) {
        [self GetlogHttp:self.orderModel.logi_code :self.orderModel.logi_name];
    }
    //创建视图
    [self creatview];

    [self fontAndSize];
}
-(void)fontAndSize
{
    _status.frame=CGRectMake(ZOOM(60),ZOOM(50), _status.frame.size.width, _status.frame.size.height);
    _ordercode.frame=CGRectMake(ZOOM(60),CGRectGetMaxY(_status.frame)+ZOOM(10), _ordercode.frame.size.width, _ordercode.frame.size.height);
    _creattime.frame=CGRectMake(ZOOM(60),CGRectGetMaxY(_ordercode.frame)+ZOOM(10), _creattime.frame.size.width, _creattime.frame.size.height);
    _paytime.frame=CGRectMake(ZOOM(60),CGRectGetMaxY(_creattime.frame)+ZOOM(10), _paytime.frame.size.width, _paytime.frame.size.height);
//    _payordercode.frame=CGRectMake(ZOOM(60),_payordercode.frame.origin.y, _payordercode.frame.size.width, _payordercode.frame.size.height);
    _buyer.frame=CGRectMake(ZOOM(60),_buyer.frame.origin.y, _buyer.frame.size.width, _buyer.frame.size.height);
    _mark.frame=CGRectMake(ZOOM(60),_mark.frame.origin.y, _mark.frame.size.width, _mark.frame.size.height);
    _addressImg.frame=CGRectMake(ZOOM(60),_addressImg.frame.origin.y, _addressImg.frame.size.width, _addressImg.frame.size.height);
    _consignee.frame=CGRectMake(_addressImg.frame.origin.x+_addressImg.frame.size.width+5,_consignee.frame.origin.y, _consignee.frame.size.width, _consignee.frame.size.height);
    _adress.frame=CGRectMake(_consignee.frame.origin.x,_adress.frame.origin.y, kApplicationWidth-ZOOM(60)-_consignee.frame.origin.x, _adress.frame.size.height);
    _phone.frame=CGRectMake(kApplicationWidth-_phone.frame.size.width- ZOOM(62),_phone.frame.origin.y, _phone.frame.size.width, _phone.frame.size.height);
    _relation.frame=CGRectMake(ZOOM(60),_relation.frame.origin.y, _relation.frame.size.width, _relation.frame.size.height);
    _callphone.frame=CGRectMake(kApplicationWidth-ZOOM(62)-_callphone.frame.size.width,_callphone.frame.origin.y, _callphone.frame.size.width, _callphone.frame.size.height);
    
    
    _relation.imageView.contentMode=UIViewContentModeScaleAspectFit;
    _callphone.imageView.contentMode=UIViewContentModeScaleAspectFit;
    
    _status.font=[UIFont systemFontOfSize:ZOOM(46)];
    _ordercode.font=[UIFont systemFontOfSize:ZOOM(40)];
    _payordercode.font=[UIFont systemFontOfSize:ZOOM(40)];
    _paytime.font=[UIFont systemFontOfSize:ZOOM(40)];
    _consignee.font=[UIFont systemFontOfSize:ZOOM(48)];
    _phone.font=[UIFont systemFontOfSize:ZOOM(48)];
    _adress.font=[UIFont systemFontOfSize:ZOOM(40)];

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

#pragma mark 查看物流
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
        
//        responseObject = [NSDictionary changeType:responseObject];
        //responseObject is %@",responseObject);
        NSString *str=responseObject[@"status"];
        NSString *message=responseObject[@"message"];
//        NSString *codenumber=responseObject[@"com"];
        NSArray *codenumber=responseObject[@"data"];
        if(codenumber.count !=0)
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
            for(NSDictionary *dic in responseObject[@"data"][0][@"lastResult"][@"data"])
            {
                ShopDetailModel *Logisticsmodel=[[ShopDetailModel alloc]init];
                Logisticsmodel.context=dic[@"context"];
                Logisticsmodel.ftime=dic[@"ftime"];
                Logisticsmodel.time=dic[@"time"];
                
                [_logisticsArray addObject:Logisticsmodel];
            }
            
            if(_logisticsArray.count)
            {
                ShopDetailModel *model=_logisticsArray[0];
                _addresslab.text=[NSString stringWithFormat:@"%@",model.context];
                _timelab.text=[NSString stringWithFormat:@"%@",model.ftime];
            }
            
            
            
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
            
        }
 
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
    }];
    
    
}



#if 0
-(void)requestHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@order/getOrderShop?version=%@&order_code=%@&token=%@",[NSObject baseURLStr],VERSION,self.orderModel.order_code,token];
    
    NSString *URL=[MyMD5 authkey:url];
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        //responseObject is %@",responseObject);
        
        
        
        NSString *message=responseObject[@"message"];
        NSArray *arr=responseObject[@"shops"];
        for(NSDictionary *dic in arr)
        {
            OrderDetailModel *model=[[OrderDetailModel alloc]init];
            model.add_time=dic[@"add_time"];
            model.bak=dic[@"bak"];
            model.color=dic[@"color"];
            model.ID=dic[@"id"];
            model.message=dic[@"message"];
        
            model.order_code=dic[@"order_code"];
            model.shop_code=dic[@"shop_code"];
            model.shop_name=dic[@"shop_name"];
            model.shop_num=dic[@"shop_num"];
            model.shop_pic=dic[@"shop_pic"];
            model.shop_price=dic[@"shop_price"];
            model.size=dic[@"size"];
            model.status=dic[@"status"];
            model.supp_id=dic[@"supp_id"];
            model.kickBack=dic[@"kickBack"];
            model.supp_money=dic[@"supp_money"];
            model.stocktypeid=dic[@"stocktypeid"];
            model.two_kickback=dic[@"two_kickback"];
            
            [_ShopArray addObject:model];
        }
        
        NSDictionary *dicc=responseObject[@"order"];
        
        _Orderdetailmodel=[[OrderDetailModel alloc]init];
        
        _Orderdetailmodel.add_time=dicc[@"add_time"];
        _Orderdetailmodel.address=dicc[@"address"];
        _Orderdetailmodel.consignee=dicc[@"consignee"];
        _Orderdetailmodel.order_code=dicc[@"order_code"];
        _Orderdetailmodel.order_price=dicc[@"order_price"];
        _Orderdetailmodel.phone=dicc[@"phone"];
        _Orderdetailmodel.postcode=dicc[@"postcode"];
        _Orderdetailmodel.status=dicc[@"status"];

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];

}
#endif

#pragma mark 创建视图
-(void)creatview
{
    self.Myscrollview.backgroundColor=kBackgroundColor;
    self.Myscrollview.frame=CGRectMake(0, Height_NavBar, kApplicationWidth,kApplicationHeight-Height_NavBar+kUnderStatusBarStartY);
    self.Myscrollview.backgroundColor=[UIColor whiteColor];
    //订单信息
    _Orderview.frame=CGRectMake(_Orderview.frame.origin.x, _Orderview.frame.origin.y, _Orderview.frame.size.width, 88+ZOOM(10)*3+ZOOM(50)*2);

    self.ordercode.text=[NSString stringWithFormat:@"订单号:%@",self.orderModel.order_code];
    NSString *timestr=[MyMD5 getTimeToShowWithTimestamp:self.orderModel.add_time];
    self.creattime.text=[NSString stringWithFormat:@"下单时间:%@",timestr];
    if (_orderModel.pay_time.floatValue!=0) {
        NSString *timestr2=[MyMD5 getTimeToShowWithTimestamp:self.orderModel.pay_time];
        self.paytime.text=[NSString stringWithFormat:@"支付时间:%@",timestr2];
    }else{
        _paytime.hidden=YES;
        _Orderview.frame=CGRectMake(_Orderview.frame.origin.x, _Orderview.frame.origin.y, _Orderview.frame.size.width, 68+ZOOM(10)*3+ZOOM(50)*2);
    }
    _buyerview.frame=CGRectMake(_buyerview.frame.origin.x, CGRectGetMaxY(_Orderview.frame), _buyerview.frame.size.width, _buyerview.frame.size.height);
//    self.payordercode.text=[NSString stringWithFormat:@"支付宝订单号:%@",self.orderModel.postcode];
    
    _ordercode.font=[UIFont systemFontOfSize:ZOOM(40)];
    _creattime.font=[UIFont systemFontOfSize:ZOOM(40)];
    _paytime.font=[UIFont systemFontOfSize:ZOOM(40)];
    _payordercode.font=[UIFont systemFontOfSize:ZOOM(40)];
    //买家
    self.buyer.text=[NSString stringWithFormat:@"买家:%@",self.orderModel.consignee];
    self.mark.text=[NSString stringWithFormat:@"备注:%@",@"希望买家早点发货"];
    self.mark.font=[UIFont systemFontOfSize:ZOOM(40)];
    self.buyer.font=[UIFont systemFontOfSize:ZOOM(48)];
    self.mark.textColor=kTextGreyColor;
    
    CGFloat logistViewHeigh=0;
    
    //订单状态
    NSString *statues=self.orderModel.status;
    switch (statues.intValue) {
        case 1:
            self.status.text=@"待付款";
            break;
        case 2:
            self.status.text=@"待发货";
            break;
        case 3:
            self.status.text=@"待收货";
            logistViewHeigh=90;
            break;
        case 4:
            self.status.text=@"待评价";
            logistViewHeigh=90;
            break;
        case 5:
            self.status.text=@"已评价";
            logistViewHeigh=90;
            break;
        case 6:
            
            self.status.text=@"已完结";
            break;
        case 7:
            self.status.text=@"延长收货";
            logistViewHeigh=90;
            break;
        case 8:
            self.status.text=@"退款成功";
            break;
        case 9:
            
            self.status.text=@"订单取消";
            break;
        default:
            break;
    }

    

    
    
    //物流信息
    UIView *logisticView=[[UIView alloc]initWithFrame:CGRectMake(0, _buyerview.frame.origin.y+_buyerview.frame.size.height, kApplicationWidth, logistViewHeigh)];
    
    UITapGestureRecognizer *logisttap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(logistclick:)];
    [logisticView addGestureRecognizer:logisttap];
    logisticView.userInteractionEnabled=YES;
    
    [self.Myscrollview addSubview:logisticView];
    logisticView.hidden=YES;
    
    UILabel *logisticlab=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(60)+25, 10, kApplicationWidth-50, 25)];
    logisticlab.text=@"物流信息";
    logisticlab.font=[UIFont systemFontOfSize:ZOOM(48)];
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(60), 32, 20, 20)];
    imageview.image=[UIImage imageNamed:@"椭圆-23"];
    
    UIImageView *imageview1=[[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(83), 32, 2, 50)];
    imageview1.image=[UIImage imageNamed:@"矩形-31"];
    
    [logisticView addSubview:imageview1];
    [logisticView addSubview:imageview];
    
    _addresslab=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(60)+25, 32, kApplicationWidth-50, 25)];
    _addresslab.text=@"物流信息";
    _addresslab.textColor=kGreenColor;
    _addresslab.font=[UIFont systemFontOfSize:ZOOM(40)];
    
    _timelab=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(60)+25, 55, kApplicationWidth-50, 25)];
    _timelab.text=@"物流信息";
    _timelab.textColor=kGreenColor;
    _timelab.font=[UIFont systemFontOfSize:ZOOM(40)];
    
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, logistViewHeigh, kApplicationWidth, 1)];
    line.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    logisticView.backgroundColor=[UIColor whiteColor];
    
    [logisticView addSubview:logisticlab];
    [logisticView addSubview:_addresslab];
    [logisticView addSubview:_timelab];
    [logisticView addSubview:line];

    
    
    //商品信息
    //商品列表
    self.shopview.frame=CGRectMake(self.shopview.frame.origin.x, CGRectGetMaxY(_buyerview.frame)+logistViewHeigh, kApplicationWidth,self.shopview.frame.size.height+logistViewHeigh);
    
    CGFloat shopHeigh=ZOOM(62)+ZOOM(350);
    CGFloat tableviewHeigh=shopHeigh*self.orderModel.shopsArray.count+30;
    
    //在商品列表创建列表视图
    _ShopTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth,tableviewHeigh) style:UITableViewStylePlain];
    _ShopTableView.dataSource=self;
    _ShopTableView.delegate=self;
    _ShopTableView.rowHeight=ZOOM(62)+ZOOM(350);
    _ShopTableView.bounces=NO;
    _ShopTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.shopview addSubview:_ShopTableView];
    [_ShopTableView registerNib:[UINib nibWithNibName:@"OrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    
    CGFloat shopviewHeigh=tableviewHeigh;
    //商品列表
    self.shopview.frame=CGRectMake(self.shopview.frame.origin.x, self.shopview.frame.origin.y, kApplicationWidth,shopviewHeigh);

    //footview
    
//    UIView *tabelfootview=[[UIView alloc]initWithFrame:CGRectMake(0, self.shopview.frame.origin.y+self.shopview.frame.size.height, kApplicationWidth, 30)];
//    tabelfootview.backgroundColor=[UIColor whiteColor];
//    UILabel *totallable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth-ZOOM(42), 30)];
//    
//    totallable.text=[NSString stringWithFormat:@"共%ld件商品        实付:￥%@",self.orderModel.shopsArray.count,self.orderModel.order_price];
//    
//    totallable.font=[UIFont systemFontOfSize:ZOOM(44)];
//    totallable.textAlignment=NSTextAlignmentRight;
//    [tabelfootview addSubview:totallable];
//    [self.Myscrollview addSubview:tabelfootview];

    UIView *tabelfootview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 30)];
    tabelfootview.backgroundColor=[UIColor whiteColor];
    UILabel *totallable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth-ZOOM(62), 30)];
    
    totallable.text=[NSString stringWithFormat:@"共%ld件商品        实付:¥%.2f",(unsigned long)self.orderModel.shopsArray.count,self.orderModel.order_price.floatValue];
    
    totallable.font=[UIFont systemFontOfSize:ZOOM(44)];
    totallable.textAlignment=NSTextAlignmentRight;
    [tabelfootview addSubview:totallable];
    _ShopTableView.tableFooterView=tabelfootview;
    
    //收货人信息
    self.addressview.frame=CGRectMake(0, self.shopview.frame.origin.y+self.shopview.frame.size.height+ZOOM(32), kApplicationWidth, self.addressview.frame.size.height);
    
    self.consignee.text=[NSString stringWithFormat:@"收件人:%@",self.orderModel.consignee];
    self.phone.text=self.orderModel.phone;
    self.adress.text=[NSString stringWithFormat:@"收货地址:%@",self.orderModel.address];
    
    //联系买家
    self.serverview.frame=CGRectMake(0, self.addressview.frame.origin.y+self.addressview.frame.size.height, kApplicationWidth, self.serverview.frame.size.height);
    
    self.relation.layer.borderWidth=1;
    self.relation.layer.borderColor=lineGreyColor.CGColor;
    [self.relation setTitleColor:kTextGreyColor forState:UIControlStateNormal];
    [self.relation addTarget:self action:@selector(relationclick:) forControlEvents:UIControlEventTouchUpInside];
    
    //拨打电话
    self.relation.frame = CGRectMake(ZOOM(62),self.relation.frame.origin.y, (kScreenWidth-3*(ZOOM(61)))/2, 30);
    self.callphone.frame = CGRectMake(kApplicationWidth-ZOOM(62)-_relation.frame.size.width,_callphone.frame.origin.y, (kScreenWidth-3*(ZOOM(61)))/2, 30);
    self.callphone.layer.borderWidth=1;
    self.callphone.layer.borderColor=lineGreyColor.CGColor;
    [self.callphone setTitleColor:kTextGreyColor forState:UIControlStateNormal];
    [self.callphone addTarget:self action:@selector(phoneclick:) forControlEvents:UIControlEventTouchUpInside];
    
    //下面带有提醒功能的视图
    UIView *foorview=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 50)];
    foorview.hidden=NO;
    foorview.tag=8989;
    foorview.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    //提示按钮
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.frame=CGRectMake(kApplicationWidth-90, 5, 80, 40);
    [button1 setTitle:@"" forState:UIControlStateNormal];
    button1.layer.cornerRadius=5;
    button1.layer.borderWidth=0.5;
    button1.tintColor=[UIColor blackColor];
    
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame=CGRectMake(kApplicationWidth-90*2, 5, 80, 40);
    [button2 setTitle:@"" forState:UIControlStateNormal];
    button2.layer.cornerRadius=5;
    button2.layer.borderWidth=0.5;
    button2.tintColor=[UIColor blackColor];
    
    
    UIButton *button3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button3.frame=CGRectMake(kApplicationWidth-90*3, 5, 80, 40);
    [button3 setTitle:@"" forState:UIControlStateNormal];
    button3.layer.cornerRadius=5;
    button3.layer.borderWidth=0.5;
    button3.tintColor=[UIColor blackColor];
    
    button1.hidden=NO;
    button2.hidden=NO;
    button3.hidden=NO;
    NSString *statue=self.orderModel.status;
    if(statue.intValue==1)
    {
        [button1 setTitle:@"联系买家" forState:UIControlStateNormal];
      
        button2.hidden=YES;
        button3.hidden=YES;
        
    }else if (statue.intValue==2)
    {

        [button1 setTitle:@"提醒发货" forState:UIControlStateNormal];

        button2.hidden=YES;
        button3.hidden=YES;
    }else if (statue.intValue==3)
    {
        logisticView.hidden=NO;

        [button1 setTitle:@"查看物流" forState:UIControlStateNormal];
       
        button2.hidden=YES;
        button3.hidden=YES;
        
    }else if (statue.intValue==4)
    {
        logisticView.hidden=NO;
        
        [button1 setTitle:@"评价客户" forState:UIControlStateNormal];
        [button2 setTitle:@"查看物流" forState:UIControlStateNormal];

        button3.hidden=YES;
    }else if (statue.intValue==5)
    {
        logisticView.hidden=NO;
        [button1 setTitle:@"钱款去向" forState:UIControlStateNormal];
        
        button2.hidden=YES;
        button3.hidden=YES;
    }else if (statue.intValue==6)
    {
        foorview.hidden=YES;
//        UIView *view=(UIView*)[self.view viewWithTag:8989];
//        [view removeFromSuperview];
        
        
        button1.hidden=YES;
        button2.hidden=YES;
        button3.hidden=YES;
    }else if (statue.intValue==7)
    {
        logisticView.hidden=NO;
        
        [button1 setTitle:@"查看物流" forState:UIControlStateNormal];

        button2.hidden=YES;
        button3.hidden=YES;
    }else if (statue.intValue==8)
    {
        [button1 setTitle:@"钱款去向" forState:UIControlStateNormal];
        
        button2.hidden=YES;
        button3.hidden=YES;
    }else if (statue.intValue==9)
    {
        foorview.hidden=YES;
//        UIView *view=(UIView*)[self.view viewWithTag:8989];
//        [view removeFromSuperview];
        
        button1.hidden=YES;
        button2.hidden=YES;
        button3.hidden=YES;
    }
    
    [button1 addTarget:self action:@selector(click11:) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(click22:) forControlEvents:UIControlEventTouchUpInside];
    [button3 addTarget:self action:@selector(click33:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.view addSubview:foorview];
    [foorview addSubview:button1];
    [foorview addSubview:button2];
    [foorview addSubview:button3];
    
    CGFloat heigh;
    if(foorview.hidden==NO)
    {
        heigh=0;
    }else{
        heigh=-50;
    }

    self.Myscrollview.contentSize=CGSizeMake(0, self.Orderview.frame.size.height+self.buyerview.frame.size.height+self.shopview.frame.size.height+self.addressview.frame.size.height+logistViewHeigh+self.serverview.frame.size.height);
//    self.Myscrollview.backgroundColor=[UIColor groupTableViewBackgroundColor];

}

#pragma mark 查看物流
-(void)logistclick:(UITapGestureRecognizer*)tap
{
    LogisticsViewController *logistics=[[LogisticsViewController alloc]init];
    logistics.Ordermodel=self.orderModel;
    [self.navigationController pushViewController:logistics animated:YES];
}


#pragma mark 处理订单
-(void)click11:(UIButton*)sender
{
    if([sender.titleLabel.text isEqualToString:@"付款"])
    {
        
    }else if ([sender.titleLabel.text isEqualToString:@"提醒发货"])
    {
        
    }else if ([sender.titleLabel.text isEqualToString:@"确认收货"])
    {

        
    }else if ([sender.titleLabel.text isEqualToString:@"评价订单"])
    {
       
        
    }else if ([sender.titleLabel.text isEqualToString:@"钱款去向"])
    {
       
    }
}

-(void)click22:(UIButton*)sender
{
    if([sender.titleLabel.text isEqualToString:@"付款"])
    {
       
        
    }else if ([sender.titleLabel.text isEqualToString:@"提醒发货"])
    {
        
    }else if ([sender.titleLabel.text isEqualToString:@"确认收货"])
    {
        
        
    }else if ([sender.titleLabel.text isEqualToString:@"评价订单"])
    {
        
        
    }else if ([sender.titleLabel.text isEqualToString:@"钱款去向"])
    {
        
    }

}

-(void)click33:(UIButton*)sender
{
    if([sender.titleLabel.text isEqualToString:@"付款"])
    {
        
    }else if ([sender.titleLabel.text isEqualToString:@"提醒发货"])
    {
        
    }else if ([sender.titleLabel.text isEqualToString:@"确认收货"])
    {
        
        
    }else if ([sender.titleLabel.text isEqualToString:@"评价订单"])
    {
        
        
    }else if ([sender.titleLabel.text isEqualToString:@"钱款去向"])
    {
        
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orderModel.shopsArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.orderModel.shop_from.intValue==1)
    {
        
//        ComboShopDetailViewController *detail=[[ComboShopDetailViewController alloc] initWithNibName:@"ComboShopDetailViewController" bundle:nil];
//        detail.shop_code = self.orderModel.bak;
//        detail.stringtype = @"订单详情";
//        detail.hidesBottomBarWhenPushed=YES;
//        [self.navigationController pushViewController:detail animated:YES];
    }else{
        OrderDetailModel *model=self.orderModel.shopsArray[indexPath.row];
        
        ShopDetailViewController *shopdetail=[[ShopDetailViewController alloc]init];
        shopdetail.shop_code=model.shop_code;
        OrderTableViewCell *cell = (OrderTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        shopdetail.stringtype = @"订单详情";
        shopdetail.bigimage=cell.headimage.image;
        
        [self.navigationController pushViewController:shopdetail animated:NO];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell=[[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    if (self.orderModel.shop_from.intValue==1) {
        [cell refreshZeroData:self.orderModel];
        cell.zeroLabel.hidden=NO;
        cell.color_size.hidden=YES;
    }else{
        ShopDetailModel *model=self.orderModel.shopsArray[indexPath.row];
        [cell refreshData1:model];
        cell.zeroLabel.hidden=YES;
        cell.color_size.hidden=NO;
    }
   
    
    cell.number.hidden=YES;
    cell.statue.hidden=YES;
//    cell.delegate=self;
//    cell.row=indexPath.row;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma  mark - *****************请求电话号码
-(void)httpPhone
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    ShopDetailModel *model = self.orderModel.shopsArray[0];

    NSString *url=[NSString stringWithFormat:@"%@order/getSuppPhone?version=%@&token=%@&supp_id=%@",[NSObject baseURLStr],VERSION,token,model.suppid];
    NSString *URL=[MyMD5 authkey:url];
    [manager GET:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
//            responseObject = [NSDictionary changeType:responseObject];
            phoneNum = responseObject[@"phone"];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];
    
}
#pragma mark 联系买家
-(void)relationclick:(UIButton*)sender
{
//    ShopDetailModel *model = self.orderModel.shopsArray[0];
    //联系买家%@",_orderModel.user_id);
    [self Message:[NSString stringWithFormat:@"%@",_orderModel.user_id]];
}
#pragma mark 聊天
-(void)Message:(NSString*)suppid
{
    // begin 赵官林 2016.5.26
    [self messageWithSuppid:suppid title:nil model:nil detailType:nil imageurl:nil];
    // end
}
#pragma mark 拨打电话
-(void)phoneclick:(UIButton*)sender
{
    //拨打电话");
    if(self.orderModel.phone !=nil && ![self.orderModel.phone isEqual:[NSNull null]])
    {
        
        UIActionSheet *phonesheet=[[UIActionSheet alloc]initWithTitle:@"联系买家" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:@"%@",self.orderModel.phone], nil];
        [phonesheet showInView:self.view];
        
    }else{
        
        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        [mentionview showLable:@"抱歉,没有买家电话" Controller:self];

    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)//打电话
    {

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.orderModel.phone]]];

    }
}

-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
