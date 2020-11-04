//
//  TFPayStyleViewController.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/22.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFPayStyleViewController.h"
#import "LoginViewController.h"
#import "TFSetPaymentPasswordViewController.h"
#import "TFPayPasswordView.h"
#import "TFChangePaymentPasswordViewController.h"
#import "TFVoiceRedViewController.h"
#import "AppDelegate.h"
#import "DShareManager.h"
#import "BuySuccessViewController.h"
#import "TFMemberSuccessViewController.h"
#import "TFMemberShopStoreViewController.h"
#import "OrderDetailViewController.h"
#import "OrderTableViewController.h"

#import "TFPopBackgroundView.h"
#import "MyOrderViewController.h"

#import "payRequsestHandler.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "DataManager.h"
#import "YFShareModel.h"

#import "TFLedBrowseShopViewController.h"
#import "NewShoppingCartViewController.h"
#import "FightgroupsViewController.h"
#import "OneLuckdrawViewController.h"
#import "SpecialShopDetailViewController.h"
typedef NS_ENUM(NSInteger, PayStyle)
{
    PayStyleMine = 100, /**< 钱包付款 */
    PayStyleZhiFuBao, /**< 支付宝 */
    PayStyleWeChat /**< 微信支付 */
};



@interface TFPayStyleViewController () <UITableViewDelegate, UITableViewDataSource,DShareManagerDelegate>
{
    dispatch_source_t _timer;
    
    NSTimer *secondsTimer;
    int secondsTime;
    NSString *_style;
    
    /**
     *  a.若余额不足6元;则提示可用余额0元；
     
        b.若余额大于等于6元，购买单件正价商品，则提示可用余额6元；
     
        c. 若余额大于等于6元，购买多件正价商品，则提示账户余额翻倍后最大的可用余额值即6*商品件数，例如，用户购买3件商品，账户余额翻倍后余额值为15元，则支付页面显示可用余额12元；
     */
    double changeMoney;
    BOOL payedMoney;
    NSInteger useTwofold;//用户的余额可以使用额度
    
    NSInteger comecount;
}
/**
 *  钱包总共的钱
 */
@property (nonatomic, assign) double totalMoney;    /**< 钱包总额 */
@property (nonatomic, assign) double usableMoney; /**< 可用余额 */
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) UILabel *timerLabal;
@property (nonatomic, strong) UIView *bottomView;
/**
 *  立即支付
 */
@property (nonatomic, strong) UIButton *payBtn;
/**
 *  可用余额
 */
@property (nonatomic, assign) PayStyle myPayStyle;
@property (nonatomic, assign) BOOL isGroupPay;  /**< 是否组合付款 */
@property (nonatomic, assign) BOOL isWXPay;     /**< 能不能微信付款 */
@property (nonatomic, assign) BOOL isNormolShop;     /**< 是不是正价商品 */

@end

@implementation TFPayStyleViewController

- (instancetype)initWithPayType:(PayType)payType price:(double)price
{
    if (self = [super init]) {
        _payType = payType;
        _price = price;
    }
    return self;
}

- (void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)postNotification{
    if ([_fromType isEqualToString:@"订单组合付款"]&&[_fromType isEqualToString:@"订单列表按钮"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshOrder" object:nil];
    }
}

-(void)NotificationCenter{
    //监听支付成功回调通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buysuccess:) name:@"buysuccess" object:nil];
    //监听支付失败回调通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyfail:) name:@"buyfail" object:nil];
    
    //设置支付密码成功监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setpasswordsuccess:) name:@"setpasswordsuccess" object:nil];
}
-(void)BaseData{
    self.isWXPay=YES;changeMoney=0;
    self.payType = PayTypeSingle;
    MyLog(@"%d",[DataManager sharedManager].grade);
    /*
    if ([DataManager sharedManager].grade!=2) {
        useTwofold=[DataManager sharedManager].auseTwofold;
    }else if ([DataManager sharedManager].grade==2){
        useTwofold=[DataManager sharedManager].buseTwofold;
    }
    */
    if(self.shop_from.intValue==0&&self.shop_from!=nil){//单个订单点击付款时
        if (_shopmodel.tfn_money.floatValue!=0&&[_fromType isEqualToString:@"订单列表按钮"]) {
            changeMoney=_shopmodel.tfn_money.floatValue;
        }
        else if (_shopmodel.shop_price.floatValue>=useTwofold||_shopmodel.order_price.floatValue>=useTwofold)
            changeMoney += useTwofold*_shopmodel.shop_num.integerValue;
       
        self.isNormolShop=YES;
//        self.payType = ([DataManager sharedManager].isOpen==YES)?PayTypeGroup:PayTypeSingle;
        self.isOpen_type = [DataManager sharedManager].isOpen==YES?@"5":nil;
    }
    for(ShopDetailModel *model in self.sortArray){//批量付款的如果有签到包邮的订单就不显示余额支付
        if(model.shop_from.intValue==3||model.shop_from.intValue==5){
            self.p_type = @"5";
            self.shop_from = @"3";
        }else if (model.shop_from.intValue==4||model.shop_from.intValue==6){
            self.p_type = @"5";
            self.shop_from = @"4";
        }else if (model.shop_from.intValue==1){//特卖商品
            self.shop_from=@"1";
        }
        /*
        if (![model.remain_money isEqual:[NSNull null]]&&![model.wx_price isEqual:[NSNull null]]&&![model.is_wx isEqual:[NSNull null]]) {
            if (model.is_wx.integerValue==1&&model.wx_price.doubleValue != model.remain_money.doubleValue) {
                self.isWXPay=NO;
            }
        }
        */
        if(model.shop_from.intValue==0&&model.shop_from!=nil){
            self.shop_from=@"0";
            if (model.tfn_money.floatValue!=0&&[_fromType isEqualToString:@"订单组合付款"]) {
                _price+=model.tfn_money.floatValue;
                payedMoney=YES;
                changeMoney+=model.tfn_money.floatValue;
            }
            else if (model.shop_price.floatValue>=useTwofold||model.order_price.floatValue>=useTwofold)
                changeMoney += useTwofold*model.shop_num.integerValue;
            self.isNormolShop=YES;
//            self.payType = ([DataManager sharedManager].isOpen==YES)?PayTypeGroup:PayTypeSingle;
            self.isOpen_type = [DataManager sharedManager].isOpen==YES?@"5":nil;
        }
        if (model.lasttime.doubleValue<_lasttime.doubleValue||_lasttime==nil) {
            _lasttime=model.lasttime;
        }
    }
    if (![_shopmodel.remain_money isEqual:[NSNull null]]&&![_shopmodel.wx_price isEqual:[NSNull null]]&&![_shopmodel.is_wx isEqual:[NSNull null]]) {
        if (self.shopmodel.is_wx.integerValue==1&&_shopmodel.wx_price.doubleValue!=_shopmodel.remain_money.doubleValue) {
            self.isWXPay=NO;
        }
    }
    if(self.shop_from.intValue == 3||self.shop_from.intValue==4||self.shop_from.intValue==5){
        self.p_type = @"5";
    }
    if ([_order_code hasPrefix:@"G"] || [_order_code hasPrefix:@"V"]) {
        _urlcount=@"2";
    }else
        _urlcount=@"1";
    if (_urlcount.intValue==1&&_requestOrderDetail==1) {
        [self OrderdetailHttp];
    }

    //衣豆减半获取资格 在判断有未付款订单弹框后,用户点确认就调用,一天只可以调用一次!
//    if ([DataManager sharedManager].is_guideOrder) {
        [self httpGetActivityPayTime];
//    }else
//        [self httpGetNowTime];

    //衣豆减半活动下单成功后 2分钟后弹框 疯狂星期一 夺宝,一元夺宝也不引导
    if (![DataManager sharedManager].IS_Monday && self.shop_from.intValue != 4  && self.shop_from.intValue != 7 && self.shop_from.intValue != 5 && self.shop_from.intValue != 8) {
        [[DataManager sharedManager] getOrderHttp:YES];
    }
//    if (_lasttime!=nil) {
//        [self httpGetNowTime];
//    }


    MyLog(@"shop_from —— %@",self.shop_from);
    
}

-(void)viewDidAppear:(BOOL)animated
{
    comecount =0;
    [super viewDidAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    //如果是1元购订单 自动发起支付
    if(self.shop_from.intValue == 9)
    {
        [self payBtnClick:nil];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [TFStatisticsClickVM StatisticshandleDataWithClickType:@"到达支付" success:nil failure:nil];

    [DataManager sharedManager].outAppStatistics = @"支付方式页";
    
    [self NotificationCenter];
    [self BaseData];
    
    [self setNavigationItemLeft:@"支付方式"];
    
    [self setupUI]; /**< 配置UI */
    
    [self getData]; /**< 获取数据 */
    
}

- (void)setupUI
{
    ESWeakSelf;
    [self.view addSubview:self.tableView];
    
    CGFloat H_bottomV = ZOOM6(130);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(__weakSelf.view).offset(64);
        make.bottom.equalTo(__weakSelf.view).offset(-H_bottomV);
        make.width.mas_equalTo(kScreenWidth);
    }];
    
    [self showHeaderView:NO];
    
    
    [self.view addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(__weakSelf.view);
        make.height.mas_equalTo(H_bottomV);
    }];
}
/**
 *  获取数据, 在该方法内请求数据, 可用余额 等
 */
- (void)getData
{
//    self.price = 999999;
    
//    self.payType = ([DataManager sharedManager].isOpen==YES)?PayTypeGroup:PayTypeSingle;
    
    [self httpGetUsableMoney];

    [self updataSource:self.payType];

}

/**
 *  更新数据源
 *
 *  @param payType 支付类型
 */
- (void)updataSource:(PayType)payType
{
    [self.dataSourceArray removeAllObjects];
    /*
    if (payType == PayTypeGroup) {
        
        [self updataTableViewDataSource:[self updataArray] isGroupPay:YES currItem:[self defaultChoosePayStyle:PayStyleZhiFuBao]];
        
    } else {
        
        [self updataTableViewDataSource:[self initialArray] isGroupPay:NO currItem:(self.shop_from.intValue==1||[DataManager sharedManager].grade==2||self.totalMoney==0||self.p_type.integerValue==5 || self.isOpen_type.integerValue==5||([DataManager sharedManager].isOpen&&([DataManager sharedManager].twofoldness > 0))) ?[self defaultChoosePayStyle:PayStyleZhiFuBao]:[self defaultChoosePayStyle:PayStyleMine]];
    }
    */
    [self updataTableViewDataSource:[self initialArray] isGroupPay:NO currItem:[self defaultChoosePayStyle:PayStyleWeChat]];
    [self.tableView reloadData];
    
//    [self defaultChoosePayType:payType payStyle:self.myPayStyle];
}

- (PayStyleItem *)defaultChoosePayStyle:(PayStyle)payStyle
{

    PayStyleItem *item = [[PayStyleItem alloc] init];
    item.cellStyle = CellStyleFromPay;
    item.selected = YES;
    switch (payStyle) {
        case PayStyleMine:
        {
            item.title = @"余额";

        }
            break;
        case PayStyleZhiFuBao:
        {
            item.title = @"支付宝支付";
        }
            break;
        case PayStyleWeChat:
        {
            item.title = @"微信支付";
        }
            break;
            
        default:
            break;
    }
    return item;
}

//- (void)defaultChoosePayType:(PayType)payType payStyle:(PayStyle)payStyle
//{
//    if (payType==PayTypeSingle) {
//        [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:(payStyle-100) inSection:1]];
//    } else {
//        [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:(payStyle-100) inSection:1]];
//    }
//
//}
- (void)updataTableViewDataSource:(NSArray *)array isGroupPay:(BOOL)group currItem:(PayStyleItem *)currItem
{
    [self.dataSourceArray removeAllObjects];
    for (int i = 0; i<array.count; i++) {
        NSArray *arr = array[i];
        NSMutableArray *muArray = [NSMutableArray array];
        for (int j = 0; j<arr.count; j++) {
            PayStyleItem *item = [[PayStyleItem alloc] init];
            item.title = arr[j];
            item.selected = NO;
        
            if ([item.title isEqualToString:@"支付金额"]||[item.title isEqualToString:@"还需支付"]) {
                item.cellStyle = CellStyleFromTitle;
                if ([item.title isEqualToString:@"支付金额"]) {
//                    item.price = self.price;
//                    if (self.shop_from.intValue==1&&[DataManager sharedManager].isOpen) {//特卖商品余额翻倍情况下
//                        item.price=self.price;
//                    }else
                        item.price = [DataManager sharedManager].isOpen||[DataManager sharedManager].grade==2?self.price - self.usableMoney:self.price;
                    
                    self.SuccessViewMoney=item.price;
                } else {
                    item.price = self.price - self.usableMoney;
                }
            } else {
                item.cellStyle = CellStyleFromPay;
            }
            /**
             *  <#Description#>
             */
            if ([item.title isEqualToString:@"余额"] && group && self.usableMoney!=0) {
                item.selected = YES;
                self.isGroupPay = YES;
            }
            
            /**
             *  <#Description#>
             */
            if ([item.title isEqualToString:@"余额"] && !group &&[currItem.title isEqualToString:@"余额"]&& (self.totalMoney==0||([DataManager sharedManager].isOpen&&([DataManager sharedManager].twofoldness > 0)))) {
                item.selected = NO;
                self.isGroupPay = NO;
            }
            else if ([item.title isEqualToString:@"余额"] && !group &&[currItem.title isEqualToString:@"余额"]) {
                item.selected = YES;
                self.isGroupPay = NO;
                self.myPayStyle = PayStyleMine;
            }
            
            if ([item.title isEqualToString:@"支付宝支付"] && [currItem.title isEqualToString:@"支付宝支付"]) {
                item.selected = YES;
                self.myPayStyle = PayStyleZhiFuBao;
            }
            
            if ([item.title isEqualToString:@"微信支付"] && [currItem.title isEqualToString:@"微信支付"]) {
                item.selected = YES;
                self.myPayStyle = PayStyleWeChat;
            }
            
            [muArray addObject:item];
        }
        [self.dataSourceArray addObject:muArray];
    }
}

- (NSArray *)initialArray
{
    NSMutableArray *secArray = [NSMutableArray array];
    NSArray *array1 = @[@"支付金额"];
//    NSArray *array2 = (self.shop_from.intValue==1||self.p_type.integerValue==5||self.isOpen_type.integerValue==5||([DataManager sharedManager].grade==2&&[DataManager sharedManager].isOpen==NO&&self.shop_from.integerValue==0)) ? @[@"支付宝支付", @"微信支付"] : @[@"余额", @"支付宝支付", @"微信支付"];
    
    NSArray *array2 = @[ @"微信支付",@"支付宝支付"];
    //1元购只有微信支付
    if(self.shop_from.intValue == 9)
    {
        array2 = @[@"微信支付"];
    }
    [secArray addObject:array1];
    [secArray addObject:array2];
    
    return secArray;
}

- (NSArray *)updataArray
{
    NSMutableArray *secArray = [NSMutableArray array];
    NSArray *array1 = @[@"支付金额", @"余额"];
    NSArray *array2 = @[@"还需支付", @"支付宝支付", @"微信支付"];
    
    [secArray addObject:array1];
    [secArray addObject:array2];
    
    return secArray;
}

/**
 *  获取可用余额
 */
- (void)httpGetUsableMoney
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr1 = [NSString stringWithFormat:@"%@wallet/myWallet?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL1 = [MyMD5 authkey:urlStr1];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            responseObject = [NSDictionary changeType:responseObject];
            if ([responseObject[@"status"] intValue] == 1) {
                NSString *balanceStr = responseObject[@"balance"];
                self.totalMoney = [balanceStr doubleValue];
                if ([DataManager sharedManager].isOpen&&([DataManager sharedManager].twofoldness > 0)) {
                    self.totalMoney *= [DataManager sharedManager].twofoldness;
                }
//                self.totalMoney = 15.32;
//                 self.usableMoney = (int)self.totalMoney/6*6;
                if ((![DataManager sharedManager].isOpen&&([DataManager sharedManager].grade!=2))
//                    ||([DataManager sharedManager].isOpen&&self.shop_from.intValue==1)
                    )//后面加的  特卖商品余额翻倍情况下
                    self.usableMoney=self.totalMoney;
                else if (self.payType == PayTypeSingle) {
//                    self.usableMoney = self.totalMoney;
//                } else if (self.payType == PayTypeGroup) {
                    if([_fromType isEqualToString:@"订单列表按钮"]){
                        MyLog(@"%@",_shopmodel.remain_money);
                        
                        if (_shopmodel.remain_money.floatValue!=0&&_shopmodel.tfn_money.floatValue!=0) {
                            self.usableMoney=_price-_shopmodel.remain_money.floatValue;
                        }else if(self.totalMoney<changeMoney)
                            self.usableMoney=self.totalMoney;
                        else
                            self.usableMoney=changeMoney;

                    }else if ([_fromType isEqualToString:@"订单组合付款"]){
                        if (payedMoney) {
                            self.usableMoney=changeMoney;
                        }
                        else if(self.totalMoney<changeMoney)
                            self.usableMoney=self.totalMoney;
                        else if (![DataManager sharedManager].isOpen)//后面加的
                            self.usableMoney=0;
                        else
                            self.usableMoney=changeMoney;
                    }
                    else
                    if (changeMoney==0) {
                        self.usableMoney = changeMoney;
                    }
                    else if (self.totalMoney >= changeMoney) {
                        self.usableMoney = changeMoney;
                    }else if(self.totalMoney<useTwofold&&changeMoney==useTwofold){
                        self.usableMoney=0;
                    }
                    else {
//                        self.usableMoney = (int)self.totalMoney/6*6;
                        self.usableMoney=self.totalMoney;
                    }
                
                }
                [self updataSource:self.payType];
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NavgationbarView *nv =[[NavgationbarView alloc]init];
        [nv showLable:@"网络连接失败，请检查网络后重试" Controller:self];
    }];
}

/**
 *  立即支付按钮 事件
 *
 *  @param sender <#sender description#>
 */
- (void)payBtnClick:(UIButton *)sender
{
    
    MyLog(@"self.isGroup: %d, self.myPayStyle: %ld", self.isGroupPay, (long)self.myPayStyle);
    _style=[NSString stringWithFormat:@"%ld",self.myPayStyle-100];
    [self pay];
}

/**
 *  是否显示头部开始计时
 *
 *  @param show <#show description#>
 */
- (void)showHeaderStartTimer:(BOOL)show
{
    if (show) {
        [self showHeaderView:YES];
//        [self startTimer: 24*60*60 action:@selector(headViewStartTimer:) withTimeOut:@selector(headViewTimeOut)];
    } else {
        [self showHeaderView:NO];
        [self stopTimer];
    }
}

/**
 *  头部开始计时
 *
 *  @param timeText 时间文本
 */
- (void)headViewStartTimer:(NSString *)timeText
{
    NSString *text = [NSString stringWithFormat:@"订单为你保留%@，超时将会自动关闭", timeText];
    NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:text];
    [attText addAttribute:NSForegroundColorAttributeName value:COLOR_ROSERED range:NSMakeRange(6, 8)];
    
    self.timerLabal.attributedText = attText;
}

/**
 *  头部计时超时
 */
- (void)headViewTimeOut
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"buyfail" object:nil];
    if (self.navigationController.viewControllers.lastObject!=self) {
        return;
    }
    for (UIViewController *view in self.navigationController.viewControllers) {
        if ([view isKindOfClass:[NewShoppingCartViewController class]]) {
            [self.navigationController popToViewController:view animated:YES];
            return;
        }
    }
    if ([self.fromType isEqualToString:@"我要发红包"]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self judgeOrderCount];
    }
}

/**
 *  立即支付计时
 *
 *  @param timeText <#timeText description#>
 */
- (void)payBtnStartTimer:(NSString *)timeText
{
    if([self.fromType isEqualToString:@"购买会员"])
    {
        [self.payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    }else{
        [self.payBtn setTitle:[NSString stringWithFormat:@"立即支付 %@", timeText] forState:UIControlStateNormal];
    }
    
}

/**
 *  立即支付计时超时
 */
- (void)payBtnTimeOut
{
    self.payBtn.backgroundColor = RGBCOLOR_I(240, 240, 240);
    self.payBtn.userInteractionEnabled=NO;
}

/**
 *  计时器开始计时
 *
 *  @param timeCount 计时总共秒数
 */
- (void)startTimer:(double)timeCount action:(SEL)sel withTimeOut:(SEL)selOut
{
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
    __block double timeOut = timeCount-1;
    double delayInSeconds = 1.0;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    _timer = timer;
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0), delayInSeconds*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        if(timeOut < 0){ //倒计时结束，关闭
            dispatch_source_cancel(timer);
            _timer = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSelector:selOut withObject:nil afterDelay:0.0];
                [self payBtnTimeOut];
            });
        } else{
            int hours = timeOut / 3600;
            int minutes = (int)timeOut % 3600/ 60;
            int seconds = (int)timeOut % 60;
            NSString *stringTime = [NSString stringWithFormat:@"%02d:%02d:%02d", hours,minutes, seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSelector:sel withObject:stringTime afterDelay:0.0];
                [self payBtnStartTimer:stringTime];
            });
            timeOut--;
        }
    });
    dispatch_resume(timer);
}

/**
 *  停止计时
 */
- (void)stopTimer
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        dispatch_async(dispatch_get_main_queue(), ^{
            //设置界面的按钮显示 根据自己需求设置
            _timer = nil;
        });
    }
}

/**
 *  显示订单失败计时视图
 *
 *  @param isShow 是否显示
 */
- (void)showHeaderView:(BOOL)show
{
    CGFloat headerHeight = 0;
    if (show) {
        headerHeight = ZOOM6(200);
    }
    self.headerView.hidden=!show;
    self.headerView.frame = CGRectMake(0, 0, 0, headerHeight);
    self.tableView.tableHeaderView = self.headerView;
    
    [self updateWithHeaderViewAll:show];
}

- (void)updateWithHeaderViewAll:(BOOL)show
{
    UIButton *btn = (UIButton *)[self.headerView viewWithTag:200];
    UILabel *lab = (UILabel *)[self.headerView viewWithTag:201];
    
    CGFloat H_btn = 0;
    CGFloat H_lab = 0;
    if (show) {
        H_btn = ZOOM6(60);
        H_lab = ZOOM6(46);
    }
    
    [btn setTitle:(H_btn?@"支付失败":@"") forState:UIControlStateNormal];
    
    [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headerView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, H_btn));
        make.top.equalTo(_headerView.mas_top).offset(ZOOM6(50));
    }];
    
    [lab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom);
        make.centerX.equalTo(_headerView.mas_centerX);
        make.width.equalTo(_headerView);
        make.height.mas_equalTo(H_lab);
    }];

}

/**
 *  弹框
 */
- (void)showPopView
{
    PopBackgroundView *popView = [[PopBackgroundView alloc] init];
    [popView show];
    
    /**
     *  取消 和 确定
     */
    [popView setCancelBlock:^{
        
    } withConfirmBlock:^{
        [self stopTimer];
        [self judgeOrderCount];
    }];
}
- (void)zeroBuyRemindView {
    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] initWithTitle:@"温馨提示" message:@"每日仅有一次0元购美衣的机会哦。错过就木有啦。" showCancelBtn:NO leftBtnText:@"白送也不要" rightBtnText:@"继续付款"];
    popView.textAlignment=NSTextAlignmentCenter;
    popView.isManualDismiss = YES;
    popView.showView = self.view;
    
    kSelfWeak;
    [popView showCancelBlock:^{
        [popView dismissAlert:YES];
        [weakSelf stopTimer];
        [weakSelf judgeOrderCount];
    } withConfirmBlock:^{
        [popView dismissAlert:YES];
        [self payBtnClick:nil];
    } withNoOperationBlock:^{

    }];

}

#pragma maek - tableView delegate dataSoureDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSourceArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ZOOM6(100);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    PayStyleItem *item = self.dataSourceArray[indexPath.section][indexPath.row];
    
    switch (item.cellStyle) {
        case CellStyleFromTitle:
        {
            static NSString *cellIdf = @"cell";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdf];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdf];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UILabel *titleLab = [UILabel new];
                titleLab.font = kFont6px(30);
                titleLab.textColor = RGBCOLOR_I(62, 62, 62);
                titleLab.tag = 199;
                [cell.contentView addSubview:titleLab];
                
                [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(cell.contentView).offset(10);
                    make.top.bottom.equalTo(cell.contentView);
                    make.width.mas_equalTo(200);
                    make.centerY.equalTo(cell.contentView.mas_centerY);
                }];
                
                UILabel *moneyLab = [UILabel new];
                moneyLab.tag = 200;
                moneyLab.font = kFont6px(30);
                moneyLab.textColor = RGBCOLOR_I(62, 62, 62);
                moneyLab.textAlignment = NSTextAlignmentRight;
                [cell.contentView addSubview:moneyLab];
                [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(cell.contentView.mas_centerY);
                    make.right.equalTo(cell.contentView.mas_right).offset(-10);
                    make.top.and.bottom.equalTo(cell.contentView);
                    make.width.mas_equalTo(200);
                }];
            }
            UILabel *titleLab = (UILabel *)[cell.contentView viewWithTag:199];
            UILabel *moneyLab = (UILabel *)[cell.contentView viewWithTag:200];
            titleLab.text = item.title;
            moneyLab.text = [NSString stringWithFormat:@"%.2f元", item.price];
            
            return cell;
            
        }
            break;
        case CellStyleFromPay:
        {
            static NSString *cellIdf2 = @"cell2";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdf2];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdf2];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UIImageView *imgV = [UIImageView new];
                imgV.tag = 201;
                [cell.contentView addSubview:imgV];
                [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(cell.contentView).offset(10);
                    make.size.mas_equalTo(CGSizeMake(ZOOM6(50), ZOOM6(50)));
                    make.centerY.equalTo(cell.contentView.mas_centerY);
                }];
                
                UIButton *selectBtn = [UIButton new];
                selectBtn.tag = 100;
                [selectBtn setImage:[UIImage imageNamed:@"pay_icon_nor"] forState:UIControlStateNormal];
                [selectBtn setImage:[UIImage imageNamed:@"pay_icon_cel"] forState:UIControlStateSelected];
                selectBtn.userInteractionEnabled = NO;
                [cell.contentView addSubview:selectBtn];
                
                [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(cell.contentView.mas_right).offset(-10);
                    make.size.mas_equalTo(CGSizeMake(ZOOM6(44), ZOOM6(44)));
                    make.centerY.equalTo(cell.contentView.mas_centerY);
                }];
                
                UILabel *titleLab = [UILabel new];
                titleLab.tag = 202;
                titleLab.textColor = RGBCOLOR_I(62, 62, 62);
                titleLab.font = kFont6px(30);
                [cell.contentView addSubview:titleLab];
                [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(imgV.mas_right).offset(ZOOM6(10));
                    make.centerY.equalTo(cell.contentView.mas_centerY);
                    make.top.bottom.equalTo(cell.contentView);
                    make.width.mas_equalTo(200);
                }];
                
                UILabel *usableMoneyLab = [UILabel new];
                usableMoneyLab.tag = 203;
                usableMoneyLab.textColor = COLOR_ROSERED;
                usableMoneyLab.font = [UIFont systemFontOfSize:13];
                usableMoneyLab.textAlignment = NSTextAlignmentRight;
                [cell.contentView addSubview: usableMoneyLab];
                
                [usableMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(cell.contentView);
                    make.right.equalTo(selectBtn.mas_left).offset(-ZOOM6(12));
                    make.width.mas_equalTo(200);
                    
                }];
                
            }
            
            UIImageView *imgV = (UIImageView *)[cell.contentView viewWithTag:201];
            UILabel *titleLab = (UILabel *)[cell.contentView viewWithTag:202];
            UILabel *usableMoneyLab = (UILabel *)[cell.contentView viewWithTag:203];
            UIButton *selectBtn = (UIButton *)[cell.contentView viewWithTag:100];
            if (![item.title isEqualToString:@"余额"]) {
                usableMoneyLab.hidden = YES;
            } else {
                usableMoneyLab.hidden = NO;
            }
            titleLab.textColor = RGBCOLOR_I(62, 62, 62);
            if (self.payType == PayTypeGroup) { /**< 组合付款 */
                usableMoneyLab.text = [NSString stringWithFormat:@"可用余额%.2f元", self.usableMoney];
                if (self.usableMoney!=0) {
                    usableMoneyLab.textColor = COLOR_ROSERED;
                } else {
                    usableMoneyLab.textColor = RGBCOLOR_I(240, 240, 240);
                    if ([item.title isEqualToString:@"余额"]) {
                        titleLab.textColor = RGBCOLOR_I(240, 240, 240);
                    }
                }
                if (self.isWXPay==NO&&[item.title isEqualToString:@"微信支付"]) {
                    titleLab.textColor = RGBCOLOR_I(240, 240, 240);
                }
            } else { /**< 单选付款 */
                usableMoneyLab.textColor = COLOR_ROSERED;
                if (([DataManager sharedManager].grade==2&&self.shop_from.integerValue==1)) {
                    if (([DataManager sharedManager].isOpen&&([DataManager sharedManager].twofoldness > 0))) {
                         usableMoneyLab.textColor = RGBCOLOR_I(240, 240, 240);
                    }
                    usableMoneyLab.text = [NSString stringWithFormat:@"可用余额%.2f元", self.totalMoney];
                }else
                if (self.totalMoney==0||([DataManager sharedManager].isOpen&&([DataManager sharedManager].twofoldness > 0))) {
                    if ([item.title isEqualToString:@"余额"]) {
                        titleLab.textColor = RGBCOLOR_I(240, 240, 240);
                    }
                    usableMoneyLab.text = [NSString stringWithFormat:@"可用余额%.2f元", self.usableMoney];
                    usableMoneyLab.textColor = RGBCOLOR_I(240, 240, 240);
                }
                else if (self.usableMoney < self.price) {
                    usableMoneyLab.text = [NSString stringWithFormat:@"可用余额%.2f元(余额不足)", self.usableMoney];
                    usableMoneyLab.textColor = COLOR_ROSERED;
                } else {
                    usableMoneyLab.text = [NSString stringWithFormat:@"可用余额%.2f元", self.usableMoney];
                    usableMoneyLab.textColor = RGBCOLOR_I(255, 63, 139);
                }
            }
            
            imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"pay_icon_%@", item.title]];
            titleLab.text = item.title;
            selectBtn.selected = item.selected;
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PayStyleItem *item = self.dataSourceArray[indexPath.section][indexPath.row];
    if (item.cellStyle!=CellStyleFromTitle) {
        if (self.payType == PayTypeSingle) {
            if ((self.totalMoney==0||([DataManager sharedManager].isOpen&&([DataManager sharedManager].twofoldness > 0)))&&[item.title isEqualToString:@"余额"]) {
                
            }else
                [self singleChooseItemWithCurrItem:item];
        } else if (self.payType == PayTypeGroup) {
            
            if ([item.title isEqualToString:@"余额"]) {
                
            } else if ([item.title isEqualToString:@"支付宝支付"]) {

                [self groupChooseItemWithCurrItem:item];
                
            } else if ([item.title isEqualToString:@"微信支付"]) {
                if (self.isWXPay) {
                    [self groupChooseItemWithCurrItem:item];
                }
            }
        }
        [self.tableView reloadData];
    }
}

/**
 *  单选模式
 *
 *  @param item 当前点击的item
 */
- (void)singleChooseItemWithCurrItem:(PayStyleItem *)item
{
    [self updataWithSelectItem];
    if ([item.title isEqualToString:@"余额"]) {
        self.myPayStyle = PayStyleMine;
    } else if ([item.title isEqualToString:@"支付宝支付"]) {
        self.myPayStyle = PayStyleZhiFuBao;
    } else if ([item.title isEqualToString:@"微信支付"]) {
        self.myPayStyle = PayStyleWeChat;
    }
    item.selected = !item.selected;
}

- (void)groupChooseItemWithCurrItem:(PayStyleItem *)item
{
    [self updataTableViewDataSource:[self updataArray] isGroupPay:YES currItem:item];
}

- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)updataWithSelectItem
{
    [self.dataSourceArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSArray *secArray = (NSArray *)obj;
        [secArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            PayStyleItem *item = (PayStyleItem *)obj;
            item.selected = NO;
        }];
        
    }];
}

#pragma mark - getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.backgroundColor = [UIColor whiteColor];
        UIButton *btn = [UIButton new];
        btn.tag = 200;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"pay_icon_Payment_failure"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"pay_icon_Payment_failure"] forState:UIControlStateSelected];
        [btn setTitle:@"支付失败" forState:UIControlStateNormal];
        [_headerView addSubview:btn];
        
//        [btn setImageEdgeInsets:UIEdgeInsetsMake(btn.imageEdgeInsets.top, btn.imageEdgeInsets.left, btn.imageEdgeInsets.bottom, ZOOM6(10))];
        [btn setTitleColor:RGBCOLOR_I(62, 62, 62) forState:UIControlStateNormal];
        btn.titleLabel.font = kFont6px(36);
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_headerView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(200, ZOOM6(60)));
            make.top.equalTo(_headerView.mas_top).offset(ZOOM6(50));
        }];
        
        UILabel *timerLable = [UILabel new];
        timerLable.tag = 201;
        timerLable.font = kFont6px(30);
        timerLable.textColor = RGBCOLOR_I(125, 125, 125);
        timerLable.textAlignment = NSTextAlignmentCenter;
        
        NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:@"订单为你保留23:59:59，超时将会自动关闭"];
        [attText addAttribute:NSForegroundColorAttributeName value:COLOR_ROSERED range:NSMakeRange(6, 8)];
        timerLable.attributedText = attText;
        
        [_headerView addSubview:_timerLabal = timerLable];
        [timerLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btn.mas_bottom);
            make.centerX.equalTo(_headerView.mas_centerX);
            make.width.equalTo(_headerView);
            make.height.mas_equalTo(ZOOM6(46));
        }];
    }
    return _headerView;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [UIView new];
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = RGBCOLOR_I(194, 194, 194);
        [_bottomView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(_bottomView);
            make.height.mas_equalTo(1);
        }];
        
        UIButton *payBtn = [UIButton new];
        [payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        payBtn.backgroundColor = COLOR_ROSERED;
        [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        payBtn.layer.masksToBounds = YES;
        payBtn.layer.cornerRadius = ZOOM6(10);
        payBtn.titleLabel.font = kFont6px(36);
        [payBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_payBtn = payBtn];
        
        [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(ZOOM6(690), ZOOM6(88)));
            make.edges.equalTo(_bottomView).with.insets(UIEdgeInsetsMake(ZOOM6(18), ZOOM6(30), ZOOM6(18), ZOOM6(30)));
            make.center.equalTo(_bottomView);
        }];
    }
    return _bottomView;
}

- (NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pay
{
    if (secondsTime <= 0&&_lasttime!=nil) {
        [self showHint:@"您已错过付款时间"];
        return;
    }
    [MobClick event:SHOP_PAY];
    
    if(_isNormolShop)
        [TFStatisticsClickVM handleDataWithPageType:nil withClickType:@"支付方式页面”立即支付“" success:^(id data, Response *response) {
        } failure:^(NSError *error) {
        }];
    
    NSUserDefaults *userdefaul =[NSUserDefaults standardUserDefaults];
    [userdefaul setObject:[NSString stringWithFormat:@"%f",self.SuccessViewMoney] forKey:PAY_PRICE];
    [userdefaul setObject:[NSString stringWithFormat:@"%f",self.SuccessViewMoney] forKey:PAY_MONEY];
    
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

#pragma mark - 第三方红包支付成功回调后台
//支付成功
- (void)httpThirdPartyPayToRedCallback{
    for (UIViewController *viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[TFVoiceRedViewController class]]) {
            [self.navigationController popToViewController:viewController animated:YES];
        }
    }
    
    [self httpGetRedPacketShareLink];
    
}

//支付失败
- (void)httpThirdPartyPayToRedFail{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    [nv showLable:@"红包支付失败" Controller:self];
}
#pragma mark - 数据请求处理
- (void)httpGetActivityPayTime {
    [[APIClient sharedManager]netWorkGeneralRequestWithApi:@"wallet/yiDouHalve?" caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
        if (response.status == 1 && data[@"now"]!=nil && data[@"data"][@"end_date"]!=nil && ![data[@"data"][@"end_date"] isEqual:[NSNull null]]) {
            if ([data[@"data"][@"end_date"] doubleValue]>[data[@"now"] doubleValue]) {
                secondsTime=[data[@"data"][@"end_date"] doubleValue]/1000-[data[@"now"] doubleValue]/1000;
                [self startTimer: secondsTime action:@selector(headViewStartTimer:) withTimeOut:@selector(headViewTimeOut)];
                [DataManager sharedManager].is_guideOrder=YES;
            }else{
                [self httpGetNowTime];
                [DataManager sharedManager].is_guideOrder=NO;
            }

        }else{
            [self httpGetNowTime];
            [DataManager sharedManager].is_guideOrder=NO;
        }
    } failure:^(NSError *error) {

    }];
}
/**
 *  在使用微信和支付宝支付成功后.调此接口,表示已经支付成功
 */
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

    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(void)httpGetPayCode{
    [[NSUserDefaults standardUserDefaults ]setObject:_style forKey:PAY_TYPE];
    [[NSUserDefaults standardUserDefaults ]setObject:_order_code forKey:PAY_ORDERCODE];
    [[NSUserDefaults standardUserDefaults ]setObject:_urlcount forKey:PAY_NUM];
    
}
/**
 *  系统当前时间
 */
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
            responseObject = [NSDictionary changeType:responseObject];
            MyLog(@"%@  %lld",responseObject,[DataManager sharedManager].endDate);
            NSString *message=responseObject[@"message"];
            if([responseObject[@"status"]intValue]==1) {
                secondsTime=_lasttime!=nil?[_lasttime doubleValue]/1000-[responseObject[@"now"] doubleValue]/1000:24*60*60;
//                secondsTime=6;
                /*
                if([DataManager sharedManager].isOpen&&[responseObject[@"now"]doubleValue]>[DataManager sharedManager].endDate){
                    [DataManager sharedManager].isOpen=NO;
                    self.payType = ([DataManager sharedManager].isOpen==YES)?PayTypeGroup:PayTypeSingle;
                    [self updataSource:self.payType];
                }
                */
//                secondsTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerMethod:) userInfo:nil repeats:YES];
//                [[NSRunLoop currentRunLoop] addTimer:secondsTimer forMode:UITrackingRunLoopMode];
                [self startTimer: secondsTime action:@selector(headViewStartTimer:) withTimeOut:@selector(headViewTimeOut)];
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
//- (void)timerMethod:(NSTimer*)theTimer{
//    if (secondsTime <= 0) {
//        [secondsTimer invalidate];
//    }else{
//        secondsTime--;
//    }
//}

//获取订单详情数据
- (void)OrderdetailHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
   NSString *url=[NSString stringWithFormat:@"%@order/getOrderDetial?version=%@&order_code=%@&token=%@",[NSObject baseURLStr],VERSION,self.order_code,token];
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation]createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[Animation shareAnimation]stopAnimationAt:self.view];
        
        MyLog(@"%@",responseObject);
        
        if (responseObject!=nil) {
            responseObject = [NSDictionary changeType:responseObject];
            NSString *statu=responseObject[@"status"];
            NSDictionary *dic=responseObject[@"order"];
            
            if(statu.intValue==1){
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
                model.issue_endtime=dic[@"issue_endtime"];

                model.order_price=dic[@"pay_money"];
                
                NSArray *brr=responseObject[@"orderShops"];
                for(NSDictionary *dicc in brr) {
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
                    
                    shopmodel.tfn_money=dic[@"tfn_money"];
                    shopmodel.tfn_money_ago=dic[@"tfn_money_ago"];
                    shopmodel.remain_money=dic[@"remain_money"];
                    shopmodel.is_wx=dic[@"is_wx"];
                    shopmodel.wx_price=dic[@"wx_price"];

                    
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
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[Animation shareAnimation]stopAnimationAt:self.view];
    }];
}

#pragma mark - 支付有关
#pragma  mark - 通知
- (void)buyfail:(NSNotification*)note
{
    [TFStatisticsClickVM StatisticshandleDataWithClickType:@"跳出支付" success:nil failure:nil];

    [self postNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"buyfail" object:nil];
    
    if ([self.fromType isEqualToString:@"我要发红包"]) {
        [self httpThirdPartyPayToRedFail];
    } else {
        if(self.shop_from.integerValue == 11)
        {
            [MBProgressHUD show:@"支付失败" icon:nil view:self.view];
            [self.navigationController popViewControllerAnimated:YES];
        }else
            [self showHeaderStartTimer:YES];
    }
}

-(void)buysuccess:(NSNotification*)note
{
    [TFStatisticsClickVM StatisticshandleDataWithClickType:@"跳出支付" success:nil failure:nil];

    comecount ++;
    if(comecount ==1)
    {
        [self postNotification];
        if ([self.fromType isEqualToString:@"我要发红包"]) {
            [self httpThirdPartyPayToRedCallback];
        } else {
            
            if(self.shop_from.intValue == 2){
                NSString *ismember = @"2";
                [[NSUserDefaults standardUserDefaults] setObject:ismember forKey:USER_MEMBER];
                [MyMD5 changeMemberPriceRate];
                TFMemberSuccessViewController *member = [[TFMemberSuccessViewController alloc]init];
                [self.navigationController pushViewController:member animated:YES];
                return;
                
            }
            else{
                [self httpPayResurt];
                if (self.shop_from.intValue==4 || self.shop_from.intValue==8) {
                    [self httpGetPayCode];
                }else if(self.shop_from.integerValue == 11)
                {
                    [MBProgressHUD show:@"支付成功" icon:nil view:self.view];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"buyVipCardSuccess" object:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
                
                BuySuccessViewController *successpay=[[BuySuccessViewController alloc]init];
                successpay.shopprice=[NSString stringWithFormat:@"%f",self.SuccessViewMoney];
                successpay.shopArray=self.sortArray;
                successpay.orderCode = self.order_code;
                successpay.p_type = self.p_type;
                successpay.isTM = self.isTM;
                successpay.shop_from = self.shop_from;
                if (self.is_roll) {//如果是组团订单  改变shop_from  为了支付成功后的跳转
                    successpay.shop_from=@"7";
                }
                
                //何波加的 2016-11-25
                if([self.fromType isEqualToString:@"活动商品成团下单"]||self.isFashionBuy)
                {
                    successpay.shop_from = @"7";
                    self.fromType = @"";
                    if(!self.is_group)
                    {
                        [Signmanager SignManarer].task_Fightgroups = YES;
                    }
                }
                successpay.isNormolShop=self.isNormolShop;
                [self.navigationController pushViewController:successpay animated:YES];
                return;
            }
        }
        
        return;
    }
}

//一元购买支付成功到一元抽奖界面
- (void)normalgotoOneLuck
{
    OneLuckdrawViewController *oneLuck = [OneLuckdrawViewController new];
    oneLuck.comefrom = @"paysuccess";
    oneLuck.order_code = self.order_code;
    [self.navigationController pushViewController:oneLuck animated:YES];
    
    return;
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
        if ([viewController isKindOfClass:NSClassFromString(@"OneIndianaDetailViewController")]) {
            [self.navigationController popToViewController:viewController animated:YES];
            return;
        }
        
        if ([viewController isKindOfClass:[OneLuckdrawViewController class]])
        {
            
            [self.navigationController popToViewController:viewController animated:YES];
            return;
        }
    }
    if (_urlcount.intValue==1&&_requestOrderDetail==1) {
        OrderDetailViewController *order=[[OrderDetailViewController alloc]init];
        order.orderModel= _shopmodel;
        [self.navigationController pushViewController:order animated:YES];
        NSMutableArray *viewControllers=[NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[self class]]) {
                [viewControllers removeObject:obj];
            }
        }];
        self.navigationController.viewControllers=viewControllers;
    }else if (self.shop_from.intValue == 7)//何波修改 2017-7-14
    {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (self.shop_from.intValue == 10 || self.shop_from.intValue == 11)
    {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[ShopDetailViewController class]])
            {
                [self.navigationController popToViewController:controller animated:YES];
                return;
            }else if ([controller isKindOfClass:[SpecialShopDetailViewController class]]){
                [self.navigationController popToViewController:controller animated:YES];
                return;
            }
        }
    }
    else{
        
        MyOrderViewController *myorder=[[MyOrderViewController alloc]init];
        myorder.status1=[NSString stringWithFormat:@"1"];
        myorder.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:myorder animated:YES];
        NSMutableArray *viewControllers=[NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [viewControllers removeObject:viewControllers[viewControllers.count-3]];
        [viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[self class]]) {
                [viewControllers removeObject:obj];
            }
        }];
        self.navigationController.viewControllers=viewControllers;
    }
}

/**
 *  界面返回跳转
 */
- (void)toback
{
    MyLog(@"钱包支付失败")
    for (UIViewController *controller in self.navigationController.viewControllers) {
        
        if ([controller isKindOfClass:[OrderTableViewController class]]){
//            [self judgeOrderCount];
            [self showHeaderStartTimer:YES];
            return;
        }else if ([controller isKindOfClass:[TFMemberShopStoreViewController class]]){
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }else if ([controller isKindOfClass:[OneLuckdrawViewController class]])
        {
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }else{
           [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)leftBarButtonClick
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"buyfail" object:nil];
    
    if ([self.fromType isEqualToString:@"我要发红包"] || [self.fromType isEqualToString:@"购买会员"]) {
        [self stopTimer];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self stopTimer];
        [self judgeOrderCount];
//        [self showPopView];
//        [self zeroBuyRemindView];
    }
    
}
#pragma mark  微信支付
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
            responseObject = [NSDictionary changeType:responseObject];
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
#pragma mark 微信支付++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alter show];
}
#pragma mark 网络请求获取微信支付prepay_id
-(void)WeixinHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSString *url;
    if(_urlcount.intValue >1){
        url=[NSString stringWithFormat:@"%@wxpay/appUinifiedOrderList?version=%@&order_code=%@&token=%@&order_name=%@",[NSObject baseURLStr_Pay],VERSION,self.order_code,token,@"我的"];
    }else{
        url=[NSString stringWithFormat:@"%@wxpay/appUinifiedOrder?version=%@&order_code=%@&token=%@&order_name=%@",[NSObject baseURLStr_Pay],VERSION,self.order_code,token,@"我的"];
    }
    //    url=[NSString stringWithFormat:@"%@wxpay/uinifiedOrder?version=V1.0&order_code=%@&token=%@&order_name=%@",[NSObject baseURLStr],self.order_code,token,@"我的"];
    
    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        if (responseObject!=nil) {
            responseObject = [NSDictionary changeType:responseObject];
            NSMutableDictionary *dic=responseObject[@"xml"];
            if(dic){
                [self Winpay:dic Orderno:self.order_code];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        
    }];
    
}

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
#pragma mark 获取支付宝相关参数
- (void)zhifubaoArgumentHttp:(NSString*)ordercode
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    if(token!=nil){
        url=[NSString stringWithFormat:@"%@alipay/getAppKey?version=%@&token=%@&order_code=%@",[NSObject baseURLStr_Pay],VERSION,token,ordercode];
    }
    NSString *URL=[MyMD5 authkey:url];
    NSURL *httpUrl=[NSURL URLWithString:URL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpUrl];
    request.timeoutInterval = 3;
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        int status = [responseObject[@"status"] intValue];
        if (status == 1) {
            if(responseObject !=nil && responseObject !=NULL){
                
                if (![responseObject[@"price"] isEqual:[NSNull null]] && responseObject[@"price"] !=nil) {
                    [userdefaul setObject:responseObject[@"price"] forKey:PAY_ALI_PRICE];
                }else{
                    [MBProgressHUD show:@"获取订单信息失败" icon:nil view:nil];
                    return;
                }
                
                if(responseObject[@"ali_public_key"]!=nil && ![responseObject[@"ali_public_key"] isEqualToString:@"<null>"]){
                    [userdefaul setObject:responseObject[@"ali_public_key"] forKey:PAY_ALI_PUBLIC_KEY];
                }
                if(responseObject[@"partner"]!=nil && ![responseObject[@"partner"] isEqualToString:@"<null>"]) {
                    [userdefaul setObject:responseObject[@"partner"] forKey:PAY_PARTNER];
                }
                if(responseObject[@"pay_url"]!=nil && ![responseObject[@"pay_url"] isEqualToString:@"<null>"]) {
                    [userdefaul setObject:responseObject[@"pay_url"] forKey:PAY_URL];
                }
                if(responseObject[@"private_key"] && ![responseObject[@"private_key"] isEqualToString:@"<null>"]){
                    [userdefaul setObject:responseObject[@"private_key"] forKey:PAY_PRIVATE_KEY];
                }
                if(responseObject[@"seller"] && ![responseObject[@"seller"] isEqualToString:@"<null>"]){
                    [userdefaul setObject:responseObject[@"seller"] forKey:PAY_SELLER];
                }
                if(responseObject[@"sign_type"] && ![responseObject[@"sign_type"] isEqualToString:@"<null>"]){
                    [userdefaul setObject:responseObject[@"sign_type"] forKey:PAY_SIGN_TYPE];
                }
                
                [self zhifubaoPay];
            
            }
        }else{
            [MBProgressHUD show:@"获取订单信息失败" icon:nil view:nil];
        }
        
    }else{
        [MBProgressHUD show:@"网络连接失败,请检查网络设置" icon:nil view:nil];
    }
}

#pragma mark 支付宝支付
-(void)payorder
{
//    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
//    [app zhifubaoArgumentHttp:self.order_code];
    [self zhifubaoArgumentHttp:self.order_code];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
//    [self zhifubaoPay];
}
-(void)zhifubaoPay{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSString *partner = [ud objectForKey:PAY_PARTNER];
    NSString *seller = [ud objectForKey:PAY_SELLER];
    NSString *privateKey = [ud objectForKey:PAY_PRIVATE_KEY];
    NSString *payurl = [ud objectForKey:PAY_URL];
    NSString *payPrice=[ud objectForKey:PAY_ALI_PRICE];
    
    [ud setObject:[NSString stringWithFormat:@"%@",payPrice] forKey:PAY_MONEY];

    MyLog(@"%@",payPrice);
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
    
    if(! payPrice)
    {
        payPrice=0;
    }
    
    order.amount = [NSString stringWithFormat:@"%.2f",payPrice.doubleValue]; //商品价格
    
    order.productName = @"衣蝠——好的衣服没那么贵"; //商品标题
    order.productDescription = @"衣蝠——好的衣服没那么贵"; //商品描述
    //    order.notifyURL =  @"http://183.61.166.16:9090/cloud-api/alipay/appNotify "; //回调URL
    
    if ([self.fromType isEqualToString:@"我要发红包"]) {
        order.notifyURL = [NSString stringWithFormat:@"%@alipay/appNotifyHb",payurl];
    } else {
        if(_urlcount.intValue > 1){
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
            MyLog(@"reslut = %@",resultDic);
            switch([[resultDic objectForKey:@"resultStatus"] integerValue]){
                case 9000: {//操作成功
                    [self buysuccess:nil];
                }
                    break;
                case 4000: {//系统异常
                    [self buyfail:nil];
                }
                    break;
                default:
                    [self buyfail:nil];
                    break;
            }
        }];
    }
}
#pragma mark 用自己的钱包支付
-(void)walletPayHttp:(NSString *)pwd
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSString *Password=[MyMD5 md5:pwd];
    NSString *url;
    if(_urlcount.intValue==1){
        url=[NSString stringWithFormat:@"%@order/walletPayOrder?version=%@&order_code=%@&token=%@&pwd=%@",[NSObject baseURLStr],VERSION,self.order_code,token,Password];
    }else if (_urlcount.intValue>=2){
        url=[NSString stringWithFormat:@"%@order/walletPayOrderList?version=%@&g_code=%@&token=%@&pwd=%@",[NSObject baseURLStr],VERSION,self.order_code,token,Password];
    }
    
    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        //responseObject walletPayOrderList is %@",responseObject);
        MyLog(@"shop_from = %@",_shopmodel.shop_from);
        
        if (responseObject!=nil) {
            responseObject = [NSDictionary changeType:responseObject];
            NSString *statu=responseObject[@"status"];
            NSString *pwdflag=responseObject[@"pwdflag"];
            NSString *message=responseObject[@"message"];
            if(pwdflag.intValue==0&&statu.intValue==1)//请求成功
            {
                message=@"恭喜你，支付成功！";
                [self postNotification];
                [YFShareModel getShareModelWithKey:nil type:StatisticalTypeSettlement tabType:StatisticalTabTypeCommodity success:nil];

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
                    successpay.shopprice=[NSString stringWithFormat:@"%f",self.SuccessViewMoney];
                    successpay.shopArray=self.sortArray;
                    successpay.orderCode = self.order_code;
                    successpay.p_type = self.p_type;
                    successpay.isTM = self.isTM;
                    successpay.shop_from = self.shop_from;
                    
                    if (self.is_roll) {//如果是组团订单  改变shop_from  为了支付成功后的跳转
                        successpay.shop_from=@"7";
                    }
                    
                    //何波加的 2016-11-25
                    if([self.fromType isEqualToString:@"活动商品成团下单"]||self.isFashionBuy)
                    {
                        successpay.shop_from = @"7";
                        self.fromType = @"";
                        if(!self.is_group)
                        {
                            [Signmanager SignManarer].task_Fightgroups = YES;
                        }
                    }
                    successpay.isNormolShop=self.isNormolShop;
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
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
                
                [NSTimer weakTimerWithTimeInterval:3 target:self selector:@selector(toback) userInfo:nil repeats:NO];
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
#pragma mark 设置支付密码成功
-(void)setpasswordsuccess:(NSNotification*)note
{
    TFPayPasswordView *view = [[TFPayPasswordView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [view.pwdField becomeFirstResponder];
    
    view.money = [NSString stringWithFormat:@"%.2f",_price];
    [self.view addSubview:view];
    [view returnPayResultSuccess:^(NSString *pwd) {
        if ([self.fromType isEqualToString:@"我要发红包"]) {
            [self httpMyWalletPayToRed:pwd];
        } else {
            [self walletPayHttp:pwd];
        }
        
    } withFail:^(NSString *error){
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
            responseObject = [NSDictionary changeType:responseObject];
            if ([responseObject[@"status"] intValue] == 1) {
                if ([responseObject[@"flag"] intValue] == 1) { //没设置
                    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"温馨提示" contentText:@"亲，你还没有设置支付密码请设置!" leftButtonTitle:@"取消" rightButtonTitle:@"确认"];
                    [alert show];
                    alert.leftBlock = ^() {
                        //left button clicked");//取消
                    };
                    alert.rightBlock = ^() {
                        //进入设置支付密码页面
                        TFSetPaymentPasswordViewController *tsvc= [[TFSetPaymentPasswordViewController alloc] init];
                        [self.navigationController pushViewController:tsvc animated:YES];
                        
                    };
                    alert.dismissBlock = ^() {
                        //Do something interesting after dismiss block");
                    };
                } else if ([responseObject[@"flag"] intValue] == 2) { //设置过了
                    TFPayPasswordView *view = [[TFPayPasswordView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                    [view.pwdField becomeFirstResponder];
                    view.money = [NSString stringWithFormat:@"%.2f",_price];
                    [self.view addSubview:view];
                    
                    [view returnPayResultSuccess:^(NSString *pwd) {
                        if ([self.fromType isEqualToString:@"我要发红包"]) {
                            [self httpMyWalletPayToRed:pwd];
                        } else {
                            [self walletPayHttp:pwd];
                        }
                    } withFail:^(NSString *error){
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
            responseObject = [NSDictionary changeType:responseObject];
            if ([responseObject[@"status"] intValue] == 1) {
                for (UIViewController *viewController in self.navigationController.viewControllers) {
                    if ([viewController isKindOfClass:[TFVoiceRedViewController class]]) {
                        [self.navigationController popToViewController:viewController animated:YES];
                    }
                }
                [self httpGetRedPacketShareLink];
            } else {
                NavgationbarView *nv = [[NavgationbarView alloc] init];
                [nv showLable:responseObject[@"message"] Controller:self];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark 获取红包分享链接
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
            responseObject = [NSDictionary changeType:responseObject];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
@implementation PayStyleItem

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
   
}

@end


@implementation PopBackgroundView

- (instancetype)init
{
    ESWeakSelf;
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);

        CGFloat W_backgrd = kScreenWidth- ZOOM6(85)*2;
        CGFloat H_backgrd = 180;
        
        CGFloat H_titleLab = ZOOM6(40);
        CGFloat H_btn = ZOOM6(80);
        NSString *string = @"你确定要放弃支付吗？未完成支付的订单会为你保留24小时，可在我的个人中心再次支付";
        
        CGSize sizeString = [string boundingRectWithSize:CGSizeMake(W_backgrd-ZOOM6(40)*2, 1000)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:ZOOM6(28)]}
                                                 context:nil].size;
        CGFloat H_contentLab = ceil(sizeString.height);
        H_backgrd = ZOOM6(60) + H_titleLab + ZOOM6(20) + H_contentLab + ZOOM6(60) + H_btn + ZOOM6(50);
        
//        MyLog(@"sizeString: %@", NSStringFromCGSize(sizeString));
        
        UIView *backgroundView = [UIView new];
        backgroundView.tag = 200;
        backgroundView.layer.masksToBounds = YES;
        backgroundView.layer.cornerRadius = ZOOM6(15);
        backgroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backgroundView];
        [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(__weakSelf);
            make.centerY.equalTo(__weakSelf);
            make.size.mas_equalTo(CGSizeMake(W_backgrd, H_backgrd));
        }];
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"温馨提示";
        titleLabel.textColor = RGBCOLOR_I(62, 62, 62);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
        [backgroundView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(backgroundView).offset(ZOOM6(60));
            make.left.right.equalTo(backgroundView);
            make.height.mas_equalTo(H_titleLab);
        }];
        
        UILabel *contentLabel = [UILabel new];
        contentLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
        contentLabel.text = string;
        contentLabel.textColor = RGBCOLOR_I(125, 125, 125);
        contentLabel.numberOfLines = 0;
        [backgroundView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backgroundView).offset(ZOOM6(40));
            make.right.equalTo(backgroundView).offset(-ZOOM6(40));
            make.top.equalTo(titleLabel.mas_bottom).offset(ZOOM6(20));
            make.height.mas_equalTo(H_contentLab);
        }];
        
        UIButton *canBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [canBtn setTitle:@"取消" forState:UIControlStateNormal];
        [canBtn setTitleColor:COLOR_ROSERED forState:UIControlStateNormal];
        [canBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        canBtn.layer.masksToBounds = YES;
        canBtn.layer.cornerRadius = ZOOM6(8);
        canBtn.layer.borderColor = [COLOR_ROSERED CGColor];
        canBtn.layer.borderWidth = 1;
        canBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
        [canBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [canBtn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateHighlighted];
        [backgroundView addSubview:canBtn];
        
        [canBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentLabel.mas_left);
            make.bottom.equalTo(backgroundView).offset(-ZOOM6(50));
            make.size.mas_equalTo(CGSizeMake(W_backgrd*0.5-ZOOM6(40)-ZOOM6(15), H_btn));
        }];
        
        UIButton *conBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [conBtn setTitle:@"取消" forState:UIControlStateNormal];
        conBtn.layer.masksToBounds = YES;
        conBtn.layer.cornerRadius = ZOOM6(8);
        [conBtn setTitle:@"确定" forState:UIControlStateNormal];
        [conBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        conBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
//        conBtn.backgroundColor = COLOR_ROSERED;
        [conBtn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateNormal];
        [conBtn setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_I(204, 20, 93)] forState:UIControlStateHighlighted];
        [backgroundView addSubview:conBtn];
        
        [conBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentLabel.mas_right);
            make.bottom.equalTo(backgroundView).offset(-ZOOM6(50));
            make.size.mas_equalTo(CGSizeMake(W_backgrd*0.5-ZOOM6(40)-ZOOM6(15), H_btn));
        }];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        backgroundView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        
        [canBtn addTarget:self action:@selector(canBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [conBtn addTarget:self action:@selector(conBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRClick:)];
        [self addGestureRecognizer:tapGR];
    }
    return self;
}


- (void)setCancelBlock:(CancelBlock)canBlock withConfirmBlock:(ConfirmBlock)conBlock
{
    self.cancelClickBlock = canBlock;
    self.confirmClickBlock = conBlock;
}

- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];

    UIView *backgroundView = (UIView *)[self viewWithTag:200];
    [UIView animateWithDuration:0.35 animations:^{
        self.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        backgroundView.transform = CGAffineTransformMakeScale(1, 1);
        backgroundView.alpha = 1;
    } completion:^(BOOL finish) {
        
    }];
    
}
- (void)tapGRClick:(UITapGestureRecognizer *)sender
{
    [self dismissAlert:YES];
}

- (void)canBtnClick:(UIButton *)sender
{
    if (self.cancelClickBlock) {
        self.cancelClickBlock();
    }
    [self dismissAlert:YES];
}

- (void)conBtnClick:(UIButton *)sender
{
    if (self.confirmClickBlock) {
        self.confirmClickBlock();
    }
    [self dismissAlert:YES];
}

- (void)dismissAlert:(BOOL)animation
{
    UIView *backgroundView = (UIView *)[self viewWithTag:200];
    if (animation) {
        [UIView animateWithDuration:0.35 animations:^{
            self.alpha = 0;
            backgroundView.transform = CGAffineTransformMakeScale(0.25, 0.25);
            backgroundView.alpha = 0;
        } completion:^(BOOL finish) {
            [backgroundView removeFromSuperview];
            [self removeFromSuperview];
        }];
    } else {
        [backgroundView removeFromSuperview];
        [self removeFromSuperview];
    }
}


@end
