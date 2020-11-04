//
//  LuckdrawViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 2016/12/8.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "LuckdrawViewController.h"
#import "GlobalTool.h"
#import "RawardModel.h"
#import "SUTableView.h"
#import "CFPopView.h"
#import "VitalityTaskPopview.h"
#import "ScrollView_public.h"
#import "TFPopBackgroundView.h"
#import "DJRoationView.h"
#import "RawardRedPopview.h"
#import "TaskCollectionVC.h"
#import "RawardTableViewCell.h"
#import "TFWithdrawCashViewController.h"
#import "AXSampleNavBarTabViewController.h"
#import "TFCollocationViewController.h"
#import "TFActivityShopVC.h"
#import "VitalityModel.h"
#import "GuideLuckModel.h"
#import "TFMyWalletViewController.h"
#import "LuckModel.h"
#import "AffirmOrderViewController.h"
#import "OrderDetailViewController.h"
#import "FriendSharePopview.h"
#import "TypeShareModel.h"
#define AppWidth [[UIScreen mainScreen] bounds].size.width
#define AppHeight [[UIScreen mainScreen] bounds].size.height


@interface LuckdrawViewController ()
@property (nonatomic, strong) NSTimer *mytimer;
@property (nonatomic, strong) VitalityTaskPopview *vitaliview;
@property (nonatomic, strong) RawardRedPopview *redPopView;
@property (nonatomic, strong) UILabel *mondayLab;
@property (nonatomic, strong) GuideLuckModel *guideModel;  //抽奖减半信息
@property (nonatomic, assign) BOOL is_open;                //是否有抽奖减半资格
@property (nonatomic, assign) BOOL is_luckGoing;           //是否正在抽奖
@property (nonatomic, assign) NSInteger twofoldness;       //抽奖减的倍数
@end

@implementation LuckdrawViewController
{
    int _ptyacount;
    int _yiducount;
    
    int _peas;               //可用衣豆
    int _peas_free;          //冻结衣豆
    float _extract;          //可提现额度
    float _ex_free;          //冻结额度
    float _balance;          //总余额
    float _freeze_balance;   //冻结金额
    float _raward;           //中奖金额
    NSInteger _rawardtype;   //奖励分类0额度 1现金
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(!self.mondaytype)
    {
        self.mondaytype=[DataManager sharedManager].IS_Monday==YES?Mondytype_YES:Mondytype_NO;
    }
    [self creatUI];
    
    [self creatData];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(self.is_comefromeRed)//悬浮红包
    {
        if(self.is_OrderRedLuck)
        {
            [self httpGetRedMoneyLeastNum];
        }else{
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"RedMoneyLeastNum"] integerValue]!=-1 && [[NSUserDefaults standardUserDefaults]objectForKey:@"RedMoneyLeastNum"] !=nil )
                [self setVitalityPopMindView:Order_red_fiveOver];
        }
        self.is_comefromeRed = NO;
    }
    else{
        if(self.is_fromOrder)//订单支付成功后的处理
        {
            if([DataManager sharedManager].IS_Monday==YES)//疯狂星期一订单
            {
                kWeakSelf(self);
                [self getluckLotteryNumber:^{
                    [weakself setVitalityPopMindView:Raward_twentyChance];
                }];
                
            }else if ([DataManager sharedManager].is_guideOrder){//引导支付
                
                kWeakSelf(self);
                [self getGuideOder:^{
                    if(weakself.is_open){
                        if(self.twofoldness != 0)
                        {
                            self.OldLotteryNumber = self.OrderGetYidou/(10/self.twofoldness);
                        }
                        [self setVitalityPopMindView:GuideOrder_paysuccess];
                        [DataManager sharedManager].is_guideOrder = NO;
                    }
                } Fail:^{
                    
                }];
            }else{//普通订单
                
                [self setVitalityPopMindView:Raward_paySuccess_yidou];
            }
//            self.is_fromOrder=NO;
        }else{//提现额度说明弹框
            NSString *popcount = [[NSUserDefaults standardUserDefaults]objectForKey:LUCK_POPUP];
            if(popcount.intValue <2 && !self.is_fromOrder)//从购买过来的就不弹
            {
//                [self discription];
                popcount = [NSString stringWithFormat:@"%d",popcount.intValue+1];
                [[NSUserDefaults standardUserDefaults] setObject:popcount forKey:LUCK_POPUP];
            }else{
                if(!self.is_fromOrder)//从购买过来的就不弹
                {
                    [LuckModel getLuckHttpRedCount:^(id data) {
                        
                        LuckModel *model = data;
                        if(model.status == 1 && model.data >0 && !self.redPopView)
                        {
                            self.OldLotteryNumber = (NSInteger)model.data;
                            [self setVitalityPopMindView:Raward_howMuchChance];//余额抽奖
                        }
                    }];
                }
            }
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [TypeShareModel getNewbieHTTP:^(TypeShareModel *data) {
        TypeShareModel *model = data;
        if(model.status == 1)
        {
            self.mondayLab.text = [NSString stringWithFormat:@"剩余%d次疯狂抽奖机会",model.LotteryNumber.intValue];
        }
    }];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.is_fromOrder = NO;
}

#pragma mark *********************弹框***********************
#pragma mark 衣豆
- (void)setVitalityPopMindView:(VitalityType)type
{
    self.vitaliview = [[VitalityTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) VitalityType:type valityGrade:self.OldLotteryNumber YidouCount:self.OrderGetYidou];
    self.vitaliview.getYidouCount = self.OrderGetYidou;
    __weak VitalityTaskPopview *view = self.vitaliview;
   
    view.tapHideMindBlock = ^{
        
    };
    view.closeMindBlock = ^{
        if(type == Raward_weixin_bingding)
        {
            [self gotoRootBack];
        }
    };
    view.leftHideMindBlock = ^(NSString*title){
        
        [self gotoshop:type];
    };
    
    view.rightHideMindBlock = ^(NSString*title)
    {
        [self getyidou:type];
    };
    
    [self.view addSubview:self.vitaliview];
}

#pragma mark 抽中红包
- (void)RawardRedPopView:(RawardRedType)type
{
    RawardRedPopview *pop = [[RawardRedPopview alloc] initWithHeadImage:nil contentText:nil upButtonTitle:nil downButtonTitle:nil RawardType:type Raward:_raward CashorEdu:_rawardtype];
//    [pop show];
    
    __weak RawardRedPopview *redpop = pop;
    pop.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    pop.center = CGPointMake(kScreenWidth*0.5, kScreenHeight*0.5);
    [self.view addSubview:self.redPopView = pop];
    
    pop.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [UIView animateWithDuration:0.5 animations:^{
        redpop.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        redpop.backgroundView.transform = CGAffineTransformMakeScale(1, 1);
        redpop.backgroundView.alpha = 1;
    } completion:^(BOOL finish) {
        
    }];

    kWeakSelf(self);
    pop.headBlock = ^() //折红包
    {
        if(type == Rawardfive_order_open)
        {
            [weakself RawardRedPopView:Rawardfive_order_success];
        }else
            [weakself RawardRedPopView:RawardRed_success];
        
        [weakself httpGetData:^{
        
        }];
    };
    pop.dismissBlock = ^()
    {
        [weakself httpGetData:^{
            
        }];
    };
    pop.upBlock = ^() { //注册
        
        [weakself httpGetData:^{
            //上键");
            [weakself upgo:type];
        }];
        
    };
    
    pop.downBlock = ^() {// 登录
        //下键");
        [weakself downgo:type];
    };
}

//在这里抽奖
- (void)upgo:(RawardRedType)type
{
    //继续抽 //现抽一次
    if(type == RawardRed_success || type == RawardRed_fail)//衣豆抽奖
    {
        kWeakSelf(self);
        [self getGuideOder:^{//衣豆减半抽奖
            if(weakself.is_open)
            {
                NSInteger count = self.twofoldness!=0?(10/self.twofoldness):10;
                if(_peas >=10 || _peas_free >= count || _balance >= 10)
                {
                    [self.roationView startRotainAnimation:1];
                }else{
                    [self setVitalityPopMindView:Raward_noenoughyidou];
                }
            }
        }Fail:^{//正常衣豆抽奖
            
            if(self.LotteryNumber > 0)
            {
                [self.roationView startRotainAnimation:1];
            }else{
                if(_peas >=10 || _peas_free >= 10 || _balance >= 10)
                {
                    [self.roationView startRotainAnimation:1];
                }else{
                    [self setVitalityPopMindView:Raward_noenoughyidou];
                }
            }
        }];

    }else if (type == RawardMondayRed_success)//疯狂星期一抽奖
    {
        if(self.LotteryNumber > 0)
        {
            [self.roationView startRotainAnimation:1];
        }else{

            if(_peas >=10 || _peas_free >= 10 || _balance >= 10)
            {
                NSString *firstselect = [[NSUserDefaults standardUserDefaults] objectForKey:RAWARD_UP];
                if(firstselect == nil)
                {
                    [self setVitalityPopMindView:Raward_fiveyidou];
                }else{
                    [self.roationView startRotainAnimation:1];
                }
            }else{
                [self setVitalityPopMindView:Raward_noenoughyidou];
            }
        }
    }
    else if (type == Rawardfive_order_fail || type == Rawardfive_order_success)
    {
        NSString* LeastNum= [[NSUserDefaults standardUserDefaults]objectForKey:@"RedMoneyLeastNum"];
        if(LeastNum.intValue > 0)
        {
            [self.roationView startRotainAnimation:1];
        }else{
            
            kWeakSelf(self);
            [[APIClient sharedManager]netWorkGeneralRequestWithApi:@"order/getOrderRaffleNum?" caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
                if (response.status == 1) {
                    
                    NSString *money = [NSString stringWithFormat:@"%@",data[@"money"]];
                    if(money.floatValue >0)
                    {
                        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",money] forKey:@"RedMoneyRaward"];
                        [weakself setVitalityPopMindView:Order_red_fiveOver];
                    }
                }
            } failure:^(NSError *error) {
                
            }];
        }
    }
}
//下键
- (void)downgo:(RawardRedType)type
{
    if(type == RawardRed_success || type == RawardMondayRed_success)//查看额度明细
    {
        [self Quotadetail];
    }
}

#pragma mark 获取衣豆
- (void)getyidou
{
    [self setVitalityPopMindView:Raward_getyidou];
}

- (void)gotoshop:(VitalityType)type
{
    if(type == Raward_getyidou)
    {
        Mtarbar.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if (type == Raward_noenoughyidou)
    {
//        AXSampleNavBarTabViewController *vc = [[AXSampleNavBarTabViewController alloc]initWithType:YDPageVCTypeYidou peas:_peas peas_freeze:_peas_free freezeMoney:_ex_free];
//        
//        [self.navigationController pushViewController:vc animated:YES];
        
        [self setVitalityPopMindView:Raward_getyue];
        
    }else if (type == Raward_twentyChance || type == Order_red_fivieChance || type == Raward_howMuchChance)
    {
        [self.roationView startRotainAnimation:1];
    }else if (type == Raward_order_Tixian)
    {
        [self Quotadetail];
    }else if (type == Raward_fiveyidou)
    {
        if(_peas >=10 || _peas_free >= 10 || _balance >= 10)
        {
            [self.roationView startRotainAnimation:1];
        }else{
            [self setVitalityPopMindView:Raward_noenoughyidou];
        }
    }else if (type == Raward_noenoughyidou)
    {
        Mtarbar.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:NO];
    }else if (type == Order_red_fiveOver)
    {
        if ([self.navigationController.viewControllers[self.navigationController.viewControllers.count-2]isKindOfClass:NSClassFromString(@"MakeMoneyViewController")]) {
            Mtarbar.selectedIndex = 0;
            [self.navigationController popToRootViewControllerAnimated:NO];
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }else if (type == Raward_weixin_bingding)
    {
        TFMyWalletViewController *wallet = [[TFMyWalletViewController alloc]init];
        wallet.hidesBottomBarWhenPushed = YES;
        wallet.is_guide = YES;
        [self.navigationController pushViewController:wallet animated:YES];
    }else if (type == Raward_getyue)
    {
        for(UIViewController *vc in self.navigationController.viewControllers)
        {
            if([vc isKindOfClass:[MakeMoneyViewController class]]){
                
                [self.navigationController popToViewController:vc animated:YES];
                return;
            }
        }
        MakeMoneyViewController *vc = [[MakeMoneyViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (type == Super_redZeroShopping)
    {
        TFCollocationViewController *subVC = [[TFCollocationViewController alloc] init];
        subVC.page = 0;
        subVC.typeName = @"专题";
        subVC.typeID = [NSNumber numberWithInt:2];
        subVC.isFinish = YES;
        subVC.pushType = PushTypeSign;
        subVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:subVC animated:YES];
    }
}
//点这里抽奖
- (void)getyidou:(VitalityType)type
{
    if(type == Raward_noenoughyidou)
    {
        [self getyidou];
    }else if (type == Raward_fiveyidou)
    {
        kWeakSelf(self);
        [self getGuideOder:^{//衣豆减半抽奖
            if(weakself.is_open){
                NSInteger count = self.twofoldness!=0?(10/self.twofoldness):10;
                if((_peas >=10) || _peas_free + self.OrderGetYidou >= count || _balance >= 10)
                {
                    [self.roationView startRotainAnimation:1];
                }else{
                    [self setVitalityPopMindView:Raward_noenoughyidou];
                }
            }
        }Fail:^{//正常抽奖
            if(_peas >=10 || _peas_free >= 10 || _balance >= 10)
            {
                [self.roationView startRotainAnimation:1];
            }else{
                [self setVitalityPopMindView:Raward_noenoughyidou];
            }
        }];

    }else if (type == Raward_paySuccess_yidou)
    {
        if((_peas >=10) || _peas_free + self.OrderGetYidou >= 10 || _balance >= 10)
        {
            [self.roationView startRotainAnimation:1];
        }else{
            [self setVitalityPopMindView:Raward_noenoughyidou];
        }
    }else if (type == GuideOrder_paysuccess)//衣豆抽奖减半
    {
        NSString *firstselect = [[NSUserDefaults standardUserDefaults] objectForKey:RAWARD_UP];
        if(firstselect == nil)
        {
            if(self.is_open && _peas <10)//如果是衣豆减半抽奖且是用冻结衣豆抽提示用户将会消耗5个冻结衣豆
            {
                [DataManager sharedManager].guidetwofoldness = self.twofoldness;
            }
            [self setVitalityPopMindView:Raward_fiveyidou];
            [DataManager sharedManager].guidetwofoldness = 0;
        }else{
            [self.roationView startRotainAnimation:1];
        }
    }else if (type == Raward_getyue)
    {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        BOOL zeroshoppong_isfirst = [user boolForKey:ZEROSHOPPINGLUCKMENTION];
        if(!zeroshoppong_isfirst)
        {
            [user setBool:YES forKey:ZEROSHOPPINGLUCKMENTION];
            [self setVitalityPopMindView:Super_redZeroShopping];
        }else{
            Mtarbar.selectedIndex = 0;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

//购买几件商品
- (void)shoppinggo:(NSString*)dataStr
{
    NSString *value1 = dataStr;
    
    if([value1 isEqualToString:@"type_name=热卖&notType=true"])//热卖
    {
        TaskCollectionVC *vc = [[TaskCollectionVC alloc]init];
        vc.typeID = [NSNumber numberWithInt:6];
        vc.typeName = @"热卖";
        vc.title = @"热卖";
        vc.is_jingxi = YES;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([value1 isEqualToString:@"collection=shop_activity"])//活动商品
    {
        TFActivityShopVC *vc = [[TFActivityShopVC alloc]init];
        vc.isMonday = YES;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([value1 isEqualToString:@"collection=collocation_shop"])//搭配
    {
        TFCollocationViewController *testVC = [[TFCollocationViewController alloc] init];
        testVC.typeName = @"搭配";
        testVC.pushType = PushTypeSign;
        testVC.isFinish = YES;
        testVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:testVC animated:YES];
    }else if ([value1 isEqualToString:@"collection=csss_shop"])//专题
    {
        TFCollocationViewController *subVC = [[TFCollocationViewController alloc] init];
        subVC.page = 0;
        subVC.typeName = @"专题";
        subVC.typeID = [NSNumber numberWithInt:2];
        subVC.isFinish = YES;
        subVC.pushType = PushTypeSign;
        subVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:subVC animated:YES];
        
    }else if ([value1 isEqualToString:@"collection=shop_home"])//首页
    {
        Mtarbar.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    else if ([value1 isEqualToString:@"collection=shopping_page"])//购物界面
    {
        Mtarbar.selectedIndex = 1;
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    else{//其它合集(热卖)
        
        TaskCollectionVC *vc = [[TaskCollectionVC alloc]init];
        vc.typeID = [NSNumber numberWithInt:6];
        vc.typeName = @"热卖";
        vc.title = @"热卖";
        vc.is_jingxi = YES;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark 额度说明
- (void)discription
{
    BOOL going = [[NSUserDefaults standardUserDefaults] boolForKey:@"luckgoing"];
    if(self.is_luckGoing || [[NSUserDefaults standardUserDefaults] boolForKey:@"luckgoing"])
    {
        return;
    }

    CFPopView *view=[[CFPopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) textStr:@"提现额度说明" leftBtnStr:@"知道了"  rightBtnStr:@"抽提现额度" popType:CFPopTypeRed];
    
    [view show];
    [view setLeftBlock:^{
        
    } withRightBlock:^{
        
        if(_peas >=10 || _peas_free >= 10 || _balance >= 10)
        {
            [self.roationView startRotainAnimation:1];
        }else{
            [self setVitalityPopMindView:Raward_noenoughyidou];
        }
    }];
}

#pragma mark 疯狂星期一抽中红包
- (void)mondayRedpopView {
    
    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
    popView.showCancelBtn = YES;
    
    UIImageView *backgroundView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"monday_hongbao-"];
    backgroundView.userInteractionEnabled = YES;
    image = [image stretchableImageWithLeftCapWidth:0 topCapHeight:image.size.height * 0.5];
    backgroundView.image = image;
    popView.backgroundView = backgroundView;
    
    UIView *contentV = [[UIView alloc] init];
    
    popView.contentView = contentV;
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"哇喔~";
    titleLabel.textColor = RGBCOLOR_I(253, 225, 40);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:ZOOM6(48)];
    [contentV addSubview:titleLabel];
    
    UILabel *desLabel = [UILabel new];
    desLabel.text = @"抽中了一个疯狂红包!";
    desLabel.textColor = RGBCOLOR_I(253, 225, 40);
    desLabel.textAlignment = NSTextAlignmentCenter;
    desLabel.font = [UIFont boldSystemFontOfSize:ZOOM6(48)];
    [contentV addSubview:desLabel];
    
    UILabel *subLabel = [UILabel new];
    subLabel.text = @"点击拆红包可以获得随机提现额度";
    subLabel.textColor = RGBCOLOR_I(253, 229, 229);
    subLabel.textAlignment = NSTextAlignmentCenter;
    subLabel.font = kFont6px(30);
    [contentV addSubview:subLabel];
    
    UIButton *openButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [openButton setBackgroundImage:[UIImage imageNamed:@"md_chai"] forState:UIControlStateNormal];
    [contentV addSubview:openButton];
    
    /**< 布局 */
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentV.mas_top).offset(ZOOM6(160));
        make.left.and.right.equalTo(@0);
    }];
    
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(ZOOM6(15));
        make.left.and.right.equalTo(@0);
    }];
    
    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(desLabel.mas_bottom).offset(ZOOM6(20));
        make.left.and.right.equalTo(@0);
    }];
    [openButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subLabel.mas_bottom).offset(ZOOM6(40));
        make.centerX.equalTo(contentV.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(ZOOM6(180), ZOOM6(180)));
        make.bottom.equalTo(contentV.mas_bottom).offset(-ZOOM6(20));
    }];
    
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(popView.contentViewWidth);
    }];
    [contentV setNeedsLayout];
    [popView show];
    
    [openButton handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
        // 拆红包
        [popView dismissAlert:YES];
        [self RawardRedPopView:RawardMondayRed_success];
    }];
}
#pragma mark *********************数据***********************
- (void)creatData
{
    RawardModel *model = [RawardModel alloc];
    
    [self.fictitiousPtyaArray addObjectsFromArray:[model getPtyaModel:1]];
    [self.fictitiousYiduArray addObjectsFromArray:[model getYiduModel:2]];
    
    [self.totalPtyaArray addObjectsFromArray:self.fictitiousPtyaArray];
    [self.totalYiduArray addObjectsFromArray:self.fictitiousYiduArray];
    
    [self httpGetData:^{
        
    }];
    [self getyidouHttp];
    [self geteduHttp];
}

- (void)httpGetData:(void(^)())success
{
    //获取余额
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr1 = [NSString stringWithFormat:@"%@wallet/myWallet?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL1 = [MyMD5 authkey:urlStr1];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1) {
                if(success)
                {
                    success();
                }
                
                _balance = [[NSString stringWithFormat:@"%@",responseObject[@"balance"]] floatValue];
                _freeze_balance = [[NSString stringWithFormat:@"%@",responseObject[@"freeze_balance"]] floatValue];
                _extract = [[NSString stringWithFormat:@"%@",responseObject[@"extract"]] floatValue];
                _peas = [[NSString stringWithFormat:@"%@",responseObject[@"peas"]] intValue];
                _peas_free = [[NSString stringWithFormat:@"%@",responseObject[@"peas_free"]] intValue];
                _ex_free = [[NSString stringWithFormat:@"%@",responseObject[@"ex_free"]] floatValue];
                
                self.roationView.yidou = _peas<10?_peas_free:_peas;
                self.roationView.balance = _balance;
                
                [self refrestHeadUI];
            } else {
//                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
    
}

//获取额度
- (void)geteduHttp
{
    NSString *urlStr1 = [NSString stringWithFormat:@"%@wallet/extractNewData?version=%@",[NSObject baseURLStr],VERSION];
    NSString *URL1 = [MyMD5 authkey:urlStr1];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            
//            NSArray *dataArr = [NSArray array];
            
            if ([responseObject[@"status"] intValue] == 1)
            {
                if(responseObject[@"data"])
                {
                    NSArray *dataArr = responseObject[@"data"];
                    for(int i = 0;i<dataArr.count;i++)
                    {
                        NSString *jsonstr = dataArr[i];
                        
                        [self getDataFromstr:jsonstr Type:1];
                    }
                    
                    [self getNeWArray];
                }
            }
            else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
}

//获取衣豆记录
- (void)getyidouHttp
{
    NSString *urlStr1 = [NSString stringWithFormat:@"%@wallet/getNewData?version=%@",[NSObject baseURLStr],VERSION];
    NSString *URL1 = [MyMD5 authkey:urlStr1];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            
//            NSArray *dataArr = [NSArray array];
            if ([responseObject[@"status"] intValue] == 1)
            {
                if(responseObject[@"data"])
                {
                    NSArray *dataArr = responseObject[@"data"];
                    for(int i = 0;i<dataArr.count;i++)
                    {
                        NSString *jsonstr = dataArr[i];
                        
                        [self getDataFromstr:jsonstr Type:2];
                    }
                    
                    [self getNeWArray];
                }

            }
            else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
}


- (void)getDataFromstr:(NSString*)strdata Type:(NSInteger)type
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
            
            [self.realPtyaArray addObject:model];
        }else if (type == 2)
        {
            model.title = [NSString stringWithFormat:@"%@ %@",dic[@"nname"],dic[@"p_name"]];
            model.price = [NSString stringWithFormat:@"%@",dic[@"num"]];
           
            [self.realYiduArray addObject:model];
        }
        
    }

}

//真实数据 虚拟数据交替合并在一起
- (void)getNeWArray
{
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

        [self.ptyaRwardTableView reloadData];
    }
    
    if(self.realYiduArray.count)
    {
        [self.totalYiduArray removeAllObjects];
        
        for(int i = 0;i<self.fictitiousYiduArray.count;i++)
        {
            if(self.realYiduArray.count>i)
            {
                RawardModel *model = self.realYiduArray[i];
                [self.totalYiduArray addObject:model];
            }
            
            RawardModel *model1 = self.fictitiousYiduArray[i];
            
            [self.totalYiduArray addObject:model1];
            
        }
        
        [self.yiduRwardTableView reloadData];
        
    }

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

    str = [NSString stringWithFormat:@"%@获得提现额度",str];
    return str;
}

#pragma mark 获取抽奖次数
- (void)getluckLotteryNumber:(void(^)())success
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@signIn2_0/getCount?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            if(statu.intValue==1)
            {
                self.LotteryNumber = [[NSString stringWithFormat:@"%@",responseObject[@"LotteryNumber"]] intValue];
                if(self.LotteryNumber > 0)
                {
                    [self refrestHeadUI];
                    
                    if(success)
                    {
                        success();
                    }
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"网络连接失败，请检查网络设置~" Controller:self];
    }];
}

//获取抽奖减半的资格
- (void)getGuideOder:(void(^)())success Fail:(void(^)())fail
{
    kWeakSelf(self);
    [GuideLuckModel getGuideLuckHttpSuccess:^(id data) {
        weakself.guideModel = data;
        if(weakself.guideModel.status == 1)
        {
            self.is_open = [weakself.guideModel.data[@"is_open"] boolValue];
            self.twofoldness = [weakself.guideModel.data[@"twofoldness"] integerValue];
            
            long long now = ((NSNumber*)weakself.guideModel.now).longLongValue;
            long long end = ((NSNumber*)weakself.guideModel.data[@"end_date"]).longLongValue;
            self.is_open = now > end?NO:YES;
            
            if(self.is_open)
            {
                if(success)
                {
                    success();
                }
            }else{
                if(fail)
                {
                    fail();
                }
            }
        }else{
            self.is_open = NO;
            if(fail)
            {
                fail();
            }
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
            if([data[@"data"] integerValue] > 0)
            {
                [weakSelf setVitalityPopMindView:Order_red_fivieChance];//5次机会
            }else{
                self.is_OrderRedLuck = NO;
                [self.roationView loadMainImage];
                [weakSelf setVitalityPopMindView:Order_red_fiveOver];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

//获取用户是否绑定了微信   (自动提现)
- (void)httpGetWXOpenID {
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:@"wallet/getWxOpenid?" caches:NO cachesTimeInterval:0*TFMinute token:YES success:^(id data, Response *response) {
        if (response.status == 1) {
            NSNumber *dataNumber = data[@"data"];
            if (dataNumber.integerValue==0) {//0否1是
                [self setVitalityPopMindView:Raward_weixin_bingding];
            }else{
                
                [self gotoRootBack];
            }
        }else{
            [self gotoRootBack];
        }
    } failure:^(NSError *error) {
        [self gotoRootBack];
    }];
}

- (void)gotoRootBack
{
    if(self.is_fromOrder)//是支付过来的
    {
//        [[DataManager sharedManager] paySuccessMentionView];
        
        //购买并支付完成后直接跳抽奖，抽奖返回必须返回“确认订单页面”之前的页面
        if(self.navigationController.viewControllers.count >= 5)
        {
            UIViewController *vc = self.navigationController.viewControllers[self.navigationController.viewControllers.count-5];
            [self.navigationController popToViewController:vc animated:YES];
        }else{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        return ;
    }

    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark *********************UI界面***********************
- (void)creatUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatNavagationbar];
    
    [self creatLuckMainView];
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
    titlelable.text=@"提现额度";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [self.tabheadview addSubview:titlelable];
    
    UIButton* discriptionBtn=[[UIButton alloc]init];
    discriptionBtn.frame=CGRectMake(kApplicationWidth-ZOOM6(180), 23, ZOOM6(160), 40);
    discriptionBtn.centerY = View_CenterY(self.tabheadview);
    [discriptionBtn setTitle:@"额度说明" forState:UIControlStateNormal];
    discriptionBtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM6(32)];
    [discriptionBtn setTitleColor:RGBCOLOR_I(125, 125, 125) forState:UIControlStateNormal];
    discriptionBtn.tag=1111;
    [discriptionBtn addTarget:self action:@selector(discription) forControlEvents:UIControlEventTouchUpInside];
    [self.tabheadview addSubview:discriptionBtn];

}

//主界面
- (void)creatLuckMainView
{
    self.myScrollview = [[UIScrollView alloc]init];
    self.myScrollview.userInteractionEnabled = YES;
    self.myScrollview.backgroundColor = self.mondaytype==Mondytype_YES?RGBCOLOR_I(142, 76, 226):RGBCOLOR_I(234, 131, 253);
    self.myScrollview.contentMode =UIViewContentModeScaleAspectFill;
    self.myScrollview.contentSize = CGSizeMake(0, 1000);
    [self.view addSubview:self.myScrollview];
    
    UIButton *getyibtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    getyibtn.backgroundColor = tarbarrossred;
    [getyibtn setTintColor:[UIColor whiteColor]];
    getyibtn.layer.cornerRadius = 5;
    getyibtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    NSString *title = self.mondaytype==Mondytype_YES?@"获取抽奖机会":@"获取衣豆";
    [getyibtn setTitle:title forState:UIControlStateNormal];
    [getyibtn addTarget:self action:@selector(getyidou) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getyibtn];
    
    [self.myScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tabheadview.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(kScreenHeight-Height_NavBar-ZOOM6(120)));

    }];

    [getyibtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myScrollview.mas_bottom).offset(ZOOM6(20));
        make.left.equalTo(self.myScrollview).offset(ZOOM6(20));
        make.right.equalTo(self.myScrollview).offset(-ZOOM6(20));
        make.height.equalTo(@ZOOM6(80));
    }];
    
    [self creatHeadView];
    
    [self creatLuckView];
    
    [self creatTabview];
}

//头部
- (void)creatHeadView
{
    CGFloat headheight = self.mondaytype==Mondytype_YES?kScreenWidth*1.52:kScreenWidth*1.29;
    
    self.headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, headheight)];
    self.headView.userInteractionEnabled = YES;
    self.headView.image = self.mondaytype==Mondytype_YES?[UIImage imageNamed:@"monday_提现额度-bg"]:[UIImage imageNamed:@"bg_choujiang.jpg"];
    [self.myScrollview addSubview:self.headView];
    
    UIImageView *headimage = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(20), 0, kScreenWidth-ZOOM6(20)*2, ZOOM6(130))];
    headimage.image = [UIImage imageNamed:@"bg_top"];
    headimage.userInteractionEnabled = YES;
    [self.headView addSubview:headimage];
    
    CGFloat labwith = CGRectGetWidth(headimage.frame)/3;
    CGFloat labheigh = CGRectGetHeight(headimage.frame);
    
    //总余额 提现额度
    for(int i = 0;i<3;i++)
    {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(30)+labwith*i, ZOOM6(10), labwith, labheigh-ZOOM6(20))];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:ZOOM6(30)];
        lable.numberOfLines = 0;;
        lable.textColor = [UIColor redColor];
        if(i==0)
        {
            NSString *str = @"0.00";
            lable.text = [NSString stringWithFormat:@"%.2f\n总金额(元)",[str floatValue]];
            [self getBalancemutable:lable Text:str];
            
            self.totalbalanceLab = lable;

        }else if (i == 1)
        {
            NSString *str = @"0.00";
            lable.text = [NSString stringWithFormat:@"%.2f\n可提现(元)",[str floatValue]];
            [self getBalancemutable:lable Text:str];
            
            self.availablebalanceLab = lable;
        }else{
            lable.frame = CGRectMake(CGRectGetWidth(headimage.frame)-ZOOM6(180), (labheigh - ZOOM6(60))/2+ZOOM6(10), ZOOM6(160), ZOOM6(60));
            lable.userInteractionEnabled = YES;
            lable.backgroundColor = tarbarrossred;
            lable.textColor = [UIColor whiteColor];
            lable.clipsToBounds = YES;
            lable.layer.cornerRadius = 5;
            lable.text = @"提现";
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tixian)];
            [lable addGestureRecognizer:tap];
        }
        
        [headimage addSubview:lable];
    }
    
    CGFloat yilabWith =(CGRectGetWidth(self.headView.frame) - ZOOM6(40)*3)/2;
    //可用衣豆 提现衣豆
    for(int i =0;i<2;i++)
    {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(40)+(yilabWith+ZOOM6(40))*i, ZOOM6(160), yilabWith, ZOOM6(40))];
        lable.backgroundColor = RGBCOLOR_I(87, 66, 129);
        lable.font = [UIFont systemFontOfSize:ZOOM6(24)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor whiteColor];
        lable.layer.cornerRadius = ZOOM6(40)/2;
        lable.clipsToBounds = YES;
        lable.tag = 20000+i;
        
        NSString *str = @"0";
        if(i == 0)
        {
            lable.text = [NSString stringWithFormat:@"可用衣豆:%@",str];
            self.availableyidouLab = lable;
        
        }else if (i == 1)
        {
            lable.text = [NSString stringWithFormat:@"冻结衣豆:%@",str];
            self.frozenyidouLab = lable;
        }
        
        lable.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(yidoumingxi:)];
        [lable addGestureRecognizer:tap];

        NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:lable.text];
        [mutable addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:ZOOM6(30)] range:NSMakeRange(5, str.length)];
        [lable setAttributedText:mutable];

        [self.headView addSubview:lable];
    }
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    button.frame = CGRectMake(CGRectGetWidth(self.headView.frame)-ZOOM6(200), ZOOM6(160), ZOOM6(160), ZOOM6(40));
//    [button setBackgroundImage:[UIImage imageNamed:@"edmx"] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(Quotadetail) forControlEvents:UIControlEventTouchUpInside];
//    [self.headView addSubview:button];
    
    //疯狂星期一
    self.mondayLab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), ZOOM6(360), kScreenWidth-ZOOM6(20)*2, ZOOM6(40))];
    self.mondayLab.text = [NSString stringWithFormat:@"剩余%d次疯狂抽奖机会",(int)self.LotteryNumber];
    self.mondayLab.textColor = [UIColor whiteColor];
    self.mondayLab.font = [UIFont systemFontOfSize:ZOOM6(36)];
    self.mondayLab.textAlignment = NSTextAlignmentCenter;
    self.mondayLab.hidden = self.mondaytype==Mondytype_YES?NO:YES;
    [self.headView addSubview:self.mondayLab];
    
    NSString *numberStr = [NSString stringWithFormat:@"%ld",(long)self.LotteryNumber];
    NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:self.mondayLab.text];
    [mutable addAttribute:NSForegroundColorAttributeName value:RGBCOLOR_I(255, 244, 0) range:NSMakeRange(2, numberStr.length)];
    [self.mondayLab setAttributedText:mutable];
}

//刷新头部
- (void)refrestHeadUI
{
    if(_balance >= 0)
    {
        CGFloat bb = 0;
        if ([DataManager sharedManager].isOligible&&[DataManager sharedManager].isOpen&&([DataManager sharedManager].twofoldness > 0)) {
            
            bb = [DataManager sharedManager].twofoldness *_balance +_freeze_balance;
        }else{
            bb = _balance +_freeze_balance;
        }

        self.totalbalanceLab.text = [NSString stringWithFormat:@"%.2f\n总金额(元)",bb];
        [self getBalancemutable:self.totalbalanceLab Text:[NSString stringWithFormat:@"%.2f",bb]];
    }
    
    if(_extract+_ex_free >=0)
    {
        self.availablebalanceLab.text = [NSString stringWithFormat:@"%.2f\n可提现(元)",_extract+_ex_free];
        [self getBalancemutable:self.availablebalanceLab Text:[NSString stringWithFormat:@"%.2f",_extract+_ex_free]];
    }
    
    self.availableyidouLab.text = [NSString stringWithFormat:@"可用衣豆:%d",_peas];
    [self getYidoumutable:self.availableyidouLab Yidou:_peas];
    
    self.frozenyidouLab.text = [NSString stringWithFormat:@"冻结衣豆:%d",_peas_free];
    [self getYidoumutable:self.frozenyidouLab Yidou:_peas_free];
    
    if(self.LotteryNumber >=0)
    {
        self.mondayLab.text = self.LotteryNumber==0?[NSString stringWithFormat:@"  %d次疯狂抽奖机会",(int)self.LotteryNumber]:[NSString stringWithFormat:@"剩余%d次疯狂抽奖机会",(int)self.LotteryNumber];
        
        NSString *numberStr = [NSString stringWithFormat:@"%ld",(long)self.LotteryNumber];
        NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:self.mondayLab.text];
        [mutable addAttribute:NSForegroundColorAttributeName value:RGBCOLOR_I(255, 244, 0) range:NSMakeRange(2, numberStr.length)];
        [self.mondayLab setAttributedText:mutable];
        
        self.roationView.LotteryNumber = (int)self.LotteryNumber;
    }
}

- (void)getBalancemutable:(UILabel*)lab Text:(NSString*)text
{
    NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:lab.text];
    
    [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(48)] range:NSMakeRange(0, text.length)];
    [lab setAttributedText:mutable];

}

- (void)getYidoumutable:(UILabel*)lab Yidou:(int)yidou
{
    NSString *str = [NSString stringWithFormat:@"%d",yidou];
    
    NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:lab.text];
    [mutable addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:ZOOM6(30)] range:NSMakeRange(5, str.length)];
    [lab setAttributedText:mutable];
}
#pragma mark 转盘
- (void)creatLuckView
{
    CGFloat YY = self.mondaytype == Mondytype_YES?ZOOM6(550):ZOOM6(400);
    CGFloat roatwith = ZOOM6(550);
    self.roationView = [[DJRoationView alloc] initWithFrame:CGRectMake((kScreenWidth-roatwith)/2,YY, roatwith, roatwith)];
    self.roationView.speed = 20;//调速度 最快20;
    int yidou = _peas<10?_peas_free:_peas;
    
//    self.mondaytype == Mondytype_YES?(self.roationView.yidou = yidou):(self.roationView.LotteryNumber=(int)self.LotteryNumber);
//    if(self.mondaytype == Mondytype_YES)
//    {
//        self.roationView.yidou = yidou;
//        self.roationView.balance = _balance;
//    }else{
//        self.roationView.LotteryNumber=(int)self.LotteryNumber;
//    }
    
    self.roationView.yidou = yidou;
    self.roationView.balance = _balance;
    self.roationView.LotteryNumber=(int)self.LotteryNumber;
    
    self.roationView.is_OrderRedLuck = self.is_OrderRedLuck;
    [self.headView addSubview:self.roationView];
    
    kWeakSelf(self);
    self.roationView.startRotainBlock = ^(NSString *title)
    {
        weakself.is_luckGoing = (title.intValue==1)?YES:NO;
        if(weakself.is_OrderRedLuck)//红包抽的
        {
            NSString* LeastNum= [[NSUserDefaults standardUserDefaults]objectForKey:@"RedMoneyLeastNum"];
            if(LeastNum.intValue > 0)
            {
                [weakself.roationView startRotainAnimation:1];
            }else{
                
                [[APIClient sharedManager]netWorkGeneralRequestWithApi:@"order/getOrderRaffleNum?" caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
                    if (response.status == 1) {
                        
                        NSString *money = [NSString stringWithFormat:@"%@",data[@"money"]];
                        if(money.floatValue >0)
                        {
                            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",money] forKey:@"RedMoneyRaward"];
                            [weakself setVitalityPopMindView:Order_red_fiveOver];
                        }
                    }
                } failure:^(NSError *error) {
                    
                }];
            }
        }else if(self.LotteryNumber > 0)//疯狂星期一抽的
        {
            [weakself.roationView startRotainAnimation:1];
        }else{//正常抽的
            [weakself getGuideOder:^{
                if(weakself.is_open){
                    NSInteger count = self.twofoldness!=0?(10/self.twofoldness):10;
                    if(_peas >=10 || _peas_free >= count || _balance >= 10)
                    {
                        [weakself startRaward:@"1"];//可抽奖
                    }else{
                        [weakself startRaward:@"0"];//不可抽奖
                    }
                }
            }Fail:^{
                [weakself startRaward:title];
            }];
        }
    };

    [self.roationView rotatingDidFinishBlock:^(NSInteger index, CGFloat score,CGFloat raward,NSInteger rawardtype) {
        NSLog(@"indx=%d,score=%.f",(int)index,score);
        weakself.is_luckGoing = NO;
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"luckgoing"];
        if(raward >= 0)//抽奖的额度
        {
            _raward = raward;
            _rawardtype = rawardtype;
            if(self.is_OrderRedLuck)
            {
                _balance +=raward;
            }else{
//                _extract +=raward;
            }
            
            if(weakself.mondaytype == Mondytype_YES && !self.is_OrderRedLuck)//疯狂星期一抽的
            {
                if(weakself.LotteryNumber <= 0)//没有抽奖机会用衣豆
                {
                    if(_peas >= 10)
                    {
                        _peas -= 10;
                        weakself.roationView.yidou = _peas;
                    }else if(_peas_free >= 10)
                    {
                        _peas_free -= 10;
                        weakself.roationView.yidou = _peas_free;
                    }
                    
                    if(raward == 0)
                    {
                        [weakself RawardRedPopView:RawardRed_fail];
                    }else
                        [weakself RawardRedPopView:RawardRed_open];
                }else{//有抽奖机会时
                    weakself.LotteryNumber -= 1;
                    weakself.roationView.LotteryNumber = (int)self.LotteryNumber;
                    if(raward == 0)
                    {
                        [weakself RawardRedPopView:RawardRed_fail];
                    }else{
                        [weakself mondayRedpopView];
                    }
                }
            }else if (self.is_OrderRedLuck)//订单红包抽奖
            {
                NSString *LeastNum= [[NSUserDefaults standardUserDefaults]objectForKey:@"RedMoneyLeastNum"];
                NSString *newLeasNum = [NSString stringWithFormat:@"%d",LeastNum.intValue-1];
                [[NSUserDefaults standardUserDefaults]setObject:newLeasNum forKey:@"RedMoneyLeastNum"];
                
                if(raward == 0)
                {
                    [weakself RawardRedPopView:Rawardfive_order_fail];
                }else{
                    [weakself RawardRedPopView:Rawardfive_order_open];
                }
            }
            else{//正常用衣豆抽的\引导支付衣豆减半抽的
                NSInteger count = (self.twofoldness!=0 && self.is_open)?(10/self.twofoldness):10;
                if(_peas >= 10)
                {
                    _peas -= 10;
                    weakself.roationView.yidou = _peas;
                }else if(_peas_free >= count)
                {
                    _peas_free -= count;
                    weakself.roationView.yidou = _peas_free;
                }

                if(raward == 0)
                {
                    [weakself RawardRedPopView:RawardRed_fail];
                }else
                    [weakself RawardRedPopView:RawardRed_open];
            }

        }else{
        
            [MBProgressHUD show:@"网络连接失败,请检查网络设置" icon:nil view:weakself.view];
        }
        
        
    }];//动画停止后回调
}

- (void)startRaward:(NSString*)title
{
    if(title.intValue != 0)
    {
        if(self.mondaytype == Mondytype_YES)
        {
            if(self.LotteryNumber > 0)//用抽奖机会抽的
            {
                [self.roationView startRotainAnimation:1];
            }else{//抽奖机会不足时用衣豆抽的
                
                self.roationView.yidou = _peas<10?_peas_free:_peas;
                self.roationView.balance = _balance;
                NSString *firstselect = [[NSUserDefaults standardUserDefaults] objectForKey:RAWARD_UP];
                if(firstselect == nil)
                {
                    [self setVitalityPopMindView:Raward_fiveyidou];
                }else{
                    [self.roationView startRotainAnimation:1];
                }
            }
        }else{//用衣豆抽的
            
            NSString *firstselect = [[NSUserDefaults standardUserDefaults] objectForKey:RAWARD_UP];
            if(firstselect == nil)
            {
                if(self.is_open && _peas <10)//如果是衣豆减半抽奖且是用冻结衣豆抽提示用户将会消耗5个冻结衣豆
                {
                    [DataManager sharedManager].guidetwofoldness = self.twofoldness;
                }
                [self setVitalityPopMindView:Raward_fiveyidou];
                [DataManager sharedManager].guidetwofoldness = 0;
            }else{
                [self.roationView startRotainAnimation:1];
            }
        }
        
    }else{
        [self setVitalityPopMindView:Raward_noenoughyidou];
    }

}
//列表
- (void)creatTabview
{
    int count = self.mondaytype==Mondytype_YES?1:2;
    CGFloat viewHeigh = 305;
    for(int i=0; i <count; i++)
    {
        UIView * backview = [[UIView alloc]initWithFrame:CGRectMake(ZOOM6(20), (viewHeigh+ZOOM6(20))*i+CGRectGetMaxY(self.headView.frame), kScreenWidth-ZOOM6(20)*2, viewHeigh)];
        backview.backgroundColor = [UIColor whiteColor];
        backview.layer.cornerRadius = 5;
        [self.myScrollview addSubview:backview];
        
        CGFloat imageHeigh = 20;
        UIImageView *titleimage = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(backview.frame)-imageHeigh*7.5)/2, 15, imageHeigh*7.5, imageHeigh)];
        
        UITableView *tabview = [[SUTableView alloc]initWithFrame:CGRectMake(0, 50, CGRectGetWidth(backview.frame), CGRectGetHeight(backview.frame)-55) style:UITableViewStylePlain];
        tabview.delegate = self;
        tabview.dataSource = self;
        tabview.scrollEnabled = NO;
        tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
        tabview.showsVerticalScrollIndicator = NO;
        [tabview registerNib:[UINib nibWithNibName:@"RawardTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
        
        if(i==0)
        {
            titleimage.image = [UIImage imageNamed:@"edjl"];
            self.ptyaRwardTableView = tabview;
        }else{
            titleimage.image = [UIImage imageNamed:@"ydjl"];
            self.yiduRwardTableView = tabview;
        }
        
        UIView *clearview = [[UIView alloc]initWithFrame:backview.bounds];
        clearview.backgroundColor = [UIColor clearColor];
        clearview.userInteractionEnabled = YES;
        
        [backview addSubview:titleimage];
        [backview addSubview:tabview];
        [backview addSubview:clearview];
    }

    self.myScrollview.contentSize = CGSizeMake(0, CGRectGetMaxY(self.headView.frame)+count*(305+ZOOM6(20)));
    
    self.mytimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
}


#pragma mark 提现
- (void)tixian
{
    if(self.is_luckGoing || [[NSUserDefaults standardUserDefaults] boolForKey:@"luckgoing"])
    {
        return;
    }
    NSString *usertype = [[NSUserDefaults standardUserDefaults] objectForKey:USER_CLASSIFY];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    if([usertype isEqualToString:@"0"]||[usertype isEqualToString:@"1"]||[usertype isEqualToString:@"2"])//提现引导
    {
        if(token.length > 8)
        {
//            [self popViewWithDrawCashGuide];
            [VitalityModel posguide:^(id data) {//弹了引导弹框告诉后台
                
            }];
            
            TFWithdrawCashViewController *VC = [[TFWithdrawCashViewController alloc] init];
            VC.bindNameAndIdenfBlock = ^(NSInteger sguidance) {
                
            };
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];

        }
    }else{//提现
        
        TFWithdrawCashViewController *cash = [[TFWithdrawCashViewController alloc]init];
        [self.navigationController pushViewController:cash animated:YES];
    }
}

#pragma mark 提现引导
- (void)popViewWithDrawCashGuide {
    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
    popView.showCancelBtn = YES;
    popView.rightText = @"下一步";
    popView.title = @"提现引导";
    UIView *contentV = [[UIView alloc] init];
    popView.contentView = contentV;
    
    UILabel *contentLabel = [UILabel new];
    NSString *text = @"欢迎加入衣蝠，为了让新用户能快速体验提现功能，我们特意在你的提现可提现额度中存入了1.00元现金，现在可以立即提现了哦~";
    contentLabel.textColor = RGBCOLOR_I(125, 125, 125);
    contentLabel.font = kFont6px(28);
    contentLabel.numberOfLines = 0;
    contentLabel.text = text;
    [contentV addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(contentV);
    }];
    
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(popView.contentViewWidth);
    }];
    [contentV setNeedsLayout];
    
    [popView showCancelBlock:^{
        
        [VitalityModel posguide:^(id data) {//弹了引导弹框告诉后台
            
        }];
    } withConfirmBlock:^{
        
        [VitalityModel posguide:^(id data) {//弹了引导弹框告诉后台
            
        }];
        
        TFWithdrawCashViewController *VC = [[TFWithdrawCashViewController alloc] init];
        VC.bindNameAndIdenfBlock = ^(NSInteger sguidance) {
            
        };
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } withNoOperationBlock:^{
        
        [VitalityModel posguide:^(id data) {//弹了引导弹框告诉后台
            
        }];
    }];
}

#pragma mark 额度明细
- (void)Quotadetail
{
    if(self.is_luckGoing || [[NSUserDefaults standardUserDefaults] boolForKey:@"luckgoing"])
    {
        return;
    }

    AXSampleNavBarTabViewController *vc = [[AXSampleNavBarTabViewController alloc]initWithType:YDPageVCTypeMoney peas:_balance peas_freeze:_freeze_balance extract:_extract freezeMoney:_ex_free];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)yidoumingxi:(UITapGestureRecognizer*)tap
{
    if(self.is_luckGoing || [[NSUserDefaults standardUserDefaults] boolForKey:@"luckgoing"])
    {
        return;
    }
//    int tag = tap.view.tag % 20000; //0衣豆 1冻结衣豆
    if(!self.is_fromMessage)
    {
        AXSampleNavBarTabViewController *vc = [[AXSampleNavBarTabViewController alloc]initWithType:YDPageVCTypeYidou peas:_peas peas_freeze:_peas_free extract:_extract freezeMoney:_ex_free];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.ptyaRwardTableView)
    {
        return self.self.totalPtyaArray.count;
    }else{
        return self.totalYiduArray.count;
    }
    
    return 0;
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
    
    if(tableView == self.ptyaRwardTableView)
    {
        RawardModel *model = self.totalPtyaArray[indexPath.row];
        [cell refreshData:model];
    }else{
        RawardModel *model = self.totalYiduArray[indexPath.row];
        [cell refreshData:model];
    }
    return cell;

}

- (void) tick:(NSTimer *)time {
    
    _ptyacount ++;
    _yiducount ++;
    //(25.0 / 30.0) * (float)self.count) ---> (tableview需要滚动的contentOffset / 一共调用的次数) * 第几次调用
    //比如该demo中 contentOffset最大值为 = cell的高度 * cell的个数 ,5秒执行一个循环则调用次数为 300,没1/60秒 count计数器加1,当count=300时,重置count为0,实现循环滚动.
    
    if(_ptyacount == 0)
    {
        [self.ptyaRwardTableView setContentOffset:CGPointMake(0, 50 * (float)_ptyacount) animated:NO];
       
    }else{
        
        [UIView animateWithDuration:3.0 animations:^{
           
            [self.ptyaRwardTableView setContentOffset:CGPointMake(0, 50 * (float)_ptyacount) animated:NO];
        }];
        
//        [self.ptyaRwardTableView setContentOffset:CGPointMake(0, 50 * (float)_ptyacount) animated:YES];
      
    }
    
    if(_yiducount == 0)
    {
        [self.yiduRwardTableView setContentOffset:CGPointMake(0, 50 * (float)_yiducount) animated:NO];
    }else{
        
        [UIView animateWithDuration:3.0 animations:^{
            
             [self.yiduRwardTableView setContentOffset:CGPointMake(0, 50 * (float)_yiducount) animated:NO];
            
        }];

//        [self.yiduRwardTableView setContentOffset:CGPointMake(0, 50 * (float)_yiducount) animated:YES];
    }

    if (_ptyacount >= self.totalPtyaArray.count*2) {
        
        _ptyacount = -1;
    }
    
    if (_yiducount >= self.totalYiduArray.count*2) {
        
        _yiducount = -1;
    }
}

#pragma mark 懒加载
- (NSMutableArray*)fictitiousPtyaArray
{
    if(_fictitiousPtyaArray == nil)
    {
        _fictitiousPtyaArray = [NSMutableArray array];
    }
    
    return _fictitiousPtyaArray;
}

- (NSMutableArray*)realPtyaArray
{
    if(_realPtyaArray == nil)
    {
        _realPtyaArray = [NSMutableArray array];
    }
    return _realPtyaArray;
}

- (NSMutableArray*)totalPtyaArray
{
    if(_totalPtyaArray == nil)
    {
        _totalPtyaArray = [NSMutableArray array];
    }
    return _totalPtyaArray;
}

- (NSMutableArray*)fictitiousYiduArray
{
    if(_fictitiousYiduArray == nil)
    {
        _fictitiousYiduArray = [NSMutableArray array];
    }
    return _fictitiousYiduArray;
}

- (NSMutableArray*)realYiduArray
{
    if(_realYiduArray == nil)
    {
        _realYiduArray = [NSMutableArray array];
    }
    return _realYiduArray;
}

- (NSMutableArray*)totalYiduArray
{
    if(_totalYiduArray == nil)
    {
        _totalYiduArray = [NSMutableArray array];
    }
    return _totalYiduArray;
}

- (void)back
{
//    [self httpGetWXOpenID];
    [self gotoRootBack];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    [self.mytimer invalidate];
    self.mytimer = nil;
}

@end
