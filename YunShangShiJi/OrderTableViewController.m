//
//  OrderTableViewController.m
//  YunShangShiJi
//
//  Created by yssj on 15/9/5.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//
/**
 ****************     目前下单都是跳转到此页面    详情页下单、购物车下单、搭配购下单
 **/

#import "OrderTableViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "AdressModel.h"
#import "SCarCell.h"
#import "TFReceivingAddressViewController.h"
#import "UIImageView+WebCache.h"
#import "TFUserCardViewController.h"
//#import "PaystyleViewController.h"
#import "TFPayStyleViewController.h"
#import "DXAlertView.h"
#import "TFSetPaymentPasswordViewController.h"
#import "TFPayPasswordView.h"
#import "PayFailedViewController.h"
#import "Order.h"
#import "BuySuccessViewController.h"
#import "payRequsestHandler.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "WXApiObject.h"
#import "AddressModel.h"
#import "ShopDetailViewController.h"
#import "LoginViewController.h"
#import "VoucherModel.h"
#import "AppDelegate.h"
#import "DShareManager.h"
#import "IntelligenceViewController.h"
#import "FightgroupsViewController.h"
#import "LuckdrawViewController.h"
#import "GroupBuyDetailVC.h"
#import "SpecialShopDetailViewController.h"
#import "TFPopBackgroundView.h"
#import "WTFAddressView.h"
#import "OrderFootView.h"
#import "UIButton+WTF.h"
#import "AffirmOrderCell.h"
#import "DefaultImgManager.h"
#import "GoldCouponsManager.h"
#import "GoldCouponModel.h"
#import "NSDate+Helper.h"
#import "BindingManager.h"
#import "OneYuanModel.h"
#import "TypeShareModel.h"
#import "ShopDetailViewModel.h"
#import "MyOrderViewController.h"
#import "OneLuckdrawViewController.h"
#import "OrderDetailViewController.h"
#import "ShareFreeLingViewController.h"
#import "ShareFreelingBargainViewController.h"
#define leftSpace ZOOM(62)
#define rightSpace ZOOM(42)
//#define integralRate  50
#define HEIGHT(height) [self heightCoefficient:height]
#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]

#define min(a,b,c) a>b?(b>c?c:b):(a>c?c:a)

#define MIN_IntegralNeed 1

@interface OrderTableViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>
{
    BOOL SwitchSelected;
    BOOL myMoneySwitchSelected;
    NSMutableArray *_DeliverArray;
    NSArray        *_shopArray;
    NSMutableArray *_couponArray;   //优惠劵
    NSMutableArray        *_supp_idArray;  //供应商id
    //    NSMutableArray *_integralArray; //输入积分数组
    //    NSMutableArray *_subIntegArray; //最多可使用积分数组
    NSMutableArray *_selectSwithcArray; //关闭switch数组
    
    double changeMoney;
    WTFAddressView  *_addressView;
    
    //    NSString *_urlcount;            //判断多订单还是单订单
    
    CGFloat tempTotalprice;         //价格合计
    NSString* tempShop_num;         //数量
    CGFloat couponMoney;            //优惠劵金额
    NSString *integralString;       //积分总数
    
    NSString *_orderPrice;
    
    BOOL _isnotifation;                 //是否监听到通知
    
    UIButton *confirmButton;
    NSString *orderToken;
    
    UISwitch *integralSwitch;
    UISwitch *myMoneySwitch;
    
    NSString *integral_num;
    
    UILabel *integralLabel;
    UILabel *discount;
    UILabel *discountLabel;
    UILabel *discountMoney;
    UILabel *remainMoney;
    
    
    OrderFootView *OrderFooterView;
    ShopDetailModel *_selectMoel;   //随机获取到的商品
    
    int secondsTime;
    NSTimer *secondsTimer;
    dispatch_source_t _timer; //计时器
    
    NSString *GoldIntegralString; //积分、金币
    NSString *GoldCouponString; //优惠券、金券
    
    NSInteger integralRate; //积分、金币  比率
    float myMaxUsedMoney;//余额最高抵扣
    float tempUsedMoney; //余额最高抵扣 存储临时值
    NSNumber *myWalletMoney;//钱包余额
    NSNumber *maxMoney;
    NSNumber *maxRate;
    
    BOOL FinishGetCoupon;
    BOOL share_freeLing; //是否分享免费领
}
@property (nonatomic, assign) double totalMoney;    /**< 钱包总额 */
@property (nonatomic, assign) double usableMoney; /**< 可用余额 */

@property (nonatomic,strong)NSMutableArray *voucherArr;
@property (nonatomic , strong)NSString *addressid;

@property(nonatomic,strong)UITextField *message;
@property(nonatomic,strong)UILabel *totalprice;         //总计
@property(nonatomic,strong)NSString *shop_code;         //商品编号
@property(nonatomic,strong)NSMutableArray *orderArray;  //订单数据
@property(nonatomic,assign)CGFloat shop_deduction;
@property(nonatomic,copy)NSString *maxType;
@end

@implementation OrderTableViewController

- (float)heightCoefficient:(float)height
{
    if (ThreeAndFiveInch) {
        return height*0.9;
    } else if (FourInch) {
        return height*0.9;
    } else if (FourAndSevenInch) {
        return height*1;
    } else if (FiveAndFiveInch) {
        return height*1;
    } else {
        return height*1;
    }
}
/**     改变结算按钮的状态    **/
-(void)changePayTimeAndBtn{
    confirmButton.textLabel.attributedText=[[NSAttributedString alloc]initWithString:@"确认下单"];
    confirmButton.backgroundColor= _coutTime == -1?tarbarrossred:kbackgrayColor;
    confirmButton.userInteractionEnabled=NO;
}
- (void)countdownTime {
    if (_coutTime<=0) {
        //        [self changePayTimeAndBtn];
        return;
    }
    __block int timeout=_coutTime;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //                [self changePayTimeAndBtn];
                confirmButton.textLabel.attributedText=[[NSAttributedString alloc]initWithString:@"确认下单"];
            });
        } else {
            int minute = timeout/60;
            int seconds = timeout%60;
            NSString *strTime = [NSString stringWithFormat:@"%02d:%02d", minute, seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                confirmButton.textLabel.attributedText=[NSMutableString getOneColorInLabel:[NSString stringWithFormat:@"确认下单\n%@",strTime] ColorString:strTime Color:[UIColor whiteColor] fontSize:ZOOM6(20)];
                //                [confirmButton setTitle:@"" forState:UIControlStateNormal];
                //                confirmButton.textLabel.attributedText=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"确认下单\n%@",strTime]];
            });
            timeout--;_coutTime--;
        }
    });
    dispatch_resume(_timer);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    share_freeLing = NO;
    GoldIntegralString = [GoldCouponsManager goldcpManager].gold_is_open?@"金币":@"积分";
    GoldCouponString = @"优惠券";
    integralRate = [GoldCouponsManager goldcpManager].gold_is_open?10:10;
    
    [TFStatisticsClickVM StatisticshandleDataWithClickType:@"到达订单确认" success:nil failure:nil];
    
    [DataManager sharedManager].outAppStatistics=@"确认订单页";
    
    orderToken = [[NSUserDefaults standardUserDefaults] objectForKey:ORDER_TOKEN];
    
    self.usableMoney=0;self.totalMoney=0;
    _isnotifation =NO;
    _addressid=@"0";
    _DeliverArray = [NSMutableArray array];
    _couponArray = [NSMutableArray array];
    _supp_idArray = [NSMutableArray array];
    //    _integralArray = [NSMutableArray array];
    //    _subIntegArray = [NSMutableArray array];
    _selectSwithcArray = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeaddress:) name:@"changeaddress" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteAddress:) name:@"deleteAddress" object:nil];
    
    //监听智能分享成功通知
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sharesuccess:) name:@"Intelligencesharesuccess" object:nil];
    //
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sharefail:) name:@"Intelligencesharefail" object:nil];
    
    
    /*
     //监听支付通知
     
     //设置支付密码成功监听
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setpasswordsuccess:) name:@"setpasswordsuccess" object:nil];
     */
    
    
    [self sort];
    
    couponMoney = 0;    integralString=@"0";
    
    
    [self setTableView];
    [self setBottomView];
    //    [self countdownTime];
    //    [self timer];
    [self setNavgationView];
    
    CGFloat totalprice=0;
    CGFloat totalnumber=0;
    for(int i=0;i<self.sortArray.count;i++)
    {
        ShopDetailModel *shopmodel=self.sortArray[i];
        
        NSString *price=[NSString stringWithFormat:@"%@",shopmodel.shop_se_price];
        NSString *number=[NSString stringWithFormat:@"%@",shopmodel.shop_num];
        
        CGFloat PRICE=[price floatValue]*[number integerValue];
        totalprice +=PRICE;
        totalnumber +=number.floatValue;
        
        if (shopmodel.shop_se_price.floatValue>=6||shopmodel.order_price.floatValue>=6)
            changeMoney += 6*shopmodel.shop_num.integerValue;
    }
    
    if (_orderBuyType == OrderType_Normal) {
        
        [self getOneYuanCount];
        
        [self httpMyWalletMoney];
        //    [self httpGetIntegral];
        
        [self httpVoucher];
        
        [self httpMaxMoneyAndRate:(CGFloat)totalprice];
        /*
         if ([DataManager sharedManager].isOpen) {
         [self httpGetUsableMoney];
         }
         */
        //%f",memberPriceRate);
        if ([GoldCouponsManager goldcpManager].is_open) {
            [self changeGoldCouponModel:totalprice];
        }else{
//             [self httpMatchCoupon1:totalprice-_allResavePrice];
        }
        
        
    }
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"RedMoneyLeastNum"] integerValue]!=-1) {
        [self httpGetRedMoneyLeastNum];
    }
    
    //一元购订单相关
    [DataManager sharedManager].orderShopAarray = [NSArray arrayWithArray:self.sortArray];
    ShopDetailModel *model ;
    if(self.sortArray.count)
    {
        model = self.sortArray[0];
        self.shop_code=model.shop_code;
    }
    [self getShopTypeDataFromShopcode:model.shop_code];
    
}

//获取订单商品的二级类目
- (void)getShopTypeDataFromShopcode:(NSString*)shopcode
{
    [TypeShareModel getTypeCodeWithShop_code:shopcode success:^(TypeShareModel *data) {
       
        if(data.status == 1)
        {
            [DataManager sharedManager].type_data = data.type2;
        }else{
            [DataManager sharedManager].type_data = nil;
        }
    }];
}
/**
 获取当天还有多少次抽奖机会
 */
- (void)httpGetRedMoneyLeastNum {
    kSelfWeak;
    [[APIClient sharedManager]netWorkGeneralRequestWithApi:@"order/getOrderRaffleNum?" caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
        if (response.status == 1) {
            [[NSUserDefaults standardUserDefaults]setObject:data[@"data"] forKey:@"RedMoneyLeastNum"];
            [[NSUserDefaults standardUserDefaults]setObject:data[@"n"] forKey:@"RedMoneyAllNum"];
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",data[@"money"]] forKey:@"RedMoneyRaward"];
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"RedMoneyLeastNum"] integerValue]!=-1)
                [weakSelf creatRedMoneyAlertView];
            
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)creatRedMoneyAlertView {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"余额抽奖红包"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"余额抽奖红包"] forState:UIControlStateNormal|UIControlStateHighlighted];
    [btn addTarget:self action:@selector(redViewClick) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(kScreenWidth-ZOOM6(168)-ZOOM6(20), 200, ZOOM6(168), ZOOM6(178));
    //    [self.view addSubview:btn];
    //    [self.view bringSubviewToFront:btn];
    
    kWeakSelf(self);
    [[DataManager sharedManager] taskListHttp:26 Success:^{
        
        [weakself.view addSubview:btn];
        [weakself.view bringSubviewToFront:btn];
    }];
    
}
- (void)redViewClick {
    
    kWeakSelf(self);
    
    [[BindingManager BindingManarer] checkPhoneAndUnionID:YES Success:^{
        
        [weakself gotoLuck];
    }];
    [BindingManager BindingManarer].BindingSuccessBlock = ^{
        [weakself gotoLuck];
    };
}
- (void)gotoLuck
{
    LuckdrawViewController *vc = [[LuckdrawViewController alloc]init];
    vc.is_OrderRedLuck = [[[NSUserDefaults standardUserDefaults]objectForKey:@"RedMoneyLeastNum"] integerValue] ? YES : NO;
    vc.is_comefromeRed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
/*
 -(void)timer{
 secondsTime=_coutTime;
 secondsTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerMethod:) userInfo:nil repeats:YES];
 //    [[NSRunLoop currentRunLoop] addTimer:secondsTimer forMode:UITrackingRunLoopMode];
 }
 - (void)timerMethod:(NSTimer*)theTimer
 {
 if (secondsTime <= 0) {
 [secondsTimer invalidate];
 }else{
 int minute = secondsTime/60;
 int seconds = secondsTime%60;
 NSString *strTime = [NSString stringWithFormat:@"%02d:%02d", minute, seconds];
 confirmButton.textLabel.attributedText=[NSMutableString getOneColorInLabel:[NSString stringWithFormat:@"确认下单\n%@",strTime] ColorString:strTime Color:[UIColor whiteColor] fontSize:ZOOM6(20)];
 secondsTime--;
 }
 }
 */
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    confirmButton.userInteractionEnabled=YES;
    if (_orderBuyType==OrderType_GroupBuy
        &&
        [self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden = YES;
    
    if (_timer==nil) {
        [self countdownTime];
    }
    
    //如果有选取地址就不用请求获取收货地址
    if(_isnotifation==NO){
        //获取收货信息
        [self httpDelivery];
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden = NO;
    if(_timer){
        dispatch_source_cancel(_timer);
        _timer=nil;
    }
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark - keyboard
- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    CGPoint rootViewPoint = [[self.message superview] convertPoint:self.message.frame.origin toView:self.view];
    //%f  %f",self.message.frame.origin.y,rootViewPoint.y);
    
    CGFloat height =rootViewPoint.y -keyboardFrame.origin.y;
    
    if (height>0)
    {
        [UIView animateWithDuration:animationDuration
                         animations:^{
                             _myTableView.frame=CGRectMake(0,_myTableView.frame.origin.y-height-Height_NavBar, kApplicationWidth, _myTableView.frame.size.height);
                             
                         }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         _myTableView.frame=CGRectMake(0, Height_NavBar, kApplicationWidth, _myTableView.frame.size.height);
                     }];
}
/****************  数据源处理   ***********/
-(void)sort
{
    //    [_subIntegArray removeAllObjects];
    //    [_integralArray removeAllObjects];
    [_supp_idArray removeAllObjects];
    
    NSMutableArray *shoparr = [NSMutableArray arrayWithArray:self.sortArray];
    
    NSMutableArray *dateMutablearray = [@[] mutableCopy];
    NSMutableString *tempStrings=[NSMutableString string];
    
    NSMutableArray *array = [NSMutableArray array];
    for(int i=0;i<self.sortArray.count;i++){
        ShopDetailModel *model=self.sortArray[i];
        if(model.supp_id){
            [array addObject:model.supp_id];
        }
        if (model.p_code!=nil) {
            NSArray *arr = [NSArray arrayWithObject:model];
            [dateMutablearray addObject:arr];
        }
    }
    
    for (int i = 0; i < array.count; i ++) {
        
        ShopDetailModel *model=shoparr[i];
        NSString *string = [NSString stringWithFormat:@"%@",array[i]];
        NSMutableArray *tempArray = [@[] mutableCopy];
        NSMutableArray *tempArray1 = [@[] mutableCopy];
        
        [tempArray addObject:string];
        [tempArray1 addObject:model];
        [tempStrings appendString:[NSString stringWithFormat:@"%@",model.supp_id]];
        [tempStrings appendString:@","];
        
        
        for (int j = i+1; j < array.count; j ++) {
            ShopDetailModel *model1=shoparr[j];
            
            NSString *jstring = [NSString stringWithFormat:@"%@",array[j]];
            
            if([string isEqualToString:jstring]){
                
                [tempArray addObject:jstring];
                [tempArray1 addObject:model1];
                
                [array removeObjectAtIndex:j];
                [shoparr removeObjectAtIndex:j];
                j -= 1;
                
            }
            //            else{
            //                [tempStrings appendString:[NSString stringWithFormat:@"%@",model1.supp_id]];
            //                [tempStrings appendString:@","];
            //
            //            }
            
        }
        [dateMutablearray addObject:tempArray1];
    }
    
    _shopArray = [NSArray arrayWithArray:dateMutablearray];
    //    //tempstrings:%@   dateMutable:%@",tempStrings,dateMutablearray);
    
    /************   以下优惠劵参数操作  供应商supp_id和总价格 ***********/
    
    NSMutableString *priceStrings=[NSMutableString string];
    //    CGFloat totalprice=0;
    CGFloat totalnumber=0;
    
    for (int i=0; i<_shopArray.count; i++) {
        NSArray *array = _shopArray[i];
        CGFloat totalShopPrice=0;
        for (int j=0; j<array.count; j++) {
            ShopDetailModel *shopmodel=array[j];
            
            //            NSString *price=[NSString stringWithFormat:@"%@",shopmodel.original_price];
            NSString *number=[NSString stringWithFormat:@"%@",shopmodel.shop_num];
            
            NSString *shop_Price=[NSString stringWithFormat:@"%@",shopmodel.shop_se_price];
            CGFloat shopPrice = [shop_Price floatValue]*[number integerValue];
            totalShopPrice +=shopPrice;
            
            //            CGFloat PRICE=[price floatValue]*[number integerValue];
            //            totalprice +=PRICE;
            totalnumber +=number.floatValue;
            
            //            shopmodel.voucher=[NSString stringWithFormat:@"%d",[self vouchersMatch:shopmodel]];
        }
        
        //        [_subIntegArray addObject:[NSString stringWithFormat:@"%f",totalprice]];
        //        [_integralArray addObject:[NSString stringWithFormat:@"0"]];
        [priceStrings appendString:[NSString stringWithFormat:@"%.2f,",totalShopPrice]];
        //        totalprice = 0;
        totalnumber =0;
        
    }
    //    //idstrings %@",priceStrings);
    
    
    NSArray *idarray = [tempStrings componentsSeparatedByString:@","];
    _supp_idArray = [NSMutableArray arrayWithArray:idarray];
    NSArray *priceArray = [priceStrings componentsSeparatedByString:@","];
    NSMutableString *allstrings=[NSMutableString string];
    
    for (int i=0; i<idarray.count-1; i++) {
        for (int j=0; j<priceArray.count-1; j++) {
            if (i==j) {
                [allstrings appendString:[NSString stringWithFormat:@"%@:%@,",idarray[i],priceArray[j]]];
            }
        }
    }
    //    //%@",allstrings);
    
    
}
- (void)httpMaxMoneyAndRate:(CGFloat)totalPrice {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr1 = [NSString stringWithFormat:@"%@order/addOrderAgo?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL1 = [MyMD5 authkey:urlStr1];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        maxRate=responseObject[@"maxRate"];
        maxMoney=responseObject[@"maxMoney"];
        myMaxUsedMoney=MIN([maxRate floatValue]*totalPrice, [maxMoney floatValue]);
        tempUsedMoney=myMaxUsedMoney;
        if (OrderFooterView.bottomMoneyLabel5.hidden) {
            [OrderFooterView hidBottomLabel:5 hidden:NO];
            [self changeTotalPrice];
            [_myTableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NavgationbarView *nv =[[NavgationbarView alloc]init];
        [nv showLable:@"网络连接失败，请检查网络后重试" Controller:self];
    }];
}

//钱包余额
- (void)httpMyWalletMoney
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr1 = [NSString stringWithFormat:@"%@wallet/myWallet?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL1 = [MyMD5 authkey:urlStr1];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            myWalletMoney = responseObject[@"balance"];
            //是否翻倍
            if ([DataManager sharedManager].isOligible&&[DataManager sharedManager].isOpen&&([DataManager sharedManager].twofoldness > 0)) {
                myWalletMoney = [NSNumber numberWithDouble:myWalletMoney.floatValue*[DataManager sharedManager].twofoldness];
            }
//            myMoneySwitchSelected=(myWalletMoney.floatValue)?YES:NO;
            myMoneySwitchSelected=([DataManager sharedManager].one_not_use_price>0)?YES:NO;
            
            [self changeTotalPrice];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NavgationbarView *nv =[[NavgationbarView alloc]init];
        [nv showLable:@"网络连接失败，请检查网络后重试" Controller:self];
    }];
}

//可抵扣的余额
- (void)getOneYuanCount
{
    [OneYuanModel GetOneYuanCountSuccess:^(id data) {
        OneYuanModel *oneModel = data;
        if(oneModel.status == 1)
        {
//            OneYuanDataModel *dataModel = oneModel.data;
            
            [DataManager sharedManager].one_not_use_price = oneModel.one_not_use_price;
        }
    }];
}
/**
 *  获取订单详情数据
 */

- (void)httpGetOrderDetailData:(NSDictionary*)orderDta Pay:(BOOL)isPay
 {
     NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
     NSString *token = [ud objectForKey:USER_TOKEN];
     NSString *urlStr1 = [NSString stringWithFormat:@"%@order/getOrderDetialByGcodeOrOcode?version=%@&token=%@&order_code=%@",[NSObject baseURLStr],VERSION,token,orderDta[@"order_code"]];
     NSString *URL1 = [MyMD5 authkey:urlStr1];
     
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     [manager GET:URL1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         if (responseObject!=nil) {
             //responseObject = [NSDictionary changeType:responseObject];
             if ([responseObject[@"status"] intValue] == 1) {
                
                 [self handelOrderData:orderDta OrderDetialData:responseObject Pay:isPay];
             } else {
                 [MBProgressHUD showError:responseObject[@"message"]];
             }
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NavgationbarView *nv =[[NavgationbarView alloc]init];
         [nv showLable:@"网络连接失败，请检查网络后重试" Controller:self];
     }];
 }

- (void)handelOrderData:(NSDictionary*)orderData OrderDetialData:(NSDictionary*)dic Pay:(BOOL)isPay
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
        
        [self.orderArray addObject:model];
    }
    
    if(!isPay)//不用支付
    {
        if(self.orderArray.count)
        {
            ShopDetailModel *orderShopmodel=self.orderArray[0];
            OrderDetailViewController *order=[[OrderDetailViewController alloc]init];
            order.orderModel=orderShopmodel;
            [self.navigationController pushViewController:order animated:YES];
        }
    }else{//要支付
        [self goPaystyleVC:orderData];
    }
   
}
 
- (void)changeGoldCouponModel:(CGFloat )totalprice {
    [GoldCouponModel getGoldCoupons:@"CpGold" success:^(id data) {
        GoldCouponModel *goldmodel = data;
        GoldcpModel *model = goldmodel.CpGold;
        if(goldmodel.status == 1){
            
            [GoldCouponsManager goldcpManager].is_open = YES ;
            [GoldCouponsManager goldcpManager].goldcp_end_date = model.end_date;
            [GoldCouponsManager goldcpManager].c_last_time = model.c_last_time;
            [GoldCouponsManager goldcpManager].c_price = model.c_price;
            [GoldCouponsManager goldcpManager].is_use = model.is_use;
            [GoldCouponsManager goldcpManager].c_id = model.c_id;
            
        }else{
            [GoldCouponsManager goldcpManager].is_open = NO;
        }
//        [self httpMatchCoupon1:totalprice-_allResavePrice];
        
    }];
}
/**************   自动匹配优惠劵    ************/
-(void)httpMatchCoupon1:(CGFloat )totalprice
{
    NSString *string = [NSString stringWithFormat:@"0:%.2f",totalprice*memberPriceRate];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *url=[NSString stringWithFormat:@"%@coupon/appMatchCoupon?version=%@&token=%@&result=%@",[NSObject baseURLStr],VERSION,token,string];
    NSString *URL=[MyMD5 authkey:url];
    
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject!=nil) {
            FinishGetCoupon=YES;
            // responseObject = [NSDictionary changeType:responseObject];
            //            NSString *idstr = [NSString stringWithFormat:@"%@",self.shopmodel.supp_id];
            NSDictionary *dic = responseObject[@"0"];
            MyCardModel *model = [[MyCardModel alloc]init];
            model.c_price = dic[@"c_price"];
            model.ID=dic[@"id"];
            GoldCouponString=@"优惠券";
            
            //            if (nil == model.c_price && [GoldCouponsManager goldcpManager].c_price<totalprice &&![GoldCouponsManager goldcpManager].is_use&&[GoldCouponsManager goldcpManager].is_open ) {
            //                model.c_price = [NSNumber numberWithFloat:[GoldCouponsManager goldcpManager].c_price];
            //                model.ID = [NSNumber numberWithInteger:[GoldCouponsManager goldcpManager].c_id];
            //                GoldCouponString=@"金券";
            //            }
            
            self.cardModel = model;
            couponMoney=model.c_price.floatValue;
            if(model.c_price != nil&&dic!=nil){
                //                discountLabel.text = [NSString stringWithFormat:@"( 已选择一张优惠劵,优惠%@元 )",model.c_price];
                [self changeDiscountLabel:[NSString stringWithFormat:@"可使用1张%@",GoldCouponString]];
                [self changeTableFooterViewFrame];
                //                [self changeTotalPrice];
            }
            [self integralSwitchClick:nil];
            //            [self changeTotalPrice];
            [self httpGetIntegral];//先匹配优惠券  然匹配积分
            
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self httpGetIntegral];
        
    }];
}

-(void)httpVoucher
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *url=[NSString stringWithFormat:@"%@coupon/queryVoucher?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject!=nil) {
            //responseObject = [NSDictionary changeType:responseObject];
            MyLog(@"%@",responseObject);
            [self.voucherArr removeAllObjects];
            for (NSDictionary *dic in responseObject[@"voucher"]) {
                VoucherModel *model = [[VoucherModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.voucherArr addObject:model];
                
            }
            [self.voucherArr sortUsingSelector:@selector(comparePerson:)];
            for (int i=0; i<_shopArray.count; i++) {
                NSArray *array = _shopArray[i];
                for (int j=0; j<array.count; j++) {
                    ShopDetailModel *shopmodel=array[j];
                    shopmodel.voucher=[NSString stringWithFormat:@"%d",[self vouchersMatch:shopmodel]];
                    if (shopmodel.voucher.floatValue==0) {
                        [_selectSwithcArray addObject:shopmodel.ID];
                    }
                }
            }
            [self changeTotalPrice];
            [_myTableView reloadData];
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)setNavgationView
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"确认订单";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.size.height-1, kApplicationWidth, 0.5)];
    line.backgroundColor = kNavLineColor;
    [headview addSubview:line];
    
}
-(void)dismissKeyBoard{
    [self.message resignFirstResponder];
}

-(void)OrderFooterViewMoney:(BOOL)isfight
{
    CGFloat totalprice=0;
    CGFloat totalVoucher=0;
    for(int i=0;i<self.sortArray.count;i++){
        ShopDetailModel *shopmodel=self.sortArray[i];
        NSString *price=[NSString stringWithFormat:@"%@",isfight?shopmodel.app_shop_group_price:shopmodel.shop_se_price];
        NSString *number=[NSString stringWithFormat:@"%@",shopmodel.shop_num];
        CGFloat PRICE=[price floatValue]*[number integerValue];
        totalprice +=PRICE;
        totalVoucher += shopmodel.voucher.integerValue;
    }
    OrderFooterView.bottomMoneyLabel1.text=[NSString stringWithFormat:@"¥%.2f",totalprice];
    OrderFooterView.bottomMoneyLabel2.text=@"-¥0.0";
    OrderFooterView.bottomMoneyLabel4.text=[NSString stringWithFormat:@"-¥%.2f",totalVoucher];
    OrderFooterView.bottomMoneyLabel3.text=[NSString stringWithFormat:@"-¥%.2f",_allResavePrice];
    
}
-(void)changeTableFooterViewFrame
{
    if ((couponMoney!=0 || integralString.integerValue>=MIN_IntegralNeed||([GoldCouponsManager goldcpManager].gold_is_open&&integralString.integerValue))&&OrderFooterView.bottomMoneyLabel6.hidden) {
        //        [OrderFooterView hidBottomLabel:4 hidden:YES];
        OrderFooterView.bottomLabel6.text = GoldCouponString;
        OrderFooterView.bottomLabel7.text = GoldIntegralString;
        [OrderFooterView hidBottomLabel:6 hidden:NO];
        [OrderFooterView hidBottomLabel:7 hidden:NO];
        _myTableView.tableFooterView=OrderFooterView;
        
    }
    
}
-(void)setTableView
{
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight-Height_NavBar-50+kUnderStatusBarStartY) style:UITableViewStyleGrouped];
    _myTableView.backgroundColor = [UIColor whiteColor];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _myTableView.showsVerticalScrollIndicator=NO;
    self.myTableView.keyboardDismissMode  = UIScrollViewKeyboardDismissModeOnDrag;
    [_myTableView registerClass:[AffirmOrderCell class] forCellReuseIdentifier:@"cell"];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyBoard)];
    tapGesture.cancelsTouchesInView =NO;
    [_myTableView addGestureRecognizer:tapGesture];
    //    _myTableView.tableFooterView=[self setTableFooterView];
    [self.view addSubview:_myTableView];
    
    OrderFooterView=[[OrderFootView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM(20)*2+ZOOM(100)*7+ZOOM6(20))];
    [OrderFooterView hidBottomLabel:2 hidden:YES];
    [OrderFooterView hidBottomLabel:3 hidden:YES];
    [OrderFooterView hidBottomLabel:4 hidden:YES];
    [OrderFooterView hidBottomLabel:5 hidden:YES];
    [OrderFooterView hidBottomLabel:6 hidden:YES];
    [OrderFooterView hidBottomLabel:7 hidden:YES];
    
    //    _myTableView.tableFooterView=OrderFooterView;
    [self OrderFooterViewMoney:self.isFight];
    
    
    __weak typeof(self) weakSelf = self;
    _addressView=[[WTFAddressView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(270))];
    _addressView.btnViewBlock=^{
        [weakSelf addressViewTap];
    };
    _addressView.type=WTFAddressEmpty;
    [self hideAddressTopView:!_haveType];
    //    _myTableView.tableHeaderView = _addressView;
    
}

/**************************   底部视图 *************************/
-(void)setBottomView
{
    //下面带有提醒功能的视图
    UIView *foorview=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 50)];
    foorview.backgroundColor=[UIColor whiteColor];
    //    foorview.layer.shadowOffset=CGSizeMake(0, -1);
    //    foorview.layer.shadowColor = [UIColor blackColor].CGColor;
    //    foorview.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    //    foorview.layer.shadowRadius = 4;//阴影半径，默认3
    
    [self.view addSubview:foorview];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 0.5)];
    line.backgroundColor = kNavLineColor;
    [foorview addSubview:line];
    
    //付款
    confirmButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    CGFloat width = ZOOM6(20)+[@"确认购买即赢千元大奖" getWidthWithFont:[UIFont systemFontOfSize:ZOOM(46)] constrainedToSize:CGSizeMake(MAXFLOAT, 50)];
    CGFloat width = kScreenWidth/2;
    confirmButton.frame=CGRectMake(kApplicationWidth-width, 0, width, foorview.frame.size.height);
    //    [confirmButton setTitle:@"确认下单" forState:UIControlStateNormal];
    //    button1.layer.cornerRadius=5;
    [confirmButton setTitle:@"提交订单" forState:UIControlStateNormal];
    confirmButton.titleLabel.font=[UIFont systemFontOfSize:ZOOM(46)];
    confirmButton.tintColor=[UIColor whiteColor];
    [confirmButton setBackgroundColor:tarbarrossred];
    [confirmButton addTarget:self action:@selector(affirmorder:) forControlEvents:UIControlEventTouchUpInside];
    [foorview addSubview:confirmButton];
    
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth/2);
        make.top.right.offset(0);
        make.height.offset(50);
    }];
    
    CGFloat totalpriceWith = kScreenWidth/2+ZOOM6(20);
    
//    _totalprice = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(confirmButton.frame)-ZOOM6(20)-200-ZOOM6(20), 5,200, 40)];
    _totalprice = [[UILabel alloc]initWithFrame:CGRectMake(0, 5,totalpriceWith, 40)];
    _totalprice.textAlignment=NSTextAlignmentCenter;
    _totalprice.textColor = tarbarrossred;
    
    self.totalprice.font=[UIFont systemFontOfSize:ZOOM(50)];
    [foorview addSubview:_totalprice];
    [_totalprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(ZOOM6(0));
        make.top.offset(5);
        make.width.mas_equalTo(totalpriceWith);
        make.height.offset(40);
    }];
    
    if (_orderBuyType == OrderType_Normal) {
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(confirmButton.frame)-ZOOM6(20)-ZOOM6(120), 5, ZOOM6(120), 40)];
        label.textAlignment=NSTextAlignmentRight;
        label.textColor=kTextColor;
        label.font=[UIFont systemFontOfSize:ZOOM6(24)];
        [foorview addSubview:label];

        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(5);
            make.right.equalTo(confirmButton.mas_left).offset(-ZOOM6(0));
            make.height.offset(40);
            make.left.equalTo(_totalprice.mas_right).offset(ZOOM6(0));
        }];

        CGFloat temp=0;
        for(int i=0;i<self.sortArray.count;i++){
            ShopDetailModel *shopmodel=self.sortArray[i];
            temp += [shopmodel.shop_se_price floatValue]/[shopmodel.shop_price floatValue]*10;
        }
//        label.text=[NSString stringWithFormat:@"专柜%.1f折",temp/self.sortArray.count];
        
    }else {
//        _totalprice.frame = CGRectMake(CGRectGetMinX(confirmButton.frame)-ZOOM6(20)-200, 5,200, 40);
        
        _totalprice.frame = CGRectMake(0, 5,totalpriceWith, 40);
        [confirmButton setTitle:@"提交订单" forState:UIControlStateNormal];
    }
    [self changeTotalPrice];
}
#pragma mark 设置收获地址
-(void)addressViewTap
{
    TFReceivingAddressViewController *tfreceiving=[[TFReceivingAddressViewController alloc]init];
    tfreceiving.adresstype = @"选择收货地址";
    [self.navigationController pushViewController:tfreceiving animated:YES];
    
}
-(void)deleteAddress:(NSNotification *)note
{
    AddressModel *model=note.object;
    NSMutableString *addressstr =[[NSMutableString alloc]init];
    if(model.addressArray.count != 0 ) {
        for(int i=0;i<model.addressArray.count;i++){
            [addressstr appendString:model.addressArray[i]];
        }
    }
    //%@  %@",_address.text,[NSString stringWithFormat:@"收货地址:%@%@",addressstr,model.address]);
    if ([_addressView.addressLabel.text isEqualToString:[NSString stringWithFormat:@"收货地址:%@%@",addressstr,model.address]]) {
        [self httpDelivery];
    }
}
#pragma mark - **************更换收货地址
-(void)changeaddress:(NSNotification*)note
{
    AddressModel *model=note.object;
    
    [self createDetailAddressView];
    
    NSMutableString *addressstr =[[NSMutableString alloc]init];
    if(model.addressArray.count != 0 ) {
        for(int i=0;i<model.addressArray.count;i++){
            [addressstr appendString:model.addressArray[i]];
        }
    }
    _addressid=[NSString stringWithFormat:@"%@",model.ID];
    //    //_addressid %@",_addressid);
    _addressView.nameLabel.text=[NSString stringWithFormat:@"收货人:%@   %@",model.consignee ,model.phone ];
    _addressView.addressLabel.text=[NSString stringWithFormat:@"收货地址:%@%@",addressstr,model.address];
    _isnotifation = YES;
    
}
#pragma mark 获取默认的收货地址
/**************************   获取默认的收货地址 *************************/
-(void)httpDelivery
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *url=[NSString stringWithFormat:@"%@address/queryDefault?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL=[MyMD5 authkey:url];
    
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject!=nil) {
            //responseObject = [NSDictionary changeType:responseObject];
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1){
                NSDictionary *dic=responseObject[@"address"];
                if([dic count]!=0) {
                    AdressModel *model=[[AdressModel alloc]init];
                    model.address=dic[@"address"];
                    model.consignee=dic[@"consignee"];
                    model.phone=dic[@"phone"];
                    model.postcode=dic[@"postcode"];
                    [_DeliverArray addObject:model];
                    self.addressid=@"0";
                    if(_DeliverArray.count>0){
                        [self createDetailAddressView];
                        _addressView.nameLabel.text=[NSString stringWithFormat:@"收货人:%@   %@",model.consignee ,model.phone ];
                        _addressView.addressLabel.text=[NSString stringWithFormat:@"收货地址:%@",model.address];
                    }
                }else{
                    [self creatAddressView];
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
                [self creatAddressView];
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"收货地址获取失败" Controller:self];
    }];
}

#pragma mark - 获取积分
/***************    获取积分   **************/
- (void)httpGetIntegral
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/getIntegralNum?token=%@&version=%@",[NSObject baseURLStr],token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject!=nil) {
            //responseObject = [NSDictionary changeType:responseObject];
            if ([responseObject[@"status"] intValue] == 1&&responseObject[@"integral"]!=nil&&![responseObject[@"integral"]isEqual:[NSNull null]]) {
                
                //                integralString = [self allCore] < [responseObject[@"integral"]floatValue] ? [NSString stringWithFormat:@"%d",[self allCore]]:[NSString stringWithFormat:@"%@",responseObject[@"integral"]];//积分总额
                
                //                integralString = [NSString stringWithFormat:@"%@",responseObject[@"integral"]];//积分总额
                
                NSInteger priceIntegral = _haveType ?  ([self allPrice]-_allResavePrice)/2 *integralRate*10 : [self allPrice]/2 *integralRate*10;
                integralString = priceIntegral < [responseObject[@"integral"]floatValue] ? [NSString stringWithFormat:@"%zd",priceIntegral]:[NSString stringWithFormat:@"%@",responseObject[@"integral"]];//积分总额
                
                if ([GoldCouponsManager goldcpManager].gold_is_open) {//金币最多600
                    integralString = integralString.integerValue>600?@"600":integralString;
                }
                [self integralSwitchClick:nil];
                [_myTableView reloadData];
                [self changeTableFooterViewFrame];
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
    
}
/**   隐藏搭配购提醒 **/
-(void)hideAddressTopView:(BOOL)hidden{
    NSString *dpZheKou = [[NSUserDefaults standardUserDefaults]objectForKey:@"dpZheKou"];
    
    _addressView.subLabel.text=[NSString stringWithFormat:@"已享受%.1f折优惠，为你节省¥%.2f",dpZheKou.floatValue*10,_allResavePrice];
    [_addressView setHiddenTopView:hidden];
    _myTableView.tableHeaderView = _addressView;
    if (hidden==NO) {
        [OrderFooterView hidBottomLabel:3 hidden:hidden];
    }else if (_orderBuyType == OrderType_GroupBuy) {
        OrderFooterView.bottomLabel3.text = @"超级拼团购";
        OrderFooterView.bottomLabel4.text = @"还需支付";
        [OrderFooterView hidBottomLabel:3 hidden:YES];
        [OrderFooterView hidBottomLabel:4 hidden:YES];
    }
    
    
    _myTableView.tableFooterView=OrderFooterView;
}
/**************************   地址详情  *************************/
-(void)createDetailAddressView
{
    _addressView.type=WTFAddressNormal;
    _myTableView.tableHeaderView = _addressView;
    
}
/**************************   无地址  *************************/
-(void)creatAddressView
{
    _addressView.type=WTFAddressEmpty;
    _myTableView.tableHeaderView = _addressView;
}

- (void)zeroBuyRemindView {
    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] initWithTitle:@"温馨提示" message:@"每日仅有一次0元购美衣的机会哦。错过就木有啦。" showCancelBtn:NO leftBtnText:@"0元也不要" rightBtnText:@"要要要"];
    popView.textAlignment=NSTextAlignmentCenter;
    popView.isManualDismiss = YES;
    popView.showView = self.view;
    
    kSelfWeak;
    [popView showCancelBlock:^{
        [popView dismissAlert:YES];
        //关闭计时器
        if(_timer) {
            dispatch_source_cancel(_timer);
            _timer = nil;
        }
        
        //何波修改 2017-7-10
        if(weakSelf.isFight){
            for(UIViewController *vc in weakSelf.navigationController.viewControllers) {
                if([vc isKindOfClass:[FightgroupsViewController class]]) {
                    [weakSelf.navigationController popToViewController:vc animated:YES];
                }
            }
        }else{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } withConfirmBlock:^{
        [popView dismissAlert:YES];
    } withNoOperationBlock:^{
        
    }];
    
}
-(void)goBack:(UIButton*)sender
{
//    [self zeroBuyRemindView];
    
    [self.view endEditing:YES];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:nil message:@"这么好的宝贝,确定不要了吗?"  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"我再想想" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        [alertCtrl addAction:cancelAction];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //关闭计时器
            if(_timer) {
                dispatch_source_cancel(_timer);
                _timer = nil;
            }
            
            //何波修改 2017-7-10
            if(self.isFight)
            {
                for(UIViewController *vc in self.navigationController.viewControllers)
                {
                    if([vc isKindOfClass:[FightgroupsViewController class]])
                    {
                        [self.navigationController popToViewController:vc animated:YES];
                        return ;
                    }
                }
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        [alertCtrl addAction:okAction];
        [self presentViewController:alertCtrl animated:YES completion:nil];
        
    }else{
        
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:nil message:@"这么好的宝贝,确定不要了吗?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"我再想想",@"确定", nil];
        alterview.delegate = self;
        alterview.tag = 8787;
        [alterview show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        //关闭计时器
        if(_timer) {
            dispatch_source_cancel(_timer);
            _timer = nil;
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = _orderBuyType==OrderType_Normal?ZOOM6(50):0;
    if (indexPath.row ==[_shopArray[indexPath.section] count]-1) {
        return ZOOM6(30)*2+ZOOM6(140)+height;
    }else
        return ZOOM6(30)+ZOOM6(140)+height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return _shopArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_shopArray[section]count];
}
- (NSString *)exchangeTextWihtString:(NSString *)text
{
    if ([text rangeOfString:@"】"].location != NSNotFound){
        NSArray *arr = [text componentsSeparatedByString:@"】"];
        NSString *textStr;
        if (arr.count == 2) {
            textStr = [NSString stringWithFormat:@"%@%@】", arr[1], arr[0]];
            return textStr;
        }
    }
    return text;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AffirmOrderCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    ShopDetailModel *model = _shopArray[indexPath.section][indexPath.row];
    cell.shop_model = model;
    if(!self.isSpecialOrder)
    {
        cell.color_size.text=[NSString stringWithFormat:@"颜色:%@  尺码:%@",model.shop_color,model.shop_size];
    }else{
        cell.color_size.text=[NSString stringWithFormat:@"%@ %@ %@",model.shop_color!=nil?model.shop_color:@"",model.shop_size!=nil?model.shop_size:@"",model.shop_other!=nil?model.shop_other:@""];
    }
    cell.title.text=[NSString stringWithFormat:@"%@",[self exchangeTextWihtString:model.shop_name]];
    
    
    NSString *shop_seprice = [NSString stringWithFormat:@" ¥%.2f",[model.shop_se_price floatValue]];
    NSString *oldPrice = [NSString stringWithFormat:@" ¥%.2f",[model.shop_price floatValue]];
    
    //如果是拼团下单价格另算
    if(self.orderBuyType == OrderType_FightBuy)
    {
        shop_seprice = [NSString stringWithFormat:@" ¥%.2f",[model.assmble_price floatValue]];
        oldPrice = [NSString stringWithFormat:@" ¥%.2f",[model.shop_price floatValue]];
    }
    else if([DataManager sharedManager].is_OneYuan && self.isFight){
        shop_seprice = [NSString stringWithFormat:@" ¥%.2f",[model.app_shop_group_price floatValue]];
        oldPrice = [NSString stringWithFormat:@" ¥%.2f",[model.shop_se_price floatValue]];
    }

    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    
    cell.price.text= shop_seprice;
    [cell.shop_oldPrice setAttributedText:attri];
    
    NSString *str=[NSString stringWithFormat:@"%@ %@",shop_seprice,oldPrice];
    NSMutableAttributedString *attriStr = [NSString getOneColorInLabel:str ColorString:oldPrice Color:kTextColor fontSize:ZOOM6(24)];
    [cell.price setAttributedText:attriStr];
    cell.brand.text = [model.supp_label containsString:@"null"]||[model.supp_label isEqual:[NSNull null]]||model.supp_label==nil
    ? @""
    : [NSString stringWithFormat:@"%@",model.supp_label];
    //    cell.shop_oldPrice.text=[NSString stringWithFormat:@"¥%.1f",[model.shop_price floatValue]];
    cell.number.text=[NSString stringWithFormat:@"x%@",model.shop_num];
    
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM6(30)]};
    CGSize textSize = [[NSString stringWithFormat:@"¥%.2f",[model.shop_se_price floatValue]] boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    cell.line.frame = CGRectMake(cell.price.frame.origin.x+textSize.width+ZOOM6(20), cell.line.frame.origin.y, [NSString widthWithString:oldPrice font:kFont6px(24) constrainedToHeight:20], cell.line.frame.size.height);
    cell.line.backgroundColor = kTextColor;
    
    cell.returnMoney.hidden = _orderBuyType==OrderType_GroupBuy;
    cell.returnMoney.text = [NSString stringWithFormat:@"返%.2f元=0元购",[model.shop_se_price floatValue]];
    cell.returnMoney.hidden = YES;
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@!180",[NSObject baseURLStr_Upy],[MyMD5 pictureString:model.shop_code],model.def_pic]];
    
    //    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.def_pic]];
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [cell.headimage sd_setImageWithURL:imgUrl placeholderImage:DefaultImg(cell.headimage.bounds.size) options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            cell.headimage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                cell.headimage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            cell.headimage.image = image;
        }
    }];
    
    return cell;
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AffirmOrderCell *cell = (AffirmOrderCell*)[tableView cellForRowAtIndexPath:indexPath];
    UIImage *image= cell.headimage.image;
    ShopDetailModel *shopdetailmodel=_shopArray[indexPath.section][indexPath.row];
    
//    if(self.isSpecialOrder)
//    {
//        SpecialShopDetailViewController *specialshopdetail = [[SpecialShopDetailViewController alloc]init];
//        specialshopdetail.shop_code = shopdetailmodel.shop_code;
//        specialshopdetail.bigimage = image;
//        [self.navigationController pushViewController:specialshopdetail animated:YES];
//
//    }else{
//        ShopDetailViewController *shopdetail=[[ShopDetailViewController alloc]init];
//        shopdetail.shop_code=shopdetailmodel.shop_code;
//        shopdetail.bigimage = image;
//        shopdetail.stringtype = @"订单详情";
//        if(self.isFight)
//        {
//            shopdetail.stringtype = @"活动商品";
//            shopdetail.isFight = YES;
//        }
//        [self.navigationController pushViewController:shopdetail animated:YES];
//    }
    
    ShopDetailViewController *shopdetail=[[ShopDetailViewController alloc]init];
    shopdetail.shop_code=shopdetailmodel.shop_code;
    shopdetail.bigimage = image;
    shopdetail.isTM = self.isSpecialOrder;
    shopdetail.stringtype = @"订单详情";
    if(self.isFight)
    {
        shopdetail.stringtype = @"活动商品";
        shopdetail.isFight = YES;
    }
    [self.navigationController pushViewController:shopdetail animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_orderBuyType == OrderType_GroupBuy) {
        return 70;
    }else
        return 70;
//        if (section == [_shopArray count]-1) {
//            return 330+ZOOM6(20)-150;
//            //        return [DataManager sharedManager].isOpen?340+ZOOM6(20)+50:340+ZOOM6(20);
//        }
    return  205+30+ZOOM6(20)-150;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    const CGFloat detailLabel_XPoint=ZOOM(260);
    UIView* sectionFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 205+30+ZOOM6(20)-150)];
    if (_orderBuyType == OrderType_GroupBuy) {
        sectionFooterView.frame = CGRectMake(0, 0, kApplicationWidth, 70);
    }else
        if (section == [_shopArray count]-1 && _orderBuyType == OrderType_Normal) {
//            sectionFooterView.frame = CGRectMake(0, 0, kApplicationWidth, 330+ZOOM6(20)-150);
            
            sectionFooterView.frame = CGRectMake(0, 0, kApplicationWidth, 70);
        }
    sectionFooterView.tag = section + 500;
    
    /**********  配送方式   ********/
    /*
     UILabel *mail = [[UILabel alloc]initWithFrame:CGRectMake(left, 10, kApplicationWidth/2, 30)];
     mail.text = @"配送方式";
     mail.textColor=kMainTitleColor;
     mail.textAlignment = NSTextAlignmentLeft;
     mail.font = [UIFont systemFontOfSize:ZOOM(48)];
     UILabel *way = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2, 10, kApplicationWidth/2-right, 30)];
     way.font = [UIFont systemFontOfSize:ZOOM(48)];
     way.text = @"快递包邮";
     way.textColor=kMainTitleColor;
     way.textAlignment = NSTextAlignmentRight;
     
     UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, way.frame.origin.y+way.frame.size.height+10, kApplicationWidth, 0.5)];
     line.backgroundColor = kTableLineColor;
     [sectionFooterView addSubview:line];
     
     **********  价格合计   ********
     UILabel *moneyTotal = [[UILabel alloc]initWithFrame:CGRectMake(left, line.frame.origin.y+line.frame.size.height+10, kApplicationWidth/2, 30)];
     moneyTotal.text = @"价格合计";
     moneyTotal.textColor=kMainTitleColor;
     moneyTotal.font=[UIFont systemFontOfSize:ZOOM(48)];
     moneyTotal.textAlignment = NSTextAlignmentLeft;
     UILabel *money = [[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/2, line.frame.origin.y+line.frame.size.height+10, kApplicationWidth/2-right, 30)];
     money.font = [UIFont systemFontOfSize:ZOOM(48)];
     money.text = @"¥";
     money.textColor=kMainTitleColor;
     money.tag = 100+section;
     money.textAlignment = NSTextAlignmentRight;
     CGFloat vouchersNum=0;
     if(_shopArray.count)
     {
     CGFloat totalprice=0;
     
     NSArray *array = _shopArray[section];
     for (int j=0; j<array.count; j++) {
     ShopDetailModel *shopmodel=array[j];
     
     NSString *price=[NSString stringWithFormat:@"%@",shopmodel.shop_se_price];
     NSString *number=[NSString stringWithFormat:@"%@",shopmodel.shop_num];
     
     CGFloat PRICE=[price floatValue]*[number integerValue]*memberPriceRate;
     totalprice +=PRICE;
     vouchersNum += shopmodel.voucher.floatValue;
     
     }
     money.text=[NSString stringWithFormat:@"¥%.1f",totalprice];
     }
     
     UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, moneyTotal.frame.origin.y+moneyTotal.frame.size.height+10, kApplicationWidth, 0.5)];
     line2.backgroundColor = kTableLineColor;
     [sectionFooterView addSubview:line2];
     
     UILabel *vouchers = [[UILabel alloc]initWithFrame:CGRectMake(left, line2.frame.origin.y+line2.frame.size.height+10, kApplicationWidth/2, 30)];
     vouchers.text = @"抵用券";
     vouchers.textColor=kMainTitleColor;
     vouchers.font=[UIFont systemFontOfSize:ZOOM(48)];
     vouchers.textAlignment = NSTextAlignmentLeft;
     UILabel *vouchersMoney=[[UILabel alloc]initWithFrame:CGRectMake(detailLabel_XPoint, vouchers.frame.origin.y, vouchers.frame.size.width, vouchers.frame.size.height)];
     vouchersMoney.text=[NSString stringWithFormat:@"抵用¥%.1f（每日登录获抵用券）",vouchersNum];
     vouchersMoney.font=[UIFont systemFontOfSize:ZOOM(37)];
     vouchersMoney.textColor=tarbarrossred;
     UISwitch *vouchersSwitch=[[UISwitch alloc]initWithFrame:CGRectMake(kApplicationWidth-50-right, line2.frame.origin.y+10, 30, 15)];
     [vouchersSwitch addTarget:self action:@selector(vouchersSwitchClick:) forControlEvents:UIControlEventValueChanged];
     [vouchersSwitch setOn:vouchersNum];
     vouchersSwitch.tag=900+section;
     [sectionFooterView addSubview:vouchersSwitch];
     
     UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, vouchers.frame.origin.y+vouchers.frame.size.height+10, kApplicationWidth, 0.5)];
     line1.backgroundColor = kTableLineColor;
     [sectionFooterView addSubview:line1];
     */
    
    /**********  给卖家留言   ********/
    UITextField *message = [[UITextField alloc]initWithFrame:CGRectMake(leftSpace, 10, kApplicationWidth-leftSpace-rightSpace, 60)];
    //    UITextField *message = [[UITextField alloc]initWithFrame:CGRectMake(left, line1.frame.origin.y+line1.frame.size.height+20, kApplicationWidth-left-right, 60)];
    message.borderStyle = UITextBorderStyleRoundedRect;
    message.layer.borderWidth = 0.5;
    message.layer.cornerRadius = 5;
    message.layer.borderColor = kTableLineColor.CGColor;
    message.font = fortySize;
    message.placeholder=@"给卖家留言...";
    ShopDetailModel *messageModel = _shopArray[section][0];
    if (messageModel.message!=nil&&messageModel.message.length!=0) {
        message.text=[NSString stringWithFormat:@"%@",messageModel.message];
    }
    message.delegate = self;
    message.tag=600+section;
    
    UIView *topline = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 0.5)];
    topline.backgroundColor = kTableLineColor;
    [sectionFooterView addSubview:topline];
    
    
//    if (_orderBuyType == OrderType_Normal) {
//        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(message.frame)+20, kApplicationWidth, ZOOM6(20))];
//        bottomView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
//        [sectionFooterView addSubview:bottomView];
//
//        if (section == [_shopArray count]-1) {
//            //**********  优惠劵   *******
//            UIView *discountView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(bottomView.frame), kApplicationWidth, 50)];
//
//            discount = [[UILabel alloc]initWithFrame:CGRectMake(leftSpace, 10, kApplicationWidth-30, 30)];
//            discount.text = GoldCouponString;
//            discount.textColor=kMainTitleColor;
//            discount.font=[UIFont systemFontOfSize:ZOOM(48)];
//            [discountView addSubview:discount];
//
//            discountLabel = [[UILabel alloc]initWithFrame:CGRectMake(detailLabel_XPoint, 10, kApplicationWidth-30, 30)];
//            discountLabel.textColor = tarbarrossred;
//            //        discountLabel.text = GoldCouponString;
//            discountLabel.font=[UIFont systemFontOfSize:ZOOM(37)];
//
//            discountMoney=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-120-rightSpace, discount.frame.origin.y, 100, 30)];
//            discountMoney.textAlignment=NSTextAlignmentRight;
//            discountMoney.textColor=tarbarrossred;
//            discountMoney.font=[UIFont systemFontOfSize:ZOOM(37)];
//
//            if (couponMoney != 0) {
//                [self changeDiscountLabel:[NSString stringWithFormat:@"可使用1张%@",GoldCouponString]];
//            }else{
//                [self changeDiscountLabel:@"无可用"];
//            }
//
//            discountLabel.tag = 300+section;
//            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(kApplicationWidth-10-rightSpace, 10, 10, 30)];
//            img.contentMode = UIViewContentModeScaleAspectFit;
//            img.image = [UIImage imageNamed:@"更多-副本-3"];
//            [discountView addSubview:discountLabel];
//            [discountView addSubview:discountMoney];
//            [discountView addSubview:img];
//            [sectionFooterView addSubview:discountView];
//
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//            btn.backgroundColor = [UIColor clearColor];
//            btn.frame = CGRectMake(0, discountView.frame.origin.y, kApplicationWidth, 50);
//            [btn addTarget: self action:@selector(discountBtn:) forControlEvents:UIControlEventTouchUpInside];
//            btn.tag = 200+section;
//            [sectionFooterView addSubview:btn];
//
//
//            UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, discountView.frame.origin.y+discountView.frame.size.height, kApplicationWidth, 0.5)];
//            line2.backgroundColor = kTableLineColor;
//            [sectionFooterView addSubview:line2];
//
//            //**********  使用积分   ********
//            UILabel *integral = [[UILabel alloc]initWithFrame:CGRectMake(leftSpace, line2.frame.origin.y+10, kApplicationWidth-30, 30)];
//            integral.text=GoldIntegralString;
//            integral.textColor=kMainTitleColor;
//            integral.font=[UIFont systemFontOfSize:ZOOM(48)];
//            [sectionFooterView addSubview:integral];
//
//            integralLabel = [[UILabel alloc]initWithFrame:CGRectMake(detailLabel_XPoint, integral.frame.origin.y, kApplicationWidth-30, 30)];
//
//            CGFloat integralPrice=0;
//            if(integralString.integerValue>=MIN_IntegralNeed||[GoldCouponsManager goldcpManager].gold_is_open) {
//                integralPrice=[integralString floatValue]/integralRate*0.1;
//            }
//            integralLabel.font = [UIFont systemFontOfSize:ZOOM(37)];
//            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"可用%@:%@  可抵用¥%.2f",GoldIntegralString,(integralString.integerValue>=MIN_IntegralNeed||[GoldCouponsManager goldcpManager].gold_is_open)?integralString:@"0",integralPrice]];
//            integralLabel.textColor = tarbarrossred;
//            //        NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@"¥"].location);
//            //        [noteStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(48)]} range:redRange];
//            [integralLabel setAttributedText:noteStr] ;
//            [sectionFooterView addSubview:integralLabel];
//
//            integralSwitch=[[UISwitch alloc]initWithFrame:CGRectMake(kApplicationWidth-50-rightSpace, integralLabel.frame.origin.y, 30, 15)];
//            [integralSwitch addTarget:self action:@selector(integralSwitchClick:) forControlEvents:UIControlEventValueChanged];
//            [integralSwitch setOn:SwitchSelected];
//            [sectionFooterView addSubview:integralSwitch];
//
//            //        if ([DataManager sharedManager].isOpen) {
//            /*
//             UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, integralLabel.frame.origin.y+integralLabel.frame.size.height+10, kApplicationWidth, 0.5)];
//             line3.backgroundColor = kTableLineColor;
//             [sectionFooterView addSubview:line3];
//
//             UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(left, line3.frame.origin.y+10, kApplicationWidth-30, 30)];
//             moneyLabel.text=@"余额抵扣";
//             moneyLabel.textColor=kMainTitleColor;
//             moneyLabel.font=[UIFont systemFontOfSize:ZOOM(48)];
//             [sectionFooterView addSubview:moneyLabel];
//
//             remainMoney = [[UILabel alloc]initWithFrame:CGRectMake(detailLabel_XPoint, moneyLabel.frame.origin.y, kApplicationWidth-30, 30)];
//             remainMoney.textColor = tarbarrossred;
//             remainMoney.font = [UIFont systemFontOfSize:ZOOM(37)];
//             //            remainMoney.text=[NSString stringWithFormat:@"可用余额¥%.2f  可抵用¥%.1f",self.totalMoney,self.usableMoney];
//             remainMoney.text=[NSString stringWithFormat:@"可抵¥%.2f（最高可抵%d%%）",myMaxUsedMoney,(int)([maxRate doubleValue]*100)];
//
//             [sectionFooterView addSubview:remainMoney];
//
//             myMoneySwitch=[[UISwitch alloc]initWithFrame:CGRectMake(kApplicationWidth-50-right, moneyLabel.frame.origin.y, 30, 15)];
//             [myMoneySwitch addTarget:self action:@selector(myMoneySwitchClick:) forControlEvents:UIControlEventValueChanged];
//             [myMoneySwitch setOn:myMoneySwitchSelected];
//             */
//            [sectionFooterView addSubview:myMoneySwitch];
//            //        }
//        }
//    }
    
    
    
    //    [sectionFooterView addSubview:mail];
    //    [sectionFooterView addSubview:way];
    //    [sectionFooterView addSubview:moneyTotal];
    //    [sectionFooterView addSubview:money];
    //    [sectionFooterView addSubview:vouchers];
    //    [sectionFooterView addSubview:vouchersMoney];
    [sectionFooterView addSubview:message];
    
    return sectionFooterView;
}
-(NSMutableArray *)voucherArr
{
    
    if (_voucherArr==nil) {
        _voucherArr = [NSMutableArray array];
        //        VoucherModel *ha1=[[VoucherModel alloc]init];
        //        ha1.snum=1;ha1.price=1;
        //        [_voucherArr addObject:ha1];
        //
        //        VoucherModel *ha=[[VoucherModel alloc]init];
        //        ha.snum=1;ha.price=2;
        //        [_voucherArr addObject:ha];
        //
        //        VoucherModel *ha2=[[VoucherModel alloc]init];
        //        ha2.snum=1;ha2.price=6;
        //        [_voucherArr addObject:ha2];
    }
    return _voucherArr;
}

-(int)vouchersMatch:(ShopDetailModel *)shopModel
{
    [shopModel.priceArray removeAllObjects];
    [shopModel.usedNunArray removeAllObjects];
    int Sum=0;
    for (VoucherModel *model in self.voucherArr) {
        if (model.price<=shopModel.kickback.integerValue*shopModel.shop_num.integerValue&&model.snum>model.usedNum) {
            int usedNum=0;
            int unUsedNum=model.snum-model.usedNum;
            for (int i=0; i<unUsedNum; i++) {
                if (Sum+model.price<=shopModel.kickback.integerValue*shopModel.shop_num.integerValue) {
                    Sum += model.price;
                    model.usedNum+=1;
                    usedNum+=1;
                    
                }
            }
            if (usedNum) {
                [shopModel.priceArray addObject:[NSString stringWithFormat:@"%f",model.price]];
                [shopModel.usedNunArray addObject:[NSString stringWithFormat:@"%d",usedNum]];
            }
        }
    }
    
    
    NSMutableString *vouchers=[NSMutableString string];
    for (int i=0; i<shopModel.priceArray.count; i++) {
        [vouchers appendString:[NSString stringWithFormat:@"%d:%@-",[shopModel.priceArray[i]intValue],shopModel.usedNunArray[i]]];
    }
    MyLog(@"vouchers:  %@",vouchers);
    
    return Sum;
    
}
-(int )allCore
{
    int totalCore=0;
    for(int i=0;i<self.sortArray.count;i++){
        ShopDetailModel *shopmodel=self.sortArray[i];
        totalCore +=[shopmodel.core intValue]*[shopmodel.shop_num intValue];
    }
    return totalCore;
}

-(CGFloat )allPrice
{
    CGFloat totalprice=0;
    CGFloat totalnumber=0;
    for(int i=0;i<self.sortArray.count;i++)
    {
        ShopDetailModel *shopmodel=self.sortArray[i];
        NSString *price=[NSString stringWithFormat:@"%@",shopmodel.shop_se_price];
        NSString *number=[NSString stringWithFormat:@"%@",shopmodel.shop_num];
        CGFloat PRICE=[price floatValue]*[number integerValue];
        totalprice +=PRICE;
        totalnumber +=number.floatValue;
    }
    return totalprice*memberPriceRate;
}

-(void)vouchersSwitchClick:(UISwitch*)sch
{
    
    if (sch.on) {
        for (ShopDetailModel *model1 in _shopArray[sch.tag%900]) {
            model1.voucher=[NSString stringWithFormat:@"%d",[self vouchersMatch:model1]];
        }
    }else{
        for (ShopDetailModel *model1 in _shopArray[sch.tag%900]) {
            for (int i=0; i<model1.usedNunArray.count; i++) {
                for (VoucherModel *model2 in self.voucherArr) {
                    if ([model1.priceArray[i]integerValue]==model2.price) {
                        model2.usedNum -= [model1.usedNunArray[i]intValue];
                        model1.voucher=@"0";
                    }
                }
            }
            [model1.usedNunArray removeAllObjects];
            [model1.priceArray removeAllObjects];
        }
        
    }
    
    [self changeTotalPrice];
    [_myTableView reloadData];
    
    int index = (int)sch.tag%900;
    
    if(sch.on == NO) {
        for (int j=0; j<[_shopArray[index]count]; j++) {
            ShopDetailModel *shopmodel=_shopArray[index][j];
            if (![_selectSwithcArray containsObject:[NSString stringWithFormat:@"%@",shopmodel.ID]]) {
                [_selectSwithcArray addObject:[NSString stringWithFormat:@"%@",shopmodel.ID]];
            }
        }
        
    }else{
        for (int j=0; j<[_shopArray[index]count]; j++) {
            ShopDetailModel *shopmodel=_shopArray[index][j];
            if ([_selectSwithcArray containsObject:[NSString stringWithFormat:@"%@",shopmodel.ID]]&&shopmodel.usedNunArray.count) {
                [_selectSwithcArray removeObject:[NSString stringWithFormat:@"%@",shopmodel.ID]];
            }
        }
    }
    
    MyLog(@"_selectSwithcArray = %@",_selectSwithcArray);
}
-(void)myMoneySwitchClick:(UISwitch *)sender {
    myMoneySwitchSelected=!myMoneySwitchSelected;
    sender.selected=myMoneySwitchSelected;
    
    [self changeTotalPrice];
    
}
-(void)integralSwitchClick:(UISwitch *)sender
{
    NSInteger priceIntegral = _haveType ?  ([self allPrice]-_allResavePrice-couponMoney)/2 *integralRate*10 : ([self allPrice]-couponMoney)/2 *integralRate*10;
    integralString = priceIntegral < [integralString floatValue] ? [NSString stringWithFormat:@"%zd",priceIntegral]:[NSString stringWithFormat:@"%@",integralString];//积分总额
    if ([GoldCouponsManager goldcpManager].gold_is_open) {
        if (sender) {
            SwitchSelected=integralSwitch.on;
        }else{
            [integralSwitch setOn:integralString.integerValue?YES:NO];
            SwitchSelected=integralString.integerValue?YES:NO;
        }
        integral_num = SwitchSelected ? integralString :@"0";
        [self changeTotalPrice];
    }else{
        if (integralString.integerValue<MIN_IntegralNeed) {
            if (sender) {
                [MBProgressHUD showError:[NSString stringWithFormat:@"至少使用%d积分",MIN_IntegralNeed]];
            }
            [integralSwitch setOn:NO];SwitchSelected=NO;
        }else{
            if (sender) {
                SwitchSelected=integralSwitch.on;
            }else{
                [integralSwitch setOn:YES];SwitchSelected=YES;
            }
            integral_num = SwitchSelected ? integralString :@"0";
        }
        [self changeTotalPrice];
    }
}
//-(void)integralSwitchClick
//{
//    if (integralString.integerValue<500) {
//      //  [MBProgressHUD showError:@"至少使用500积分"];
//        [integralSwitch setOn:NO];SwitchSelected=NO;
//    }else{
//        [integralSwitch setOn:YES];SwitchSelected=YES;
//        integral_num = SwitchSelected ? integralString :@"0";
//        [self changeTotalPrice];
//    }
//}
-(void)changeDiscountLabel:(NSString *)string
{
    //    discountLabel.font = [UIFont systemFontOfSize:ZOOM(37)];
    //    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:string];
    //    discountLabel.textColor = tarbarrossred;
    //    [discountLabel setAttributedText:noteStr];
    discountLabel.text=string;
    if(couponMoney>0)
        discountMoney.text=[NSString stringWithFormat:@"-¥%.2f",couponMoney];
    else
        discountMoney.text=@"";
}
-(void)discountBtn:(UIButton *)sender
{
    TFUserCardViewController *card=[[TFUserCardViewController alloc]init];
    card.c_cond=[self allPrice]-_allResavePrice;
    NSString *price=[self.totalprice.text substringFromIndex:7];
    card.totalPrice=price.floatValue+couponMoney;
    kSelfWeak;
    [card returnSuccessBlock:^(MyCardModel *model) {
        kSelfStrong;
        weakSelf.cardModel = model;
        couponMoney=model.c_price.floatValue;
        [weakSelf changeDiscountLabel:
         [model.ID integerValue]==[GoldCouponsManager goldcpManager].c_id&&[GoldCouponsManager goldcpManager].is_open?@"可使用1张金券":@"可使用1张优惠券"];
        strongSelf -> discount.text=[model.ID integerValue]==[GoldCouponsManager goldcpManager].c_id&&[GoldCouponsManager goldcpManager].is_open?@"金券":@"优惠券";
        strongSelf -> OrderFooterView.bottomLabel6.text = [model.ID integerValue]==[GoldCouponsManager goldcpManager].c_id&&[GoldCouponsManager goldcpManager].is_open?@"金券":@"优惠券";
        
        [weakSelf changeTotalPrice];
        
    }];
    
    [self.navigationController pushViewController:card animated:YES];
}


/**************  段价格合计  ************/
-(CGFloat)changeMoney:(NSInteger)section
{
    CGFloat totalprice=0;
    NSArray *array = _shopArray[section];
    for (int j=0; j<array.count; j++) {
        ShopDetailModel *shopmodel=array[j];
        NSString *price=[NSString stringWithFormat:@"%@",shopmodel.shop_se_price];
        NSString *number=[NSString stringWithFormat:@"%@",shopmodel.shop_num];
        CGFloat PRICE=[price floatValue]*[number integerValue];
        totalprice +=PRICE;
    }
    totalprice *=memberPriceRate;
    if (_couponArray.count!=0 && _couponArray.count>section) {
        MyCardModel *model = _couponArray[section];
        totalprice -= model.c_price.floatValue;
    }
    
    return totalprice;
}


-(void)changeIntegralString
{
    CGFloat integralPrice=0;
    if(integralString.integerValue>=MIN_IntegralNeed||[GoldCouponsManager goldcpManager].gold_is_open) {
        integralPrice=[integralString floatValue]/integralRate*0.1;
    }
    integralLabel.font = [UIFont systemFontOfSize:ZOOM(37)];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"可用%@:%@  可抵用¥%.2f",GoldIntegralString,(integralString.integerValue>=MIN_IntegralNeed||[GoldCouponsManager goldcpManager].gold_is_open)?integralString:@"0",integralPrice]];
    integralLabel.textColor = tarbarrossred;
    [integralLabel setAttributedText:noteStr];
    OrderFooterView.bottomMoneyLabel7.text=[NSString stringWithFormat:@"-¥%.2f",SwitchSelected ?integralPrice:0];
}


/******************  加减后合计价格   ***************/
-(void)changeTotalPrice
{
   
    kWeakSelf(self);
    [OneYuanModel GetOneYuanCountSuccess:^(id data) {
        OneYuanModel *oneModel = data;
        if(oneModel.status == 1)
        {
            [DataManager sharedManager].OneYuan_count = oneModel.order_price;
            [DataManager sharedManager].one_not_use_price = oneModel.one_not_use_price;
            weakself.shop_deduction = [oneModel.shop_deduction floatValue];
            
            
            [ShopDetailViewModel addUserVipOrderSuccess:^(id data) {
                ShopDetailViewModel *viewmodel = data;
                
                if(viewmodel.status == 1)
                {
                    weakself.maxType = viewmodel.maxType;
                }
                
            }];
        }
        
        [weakself handelPrice];
    }];
}

- (void)handelPrice
{
    OrderFooterView.bottomMoneyLabel6.text=[NSString stringWithFormat:@"-¥%.2f",couponMoney];
    [self changeIntegralString];
    //memberPriceRate  %f",memberPriceRate);
    CGFloat totalprice=0;
    CGFloat totalnumber=0;
    CGFloat totalOldprice=0;
    CGFloat totalIntegral=0;CGFloat totalVoucher=0;
    for(int i=0;i<self.sortArray.count;i++){
        ShopDetailModel *shopmodel=self.sortArray[i];
        NSString *price=[NSString stringWithFormat:@"%@",shopmodel.shop_se_price];
        if (_orderBuyType == OrderType_GroupBuy)
        {
            price=[NSString stringWithFormat:@"%@",shopmodel.shop_price];
        }else if (_orderBuyType == OrderType_FightBuy){
            price=[NSString stringWithFormat:@"%@",shopmodel.assmble_price];
        }
        NSString *number=[NSString stringWithFormat:@"%@",shopmodel.shop_num];
        CGFloat PRICE=[price floatValue]*[number floatValue];
        totalprice +=PRICE;
        totalOldprice +=PRICE;
        totalnumber +=number.floatValue;
        totalVoucher += shopmodel.voucher.integerValue;
    }
    
    
    OrderFooterView.bottomMoneyLabel4.text=[NSString stringWithFormat:@"-¥%.2f",totalVoucher];
    
    totalprice = totalprice*memberPriceRate-totalVoucher-self.usableMoney-_allResavePrice;
    if (totalIntegral !=0 || integral_num.integerValue!=0) {
        CGFloat integralPrice=integral_num.floatValue/integralRate*0.1;
        totalprice -=integralPrice;
    }
    
    //金券能否使用
//    if(FinishGetCoupon){
//        if (nil == self.cardModel.c_price && [GoldCouponsManager goldcpManager].c_price<totalprice &&![GoldCouponsManager goldcpManager].is_use&&[GoldCouponsManager goldcpManager].is_open &&[GoldCouponsManager goldcpManager].c_price) {
//            self.cardModel.c_price = [NSNumber numberWithFloat:[GoldCouponsManager goldcpManager].c_price];
//            self.cardModel.ID = [NSNumber numberWithInteger:[GoldCouponsManager goldcpManager].c_id];
//            GoldCouponString=@"金券";
//            couponMoney=self.cardModel.c_price.floatValue;
//            NSString *price=[self.totalprice.text substringFromIndex:7];
//            self.totalprice.text = [NSString stringWithFormat:@"实付款: ¥%.2f",price.floatValue-couponMoney];
//            [self changeDiscountLabel:[NSString stringWithFormat:@"可使用1张%@",GoldCouponString]];
//            [self changeTableFooterViewFrame];
//        }else if([GoldCouponsManager goldcpManager].c_price>=totalprice){
//            self.cardModel.ID=0;
//            self.cardModel.c_price=nil;
//            couponMoney=0;
//            GoldCouponString=@"优惠券";
//            [self changeDiscountLabel:@"无可用"];
//        }
//        discount.text=GoldCouponString;
//        OrderFooterView.bottomMoneyLabel6.text=[NSString stringWithFormat:@"-¥%.2f",couponMoney];
//
//    }
    if ((myMaxUsedMoney||myWalletMoney||[DataManager sharedManager].one_not_use_price)) {//改变最高可抵多少
        float tempMoney=totalprice-couponMoney;
        //        myMaxUsedMoney=MIN(tempMoney*maxRate.floatValue, [maxMoney floatValue]);
        myMaxUsedMoney=min(myWalletMoney.floatValue,tempMoney*maxRate.floatValue, [maxMoney floatValue]);
        // 1元购更改需求  余额抵扣的钱是1元购抽奖的钱  不是钱包余额
        myMaxUsedMoney=MIN(tempMoney, [DataManager sharedManager].one_not_use_price);
        
        ShopDetailViewModel *viewmodel = [ShopDetailViewModel alloc];
        CGFloat hadelprice = [viewmodel get_discount_price:tempMoney DiscountMoney:[DataManager sharedManager].one_not_use_price MaxViptype:self.maxType Shop_deduction:self.shop_deduction];
        myMaxUsedMoney = tempMoney - hadelprice;
        
        if (myMaxUsedMoney<=0) {
            myMaxUsedMoney=0;
        }
        tempUsedMoney=myMaxUsedMoney;
        remainMoney.text=[NSString stringWithFormat:@"可抵¥%.2f（最高可抵%d%%）",myMaxUsedMoney,(int)([maxRate doubleValue]*100)];
        
        OrderFooterView.bottomMoneyLabel5.text=[NSString stringWithFormat:@"-¥%.2f",myMoneySwitchSelected? myMaxUsedMoney:0.];
        _myTableView.tableFooterView=OrderFooterView;
        
    }
    
    NSString *str = [NSString stringWithFormat:@"实付款: ¥%.2f",myMoneySwitchSelected?totalprice-couponMoney-myMaxUsedMoney:totalprice-couponMoney];
    
    self.totalprice.text = str;
    
    //    if (_orderBuyType == OrderType_GroupBuy) {
    //
    //        ShopDetailModel *shopmodel=self.sortArray[0];
    //        OrderFooterView.bottomLabel1.text = @"商品原价";
    //        OrderFooterView.bottomMoneyLabel4.text = [NSString stringWithFormat:@"¥%.2f",totalprice-couponMoney];
    //        self.totalprice.text = [NSString stringWithFormat:@"实付款：%.1f元",shopmodel.app_shop_group_price.floatValue];
    //    }else{
    //        OrderFooterView.bottomLabel1.text = @"商品价格";
    //    }
    
    
    if(_orderBuyType == OrderType_Normal)
    {
        OrderFooterView.bottomLabel1.text = @"商品价格";
        OrderFooterView.bottomLabel2.text = @"预存抵扣";
        OrderFooterView.bottomLabel2.hidden = NO;
        
    }else if (_orderBuyType == OrderType_FightBuy)
    {
        OrderFooterView.bottomLabel1.text = @"拼团价格";
        OrderFooterView.bottomLabel2.text = @"开团免费";
        OrderFooterView.bottomLabel2.hidden = NO;
        
        OrderFooterView.bottomMoneyLabel1.text = [NSString stringWithFormat:@"￥%.2f",totalOldprice*totalnumber];
        OrderFooterView.bottomMoneyLabel2.text = [NSString stringWithFormat:@"-￥%.2f",totalOldprice*totalnumber];
        OrderFooterView.bottomMoneyLabel2.hidden = NO;
        
        self.totalprice.text = [NSString stringWithFormat:@"实付款：￥%.2f元",0.0];
    }else if (_orderBuyType == OrderType_GroupBuy)
    {
        if (self.firstGroup == 1 && self.isTM == 0)
        {
            OrderFooterView.bottomLabel1.text = @"商品原价";
            OrderFooterView.bottomLabel2.text = @"会员购物券";
            OrderFooterView.bottomLabel2.hidden = NO;
            
            OrderFooterView.bottomMoneyLabel1.text = [NSString stringWithFormat:@"￥%.2f",totalOldprice*totalnumber];
            OrderFooterView.bottomMoneyLabel2.text = [NSString stringWithFormat:@"-￥%.2f",totalOldprice*totalnumber];
            OrderFooterView.bottomMoneyLabel2.hidden = NO;
            
            self.totalprice.text = [NSString stringWithFormat:@"实付款：￥%.2f元",0.0];
        }else
        {
            OrderFooterView.bottomLabel1.text = @"商品原价";
            OrderFooterView.bottomLabel2.text = @"会员优惠";
            OrderFooterView.bottomLabel2.hidden = NO;
            
            OrderFooterView.bottomMoneyLabel1.text = [NSString stringWithFormat:@"￥%.2f",totalOldprice*totalnumber];
            OrderFooterView.bottomMoneyLabel2.text = [NSString stringWithFormat:@"-￥%.2f",totalOldprice*totalnumber];
            OrderFooterView.bottomMoneyLabel2.hidden = NO;
            
            self.totalprice.text = [NSString stringWithFormat:@"实付款：￥%.2f元",0.0];
        }
    }
    
    
    
}
- (void)func:(BOOL)bl with:(NSIndexPath*)index
{
    if (bl) {
        AffirmOrderCell * cell = (AffirmOrderCell *)[_myTableView cellForRowAtIndexPath:index];
        ShopDetailModel *model=_shopArray[index.section][index.row];
        model.shop_num =[NSString stringWithFormat:@"%@",tempShop_num];
        cell.changeNum.text=[NSString stringWithFormat:@"%@",tempShop_num];
        cell.number.text=[NSString stringWithFormat:@"x%d",cell.changeNum.text.intValue ];
        UIView *view = [_myTableView viewWithTag:index.section+500];
        UILabel *money = (UILabel *)[view viewWithTag:index.section+100];
        money.text=[NSString stringWithFormat:@"¥%.2f",tempTotalprice+[model.shop_se_price floatValue]*cell.changeNum.text.intValue];
        
        [self changeTotalPrice];
    }
}

#pragma mark 确认订单到支付界面
-(void)affirmorder:(UIButton*)sender
{
    if(_DeliverArray.count>0|| (_addressView.nameLabel.text.length!=0 && _addressView.addressLabel.text.length !=0 && ![_addressView.addressLabel.text isEqualToString:@"收货地址:null"]) ){
        confirmButton.userInteractionEnabled=NO;
        MyLog(@"%@",_selectSwithcArray);

        [self httpAddOrder];

    }else{

        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"你还没有设置收货地址,请设置" Controller:self];
    }
}


/**
 跳转  拼团详情页
 */
- (void)toGroupBuyDetail:(NSString*)roll_code {
    
    if([DataManager sharedManager].opengroup == 1)//开团
    {
        [DataManager sharedManager].opengroutSuccess = 1;//开团成功
    }else if ([DataManager sharedManager].opengroup == 2)//参团
    {
        [DataManager sharedManager].opengroutSuccess = 4;//参团成功
    }
    
    GroupBuyDetailVC *fightvc = [[GroupBuyDetailVC alloc] init];
    fightvc.roll_code = roll_code;
    fightvc.hidesBottomBarWhenPushed=YES;

    Mtarbar.selectedIndex=0;
    UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[0];
    nv.navigationBarHidden = YES;
    [nv pushViewController:fightvc animated:YES];
    
}

#pragma  mark - 确认下单 请求数据
-(void)httpAddOrder
{
    //测试用
//    MyOrderViewController *myorder = [[MyOrderViewController alloc]init];
//    myorder.hidesBottomBarWhenPushed = YES;
//    myorder.tag=999;
//    myorder.status1=@"0";
//    myorder.isfirst_freeling = YES;
//    [self.navigationController pushViewController:myorder animated:YES];
//    return ;
    
    [TFStatisticsClickVM handleDataWithPageType:nil withClickType:@"确认订单页面”确认下单“" success:^(id data, Response *response) {
    } failure:^(NSError *error) {
    }];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSString *url;
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSMutableString *message=[NSMutableString string];
    NSMutableString *result=[NSMutableString string];
    
    
    for (int i=0; i<_shopArray.count; i++) {
        for (int j=0; j<[_shopArray[i]count]; j++) {
            ShopDetailModel *model = _shopArray[i][j];
            NSMutableString *vouchers=[NSMutableString string];
            for (int i=0; i<model.priceArray.count; i++) {
                [vouchers appendString:[NSString stringWithFormat:@"%d:%@-",[model.priceArray[i]intValue],model.usedNunArray[i]]];
            }
            if (vouchers.length==0) {
                [result appendString:[NSString stringWithFormat:@"%@^%@^%@^0,",model.shop_num,model.shop_code,model.stock_type_id]];
            }else{
                [result appendString:[NSString stringWithFormat:@"%@^%@^%@^%@,",model.shop_num,model.shop_code,model.stock_type_id,[vouchers substringToIndex:[vouchers length]-1]]];
            }
        }
        ShopDetailModel *messageModel = _shopArray[i][0];
        if (messageModel.message!=nil) {
            [message appendString:[NSString stringWithFormat:@"%@^%@,",messageModel.ID,messageModel.message]];
        }
        
    }
    
    MyLog(@"%@",result);
    //********************     cartIds
    NSMutableString *IDstrings=[NSMutableString string];
    for(int i=0;i<self.sortArray.count;i++){
        ShopDetailModel *model=self.sortArray[i];
        if(model.ID){
            [IDstrings appendString:[NSString stringWithFormat:@"%@",model.ID]];
            [IDstrings appendString:@","];
        }
    }
    NSString *ccc=IDstrings.length!=0?[IDstrings substringToIndex:[IDstrings length]-1]:@"";
    
    NSString *messageStr=[NSString string];
    if (message.length!=0) {
        messageStr = [message substringToIndex:[message length]-1];
    }
    
    if (integral_num==nil) {
        integral_num=@"";
    }
    NSString *couponid;
    if ([self.cardModel.ID isEqual:[NSNull null]]||self.cardModel.ID==nil) {
        self.cardModel.ID=0;
        couponid=@"";
    }else
        couponid=[NSString stringWithFormat:@"%@",self.cardModel.ID];
    
    
    if (_orderBuyType == OrderType_GroupBuy)//免费领
    {
        
        if(self.vip_free == 1)//会员免费领下单
        {
            if(self.is_vip >0 && self.is_vip !=3)//是会员
            {
                //好友分享下单
                url=[NSString stringWithFormat:@"%@order/addOrderFriendsShare?version=%@&token=%@&message=%@&result=%@&address_id=%@&t=1&vip_type=%zd&shop_code=%@&couponid=%@",[NSObject baseURLStr],VERSION,token,messageStr,[result substringToIndex:[result length]-1],_addressid,self.vipType,self.shop_code,couponid];
                share_freeLing = YES;
            }else{
                //免费领下单
                url=[NSString stringWithFormat:@"%@order/addOrderVipFreeBuy?version=%@&token=%@&message=%@&result=%@&address_id=%@&t=1&vip_type=%zd&page3=1&shop_code=%@",[NSObject baseURLStr],VERSION,token,messageStr,[result substringToIndex:[result length]-1],_addressid,self.vipType,self.shop_code];
            }
            
        }else{
            //好友分享下单
            url=[NSString stringWithFormat:@"%@order/addOrderFriendsShare?version=%@&token=%@&message=%@&result=%@&address_id=%@&t=1&vip_type=%zd&shop_code=%@&couponid=%@",[NSObject baseURLStr],VERSION,token,messageStr,[result substringToIndex:[result length]-1],_addressid,self.vipType,self.shop_code,couponid];
            share_freeLing = YES;
        }
        
    }else if (_orderBuyType == OrderType_FightBuy){//开团
        url=[NSString stringWithFormat:@"%@order/addOrderListPT?version=%@&token=%@&message=%@&result=%@&address_id=%@&t=1",[NSObject baseURLStr],VERSION,token,messageStr,[result substringToIndex:[result length]-1],_addressid];
    }
    else
        if (_haveType) {
            url=[NSString stringWithFormat:@"%@order/addOrderListDpV160806?version=%@&token=%@&message=%@&integral_num=%@&result=%@&address_id=%@&couponid=%@&is_be=%d",[NSObject baseURLStr],VERSION,token,messageStr,integral_num,[result substringToIndex:[result length]-1],_addressid,couponid,myMoneySwitchSelected];
        }else
            url=[NSString stringWithFormat:@"%@order/addOrderListV160302?version=%@&token=%@&message=%@&cartIds=%@&integral_num=%@&result=%@&address_id=%@&couponid=%@&is_be=%d",[NSObject baseURLStr],VERSION,token,messageStr,ccc,integral_num,[result substringToIndex:[result length]-1],_addressid,couponid,myMoneySwitchSelected];
    
    
    NSString *URL=[MyMD5 authkey:url];
    MyLog(@"%@",URL);
    
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        //responseObject = [NSDictionary changeType:responseObject];
        confirmButton.userInteractionEnabled=YES;
        if(responseObject[@"orderToken"]!=nil)
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"orderToken"] forKey:ORDER_TOKEN];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                
                CGFloat price = [[NSString stringWithFormat:@"%@",responseObject[@"price"]] floatValue];
                NSString *roll_code = [NSString stringWithFormat:@"%@",responseObject[@"roll_code"]];
                NSString *isNew = [NSString stringWithFormat:@"%@",responseObject[@"isNew"]];
                NSString *isFirst = [NSString stringWithFormat:@"%@",responseObject[@"isFirst"]];
                NSString *order_code = [NSString stringWithFormat:@"%@",responseObject[@"order_code"]];
                
                if (self.affirmOrder) {
                    self.affirmOrder();
                }
                self.order_code=nil;
                self.order_code =responseObject[@"order_code"];
                [userdefaul setObject:self.order_code forKey:ORDER_CODE];
                
                [TFStatisticsClickVM StatisticshandleDataWithClickType:@"跳出订单确认" success:nil failure:nil];
            
                
                
                if(_orderBuyType == OrderType_GroupBuy)//拼团购买
                {
                    //如果是分享免费领去分享
                    if(share_freeLing == YES){
                        ShopDetailModel *orderShopmodel=_shopArray[0][0];
                        orderShopmodel.isTM = self.isSpecialOrder ==1?@"1":@"0";
                        ShareFreeLingViewController *freeling=[[ShareFreeLingViewController alloc]init];
                        freeling.comefrome = @"分享免费领";
                        freeling.order_code = self.order_code;
                        freeling.Ordermodel=orderShopmodel;
                        [self.navigationController pushViewController:freeling animated:YES];
                        return ;
                    }
                    //新用户首单免费领直接跳订单列表
                    if(self.firstGroup && self.firstGroup== 1 && self.vip_free==1)
                    {
                        MyOrderViewController *myorder = [[MyOrderViewController alloc]init];
                        myorder.hidesBottomBarWhenPushed = YES;
                        myorder.tag=999;
                        myorder.status1=@"0";
                        myorder.isfirst_freeling = YES;
                        [self.navigationController pushViewController:myorder animated:YES];
                        
                        return ;
                    }
                    
                    if(self.vip_free == 1)//免费领
                    {
                        if(self.free_page == 1)//跳转订单详情
                        {
                            [self httpGetOrderDetailData:responseObject Pay:NO];
                            return;
                        }else{//跳转抽奖界面
                            OneLuckdrawViewController *oneLuck = [OneLuckdrawViewController new];
                            oneLuck.comefrom = @"paysuccess";
                            oneLuck.order_code = self.order_code;
                            [self.navigationController pushViewController:oneLuck animated:YES];
                            return;
                        }
                    }
                }
                
                if (self.isFight) {
                    [DataManager sharedManager].fightStatus = [NSString stringWithFormat:@"%@",responseObject[@"roll_code"]];//开团团号
                    [Signmanager SignManarer].rnum = @"2";//2人成团
                    [DataManager sharedManager].opengroup = 1;//开团
                    
                    if([DataManager sharedManager].opengroup == 1)//开团
                    {
                        [DataManager sharedManager].opengroutSuccess = 1;//开团成功
                    }else if ([DataManager sharedManager].opengroup == 2)//参团
                    {
                        [DataManager sharedManager].opengroutSuccess = 4;//参团成功
                    }
                    
//                    [self goPaystyleVC:responseObject];
                    
                    [self toGroupBuyDetail:[DataManager sharedManager].fightStatus];
                }else {
                    
                    [self httpGetOrderDetailData:responseObject Pay:YES];
                    
//                    [self goPaystyleVC:responseObject];
                }
            }else{
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        confirmButton.userInteractionEnabled=YES;
        
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    
}

- (void)goPaystyleVC:(id)responseObject{
    
    TFPayStyleViewController *paystyle=[[TFPayStyleViewController alloc]init];
    paystyle.urlcount=responseObject[@"url"];
    paystyle.price=[responseObject[@"price"]doubleValue];
    paystyle.shop_from=self.isFight?@"10":@"6";
    paystyle.order_code=_order_code;
    paystyle.sortArray=self.sortArray;
    paystyle.isTM = self.isTM;
    [self.navigationController pushViewController:paystyle animated:YES];
}

-(void)shareToWeiXin
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]])//是否安装微信
    {
        IntelligenceViewController *intell=[[IntelligenceViewController alloc]init];
        kSelfWeak;
        intell.BackBlock=^{
            [weakSelf httpAddOrder];
        };
        
        NSMutableArray *shareArray = [NSMutableArray array];
        for(int k =0;k<_shopArray.count;k++){
            [shareArray addObject:_shopArray[k]];
        }
        for(int i =0; i<shareArray.count;i++){
            ShopDetailModel *sortmoel = shareArray[i][0];
            for(int j = 0 ;j<_selectSwithcArray.count;j++){
                NSString *ID = _selectSwithcArray[j];
                if(sortmoel.ID.intValue == ID.intValue){
                    [shareArray removeObjectAtIndex:i];
                }
            }
        }
        MyLog(@"self.shopArray = %@",shareArray);
        
        int index = arc4random() % shareArray.count;
        
        ShopDetailModel *model=shareArray[index][0];
        _selectMoel = model;
        intell.shopPrice=[NSString stringWithFormat:@"%@",model.shop_se_price];
        intell.isshare = @"yes";
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",model.shop_code] forKey:SHOP_CODE];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",model.def_pic] forKey:SHOP_PIC];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",[model.kickback intValue]] forKey:KICKBACK];
        
        [self.navigationController pushViewController:intell animated:YES];
    }else{
        confirmButton.userInteractionEnabled=YES;
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"亲,使用抵用劵购买需要分享,请先安装微信再来哦~" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alter show];
    }
}

#pragma mark 智能分享成功下单
- (void)sharesuccess:(NSNotification*)note
{
    [self httpAddOrder];
}
#pragma mark 智能分享失败
- (void)sharefail:(NSNotification*)note
{
    [self httpAddOrder];
}


- (void)sharetishi
{
    //配置分享平台信息
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app shardk];
    
    [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:nil WithShareType:@"index"];
}

#pragma mark UIGestureRecognizerDelegate methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:_myTableView]) {
        
        // Don't let selections of auto-complete entries fire the
        // gesture recognizer
        return NO;
    }
    
    return YES;
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.message = textField;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    for (int i=0; i<_shopArray.count; i++) {
        UIView *view = [_myTableView viewWithTag:i+500];
        UITextField *message = (UITextField *)[view viewWithTag:600+i];
        if (textField == message) {
            ShopDetailModel *model = _shopArray[i][0];
            model.message=textField.text;
        }
    }
    /*
     for (int i=0; i<_shopArray.count; i++) {
     UIView *view = [_myTableView viewWithTag:i+500];
     UITextField *integralTextField =(UITextField *)[view viewWithTag:i+10];
     UITextField *message = (UITextField *)[view viewWithTag:600+i];
     
     
     if (textField == message) {
     ShopDetailModel *model = _shopArray[i][0];
     model.message=textField.text;
     }
     NSString *totalPrice = [NSString stringWithFormat:@"%@",_subIntegArray[i]];
     CGFloat totalInput = 0;
     for (int j=0; j<_integralArray.count; j++) {
     if (i!=j && ![_integralArray[j]isEqualToString:@"0"]) {
     totalInput += [_integralArray[j] floatValue];
     }
     }
     totalInput = integralString.intValue-totalInput;
     if (textField == integralTextField) {
     if ([textField.text isEqualToString:@"0"] || [textField.text isEqualToString:@""]) {
     textField.text = nil;
     [_integralArray replaceObjectAtIndex:i withObject:@"0"];
     textField.placeholder = @"输入积分";
     }else if(![MyMD5 validateNumber:textField.text ]){
     textField.text = nil;
     [_integralArray replaceObjectAtIndex:i withObject:@"0"];
     textField.placeholder = @"输入积分";
     NavgationbarView *mentionview=[[NavgationbarView alloc]init];
     [mentionview showLable:@"请输入正确积分数字" Controller:self];
     }else if(textField.text.intValue<500){
     
     integralTextField.text = nil;
     NavgationbarView *mentionview=[[NavgationbarView alloc]init];
     [mentionview showLable:@"最低使用500积分" Controller:self];
     [_integralArray replaceObjectAtIndex:i withObject:@"0"];
     
     }
     else if(totalInput<500){
     textField.text = nil;
     NavgationbarView *mentionview=[[NavgationbarView alloc]init];
     [mentionview showLable:@"积分不足" Controller:self];
     [_integralArray replaceObjectAtIndex:i withObject:@"0"];
     }
     else if (textField.text.intValue>totalInput || textField.text.intValue>[totalPrice floatValue] *integralRate) {
     
     if (![textField.text isEqualToString:@"0"]) {
     if (textField.text.intValue>[totalPrice floatValue] *integralRate) {
     NavgationbarView *mentionview=[[NavgationbarView alloc]init];
     [mentionview showLable:@"输入积分大于可使用积分" Controller:self];
     }else{
     NavgationbarView *mentionview=[[NavgationbarView alloc]init];
     [mentionview showLable:@"积分不足" Controller:self];
     }
     
     CGFloat price = totalInput>[totalPrice floatValue] *integralRate ? [totalPrice floatValue] *integralRate : totalInput;
     textField.text = [NSString stringWithFormat:@"%g",price];
     [_integralArray replaceObjectAtIndex:i withObject:textField.text];
     }
     
     }else{
     [_integralArray replaceObjectAtIndex:i withObject:textField.text];
     if(textField.text.intValue<500){
     
     integralTextField.text = nil;
     NavgationbarView *mentionview=[[NavgationbarView alloc]init];
     [mentionview showLable:@"最低使用500积分" Controller:self];
     
     
     }
     else if(totalInput<500){
     textField.text = nil;
     NavgationbarView *mentionview=[[NavgationbarView alloc]init];
     [mentionview showLable:@"积分不足" Controller:self];
     [_integralArray replaceObjectAtIndex:i withObject:@"0"];
     }
     }
     
     UIView *view = [_myTableView viewWithTag:textField.tag-10+500];
     UILabel *money = (UILabel *)[view viewWithTag:textField.tag-10+100];
     NSString* integ = [NSString stringWithFormat:@"%@",_integralArray[i]];
     CGFloat integfloat = integ.floatValue;
     CGFloat pricetota = [self changeMoney:textField.tag-10] - integfloat/integralRate*0.1;
     money.text=[NSString stringWithFormat:@"¥%.2f",pricetota];
     [self changeTotalPrice];
     return;
     }
     }
     */
}

- (NSMutableArray*)orderArray
{
    if(_orderArray == nil)
    {
        _orderArray = [NSMutableArray array];
    }
    return _orderArray;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 *  #pragma mark 数量减
 -(void)reduce:(UIButton*)sender
 {
 AffirmOrderCell * cell;
 if (kIOSVersions >= 7.0 && kIOSVersions < 8) {
 cell = [[(AffirmOrderCell *)[sender superview]superview]superview] ;
 }else{
 cell = (AffirmOrderCell *)[[sender superview] superview];
 }
 //    SCarCell * cell = (SCarCell *)[[sender superview] superview];
 
 if(cell.changeNum.text.intValue>1)
 {
 NSIndexPath * path = [_myTableView indexPathForCell:cell];
 ShopDetailModel *model=_shopArray[path.section][path.row];
 NSString *str = [cell.price.text substringFromIndex:1];
 
 UIView *view = [_myTableView viewWithTag:path.section+500];
 UILabel *money = (UILabel *)[view viewWithTag:path.section+100];
 //        //money:%@",money.text);
 
 tempTotalprice = [[money.text substringFromIndex:1] floatValue]-([model.shop_se_price intValue]*model.shop_num.intValue);
 tempShop_num =[NSString stringWithFormat:@"%d",model.shop_num.intValue-1];
 [self changeshopHttp:cell.shop_model typeid:cell.shop_model.stock_type_id withIndex:path shop_num:tempShop_num];
 
 }
 
 }
 
 -(void)addbtn:(UIButton*)sender
 {
 AffirmOrderCell * cell;
 if (kIOSVersions >= 7.0 && kIOSVersions < 8) {
 cell = [[(AffirmOrderCell *)[sender superview]superview]superview] ;
 }else{
 cell = (AffirmOrderCell *)[[sender superview] superview];
 }
 
 NSIndexPath * path = [_myTableView indexPathForCell:cell];
 //    //%d  %d",path.row,path.section);
 ShopDetailModel *model=_shopArray[path.section][path.row];
 NSString *str = [cell.price.text substringFromIndex:1];
 
 UIView *view = [_myTableView viewWithTag:path.section+500];
 UILabel *money = (UILabel *)[view viewWithTag:path.section+100];
 
 tempTotalprice = [[money.text substringFromIndex:1] floatValue]-([model.shop_se_price intValue]*model.shop_num.intValue);
 tempShop_num =[NSString stringWithFormat:@"%d",model.shop_num.intValue+1];
 [self changeshopHttp:cell.shop_model typeid:cell.shop_model.stock_type_id withIndex:path shop_num: tempShop_num ];
 
 }
 #pragma mark 改变购物车商品网络请求
 -(void)changeshopHttp:(ShopDetailModel *)model typeid:(NSString*)typeid withIndex:(NSIndexPath*)index shop_num:(NSString*)shop_num;
 {
 AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
 NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
 NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
 NSString*token=[user objectForKey:USER_TOKEN];
 
 
 NSString *url=[NSString stringWithFormat:@"%@shopCart/update?version=%@&token=%@&id=%@&size=%@&color=%@&shop_num=%@&stock_type_id=%@",[NSObject baseURLStr],VERSION,token,model.ID,model.shop_size,model.shop_color,shop_num,typeid];
 NSString *URL=[MyMD5 authkey:url];
 
 [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
 NSString *message=responseObject[@"message"];
 if (responseObject!=nil) {
 NSString *statu=responseObject[@"status"];
 if(statu.intValue==1)//请求成功
 {
 [self func:YES with:index];
 }else{
 [self func:NO with:index];
 }
 }
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 
 [[Animation shareAnimation] stopAnimationAt:self.view];
 if ([error code] == kCFURLErrorTimedOut) {
 [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
 }else{
 NavgationbarView *mentionview=[[NavgationbarView alloc]init];
 [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
 }
 }];
 }
 */
/**
 *  -(void)vouchersAlertView
 {
 NSString *message = [NSString stringWithFormat:@"分享就能使用%@元抵用券哦，\n确定不使用吗？",_selectMoel.voucher];
 //    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:nil contentText:message leftButtonTitle:@"暂不使用" rightButtonTitle:@"继续分享"];
 DXAlertView *alert =[DXAlertView shareWTF];
 [alert setWithTitle:nil contentText:message leftButtonTitle:@"暂不使用" rightButtonTitle:@"继续分享"];
 alert.layer.cornerRadius=5;
 alert.leftBtn.layer.cornerRadius=5;
 alert.rightBtn.layer.cornerRadius=5;
 alert.alertContentLabel.font=[UIFont systemFontOfSize:ZOOM(48)];
 alert.leftBtn.layer.borderColor=tarbarrossred.CGColor;
 alert.leftBtn.layer.borderWidth=1;
 alert.leftBtn.backgroundColor=[UIColor whiteColor];
 alert.rightBtn.backgroundColor=tarbarrossred;
 [alert.leftBtn setTitleColor:tarbarrossred forState:UIControlStateNormal];
 [alert.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
 [alert show];
 
 alert.leftBlock = ^() {
 [_selectSwithcArray removeAllObjects];
 for (int i=0; i<_shopArray.count; i++) {
 NSArray *array = _shopArray[i];
 for (int j=0; j<array.count; j++) {
 ShopDetailModel *shopmodel=array[j];
 shopmodel.voucher=@"0";
 [_selectSwithcArray addObject:[NSString stringWithFormat:@"%@",shopmodel.ID]];
 [shopmodel.usedNunArray removeAllObjects];
 [shopmodel.priceArray removeAllObjects];
 }
 }
 for (VoucherModel *model in self.voucherArr) {
 model.usedNum=0;
 }
 //        [_selectSwithcArray removeAllObjects];
 [_myTableView reloadData];
 [self changeTotalPrice];
 };
 alert.rightBlock = ^() {
 
 //现在去分享
 NavgationbarView *mentionview = [[NavgationbarView alloc]init];
 [mentionview showLable:@"分享中，请稍等哦~" Controller:self];
 
 [self performSelector:@selector(sharetishi) withObject:nil afterDelay:0.3];
 };
 alert.dismissBlock = ^() {
 
 };
 }
 */
@end

