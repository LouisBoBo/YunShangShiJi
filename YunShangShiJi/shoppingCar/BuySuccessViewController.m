//
//  BuySuccessViewController.m
//  YunShangShiJi
//
//  Created by yssj on 15/8/6.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "BuySuccessViewController.h"
#import "AffirmOrderViewController.h"
#import "MyOrderViewController.h"
#import "GlobalTool.h"
#import "IntelligenceViewController.h"
#import "ChoseShareViewController.h"
#import "ShopDetailViewController.h"
#import "ShareNumberViewController.h"
#import "OneIndianaDetailViewController.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "OrderModel.h"
#import "LoginViewController.h"

#import "OrderDetailViewController.h"
#import "TFMemberSuccessViewController.h"

#import "OrderTableViewController.h"
#import "AffirmOrderViewController.h"
#import "IndianaDetailViewController.h"

#import "LuckdrawViewController.h"
#import "TFLedBrowseShopViewController.h"
#import "CollocationDetailViewController.h"
#import "ActivityShopOrderVC.h"
#import "Signmanager.h"
#import "TopicPublicModel.h"
#import "GroupBuyDetailVC.h"
#import "OneLuckdrawViewController.h"
@interface BuySuccessViewController ()

@end

@implementation BuySuccessViewController
{
    NSString* _isshare;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [Signmanager SignManarer].task_isfinish = YES;
    [DataManager sharedManager].outAppStatistics=@"支付成功弹出页";
    
    [TFStatisticsClickVM StatisticshandleDataWithClickType:@"到达支付成功" success:nil failure:nil];
    
    if (_isNormolShop)
        [TFStatisticsClickVM handleDataWithPageType:nil withClickType:@"支付成功页面弹出次数" success:^(id data, Response *response) {
        } failure:^(NSError *error) {
        }];

     _isshare = @"yes";
    [self setNavigationView];
    [self setMainView];
    
    //是否有疯狂星期一的任务
    [TopicPublicModel GetisMandayDataSuccess:^(id data) {
        
        TopicPublicModel *model = data;
        if(model.status == 1)
        {
            [DataManager sharedManager].IS_Monday = model.isMonday==1?YES:NO;
            [self gotoVC];
        }else{
            [self gotoVC];
        }
    }];
}
/*
 *   导航条界面
 */

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

-(void)setNavigationView
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 125)];
    //    headview.image=[UIImage imageNamed:@"u265"];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(kApplicationWidth/2-60, IS_IPHONE_X?40:20, 120, 40);
    titlelable.text=@"收银台";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [headview addSubview:backbtn];
    

    UIImageView *payView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 85, 28, 21)];
    payView.image = [UIImage imageNamed:@"快捷支付"];
//    [headview addSubview:payView];
    
    UILabel* noteLabel = [[UILabel alloc] init];
    noteLabel.frame = CGRectMake(payView.frame.origin.x + payView.frame.size.width +10, payView.frame.origin.y, 200, 25);
    noteLabel.textColor = [UIColor lightGrayColor];
    noteLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"快捷支付 安全可靠 便利快捷"];
    NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@" "].location);
    [noteStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(48)]} range:redRange];
    [noteLabel setAttributedText:noteStr] ;
    [noteLabel sizeToFit];
//    [headview addSubview:noteLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.size.height-1, kApplicationWidth, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
//    [headview addSubview:line];
    
}
/**
 *  主界面
 */
-(void)setMainView
{
    UIImageView *smileView = [[UIImageView alloc]initWithFrame:CGRectMake(kApplicationWidth/2-20, 200, 40, 40)];
    //    smileView.center = CGPointMake(kApplicationWidth/2, 100);
    if (kScreenWidth>=375) {
        smileView.frame = CGRectMake(kApplicationWidth/2-20, 240, 40, 40);
    }
    smileView.image = [UIImage imageNamed:@"成功"];
    [self.view addSubview:smileView];
    
    UILabel *thanksLabel = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2-150, smileView.frame.origin.y+smileView.frame.size.height+10, 300, 50)];
    thanksLabel.text = @"恭喜您!购买成功";
    thanksLabel.textColor = [UIColor blackColor];
    [thanksLabel setFont:[UIFont systemFontOfSize:ZOOM(60)]];
    thanksLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:thanksLabel];
    
    
    UILabel *remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2-150,  thanksLabel.frame.origin.y+thanksLabel.frame.size.height-20 , 300, 50)];
    remindLabel.text = @"您使用快捷支付完成本次交易";
    remindLabel.textColor = [UIColor lightGrayColor];
    [remindLabel setFont:[UIFont systemFontOfSize:ZOOM(38)]];
    remindLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:remindLabel];
    
    //支付的金额
    NSUserDefaults *userdefaul =[NSUserDefaults standardUserDefaults];
    NSString *se_price = [userdefaul objectForKey:PAY_PRICE];
    
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2-150,  remindLabel.frame.origin.y+remindLabel.frame.size.height, 300, 50)];
    NSString *str = [NSString stringWithFormat:@"%@",se_price];
    moneyLabel.text = [NSString stringWithFormat:@"¥ %.2f",[str floatValue]];
    moneyLabel.textColor = [UIColor blackColor];
    [moneyLabel setFont:[UIFont systemFontOfSize:ZOOM(60)]];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:moneyLabel];
    
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
    
    [TFStatisticsClickVM StatisticshandleDataWithClickType:@"跳出支付成功" success:nil failure:nil];
}
#pragma mark 界面跳转
- (void)gotoVC
{
    if (self.shop_from.intValue == 9){//一元购买
        [self performSelector:@selector(normalgotoOneLuck) withObject:nil afterDelay:1.5];
    }
    else if(self.shop_from.intValue == 4)//夺宝成功
    {
        [self performSelector:@selector(gotoMakeMoney) withObject:nil afterDelay:1.5];
    }else if (self.shop_from.intValue == 7)//活动商品成团
    {
        [self performSelector:@selector(goFightDetail) withObject:nil afterDelay:1.5];
    }else if (self.shop_from.intValue == 5){//活动商品
        [self performSelector:@selector(normalgotoLuck) withObject:nil afterDelay:1.5];
    }else if (self.shop_from.intValue == 8){//一元夺宝
        [self performSelector:@selector(goOneIndiana) withObject:nil afterDelay:1.5];
    }else if (self.shop_from.intValue == 10)//1元购拼团
    {
        [self performSelector:@selector(goFightDetail) withObject:nil afterDelay:1.5];
    }else if ([DataManager sharedManager].IS_Monday) {//疯狂星期一购物成功
        [self performSelector:@selector(normalgotoLuck) withObject:nil afterDelay:1.5];
    }
    else if ([DataManager sharedManager].is_guideOrder){//引导支付
        [self performSelector:@selector(normalgotoLuck) withObject:nil afterDelay:1.5];
    }
    else{//普通订单
        [self performSelector:@selector(normalgotoOrder) withObject:nil afterDelay:1.5];
    }
    
}
//一元购买支付成功到一元抽奖界面
- (void)normalgotoOneLuck
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        OneLuckdrawViewController *oneLuck = [OneLuckdrawViewController new];
        oneLuck.comefrom = @"paysuccess";
        oneLuck.order_code = self.orderCode;
        [self.navigationController pushViewController:oneLuck animated:YES];
        
        return;
    });
}
//普通订单到订单详情
- (void)normalgotoOrder{
    [self OrderHttp];
}
//正常支付到抽奖界面
- (void)normalgotoLuck
{
    BOOL ISmonday = [DataManager sharedManager].IS_Monday;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
        LuckdrawViewController *luck=[[LuckdrawViewController alloc] init];
        luck.hidesBottomBarWhenPushed=YES;
        luck.is_fromOrder = YES;
        if(!ISmonday)
        {
            luck.OrderGetYidou = [self.shopprice intValue];
            if([self.shopprice floatValue] > [self.shopprice intValue])
            {
                luck.OrderGetYidou += 1;
            }
            luck.OldLotteryNumber = [self.shopprice intValue]/10;
        }else{
            luck.OldLotteryNumber = [self.shopprice intValue]/5+[self.shopprice longLongValue]%5==0?1:1+[self.shopprice intValue]/5;
        }
        
        [self.navigationController pushViewController:luck animated:YES];
        
    });
}

//夺宝成功返回赚钱任务页面
- (void)gotoMakeMoney
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
        [userdefaul setObject:self.shop_from forKey:PYSUCCESS];
        
        [self.navigationController popToRootViewControllerAnimated:NO];
        MakeMoneyViewController *makemoney=[[MakeMoneyViewController alloc] init];
        makemoney.hidesBottomBarWhenPushed=YES;
        
        Mtarbar.selectedIndex=0;
        UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[0];
        nv.navigationBarHidden = YES;
        [nv pushViewController:makemoney animated:YES];
    });
}
//活动商品成团返回到购物界面
-(void)goFightDetail
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        GroupBuyDetailVC *fightvc = [[GroupBuyDetailVC alloc] init];
        fightvc.roll_code = [DataManager sharedManager].fightStatus;
        fightvc.fightStatus = 11;
        fightvc.isTM = self.isTM;
        fightvc.hidesBottomBarWhenPushed=YES;
        
        [DataManager sharedManager].opengroup = 1;//开团
        Mtarbar.selectedIndex=0;
        UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[0];
        nv.navigationBarHidden = YES;
        [nv pushViewController:fightvc animated:YES];
        
    });
}
//一元夺宝成功后返回夺宝详情
- (void)goOneIndiana
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    [userdefaul setObject:self.shop_from forKey:PYSUCCESS];
    for(UIViewController *vc in self.navigationController.viewControllers)
    {
        if([vc isKindOfClass:[OneIndianaDetailViewController class]]){
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }
}

//直接返回到首页
- (void)backHome
{
    Mtarbar.selectedIndex=0;
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (void)gotoviewcontroller
{
    if(self.p_type.intValue == 5)
    {
        
        NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
        [userdefaul setObject:self.shop_from forKey:PYSUCCESS];
        
        // 跳转到衣服
        Mtarbar.selectedIndex=2;
        
        [self.navigationController popToRootViewControllerAnimated:NO];
    
        return;
    }
    else if(self.p_type.intValue == 3 || self.p_type.intValue==4)
    {
        // 跳转到衣服
        Mtarbar.selectedIndex=0;

        [self.navigationController popToRootViewControllerAnimated:NO];
        
        return ;
    }else{//0元9元
        
        Mtarbar.selectedIndex=0;
        
        [self.navigationController popToRootViewControllerAnimated:NO];
        
        return;
    }

}

-(void)OrderHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    
    NSString *urlStr1 = [NSString stringWithFormat:@"%@order/getOrderDetialByGcodeOrOcode?version=%@&token=%@&order_code=%@",[NSObject baseURLStr],VERSION,token,self.orderCode];
    NSString *URL = [MyMD5 authkey:urlStr1];
    
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation]stopAnimationAt:self.view];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                [self OrderData:responseObject[@"order"]];//疯抢中订单信息
            }
            else{
                
                [self normalgotoLuck];
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        if ([error code] == kCFURLErrorTimedOut) {
            
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
            
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
}
//订单信息
- (void)OrderData:(NSDictionary*)dic
{
    if (dic!=nil && ![dic isEqual:[NSNull null]]) {
        
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
        model.shop_price=dic[@"order_price"];
        model.one_deductible=dic[@"one_deductible"];
        
        model.shop_num=dic[@"shop_num"];
        model.address=dic[@"address"];
        model.consignee=dic[@"consignee"];
        model.phone=dic[@"phone"];
        model.local_time=[NSDate date];
        //                model.requestNow_time=responseObject[@"now"];
        model.issue_status=dic[@"issue_status"];
        model.issue_code=dic[@"issue_code"];
        model.participation_code=dic[@"participation_code"];
        
        if ([dic[@"logi_code"] isEqual:[NSNull null]]) {
            model.logi_code=@"";
        }else
            model.logi_code=[NSString stringWithFormat:@"%@",dic[@"logi_code"]];
        if ([dic[@"logi_name"] isEqual:[NSNull null]]) {
            model.logi_name=@"";
        }else
            model.logi_name=[NSString stringWithFormat:@"%@",dic[@"logi_name"]];
        model.change=dic[@"change"];
        model.suppid=dic[@"supp_id"];
        model.kickback=dic[@"kickBack"];
        
        model.bak=dic[@"bak"];
        model.shop_from=dic[@"shop_from"];
        model.postage=dic[@"postage"];
        model.postcode=dic[@"postcode"];
        
        model.issue_endtime=dic[@"issue_endtime"];
        model.twofoldness=dic[@"twofoldness"];
        model.tfn_money=dic[@"tfn_money"];
        model.tfn_money_ago=dic[@"tfn_money_ago"];
        model.remain_money=dic[@"remain_money"];
        model.is_wx=dic[@"is_wx"];
        model.wx_price=dic[@"wx_price"];
        
        model.is_free=[[NSString stringWithFormat:@"%@",dic[@"is_free"]]integerValue];
        model.is_roll=[[NSString stringWithFormat:@"%@",dic[@"is_roll"]]integerValue];
        model.roll_code=dic[@"roll_code"];
        
        if([dic[@"order_price"] isEqual:[NSNull null]]||!dic[@"order_price"])
            model.order_price=@"0";
        if([dic[@"tfn_money"] isEqual:[NSNull null]]||!dic[@"tfn_money"])
            model.tfn_money=@"0";
        
        model.order_price=dic[@"pay_money"];
        model.pay_status=[NSString stringWithFormat:@"%@",dic[@"pay_status"]];
        
        NSArray *brr=dic[@"orderShops"];
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
            //                    shopmodel.requestNow_time=responseObject[@"now"];
            
            shopmodel.orderShopStatus=dicc[@"status"];
            shopmodel.change=dicc[@"change"];
            shopmodel.status=dic[@"status"];
            
            model.orderShopStatus=dicc[@"status"];
            model.change=dicc[@"change"];
            model.status=dic[@"status"];
            
            shopmodel.pay_status=[NSString stringWithFormat:@"%@",dic[@"pay_status"]];
            
            [model.shopsArray addObject:shopmodel];
            
            model.shop_code=shopmodel.shop_code;
            
        }
        
        [self.dataArray addObject:model];
    }
    
    if(self.dataArray.count)
    {
        ShopDetailModel *orderShopmodel=self.dataArray[0];
        OrderDetailViewController *order=[[OrderDetailViewController alloc]init];
        order.orderModel=orderShopmodel;
        order.comefromPaySuccess = YES;
        [self.navigationController pushViewController:order animated:YES];
    }else{
        [self normalgotoLuck];
    }
}
-(void)back
{
    MyLog(@"self.ptype = %@",self.p_type);
    
    for(UIViewController *vc in self.navigationController.viewControllers)
    {
        if([vc isKindOfClass:[ShopDetailViewController class]]){
            [self.navigationController popToViewController:vc animated:YES];
            return;
            
        }else if ([vc isKindOfClass:[AffirmOrderViewController class]])
        {
            [self.navigationController popToViewController:vc animated:YES];
        }
        else if ([vc isKindOfClass:[MyOrderViewController class]]){
            if(self.p_type.intValue == 5){
                
                [self gotoviewcontroller];
                
            }else{
                [self.navigationController popToViewController:vc animated:YES];
            }
            return;
        }else if ([vc isKindOfClass:[ActivityShopOrderVC class]])
        {
            [self gotoviewcontroller];
        }
    }
}

- (NSMutableArray*)dataArray
{
    if(_dataArray == nil)
    {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
