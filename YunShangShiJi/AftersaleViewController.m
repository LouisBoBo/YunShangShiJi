//
//  AftersaleViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/23.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "AftersaleViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "MyMD5.h"
#import "MJRefresh.h"
#import "OrderModel.h"
#import "UIImageView+WebCache.h"
#import "NavgationbarView.h"
#import "MyorderTableViewCell.h"
#import "MoneyGoViewController.h"
#import "RefunddetailViewController.h"
#import "RefundAndReturnViewController.h"
#import "ServiceViewController.h"
#import "OrderTableViewCell.h"
#import "ChangeDetailViewController.h"
#import "AskforChangeViewController.h"
#import "AskforSaleViewController.h"
#import "SuccessRerundViewController.h"
#import "CancleViewController.h"
#import "SuccessChangeViewController.h"
#import "AskforSaleViewController.h"
//#import "ChatListViewController.h"
#import "SaleDetailViewController.h"
#import "LoginViewController.h"

#import "YSSJInterveneViewController.h"
#import "InterveneDetailViewController.h"

#define segmentTag        99


@interface AftersaleViewController ()<changeTitleDelegate>
{
    UITableView *_Mytableview;
    NSMutableArray *_shopArray;

    //商品刷新到第几页
    NSInteger _currentpage;
    //商品总页数
    NSString *_pageCount;
    
    //记录是买单 还是卖单
    NSString *_titlestring;
    
    //售后类别
    NSString *_saletitle;
}
@end

@implementation AftersaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _currentpage=1;
    _shopArray=[NSMutableArray array];
    _titlestring=@"已买商品";
    
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
    titlelable.frame=CGRectMake(0, 0, 100, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"退款/售后";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];

//    UIButton *searchbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    searchbtn.frame=CGRectMake(kApplicationWidth - 40, 30, 25, 25);
//    //    searchbtn.titleLabel.font=[UIFont systemFontOfSize:12];
//    searchbtn.tintColor=[UIColor blackColor];
//    //    [searchbtn setBackgroundImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
//    [searchbtn setImage:[UIImage imageNamed:@"设置"]  forState:UIControlStateNormal];
//    searchbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [searchbtn addTarget:self action:@selector(tomessage:) forControlEvents:UIControlEventTouchUpInside];
//    [headview addSubview:searchbtn];

    
    //获得所有DB中未读消息数量
//    NSInteger unReadMessageCount=[[EaseMob sharedInstance].chatManager loadTotalUnreadMessagesCountFromDatabase];
//    
//    UILabel *messagecount=[[UILabel alloc]initWithFrame:CGRectMake(20, -10, 20, 20)];
//    messagecount.text=[NSString stringWithFormat:@"%d",unReadMessageCount];
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

    
    [self creatView];
    [self creatTableview];
}
#pragma mark 信息
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

    if ([_titlestring isEqualToString:@"已买商品"]) {
        _currentpage = 1;
        [self requestHttp:_currentpage];
    }else{
        _currentpage = 1;
        [self requestSellHttp:_currentpage];
    }


}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidDisappear:YES];
//    if ([_titlestring isEqualToString:@"已买商品"]) {
//        _currentpage = 1;
//        [self requestHttp:_currentpage];
//    }else{
//        _currentpage = 1;
//        [self requestSellHttp:_currentpage];
//    }
    
     [_Mytableview reloadData];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}

/*
#pragma mark 网络请求(买单)
-(void)requestHttp:(NSInteger)page
{
    //    [_dataArray removeAllObjects];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    
    NSString *cutpage=[NSString stringWithFormat:@"%d",page];
    NSString *url=[NSString stringWithFormat:@"%@order/getBuyOrder?version=%@&token=%@&pager.curPage=%@&status=%@&Change=-1&order=desc",[NSObject baseURLStr],VERSION,token,cutpage,@"0"];
    
    NSString *URL=[MyMD5 authkey:url];
    
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        if (responseObject!=nil) {
            if(page==1){
                [_shopArray removeAllObjects];
            }
            _Mytableview.hidden=NO;
            //responseObject is %@",responseObject);
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            _pageCount=responseObject[@"pageCount"];
            
            
            if(str.intValue==1)
            {
                
                NSArray *arr=responseObject[@"orders"];
                if(arr.count>0)
                {
                    for(NSDictionary *dic in arr)
                    {
                        OrderModel *model=[[OrderModel alloc]init];
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
                        model.order_price=dic[@"order_price"];
                        model.shop_num=dic[@"shop_num"];
                        model.address=dic[@"supp_address"];
                        model.consignee=dic[@"supp_consignee"];
                        model.phone=dic[@"phone"];
                        model.change=dic[@"change"];
                        
                        
                        
                        NSArray *brr=dic[@"orderShops"];
                        for(NSDictionary *dicc in brr)
                        {
                            OrderModel *shopmodel=[[OrderModel alloc]init];
                            
                            shopmodel.shop_color=dicc[@"color"];
                            shopmodel.ID=dicc[@"id"];
                            shopmodel.order_code=dicc[@"order_code"];
                            shopmodel.shop_code=dicc[@"shop_code"];
                            shopmodel.shop_name=dicc[@"shop_name"];
                            shopmodel.shop_num=dicc[@"shop_num"];
                            shopmodel.shop_pic=dicc[@"shop_pic"];
                            shopmodel.shop_price=dicc[@"shop_price"];
                            shopmodel.shop_size=dicc[@"size"];
                            shopmodel.suppid=dicc[@"supp_id"];
                            shopmodel.status=dicc[@"status"];
                            shopmodel.change=model.change;
                            
                            [model.shopsArray addObject:shopmodel];
                            
                        }
                        
                        
                        [_shopArray addObject:model];
                    }
                    
                    UIView *backview=(UIView*)[self.view viewWithTag:8789];
                    [backview removeFromSuperview];
                    
                    [_Mytableview reloadData];
                }else{
                    //                [_Mytableview removeFromSuperview];
                    [self creatBackview];
                }
                
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
                
                
                
                
                //            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                //            [mentionview showLable:message Controller:self];
            }

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
        if(page<1)
        {
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    
    
    
}

*/
#pragma mark 网络请求(买单)
-(void)requestHttp:(NSInteger)page
{
    //    [_dataArray removeAllObjects];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];

    
    NSString *cutpage=[NSString stringWithFormat:@"%d",page];
    NSString *url=[NSString stringWithFormat:@"%@returnShop/queryByPage?version=%@&token=%@&page=%@&is_buy=%@&order=desc&sort=id",[NSObject baseURLStr],VERSION,token,cutpage,@"0"];
    
    NSString *URL=[MyMD5 authkey:url];
    
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        MyLog(@"%@",responseObject);
        //responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if(page==1){
                [_shopArray removeAllObjects];
            }
            _Mytableview.hidden=NO;
            //responseObject is %@",responseObject);
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            _pageCount=responseObject[@"pageCount"];
            
            
            if(str.intValue==1)
            {
                
                NSArray *arr=responseObject[@"data"];
                if(arr.count>0)
                {
                    for(NSDictionary *dic in arr)
                    {
                        OrderModel *model=[[OrderModel alloc]init];
                        model.add_time=dic[@"add_time"];
                        model.address=dic[@"address"];
                        model.cause=dic[@"cause"];
                        model.explain=dic[@"explain"];
                        model.consignee=dic[@"consignee"];
                        model.free=dic[@"free"];
                        model.lasttime=dic[@"last_time"];
                        model.money=dic[@"money"];
                        model.end_time=dic[@"end_time"];
                        model.status=dic[@"status"];
                        model.phone=dic[@"phone"];
                        model.message=dic[@"order_name"];
                        model.orderShopStatus=dic[@"return_type"];
                        model.change=dic[@"status"];
                        
                        model.shop_from=dic[@"order_shop_id"];   //-2代表夺宝
                        
                        model.order_code=dic[@"order_code"];
                        model.order_price=dic[@"order_price"];
                        model.shop_num=dic[@"shop_num"];
                        model.address=dic[@"supp_address"];
                        model.consignee=dic[@"supp_consignee"];
                        model.phone=dic[@"phone"];
                        
                        NSString *logi_code=@"";   NSString *logi_name=@"";
                        NSString *sting = [NSString stringWithFormat:@"%@",dic[@"express_id"]];
//                        NSString *express_id = @"2234:yuantong,23421:shentong";
                        if(![sting isEqualToString:@"<null>"]){
                            NSString *express_id = dic[@"express_id"];
                            NSArray *arr = [express_id componentsSeparatedByString:@","];
                            NSArray *arr2 = [arr[arr.count-1] componentsSeparatedByString:@":"];
                            logi_code = [NSString stringWithFormat:@"%@",arr2[0]];
                            if (arr2.count>1) {
                                logi_name = [NSString stringWithFormat:@"%@",arr2[1]];
                            }
                            //logi_code = %@  logi_name = %@",logi_code,logi_name);
                        }
                        model.logi_code=logi_code;
                        model.logi_name=logi_name;
                            
//                        "supp_address" = "<null>";
//                        "supp_consignee" = "<null>";
//                        "supp_kb" = 236;
//                        "supp_phone" = "<null>";
//                        "supp_postcode" = "<null>";
                        model.supp_address=dic[@"supp_address"];
                        model.supp_consignee=dic[@"supp_consignee"];
                        model.supp_kb=dic[@"supp_kb"];
                        model.supp_phone=dic[@"supp_phone"];
                        model.supp_postcode=dic[@"supp_postcode"];
                        
                        model.shop_color=dic[@"shop_color"];
                        model.ID=dic[@"id"];
                        model.order_code=dic[@"order_code"];
                        model.return_code=dic[@"return_code"];
                        model.postcode=dic[@"postcode"];
                        model.shop_code=dic[@"shop_code"];
                        model.shop_name=dic[@"shop_name"];
                        model.shop_num=dic[@"shop_num"];
                        model.shop_pic=dic[@"pic"];
                        model.shop_price=dic[@"shop_price"];
                        model.shop_size=dic[@"shop_size"];
                        model.suppid=dic[@"supp_id"];

                        
                        
                        model.end_explain=dic[@"end_explain"];
                        model.ys_intervene=dic[@"ys_intervene"];
                        model.supp_sign_time=dic[@"supp_sign_time"];
                        model.supp_sign_status=dic[@"supp_sign_status"];
                        model.supp_refuse_msg=dic[@"supp_refuse_msg"];
                        model.supp_certificate=dic[@"supp_certificate"];
                        model.user_certificate=dic[@"user_certificate"];
                        model.user_cert_msg=dic[@"user_cert_msg"];
                        model.user_apply_ys_time=dic[@"user_apply_ys_time"];
                        model.ys_intervene_time=dic[@"ys_intervene_time"];
                        
                        
                        if ([model.orderShopStatus integerValue]==1) {//如果是换货
                            model.money=dic[@"shop_price"];
                        }
                        
                        [_shopArray addObject:model];
                    }
                    
                    
                    UIView *backview=(UIView*)[self.view viewWithTag:8789];
                    [backview removeFromSuperview];
                    
                    [_Mytableview reloadData];
                }
                
                if(_shopArray.count<=0){
                    //                [_Mytableview removeFromSuperview];
                    [self creatBackview];
                }
                
            }else if (str.intValue==10030)
            {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_TOKEN];
                LoginViewController *login=[[LoginViewController alloc]init];
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }
            else{
                
                
                
                
                //            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                //            [mentionview showLable:message Controller:self];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
        if(page<1)
        {
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    
    
    
}
#pragma mark 网络请求(卖单)
-(void)requestSellHttp:(NSInteger)page
{

    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *storecode=[user objectForKey:STORE_CODE];
    
    NSString *cutpage=[NSString stringWithFormat:@"%d",page];
//    NSString *url=[NSString stringWithFormat:@"%@order/sellOrderManage?version=%@&token=%@&page=%@&store_code=%@&status=%@&Change=-1&order=desc",[NSObject baseURLStr],VERSION,token,cutpage,storecode,@"0"];
    NSString *url=[NSString stringWithFormat:@"%@returnShop/queryByPage?version=%@&token=%@&page=%@&is_buy=%@&order=desc&sort=id",[NSObject baseURLStr],VERSION,token,cutpage,@"1"];

    
    NSString *URL=[MyMD5 authkey:url];
    
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        //responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if(page==1){
                [_shopArray removeAllObjects];
            }
            _Mytableview.hidden=NO;
            
            //responseObject is %@",responseObject);
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            _pageCount=responseObject[@"count"];
            
            
            if(str.intValue==1)
            {
                
                NSArray *arr=responseObject[@"data"];
                
                if(arr.count>0)
                {
                    
                    for(NSDictionary *dic in arr)
                    {
                        
                        OrderModel *model=[[OrderModel alloc]init];
                        model.add_time=dic[@"add_time"];
                        model.address=dic[@"address"];
                        model.cause=dic[@"cause"];
                        model.explain=dic[@"explain"];
                        model.consignee=dic[@"consignee"];
                        model.free=dic[@"free"];
                        model.lasttime=dic[@"last_time"];
                        model.money=dic[@"money"];
                        model.end_time=dic[@"end_time"];
                        
                        model.phone=dic[@"phone"];
                        model.message=dic[@"order_name"];
                        model.orderShopStatus=dic[@"return_type"];
                        model.change=dic[@"status"];
                        
                        model.order_code=dic[@"order_code"];
                        model.order_price=dic[@"order_price"];
                        model.shop_num=dic[@"shop_num"];
                        model.address=dic[@"supp_address"];
                        model.consignee=dic[@"supp_consignee"];
                        model.phone=dic[@"phone"];
                        
                        NSString *logi_code=@"";   NSString *logi_name=@"";
                        NSString *sting = [NSString stringWithFormat:@"%@",dic[@"express_id"]];
                        //                        NSString *express_id = @"2234:yuantong,23421:shentong";
                        //%@",sting);
                        if(![sting isEqualToString:@"<null>"]&&sting!=nil&&dic[@"express_id"]!=nil){
                            NSString *express_id = dic[@"express_id"];
                            NSArray *arr = [express_id componentsSeparatedByString:@","];
                            NSArray *arr2 = [arr[0] componentsSeparatedByString:@":"];
                            logi_code = [NSString stringWithFormat:@"%@",arr2[0]];
                            if (arr2.count>1) {
                                logi_name = [NSString stringWithFormat:@"%@",arr2[1]];
                            }
                            //logi_code = %@  logi_name = %@",logi_code,logi_name);
                        }
                        model.logi_code=logi_code;
                        model.logi_name=logi_name;
                        
//                        _orderMoney.text = [NSString stringWithFormat:@"订单金额(包邮):¥%@",dic[@"money"]];
//                        _orderNum.text = [NSString stringWithFormat:@"订单号:%@",dic[@"order_code"]];
//                        _orderTime.text = [NSString stringWithFormat:@"下单时间:%@",dic[@"add_time"]];
//                        _tellPhone.text = [NSString stringWithFormat:@"电话:%@",dic[@"supp_phone"]];
//                        _zipCode.text = [NSString stringWithFormat:@"邮编:%@",dic[@"supp_postcode"]];
//                        _address.text = [NSString stringWithFormat:@"地址:%@",dic[@"supp_address"]];
//                        _Name.text=[NSString stringWithFormat:@"收件人:%@",dic[@"supp_consignee"]];
                        
                        model.supp_address=dic[@"supp_address"];
                        model.supp_consignee=dic[@"supp_consignee"];
                        model.supp_kb=dic[@"supp_kb"];
                        model.supp_phone=dic[@"supp_phone"];
                        model.supp_postcode=dic[@"supp_postcode"];
                        model.user_id=dic[@"user_id"];
                        
                        model.shop_color=dic[@"shop_color"];
                        model.ID=dic[@"id"];
                        model.order_code=dic[@"order_code"];
                        model.return_code=dic[@"return_code"];
                        model.postcode=dic[@"postcode"];
                        model.shop_code=dic[@"shop_code"];
                        model.shop_name=dic[@"shop_name"];
                        model.shop_num=dic[@"shop_num"];
                        model.shop_pic=dic[@"pic"];
                        model.shop_price=dic[@"shop_price"];
                        model.shop_size=dic[@"shop_size"];
                        model.suppid=dic[@"supp_id"];
                        
                        
                        [_shopArray addObject:model];
                    }
                    
                    /*
                    
                    for(NSDictionary *dic in arr)
                    {
                        OrderModel *model=[[OrderModel alloc]init];
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
                        model.order_price=dic[@"order_price"];
                        model.shop_num=dic[@"shop_num"];
                        model.address=dic[@"supp_address"];
                        model.consignee=dic[@"supp_consignee"];
                        model.phone=dic[@"phone"];
                        model.change=dic[@"change"];
                        
                        
                        NSArray *brr=dic[@"orderShops"];
                        for(NSDictionary *dicc in brr)
                        {
                            OrderModel *shopmodel=[[OrderModel alloc]init];
                            
                            shopmodel.shop_color=dicc[@"color"];
                            shopmodel.ID=dicc[@"id"];
                            shopmodel.order_code=dicc[@"order_code"];
                            shopmodel.shop_code=dicc[@"shop_code"];
                            shopmodel.shop_name=dicc[@"shop_name"];
                            shopmodel.shop_num=dicc[@"shop_num"];
                            shopmodel.shop_pic=dicc[@"shop_pic"];
                            shopmodel.shop_price=dicc[@"shop_price"];
                            shopmodel.shop_size=dicc[@"size"];
                            shopmodel.suppid=dicc[@"supp_id"];
                            shopmodel.status=dicc[@"status"];
                            shopmodel.change=model.change;
                            
                            
                            [model.shopsArray addObject:shopmodel];
                            
                        }
                        
                        
                        [_shopArray addObject:model];
                    }
                    */
                    
                    UIView *backview=(UIView*)[self.view viewWithTag:8789];
                    [backview removeFromSuperview];
                    
                    [_Mytableview reloadData];
                }
                
                if(_shopArray.count<=0){
                    //                [_Mytableview removeFromSuperview];
                    [self creatBackview];
                }
                
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
                
                
                //            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                //            [mentionview showLable:message Controller:self];
            }

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
        if(page<1)
        {
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    
    
}

#pragma mark 查看详情网络请求
-(void)requestsaleHttp:(NSString*)ordercode
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    
    NSString *url=[NSString stringWithFormat:@"%@returnShop/findOne?version=%@&token=%@&order_code=%@",[NSObject baseURLStr],VERSION,token,ordercode];
    
    NSString *URL=[MyMD5 authkey:url];
    
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
       // responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *message;
            NSString *str=[NSString stringWithFormat:@"%@",responseObject[@"status"]];
            if(str.intValue==1)
            {
                NSDictionary *dic=responseObject[@"returnShop"];
                NSString *statue=dic[@"status"];
                if(statue.intValue==1 && ![dic isEqual:[NSNull null]])//待审核 OK
                {
                    
                    //待审核
                    
#if 1
                    ChangeDetailViewController *change=[[ChangeDetailViewController alloc]init];
                    change.titlestring=_saletitle;
                    change.ordercode=ordercode;
//                    change.dic=dic;
                    [self.navigationController pushViewController:change animated:YES];
#endif
                    
                    
                }
                else if(statue.intValue==2)//审核通过 OK
                {
                    AskforChangeViewController *askforchange=[[AskforChangeViewController alloc]init];
                    
                    askforchange.titlestring=_saletitle;
                    askforchange.ordercode=ordercode;
//                    askforchange.dic=dic;
                    
                    [self.navigationController pushViewController:askforchange animated:YES];
                }
                else if(statue.intValue==3)//审核未通过 OK
                {
                    //未通过
                    CancleViewController *cancle=[[CancleViewController alloc]init];
                    
                    cancle.titlestring=_saletitle;
//                    cancle.dic=dic;
                    
                    [self.navigationController pushViewController:cancle animated:YES];
                    
                }
                else if(statue.intValue==4)//供应商收到货并向买家发货 OK
                {
                    //商家收到货
                    
                    SuccessChangeViewController *success=[[SuccessChangeViewController alloc]init];
//                    success.dic=dic;
                    success.statues=statue;
                    success.titlestr=_saletitle;
                    [self.navigationController pushViewController:success animated:YES];
                    
                    
                }
                else if(statue.intValue==5)//买家取消 OK
                {
                    CancleViewController *cancle=[[CancleViewController alloc]init];
                    
                    cancle.titlestring=_saletitle;
//                    cancle.dic=dic;
                    
                    [self.navigationController pushViewController:cancle animated:YES];
                }
                else if(statue.intValue==6)//退款成功 OK
                {
                    
                    CancleViewController *cancle=[[CancleViewController alloc]init];
                    
                    cancle.titlestring=_saletitle;
//                    cancle.dic=dic;
                    
                    [self.navigationController pushViewController:cancle animated:YES];
                    
                }
                else if(statue.intValue==7)//退款关闭 OK
                {
                    
                    CancleViewController *cancle=[[CancleViewController alloc]init];
                    
                    cancle.titlestring=_saletitle;
//                    cancle.dic=dic;
                    
                    [self.navigationController pushViewController:cancle animated:YES];
                    
                }
                
                else if(statue.intValue==8)//换货成功 OK
                {
                    
                    CancleViewController *cancle=[[CancleViewController alloc]init];
                    
                    cancle.titlestring=_saletitle;
//                    cancle.dic=dic;
                    
                    [self.navigationController pushViewController:cancle animated:YES];
                    
                }else if (statue.intValue==9)//审核退款
                {
                    
                    
                }else if (statue.intValue==10)//买家向卖家寄货 OK
                {
                    //给买家发货的详情
                    SuccessChangeViewController *success=[[SuccessChangeViewController alloc]init];
//                    success.dic=dic;
                    success.statues=statue;
                    success.titlestr=_saletitle;
                    [self.navigationController pushViewController:success animated:YES];
                    
                }
                else if (statue.intValue==11)//支付宝审核中
                {
                    AskforChangeViewController *askforchange=[[AskforChangeViewController alloc]init];
                    
                    askforchange.titlestring=_saletitle;
                    askforchange.ordercode=ordercode;
//                    askforchange.dic=dic;
                    
                    [self.navigationController pushViewController:askforchange animated:YES];
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
                
                
            }else{
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:responseObject[@"message"] Controller:self];
            }
        }else{
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:responseObject[@"message"] Controller:self];
        }
            
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");

        [MBProgressHUD hideHUDForView:self.view];
        
    }];
    
    
    
}




#if 0

-(void)requestHttp:(NSInteger)page
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    
    NSString *cutpage=[NSString stringWithFormat:@"%d",page];
    NSString *url=[NSString stringWithFormat:@"%@returnShop/getReturnOrder?version=%@&token=%@&pager.curPage=%@",[NSObject baseURLStr],VERSION,token,cutpage];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        //responseObject is %@",responseObject);

        
        NSString *str=responseObject[@"status"];
        NSString *message=responseObject[@"message"];
        _pageCount=responseObject[@"pageCount"];
        
        if(str.intValue==1)
        {
            
            NSArray *arr=responseObject[@"returnShops"];
            for(NSDictionary *dic in arr)
            {
                OrderModel *model=[[OrderModel alloc]init];
                
                model.add_time=dic[@"add_time"];
                model.cause=dic[@"cause"];
                model.ck_explain=dic[@"ck_explain"];
                model.ck_id=dic[@"ck_id"];
                model.ck_time=dic[@"ck_time"];
                model.explain=dic[@"explain"];
                model.ID=dic[@"15"];
                model.money=dic[@"money"];
                model.order_shop_id=dic[@"order_shop_id"];
                model.shop_name=dic[@"shop_name"];
                model.shop_num=dic[@"shop_num"];
                model.shop_pic=dic[@"shop_pic"];
                model.shop_price=dic[@"shop_price"];
                model.sizecolor=dic[@"sizecolor"];
                model.store_code=dic[@"store_code"];
                model.store_name=dic[@"store_name"];
                model.user_id=dic[@"user_id"];
                model.status=dic[@"status"];
               
                [_shopArray addObject:model];
            }
            
            [_Mytableview reloadData];
        }else{
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }
        
        [_Mytableview reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络连接失败" Controller:self];
        
    }];
    
    

}

#endif

-(void)creatView
{
      /*
    NSArray *titlearr=@[@"已买商品",@"已卖商品"];
    
    UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 64, kApplicationWidth, 30)];
    [self.view addSubview:headview];
    
  
    UISegmentedControl *segment=[[UISegmentedControl alloc]initWithItems:titlearr];
    segment.tag=segmentTag;
    segment.frame=CGRectMake((kApplicationWidth-160)/2, 0, 160, 30);
    segment.selectedSegmentIndex=0;
    
    segment.layer.borderWidth=1.5;
    segment.layer.borderColor=kTitleColor.CGColor;
    segment.clipsToBounds=YES;
    segment.layer.cornerRadius=15.5;
    
    [segment setTintColor:[UIColor blackColor]];
    NSDictionary *textDic = [NSDictionary dictionaryWithObjectsAndKeys:
                             [UIFont systemFontOfSize:ZOOM(40)],NSFontAttributeName,nil];
    
    [segment setTitleTextAttributes:textDic forState:UIControlStateNormal];
    [headview addSubview:segment];
    
    [segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    */
    
    
    //底视图
    UIView *footview=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-ZOOM(146)+kUnderStatusBarStartY, kApplicationWidth,ZOOM(146))];
    [self.view addSubview:footview];
    
    UILabel *lableine=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 1)];
    lableine.backgroundColor=kBackgroundColor;
    [footview addSubview:lableine];
    
    CGFloat width=(kApplicationWidth-ZOOM(42)*3)/2;
    NSArray *arr=@[@"我要申请",@"售后帮助"];
    for(int i=0;i<2;i++)
    {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame=CGRectMake(ZOOM(42)*(i+1)+(width)*i,ZOOM(23), width, ZOOM(100));
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor=[UIColor blackColor];
        button.titleLabel.font=[UIFont systemFontOfSize:ZOOM(46)];
//        button.layer.cornerRadius = 5;
        button.tag=1000+i;
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [footview addSubview:button];
        
       
    }

    
}

-(void)creatTableview
{

    //列表
    _Mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight-Height_NavBar+kUnderStatusBarStartY-ZOOM(146)) style:UITableViewStyleGrouped];
    _Mytableview.backgroundColor = [UIColor whiteColor];
    _Mytableview.dataSource=self;
    _Mytableview.delegate=self;
    _Mytableview.rowHeight=ZOOM(62)*2+ZOOM(350);
    _Mytableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    
    [_Mytableview registerNib:[UINib nibWithNibName:@"OrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_Mytableview];
    
    __weak AftersaleViewController *afterSale = self;
    
    [_Mytableview addFooterWithCallback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UISegmentedControl *segment=(UISegmentedControl *)[afterSale.view viewWithTag:segmentTag];
            switch (segment.selectedSegmentIndex) {
                case 0:
                {
                    _currentpage++;
//                    if(! (_currentpage > _pageCount.intValue))
//                    {
                        [afterSale requestHttp:_currentpage];
//                    }
                }
                    break;
                case 1:
                {
                    _currentpage++;
//                    if(! (_currentpage > _pageCount.intValue))
//                    {
                        [afterSale requestSellHttp:_currentpage];
//                    }
                }
                    break;
            }
            [_Mytableview footerEndRefreshing];
        });
        
        
    }];
    
    [_Mytableview addHeaderWithCallback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UISegmentedControl *segment=(UISegmentedControl *)[afterSale.view viewWithTag:segmentTag];
            switch (segment.selectedSegmentIndex) {
                case 0:
                {
                    _currentpage = 1;
                    [afterSale requestHttp:_currentpage];
                }
                    break;
                case 1:
                {
                    _currentpage=1;
                    [afterSale requestSellHttp:_currentpage];
                }
                    break;
            }
            
            [_Mytableview headerEndRefreshing];

        });
    }];
    
    //刷新
//    [self addheadFresh];
//    [self addfootFresh];


}

-(void)creatBackview
{
    //没有订单的相关界面
    
    UIView *backview=[[UIView alloc]initWithFrame:CGRectMake(0, 94, kApplicationWidth, kApplicationHeight-ZOOM(146)-94+kUnderStatusBarStartY)];
    backview.backgroundColor = [UIColor whiteColor];
    backview.tag=8789;
    
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(kApplicationWidth/2-40, 20, 80, 150)];
    if (kScreenHeight>=568) {
        imageview.frame = CGRectMake(kApplicationWidth/2-40, kScreenHeight/4-75, 80, 150);
    }
    imageview.image=[UIImage imageNamed:@"组-32"];
    [backview addSubview:imageview];
    
    for(int i=0;i<2; i++)
    {
        
        UILabel *marklable=[[UILabel alloc]initWithFrame:CGRectMake(0, imageview.frame.origin.y+imageview.frame.size.height+ 20 +40*i, backview.frame.size.width, 40)];
        marklable.textAlignment=NSTextAlignmentCenter;
//        marklable.font=[UIFont systemFontOfSize:ZOOM(46)];
        if(i==0)
        {
            marklable.text=@"你还没有相关订单";
            
        }else{
            marklable.text=@"可以去看看有哪些想买的";
            marklable.textColor=kTextGreyColor;
        }
        
        [backview addSubview:marklable];
        
    }
    
    UIButton *shoppintbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
   shoppintbtn.frame=CGRectMake(50, imageview.frame.origin.y+imageview.frame.size.height+120, kApplicationWidth-100, 40);
    [shoppintbtn setTitle:@"随便逛逛" forState:UIControlStateNormal];
//    shoppintbtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(46)];
    [shoppintbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shoppintbtn.layer.borderWidth=1;
    shoppintbtn.layer.cornerRadius = 5;
    [backview addSubview:shoppintbtn];
    
    [shoppintbtn addTarget:self action:@selector(shoppinggo:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backview];
    
}




#pragma mark 逛逛
-(void)shoppinggo:(UIButton*)sender
{
    // 跳转到衣服
    Mtarbar.selectedIndex=0;
    
    [self.navigationController popToRootViewControllerAnimated:NO];


}

#pragma mark 我的买单 我的卖单
-(void)change:(id)sender
{
    UIView *backview=(UIView*)[self.view viewWithTag:8789];
    [backview removeFromSuperview];

    _Mytableview.hidden=YES;
    UISegmentedControl *segment=(UISegmentedControl*)sender;
    UIButton *button=(UIButton*)[self.view viewWithTag:1000];
    
    switch (segment.selectedSegmentIndex) {
        case 0:
        {
            _titlestring=@"已买商品";
            button.enabled=YES;
            button.alpha=1;
            //买单");
            
            _currentpage = 1;
            [self requestHttp:_currentpage];
            
        }
            
            break;
        case 1:
        {
            //卖单");
            button.enabled=NO;
            button.alpha=0.5;
            _titlestring=@"已卖商品";
            
            _currentpage = 1;
            [self requestSellHttp:_currentpage];
            
        }
            
    }
    

}

-(void)click:(UIButton*)sender
{
   
   if(sender.tag==1000)
   {
       MyLog(@"我要申请");
       
       AskforSaleViewController *askforsale=[[AskforSaleViewController alloc]init];
       [self.navigationController pushViewController:askforsale animated:YES];
       
//       
//       RefundAndReturnViewController *refund=[[RefundAndReturnViewController alloc]init];
//       [self.navigationController pushViewController:refund animated:YES];
       
      
   }else{
       MyLog(@"售后帮助");
       
       ServiceViewController *service=[[ServiceViewController alloc]init];
       [self.navigationController pushViewController:service animated:YES];
   }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
/*
#pragma mark footview 高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    OrderModel *model=_shopArray[section];
    if(model.change.intValue==6 || model.change.intValue==3)
    {
        return 30;
    }
    
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _shopArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_shopArray.count)
    {
        OrderModel *model=_shopArray[section];
    
        return model.shopsArray.count;
    }
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    OrderModel *model;
    if (_shopArray.count) {
        model=_shopArray[section];
    }
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 60)];
    view.backgroundColor=[UIColor whiteColor];
    UILabel *pricelable=[[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth-130-ZOOM(42), 5, 130, 20)];
    pricelable.textAlignment=NSTextAlignmentRight;
    pricelable.font=[UIFont systemFontOfSize:ZOOM(46)];
    pricelable.text=[NSString stringWithFormat:@"实付:¥%.2f",[model.order_price floatValue]];;
    
    UILabel *countlable=[[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth-280, 5, 100, 20)];
    countlable.textAlignment=NSTextAlignmentRight;
    countlable.font=[UIFont systemFontOfSize:ZOOM(46)];
    countlable.text=[NSString stringWithFormat:@"共%@件商品",model.shop_num];
    
    //状态按钮的数量
    int statecount=0;
    //状态按钮的title
    NSArray *titlearr;
    
    //订单状态
    NSString *statue;
    statue=model.change;
    if([_titlestring isEqualToString:@"已买商品"])
    {
        switch (statue.intValue) {
            case 1:
                statecount=1;
                titlearr=@[@"联系卖家"];
                break;
            case 2:
                statecount=2;
                titlearr=@[@"提醒发货",@"退款"];
                break;
            case 3:
                statecount=0;

                break;
            case 4:
                statecount=2;
                titlearr=@[@"评价订单",@"删除订单"];
                break;
            case 5:
                statecount=1;
                titlearr=@[@"钱款去向"];
                break;
            case 6:
                statecount=0;
                
                break;
            case 7:
                statecount=2;
                titlearr=@[@"确认收货",@"查看物流"];
                break;
            case 8:
                statecount=1;
                titlearr=@[@"退货成功"];
                break;
            case 9:
                statecount=1;
                titlearr=@[@"钱款去向"];
                break;
            default:
                break;
        }
    }else if ([_titlestring isEqualToString:@"已卖商品"])//已卖商品
    {
        
        
        switch (statue.intValue) {
            case 1:
                statecount=1;
                titlearr=@[@"联系买家"];
                break;
            case 2:
                statecount=1;
                titlearr=@[@"提醒发货"];
                break;
            case 3:
                statecount=1;
                titlearr=@[@"钱款去向"];
                break;
            case 4:
                statecount=2;
                titlearr=@[@"评价客户",@"查看物流"];
                break;
            case 5:
                statecount=1;
                titlearr=@[@"钱款去向"];
                break;
            case 6:
                statecount=0;
                
                break;
            case 7:
                statecount=1;
                titlearr=@[@"查看物流"];
                break;
            case 8:
                statecount=0;
                
                break;
            case 9:
                statecount=1;
                titlearr=@[@"钱款去向"];
                break;
            default:
                break;
        }
        
    }
    
    for(int i=0; i<statecount; i++)
    {
        UIButton *statebutton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        statebutton.frame=CGRectMake(kApplicationWidth-ZOOM(42)-ZOOM(200)*i, 30, ZOOM(200), ZOOM(80));
        statebutton.backgroundColor=[UIColor blackColor];
//        statebutton.layer.cornerRadius = 5;
        statebutton.tag=10000*(section+1)+i;
        [statebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [statebutton setTitle:titlearr[i] forState:UIControlStateNormal];
        statebutton.titleLabel.font=[UIFont systemFontOfSize:ZOOM(38)];
        [statebutton addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
        
//        [view addSubview:statebutton];
    }
    
    [view addSubview:pricelable];
    [view addSubview:countlable];
    
    return view;
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _shopArray.count;
}
-(void)buttonclick:(UIButton*)sender
{
    
    UIButton *button=(UIButton*)[self.view viewWithTag:sender.tag];
    NSString *title=button.titleLabel.text;
    MyLog(@"title is %@",title);
    
    long index=sender.tag/10000-1;
    
    OrderModel *model=_shopArray[index];
    NSString *ordercoder=model.order_code;
    NSString *orderprice=model.order_price;
        
    if([title isEqualToString:@"付款"])
    {
        
    }
    else if ([title isEqualToString:@"取消订单"])
    {
        
    }
    else if ([title isEqualToString:@"联系卖家"])
    {
        //联系买家");
    }
    else if ([title isEqualToString:@"提醒发货"])
    {
        //提醒发货");
    }
    else if ([title isEqualToString:@"退款"])
    {
       
    }
    else if ([title isEqualToString:@"确认收货"])
    {
        
    }
    else if ([title isEqualToString:@"查看物流"])
    {
      
    }
    else if ([title isEqualToString:@"评价订单"])
    {
       
    }
    else if ([title isEqualToString:@"删除订单"])
    {
      
        
    }
    else if ([title isEqualToString:@"钱款去向"])
    {
        MoneyGoViewController *moneygo=[[MoneyGoViewController alloc]init];
        
        [self.navigationController pushViewController:moneygo animated:YES];
    }
}


-(void)withStatusToOrderDetail:(OrderModel *)model
{
    if(model.orderShopStatus.intValue==3)//退款中
    {
        _saletitle=@"退款详情";
        
    }
    else if (model.orderShopStatus.intValue==1)//换货中
    {
        _saletitle=@"换货详情";
        
    }
    else if (model.orderShopStatus.intValue==2)//退货详情
    {
        _saletitle=@"退货详情";
    }
    
    
    NSString *statue = model.status;
    
    MyLog(@"statue = %d",statue.intValue);
    if (model.supp_sign_status.integerValue==1) {
        InterveneDetailViewController *view =[[InterveneDetailViewController alloc]init];
        view.orderModel=model;
        [self.navigationController pushViewController:view animated:YES];
    }
    else if(statue.intValue==1)//待审核 OK
    {
        //待审核
        ChangeDetailViewController *change=[[ChangeDetailViewController alloc]init];
        change.titlestring=_saletitle;
        change.orderModel=model;
        [self.navigationController pushViewController:change animated:YES];
    }
    else if(statue.intValue==2)//审核通过 OK
    {
        AskforChangeViewController *askforchange=[[AskforChangeViewController alloc]init];
        askforchange.titlestring=_saletitle;
        askforchange.ordercode=model.order_code;
        askforchange.orderModel=model;
        [self.navigationController pushViewController:askforchange animated:YES];
    }
    else if(statue.intValue==3)//审核未通过 OK
    {
        //未通过
        CancleViewController *cancle=[[CancleViewController alloc]init];
        cancle.titlestring=_saletitle;
        cancle.orderModel=model;
        [self.navigationController pushViewController:cancle animated:YES];
    }
    else if(statue.intValue==4)//供应商收到货并向买家发货 OK
    {
        //商家收到货
        SuccessChangeViewController *success=[[SuccessChangeViewController alloc]init];
        success.orderModel=model;
        success.statues=statue;
        success.titlestr=_saletitle;
        [self.navigationController pushViewController:success animated:YES];
        
        
    }
    else if(statue.intValue==5)//买家取消 OK
    {
        CancleViewController *cancle=[[CancleViewController alloc]init];
        cancle.titlestring=_saletitle;
        cancle.orderModel=model;
        [self.navigationController pushViewController:cancle animated:YES];
    }
    else if(statue.intValue==6)//退款成功 OK
    {
        CancleViewController *cancle=[[CancleViewController alloc]init];
        cancle.titlestring=_saletitle;
        cancle.orderModel=model;
        [self.navigationController pushViewController:cancle animated:YES];
    }
    else if(statue.intValue==7)//退款关闭 OK
    {
        CancleViewController *cancle=[[CancleViewController alloc]init];
        cancle.titlestring=_saletitle;
        cancle.orderModel=model;
        [self.navigationController pushViewController:cancle animated:YES];
    }
    else if(statue.intValue==8)//换货成功 OK
    {
        CancleViewController *cancle=[[CancleViewController alloc]init];
        cancle.titlestring=_saletitle;
        cancle.orderModel=model;
        [self.navigationController pushViewController:cancle animated:YES];
        
    }else if (statue.intValue==9)//审核退款
    {
        AskforChangeViewController *askforchange=[[AskforChangeViewController alloc]init];
        askforchange.titlestring=_saletitle;
        askforchange.ordercode= model.order_code;
        askforchange.orderModel=model;
        [self.navigationController pushViewController:askforchange animated:YES];
        
    }else if (statue.intValue==10)//买家向卖家寄货 OK
    {
        //给买家发货的详情
        SuccessChangeViewController *success=[[SuccessChangeViewController alloc]init];
        success.orderModel=model;
        success.statues=statue;
        success.titlestr=_saletitle;
        [self.navigationController pushViewController:success animated:YES];
    }
    else if (statue.intValue==11)//支付宝审核中
    {
        AskforChangeViewController *askforchange=[[AskforChangeViewController alloc]init];
        askforchange.titlestring=_saletitle;
        askforchange.ordercode= model.order_code;
        askforchange.orderModel=model;
        [self.navigationController pushViewController:askforchange animated:YES];
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    RefunddetailViewController *refund=[[RefunddetailViewController alloc]init];
//    [self.navigationController pushViewController:refund animated:YES];
    OrderModel *model=_shopArray[indexPath.row];
    NSString *ordercode=[NSString stringWithFormat:@"%@",model.order_code];
    
    if ([_titlestring isEqualToString:@"已买商品"]) {
        
        
        [self withStatusToOrderDetail:model];
        /*
        if(model.change.intValue==3 || model.change.intValue==6 || model.change.intValue==9 || model.change.intValue==11)//退款中
        {
            _saletitle=@"退款详情";
            
        }
        else if (model.change.intValue==1 || model.change.intValue==4 || model.change.intValue==7)//换货中
        {
            _saletitle=@"换货详情";
            
        }
        else if (model.change.intValue==2 || model.change.intValue==5 || model.change.intValue==8)//退货详情
        {
            _saletitle=@"退货详情";
        }
        
        [self requestsaleHttp:ordercode];
        */
    }else{
        
        SaleDetailViewController *view = [[SaleDetailViewController alloc]init];
        view.order_code = model.order_code;
        view.suppid = model.suppid;
        view.orderModel=model;
        [self.navigationController pushViewController:view animated:YES];
    }

    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell=[[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    if(_shopArray.count)
    {
        OrderModel *model=_shopArray[indexPath.row];
        
//        if(model.shopsArray.count)
//        {
//            OrderModel *shopmodel=model.shopsArray[indexPath.row];
        
        
//        }
//                if(model.shopsArray.count&&[_titlestring isEqualToString: @"已卖商品"])
//                {
//                    OrderModel *model=_shopArray[indexPath.row];
//                    OrderModel *shopmodel=model.shopsArray[0];
//        
//        
//                    [cell refreshData2:shopmodel];
//                  
//                }else
                    [cell refreshData2:model];

        if (model.supp_sign_status.integerValue==1) {
            cell.interveneBtn.tag=indexPath.row;
            [cell.interveneBtn addTarget:self action:@selector(interveneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)interveneBtnClick:(UIButton *)sender
{
    YSSJInterveneViewController *view = [[YSSJInterveneViewController alloc]init];
    view.orderModel = _shopArray[sender.tag];
    [self.navigationController pushViewController:view animated:YES];
}
#pragma mark 处理订单
-(void)changeTitle:(NSInteger)index
{
    //钱款去向");
    
    MoneyGoViewController *moneygo=[[MoneyGoViewController alloc]init];
    [self.navigationController pushViewController:moneygo animated:YES];

}


#pragma mark 下拉刷新
-(void)addheadFresh
{
    [_Mytableview addHeaderWithCallback:^{
        

            
            UISegmentedControl *segment=(UISegmentedControl *)[self.view viewWithTag:segmentTag];
            switch (segment.selectedSegmentIndex) {
                case 0:
                {
                    
                        _currentpage = 1;
                        [self requestHttp:_currentpage];


                    
                }
                    break;
                case 1:
                {

                        _currentpage=1;
                        [self requestSellHttp:_currentpage];

                }
                    break;
                    
            }
            
        

    }];
    
//    [_Mytableview headerBeginRefreshing];
}

#pragma mark 上拉刷新
-(void)addfootFresh
{
    [_Mytableview addFooterWithCallback:^{
        
        
        
            

            UISegmentedControl *segment=(UISegmentedControl *)[self.view viewWithTag:segmentTag];
            switch (segment.selectedSegmentIndex) {
                case 0:
                {
                  
                        _currentpage++;
                        if(! (_currentpage > _pageCount.intValue))
                        {
                            [self requestHttp:_currentpage];
                        }

                    
                }
                    break;
                case 1:
                {
                        _currentpage++;
                        if(! (_currentpage > _pageCount.intValue))
                        {
                            [self requestSellHttp:_currentpage];
                        }
                }
                    break;
                    
            }
            // 结束刷新
            [_Mytableview footerEndRefreshing];
       
        
    }];
    
    
}

-(void)back:(UIButton*)sender
{
    [self .navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
