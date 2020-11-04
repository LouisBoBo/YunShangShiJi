//
//  MyOrderViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/17.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyorderTableViewCell.h"
#import "OrderTableViewController.h"
#import "RefundAndReturnViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "IndianaOweViewController.h"
#import "ContactKefuViewController.h"
#import "OrderDetailViewController.h"
#import "NavgationbarView.h"
#import "LogisticsViewController.h"
#import "MoneyGoViewController.h"
#import "EvaluateViewController.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "MJRefresh.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AppDelegate.h"
#import "DShareManager.h"
#import "UPPayPlugin.h"
#import "Order.h"
#import "DataSigner.h"
#import "PopoverView.h"
#import "SellorderViewController.h"
#import "OrderTableViewCell.h"
#import "DXAlertView.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "payRequsestHandler.h"
#import "LoginViewController.h"
//#import "ChatViewController.h"
#import "RobotManager.h"
#import "TFPayPasswordView.h"
#import "VitalityTaskPopview.h"
//#import "PaystyleViewController.h"
#import "TFPayStyleViewController.h"
#import "ShareFreeLingViewController.h"
#import "BuySuccessViewController.h"
#import "PayFailedViewController.h"
#import "IntelligenceViewController.h"
#import "TFChangePaymentPasswordViewController.h"
#import "ContactKefuViewController.h"

#import "TFEvaluationOrderViewController.h"
#import "TFAdditionalEvaluationViewController.h"
#import "TFAccountDetailsViewController.h"
#include "TFSetPaymentPasswordViewController.h"
#import "NewShoppingCartViewController.h"
#import "TFMyWalletViewController.h"
#import "GroupBuyDetailVC.h"
#import "OneLuckdrawViewController.h"
#import "MessageKefuViewController.h"
#import "MakeMoneyViewController.h"
#import "HBmemberViewController.h"
#import "ShopDetailModel.h"
#import "SVProgressHUD.h"
#import "TFNoviceTaskView.h"
#import "TFDailyTaskView.h"
#import "DPAddShopVC.h"
#import "OneYuanModel.h"
#import "TaskSignModel.h"
#import "TypeShareModel.h"
#import "vipInfoModel.h"
#import "FinishTaskPopview.h"
#import "AddMemberCardViewController.h"

#define KBtn_width        200
#define KBtn_height       80
#define KXOffSet          (self.view.frame.size.width - KBtn_width) / 2
#define KYOffSet          80
#define segmentTag        99


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

@interface MyOrderViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,PopoverViewDelegate>

@property (strong, nonatomic)  UIPickerView *myPicker;
@property (strong, nonatomic)  UIView *pickerBgView;
@property (strong, nonatomic) UIView *maskView;
@property (nonatomic, strong)UIImageView *animationView;
@property (nonatomic,strong)UIView *backview;
@property (nonatomic, assign)int currentpage;
@property (nonatomic, copy) NSString * shopmessage;
@property (nonatomic, copy) NSString * maxvipName;
@property (nonatomic, strong) FinishTaskPopview *bonusview;

@end

@implementation MyOrderViewController
{
    
    NSArray *_titleArr;//几个状态
    UILabel *_statelab;
    NSString *_orderstate;//记录按钮状态
    UITableView *_MytableView;//商品列表
    UITableView *_MySellTableView;
    NSString *_pageCount;//商品总页数
    ShopDetailModel *_Ordermodel;//选取的订单
    
    UITableView *_MytableView1;
    UITableView *_MytableView2;
    
    NSMutableArray *_dataArray;//数据源
    NSMutableArray *_sellDataArray;
    UIScrollView *_scrollview;//滑动视图
    NSMutableArray *_viewArr;//保存有几个视图
    NSMutableArray *_tableArr;
    
    UIAlertView* mAlert;
    NSMutableData* mData;
    NSArray* titlesArray;
    NSString *_titlestring;//记录当前是买单还是卖单
    NSInteger _statuetag;
    UIButton *_SelectBtn;//选择订单按键
    NSMutableArray *_selectArray;
    NSInteger _Ordernumber;//记录选择订单的数量
    CGFloat _OrderMoney;
    NSInteger tempNum;
    UIView *_FootView;//全选
    BOOL _select;//全选按钮是否选中
    
    UIButton *_allpaybtn;//结算
    UILabel *_allmoneylable;
    
    NSMutableString *_orderString;//订单编号字符串
    NSArray *pickerArray;
    long indextag;
    NSString *_orderPrice;
    NSInteger _time;
    NSMutableArray *_selectShopPayArray;//选择要支付的商品
    UIButton *lastBtn;
    UISegmentedControl *subSegment;
    
    NSInteger _sharefailnumber;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _time = 0;
    _pageCount= @"1";
    _dataArray=[NSMutableArray array];
    _viewArr=[NSMutableArray array];
    _tableArr=[NSMutableArray array];
    _selectArray=[NSMutableArray array];
    _orderString=[NSMutableString string];
    _sellDataArray=[NSMutableArray array];
    _selectShopPayArray=[NSMutableArray array];
    
    _oldstatus1=@"0";
    _oldstatus2=@"0";
    
    _sharefailnumber = 0;
    
    _titlestring=@"已买商品";
    _titleArr=@[@"全部",@"待付款",@"免费领",@"待收货",@"待评价"];
    pickerArray = [NSArray arrayWithObjects:@"卖家缺货",@"信息填写错误，重新拍",@"我不想买了",@"同城见面交易",@"拍错了",@"其它原因", nil];
    [self creatPickerView];
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(46, 0, headview.frame.size.width-46*2, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text= @"我的订单";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment= NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    /*
    //监听支付通知
    //监听支付成功回调通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buysuccess:) name:@"buysuccess" object:nil];
     */
    
//    //监听分享成功通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sharesuccess:) name:@"MyOrdersharesuccess" object:nil];

    //监听智能分享成功通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sharesuccess:) name:@"Intelligencesharesuccess" object:nil];
    
    //监听智能分享失败通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sharefail:) name:@"Intelligencesharefail" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView) name:@"RefreshOrder" object:nil];
    
    //监听疯抢成功通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fightSuccess:) name:@"fightSuccess" object:nil];

    //头上按钮
//    [self creatnavView];
    [self creatBackview];
    if (!_Distribution) {
        [self creatFootview];
    }
    [self creatHeadView];
    [self creatTableview];
    [self refreshView];
    
    //获取最高会员等级
    [vipInfoModel addUserVipOrderSuccess:^(id data) {
        vipInfoModel *model = data;
        self.maxvipName = @"";
        NSInteger isVip = model.isVip ? model.isVip:0;
        if(isVip !=0)
        {
            NSInteger maxVipType = model.maxType?model.maxType:999;
            switch (maxVipType) {
                case 4:
                    self.maxvipName = @"钻石会员";
                    break;
                case 5:
                    self.maxvipName = @"皇冠会员";
                    break;
                case 6:
                    self.maxvipName = @"至尊会员";
                    break;
                default:
                    break;
            }
            [[NSUserDefaults standardUserDefaults] setObject:self.maxvipName forKey:@"ordermaxvipName"];
        }
    }];
    
    
    //首单免费领成功提示框
    if(self.isfirst_freeling)
    {
        [self setTaskPopMindView:OrderFreeling_paySuccess Value:nil Title:nil Rewardvalue:nil Rewardnum:0];
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
        if(type == OrderFreeling_paySuccess)//接通客服
        {
            ContactKefuViewController *contact = [[ContactKefuViewController alloc]init];
            contact.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:contact animated:YES];
        }
    };
    self.bonusview.balanceHideMindBlock = ^(NSInteger tag){
        [weakSelf.bonusview remindViewHiden];
    };
    
    [self.view addSubview:self.bonusview];
}
-(void)refreshView
{
    _Ordernumber=0;_OrderMoney=0;
    _allmoneylable.text=[NSString stringWithFormat:@"共%ld个订单\n总金额%.2f元",(long)_Ordernumber,_OrderMoney];
    
    UIButton *btn = (UIButton *)[_FootView viewWithTag:9999];
    btn.selected = NO;

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
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self.isbaoyou)
    {
        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        [mentionview showLable:@"亲,你有包邮商品未付款" Controller:self];
        
        self.isbaoyou = NO;
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
    
}


-(void)creatSelectData
{
    [_selectArray removeAllObjects];
    for(int i=0; i<_dataArray.count;i++){
        [_selectArray addObject:@"0"];
    }
}
- (void)fightSuccess:(NSNotification*)note
{
    _currentpage = 1;
    [self requestHttp:_currentpage];
}
#pragma mark ********************** 数据处理 ***********************
#pragma mark 网络请求(买单)
-(void)requestHttp:(NSInteger)page
{
    if(![self.status1 isEqualToString:self.oldstatus1]){
        self.oldstatus1=self.status1;
    }
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];

    NSString *cutpage=[NSString stringWithFormat:@"%ld",(long)page];
    NSString *url;
    if (_Distribution) {
        url=[NSString stringWithFormat:@"%@merchantAlliance/seljuniorUserOrder?version=%@&token=%@&page=%@&status=%@&order=desc&user_id=%@",[NSObject baseURLStr],VERSION,token,cutpage,self.oldstatus1,_user_id];
    }else
        url = [NSString stringWithFormat:@"%@order/getBuyOrder?version=%@&token=%@&page=%@&status=%@&order=desc",[NSObject baseURLStr],VERSION,token,cutpage,self.oldstatus1];

    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] CreateAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        [_MytableView footerEndRefreshing];   //停止刷新
        [MBProgressHUD hideHUDForView:self.view];
        
        _MytableView.hidden=NO;
        MyLog("responseObject is %@",responseObject);
        
        if (responseObject!=nil && [_titlestring isEqualToString:@"已买商品"]) {
            
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            _pageCount=responseObject[@"pageCount"];
            
            if(str.intValue==1){
                if (page == 1) { //上拉
                    [_dataArray removeAllObjects];
                    UIButton *btn = [_FootView viewWithTag:9999];
                    btn.selected=NO;
                    for(int i=0;i<_selectArray.count;i++){
                        _selectArray[i]=@"0";
                    }
                    _Ordernumber=0;_OrderMoney=0;
                    _allmoneylable.text=[NSString stringWithFormat:@"共%ld个订单\n总金额%.2f元",(long)_Ordernumber,_OrderMoney];
            
                }
                
                NSArray *arr=responseObject[@"orders"];
                if(arr.count>0){
                    for(NSDictionary *dic in arr){
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
                        model.requestNow_time=responseObject[@"now"];
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
                        model.roll_name=[NSString stringWithFormat:@"%@",dic[@"roll_name"]];
                        
                        if([dic[@"order_price"] isEqual:[NSNull null]]||!dic[@"order_price"])
                            model.order_price=@"0";
                        if([dic[@"tfn_money"] isEqual:[NSNull null]]||!dic[@"tfn_money"])
                            model.tfn_money=@"0";
                        
                        if(![dic[@"page4_shop"] isEqual:[NSNull null]])
                        {
                            model.isTM = [NSString stringWithFormat:@"%@",dic[@"page4_shop"]];
                        }

                        model.isTM = [NSString stringWithFormat:@"%@",dic[@"isTM"]];
                        model.order_price=dic[@"pay_money"];
                        model.new_free = [[NSString stringWithFormat:@"%@",dic[@"new_free"]]integerValue];
                        


                        model.pay_status=[NSString stringWithFormat:@"%@",dic[@"pay_status"]];
                        
                        model.whether_prize = [NSString stringWithFormat:@"%@",dic[@"whether_prize"]];
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
                            model.shop_se_price=dicc[@"shop_price"];
                            model.shop_name=dicc[@"shop_name"];
                            shopmodel.shop_size=dicc[@"size"];
                            shopmodel.supp_id=dicc[@"supp_id"];
                            
                            shopmodel.lasttime=dic[@"last_time"];
                            shopmodel.requestNow_time=responseObject[@"now"];

                            shopmodel.orderShopStatus=dicc[@"status"];
                            shopmodel.change=dicc[@"change"];
                            shopmodel.status=dic[@"status"];
                            
                            model.orderShopStatus=dicc[@"status"];
                            model.change=dicc[@"change"];
                            model.status=dic[@"status"];
                            shopmodel.new_free = [[NSString stringWithFormat:@"%@",dic[@"new_free"]]integerValue];
                            shopmodel.whether_prize = [NSString stringWithFormat:@"%@",dic[@"whether_prize"]];
                            shopmodel.roll_name=[NSString stringWithFormat:@"%@",dic[@"roll_name"]];
                            
                            shopmodel.pay_status=[NSString stringWithFormat:@"%@",dic[@"pay_status"]];
                            shopmodel.original_price=[NSString stringWithFormat:@"%@",dicc[@"original_price"]];
                            
                            if(![dic[@"page4_shop"] isEqual:[NSNull null]])
                            {
                                shopmodel.isTM = [NSString stringWithFormat:@"%@",dic[@"page4_shop"]];
                            }
                            shopmodel.isTM = [NSString stringWithFormat:@"%@",dic[@"isTM"]];
                            [model.shopsArray addObject:shopmodel];
                            
                            model.shop_code=shopmodel.shop_code;
                            
                        }
                        
                        model.app_shop_group_price = model.order_price;
                        
                        [_dataArray addObject:model];
                    }
                    _backview.hidden=YES;
                    
                    if(self.status1.intValue==1 && [_titlestring isEqualToString:@"已买商品"] && !_Distribution) {
                        _MytableView.frame= CGRectMake(0, 94+ZOOM(30)*2, kApplicationWidth, kApplicationHeight-94-ZOOM(30)*2-50+kUnderStatusBarStartY);
                        _FootView.hidden = NO;
                    }
                    [self creatSelectData];             //记录选择订单的数据源
                    [_MytableView reloadData];
                }
                if (_dataArray.count == 0) {
                    UIView *animationView=(UIView*)[self.view viewWithTag:7171];
                    if (animationView==nil) {
                        _backview.hidden=NO;
                        [self.view bringSubviewToFront:_backview];
                    }
                    _FootView.hidden=YES;
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
                
            }else{
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [_MytableView footerEndRefreshing];   //停止刷新
        
        [MBProgressHUD hideHUDForView:self.view];
        
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    
    
    
}
-(int)compareWithAnotherDay:(ShopDetailModel *)model
{
     return model.lasttime.doubleValue<=model.requestNow_time.doubleValue?-1:0;
    
}
#pragma mark 网络请求(卖单)
-(void)requestSellHttp:(NSInteger)page
{
    if(self.status2 !=nil){
        if(![self.status2 isEqualToString:self.oldstatus2]){
            self.oldstatus2=self.status2;
        }
    }
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *storecode=[user objectForKey:STORE_CODE];
    
    NSString *cutpage=[NSString stringWithFormat:@"%zd",page];
    NSString *url;
    if (_Distribution) {
        url=[NSString stringWithFormat:@"%@order/sellOrderManage?version=%@&token=%@&page=%@&store_code=%@&status=%@&order=desc",[NSObject baseURLStr],VERSION,token,cutpage,_user_id,self.oldstatus2];
    }else
        url=[NSString stringWithFormat:@"%@order/sellOrderManage?version=%@&token=%@&page=%@&store_code=%@&status=%@&order=desc",[NSObject baseURLStr],VERSION,token,cutpage,storecode,self.oldstatus2];
    
    NSString *URL=[MyMD5 authkey:url];
    
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [_MytableView footerEndRefreshing];   //停止刷新
        [MBProgressHUD hideHUDForView:self.view];
        
        MyLog(@"responseObject = %@",responseObject);
        
        if (responseObject!=nil && [_titlestring isEqualToString:@"已卖商品"]) {
            //responseObject = [NSDictionary changeType:responseObject];
            _MytableView.hidden=NO;
            //responseObject is %@",responseObject);
            NSString *str=responseObject[@"status"];
//            NSString *message=responseObject[@"message"];
            _pageCount=responseObject[@"pageCount"];
            
            if(str.intValue==1){
                if (page == 1) { //上拉
                    [_sellDataArray removeAllObjects];
                }
                
                NSArray *arr=responseObject[@"orders"];
                if(arr.count>0)
                {
                    for(NSDictionary *dic in arr)
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
                        
                        model.bak=dic[@"bak"];
                        model.shop_from=dic[@"shop_from"];
                        model.postage=dic[@"postage"];
                        model.postcode=dic[@"postcode"];
                        
                        NSArray *brr=dic[@"orderShops"];
                        for(NSDictionary *dicc in brr)
                        {
                            ShopDetailModel   *shopmodel=[[ShopDetailModel alloc]init];
                            
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
                            
                            shopmodel.orderShopStatus=dicc[@"status"];
                            shopmodel.change=dicc[@"change"];
                            shopmodel.status=dic[@"status"];
                            shopmodel.lasttime=dic[@"last_time"];

                            model.orderShopStatus=dicc[@"status"];
                            model.change=dicc[@"change"];
                            model.status=dic[@"status"];
                            
                            [model.shopsArray addObject:shopmodel];
                            
                        }
                        
                        [_sellDataArray addObject:model];
                    }
                    _backview.hidden=YES;
                    [_MytableView reloadData];
                }else{
                    if (_sellDataArray.count == 0) {
                        [self.view bringSubviewToFront:_backview];
                        _backview.hidden=NO;
                        _FootView.hidden =YES;
                    }
                }
            }else if(str.intValue == 10030){//没登录状态
                LoginViewController *login=[[LoginViewController alloc]init];
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
            }else{
//                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
//                [mentionview showLable:message Controller:self];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_MytableView footerEndRefreshing];   //停止刷新
        
        [MBProgressHUD hideHUDForView:self.view];
        
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
    }];
    
    
}

//获取订单商品的二级类目
- (void)getShopTypeDataFromShopcode:(NSString*)shopcode Price:(CGFloat)shop_price Wxh:(NSString*)servicewxh
{
    
    kWeakSelf(self);
    [TypeShareModel getTypeCodeWithShop_code:shopcode success:^(TypeShareModel *data) {
        
        if(data.status == 1)
        {
            [DataManager sharedManager].type_data = data.type2;
            
            SqliteManager *manager = [SqliteManager sharedManager];
            TypeTagItem *item = [manager getSuppLabelItemForId:data.supp_label_id];
            
            NSString *sqsupp_label = item != nil?item.class_name:@"";
            
            weakself.shopmessage = [NSString stringWithFormat:@"价值%.2f元的%@%@",shop_price,sqsupp_label,data.type2];
        }
        
        MessageKefuViewController * messagevc = [[MessageKefuViewController alloc]init];
        messagevc.weixinNum = servicewxh;
        messagevc.shopmessage = weakself.shopmessage;
        [weakself.navigationController pushViewController:messagevc animated:YES];
    }];
    
}
#pragma mark 申请发货获取微信号
-(void)applicationforshipmentHttp:(ShopDetailModel*)shopModel
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@order/applySendOrderTips?version=%@&token=%@&bak=%@",[NSObject baseURLStr],VERSION,token,shopModel.bak];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        if (responseObject!=nil) {
            NSString *servicewxh = [NSString stringWithFormat:@"%@",responseObject[@"wxh"]];
            [self getShopTypeDataFromShopcode:shopModel.shop_code Price:shopModel.shop_se_price.floatValue Wxh:servicewxh];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
}
#pragma mark 删除订单
-(void)deleteHttp:(NSString*)ordercoder Index:(NSInteger)index
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@order/delOrder?version=%@&token=%@&order_code=%@",[NSObject baseURLStr],VERSION,token,ordercoder];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        if (responseObject!=nil) {
            //responseObject = [NSDictionary changeType:responseObject];
            
            NSString *str=responseObject[@"status"];
//            NSString *message=responseObject[@"message"];
            NSString *message;
            if(str.intValue==1)
            {
                message=@"订单删除成功";
                //            [_dataArray removeAllObjects];
                _currentpage = 1;
                [self requestHttp:_currentpage];
            }else{
                
                message=@"订单删除失败";
            }
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    
    
}

#pragma mark 确认收货
-(void)ShouhuoHttp:(NSString*)ordercode withPwd:(NSString*)pwd Index:(NSInteger)index
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *passwd=[MyMD5 md5:pwd];
    
    NSString *url=[NSString stringWithFormat:@"%@order/affirmOrder?version=%@&token=%@&order_code=%@&pwd=%@",[NSObject baseURLStr],VERSION,token,ordercode,passwd];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        if (responseObject!=nil) {
            //responseObject = [NSDictionary changeType:responseObject];
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(str.intValue==1)
            {
//                message=@"收货成功";
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
                }

                _currentpage = 1;
                [self requestHttp:_currentpage];
                
            }
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
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

#pragma mark 取消订单
-(void)CancelHttp:(ShopDetailModel *)model Index:(NSInteger)index Explain:(NSString *)explain
{
    NSString *ordercoder=model.order_code;
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    //    NSString *url=[NSString stringWithFormat:@"%@order/escOrder?version=v1.0&token=%@&order_code=%@end_explain=%@",[NSObject baseURLStr],token,ordercoder,explain];
    NSString *url;
    if (model.shop_from.intValue==4||model.shop_from.intValue==6) {
        url=[NSString stringWithFormat:@"%@treasures/escOrder?version=%@&token=%@&order_code=%@&end_explain=%@",[NSObject baseURLStr],VERSION,token,ordercoder,explain];
    }else
        url=[NSString stringWithFormat:@"%@order/escOrder?version=%@&token=%@&order_code=%@",[NSObject baseURLStr],VERSION,token,ordercoder];
    
    NSString *URL=[MyMD5 authkey:url];
    
//    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [MBProgressHUD showHUDAddTo:self.view  animated:YES];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        if (responseObject!=nil) {
            //responseObject = [NSDictionary changeType:responseObject];
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(str.intValue==1){
                message=@"取消订单成功";
                _currentpage = 1;
                [self requestHttp:_currentpage];
                
            }
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
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

#pragma mark 查看物流
-(void)LogisticsHttp:(NSString*)ordercoder Index:(NSInteger)index
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    ShopDetailModel *model;
    if ([_titlestring isEqualToString:@"已买商品"]) {
        model=_dataArray[index];
    }else{
        model=_sellDataArray[index];
    }
    NSString *shop_code=[NSString stringWithFormat:@"%@",model.shop_code];
    NSString *url=[NSString stringWithFormat:@"%@order/selLogistics?version=%@&token=%@&order_code=%@&shop_code=%@",[NSObject baseURLStr],VERSION,token,ordercoder,shop_code];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];

        if (responseObject!=nil) {
            //responseObject = [NSDictionary changeType:responseObject];
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(str.intValue==1){
                message=@"查看物流成功";
            }
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
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

#pragma mark 申请关闭拼团
-(void)CoseFightHttp:(NSString*)rollcode Order_code:(NSString*)order_code ShopModel:(ShopDetailModel*)model
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
   
    NSString *url=[NSString stringWithFormat:@"%@order/addOrderFake?version=%@&token=%@&order_code=%@&roll_code=%@",[NSObject baseURLStr],VERSION,token,order_code,rollcode];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject!=nil) {
            //responseObject = [NSDictionary changeType:responseObject];
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            NSString *userName = [NSString stringWithFormat:@"%@",responseObject[@"userName"]];
            if(str.intValue==1){//参团成功
                _currentpage = 1;
                [self requestHttp:_currentpage];
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setValue:userName forKey:@"Fight_userName"];
                
                [NSThread sleepForTimeInterval:2.0];
                [self setVitalityPopMindView:Robot_Fight_luckSuccess Rollcode:rollcode Ordercode:order_code ShopModel:model];
            }else{
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
#pragma mark 延长收货
-(void)ExtendHttp:(NSString*)ordercoder
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@order/extension?version=%@&token=%@&order_code=%@",[NSObject baseURLStr],VERSION,token,ordercoder];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        if (responseObject!=nil) {
            //responseObject = [NSDictionary changeType:responseObject];
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(str.intValue==1){
                message=@"延长收货成功";
                _currentpage = 1;
                [self requestHttp:_currentpage];
            }
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
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
#pragma mark 关闭订单
-(void)closeOrder:(NSString*)ordercoder
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@order/closeTemporaryRollOrder?version=%@&token=%@&order_code=%@",[NSObject baseURLStr],VERSION,token,ordercoder];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
    
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
        
            if(str.intValue==1)
            {
                message=@"关闭订单成功";
                _currentpage = 1;
                [self requestHttp:_currentpage];
            }
            
            [MBProgressHUD show:message icon:nil view:self.view];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
    }];
}
#pragma mark 提醒发货
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
        
        //responseObject is %@",responseObject);
        
        if (responseObject!=nil) {
            //responseObject = [NSDictionary changeType:responseObject];
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            NSString *flag = responseObject[@"falg"];
            
            if(str.intValue==1)
            {
                message=@"提醒发货成功";
                if (flag.intValue==2) {
                    message=@"亲，提醒太频繁了，不要那么着急嘛";
                }
            }else{
                
                //                message=@"提醒发货失败";
                
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
    }];
}
#pragma mark 生成组合订单编号
-(void)payOrdersHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString * url=[NSString stringWithFormat:@"%@order/payOrders?version=%@&order_codes=%@&token=%@",[NSObject baseURLStr],VERSION,self.order_code,token];
    
    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        
        if (responseObject!=nil) {
           // responseObject = [NSDictionary changeType:responseObject];
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            if(statu.intValue==1)//请求成功
            {
                self.order_code=nil;
                self.order_code=responseObject[@"g_code"];
                //%@",self.order_code);
                tempNum = _Ordernumber;
                
                NSMutableArray *orderArray=[NSMutableArray array];
                
                
                for(int i=0 ;i<_selectShopPayArray.count;i++){
                    ShopDetailModel* model=_selectShopPayArray[i];

//                    if (model.shop_from.intValue!=1) {
                        [orderArray addObject:model];
//                    }
                }
                
                __block  BOOL isFashionBuy=NO; __block NSInteger is_roll=0;
                [_selectShopPayArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    ShopDetailModel* model=obj;
                    if (model.is_roll) {
                        is_roll=model.is_roll;
                    }
                    if(model.is_roll==1||model.is_roll==3||model.is_roll==4) {
                        isFashionBuy=YES;
                        *stop=YES;
                    }
                }];
                //                [[NSUserDefaults standardUserDefaults]setObject:indianaArray forKey:@"indianaArray"];
                //                PaystyleViewController *paystyle=[[PaystyleViewController alloc]init];
                //                paystyle.price = [NSString stringWithFormat:@"%@", responseObject[@"orderPrice"]];
                TFPayStyleViewController *paystyle=[[TFPayStyleViewController alloc]init];
                paystyle.price = [responseObject[@"orderPrice"]floatValue];
                paystyle.sortArray=orderArray;
                
                paystyle.order_code=_order_code;
                paystyle.urlcount=[NSString stringWithFormat:@"%lu",(unsigned long)_selectShopPayArray.count];
                paystyle.requestOrderDetail=1;
                _orderPrice=[NSString stringWithFormat:@"¥%f",paystyle.price];
                paystyle.fromType=@"订单组合付款";
                paystyle.is_roll=is_roll;
                paystyle.isFashionBuy=isFashionBuy;
                //            paystyle.delegate=self;
                [self.navigationController pushViewController:paystyle animated:YES];
                
                
            }else{
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
            }   
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
    }];
    
    
}



#pragma mark 聊天
-(void)Message:(NSString*)suppid{
    if([_titlestring isEqualToString:@"已买商品"])    {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        suppid = [user objectForKey:PTEID];
        
    }
    
    // begin 赵官林 2016.5.26（功能：联系客服）
    // [self messageWithSuppid:suppid title:nil model:nil detailType:nil imageurl:nil];
    // end
    
    ContactKefuViewController *contact = [[ContactKefuViewController alloc]init];
    contact.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:contact animated:YES];
    
}

#pragma mark 检查是否设置过支付密码
- (void)httpIsSetPwd:(NSString *)ordercoder withOrderPrice:(NSString *)orderprice
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
            //responseObject = [NSDictionary changeType:responseObject];
            if ([responseObject[@"status"] intValue] == 1) {
                
                if ([responseObject[@"flag"] intValue] == 1) { //没设置
                    
                    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"温馨提示" contentText:@"亲，你还没有设置支付密码请设置!" leftButtonTitle:@"取消" rightButtonTitle:@"确认"];
                    [alert show];
                    alert.leftBlock = ^() {
                        
                    };
                    alert.rightBlock = ^() {
                        
                        TFSetPaymentPasswordViewController *tsvc= [[TFSetPaymentPasswordViewController alloc] init];
                        [self.navigationController pushViewController:tsvc animated:YES];
                        
                    };
                    alert.dismissBlock = ^() {
                        
                    };
                } else if ([responseObject[@"flag"] intValue] == 2) { //设置过了
                    [self payPassWordView:ordercoder withOrderPrice:orderprice];
                }
                
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
}
-(void)payPassWordView:(NSString *)ordercoder withOrderPrice:(NSString *)orderprice
{
    TFPayPasswordView *view = [[TFPayPasswordView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    view.money = [NSString stringWithFormat:@"%.2f",orderprice.floatValue];
    [self.view addSubview:view];
    
    
    [view returnPayResultSuccess:^(NSString *pwd) {
        
        //密码验证成功");
        [self ShouhuoHttp:ordercoder withPwd:pwd Index:0];
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
#pragma mark ***********************  UI 界面 **********************

#pragma mark 没有订单的相关界面
-(void)creatBackview
{
    //没有订单的相关界面
    _backview=[[UIView alloc]initWithFrame:CGRectMake(0,94+ZOOM(30)*2, kApplicationWidth, kApplicationHeight)];
    _backview.tag=8789;
    _backview.backgroundColor = [UIColor whiteColor];

    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(kApplicationWidth/2-40, 20, 80, 150)];
    if (kScreenHeight>=568) {
        imageview.frame = CGRectMake(kApplicationWidth/2-40, kScreenHeight/4-75, 80, 150);
    }
    imageview.image=[UIImage imageNamed:@"组-32"];
    [_backview addSubview:imageview];
    
    for(int i=0;i<2; i++){
        UILabel *marklable=[[UILabel alloc]initWithFrame:CGRectMake(0, imageview.frame.origin.y+imageview.frame.size.height+ 20 +40*i, _backview.frame.size.width, 40)];
        marklable.textAlignment=NSTextAlignmentCenter;
        if(i==0){
            marklable.text=@"你还没有相关订单";
        }else{
            marklable.text=@"可以去看看有哪些想买的";
            marklable.textColor=kTextGreyColor;
        }
        [_backview addSubview:marklable];
    }
    
    UIButton *shoppintbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    shoppintbtn.frame=CGRectMake(50, imageview.frame.origin.y+imageview.frame.size.height+120, kApplicationWidth-100, 40);
    [shoppintbtn setTitle:@"随便逛逛" forState:UIControlStateNormal];
    [shoppintbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shoppintbtn.layer.borderWidth=1;
    shoppintbtn.layer.cornerRadius=5;
    [shoppintbtn addTarget:self action:@selector(shoppinggo:) forControlEvents:UIControlEventTouchUpInside];
    [_backview addSubview:shoppintbtn];

    [self.view addSubview:_backview];
    
}

/*
-(void)creatnavView
{
    NSArray *titlearr=@[@"已买商品",@"已卖商品"];
    UISegmentedControl *segment=[[UISegmentedControl alloc]initWithItems:titlearr];
    segment.frame=CGRectMake((kApplicationWidth-160)/2, 25, 160, 30);
    segment.selectedSegmentIndex = 0;
    segment.tag = segmentTag;
    segment.layer.borderWidth = 1.5;
    segment.layer.borderColor = kTitleColor.CGColor;
    segment.layer.masksToBounds = YES;
    segment.layer.cornerRadius = 15;
    [segment setTintColor:[UIColor blackColor]];
    [segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];

    [self.view addSubview:segment];

}
*/

-(void)creatHeadView
{
    UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 64, kApplicationWidth, 30+ZOOM(30)*2)];
    headview.tag=9999;
    [self.view addSubview:headview];

    subSegment = [[UISegmentedControl alloc]initWithItems:_titleArr];
    subSegment.frame=CGRectMake(0, ZOOM(30), kApplicationWidth, 30);
    
    [subSegment setContentOffset:CGSizeMake(-6, 0) forSegmentAtIndex:1];
    [subSegment setContentOffset:CGSizeMake(-5, 0) forSegmentAtIndex:2];
    [subSegment setContentOffset:CGSizeMake(-4, 0) forSegmentAtIndex:3];

    
    subSegment.tintColor = [UIColor clearColor];//去掉颜色,现在整个segment都看不见
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(50)],
                                             NSForegroundColorAttributeName:tarbarrossred };
    [subSegment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(50)],
                                               NSForegroundColorAttributeName: [UIColor blackColor] };
    [subSegment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    subSegment.selectedSegmentIndex=(self.tag+1)%1000;
    [subSegment addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventValueChanged];
    [headview addSubview:subSegment];
    
    if (@available(iOS 13, *)) {

           UIColor *tintColor = [subSegment tintColor];
           UIImage *tintColorImage = [self imageWithColor:tintColor];
           [subSegment setBackgroundImage:[self imageWithColor:subSegment.backgroundColor ? subSegment.backgroundColor : [UIColor clearColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
           [subSegment setBackgroundImage:tintColorImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
           
        [subSegment setBackgroundImage:[self imageWithColor:[[UIColor clearColor] colorWithAlphaComponent:0.0]] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
           
        [subSegment setBackgroundImage:tintColorImage forState:UIControlStateSelected|UIControlStateSelected barMetrics:UIBarMetricsDefault];
           
        [subSegment setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:ZOOM(50)]} forState:UIControlStateNormal];
        
        [subSegment setDividerImage:tintColorImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
        subSegment.layer.borderWidth = 0;
        subSegment.selectedSegmentTintColor = tintColor;
    }

}

- (UIImage *)imageWithColor: (UIColor *)color {

    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);

    UIGraphicsBeginImageContext(rect.size);

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);

    CGContextFillRect(context, rect);

    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return theImage;

}

-(void)creatTableview
{
    _MytableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 94+ZOOM(30)*2, kApplicationWidth, kApplicationHeight-94-ZOOM(30)*2+kUnderStatusBarStartY) style:UITableViewStyleGrouped];
    _MytableView.backgroundColor = [UIColor whiteColor];
    _MytableView.dataSource=self;
    _MytableView.delegate=self;
    _MytableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [_MytableView registerNib:[UINib nibWithNibName:@"OrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_MytableView];

    
    kSelfWeak;
    
    [_MytableView addHeaderWithCallback:^{
        kSelfStrong;
        UISegmentedControl *segment=(UISegmentedControl *)[weakSelf.view viewWithTag:segmentTag];
        switch (segment.selectedSegmentIndex) {
            case 0:
            {
                weakSelf.currentpage = 1;
                [weakSelf requestHttp:weakSelf.currentpage];
                [strongSelf -> _MytableView headerEndRefreshing];
            }
                break;
            case 1:
            {
                weakSelf.currentpage=1;
                [weakSelf requestSellHttp:weakSelf.currentpage];
                [strongSelf->_MytableView headerEndRefreshing];
            }
                break;
        }
        
    }];
    
    
    [_MytableView addFooterWithCallback:^{
        UISegmentedControl *segment=(UISegmentedControl *)[weakSelf.view viewWithTag:segmentTag];
        switch (segment.selectedSegmentIndex) {
            case 0:
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    weakSelf.currentpage++;
                    [weakSelf requestHttp:weakSelf.currentpage];
                });
            }
                break;
            case 1:
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    weakSelf.currentpage++;
                    [weakSelf requestSellHttp:weakSelf.currentpage];
                });
            }
                break;
        }
    }];
    
    
}



-(void)creatFootview
{
    _FootView=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 50)];
    _FootView.tag=5757;
    _FootView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_FootView];
    
    UILabel *linelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 0.5)];
    linelable.backgroundColor=kbackgrayColor;
    [_FootView addSubview:linelable];
    
    //全选按钮
    _select=NO;
    UIButton *allselectbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    allselectbtn.frame=CGRectMake(0, 50/2-ZOOM(70)/2, 80+ZOOM(62), ZOOM(70));
    [allselectbtn setTitle:@"全选" forState:UIControlStateNormal];
    [allselectbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    allselectbtn.clipsToBounds=YES;
    allselectbtn.tag=9999;
    allselectbtn.layer.borderColor=kbackgrayColor.CGColor;
    [allselectbtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [allselectbtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    allselectbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [allselectbtn addTarget:self action:@selector(selectclick:) forControlEvents:UIControlEventTouchUpInside];
    allselectbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(46)];
    [_FootView addSubview:allselectbtn];
    
    
    //结算
    _allpaybtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _allpaybtn.frame=CGRectMake(kApplicationWidth-80-ZOOM(42), 5, 80, 40);
    _allpaybtn.backgroundColor=tarbarrossred;
    [_allpaybtn setTitle:[NSString stringWithFormat:@"批量付款"] forState:UIControlStateNormal];
    _allpaybtn.tintColor=[UIColor whiteColor];
//    _allpaybtn.layer.cornerRadius=5;
    [_allpaybtn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    _allpaybtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(46)];
    [_FootView addSubview:_allpaybtn];
    
    _allmoneylable=[[UILabel alloc]initWithFrame:CGRectMake(allselectbtn.frame.origin.x+allselectbtn.frame.size.width+10,0, 140, 50)];
    _allmoneylable.text=[NSString stringWithFormat:@"共%ld个订单\n总金额%.2f元",(long)_Ordernumber,_OrderMoney];
    _allmoneylable.font=[UIFont systemFontOfSize:ZOOM(46)];
    _allmoneylable.textColor=tarbarrossred;
    _allmoneylable.numberOfLines=2;
    _allmoneylable.textAlignment=NSTextAlignmentLeft;
    [_FootView addSubview:_allmoneylable];
    
    
}

#pragma mark **********************     按钮事件    ***********************
#pragma mark 二级按钮监听事件
-(void)BtnClick:(UISegmentedControl *)sender
{

    _currentpage=1;

    lastBtn.selected=NO;
    self.status1=[NSString stringWithFormat:@"%ld",(long)sender.selectedSegmentIndex];
    self.status2=[NSString stringWithFormat:@"%ld",(long)sender.selectedSegmentIndex];
    _MytableView.hidden = YES;
    _backview.hidden=YES;
    _FootView.hidden=YES;
    
    if ([_titlestring isEqualToString:@"已买商品"]) {
        [self requestHttp:_currentpage];
    }else
        [self requestSellHttp:_currentpage];
    
    if(self.status1.intValue==1 && [_titlestring isEqualToString:@"已买商品"] && !_Distribution){
        _MytableView.frame= CGRectMake(0, 94+ZOOM(30)*2, kApplicationWidth, kApplicationHeight-94-ZOOM(30)*2-50+kUnderStatusBarStartY);
        _Ordernumber=0;_OrderMoney=0;
        _allmoneylable.text=[NSString stringWithFormat:@"共%ld个订单\n总金额%.2f元",(long)_Ordernumber,_OrderMoney];

        UIButton *btn = (UIButton *)[_FootView viewWithTag:9999];
        btn.selected = NO;
    }else{
        _MytableView.frame= CGRectMake(0, 94+ZOOM(30)*2, kApplicationWidth, kApplicationHeight-94-ZOOM(30)*2+kUnderStatusBarStartY);
    }

}
//我的买单 我的卖单
-(void)change:(id)sender
{
    _FootView.hidden=YES;
    _MytableView.hidden=YES;
    _backview.hidden=YES;
    _currentpage = 1;
    _titleArr=@[@"全部",@"待付款",@"免费领",@"待收货",@"待评价"];
    
    subSegment.selectedSegmentIndex=0;
    self.tag=999;
    
    [[Animation shareAnimation] createAnimationAt:self.view];
    //[_MytableView headerBeginRefreshing];
    
    _MytableView.frame= CGRectMake(0, 94+ZOOM(30)*2, kApplicationWidth, kApplicationHeight-94-ZOOM(30)*2+kUnderStatusBarStartY);
    
    UISegmentedControl *segment=(UISegmentedControl*)sender;
    
    switch (segment.selectedSegmentIndex) {
        case 0:
        {
            _titlestring=@"已买商品";
            self.status1=@"0";
            self.oldstatus1=@"0";
            [self requestHttp:_currentpage];
        }
            break;
        case 1:
        {
            _titlestring=@"已卖商品";
            self.status2=@"0";
            self.oldstatus2=@"0";
            [self requestSellHttp:_currentpage];
        }
            break;
    }
    
    [_selectArray removeAllObjects];
    
    
}

// 逛逛
-(void)shoppinggo:(UIButton*)sender
{
    // 跳转到首页
    Mtarbar.selectedIndex=0;
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}

#pragma mark 结算-批量付款
-(void)pay:(UIButton*)sender
{
    
    if(_Ordernumber == 0){
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"你还没有选择订单" Controller:self];
        return;
    }else{
        
        float price = 0.0;
        [_orderString deleteCharactersInRange:NSMakeRange(0, _orderString.length)];
        [_selectShopPayArray removeAllObjects];
        for(int i=0 ;i<_selectArray.count;i++){
            if([_selectArray[i] isEqualToString:@"1"]) {
                ShopDetailModel *model=_dataArray[i];
                [_orderString appendString:model.order_code];
                [_orderString appendString:@","];
                //                price += model.order_price.floatValue * model.shop_num.intValue;
                price =  price + model.order_price.floatValue;
                _orderPrice = [NSString stringWithFormat:@"¥%.2f",price];
                /*
                if((model.shop_from.intValue==4||model.shop_from.intValue==6)&&![model.issue_endtime isEqual:[NSNull null]]){
                    if (model.issue_endtime.doubleValue<=model.requestNow_time.doubleValue) {
                        [MBProgressHUD showError:@"此夺宝活动已开奖，暂时无法操作"];
                        return;
                    }
                }
                */

                [_selectShopPayArray addObject:model];
            }
        }
        
        NSString *ccc;
        if(_orderString.length>0) {
            ccc=[_orderString substringToIndex:[_orderString length]-1];
            self.order_code= @"";
            self.order_code=[NSString stringWithString:ccc];
        }
        
        [self payOrdersHttp]; //生成组合订单编号
        
    }
    
}


#pragma mark 底部按钮
-(void)buttonclick:(UIButton*)sender
{
    
    UIButton *button=(UIButton*)[self.view viewWithTag:sender.tag];
    NSString *title=button.titleLabel.text;
    
    UITableViewCell * cell;
//    if (kIOSVersions >= 7.0 && kIOSVersions < 8) {
//        cell = [[(UITableViewCell *)[sender superview]superview]superview] ;
//    }else{
        cell = (UITableViewCell *)[[sender superview] superview];
//    }
    //    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath * path = [_MytableView indexPathForCell:cell];
    
    MyLog(@"title is %@",title);
    
    indextag=sender.tag/10000-1;
//    NSLog(@"indextag : %d  , path.row : %d",indextag,path.row);
    ShopDetailModel *model;
    if ([_titlestring isEqualToString:@"已买商品"]) {
        model=_dataArray[indextag];
    }else{
        model=_sellDataArray[indextag];
    }
    NSString *ordercoder=model.order_code;
    NSString *orderprice=model.order_price;
    
    self.order_code=nil;
    self.order_code=ordercoder;
    
    if([title isEqualToString:@"付款"])
    {
        /*
        if((model.shop_from.intValue==4||model.shop_from.intValue==6)&&![model.issue_endtime isEqual:[NSNull null]]){
            if (model.issue_endtime.doubleValue<=model.requestNow_time.doubleValue) {
                [MBProgressHUD showError:@"此夺宝活动已开奖，暂时无法操作"];
                return;
            }
        }
        else
*/
        if (model.pay_status.intValue==1&&[model.orderShopStatus intValue]==0 && model.orderShopStatus!=nil&&model.status.intValue==1) {
            [MBProgressHUD showError:@"此订单未返回支付状态，暂时无法操作"];
            return;
        }
        
        if(model.shopsArray.count == 1)
        {
            ShopDetailModel *ordermodel=model.shopsArray[0];
            
            //model.kickBack  %@",model.kickback);
            //存储当前支付的shopcode
            NSUserDefaults *users=[NSUserDefaults standardUserDefaults];
            [users setObject:ordermodel.shop_code forKey:SHOP_CODE];
            [users setObject:ordermodel.shop_pic forKey:SHOP_PIC];
            [users setObject:model.kickback forKey:KICKBACK];
            
        }
        
        MyLog(@"model.shop_from is %@",model.shop_from);
        
        //        PaystyleViewController *paystyle=[[PaystyleViewController alloc]init];
        //        paystyle.price = [NSString stringWithFormat:@"%.2f",orderprice.floatValue];
        TFPayStyleViewController *paystyle=[[TFPayStyleViewController alloc]init];
        paystyle.price = orderprice.floatValue;
        
        
        _orderPrice = [NSString stringWithFormat:@"¥%.2f",orderprice.floatValue];
        //%@",_orderPrice);
        
        paystyle.urlcount=@"1";
        paystyle.order_code=_order_code;
        paystyle.shop_from = model.shop_from.intValue==6 ? @"4" :model.shop_from;
        paystyle.shopmodel=model;
        paystyle.lasttime=model.lasttime;
        paystyle.fromType=@"订单列表按钮";
        paystyle.is_roll=model.is_roll;
        paystyle.isFashionBuy=(model.is_roll==1||model.is_roll==3||model.is_roll==4)?YES:NO;
        //        paystyle.delegate = self;
        [self.navigationController pushViewController:paystyle animated:YES];
        
    }
    else if ([title isEqualToString:@"取消订单"])
    {
        
        if (model.pay_status.intValue==1&&[model.orderShopStatus intValue]==0 && model.orderShopStatus!=nil&&model.status.intValue==1) {
            [MBProgressHUD showError:@"此订单未返回支付状态，暂时无法取消"];
            return;
        }
        [self showMyPicker];
        
    }
    else if ([title isEqualToString:@"联系卖家"])
    {
        //联系卖家");
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString* suppid = [user objectForKey:PTEID];
        [self Message:suppid];
        
    }
    else if ([title isEqualToString:@"申请关闭拼团"])
    {
        [self setVitalityPopMindView:Close_Fight_luckSuccess Rollcode:model.roll_code Ordercode:model.order_code ShopModel:model];
    }
    else if ([title isEqualToString:@"分享好友免费领"])
    {
        ShareFreeLingViewController *freeling=[[ShareFreeLingViewController alloc]init];
        freeling.Ordermodel=model;
        freeling.order_code = ordercoder;
        [self.navigationController pushViewController:freeling animated:YES];
    }
    else if ([title isEqualToString:@"提醒发货"])
    {
        //提醒发货");
        if (model.pay_status.intValue==1&&[model.orderShopStatus intValue]==0 && model.orderShopStatus!=nil&&model.status.intValue==1) {
            [MBProgressHUD showError:@"此订单未返回支付状态，暂时无法提醒发货"];
            return;
        }
        //        [self Message];
        [self RemindDelivery:ordercoder];
        
    }
    else if ([title isEqualToString:@"退款"])
    {
        //退款");
        
        RefundAndReturnViewController *refund=[[RefundAndReturnViewController alloc]init];
        refund.orderPrice=orderprice;
        refund.ordermodel=model;
        [self.navigationController pushViewController:refund animated:YES];
        
    }
    else if ([title isEqualToString:@"退款成功"]){
        TFAccountDetailsViewController *refund=[[TFAccountDetailsViewController alloc]init];
        refund.headIndex = 3;
        [self.navigationController pushViewController:refund animated:YES];
    }
    else if ([title isEqualToString:@"确认收货"])
    {
        
        if (model.shop_from.intValue==4||model.shop_from.intValue==6) {
            [self httpIsSetPwd:ordercoder withOrderPrice:orderprice];
            return;
        }
        for (ShopDetailModel *shopModel in model.shopsArray) {
            //            if(shopModel.orderShopStatus.intValue !=1 && !(shopModel.orderShopStatus.intValue==3 && shopModel.change.intValue==3))
            if(shopModel.orderShopStatus.intValue !=1 &&!(shopModel.orderShopStatus.intValue==3 && shopModel.change.intValue==2)&& !(shopModel.orderShopStatus.intValue==3 && shopModel.change.intValue==3) && shopModel.status.intValue!=5)
            {
                //                [self payPassWordView:ordercoder withOrderPrice:orderprice];
                [self httpIsSetPwd:ordercoder withOrderPrice:orderprice];
                
                break;
            }else{
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:@"商品售后处理中" Controller:self];
            }
        }
        
    }
    else if ([title isEqualToString:@"查看物流"])
    {
        LogisticsViewController *logistics=[[LogisticsViewController alloc]init];
        logistics.Ordermodel=model;
        [self.navigationController pushViewController:logistics animated:YES];
    }
    else if ([title isEqualToString:@"评价订单"] || [title isEqualToString:@"追加评价"])
    {
        if (model.shop_from.intValue==4||model.shop_from.intValue==6) {
            IndianaOweViewController *view=[[IndianaOweViewController alloc]init];
            view.Ordermodel=model;
            [self.navigationController pushViewController:view animated:YES];
            return;
        }
        if ([title isEqualToString:@"评价订单"]) {
            //评价订单");
            for (ShopDetailModel *shopModel in model.shopsArray) {
                //                if(shopModel.orderShopStatus.intValue !=1 && !(shopModel.orderShopStatus.intValue==3 && shopModel.change.intValue==3))
                if(shopModel.orderShopStatus.intValue !=1 &&!(shopModel.orderShopStatus.intValue==3 && shopModel.change.intValue==2)&& !(shopModel.orderShopStatus.intValue==3 && shopModel.change.intValue==3) && shopModel.status.intValue!=5){
                    TFEvaluationOrderViewController *evaluate = [[TFEvaluationOrderViewController alloc] init];
                    evaluate.Ordermodel = model;
                    [self.navigationController pushViewController:evaluate animated:YES];
                    return;
                }else{
                    NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                    [mentionview showLable:@"商品售后处理中，不能评价" Controller:self];
                }
            }
            
        } else {
            for (ShopDetailModel *shopModel in model.shopsArray) {
                //                if(shopModel.orderShopStatus.intValue !=1 && !(shopModel.orderShopStatus.intValue==3 && shopModel.change.intValue==3))
                if(shopModel.orderShopStatus.intValue !=1 &&!(shopModel.orderShopStatus.intValue==3 && shopModel.change.intValue==2)&& !(shopModel.orderShopStatus.intValue==3 && shopModel.change.intValue==3)){
                    TFAdditionalEvaluationViewController *tavc = [[TFAdditionalEvaluationViewController alloc] init];
                    tavc.Ordermodel = model;
                    [self.navigationController pushViewController:tavc animated:YES];
                    return;
                }else{
                    NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                    [mentionview showLable:@"商品售后处理中，不能评价" Controller:self];
                }
            }
            
        }
    }
    else if ([title isEqualToString:@"删除订单"])
    {
        //删除订单");
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"温馨提示" contentText:@"亲，真的要删除此订单吗!" leftButtonTitle:@"取消" rightButtonTitle:@"确认"];
        [alert show];

        alert.leftBlock = ^() {
            //left button clicked");//取消
        };
        alert.rightBlock = ^() {
            //right button clicked");//确认

            [self deleteHttp:ordercoder Index:[path row]];
        };
        alert.dismissBlock = ^() {
            //Do something interesting after dismiss block");
        };
        
    }
    else if ([title isEqualToString:@"钱款去向"])
    {
        MoneyGoViewController *moneygo=[[MoneyGoViewController alloc]init];
        
        [self.navigationController pushViewController:moneygo animated:YES];
    }
    else if ([title isEqualToString:@"延长收货"])
    {
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"确认延长收货时间吗?" contentText:@"每笔订单只能延长一次哦!" leftButtonTitle:@"取消" rightButtonTitle:@"确认"];
        [alert show];
        alert.leftBlock = ^() {
            //left button clicked");//取消
        };
        alert.rightBlock = ^() {
            //right button clicked");//确认
            
            [self ExtendHttp:ordercoder];
        };
        alert.dismissBlock = ^() {
            //Do something interesting after dismiss block");
        };
    }else if ([title isEqualToString:@"联系买家"])
    {
        //联系买家");
        MyLog(@"model.suppid = %@",model.user_id);
        
        [self Message:[NSString stringWithFormat:@"%@",model.user_id]];
        
    }else if ([title isEqualToString:@"邀请好友拼团"] || [title isEqualToString:@"拼团失败"] || [title isEqualToString:@"申请关闭拼团"])
    {
        [self gotoFightDetail:model.roll_code Status:model.status Price:model.order_price.floatValue isTM:model.isTM.integerValue];
    }else if ([title isEqualToString:@"会员免费领"]){
        [DataManager sharedManager].app_value = model.order_price.floatValue;
        [DataManager sharedManager].orderShopAarray = @[model];
        
        OneLuckdrawViewController *oneluck = [OneLuckdrawViewController new];
        oneluck.comefrom = @"newbie";
        oneluck.order_code = model.order_code;
        [self.navigationController pushViewController:oneluck animated:YES];
    }else if ([title isEqualToString:@"免费领未点中"])
    {
        OrderDetailViewController *order=[[OrderDetailViewController alloc]init];
        order.orderModel=model;
        [self.navigationController pushViewController:order animated:YES];
    }else if ([title isEqualToString:@"申请发货"] || [title isEqualToString:@"联系客服发货"]){
        
        [self applicationforshipmentHttp:model];
    }else if ([title isEqualToString:@"成为会员"]){
        AddMemberCardViewController *addcard = [[AddMemberCardViewController alloc]init];
        addcard.from_vipType = @"mine";
        [self.navigationController pushViewController:addcard animated:YES];
    }else if ([title isEqualToString:@"关闭订单"]){
        [self closeOrder:ordercoder];
    }else if ([title isEqualToString:@"联系客服"] || [title isEqualToString:@"接通客服"]){
//        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        NSString* suppid = [user objectForKey:PTEID];
//        [self Message:suppid];
        
        ContactKefuViewController *contact = [[ContactKefuViewController alloc]init];
        contact.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:contact animated:YES];
    }
}
- (void)gotoFightDetail:(NSString*)roll_code Status:(NSString*)status Price:(CGFloat)orderPrice isTM:(NSInteger)isTM
{
    //去拼团详情
    [DataManager sharedManager].opengroup = 1;
    [DataManager sharedManager].app_value = orderPrice;
    
    GroupBuyDetailVC *fightvc = [[GroupBuyDetailVC alloc] init];
    fightvc.roll_code = roll_code;
    fightvc.isTM = isTM;
    fightvc.fightStatus = status.integerValue;
    [self.navigationController pushViewController:fightvc animated:YES];
    
}
/*************  总金额  ***********/
-(void)selectOrderMoney
{
    CGFloat price=0;
    for(int i=0 ;i<_selectArray.count;i++){
        if([_selectArray[i] isEqualToString:@"1"]){
            ShopDetailModel *model=_dataArray[i];
            [_orderString appendString:model.order_code];
            [_orderString appendString:@","];
            //                price += model.order_price.floatValue * model.shop_num.intValue;
            price += model.order_price.floatValue;
        }
    }
    _OrderMoney=price;
    
}
#pragma mark 选择订单
-(void)select:(UIButton*)sender
{
    if([_titlestring isEqualToString:@"已买商品"]){
        sender.selected=!sender.selected;
        if(sender.selected){
            sender.selected=YES;
            _selectArray[sender.tag%2000]=@"1";
            _Ordernumber++;
        }else{
            sender.selected=NO;
            _selectArray[sender.tag%2000]=@"0";
            _Ordernumber --;
        }
        
        UIButton *btn = (UIButton *)[_FootView viewWithTag:9999];
        btn.selected = _Ordernumber==_selectArray.count;
        
        [self selectOrderMoney];
        _allmoneylable.text=[NSString stringWithFormat:@"共%ld个订单\n总金额%.2f元",(long)_Ordernumber,_OrderMoney];
    }else{//已卖商品
        ShopDetailModel *model=_sellDataArray[sender.tag%2000];
        [self Message:[NSString stringWithFormat:@"%@",model.user_id]];
    }
}

#pragma mark 全选
-(void)selectclick:(UIButton*)sender
{
    sender.selected=!sender.selected;
    
    if(sender.selected){
        for(int i=0;i<_selectArray.count;i++){  //全选记录按钮状态数据全为1 2
            _selectArray[i]=@"1";
        }
        _Ordernumber=_selectArray.count;
    }else{
        for(int i=0;i<_selectArray.count;i++){//全选取消记录按钮状态数据全为0
            _selectArray[i]=@"0";
        }
        _Ordernumber=0;_OrderMoney=0;
        
    }
    [self selectOrderMoney];
    
    _allmoneylable.text=[NSString stringWithFormat:@"共%ld个订单\n总金额%.2f元",(long)_Ordernumber,_OrderMoney];
    
    [_MytableView reloadData];
}

#pragma mark --PopoverView 代理
- (void)seletRowAtIndex:(PopoverView *)popoverView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(popoverView.tag==8888){
        if(titlesArray.count) {
//            NSString *str=titlesArray[indexPath.row]; 
            self.status2=[NSString stringWithFormat:@"%zd",4+indexPath.row];
            [self requestSellHttp:_currentpage];
        }
    }
}


#pragma mark ********************** UITableView  ************************
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_Distribution) {
        ShopDetailModel *model;
        if([_titlestring isEqualToString:@"已买商品"]) {
            model=_dataArray[indexPath.section];
//            ShopDetailModel *model1=_dataArray[indexPath.section];
//            if(model1.shopsArray.count){
//                model=model1.shopsArray[indexPath.row];
//            }else
//                 model=_dataArray[indexPath.section];
            
            if(model.status.intValue ==12)//去疯抢
            {
                [DataManager sharedManager].app_value = model.order_price.floatValue;
                [DataManager sharedManager].orderShopAarray = @[model];
                
                OneLuckdrawViewController *oneluck = [OneLuckdrawViewController new];
                oneluck.comefrom = @"newbie";
                oneluck.order_code = model.order_code;
                [self.navigationController pushViewController:oneluck animated:YES];
            }else if (model.status.intValue == 11 || model.status.intValue == 13 || model.status.intValue == 15)
            {
                [self gotoFightDetail:model.roll_code Status:model.status Price:model.order_price.floatValue isTM:model.isTM.integerValue];
            }
            else{
                
                OrderDetailViewController *order=[[OrderDetailViewController alloc]init];
                order.orderModel=model;
                [self.navigationController pushViewController:order animated:YES];
            }
                
        }else{
            model=_sellDataArray[indexPath.section];
            SellorderViewController *sellorder=[[SellorderViewController alloc]init];
            sellorder.orderModel=model;
            [self.navigationController pushViewController:sellorder animated:YES];
        }
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_titlestring isEqualToString:@"已买商品"]&&_dataArray.count>0) {
        return _dataArray.count;
    }else if(_sellDataArray.count>0){
        return _sellDataArray.count;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_titlestring isEqualToString:@"已买商品"]&&_dataArray.count>0) {
        ShopDetailModel *model=_dataArray[section];
        if (model.shop_from.intValue==1||model.shop_from.intValue==4||model.shop_from.intValue==6) {
            return 1;
        }
        return model.shopsArray.count;
    } else if(_sellDataArray.count>0){
        ShopDetailModel *model=_sellDataArray[section];
        return model.shopsArray.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (!_Distribution) {
        if([_titlestring isEqualToString:@"已买商品"]){
            if (subSegment.selectedSegmentIndex==1) {
                return 30;
            }
        }else{//已卖商品
            return 0.1;
        }
    }
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_Distribution) {
        return ZOOM(62)+40;
    }
    else if([_titlestring isEqualToString:@"已卖商品"]){
        ShopDetailModel *model=_sellDataArray[section];
        if (model.status.intValue==6){
            return ZOOM(62)*3;
        }
    }
    return ZOOM(62)*3+40;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!_Distribution) {
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 30)];
        view.backgroundColor=[UIColor whiteColor];
        
        _SelectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _SelectBtn.frame=CGRectMake(ZOOM(62),10,ZOOM(70), ZOOM(70));
        _SelectBtn.clipsToBounds=YES;
        _SelectBtn.tag=2000+section;
        
        [_SelectBtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
        
        if(_selectArray.count>section){
            if([_selectArray[section] isEqualToString:@"1"]){
                _SelectBtn.selected=YES;
            }else{
                _SelectBtn.selected=NO;
            }
        }
        [view addSubview:_SelectBtn];
        
        
        ShopDetailModel *titlemodel;
        UILabel *storelable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(70)+_SelectBtn.frame.size.width,_SelectBtn.frame.size.height/2, 150, 20)];
        if(_dataArray.count>section) {
            titlemodel=_dataArray[section];
            storelable.text=[NSString stringWithFormat:@"%@",titlemodel.order_code];
            
        }
        storelable.font=[UIFont systemFontOfSize:ZOOM(38)];
        [view addSubview:storelable];
        
        if([_titlestring isEqualToString:@"已买商品"]&&_dataArray.count>section) {
            if (subSegment.selectedSegmentIndex ==1) {
                [_SelectBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
                [_SelectBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
                return view;
            }
        }else{
            return 0;
            /*
            ShopDetailModel *model;
            if(_sellDataArray.count>section)
            {
                model =_sellDataArray[section];
            }
            //        statuelable.text=[NSString stringWithFormat:@"订单号:%@",model.order_code];
            [_SelectBtn setImage:[UIImage imageNamed:@"底栏_联系店主"] forState:UIControlStateNormal];
            _SelectBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
            
            return view;
            */
        }
    }
    return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    int statecount=0; //状态按钮的数量
    NSArray *titlearr;//状态按钮的title
    NSString *statue;//订单状态
    NSInteger check;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, ZOOM(62)*3+40)];
    if(_Distribution){
        view.frame=CGRectMake(0, 0, kApplicationWidth, ZOOM(62)+40);
    }
//    else if([_titlestring isEqualToString:@"已卖商品"]&&(model.status.intValue==9||model.status.intValue==6)){
//        view.frame=CGRectMake(0, 0, kApplicationWidth, ZOOM(62)*2+40);
//    }
    view.backgroundColor=[UIColor whiteColor];
    UILabel *pricelable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(42),ZOOM(62), kApplicationWidth-ZOOM(42)*2, 20)];
    pricelable.textAlignment=NSTextAlignmentRight;
    pricelable.font = [UIFont systemFontOfSize:ZOOM(46)];
//    CGFloat lineheigh=view.frame.size.height-1;

    if([_titlestring isEqualToString:@"已买商品"]&&_dataArray.count>section) {
        ShopDetailModel *model=_dataArray[section];
        statue=model.status;
        check = (model.ischeck!=nil&&![model.ischeck isEqual:[NSNull null]])?model.ischeck.integerValue:9999;
        if (model.shop_from.intValue==4||model.shop_from.intValue==6) {
            pricelable.text=[NSString stringWithFormat:@"共1件商品   实付:¥%.2f",model.order_price.floatValue];
        }
        else if (model.shop_from.intValue==1) {
            pricelable.text=[NSString stringWithFormat:@"共%@件商品   实付:¥%.2f(含运费:¥%.2f)",model.shop_num,model.order_price.floatValue,model.postage.floatValue];
        }
//        else if (model.shop_from.intValue==10)//一元购订单
//        {
//            pricelable.text=[NSString stringWithFormat:@"共%@件商品   实付:¥%.2f",model.shop_num,[DataManager sharedManager].app_value];
//        }
        else
            pricelable.text=[NSString stringWithFormat:@"共%@件商品   实付:¥%.2f",model.shop_num,model.order_price.floatValue];

        
        switch (statue.intValue) {
            case 1:
                if ([self compareWithAnotherDay:model]==-1) {
                    statecount=1;
                    titlearr=@[@"删除订单"];
                }else{
                    statecount=3;
                    titlearr=@[@"付款",@"取消订单",@"联系卖家"];
                }
                break;
            case 2:
                statecount=1;
                titlearr=@[@"提醒发货"];
                
                if (model.pay_status.intValue==1&&[model.orderShopStatus intValue]==0 && model.orderShopStatus!=nil&&model.status.intValue==1) {
                    statecount=3;
                    titlearr=@[@"付款",@"取消订单",@"联系卖家"];
                }else if(model.issue_status.intValue==4){
                    statecount=1;
                    titlearr=@[@"删除订单"];
                }
                
                if(model.shop_from.intValue == 10 || model.shop_from.intValue == 11 || model.shop_from.intValue == 13){
                    if(model.whether_prize != NULL && ![model.whether_prize isEqual:[NSNull null]])
                    {
                        if(model.whether_prize.intValue  == 0){
                            titlearr=@[@"申请发货"];//直接中奖订单
                        }else if (model.whether_prize.intValue  == 2){
                            if(model.new_free == 1)
                            {
                                titlearr=@[@"接通客服"];//新用户首单
                            }else
                                titlearr=@[@"申请发货"];//预先中奖
                        }
                    }
                }
                break;
            case 3:
                statecount=2;
                titlearr=@[@"确认收货",@"查看物流"];
                break;
            case 4:
                statecount=2;
                titlearr=@[@"评价订单",@"删除订单"];
                break;
            case 5:
                if (model.shop_from.intValue==4||model.shop_from.intValue==6) {
                    statecount=1;
                    titlearr=@[@"删除订单"];
                }else{
                    statecount=2;
                    titlearr=@[@"追加评价",@"删除订单"];
                }
                break;
            case 6:
                statecount=1;
                titlearr=@[@"删除订单"];
                
                break;
            case 7:
                statecount=2;
                titlearr=@[@"确认收货",@"查看物流"];
                break;
            case 8:
                statecount=1;
                titlearr=@[@"钱款去向"];
                break;
            case 9:
                statecount=1;
                titlearr=@[@"删除订单"];
                break;
            case 11:
                statecount=1;
                titlearr=@[@"邀请好友拼团"];
                break;
            case 12:
                statecount=1;
                titlearr=@[@"会员免费领"];
                break;
            case 13:
                statecount=1;
                if(model.is_free == 4)
                {
                    titlearr=@[@"删除订单"];
                }else{
                    if(check == 0)
                    {
                        statecount=2;
                        titlearr=@[@"删除订单",@"退款关闭"];
                    }else if (check == 1)
                    {
                        titlearr=@[@"退款成功"];
                    }else if (check == 2)
                    {
                        titlearr=@[@"退款成功"];
                    }else if (check == 3)
                    {
                        titlearr=@[@"退款中"];
                    }else if (check == 4)
                    {
                        titlearr=@[@"退款失败"];
                    }else{
                        titlearr=@[@"删除订单"];
                    }
                }
                
                break;
            case 14:
//                statecount=2;
//                titlearr=@[@"删除订单",@"退款成功"];

                statecount=1;
                if(model.is_free == 4)
                {
                    titlearr=@[@"删除订单"];
                }else{
                    if(check == 0)
                    {
                        statecount=2;
                        titlearr=@[@"删除订单",@"退款关闭"];
                    }else if (check == 1)
                    {
                        titlearr=@[@"退款成功"];
                    }else if (check == 2)
                    {
                        titlearr=@[@"退款成功"];
                    }else if (check == 3)
                    {
                        titlearr=@[@"退款中"];
                    }else if (check == 4)
                    {
                        titlearr=@[@"退款失败"];
                    }else{
                        titlearr=@[@"删除订单"];
                    }
                }
                
                break;
            case 15://96小时已过
                statecount=1;
                titlearr=@[@"申请关闭拼团"];
                break;
            case 16://客服关闭拼团
                
                statecount=1;
                if(model.is_free == 4)
                {
                    titlearr=@[@"删除订单"];
                }else{
                    if(check == 0)
                    {
                        statecount=2;
                        titlearr=@[@"删除订单",@"退款关闭"];
                    }else if (check == 1)
                    {
                        titlearr=@[@"退款成功"];
                    }else if (check == 2)
                    {
                        titlearr=@[@"退款成功"];
                    }else if (check == 3)
                    {
                        titlearr=@[@"退款中"];
                    }else if (check == 4)
                    {
                        titlearr=@[@"退款失败"];
                    }else{
                        titlearr=@[@"删除订单"];
                    }
                }
                
                break;
            case 17:
                statecount=1;
                if(model.whether_prize.intValue == 2)
                {
                    if(model.new_free == 1)//用户免费领
                    {
                        statecount=3;
                        titlearr=@[@"接通客服",@"成为会员",@"关闭订单"];
                    }else{
                        statecount=2;
                        titlearr=@[@"申请发货",@"关闭订单"];
                    }
                }else
                    titlearr=@[@"关闭订单"];
                break;
            case 21:
                statecount=1;
                titlearr=@[@"分享好友免费领"];
                break;
            default:
                statecount=1;
                titlearr=@[@"删除订单"];
                break;
        }
        
    }else if ([_titlestring isEqualToString:@"已卖商品"]&&_sellDataArray.count>section)//已卖商品
    {
        ShopDetailModel *model=_sellDataArray[section];
        statue=model.status;

        if (model.shop_from.intValue==4||model.shop_from.intValue==6) {
            pricelable.text=[NSString stringWithFormat:@"共1件商品   实付:¥%.2f",model.order_price.floatValue];
        }
        else if (model.shop_from.intValue==1) {
            pricelable.text=[NSString stringWithFormat:@"共%@件商品   实付:¥%.2f(含运费:¥%.2f)",model.shop_num,model.order_price.floatValue,model.postage.floatValue];
        }else
            pricelable.text=[NSString stringWithFormat:@"共%@件商品   实付:¥%.2f",model.shop_num,model.order_price.floatValue];
        
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
                titlearr=@[@"查看物流"];
                break;
            case 4:
                statecount=1;
                titlearr=@[@"查看物流"];
                break;
            case 5:
                statecount=1;
                titlearr=@[@"查看物流"];
                break;
            case 6:
                statecount=0;
                view.frame=CGRectMake(0, 0, kApplicationWidth, ZOOM(62)*3);
                break;
            case 7:
                statecount=1;
                titlearr=@[@"查看物流"];
                break;
            case 8:
                statecount=1;
                titlearr=@[@"查看物流"];
                break;
            case 9:
                statecount=0;
//                lineheigh=29;

                break;
            default:
                break;
        }
        
    }
    
    if (!_Distribution) {
        for(int i=0; i<statecount; i++){
            UIButton *statebutton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            statebutton.frame=CGRectMake(kApplicationWidth-80*(i+1)-ZOOM(40)*i-ZOOM(42),view.frame.size.height-ZOOM(62)-30, 80, 30);
            
            statebutton.tag=10000*(section+1)+i;
            if([titlearr[i] isEqualToString:@"邀请好友拼团"] || [titlearr[i] isEqualToString:@"会员免费领"] || [titlearr[i] isEqualToString:@"免费领未点中"] )
            {
                statebutton.frame=CGRectMake(kApplicationWidth-100*(i+1)-ZOOM(40)*i-ZOOM(42),view.frame.size.height-ZOOM(62)-30, 100, 30);
                statebutton.backgroundColor=[UIColor redColor];
                statebutton.titleLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
               
            }else if([titlearr[i] isEqualToString:@"申请关闭拼团"]){
                statebutton.frame=CGRectMake(kApplicationWidth-100*(i+1)-ZOOM(40)*i-ZOOM(42),view.frame.size.height-ZOOM(62)-30, 100, 30);
                statebutton.backgroundColor=[UIColor blackColor];
                statebutton.titleLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
            }else if ([titlearr[i] isEqualToString:@"分享好友免费领"]){
                statebutton.frame=CGRectMake(kApplicationWidth-120*(i+1)-ZOOM(40)*i-ZOOM(42),view.frame.size.height-ZOOM(62)-30, 120, 30);
                statebutton.backgroundColor=[UIColor redColor];
                statebutton.titleLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
            }else if([titlearr[i] isEqualToString:@"接通客服"] || [titlearr[i] isEqualToString:@"申请发货"] || [titlearr[i] isEqualToString:@"联系客服"]){
                statebutton.frame=CGRectMake(kApplicationWidth-80*(i+1)-ZOOM(40)*i-ZOOM(42),view.frame.size.height-ZOOM(62)-30, 80, 30);
                statebutton.backgroundColor=[UIColor redColor];
                statebutton.titleLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
            }
            else{
                statebutton.backgroundColor=[UIColor blackColor];
                statebutton.titleLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
            }
           
            [statebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [statebutton setTitle:titlearr[i] forState:UIControlStateNormal];
            [statebutton addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:statebutton];
        }
    }
    [view addSubview:pricelable];
    //    [view addSubview:countlable];
    
    UILabel *linelable=[[UILabel alloc]initWithFrame:CGRectMake(0, view.frame.size.height-1, kApplicationWidth, 1)];
    linelable.backgroundColor=kBackgroundColor;
    [view addSubview:linelable];

    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ZOOM(400);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell=[[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    ShopDetailModel *model;
    if ([_titlestring isEqualToString:@"已买商品"]&& _dataArray.count>0) {
        model=_dataArray[indexPath.section];
    }else if(_sellDataArray.count>0){
        model=_sellDataArray[indexPath.section];
    }
    if (model.shop_from.intValue==4||model.shop_from.intValue==6) {
        [cell refreshIndianaData:model];
        cell.groupBuyImg.hidden = YES;
        cell.zeroLabel.hidden=YES;
        cell.color_size.hidden=YES;
    }else if (model.shop_from.intValue==1) {
        [cell refreshZeroData:model];
        cell.groupBuyImg.hidden = YES;
        cell.zeroLabel.hidden=NO;
        cell.color_size.hidden=YES;
    }else if(model.shopsArray.count>0){
        ShopDetailModel *shopmodel=model.shopsArray[indexPath.row];
        shopmodel.shop_from = model.shop_from;
        shopmodel.roll_name = model.roll_name;
        [cell refreshData:shopmodel];
        cell.groupBuyImg.hidden = model.shop_from.integerValue!=7;
        cell.zeroLabel.hidden=YES;
        cell.color_size.hidden=NO;
        
        //  1元购的商品列表更改

            kSelfWeak;
            cell.questionBtnBlock = ^{
                MyLog(@"%@", model.one_deductible);
                
                [OneYuanModel GetOneYuanCountSuccess:^(id data) {
                    OneYuanModel *oneModel = data;
            
                    [DataManager sharedManager].OneYuan_count = oneModel.order_price;
                    VitalityTaskPopview* vitaliview = [[VitalityTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) VitalityType:Detail_Deductible valityGrade:model.one_deductible.floatValue>0?0:1 YidouCount:0];
                    __weak VitalityTaskPopview *view = vitaliview;
                    
                    vitaliview.oneYuanDiKou = oneModel.order_price;
                
                    view.leftHideMindBlock = ^(NSString *title) {
                        MakeMoneyViewController *makemoney = [[MakeMoneyViewController alloc]init];
                        makemoney.hidesBottomBarWhenPushed = YES;
                        [weakSelf.navigationController pushViewController:makemoney animated:YES];
                    };
                    [weakSelf.view addSubview:vitaliview];
                }];
            };
        
            cell.moneyLabel.hidden = YES;
            cell.questionBtn.hidden = YES;
            if (model.one_deductible.integerValue!=0) {
                cell.moneyLabel.text=[NSString stringWithFormat:@"已抵扣%@元",model.one_deductible];
                cell.questionBtn.hidden = NO;
                cell.moneyLabel.hidden = NO;
            }else {
                if(model.shop_from.intValue == 10 || model.shop_from.intValue == 11)
                {
                    //疯抢未抢到 拼团失败
                    if(model.status.intValue == 13 || model.status.intValue == 14)
                    {
                        cell.moneyLabel.text= @"拼团疯抢费已返还";
                        cell.moneyLabel.hidden = YES;
                        cell.questionBtn.hidden = YES;
//                        cell.moneyLabel.hidden = model.pay_status.intValue==1?NO:YES;
//                        cell.questionBtn.hidden = model.pay_status.intValue==1?NO:YES;
                    }
                }
            }
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}




#pragma mark *************************  通知  *****************************
#pragma mark 支付成功回调
-(void)buysuccess:(NSNotification*)note
{
    BuySuccessViewController *successpay=[[BuySuccessViewController alloc]init];
    successpay.shopprice=_orderPrice;
    [self.navigationController pushViewController:successpay animated:YES];
    
}
#pragma mark 智能分享成功
-(void)sharesuccess:(NSNotification*)note
{
    /*
        _backview.hidden=YES;
        UIImageView *shareImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY)];
        shareImage.image = [UIImage imageNamed:@"share0020"];
        shareImage.tag = 7171;
        [self.view addSubview:shareImage];
    
        [self performSelector:@selector(startactive) withObject:nil afterDelay:3];
    
        [self getkickbackRequest];
     */
    
}

#pragma mark 智能分享失败
- (void)sharefail:(NSNotification*)note
{
    /*
        if(_sharefailnumber < 1)
        {
            self.noviceTaskView = [[TFNoviceTaskView alloc] init];
            [self.noviceTaskView returnClick:^(NSInteger type) {
                if (type == 9) {
                    //给钱也不要");
    
                    [self removeNoviceTaskView];
    
                } else if (type == 509) {
    
                    //现在去分享");
    
                    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                    [mentionview showLable:@"分享中，请稍等哦~" Controller:self];
    
                    [self performSelector:@selector(sharetishi) withObject:nil afterDelay:0.3];
    
                }
    
            } withCloseBlock:^(NSInteger type) {
    
                //关闭");
                [self removeNoviceTaskView];
            }];
            
            [self.noviceTaskView showWithType:@"9"];
            
            _sharefailnumber ++;
        }
    */
}

#pragma mark ***********************  creatpickerView  ******************
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
    
    NSInteger row=[self.myPicker selectedRowInComponent:0];
    NSString *value=[pickerArray objectAtIndex:row];
    ShopDetailModel *model=_dataArray[indextag];
    
    [self CancelHttp:model Index:indextag Explain:value];
    
}
#pragma mark *************************  UIPickerView   *****************************

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)back
{
    if ([self.navigationController.viewControllers[self.navigationController.viewControllers.count-2] isKindOfClass:[TFPayStyleViewController class]]
        ||[NSStringFromClass([self.navigationController.viewControllers[self.navigationController.viewControllers.count-2]class])isEqualToString:@"ActivityShopOrderVC"] || [self.navigationController.viewControllers[self.navigationController.viewControllers.count-2] isKindOfClass:[OneLuckdrawViewController class]] || [self.navigationController.viewControllers[self.navigationController.viewControllers.count-2] isKindOfClass:[OrderTableViewController class]]
        )
    {

        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        
        if ([controller isKindOfClass:[NewShoppingCartViewController class]]){
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }
        if ([controller isKindOfClass:[DPAddShopVC class]]){
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 0元购弹框
- (void)setVitalityPopMindView:(VitalityType)type Rollcode:(NSString*)roll_code Ordercode:(NSString*)order_code ShopModel:(ShopDetailModel*)model
{
    VitalityTaskPopview *vitaliview = [[VitalityTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) VitalityType:type valityGrade:0 YidouCount:0];
    vitaliview.oneYuanDiKou = [DataManager sharedManager].OneYuan_count;
    __weak VitalityTaskPopview *view = vitaliview;
    kWeakSelf(self);
    view.tapHideMindBlock = ^{
        
    };
    view.closeMindBlock = ^{
        
    };
    view.leftHideMindBlock = ^(NSString*title){
        if(type == Robot_Fight_luckSuccess){
            
            [DataManager sharedManager].app_value = model.order_price.floatValue;
            [DataManager sharedManager].orderShopAarray = @[model];
            
            OneLuckdrawViewController *oneluck = [OneLuckdrawViewController new];
            oneluck.comefrom = @"newbie";
            oneluck.order_code = order_code;
            [weakself.navigationController pushViewController:oneluck animated:YES];
            
        }else if (type == Close_Fight_luckSuccess)
        {
            [MBProgressHUD showMessage:@"请稍后~" afterDeleay:2.0 WithView:self.view];
            [weakself CoseFightHttp:roll_code Order_code:order_code ShopModel:model];
        }
    };
    
    view.rightHideMindBlock = ^(NSString *title) {
        if(type == Robot_Fight_luckSuccess){
            
        }else if (type == Close_Fight_luckSuccess)
        {
            
        }
    };
    [self.view addSubview:vitaliview];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
 #pragma mark - UPPayPlugin Test
 
 
 - (void)userPayAction:(id)sender
 {
 if (![self.mode isEqualToString:@"00"])
 {
 NSURL* url = [NSURL URLWithString:self.configURL];
 NSMutableURLRequest * urlRequest=[NSMutableURLRequest requestWithURL:url];
 NSURLConnection* urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
 [urlConn start];
 [self showAlertWait];
 }
 }
 
 - (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response
 {
 NSHTTPURLResponse* rsp = (NSHTTPURLResponse*)response;
 int code = [rsp statusCode];
 if (code != 200)
 {
 [self hideAlert];
 [self showAlertMessage:kErrorNet];
 [connection cancel];
 
 connection = nil;
 }
 else{
 if (mData != nil){
 mData = nil;
 }
 mData = [[NSMutableData alloc] init];
 }
 }
 
 - (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
 {
 [mData appendData:data];
 }
 
 - (void)connectionDidFinishLoading:(NSURLConnection *)connection
 {
 [self hideAlert];
 NSString* tn = [[NSMutableString alloc] initWithData:mData encoding:NSUTF8StringEncoding];
 if (tn != nil && tn.length > 0){
 [UPPayPlugin startPay:tn mode:self.mode viewController:self delegate:self];
 }
 connection = nil;
 
 }
 
 -(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
 {
 [self hideAlert];
 [self showAlertMessage:kErrorNet];
 connection = nil;
 }
 
 
 - (void)UPPayPluginResult:(NSString *)result
 {
 NSString* msg = [NSString stringWithFormat:kResult, result];
 [self showAlertMessage:msg];
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
 if (mAlert != nil){
 [mAlert dismissWithClickedButtonIndex:0 animated:YES];
 mAlert = nil;
 }
 }

 #pragma mark 银联支付
 -(void)normalPayAction
 {
 
 if ([self.mode isEqualToString:@"00"]) {
 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"重要提示" message:@"您现在即将进行的是一笔真实的消费,消费金额0.01元,点击确定开始支付." delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
 [alertView show];
 
 }
 else
 {
 NSURL* url = [NSURL URLWithString:self.tnURL];
 NSMutableURLRequest * urlRequest=[NSMutableURLRequest requestWithURL:url];
 NSURLConnection* urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
 [urlConn start];
 }
 
 }
 
 
 #pragma mark 获取分享的回佣
 -(void)getkickbackRequest
 {
 AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
 NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
 NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
 NSString *token=[user objectForKey:USER_TOKEN];
 NSString *code =[user objectForKey:ORDER_CODE];
 NSString *string2 = [code substringToIndex:1];
 
 NSString *url;
 if([string2 isEqualToString:@"G"])//多订单
 {
 url=[NSString stringWithFormat:@"%@order/ shareGetkbToList?version=%@&g_code=%@&token=%@",[NSObject baseURLStr],VERSION,code,token];
 }else{//单订单
 url=[NSString stringWithFormat:@"%@order/ shareGetkb?version=%@&order_code=%@&token=%@",[NSObject baseURLStr],VERSION,code,token];
 }
 
 NSString *URL=[MyMD5 authkey:url];
 
 [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
 
 if (responseObject!=nil) {
 
 }
 
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 
 }];
 
 }
 
 
 - (void)removeNoviceTaskView
 {
 for (UIView *view in self.view.subviews) {
 if ([view isKindOfClass:[TFNoviceTaskView class]]||[view isKindOfClass:[TFDailyTaskView class]]) {
 
 [view removeFromSuperview];
 }
 }
 
 }
 
 - (void)sharetishi
 {
 //配置分享平台信息
 AppDelegate *app=[[UIApplication sharedApplication] delegate];
 [app shardk];
 
 [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:nil WithShareType:@"index"];
 }
 */
/**
 *  - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
 {
 
 if ([keyPath isEqualToString:@"shopping"]) {
 //value = %@", change[@"new"]);
 
 NSNumber *st = change[@"new"];
 
 if ([st intValue ]== 1) {
 
 NavgationbarView *mentionview = [[NavgationbarView alloc]init];
 [mentionview showLable:@"分享成功" Controller:self];
 
 }
 else if ([st intValue ]== 2)
 {
 MyLog(@"微信分享成功");
 }
 
 else{
 NavgationbarView *mentionview = [[NavgationbarView alloc]init];
 [mentionview showLable:@"分享失败" Controller:self];
 
 }
 }
 
 }
 
 
 -(void)startactive
 {
 UIImageView *shareimage = (UIImageView*)[self.view viewWithTag:7171];
 [shareimage removeFromSuperview];
 
 UIView *pigview =[self creatKickbackAnimationwithDurtime:1];
 
 [self.view addSubview:pigview];
 
 [self.view bringSubviewToFront:pigview];
 
 }
 
 
 #pragma mark 分享动画
 - (UIView*)creatKickbackAnimationwithDurtime:(int)time
 {
 UIView *animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY)];
 animationView.backgroundColor = [UIColor clearColor];
 animationView.alpha = 1;
 animationView.tag = 888;
 
 //    [self.view addSubview:animationView];
 
 //    [self.view bringSubviewToFront:animationView];
 
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
 _backview.hidden=NO;
 [self.view bringSubviewToFront:_backview];
 [animationView removeFromSuperview];
 }];
 
 }
 
 
 #pragma mark 删除分享动画
 - (void)makeVisiblebgView
 {
 UIView *animationView=(UIView*)[self.view viewWithTag:888];
 [UIView animateWithDuration:0.3 animations:^{
 animationView.frame =CGRectMake(kApplicationWidth+20,animationView.frame.origin.y, animationView.frame.size.width, animationView.frame.size.height);
 } completion:^(BOOL finished) {
 animationView.frame =CGRectMake(kApplicationWidth+20,animationView.frame.origin.y, animationView.frame.size.width, animationView.frame.size.height);
 [animationView removeFromSuperview];
 }];
 }

 */
@end


