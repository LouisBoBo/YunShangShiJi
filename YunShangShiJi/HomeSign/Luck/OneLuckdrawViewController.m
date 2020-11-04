//
//  OneLuckdrawViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 2018/2/24.
//  Copyright © 2018年 ios-1. All rights reserved.
//

#import "OneLuckdrawViewController.h"
#import "ShopDetailViewController.h"
#import "TFPayStyleViewController.h"
#import "LoginViewController.h"
#import "RawardTableViewCell.h"
#import "VitalityTaskPopview.h"
#import "MyOrderViewController.h"
#import "TFMyWalletViewController.h"
#import "OrderDetailViewController.h"
#import "HBmemberViewController.h"
#import "AddMemberCardViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+NJ.h"
#import "MyMD5.h"
#import "SUTableView.h"
#import "GlobalTool.h"
#import "OneYuanModel.h"
#import "LuckModel.h"
#import "vipInfoModel.h"
@interface OneLuckdrawViewController ()
@property (nonatomic, strong) VitalityTaskPopview *vitaliview;
@property (nonatomic, assign) NSInteger robCount;  //免费疯抢次数
@property (nonatomic, assign) NSInteger firstGroup;
@property (nonatomic, assign) NSInteger global_firstGroup;
@property (nonatomic, assign) NSInteger is_orNotPreze; //0可中奖 1不可中奖
@property (nonatomic, assign) NSInteger noprize_valityGrade;
@property (nonatomic, assign) BOOL isActiveRule;   //活动规则
@property (nonatomic, assign) BOOL shouye3Free;    //首页3免费领
@end

@implementation OneLuckdrawViewController
{
    int _ptyacount;
    BOOL _once_more;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.isActiveRule = NO;
    self.is_orNotPreze = 1;
    
    [self creatNavagationbar];
    [self creatLuckMainView];
    [self setTodayRewardBtn];
//    [self creatRobCount];
    
    [self creatData];
    
    //疯抢规则
//    [self setVitalityPopMindView:Raward_oneLuckRule];
    
    //测试用
//    self.noprize_valityGrade = 15;
//    [self setVitalityPopMindView:Raward_oneLuckNOPrize];

//    [self setVitalityPopMindView:Detail_OneYuanDeductible];
//    [self setVitalityPopMindView:Raward_oneLuckPrize];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    if([self.comefrom isEqualToString:@"paysuccess"])//支付
//    {
//        [self creatRobCount];
//    }
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.comefrom = @"payfail";
}

- (void)creatRobCount
{
    self.robCount = 1;
    if([DataManager sharedManager].app_every > 0)
    {
        CGFloat app_value = [[NSString stringWithFormat:@"%.2f",[DataManager sharedManager].app_value] floatValue];
        CGFloat app_every = [[NSString stringWithFormat:@"%.2f",[DataManager sharedManager].app_every] floatValue];
        self.robCount = app_value/app_every;
        if(self.robCount * app_every < app_value)
        {
            self.robCount = self.robCount +1;
        }
    }
}
- (void)creatData
{

    RawardModel *model = [RawardModel alloc];
    [self.fictitiousPtyaArray addObjectsFromArray:[model getPtyaModel:3]];
    [self.totalPtyaArray addObjectsFromArray:self.fictitiousPtyaArray];
    
    [self startLuck_LotteryHttp:NO];

//    [self geteduHttp];
}

//导航条
- (void)creatNavagationbar
{
    self.tabheadview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    [self.view addSubview:self.tabheadview];
    self.tabheadview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(self.tabheadview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.tabheadview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, self.tabheadview.frame.size.height/2+10);

    titlelable.text = @"会员免费领商品";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [self.tabheadview addSubview:titlelable];
}

/**
 活动规则
 */
- (void)setTodayRewardBtn {
    
    UIButton *todayReward=[UIButton buttonWithType:UIButtonTypeCustom];
    [todayReward setTitle:@"活\n动\n规\n则" forState:UIControlStateNormal];
    todayReward.layer.cornerRadius=3;
    [todayReward setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [todayReward setBackgroundColor:RGBA(255, 207, 0, 1)];
    todayReward.frame=CGRectMake(kScreenWidth-ZOOM6(65), 64+ZOOM6(200), ZOOM6(70), ZOOM6(160));
    [todayReward addTarget:self action:@selector(creatDayRewardView) forControlEvents:UIControlEventTouchUpInside];
    todayReward.titleLabel.font=[UIFont boldSystemFontOfSize:ZOOM6(30)];
    todayReward.titleLabel.numberOfLines=4;
    todayReward.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:todayReward];
}

- (void)creatDayRewardView
{
    self.isActiveRule = YES;
    [self setVitalityPopMindView:Raward_oneLuckRule];
}
//主界面
- (void)creatLuckMainView
{
    self.myScrollview = [[UIScrollView alloc]init];
    self.myScrollview.userInteractionEnabled = YES;
    self.myScrollview.backgroundColor = RGBCOLOR_I(234, 0, 5);
    self.myScrollview.contentMode =UIViewContentModeScaleAspectFill;
    self.myScrollview.contentSize = CGSizeMake(0, 1000);
    [self.view addSubview:self.myScrollview];
    
    [self.myScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tabheadview.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(kScreenHeight-Height_NavBar));
    }];
    
    [self creatHeadView];
    [self creatLuckView];
    [self creatTabview];
}

//头部
- (void)creatHeadView
{
    CGFloat headheight = kScreenWidth*1.008;
    
    self.headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, headheight)];
    self.headView.userInteractionEnabled = YES;
//    self.headView.image = [UIImage imageNamed:@"yiyuangou-zhuanpan"];
    [self.headView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/memberfreeling_newbackimage.png"]]];
    [self.myScrollview addSubview:self.headView];
}

#pragma mark 转盘
- (void)creatLuckView
{
    CGFloat YY = ZOOM6(170);
    CGFloat roatwith = ZOOM6(550);
    self.roationView = [[DJRoationView alloc] initWithFrame:CGRectMake((kScreenWidth-roatwith)/2,YY, roatwith, roatwith)];
    self.roationView.speed = 15;//调速度 最快20;
    self.roationView.is_oneLuck = YES;
    [self.myScrollview addSubview:self.roationView];
    
    kWeakSelf(self);
    self.roationView.startRotainBlock = ^(NSString *title)
    {
        
        if([weakself.comefrom isEqualToString:@"paysuccess"] || [weakself.comefrom isEqualToString:@"payfail"] || [weakself.comefrom isEqualToString:@"newbie"])
        {
            if(weakself.robCount >0)//免费次数如果还有就不用下单支付
            {
                weakself.robCount --;
                [weakself.roationView startRotainAnimation:weakself.is_orNotPreze];
            }else{
                [weakself OrderHttp];
            }
            
        }else{
            weakself.robCount --;
            [weakself.roationView startRotainAnimation:weakself.is_orNotPreze];
        }
        
    };
    
    [self.roationView rotatingDidFinishBlock:^(NSInteger index, CGFloat score,CGFloat raward,NSInteger rawardtype) {
        NSLog(@"indx=%d,score=%.f",(int)index,score);
        kWeakSelf(self);
        if(raward >0)//中奖后处理
        {
            //抽奖结束告诉后台
            [LuckModel getLuckHttpLuckDraw:YES orderCode:weakself.order_code FirstGroup:weakself.firstGroup Success:^(id data) {
                LuckModel *model = data;
                if(model.status == 1)
                {
                    if(model.remainder)
                    {
                        weakself.robCount = model.remainder;
                        weakself.firstGroup = model.remainder < 1 ? weakself.global_firstGroup : weakself.firstGroup;
                    }
                    [self luckDrawOrderData:model.order];//疯抢中订单信息
                }
            }];
            
        }else{//未中奖后处理
            
            if(self.robCount <= 0)
            {
                /*
                [OneYuanModel GetOneYuanCountSuccess:^(id data) {
                    OneYuanModel *oneModel = data;
                    
                    [DataManager sharedManager].OneYuan_count = oneModel.order_price;
                    
                    [DataManager sharedManager].app_value = 0;
                    [weakself setVitalityPopMindView:Detail_OneYuanDeductible];
                }];*/
                
                
                [vipInfoModel addUserVipOrderSuccess:^(id data) {
                    vipInfoModel *model = data;
                    NSInteger isVip = model.isVip ? model.isVip:0;
                    NSInteger maxVipType = model.maxType?model.maxType:999;
                    
                    if(weakself.firstGroup == 2)//新用户首次、每日首次、非预先中奖
                    {
                        if(isVip <= 0)
                        {
                            weakself.noprize_valityGrade = 11;//再免费领一轮
                        }else{
                            if(maxVipType == 6)//至尊会员
                            {
                                weakself.noprize_valityGrade = 12;//再点一轮 离开
                            }else{
                                weakself.noprize_valityGrade = 13;//免费再抢一轮
                            }
                        }
                        
                    }else if (weakself.firstGroup == 1)//新用户首次、非预先中奖
                    {
                         weakself.noprize_valityGrade = 14;//退款进度 0元再抢一轮
                    }else{//不是首次、不是每日首次、普通中奖
                        if(isVip <= 0)
                        {
                            weakself.noprize_valityGrade = 15;//退款进度 再抢一轮
                        }else{
                            weakself.noprize_valityGrade = 12;//再点一轮 离开
                        }
                    }
                    [weakself setVitalityPopMindView:Raward_oneLuckNOPrize];
                }];
                
            }else{
                [weakself setVitalityPopMindView:Raward_oneLuckMore];
            }
            
            //抽奖结束告诉后台
            [LuckModel getLuckHttpLuckDraw:NO orderCode:weakself.order_code FirstGroup:weakself.firstGroup Success:^(id data) {
                LuckModel *model = data;
                if(model.remainder)
                {
                    weakself.robCount = model.remainder;
                    weakself.firstGroup = model.remainder < 1 ? weakself.global_firstGroup : weakself.firstGroup;
                }
            }];
        }
        
    }];//动画停止后回调
}

//列表
- (void)creatTabview
{
    CGFloat viewHeigh = 305;
    UIView * backview = [[UIView alloc]initWithFrame:CGRectMake(ZOOM6(20), CGRectGetMaxY(self.headView.frame)+ZOOM6(20), kScreenWidth-ZOOM6(20)*2, viewHeigh)];
    backview.backgroundColor = [UIColor whiteColor];
    backview.layer.cornerRadius = 5;
    [self.myScrollview addSubview:backview];
    
    CGFloat imageHeigh = 20;
    UIImageView *titleimage = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(backview.frame)-imageHeigh*7.5)/2, 15, imageHeigh*7.5, imageHeigh)];
//    titleimage.image = [UIImage imageNamed:@"yiyuangou-biaoti"];
    [titleimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/mianfeiling_shikuang.png"]]];
    
    UITableView *tabview = [[SUTableView alloc]initWithFrame:CGRectMake(0, 50, CGRectGetWidth(backview.frame), CGRectGetHeight(backview.frame)-55) style:UITableViewStylePlain];
    tabview.delegate = self;
    tabview.dataSource = self;
    tabview.scrollEnabled = NO;
    tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabview.showsVerticalScrollIndicator = NO;
    [tabview registerNib:[UINib nibWithNibName:@"RawardTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.ptyaRwardTableView = tabview;
    
    UIView *clearview = [[UIView alloc]initWithFrame:backview.bounds];
    clearview.backgroundColor = [UIColor clearColor];
    clearview.userInteractionEnabled = YES;
    
    [backview addSubview:titleimage];
    [backview addSubview:tabview];
    [backview addSubview:clearview];
    
    self.myScrollview.contentSize = CGSizeMake(0, CGRectGetMaxY(self.headView.frame)+(305+ZOOM6(70)));
    self.mytimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.totalPtyaArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier=@"Cell";
    RawardTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell=[[RawardTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    RawardModel *model = self.totalPtyaArray[indexPath.row];
    [cell refreshOneyuanData:model];
    return cell;
}

- (void)tick:(NSTimer *)time {
    
    _ptyacount ++;
    
    //(25.0 / 30.0) * (float)self.count) ---> (tableview需要滚动的contentOffset / 一共调用的次数) * 第几次调用
    //比如该demo中 contentOffset最大值为 = cell的高度 * cell的个数 ,5秒执行一个循环则调用次数为 300,没1/60秒 count计数器加1,当count=300时,重置count为0,实现循环滚动.
    if(_ptyacount == 0)
    {
        [self.ptyaRwardTableView setContentOffset:CGPointMake(0, 50 * (float)_ptyacount) animated:NO];
    }else{
        kWeakSelf(self);
        [UIView animateWithDuration:3.0 animations:^{
            
            [weakself.ptyaRwardTableView setContentOffset:CGPointMake(0, 50 * (float)_ptyacount) animated:NO];
        }];
    }
    
    if (_ptyacount >= self.totalPtyaArray.count*2) {
        
        _ptyacount = -1;
    }
}
#pragma mark *********************弹框***********************
- (void)setVitalityPopMindView:(VitalityType)type
{
    NSInteger valityGrade = type == Detail_OneYuanDeductible?2:0;
    valityGrade = type == Raward_oneLuckNOPrize?self.noprize_valityGrade:0;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setInteger:self.robCount forKey:@"oneluckCount"];
    
    self.vitaliview = [[VitalityTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) VitalityType:type valityGrade:valityGrade YidouCount:0];

    __weak VitalityTaskPopview *view = self.vitaliview;
    view.oneYuanDiKou = [DataManager sharedManager].OneYuan_count;
    
    kWeakSelf(self);
    view.tapHideMindBlock = ^{
        
    };
    view.rightHideMindBlock = ^(NSString *title) {
        if (type == Detail_OneYuanDeductible)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }else if (type == Raward_oneLuckNOPrize){
            if([title isEqualToString:@"再抢一轮"] || [title isEqualToString:@"0元再抢一轮"])
            {
                if(weakself.robCount >0)//免费次数如果还有就不用下单支付
                {
                    weakself.robCount --;
                    [weakself.roationView startRotainAnimation:weakself.is_orNotPreze];
                }else{
                    [weakself OrderHttp];
                }
            }else if ([title isEqualToString:@"离开"]){
                [weakself.navigationController popToRootViewControllerAnimated:YES];
            }
            else{
                [weakself.navigationController popViewControllerAnimated:YES];
            }
        }
        else{
            [weakself.navigationController popViewControllerAnimated:YES];
        }
    };
    view.leftHideMindBlock = ^(NSString*title){
        if(type == Raward_oneLuckMore)
        {
            if([weakself.comefrom isEqualToString:@"paysuccess"] || [weakself.comefrom isEqualToString:@"payfail"] || [weakself.comefrom isEqualToString:@"newbie"])
            {
                if(weakself.robCount >0)//免费次数如果还有就不用下单支付
                {
                    weakself.robCount --;
                    [weakself.roationView startRotainAnimation:weakself.is_orNotPreze];
                }else{
                    [weakself OrderHttp];
                }
            }else{
                weakself.robCount --;
                [weakself.roationView startRotainAnimation:weakself.is_orNotPreze];
            }
            
        }else if (type == Detail_OneYuanDeductible)//余额返回说明 再抢一次
        {
            [weakself OrderHttp];
        }else if (type == Raward_oneLuckPrize)
        {
            if([title isEqualToString:@"去申请发货"])
            {
                MyOrderViewController *myorder = [[MyOrderViewController alloc]init];
                myorder.hidesBottomBarWhenPushed = YES;
                myorder.tag=999;
                myorder.status1=@"0";
                
                Mtarbar.selectedIndex=4;
                UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[4];
                nv.navigationBarHidden = YES;
                [nv pushViewController:myorder animated:YES];
//                [nv setViewControllers:[NSArray arrayWithObject:myorder]];
            }
            else if(self.dataArray.count)
            {
                ShopDetailModel *orderShopmodel=_dataArray[0];
                OrderDetailViewController *order=[[OrderDetailViewController alloc]init];
                order.orderModel=orderShopmodel;
                [self.navigationController pushViewController:order animated:YES];
            }
        }else if (type == Raward_oneLuckRule)
        {
            weakself.robCount --;
            if(weakself.robCount >= 0){//直接抽奖
                weakself.isActiveRule = NO;
                [weakself.roationView startRotainAnimation:weakself.is_orNotPreze];
            }else{//抽奖次数不足去下单
                [weakself OrderHttp];
            }
        }else if (type == Raward_oneLuckNOPrize)
        {
            if([title isEqualToString:@"免费再抢一轮"] || [title isEqualToString:@"再免费领一轮"])
            {
                [weakself startLuck_LotteryHttp:YES];
            }else if([title isEqualToString:@"退款进度"])
            {
            if([self.navigationController.viewControllers[self.navigationController.viewControllers.count-2]isKindOfClass:NSClassFromString(@"MyOrderViewController")])
                {
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    
                    MyOrderViewController *myorder = [[MyOrderViewController alloc]init];
                    myorder.hidesBottomBarWhenPushed = YES;
                    myorder.tag=999;
                    myorder.status1=@"0";
                    
                    Mtarbar.selectedIndex=4;
                    UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[4];
                    nv.navigationBarHidden = YES;
                    [nv pushViewController:myorder animated:YES];
                }
            }else if([title isEqualToString:@"再点一轮"]){
            
                if(weakself.robCount >0)//免费次数如果还有就不用下单支付
                {
                    weakself.robCount --;
                    [weakself.roationView startRotainAnimation:weakself.is_orNotPreze];
                }else{
                    [weakself OrderHttp];
                }
            }
            else{
                [weakself.navigationController popViewControllerAnimated:YES];
            }
        }
        else{
            if(!weakself.isActiveRule)
            {
                weakself.robCount --;
                [weakself.roationView startRotainAnimation:weakself.is_orNotPreze];
            }else
                weakself.isActiveRule = NO;
        }
    };
    
    [self.view addSubview:self.vitaliview];
}
#pragma mark *********************数据***********************

#pragma mark 购买支付生成订单-支付1元抽奖
-(void)OrderHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    
    NSString *urlStr1 = [NSString stringWithFormat:@"%@order/addOrderAg?version=%@&token=%@&order_code=%@",[NSObject baseURLStr],VERSION,token,self.order_code];
    NSString *URL = [MyMD5 authkey:urlStr1];
    
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        MyLog(@"%@",responseObject);
        if(responseObject[@"orderToken"]!=nil)
            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"orderToken"] forKey:ORDER_TOKEN];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                _once_more = YES;
                NSString* tri = [NSString stringWithFormat:@"%@",responseObject[@"tri"]];
                NSString* vip_type = [NSString stringWithFormat:@"%@",responseObject[@"vip_type"]];
                
                NSString* order_code =[NSString stringWithFormat:@"%@",responseObject[@"order_code"]];
                self.order_code = order_code;
                
                CGFloat price = [responseObject[@"price"] floatValue];
                [DataManager sharedManager].app_value = price;
                
                if(tri.intValue == 1)//去补卡
                {
                    AddMemberCardViewController *addmember = [[AddMemberCardViewController alloc]init];
                    addmember.vip_type = vip_type;
                    [self.navigationController pushViewController:addmember animated:YES];
                }else if (tri.intValue == 2)//去办卡
                {
                    AddMemberCardViewController *addcard = [[AddMemberCardViewController alloc]init];
                    addcard.vip_type = vip_type;
                    [self.navigationController pushViewController:addcard animated:YES];
                }else if (price == 0)//不用支付直接抽奖
                {
                    [self startLuck_LotteryHttp:YES];//初始化抽奖
                }
                else{
                    TFPayStyleViewController*paystyle=[[TFPayStyleViewController alloc]init];
                    paystyle.price = price;
                    paystyle.urlcount=@"1";
                    paystyle.order_code=order_code;
                    paystyle.requestOrderDetail=1;
                    paystyle.shop_from = @"9";
                    [self.navigationController pushViewController:paystyle animated:YES];
                }
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

//获取额度
- (void)geteduHttp
{
    NSString *urlStr1 = [NSString stringWithFormat:@"%@wallet/extractNewData?version=%@",[NSObject baseURLStr],VERSION];
    NSString *URL1 = [MyMD5 authkey:urlStr1];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:URL1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1)
            {
                if(responseObject[@"data"])
                {
                    NSArray *dataArr = responseObject[@"data"];
                    for(int i = 0;i<dataArr.count;i++)
                    {
                        NSString *jsonstr = dataArr[i];
                        
                        RawardModel*model = [self getDataFromstr:jsonstr Type:1];
                        [self.realPtyaArray addObject:model];
                    }
                }
            }
            else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
            
            [self getNeWArray];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
    
}

//疯抢中订单信息
- (void)luckDrawOrderData:(NSDictionary*)dic
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
        ShopDetailModel *model=_dataArray[0];
        [DataManager sharedManager].app_value = model.order_price.floatValue;
        [DataManager sharedManager].orderShopAarray = @[model];
        [self setVitalityPopMindView:Raward_oneLuckPrize];
    }
}


-(void)requestHttp:(NSInteger)page
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    NSString *cutpage=[NSString stringWithFormat:@"%ld",(long)page];
    NSString *url;
   
    url = [NSString stringWithFormat:@"%@order/getBuyOrder?version=%@&token=%@&page=%@&status=%@&order=desc",[NSObject baseURLStr],VERSION,token,cutpage,@"0"];
    
    NSString *URL=[MyMD5 authkey:url];
  
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        //responseObject = [NSDictionary changeType:responseObject];
        
        MyLog("responseObject is %@",responseObject);
        
        if (responseObject!=nil) {
            
            NSString *str=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(str.intValue==1){
                
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
                            shopmodel.requestNow_time=responseObject[@"now"];
                            
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
                        ShopDetailModel *orderShopmodel=_dataArray[0];
                        OrderDetailViewController *order=[[OrderDetailViewController alloc]init];
                        order.orderModel=orderShopmodel;
                        [self.navigationController pushViewController:order animated:YES];
                    }
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
        
        
        [MBProgressHUD hideHUDForView:self.view];
        
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    
}
#pragma mark 开始抽奖 抽奖初始化
- (void)startLuck_LotteryHttp:(BOOL)paysuccess
{
    kWeakSelf(self);
    [LuckModel getLuckHttpLotteryDraw:self.order_code FirstGroup:self.firstGroup Success:^(id data) {
        LuckModel *luckmodel = data;
        
        if(luckmodel.status == 1)
        {
           
            //获取用户是否可中奖
            [LuckModel getLuckHttpOrNotPrize:^(id data) {
                LuckModel *model = data;
                if(model.status == 1)
                {
                    self.is_orNotPreze = model.OrNotPrize;
                }else{
                    self.is_orNotPreze = 1;
                }
                if(self.firstGroup == 2 || self.shouye3Free)
                {
                    self.is_orNotPreze = 0;
                }
                
                weakself.robCount = luckmodel.remainder > 0 ? luckmodel.remainder : 0;
                weakself.global_firstGroup = luckmodel.firstGroup ? luckmodel.firstGroup:0;
                weakself.is_orNotPreze = self.is_orNotPreze;
                
                [weakself setVitalityPopMindView:Raward_oneLuckRule];//活动规则弹框
            }];
        }else{
            [MBProgressHUD show:luckmodel.message icon:nil view:weakself.view];
        }
    }];
    
}
- (RawardModel*)getDataFromstr:(NSString*)strdata Type:(NSInteger)type
{
    //type 1是额度 2是衣豆
    NSData *jsonData = [strdata dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    MyLog(@"dic = %@",dic);
    
    if(dic)
    {
        RawardModel *model = [[RawardModel alloc]init];
        model.headpic = [NSString stringWithFormat:@"%@",dic[@"pic"]];
        
        if(type == 1)
        {
            
            model.price = [NSString stringWithFormat:@"%@",dic[@"num"]];
            model.type = [NSString stringWithFormat:@"%@",dic[@"type"]];
            model.title = [NSString stringWithFormat:@"%@ %@",dic[@"nname"],[self gettitileStr:model.type.intValue]];
            
        }
        return model;
    }
    
    return nil;
}

//真实数据 虚拟数据交替合并在一起
- (void)getNeWArray
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.realPtyaArray.count)
        {
            [self.totalPtyaArray removeAllObjects];
            
            for(int i = 0;i<self.fictitiousPtyaArray.count;i++)
            {
                if(self.realPtyaArray.count>i)
                {
                    RawardModel *model = self.realPtyaArray[i];
                    [self.totalPtyaArray addObject:model];
                }
                
                RawardModel *model1 = self.fictitiousPtyaArray[i];
                [self.totalPtyaArray addObject:model1];
            }
            
            [self.totalPtyaArray addObjectsFromArray:self.realPtyaArray];
            [self.ptyaRwardTableView reloadData];
        }
    });
}
- (NSString*)gettitileStr:(NSInteger)type
{
    NSString *str;
    switch (type) {
        case 1:
            str = @"抽红包";
            break;
        case 2:
            str = @"抽奖退款";
            break;
        case 3:
            str = @"粉丝购物";
            break;
        case 4:
            str = @"官方赠送";
            break;

        default:
            break;
    }
    
    str = [NSString stringWithFormat:@"%.1f元买走了%@宝贝",[DataManager sharedManager].app_value,str];

    return str;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewDidAppear:animated];
    //发送疯抢的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"fightSuccess" object:nil];
}
- (void)back
{
    if(self.isTestLuckDraw)
    {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if(self.robCount > 0)
    {
        [MBProgressHUD show:@"亲，你的疯抢次数还未用完。" icon:nil view:self.view];
        return;
    }
    kWeakSelf(self);
    if(!self.roationView.is_rotating)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [MBProgressHUD show:@"现在不能返回哦" icon:nil view:self.view];
    }
}

- (NSMutableArray*)fictitiousPtyaArray
{
    if(_fictitiousPtyaArray == nil)
    {
        _fictitiousPtyaArray = [NSMutableArray array];
    }
    
    return _fictitiousPtyaArray;
}

- (NSMutableArray*)totalPtyaArray
{
    if(_totalPtyaArray == nil)
    {
        _totalPtyaArray = [NSMutableArray array];
    }
    return _totalPtyaArray;
}
- (NSMutableArray*)dataArray
{
    if(_dataArray == nil)
    {
       _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray*)realPtyaArray
{
    if(_realPtyaArray == nil)
    {
        _realPtyaArray = [NSMutableArray array];
    }
    return _realPtyaArray;
}
- (void)dealloc
{
    [self.mytimer invalidate];
    self.mytimer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
