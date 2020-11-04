//
//  MakeMoneyViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/10/11.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "MakeMoneyViewController.h"
#import "MisionTableViewCell.h"
#import "TFIndianaRecordViewController.h"
#import "GlobalTool.h"
#import "BrowseCountModel.h"
#import "GoldCouponModel.h"
#import "GoldViewController.h"
#import "TFShareRewardDetailVC.h"
#import "TFMyWalletViewController.h"
#import "TFMyCardViewController.h"
#import "HYJIntelgralDetalViewController.h"
#import "TFMakeMoneySecretViewController.h"
#import "TaskTableViewCell.h"
#import "ExtrabonusRemindView.h"
#import "QRCodeGenerator.h"
#import "ProduceImage.h"
#import "YFDPImageView.h"
#import "ExtrabonusRemindView.h"
#import "FinishTaskPopview.h"
#import "VitalityTaskPopview.h"
#import "TixianSharePopview.h"
#import "CrazyStyleViewController.h"
#import "IndianaDetailViewController.h"
#import "TFShoppingViewController.h"
#import "TFFeedBackViewController.h"
#import "UpdateView.h"
#import "WTFAlertView.h"
#import "AddVoucherModel.h"
#import "TFNoviceTaskView.h"
#import "InviteFriendsVC.h"
#import "TFHomeViewController.h"
#import "TFLedBrowseCollocationShopVC.h"
#import "TFLedBrowseShopViewController.h"
#import "YFDoubleSucessVC.h"
#import "TFActivityShopVC.h"
#import "BoundPhoneVC.h"
#import "UIView+Animation.h"
#import "TomorrowTableViewCell.h"
#import "CrazyMondayActivityVC.h"
#import "CFAccountDetailFromTaskVC.h"
//#import "TaskTFScreenViewController.h"
#import "TypeShareModel.h"
#import "TaskSignModel.h"
#import "DoubleModel.h"
#import "SignModel.h"
#import "Signmanager.h"
#import "TaskModel.h"
#import "ExtraBonusModel.h"
#import "TopRemindView.h"
#import "TaskCollectionVC.h"
#import "TFCollocationViewController.h"
#import "NewShoppingCartViewController.h"
#import "FightIndianaDetailViewController.h"
#import "GuideIndianaModel.h"
#import "GoldCouponsManager.h"
#import "DShareManager.h"
#import "AppDelegate.h"
#import "Signmanager.h"
#import "TFPopBackgroundView.h"
#import "MyVipVc.h"
#import "VitalityModel.h"
#import "FreeOrderPopview.h"
#import "FashionBuyInfoVC.h"
#import "SpecialDetailViewController.h"
#import "LuckdrawViewController.h"
#import "SelectHobbyViewController.h"
#import "DistributionRegistViewController.h"
#import "BubbleView.h"
#import "NSDate+Helper.h"
#import "NewShoppingCartViewController.h"
#import "SubmitTopicViewController.h"
#import "TopicDetailViewController.h"
#import "HotOutfitViewController.h"
#import "SelectShareTypeViewController.h"
#import "RelationShopViewController.h"
#import "AddTagsViewController.h"
#import "AXSampleNavBarTabViewController.h"
#import "CollecLikeTaskVC.h"
#import "CFActivityDetailToPayVC.h"
#import "TopicPublicModel.h"
#import "YFShareModel.h"
#import "FightgroupsViewController.h"
#import "GroupBuyDetailVC.h"
#import "TaskSharePopView.h"
#import "ContendTreasuresAreaVC.h"
#import "WTFNewPhoneNumController.h"
#import "TFCodePhoneViewController.h"
#import "TFAccountDetailsViewController.h"
#import "InviteFriendFreelingViewController.h"
#import "SearchTypeViewController.h"
#import "CFInviteFriendsRewardVC.h"
#import "TFIntimateCircleVC.h"
#import "IndianaPublicModel.h"
#import "OneLuckdrawViewController.h"
#import "InvitFriendFreeLingView.h"
#import "RawardRedPopview.h"
#import "HBmemberViewController.h"
#import "SignCalendarViewController.h"
#import "AddMemberCardViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <ShareSDKCoreService/ShareSDKCoreService.h>
#import <ShareSDK/ShareSDKPlugin.h>
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/ISSQZoneApp.h>

#import "WXApi.h"
#import "MiniShareManager.h"
@interface MakeMoneyViewController ()<DShareManagerDelegate,NSURLSessionDelegate,WXApiDelegate,MiniShareManagerDelegate>
@property (nonatomic, assign) CGFloat inviteImageHeigh;

@end

@implementation MakeMoneyViewController
{
    FinishTaskPopview * bonusview;    //签到任务弹框
    VitalityTaskPopview * vitaliview; //活力值弹框
    TaskSharePopView* textrabonusview;//分享赢提现弹框
    BOOL vitaliview_ishiden;          //活力值弹框是否消失
    BOOL isTixian_share;              //是否是赢提现额度分享
    BOOL isxjiang_share;              //是否是分享x件商品
    BOOL automaticskip;               //H5参团引导自动跳转
    BOOL isWeixinFriend;              //微信好友
    BOOL newShareTixian;              //是不是分享赢提现
    
    FreeOrderPopview * freeorderview; //免单弹框
    FreeOrderType freeOrderType;      //免单弹框类型
    
    BubbleView *bubbleV;
    TopRemindView *RemindView;
    UILabel *vitalitylable;           //显示活力值
    UILabel *_storetimelable;         //开店倒计时显示框
    UIImageView *_SharetitleImg;      //分享弹框的头
    NSString *_Myvalue;               //开店奖励值
    NSTimer *_mytimer;
    int _timeCount;
    
    UIImageView *backimmage;          //背景图片
    
    TaskModel *PubtaskModel;
    TaskModel *Suprisemodel;          //疯狂星期一的任务

    NSMutableArray *_MydataArray;     //数据源
    NSMutableArray *_motaskIDList;    //任务列表ID
    NSMutableArray *_motaskDataArray; //任务列表数据
    NSMutableArray *_finishtaskList;  //完成任务列表
    NSMutableArray *_soonFinishList;  //即将和已经完成的任务
    NSMutableArray *_discreptionList; //签到说明数据
    NSArray *_dataArray;              //签到数据
    
    NSString* bCount;                 //余额
    NSString *iCount;                 //积分
    NSString *cCount;                 //卡券
    NSString *fCount;                 //冻结金额
    NSString *tixian;                 //可提现金额
    NSString *desing;                 //提现中金额
    NSString *todayReturnMoney;       //超级0元购今日返现金额
    NSString *cumReturnMoney;         //超级0元购累计返现金额
    NSString *cumWitMoney;            //超级0元购累计提现金额
    NSString *shareCount;             //好友提成系统分享次数
    NSString *shareMoneyCount;        //好友提成系统总奖励数
    NSString *whetherTask;            //是否可以做任务 0不可 1可
    NSString *tixianShare_link;
    NSString *tixianShare_title;
    NSString *tixianShare_discription;
    NSString *tixianShare_pic;
    NSString *sharLink;               //分享商品 夺宝 任务页 拼团

    TaskTimerManager *taskmanager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _motaskDataArray = [NSMutableArray array];
    _alldayTaskList = [NSMutableArray array];
    _MydataArray = [NSMutableArray array];
    _motaskIDList = [NSMutableArray array];
    _finishtaskList = [NSMutableArray array];
    _soonFinishList = [NSMutableArray array];
    _discreptionList = [NSMutableArray array];
    _dataArray = [NSArray array];
    _shopData = [NSArray array];
    
    UIImage *invitimage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/qingfengpic/InviteFriends_img2.jpg"]]]];
    self.inviteImageHeigh = invitimage.size.height*kScreen_Width/invitimage.size.width;
    self.inviteImageHeigh = 0;
    
    self.mondytype = [DataManager sharedManager].IS_Monday?Mondytype_YES:Mondytype_NO;
    backimmage = [[UIImageView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar)];
    
    if(self.mondytype == Mondytype_YES)
    {
        backimmage.image = [UIImage imageNamed:@"monday_疯狂新衣节-bg"];
    }else if ([DataManager sharedManager].is_friendShare_day)
    {
        backimmage.image = [UIImage imageNamed:@"TASK-超级分享日.jpg"];
    }else if ([DataManager sharedManager].is_rawardDouble)
    {
        backimmage.image = [UIImage imageNamed:@"赚钱任务-返双倍购衣款.jpg"];
    }
    else if ([DataManager sharedManager].is_SuperZeroShop == YES)
    {
        backimmage.image = [UIImage imageNamed:@"赚钱任务-超级0元购"];
    }else if ([DataManager sharedManager].is_thousandYunRed)
    {
        backimmage.image = [UIImage imageNamed:@"赚钱任务-千元红包雨.jpg"];
    }
    else{
        backimmage.image = [UIImage imageNamed:@"Task-zhuanqianrenwu"];
    }
    
    [self.view addSubview:backimmage];
    
    [self creatNavagationView];
//    [self creatInvitView];
    [self creatTableView];

    //版本更新监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateview) name:YFLaunchViewDisappear object:nil];
    
    //任务数量更新弹框监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskJingxiTixianToTop) name:@"toTask_tixian" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishPopupView) name:@"liulanTaskFinish" object:nil];
    
//    [TaskSignModel fightinitialSuccess:^(id data) {
//
//        TaskSignModel *model = data;
//        if(model.data != nil)
//        {
//            if(model.data[@"rnum"] != nil)
//            {
//                [Signmanager SignManarer].rnum = [NSString stringWithFormat:@"%@",model.data[@"rnum"]];
//
//            }else{
//                [Signmanager SignManarer].rnum = @"10";
//            }
//            [Signmanager SignManarer].DPPAYPRICE = [NSString stringWithFormat:@"%@",model.data[@"DPPAYPRICE"]];
//            [Signmanager SignManarer].validHour = [NSString stringWithFormat:@"%@",model.data[@"validHour"]];
//        }
//    }];
    
    [self guideIndianaHttp];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    //开店成功回来弹框
    if(self.fromType !=nil)
    {
        _Myvalue = @"3";
        
        [_SharePopview removeFromSuperview];
        [self creatSharePopView:DAILY_TASK_STORE];
        
        NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
        NSString *nowtime = [userdefaul objectForKey:DOUBLE_S_TIME];
        
        [_mytimer invalidate];
        _mytimer = nil;
        
        _timeCount = 0;
        _mytimer = [NSTimer weakTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nowtime repeats:YES];
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        
        [user setObject:@"1" forKey:isShowNoviceTaskView6];
        
        [Signmanager SignManarer].task_isfinish = YES;
        
        self.fromType = nil;
        _Myvalue = nil;
        
    }else{
        //额外奖励弹框
        [ExtraBonusModel getBrowseBonus:^(id data) {
            ExtraBonusModel *model = data;
            
            if(model.status == 1 && model.money.intValue > 0)
            {
                self.bonusMoney = model.money;
                [self creatSharePopView:DAILY_EXTRA_BONUS];
            }
        }];
    }
    
    if ([DataManager sharedManager].InvitationSuccess)
    {
        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        [mentionview showLable:@"分享成功" Controller:self];
        [DataManager sharedManager].InvitationSuccess = NO;
    }
    
//    [self creatData];
    
    if(!bubbleV && (self.mondytype == Mondytype_YES || [DataManager sharedManager].is_friendShare_day))
    {
        [self creatBubleview:self.zeroshopview];
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self creatData];
    
    //弹框优先级 版本更新弹框 > H5获得金额的弹框 >任务更新弹框 > 夺宝成功弹框 > 浏览任务完成弹框 > 必做任务、额外任务完成弹框 > 提现任务完成弹框 > 购买完成弹框 > 获取20衣豆弹框
    if([DataManager sharedManager].isLaunch == NO)
    {
        [self updateview];
    }
    
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:USER_TOKEN];
    if(token.length > 10)
    {
        //一键做下个任务
        if([NextTaskManager taskManager].backToMakeMoney)
        {
            [NextTaskManager taskManager].backToMakeMoney = NO;
            [[Animation shareAnimation] CreateAnimationAt:self.view];
            [self performSelector:@selector(getNextTask) withObject:nil afterDelay:0.5];
        }

        //参团状态提示
        if(self.roll == 0)//无资格
        {
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            if (self.fighStatus.intValue == 2)
            {
                [mentionview showLable:@"新用户只能参与一次哦~" Controller:self];
                [TaskSignModel fightStatusSuccess:^(id data) {//重置状态
                    
                }];
            }else if (self.fighStatus.intValue == 3 && self.orderCount == 0)
            {
                [mentionview showLable:@"超级拼团仅限新用户参与哦~" Controller:self];
                [TaskSignModel fightStatusSuccess:^(id data) {//重置状态
                    
                }];
            }else if(self.fighStatus.integerValue == 1 && self.orderCount == 0 && self.offered.intValue==2 && !automaticskip)
            {
                if([[NSUserDefaults standardUserDefaults]boolForKey:@"automaticpop"] == NO)
                {
                    if([[NSUserDefaults standardUserDefaults] objectForKey:USER_PHONE] !=nil && [[NSUserDefaults standardUserDefaults] objectForKey:UNION_ID] != nil)
                    {
                        automaticskip = YES;
                        [self goFight:2];//当用户从H5引导且有参团资格时自动跳转到拼团列表页
                        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"automaticpop"];
                    }
                }
            }
        }else if (self.roll == 1 && self.offered.intValue==2 && !automaticskip)//有资格
        {
            if([[NSUserDefaults standardUserDefaults]boolForKey:@"automaticpop"] == NO)
            {
                if([[NSUserDefaults standardUserDefaults] objectForKey:USER_PHONE] !=nil && [[NSUserDefaults standardUserDefaults] objectForKey:UNION_ID] != nil)
                {
                    automaticskip = YES;
                    [self goFight:2];//当用户从H5引导且有参团资格时自动跳转到拼团列表页
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"automaticpop"];
                }
            }
        }
    }
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //是否有疯狂星期一的任务
//    [TopicPublicModel GetisMandayDataSuccess:^(id data) {
//        
//        TopicPublicModel *model = data;
//        if(model.status == 1)
//        {
//            [DataManager sharedManager].IS_Monday = model.isMonday==1?YES:NO;
//            
//            if(model.sup_day==1 || model.fri_win==1)
//            {
//                [DataManager sharedManager].is_friendShare_day = YES;
//            }
//            
//            [DataManager sharedManager].is_SuperZeroShop = model.zero_buy==1?YES:NO;
//            [DataManager sharedManager].is_rawardDouble = model.monthly==1?YES:NO;
//            [DataManager sharedManager].is_thousandYunRed = model.red_rain==1?YES:NO;
//        }
//    }];
    
    [bubbleV removeFromSuperview];
    bubbleV = nil;
}

#pragma mark 寻找下一个任务
- (void)getNextTask
{
    //先必做后额外
    BOOL mustTaskFinish =[self mustTaskFinisStatue];
    BOOL extraTaskFinish = [self extraTaskFinisStatue];
    if(!mustTaskFinish && self.dayMustTaskList.count)
    {
        NSIndexPath *nextTaskIndexPath = [NSIndexPath indexPathForRow:[self getDayNextTaskForRow:self.dayMustTaskList] inSection:2];
        if(nextTaskIndexPath )
        {
            [self selectTaskIndexPath:nextTaskIndexPath];
        }
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
    }else if(!extraTaskFinish && self.dayExtraTasklist.count){
        
        NSIndexPath *nextTaskIndexPath = [NSIndexPath indexPathForRow:[self getDayNextTaskForRow:self.dayExtraTasklist] inSection:4];
        if(nextTaskIndexPath)
        {
            [self selectTaskIndexPath:nextTaskIndexPath];
        }
        [[Animation shareAnimation] stopAnimationAt:self.view];
    }else if(self.dayMustFinsishList.count && self.dayExtraFinishlist.count)
    {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSDate *addtionalrecord = [user objectForKey:MUSTANDEXTRATASKFINISH];
        if(![[MyMD5 compareDate:addtionalrecord] isEqualToString:@"今天"] || addtionalrecord==nil)
        {
            [user setObject:[NSDate date] forKey:MUSTANDEXTRATASKFINISH];
            //必做任务额外任务均做完
            [self setTaskPopMindView:Task_Finish_mention Value:nil Title:nil Rewardvalue:nil Rewardnum:0];
        }
        [[Animation shareAnimation] stopAnimationAt:self.view];
    }else{
        [[Animation shareAnimation] stopAnimationAt:self.view];
    }
}
- (NSInteger)getDayNextTaskForRow:(NSMutableArray*)dataArray
{
    NSInteger row = 0;
    for(int i=0; i<dataArray.count; i++)
    {
        TaskModel *model = dataArray[i];
        if(!model.isfinish)
        {
            row = i;
            break;
        }
    }
    return row;
}

- (void)creatData
{
    _tomorrowTaskList = [NSMutableArray array];
    
    NSArray *disarray = @[@"完成赚钱小任务赢得的奖金分为账户余额与可提现的现金。",
                          @"账户余额能用来抽取1-1000元不等的提现现金，每次消耗10元余额。",
                          @"完成惊喜提现任务可直接得可提现的现金。"];
    _discreptionList = [NSMutableArray arrayWithArray:disarray];

    [self requestHttp];     //详情数据
}
#pragma mark *************************界面部分**********************
- (void)creatNavagationView
{
//    _ExtratopView=[[ExtrabonusTopView alloc]initWithFrame:CGRectMake(0, Height_NavBar-30, kScreenWidth, 30)];
//    [self.view addSubview:_ExtratopView];
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, Height_NavBar-57, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    backbtn.hidden = self.MakeMoney_Type == MakeMoney_NTarbarType?YES:NO;
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"赚钱小任务";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIButton* discriptionBtn=[[UIButton alloc]init];
    discriptionBtn.frame=CGRectMake(kApplicationWidth-ZOOM6(180), Height_NavBar-45, ZOOM6(160), 20);
    discriptionBtn.centerY = View_CenterY(headview);
    [discriptionBtn setTitle:@"任务说明" forState:UIControlStateNormal];
    discriptionBtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM6(32)];
    [discriptionBtn setTitleColor:RGBCOLOR_I(125, 125, 125) forState:UIControlStateNormal];
    discriptionBtn.tag=1111;
    [discriptionBtn addTarget:self action:@selector(discription) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:discriptionBtn];

}
- (InvitFriendFreeLingView*)creatInvitView{
    //邀请好友免费领
    InvitFriendFreeLingView *lingview = [[InvitFriendFreeLingView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, self.inviteImageHeigh)];
    lingview.invitFreeLingBlock = ^{
        InviteFriendFreelingViewController *friendraward = [[InviteFriendFreelingViewController alloc]init];
        friendraward.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:friendraward animated:YES];
    };
    
    lingview.closeFreeLingBlock = ^{
        lingview.frame =CGRectMake(0, Height_NavBar, kScreenWidth, 0);
        [lingview removeFromSuperview];
        self.inviteImageHeigh = 0;
        _MytableView.tableHeaderView = [self creatTableHead];
        [_MytableView reloadData];
    };
    return lingview;
}
- (void)creatTableView
{
    _MytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight-Height_NavBar+kUnderStatusBarStartY) style:UITableViewStyleGrouped];
    _MytableView.delegate = self;
    _MytableView.dataSource = self;
    _MytableView.backgroundColor=[UIColor clearColor];
    _MytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _MytableView.tableHeaderView = [self creatTableHead];
    _MytableView.tableFooterView = [self creatTableFoot];
    [self.view addSubview:_MytableView];

    
    [_MytableView registerNib:[UINib nibWithNibName:@"TaskTableViewCell" bundle:nil] forCellReuseIdentifier:@"TaskCell"];
    
    [_MytableView registerNib:[UINib nibWithNibName:@"TomorrowTableViewCell" bundle:nil] forCellReuseIdentifier:@"TomorrowCell"];
}
-  (UIView*)creatTableFoot
{
    SignCalendarViewController *calendar = [[SignCalendarViewController alloc]init];
    calendar.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth+100);
    return calendar.view;
}
- (UIView*)creatTableHead
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    CGFloat imageWith = kScreenWidth - 2*ZOOM6(20);
    CGFloat viewWidth = (kScreenWidth - 2*ZOOM6(20))/3;
    CGFloat viewYY = 0;
    if ([DataManager sharedManager].is_friendShare_day)
    {
        viewYY = ZOOM6(220);
    }else if ([DataManager sharedManager].is_rawardDouble)
    {
        viewYY = ZOOM6(170);
    }else if([DataManager sharedManager].is_SuperZeroShop)
    {
        viewYY = ZOOM6(300);
    }else if ([DataManager sharedManager].is_thousandYunRed)
    {
        viewYY = ZOOM6(250);
    }
    CGFloat viewHeigh = self.mondytype==Mondytype_YES?ZOOM6(300):ZOOM6(20)+viewYY+self.inviteImageHeigh;
    CGFloat scale = (self.mondytype==Mondytype_YES || token.length < 10)?0.4:0.5;
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, viewHeigh +imageWith*scale)];
    headView.userInteractionEnabled = YES;
    self.zeroshopview = headView;
    
    if(self.inviteImageHeigh > 0)
    {
        [headView addSubview:[self creatInvitView]];
    }
    
//    for (int i=0; i<3; i++) {
//        UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(ZOOM6(20)+i*viewWidth, self.inviteImageHeigh, viewWidth, ZOOM6(100))];
//        backview.clipsToBounds = YES;
//        backview.tag = 300000+i;
//        backview.userInteractionEnabled = YES;
//
//        UITapGestureRecognizer *Retroactivetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(RetroactiveClick:)];
//        [backview addGestureRecognizer:Retroactivetap];
//
//        [headView addSubview:backview];
//
//        if(i==3)
//        {
//            //夺宝记录
//            UIImageView *Retroactiveimage = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(15), ZOOM6(10), ZOOM6(108), ZOOM6(86))];
//            Retroactiveimage.image = [UIImage imageNamed:@"newtask_icon_duobaojilu"];
//            Retroactiveimage.userInteractionEnabled = YES;
//            [backview addSubview:Retroactiveimage];
//
//        }else{
//            CGFloat imageWidth = viewWidth-ZOOM6(30);
//            CGFloat imageHeigh = imageWidth*0.29;
//
//            UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(backview.frame)-imageWidth)/2, ZOOM6(20), imageWidth, imageHeigh)];
//            imageview.tag = 500000+i;
//
//            UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(50),-ZOOM6(3), imageWidth-ZOOM6(80), imageHeigh)];
//            titlelable.textColor = [UIColor whiteColor];
//            titlelable.textAlignment = NSTextAlignmentCenter;
//            titlelable.font = [UIFont systemFontOfSize:ZOOM6(20)];
//            titlelable.text = @"0";
//            titlelable.tag = 400000+i;
//
//            if(i==0)
//            {
//                titlelable.text = [NSString stringWithFormat:@"%.2f",[bCount floatValue]];
//                imageview.image = [UIImage imageNamed:@"newtask_yu-e"];
//
//            }else if (i==1)
//            {
//                titlelable.text = [NSString stringWithFormat:@"%d",[iCount intValue]];
//                imageview.image = [UIImage imageNamed:@"newtask_jifen"];
//                if([GoldCouponsManager goldcpManager].gold_is_open == YES)
//                {
//                    imageview.image = [UIImage imageNamed:@"newtask_jingbi"];
//                }
//
//            }else if (i==2)
//            {
//                titlelable.text = [NSString stringWithFormat:@"%d",[cCount intValue]];
//                imageview.image = [UIImage imageNamed:@"newtask_youhuijuan"];
//                if([GoldCouponsManager goldcpManager].is_open == YES)
//                {
//                    imageview.image = [UIImage imageNamed:@"newtask_jingquan"];
//                }
//            }
//
//            [backview addSubview:imageview];
//            [imageview addSubview:titlelable];
//        }
//    }
    if(self.mondytype == Mondytype_YES && !bubbleV)
    {
        [self creatBubleview:headView];
    }else if ([DataManager sharedManager].is_friendShare_day)
    {
        
    }else if ([DataManager sharedManager].is_rawardDouble)
    {
    }
    else if ([DataManager sharedManager].is_SuperZeroShop){
        
        [self creatZeroShoppingview];
    }
    
    CGFloat space = self.mondytype==Mondytype_YES?ZOOM6(10):0;
    
    UIImageView *headimage = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(20)-space, viewHeigh, imageWith+space, (imageWith+space)*scale)];
    headimage.image = self.mondytype==Mondytype_YES?[UIImage imageNamed:@"mad monday"]:[UIImage imageNamed:@"bg_zhaocaimiao"];
    
    headimage.image = token.length > 10 ? headimage.image : [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/qingfengpic/bg_zhaocaimiao_no_login_new.png"]]]];
    headimage.userInteractionEnabled = YES;
    [headView addSubview:headimage];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(edumingxi:)];
    [headimage addGestureRecognizer:tap];
    
    for(int j=0; j<2; j++)
    {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = tarbarrossred;
        label.hidden = self.mondytype==Mondytype_YES?YES:NO;
        if(j == 0)
        {
            label.frame = CGRectMake(ZOOM6(20), ZOOM6(120), CGRectGetWidth(headimage.frame)-ZOOM6(40), ZOOM6(50));
            label.font = [UIFont systemFontOfSize:ZOOM6(48)];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"今日赚(元)";
        }else{
            label.frame = CGRectMake(ZOOM6(20), ZOOM6(180), CGRectGetWidth(headimage.frame)-ZOOM6(40), ZOOM6(90));
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(84)];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"竟然没有";
            self.todayEarnMoney = label;
        }
        [headimage addSubview:label];
    }
    
    int count = self.mondytype==Mondytype_YES?2:3;
    count = token.length < 10 ? 0 : count;
    
    CGFloat labelwith = CGRectGetWidth(headimage.frame)/3;
    for(int k=0; k<count; k++)
    {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(space+labelwith*k, ZOOM6(280), labelwith, ZOOM6(60));
        if(self.mondytype == Mondytype_YES)
        {
            label.frame = CGRectMake(space+labelwith*k, ZOOM6(200), labelwith, ZOOM6(60));
        }
        label.font = [UIFont systemFontOfSize:ZOOM6(30)];
        label.textColor = tarbarrossred;
        label.userInteractionEnabled = YES;
        label.textAlignment = NSTextAlignmentCenter;
        
        UILabel *linelab = [[UILabel alloc] init];
        linelab.frame = CGRectMake(CGRectGetMaxX(label.frame), CGRectGetMinY(label.frame)+ZOOM6(20), 0.5, ZOOM6(20));
        linelab.backgroundColor = tarbarrossred;
        
        if(k == 0)
        {
            NSString *bc = [NSString stringWithFormat:@"%.2f",[bCount floatValue]];
            label.text = [NSString stringWithFormat:@"余额%@元",bc];
            [self getBalancemutable:label Text:bc FromIndex:2];
            self.totalMoney = label;
        }else if (k == 1){
            NSString *tx = [NSString stringWithFormat:@"%.2f",[tixian floatValue]];
            label.text = [NSString stringWithFormat:@"可提现%@元",tx];
            [self getBalancemutable:label Text:tx FromIndex:3];
            self.tixianMoney = label;
        }else if (k == 2)
        {
            linelab.hidden = YES;
            NSString *tx = [NSString stringWithFormat:@"%.2f",[desing floatValue]];
            label.text = [NSString stringWithFormat:@"提现中%@元",tx];
            [self getBalancemutable:label Text:tx FromIndex:3];
            self.tixianUnderway = label;
        }
        
        UITapGestureRecognizer *accuontlabtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoAccount:)];
        UITapGestureRecognizer *labtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToWallet:)];
        UITapGestureRecognizer *tixiantap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goTotixian:)];
        if(k == 0)
        {
            [label addGestureRecognizer:accuontlabtap];
        }else if (k== 1){
            [label addGestureRecognizer:labtap];
        }else{
            [label addGestureRecognizer:tixiantap];
        }
        
        [headimage addSubview:label];
        [headimage addSubview:linelab];
    }
    
    UIButton *tixianbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    tixianbtn.frame = CGRectMake(CGRectGetWidth(headimage.frame)-ZOOM6(160), ZOOM6(120), ZOOM6(160), ZOOM6(46));
    [tixianbtn setBackgroundImage:[UIImage imageNamed:@"+提现额度"] forState:UIControlStateNormal];
    if(self.mondytype == Mondytype_YES)
    {
        tixianbtn.frame = CGRectMake(CGRectGetWidth(headimage.frame)-ZOOM6(182), ZOOM6(210), ZOOM6(162), ZOOM6(52));
        [tixianbtn setBackgroundImage:[UIImage imageNamed:@"but_tixianedu"] forState:UIControlStateNormal];
    }
    
    [tixianbtn addTarget:self action:@selector(addtixian) forControlEvents:UIControlEventTouchUpInside];
    [headimage addSubview:tixianbtn];
    
    return headView;
}
- (void)creatBubleview:(UIView*)headView
{
    UILabel *titlelable = [headView viewWithTag:400000];
    CGFloat space = [DataManager sharedManager].is_SuperZeroShop?ZOOM6(50):ZOOM6(30);
    bubbleV = [[BubbleView alloc] initWithFrame:CGRectMake(ZOOM6(20), titlelable.bottom + space, (int)ZOOM6(430), (int)(ZOOM6(62) + ZOOM6(20)) * 2)];
    [headView addSubview:bubbleV];
    [bubbleV startScroll];
    [bubbleV getData];

}
- (void)creatZeroShoppingview
{
    backimmage.image = [UIImage imageNamed:@"赚钱任务-超级0元购"];
    
    CGFloat imageWidth = IMAGEW(@"head_超级0元购");
    CGFloat imageHeigh = IMAGEH(@"head_超级0元购");
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.zeroshopview.frame)-imageWidth)/2, ZOOM6(100), imageWidth, imageHeigh)];
    imageview.image = [UIImage imageNamed:@"head_超级0元购"];
    [self.zeroshopview addSubview:imageview];
    
    CGFloat labelwith = CGRectGetWidth(backimmage.frame)/3;
    for(int k=0; k<3; k++)
    {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(labelwith*k, ZOOM6(330), labelwith, ZOOM6(30));
        label.font = [UIFont systemFontOfSize:ZOOM6(24)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.userInteractionEnabled = YES;
        
        UILabel *linelab = [[UILabel alloc] init];
        linelab.frame = CGRectMake(CGRectGetMaxX(label.frame), CGRectGetMinY(label.frame)+ZOOM6(5), 0.5, ZOOM6(20));
        linelab.backgroundColor = [UIColor whiteColor];
        
        if(k == 0)
        {
            NSString *bc = [NSString stringWithFormat:@"%.1f",[todayReturnMoney floatValue]];
            label.text = [NSString stringWithFormat:@"今日已返%@万元",bc];
            [self getBalancemutable:label Text:bc FromIndex:4];
            self.todayReturnMoneyLab = label;
        }else if (k == 1){
            NSString *tx = [NSString stringWithFormat:@"%.1f",[cumReturnMoney floatValue]];
            label.text = [NSString stringWithFormat:@"累计已返%@万元",tx];
            [self getBalancemutable:label Text:tx FromIndex:4];
            self.cumReturnMoneyLab = label;
        }else if (k == 2)
        {
            linelab.hidden = YES;
            NSString *tx = [NSString stringWithFormat:@"%.1f",[cumWitMoney floatValue]];
            label.text = [NSString stringWithFormat:@"累计提现%@万元",tx];
            [self getBalancemutable:label Text:tx FromIndex:4];
            self.cumWitMoneyLab = label;
        }
        
        [self.zeroshopview addSubview:label];
        [self.zeroshopview addSubview:linelab];
    }
}
- (void)getBalancemutable:(UILabel*)lab Text:(NSString*)text FromIndex:(int)index
{
    NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:lab.text];
    
    [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(30)] range:NSMakeRange(index, text.length)];
    [lab setAttributedText:mutable];
    
}

#pragma mark 额度明细
- (void)edumingxi:(UITapGestureRecognizer*)tap
{
    [self goAccount];
}
#pragma mark 账户明细
- (void)goAccount
{
    [self loginSuccess:^{
        [self.MytableView.tableHeaderView removeFromSuperview];
        self.MytableView.tableHeaderView = [self creatTableHead];
        [self.MytableView reloadData];
        
        TFAccountDetailsViewController *tdvc = [[TFAccountDetailsViewController alloc] init];
        tdvc.headIndex = 1;
        tdvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tdvc animated:YES];
    }];
}
#pragma mark 增加提现额度
- (void)addtixian
{
    [self loginSuccess:^{
        LuckdrawViewController *luck = [[LuckdrawViewController alloc]init];
        luck.hidesBottomBarWhenPushed = YES;
        luck.mondaytype = self.mondytype;
        luck.LotteryNumber = self.LotteryNumber;
        [self.navigationController pushViewController:luck animated:YES];
    }];
}
#pragma mark 刷新主界面
- (void)refreshMainUI:(NSDictionary*)dic
{
    //点赞数
    self.point_count = [NSString stringWithFormat:@"%@",dic[@"point_count"]];
    //奖励数
    self.total_rewards = [NSString stringWithFormat:@"%@",dic[@"total_rewards"]];
    //顶置框
    [self setExtraTopView:self.point_count.intValue Count_money:self.total_rewards.floatValue];
    
    //余额
    CGFloat over = [dic[@"bCount"] floatValue];
    if ([DataManager sharedManager].isOligible&&[DataManager sharedManager].isOpen&&([DataManager sharedManager].twofoldness > 0)) {
        over *= [DataManager sharedManager].twofoldness;
    }
    
    bCount = [NSString stringWithFormat:@"%.2f",over];
    _toatlbCount = [NSString stringWithFormat:@"%@",dic[@"bCount"]];
    
    //积分
    iCount = [NSString stringWithFormat:@"%d",[dic[@"iCount"] intValue]];
    //卡券
    cCount = [NSString stringWithFormat:@"%d",[dic[@"cCount"] intValue]];
    //冻结金额
    fCount = [NSString stringWithFormat:@"%.2f",[dic[@"ex_free"] floatValue]];
    //可提现金额
    tixian = [NSString stringWithFormat:@"%.2f",[dic[@"withdrawal_money"] floatValue]+[fCount floatValue]];
    //提现中金额
    desing = [NSString stringWithFormat:@"%.2f",[dic[@"desing"] floatValue]];
    //每日金额
    NSString *today_money = [NSString stringWithFormat:@"%@",dic[@"today_money"]];
    //今日已返
    todayReturnMoney = [NSString stringWithFormat:@"%f",[dic[@"todayReturnMoney"] floatValue]];
    //累计已返
    cumReturnMoney = [NSString stringWithFormat:@"%f",[dic[@"cumReturnMoney"] floatValue]];
    //累计提现
    cumWitMoney = [NSString stringWithFormat:@"%f",[dic[@"cumWitMoney"] floatValue]];
    //好友提成分享数
    shareCount = [NSString stringWithFormat:@"%@",dic[@"shareCount"]];
    //好友提成系统总奖励数
    shareMoneyCount = [NSString stringWithFormat:@"%@",dic[@"shareMoneyCount"]];
    //是否可以做任务 0不 1可
    whetherTask = [NSString stringWithFormat:@"%@",dic[@"whetherTask"]];
    
    if(self.point_count.intValue > 100000)
    {
        _ExtratopView.BrowseLabel.text = @"100000+";
    }else{
        _ExtratopView.BrowseLabel.text = [NSString stringWithFormat:@"累计分享数：%d",shareCount.intValue];
    }
    
    if(self.total_rewards.floatValue > 10000)
    {
        _ExtratopView.FunsLabel.text = @"10000+";
    }else{
        
        _ExtratopView.FunsLabel.text = [NSString stringWithFormat:@"累计获得奖励:%.2f元",shareMoneyCount.floatValue];
    }

    
    //是否免费点赞
    self.isGratis = [dic[@"isGratis"] boolValue];
    //继续点赞弹框状态
    self.popup = [dic[@"popup"] boolValue];
    //是否新手
    NSString *current_date = [NSString stringWithFormat:@"%@",dic[@"current_date"]];
    if([current_date hasPrefix:@"newbie"])
    {
        self.newbie = 0;
    }else{
        self.newbie = 1;
    }
    //点赞状态
    self.point_status = -1;
    if(dic[@"point_status"] != nil)
    {
        self.point_status = [[NSString stringWithFormat:@"%@",dic[@"point_status"]] integerValue];
        
        NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:USER_TOKEN];
        
        if(self.point_status == 0 && token.length > 10)//第一次H5过来免费点赞
        {
            [self fabousHttp:YES];
            [TaskSignModel popupHttpSuccess:^(id data) {
                
            }];
        }else if (self.point_status >0 && token.length > 10)
        {
            if(self.popup){//是否是从H5引导过来的
                if(self.isGratis)//再一次H5引导过来免费点赞
                {
                    [self fabousHttp:NO];
                    [TaskSignModel popupHttpSuccess:^(id data) {
                        
                    }];
                }
                else //再次H5过来提示免费点赞次数已用完
                {
                    if(!bonusview)
                    {
                        [self setTaskPopMindView:Task_jizanOver_type Value:nil Title:_reward_type Rewardvalue:_reward_value Rewardnum:0];
                        [TaskSignModel popupHttpSuccess:^(id data) {
                            
                        }];
                    }
                }
            }
        }
    }
    
    //参团状态
    if(dic[@"roll"] != nil)
    {
        self.roll = [dic[@"roll"] integerValue];
    }
    if(dic[@"fighStatus"] != nil)
    {
        self.fighStatus = [NSString stringWithFormat:@"%@",dic[@"fighStatus"]];
    }
    if(dic[@"orderStatus"] != nil)
    {
        self.orderStatus = [NSString stringWithFormat:@"%@",dic[@"orderStatus"]];
    }
    if(dic[@"orderCount"] !=nil)
    {
        self.orderCount = [dic[@"orderCount"] integerValue];
    }
    if(dic[@"offered"] != nil)
    {
        self.offered = [NSString stringWithFormat:@"%@",dic[@"offered"]];
    }
    for(int j=0;j<3;j++)
    {
        UILabel *countlab = (UILabel*)[self.view viewWithTag:400000+j];
        if(j==0)
        {
            if(bCount)
            {
                countlab.text = bCount;
            }
        }else if (j==1)
        {
            if(iCount)
            {
                countlab.text = iCount;
            }
        }else if (j==2)
        {
            if(cCount)
            {
                countlab.text = cCount;
            }
        }
    }
    
    //总余额
    if([bCount floatValue] >= 0 && self.totalMoney)
    {
        self.totalMoney.text = [NSString stringWithFormat:@"余额%@元",bCount];
        [self getBalancemutable:self.totalMoney Text:bCount FromIndex:2];
    }
    
    //可提现
    if([tixian floatValue] >= 0 && self.tixianMoney)
    {
        self.tixianMoney.text = [NSString stringWithFormat:@"可提现%.2f元",[tixian floatValue]];
        [self getBalancemutable:self.tixianMoney Text:tixian FromIndex:3];
    }
    
    //提现中
    if([desing floatValue] >= 0 && self.mondytype != Mondytype_YES && self.tixianUnderway)
    {
        self.tixianUnderway.text = [NSString stringWithFormat:@"提现中%.2f元",[desing floatValue]];
        [self getBalancemutable:self.tixianUnderway Text:desing FromIndex:3];
    }
    
    if([DataManager sharedManager].is_SuperZeroShop)
    {
        //今日已返
        if([todayReturnMoney floatValue] >= 0 && self.todayReturnMoneyLab)
        {
            NSString *bc = [NSString stringWithFormat:@"%.1f",[todayReturnMoney floatValue]];
            self.todayReturnMoneyLab.text = [NSString stringWithFormat:@"今日已返%@万元",bc];
            [self getBalancemutable:self.todayReturnMoneyLab Text:bc FromIndex:4];
        }
        //累计已返
        if ([cumReturnMoney floatValue] >= 0 && self.cumReturnMoneyLab)
        {
            NSString *tx = [NSString stringWithFormat:@"%.1f",[cumReturnMoney floatValue]];
            self.cumReturnMoneyLab.text = [NSString stringWithFormat:@"累计已返%@万元",tx];
            [self getBalancemutable:self.cumReturnMoneyLab Text:tx FromIndex:4];
            
        }
        //累计提现
        if ([cumWitMoney floatValue] >= 0 && self.cumWitMoneyLab)
        {
            NSString *tx = [NSString stringWithFormat:@"%.1f",[cumWitMoney floatValue]];
            self.cumWitMoneyLab.text = [NSString stringWithFormat:@"累计提现%@万元",tx];
            [self getBalancemutable:self.cumWitMoneyLab Text:tx FromIndex:4];
        }
    }
    if([today_money floatValue] > 0)
    {
        self.todayEarnMoney.text = [NSString stringWithFormat:@"%.2f",[today_money floatValue]];
    }else{
        self.todayEarnMoney.text = @"竟然没有";
    }
    
//  抽奖次数
    self.LotteryNumber = [[NSString stringWithFormat:@"%@",dic[@"LotteryNumber"]] intValue];
    if(self.LotteryNumber >= 0 && self.mondytype==Mondytype_YES && self.surpriseTaskList.count > 0)
    {
         Suprisemodel.value = [NSString stringWithFormat:@"%zd",self.LotteryNumber];
    }
}

#pragma mark 改变金币金券的状态
- (void)changeGoldUI
{
    //金币、金券改变状态
    UIImageView *goldimageview = (UIImageView*)[self.view viewWithTag:500001];
    UIImageView *goldcpimageview = (UIImageView*)[self.view viewWithTag:500002];
    if([GoldCouponsManager goldcpManager].gold_is_open == YES)
    {
        goldimageview.image = [UIImage imageNamed:@"newtask_jingbi"];
        [goldimageview shakeStatus:YES];
    }else{
        goldimageview.image = [UIImage imageNamed:@"newtask_jifen"];
        [goldimageview shakeStatus:NO];
    }
    
    if ([GoldCouponsManager goldcpManager].is_open == YES)
    {
        goldcpimageview.image = [UIImage imageNamed:@"newtask_jingquan"];
        [goldcpimageview shakeStatus:YES];
    }else{
        goldcpimageview.image = [UIImage imageNamed:@"newtask_youhuijuan"];
        [goldcpimageview shakeStatus:NO];
    }

}
#pragma mark *************************弹框部分**********************

//设置喜好成功弹框
- (void)hobbySuccess
{
    [self setTaskPopMindView:Task_setHobbySuccess Value:nil Title:_reward_type Rewardvalue:_reward_value Rewardnum:0];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:FIRSTCOMING];
}

- (void)discription
{
    MyLog(@"签到说明");

    [MobClick event:QIANDAO_SHUOMING];

    if(!_Popview)
    {
        [self creatPopView:@"签到说明"];
    }
}

#pragma mark 分享赢提现
- (void)creatIndianaPopView
{
    
    textrabonusview = [[TaskSharePopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    __weak TaskSharePopView *view = textrabonusview;
    view.tapHideMindBlock = ^{
        [view remindViewHiden];
    };
    
    kWeakSelf(self);
    view.weixinBlock = ^{
        _isWeixin_share = YES;
        isWeixinFriend = YES;
        view.tixianShareBtn.userInteractionEnabled = NO;
        //分享提现埋点
        [YFShareModel getShareModelWithKey:@"fxytx" type:StatisticalTypeShareTixian tabType:StatistiaclTabTypeShareTixian success:nil];

        if([Signmanager SignManarer].AlreadyFinishCount <= 0)
        {
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"今日的分享次数已达上线，明天再来吧~" Controller:self];
        }else
        [weakself httpGetTixianShare];
    };
    
    view.tixianBlock = ^{
    
        TFWithdrawCashViewController *cash = [[TFWithdrawCashViewController alloc]init];
        cash.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:cash animated:YES];
    };
    [self.view addSubview:textrabonusview];

}

- (void)setShoppingVCIndex:(NSInteger)currIndex
{
    UINavigationController *shopNC = Mtarbar.viewControllers[1];
    TFShoppingViewController *shopVC = [[shopNC viewControllers] firstObject];
    shopVC.currPageViewController = currIndex;
    Mtarbar.selectedIndex = 0;
}

#pragma mark 提现
- (void)tixian
{
    [self loginSuccess:^{
        TFWithdrawCashViewController *cash = [[TFWithdrawCashViewController alloc]init];
        cash.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cash animated:YES];
    }];
}

#pragma mark 签到说明弹框
-(void)creatPopView:(NSString*)str
{
    _Popview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    _Popview.userInteractionEnabled = YES;

    //弹框内容
    _InvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(120), ZOOM6(500)-(IMGSIZEW(@"icon_close1")/2), kScreenWidth-ZOOM(120)*2, kScreenHeight-ZOOM6(500)*2+IMGSIZEW(@"icon_close1"))];
    _InvitationCodeView.backgroundColor=[UIColor clearColor];
    _InvitationCodeView.clipsToBounds = YES;
    [_Popview addSubview:_InvitationCodeView];
    
    //关闭按钮
    CGFloat btnwidth = IMGSIZEW(@"icon_close1");
    
    _canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _canclebtn.frame=CGRectMake(CGRectGetWidth(_InvitationCodeView.frame)-btnwidth-ZOOM(10), 0, btnwidth, btnwidth);
    [_canclebtn setImage:[UIImage imageNamed:@"icon_close1"] forState:UIControlStateNormal];
    _canclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    _canclebtn.layer.cornerRadius=btnwidth/2;
    [_canclebtn addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
    [_InvitationCodeView addSubview:_canclebtn];
    
    _backview = [[UIView alloc]initWithFrame:CGRectMake(0,btnwidth+ZOOM(30), kScreenWidth-ZOOM(120)*2,CGRectGetHeight(_InvitationCodeView.frame)-btnwidth-ZOOM(30))];
    _backview.backgroundColor=[UIColor whiteColor];
    _backview.layer.cornerRadius=5;
    _backview.clipsToBounds = YES;
    [_InvitationCodeView addSubview:_backview];
    
    UIImageView *bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _InvitationCodeView.frame.size.width, ZOOM6(100))];
    bgImg.backgroundColor=tarbarrossred;
    [_backview addSubview:bgImg];
    
    
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bgImg.frame), CGRectGetHeight(bgImg.frame))];
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.font = [UIFont systemFontOfSize:ZOOM(70)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    [_backview addSubview:titlelabel];
    
    if([str isEqualToString:@"签到说明"])
    {
        
        _InvitationCodeView.frame = CGRectMake(ZOOM(120), ZOOM6(550), kScreenWidth-ZOOM(120)*2, kScreenHeight-ZOOM6(550)*2);
        
        _backview.frame = CGRectMake(0,0, kScreenWidth-ZOOM(120)*2,CGRectGetHeight(_InvitationCodeView.frame));
        
        _canclebtn.frame=CGRectMake(CGRectGetWidth(_InvitationCodeView.frame)-btnwidth-ZOOM(10), (CGRectGetHeight(bgImg.frame)-btnwidth)/2, btnwidth, btnwidth);
        [_canclebtn setImage:[UIImage imageNamed:@"qiandao_icon_close"] forState:UIControlStateNormal];
        
        [_backview addSubview:_canclebtn];
        
        
        titlelabel.text = @"赚钱任务说明";
        
        _DiscriptableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgImg.frame)+15, CGRectGetWidth(bgImg.frame), CGRectGetHeight(_backview.frame)-CGRectGetHeight(bgImg.frame)-30) style:UITableViewStylePlain];
        _DiscriptableView.delegate = self;
        _DiscriptableView.dataSource = self;
        _DiscriptableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _DiscriptableView.showsVerticalScrollIndicator = YES;
        [_DiscriptableView registerNib:[UINib nibWithNibName:@"PartnerCardCell" bundle:nil] forCellReuseIdentifier:@"CardCell"];
        _DiscriptableView.userInteractionEnabled = YES;
        [_backview addSubview:_DiscriptableView];
    }
    
    [_Popview addSubview:_InvitationCodeView];
    [self.view addSubview:_Popview];
    
    _InvitationCodeView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _InvitationCodeView.alpha = 0.5;
    
    _Popview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _Popview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        _InvitationCodeView.transform = CGAffineTransformMakeScale(1, 1);
        _InvitationCodeView.alpha = 1;
        
    } completion:^(BOOL finish) {
        
    }];
}
#pragma mark 每日更新任务数弹框
- (void)taskCountChangePopview
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDate *addtionalrecord = [user objectForKey:TASKCOUNTMENTION];
    NSString *token = [user objectForKey:USER_TOKEN];
    
    //如果没有列表数据或者是没有登录就不弹
    if(self.alldayTaskList.count == 0 || token == nil)
    {
        return;
    }

    if(![[MyMD5 compareDate:addtionalrecord] isEqualToString:@"今天"] || addtionalrecord==nil)
    {
        NSString *URL= [NSString stringWithFormat:@"%@paperwork/paperwork.json",[NSObject baseURLStr_Upy]];
        NSURL *httpUrl=[NSURL URLWithString:URL];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpUrl];
        request.timeoutInterval = 3;
        
        NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        if (data) {
            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            responseObject = [NSDictionary changeType:responseObject];
            if (responseObject!=nil) {
                
                if(responseObject[@"qdrwyd"] != nil)
                {
                    if(responseObject[@"qdrwyd"][@"text"] != nil)
                    {
                      __block  NSString *str0 = @"0";
                        NSString *str1 = @"16";
                        NSString *str2 = @"50";
                        
                        NSArray *listArr = [responseObject[@"qdrwyd"][@"text"] componentsSeparatedByString:@","];
                        if(listArr.count >= 3)
                        {
//                            str0 = [NSString stringWithFormat:@"%@",listArr[0]];
                            str1 = [NSString stringWithFormat:@"%@",listArr[1]];
                            str2 = [NSString stringWithFormat:@"%@",listArr[2]];
                        }
                        
                        [IndianaPublicModel H5getMoney:^(id data) {
                            IndianaPublicModel *model = data;
                            if(model.status == 1 && model.data.floatValue>0)
                            {
                                 str0 = [NSString stringWithFormat:@"%.2f",model.data.floatValue];
                            }
                            
                            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                            BOOL h5moneypopup = [user boolForKey:H5MONEYPOPUP];
                            
                            NSString *titlestr =str0.floatValue>0?[NSString stringWithFormat:@"%@元购衣款已返，完成任务可提现",str0]:@"";
                            if([DataManager sharedManager].h5money >0 && !h5moneypopup)
                            {
                                [user setBool:YES forKey:H5MONEYPOPUP];
                                titlestr = [NSString stringWithFormat:@"你完成%.2f元的任务奖金已放入余额。",[DataManager sharedManager].h5money];
                            }
                            
                            NSString *str=[NSString stringWithFormat:@"%@\n今日更新了%@个任务，共计%@元奖励",titlestr,str1,str2];
                            
                            //何波修改2018-3-26
                            [self setTaskPopMindView:Task_count_mention Value:nil Title:str Rewardvalue:nil Rewardnum:0];
                            NSDate *date = [NSDate date];
                            [user setObject:date forKey:TASKCOUNTMENTION];
                        }];
                        
                    }
                }
            }
            
        }else{
            [self IndianaPaySuccessPopview];
        }
    }else{
        [self IndianaPaySuccessPopview];
    }
}
#pragma 夺宝成功弹框
- (void)IndianaPaySuccessPopview
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *shopfrom = [userdefaul objectForKey:PYSUCCESS];
    //夺宝包邮商品支付成功回调
    if (shopfrom!=nil) {
        MyLog(@"支付成功");
        [userdefaul setObject:nil forKey:PYSUCCESS];
        
        if (shopfrom.intValue == 4)//夺宝
        {
            [self getincode:1];
        }else if (shopfrom.intValue == 5)//拼团夺宝
        {
            [self getincode:2];
        }else{
            [self liulanFinishPopview];
        }
    }else{
        [self liulanFinishPopview];
    }
}

#pragma mark 浏览任务完成弹框
- (void)liulanFinishPopview
{
    if([TaskTimerManager taskTimerManager].liulan_isfinish)
    {
        [TaskTimerManager taskTimerManager].liulan_isfinish = NO;
        _reward_type = [Signmanager SignManarer].liulan_rewardtype;
    
        [self setTaskPopMindView:Task_liulanFinish Value:nil Title:nil Rewardvalue:[Signmanager SignManarer].liulan_rewardvalue Rewardnum:(int)[Signmanager SignManarer].liulan_rewardnumber];
    }else{
        [self mushtTaskAndExtraTaskFinishPopview];
    }
}
#pragma mark 必做任务、额外任务完成弹框
- (void)mushtTaskAndExtraTaskFinishPopview
{
    BOOL taskNOFinish = NO;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDate *addtionalrecord = [user objectForKey:MUSTANDEXTRATASKFINISH];
    if([NextTaskManager taskManager].backToMakeMoney)//当是一键做下个任务过来的不弹
    {
        taskNOFinish = YES;
    }
    else if(![[MyMD5 compareDate:addtionalrecord] isEqualToString:@"今天"] || addtionalrecord==nil)
    {
        BOOL mustTaskFinish = [self mustTaskFinisStatue];
        BOOL extraTaskFinish = [self extraTaskFinisStatue];
        if(mustTaskFinish && extraTaskFinish)
        {
            taskNOFinish = NO;
        }else{
            taskNOFinish = YES;
        }
    
    }else{
        taskNOFinish = YES;
    }

    if(!taskNOFinish && (self.dayMustFinsishList.count || self.dayExtraFinishlist.count))
    {
        [user setObject:[NSDate date] forKey:MUSTANDEXTRATASKFINISH];
        [self setTaskPopMindView:Task_Finish_mention Value:nil Title:nil Rewardvalue:nil Rewardnum:0];
    }else{
        [self finishTixianTaskPopview];
    }
}
#pragma mark 提现任务完成弹框
- (void)finishTixianTaskPopview
{
    //没有完成状态任务：为好友点赞，抽奖赢提现，拼团抽奖，新分享赢提现 余额抽提现(这些任务除外)
    BOOL tixianTaskNOFinsih = NO;//提现任务栏有没有没完成的任务
    for(TaskModel *model in self.surTixianTaskList)
    {
        if(model.isfinish == NO && model.task_type.intValue != 15 && model.task_type.intValue != 21 && model.task_type.intValue != 22 && model.task_type.intValue != 25 && model.task_type.intValue != 27)
        {
            tixianTaskNOFinsih = YES;
            break;
        }
    }
    tixianTaskNOFinsih = ![self tixianTaskFinishStatue];
   
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDate *addtionalrecord = [user objectForKey:TIXIANTASKFINISH];
    if([NextTaskManager taskManager].backToMakeMoney)//当是一键做下个任务过来的不弹
    {
        tixianTaskNOFinsih = YES;
    }
    else if([[MyMD5 compareDate:addtionalrecord] isEqualToString:@"今天"] && addtionalrecord !=nil)
    {
        tixianTaskNOFinsih = YES;
    }
    
    if(self.newbie == 0 && !tixianTaskNOFinsih && self.surTixianFinishlist.count)//新手才弹此框
    {
        [user setObject:[NSDate date] forKey:TIXIANTASKFINISH];
        [self setTaskPopMindView:Task_tixian_finish Value:nil Title:nil Rewardvalue:nil Rewardnum:0];
    }else{
        [self twentyYiduPopview];
    }
    
}
#pragma mark 20衣豆弹框
- (void)twentyYiduPopview
{
    //获取20衣豆弹框
    if([DataManager sharedManager].sguidance >0)
    {
        [self setVitalityPopMindView:Raward_twentyyidou];
        [DataManager sharedManager].sguidance = 0;
    }
}
#pragma mark 惊喜任务完成弹框(免单\疯狂星期一)--此弹框不要了
- (void)finishOrderPopview
{
    //下单成功提示框
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([DataManager sharedManager].Buy_Task && [DataManager sharedManager].Finish_Buy_task)
    {
        for(TaskModel *model in _finishtaskList)
        {
            if(model.task_type.intValue == 6)//购买任务
            {
                if(model.task_class.intValue == 2)//额外任务
                {
                    NSDate *addtionalrecord = [user objectForKey:ADDITIONALFINISHDATA];
                    if(![[MyMD5 compareDate:addtionalrecord] isEqualToString:@"今天"] || addtionalrecord==nil)
                    {
                        [self setTaskPopMindView:Task_buyFinish_type Value:nil Title:nil Rewardvalue:_reward_value Rewardnum:(int)_rewardNumber];
                        [DataManager sharedManager].Buy_Task = NO;
                        [DataManager sharedManager].Finish_Buy_task = NO;
                        [self requestHttp];
                        
                        NSDate *date = [NSDate date];
                        [user setObject:date forKey:ADDITIONALFINISHDATA];
                    }
                }else if (model.task_class.intValue == 4)//惊喜提现任务
                {
                    NSDate *tixianrecord = [user objectForKey:TIXIANFINISHDATA];
                    if(![[MyMD5 compareDate:tixianrecord] isEqualToString:@"今天"] || tixianrecord==nil){
                        
                        [self setTaskPopMindView:Task_buyFinish_type Value:nil Title:nil Rewardvalue:_reward_value Rewardnum:(int)_rewardNumber];
                        [DataManager sharedManager].Buy_Task = NO;
                        [DataManager sharedManager].Finish_Buy_task = NO;
                        [self requestHttp];
                        
                        NSDate *date = [NSDate date];
                        [user setObject:date forKey:TIXIANFINISHDATA];
                    }
                }
            }else if (model.task_type.intValue == 28)//超级0元购任务
            {
                NSDate *addtionalrecord = [user objectForKey:SUPERZEROSHOPPINGDATE];
                if(![[MyMD5 compareDate:addtionalrecord] isEqualToString:@"今天"] || addtionalrecord==nil)
                {
                    [self setTaskPopMindView:Task_buyFinish_type Value:nil Title:nil Rewardvalue:_reward_value Rewardnum:(int)_rewardNumber];
                    [DataManager sharedManager].Buy_Task = NO;
                    [DataManager sharedManager].Finish_Buy_task = NO;
                
                    [self requestHttp];
                    
                    NSDate *date = [NSDate date];
                    [user setObject:date forKey:SUPERZEROSHOPPINGDATE];
                }
            }
        }
    }
    else if(_finishtaskList.count && [user boolForKey:REMIND_ORDER] != YES)//每月惊喜任务
    {
        for(TaskModel *model in _finishtaskList)
        {
            if(model.task_type.intValue == 6 || model.task_type.intValue == 24)//购买任务
            {
                if(model.task_class.intValue == 3)//惊喜任务
                {
                    [self setTaskPopMindView:Task_order_type Value:nil Title:nil Rewardvalue:_reward_value Rewardnum:(int)_rewardNumber];
                    
                    [user setBool:YES forKey:REMIND_ORDER];
                    break;
                }
            }
        }
    }
    else{//免单\疯狂星期一
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *usertoken = [ud objectForKey:USER_TOKEN];
        
        if (![ud boolForKey:@"FreemOrderisFirst"] && usertoken.length >10)
        {
            if([[self getresult] isEqualToString:@"免单"])//免单
            {
                [ud setBool:YES forKey:@"FreemOrderisFirst"];
                [self setFreeOrderPopMindView:freeOrderType];
            }else if([[self getresult] isEqualToString:@"疯狂星期一"])//疯狂星期一
            {
                
            }
        }
    }
}

#pragma mark 签到任务弹框
- (void)setTaskPopMindView:(TaskPopType)type Value:(NSString*)value Title:(NSString*)title Rewardvalue:(NSString*)rewardValue Rewardnum:(int)num
{
    if(bonusview)
    {
        [bonusview removeFromSuperview];
        bonusview = nil;
    }
    
    bonusview = [[FinishTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) TaskType:type TaskValue:value Title:title RewardValue:rewardValue RewardNumber:num Rewardtype:_reward_type];
    
    kSelfWeak;
    bonusview.tapHideMindBlock = ^{
        kSelfStrong;
        [strongSelf->bonusview remindViewHiden];
    };
    
    bonusview.leftHideMindBlock = ^(NSString*title){
        MyLog(@"左");
        [weakSelf gotovc:title Tasktype:type];
    };
    
    bonusview.rightHideMindBlock = ^(NSString*title){
        MyLog(@"右");
        [weakSelf gotovc:title Tasktype:type];
    };
    
    [self.view addSubview:bonusview];
}

#pragma mark 弹框跳转
- (void)gotovc:(NSString*)title Tasktype:(TaskPopType)type
{
    if([title isEqualToString:@"去浏览美衣~"])//浏览
    {
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"is_read"] == YES)
        {
            NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"liulanModel"];
            TaskModel *oldmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
            [self liulanDapei:oldmodel];
        }else{
            [self liulanDapei:PubtaskModel];
        }
        
    }else if ([title isEqualToString:@"去浏览美衣~~"])//加购物车
    {
//        TFShoppingViewController *shopvc = [[TFShoppingViewController alloc]init];
//        shopvc.hidesBottomBarWhenPushed = YES;
//        shopvc.pushCome = YES;
//        [self.navigationController pushViewController:shopvc animated:YES];
        
        [self shoppinggo:PubtaskModel];
    }
    else if ([title hasPrefix:@"去分享美衣"])
    {
        [self beginshareStatue];
    }
    else if ([title hasPrefix:@"买买买"])
    {
        if(type == Task_supprise_type || type == Task_goumai_type || type == Task_DoubleActiveRule)
        {
            [self shoppinggo:PubtaskModel];
        }else{
            TaskCollectionVC *vc = [[TaskCollectionVC alloc]init];
            vc.typeID = [NSNumber numberWithInt:6];
            vc.typeName = @"热卖";
            vc.title = @"热卖";
            vc.is_jingxi = YES;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else if ([title isEqualToString:@"查看金币"])
    {
        UILabel *countlab = (UILabel*)[self.view viewWithTag:400001];
        GoldViewController *vc = [[GoldViewController alloc]init];
        vc.jifen = countlab.text;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];

    }else if ([title isEqualToString:@"去结算"])
    {
        NewShoppingCartViewController *shoppingcart =[[NewShoppingCartViewController alloc]init];
        shoppingcart.ShopCart_Type = ShopCart_NormalType;
        shoppingcart.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:shoppingcart animated:YES];
    }else if ([title isEqualToString:@"知道了"] || [title isEqualToString:@"再逛逛"])
    {

    }else if ([title isEqualToString:@"去0元购衣"])
    {
        BOOL zeroshoppong_isfirst = [[NSUserDefaults standardUserDefaults] boolForKey:ZEROSHOPPINGTASKMENTION];
        if(!zeroshoppong_isfirst)
        {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ZEROSHOPPINGTASKMENTION];
            [self setVitalityPopMindView:Super_zeroShopping];
        }else{
            Mtarbar.selectedIndex=0;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    }else if ([title isEqualToString:@"查看金券"])
    {
        TFMyCardViewController *tmvc = [[TFMyCardViewController alloc] init];
        tmvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tmvc animated:YES];
        
    }else if ([title isEqualToString:@"查看余额"])
    {
        TFMyWalletViewController *wallet = [[TFMyWalletViewController alloc]init];
        wallet.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:wallet animated:YES];

    }else if ([title isEqualToString:@"立即查看~"])
    {
        AXSampleNavBarTabViewController *vc = [[AXSampleNavBarTabViewController alloc]initWithType:YDPageVCTypeMoney peas:[bCount floatValue] peas_freeze:[tixian floatValue] extract:0 freezeMoney:[fCount floatValue]];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"去集赞"])
    {
        [self goyaoqing:YES];
    }else if ([title isEqualToString:@"确 定"])
    {
        if(type == Task_jizanOver_type)
        {
            [self httpGetData];//获取衣豆
        }else if (type == Task_yiduNoenough_type)//衣豆不足
        {
            [self setVitalityPopMindView:Raward_getyidou];
        }
    }else if ([title isEqualToString:@"查看我的衣豆"])
    {
        AXSampleNavBarTabViewController *vc = [[AXSampleNavBarTabViewController alloc]initWithType:YDPageVCTypeMoney peas:[bCount floatValue] peas_freeze:[tixian floatValue] extract:0 freezeMoney:[fCount floatValue]];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"补充衣豆"]){
        TaskModel *model = [TaskModel alloc];
        model.value = [DataManager sharedManager].mondayValue;
        [self shoppinggo:model];
    }else if ([title isEqualToString:@"继续点赞"])
    {
        //免费点赞用完
        [self setTaskPopMindView:Task_jizanOver_type Value:nil Title:nil Rewardvalue:_reward_value Rewardnum:0];
    }else if ([title isEqualToString:@"我先逛逛"])
    {
        Mtarbar.selectedIndex=0;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if ([title isEqualToString:@"赚赚赚"])
    {
        if(self.dayExtraTasklist.count)
        {
            NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:4];
            
            [self.MytableView scrollToRowAtIndexPath:scrollIndexPath
                                    atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }else if ([title isEqualToString:@"一键做下个任务"] || [title isEqualToString:@"一键完成任务"])
    {
        [[Animation shareAnimation] CreateAnimationAt:self.view];
        [self performSelector:@selector(getNextTask) withObject:nil afterDelay:0.5];
    }else if ([title isEqualToString:@"立即开启特权"])
    {
        CFActivityDetailToPayVC *CFActivity = [[CFActivityDetailToPayVC alloc]init];
        CFActivity.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:CFActivity animated:YES];
        
        [[DataManager sharedManager] getyidouQualifications];
    }else if ([title isEqualToString:@"继续分享"])//新分享赢提现
    {
        [self creatTixianPopview];
    }
}

#pragma mark 账户明细
- (void)gotoAccount:(UITapGestureRecognizer*)tap
{
    [self loginSuccess:^{
        TFAccountDetailsViewController *tdvc = [[TFAccountDetailsViewController alloc] init];
        tdvc.headIndex = 1;
        tdvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tdvc animated:YES];
    }];
}
#pragma mark 我的钱包
- (void)goToWallet:(UITapGestureRecognizer*)tap
{
    [self loginSuccess:^{
        LuckdrawViewController *wallet = [[LuckdrawViewController alloc]init];
        wallet.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:wallet animated:YES];
    }];
}
#pragma mark 提现中
- (void)goTotixian:(UITapGestureRecognizer*)tap
{
    [self loginSuccess:^{
        CFAccountDetailFromTaskVC *wallet = [[CFAccountDetailFromTaskVC alloc]init];
        wallet.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:wallet animated:YES];
    }];

}
#pragma makr 惊喜任务置顶
- (void)taskJingxiTixianToTop
{
    if(self.surTixianTaskList.count)
    {
        NSIndexPath * dayOne = [NSIndexPath indexPathForRow:0 inSection:2];
        [self.MytableView scrollToRowAtIndexPath:dayOne atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}
#pragma mark 免单弹框
- (void)setFreeOrderPopMindView:(FreeOrderType)Ordertype
{
    freeorderview = [[FreeOrderPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) FreeOrderType:Ordertype];
    __weak FreeOrderPopview *view = freeorderview;
    kWeakSelf(self);
    view.tapHideMindBlock = ^{
        
        if(Ordertype == CrazyMonday_activity)
        {
            [weakself loginSuccess:^{
                [weakself CrazyMonday];
            }];
        }else{
            FashionBuyInfoVC *vc = [[FashionBuyInfoVC alloc]init];
            if(Ordertype == FreeOrder_hundred)
            {
                vc.fashionType = 1;
            }else{
                vc.fashionType = 2;
            }
            vc.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:vc animated:YES];
        }
    };
    
    view.getLuckBlock = ^{
        
        [weakself loginSuccess:^{
            CrazyStyleViewController *vc = [[CrazyStyleViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:vc animated:YES];
        }];
    };
    
    [self.view addSubview:freeorderview];
}

- (NSString*)getresult
{
    NSString* retult = @"";
    
    for(TaskModel *model in self.surpriseTaskList)
    {
        NSString *tasktype = model.task_type;
        if([tasktype intValue] == 9)
        {
            if(_finishtaskList.count == 0)
            {
                if([model.value intValue] == 1)
                {
                    freeOrderType = FreeOrder_hundred;
                }else{
                    freeOrderType = FreeOrder_fifty;
                }
                
                retult = @"免单";
            }else{
                
                for(TaskModel *model2 in _finishtaskList)
                {
                    if([model2.task_type intValue] == 9 && model2.isfinish != YES)
                    {
                        if([model.value intValue] == 1)
                        {
                            freeOrderType = FreeOrder_hundred;
                        }else{
                            freeOrderType = FreeOrder_fifty;
                        }

                         retult = @"免单";
                    }
                }
            }
        }else if([tasktype intValue] == 6){
             retult = @"疯狂星期一";
        }
    }

    return retult;
}

#pragma mark 获得20衣豆弹框
- (void)setVitalityPopMindView:(VitalityType)type
{
    vitaliview = [[VitalityTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) VitalityType:type valityGrade:self.valityGrade YidouCount:0];
    __weak VitalityTaskPopview *view = vitaliview;
    kWeakSelf(self);
    view.tapHideMindBlock = ^{
        
        if(type == Stop_business)
        {
            sharLink = @"share=h5money";
            [self miniSharewithTypeisShop:NO Tixian:NO Sharelink:nil];
        }else{
            [view remindViewHiden];
            vitaliview_ishiden = YES;
        }
    };
    
    view.leftHideMindBlock = ^(NSString*title){
        
        if(type == Stop_business)
        {
            sharLink = @"share=h5money";
            [self miniSharewithTypeisShop:NO Tixian:NO Sharelink:nil];
        }else{
            [weakself gotoshop:type];
        }
    };
    
    if(type == Stop_business)
    {
        [kUIWindow addSubview:vitaliview];
    }else
        [self.view addSubview:vitaliview];
    
}

- (void)gotoshop:(VitalityType)type
{
    if(type == Vitality_Onehundred)
    {
        MyVipVC *vip = [[MyVipVC alloc]init];
        vip.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vip animated:YES];
        
    }else if (type == Raward_twentyyidou)
    {
        LuckdrawViewController *luck = [[LuckdrawViewController alloc]init];
        luck.hidesBottomBarWhenPushed = YES;
        luck.mondaytype = self.mondytype;
        luck.LotteryNumber = self.LotteryNumber;
        [self.navigationController pushViewController:luck animated:YES];
    }else if (type == Super_redZeroShopping)
    {
        [self shoppinggo:PubtaskModel];

    }else if (type == Super_zeroShopping)
    {
        TFCollocationViewController *subVC = [[TFCollocationViewController alloc] init];
        subVC.page = 0;
        subVC.typeName = @"专题";
        subVC.typeID = [NSNumber numberWithInt:2];
        subVC.isFinish = PubtaskModel.isfinish;
        subVC.pushType = PushTypeSign;
        subVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:subVC animated:YES];
    }else if (type == BecomeMember_task)
    {
        AddMemberCardViewController *addcard = [[AddMemberCardViewController alloc]init];
        addcard.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addcard animated:YES];
    }
    else{
        
        TaskCollectionVC *vc = [[TaskCollectionVC alloc]init];
        vc.typeID = [NSNumber numberWithInt:6];
        vc.typeName = @"热卖";
        vc.title = @"热卖";
        vc.is_jingxi = YES;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

#pragma mark ***********************版本更新**********************
- (void)updateview {
    //网络获取当前版本
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    if (appDelegate.isUpdata == YES && [DataManager sharedManager].shouYeGround == 2) {
        
        NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
        BOOL isShow = [userDef boolForKey:UPDATE_SHOW];
        NSTimeInterval time = [NSDate date].timeIntervalSince1970 - [userDef doubleForKey:UPDATE_TIME];
        if (isShow || time < 72*60*60) {
//            [self taskCountChangePopview];
        }else{
            
            /// 强制更新
            NSString *version_no = [NSString stringWithFormat:@"%@更新了以下内容",appDelegate.version_no];
            NSString *msg = [NSString stringWithFormat:@"%@",appDelegate.msg];
            [UpdateView showType:appDelegate.isQiangGeng title:@"衣蝠发新版啦～" subtitle:version_no text:msg toView:self.view.window removeBlock:^{
                
            }];
        }
    } else{

//        [self taskCountChangePopview];
    }

    [self changeGoldUI];
    
    //总余额
    CGFloat over = [_toatlbCount floatValue];
    if ([DataManager sharedManager].isOligible&&[DataManager sharedManager].isOpen&&([DataManager sharedManager].twofoldness > 0)) {
        over *= [DataManager sharedManager].twofoldness;
        
        NSString*bCount1 = [NSString stringWithFormat:@"%.2f",over];
        
        UILabel *countlab = (UILabel*)[self.view viewWithTag:400000];
        
        if([bCount1 floatValue] > 0)
        {
            countlab.text = bCount1;
        }
        
        if([bCount1 floatValue] > 0)
        {
            self.totalMoney.text = [NSString stringWithFormat:@"余额%@元",bCount1];
            [self getBalancemutable:self.totalMoney Text:bCount1 FromIndex:2];
        }
    }
}

#pragma mark ***********************提现引导弹框**********************
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
        kWeakSelf(self);
        VC.bindNameAndIdenfBlock = ^(NSInteger sguidance) {
            
            if(sguidance != 0)
            {
                weakself.lastGrade = sguidance;
            }
        };
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } withNoOperationBlock:^{
        
        [VitalityModel posguide:^(id data) {//弹了引导弹框告诉后台
            
        }];

    }];
}

#pragma mark *************************额外奖励**********************
- (void)setExtraTopView:(int)browseCount Count_money:(float)count_money
{
    //如果没有登录就不显示
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:USER_TOKEN];
    if(token.length <10)
    {
        return;
    }
    kSelfWeak;
    _ExtratopView.RemindBtnBlock = ^{
        MyLog(@"额外奖励");
//        [weakSelf goFabous:NO];
        [weakSelf CFInviteFriends:NO];
    };
    
    if(self.point_count.intValue > 100000)
    {
        _ExtratopView.BrowseLabel.text = @"100000+";
    }else{
        _ExtratopView.BrowseLabel.text = [NSString stringWithFormat:@"累计分享数：%d",shareCount.intValue];
    }
    
    if(self.total_rewards.floatValue > 10000)
    {
        _ExtratopView.FunsLabel.text = @"10000+";
    }else{

        _ExtratopView.FunsLabel.text = [NSString stringWithFormat:@"累计获得奖励:%.2f元",shareMoneyCount.floatValue];
    }
    
    [UIView animateWithDuration:0.1 animations:^{

        _ExtratopView.frame =CGRectMake(0, Height_NavBar, kScreenWidth, 30);
        backimmage.frame= CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar);
        _MytableView.frame = CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar);

    } completion:^(BOOL finish) {

    }];
}

- (void)RetroactiveClick:(UITapGestureRecognizer*)tap
{
    int tag = (int)tap.view.tag;

    kSelfWeak;
    [self loginVerifySuccess:^{
        if(tag == 300000)//余额
        {
            [MobClick event:QIANDAO_YUER];
            
            TFMyWalletViewController *wallet = [[TFMyWalletViewController alloc]init];
            wallet.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:wallet animated:YES];
            
        }else if (tag == 300001)//积分
        {
            [MobClick event:QIANDAO_JIFEN];
            
            UILabel *countlab = (UILabel*)[weakSelf.view viewWithTag:400001];
            
            if([GoldCouponsManager goldcpManager].gold_is_open == YES)
            {
                GoldViewController *vc = [[GoldViewController alloc]init];
                vc.jifen = countlab.text;
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else{
                HYJIntelgralDetalViewController *vc = [[HYJIntelgralDetalViewController alloc] init];
                vc.jifen = countlab.text;
                vc.hidesBottomBarWhenPushed = YES;
                vc.index = 0;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
            
        }else if (tag == 300002)//卡券
        {
            [MobClick event:QIANDAO_KAQUAN];
            TFMyCardViewController *tmvc = [[TFMyCardViewController alloc] init];
            tmvc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:tmvc animated:YES];
        }else if (tag == 300003)//夺宝记录
        {
            TFIndianaRecordViewController *tiVC = [[TFIndianaRecordViewController alloc] init];
            tiVC.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:tiVC animated:YES];
        }
    }];

}
-(void)tapClick
{
    
    [_canclebtn removeFromSuperview];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _Popview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        _InvitationCodeView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        _InvitationCodeView.alpha = 0;
        
    } completion:^(BOOL finish) {
        
        [_Popview removeFromSuperview];
        
        _Popview = nil;
    }];
    
}
#pragma mark *************************网络部分**********************
#pragma mark 任务列表
- (void)taskListHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    
    if(token ==nil || [token isEqual:[NSNull null]])//没登录
    {
        url=[NSString stringWithFormat:@"%@signIn2_0/siTaskList?version=%@",[NSObject baseURLStr],VERSION];
        
    }else{//已登录
        
        url=[NSString stringWithFormat:@"%@signIn2_0/siLogTaskList?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    }
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            if(responseObject[@"today_ref"] != nil)
            {
                self.today_ref = [responseObject[@"today_ref"] integerValue];
            }

            //保存存储的数据
            [NSObject saveResponseData:responseObject toPath:url];
            
            [self taskListGetData:responseObject redMoney:[DataManager sharedManager].is_RedMoney];
           
            if(token ==nil || [token isEqual:[NSNull null]])//没登录
            {
                 [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstLogin"];
            }else{
                 [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:FIRSTCOMING];
            }
           
            NSMutableString *liststr = [NSMutableString string];
            if([responseObject[@"motaskList"] count])
            {
                for(NSDictionary *dic in responseObject[@"motaskList"])
                {
                    NSString *str = [NSString stringWithFormat:@"%@",dic[@"id"]];
                    
                    if(str)
                    {
                        [liststr appendString:str];
                    }
                }
            }
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString *signstr = [user objectForKey:SIGN_STRING];
            
            if(![signstr isEqualToString:liststr])
            {
                if(token.length > 0)
                {
                    [Signmanager SignManarer].signChange = NO;
                    [user setObject:[NSString stringWithFormat:@"%@",liststr] forKey:SIGN_STRING];
                }
            }else{
                
                //签到表更新后弹窗提示
                if([Signmanager SignManarer].signChange == YES)
                {
                    [Signmanager SignManarer].signChange = NO;
                }
                
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [MBProgressHUD hideHUDForView:self.view];
        id responseObject = [NSObject loadResponseWithPath:url];
        [self taskListGetData:responseObject redMoney:NO];
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"网络连接失败，请检查网络设置~" Controller:self];
    }];
    
}

//任务列表数据
- (void)taskListGetData:(NSDictionary *)responseObject redMoney:(BOOL)redmoney
{
    NSString *statu=responseObject[@"status"];
    
    if(statu.intValue==1)
    {
        if([responseObject[@"taskList"] count])
        {
            [_MydataArray removeAllObjects];
            [_motaskIDList removeAllObjects];
            
            _motaskDataArray = [NSMutableArray arrayWithArray:responseObject[@"taskList"]];
            _alldayTaskList = [NSMutableArray arrayWithArray:responseObject[@"daytaskList"]];
            
            for(NSDictionary *dic in responseObject[@"taskList"])
            {
                //后面加上
                NSString * ID = [NSString stringWithFormat:@"%@",dic[@"id"]];

                if(ID !=nil)
                {
                    [_motaskIDList addObject:ID];
                }
            }
        }
        
        //完成任务的图标列表
        if([responseObject[@"shopGroupList"] count])
        {
            self.shopGroupList = responseObject[@"shopGroupList"];
        }

        //将daytaskList中已经完成的任务删除掉
        _noFinishTasklist = [NSMutableArray arrayWithArray:responseObject[@"daytaskList"]];
        NSMutableArray *idArr = [NSMutableArray array];

        //获取当日必做任务数、额外任务数、提现任务数
        [self getTodayTaskCount];
    
        if(_finishtaskList.count && _noFinishTasklist.count)
        {
            for(TaskModel *model in _finishtaskList)
            {
                for(int i =0 ;i<_noFinishTasklist.count;i++)
                {
                    NSDictionary *dic = _noFinishTasklist[i];
                    
                    if((model.index.intValue == [dic[@"index"] intValue]) && (model.task_type.intValue == [dic[@"task_type"] intValue]))
                    {
                        model.value = [NSString stringWithFormat:@"%@",dic[@"value"]];
                        model.num = [NSString stringWithFormat:@"%@",dic[@"num"]];
                        model.icon = [NSString stringWithFormat:@"%@",dic[@"icon"]];
                        for(NSDictionary *shopdic in self.shopGroupList)
                        {
                            if([model.icon isEqualToString:[NSString stringWithFormat:@"%@",shopdic[@"id"]]])
                            {
                                model.shopImage = [NSString stringWithFormat:@"%@",shopdic[@"icon"]];
                                model.app_name = [NSString stringWithFormat:@"%@",shopdic[@"app_name"]];
                            }
                        }
                        
                        [idArr addObject:dic];
                    }
                    
                }
                
                [self getTitle_image:model];
            }
            
            [_noFinishTasklist removeObjectsInArray:idArr];
        }
        
        //今天任务
        if([responseObject[@"daytaskList"] count])
        {
            [self.dayMustTaskList removeAllObjects];
            [self.dayExtraTasklist removeAllObjects];
            [self.surpriseTaskList removeAllObjects];
            [self.FabulousTaskList removeAllObjects];
            [self.surTixianTaskList removeAllObjects];
            
            NSMutableArray *MonthArray  = [NSMutableArray array];
           
            //当是疯狂星期一的时候前端自己加入一条疯狂星期一的任务
            if(self.mondytype == Mondytype_YES)
            {
                [self insertMondayTask:[NSString stringWithFormat:@"%d",(int)self.LotteryNumber]];
            }else{
                [self.FabulousTaskList removeObject:Suprisemodel];
            }

            //未完成的列表数据
            for(NSDictionary *todayDic in _noFinishTasklist)
            {
                TaskModel *model = [[TaskModel alloc]init];
                model.index = [NSString stringWithFormat:@"%@",todayDic[@"index"]];
                model.num = [NSString stringWithFormat:@"%@",todayDic[@"num"]];
                model.t_id = [NSString stringWithFormat:@"%@",todayDic[@"t_id"]];
                model.task_class = [NSString stringWithFormat:@"%@",todayDic[@"task_class"]];
                model.task_type = [NSString stringWithFormat:@"%@",todayDic[@"task_type"]];
                model.value = [NSString stringWithFormat:@"%@",todayDic[@"value"]];
                model.icon = [NSString stringWithFormat:@"%@",todayDic[@"icon"]];
                model.task_h5 = [NSString stringWithFormat:@"%@",todayDic[@"task_h5"]];
                
                //后面加上的
                for(NSDictionary *shopdic in self.shopGroupList)
                {
                    if([model.icon isEqualToString:[NSString stringWithFormat:@"%@",shopdic[@"id"]]])
                    {
                        model.app_name = [NSString stringWithFormat:@"%@",shopdic[@"app_name"]];
                    }
                }
                
                [self getTitle_image:model];
                
                NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:USER_TOKEN];
                if(model.task_h5.intValue >= 5)
                {
                    continue;
                }
                else if(model.task_type.intValue == 15)//继续为好友点赞
                {
                    if(self.point_status <= 0)
                    {
                        continue;
                    }
                }
                else if(model.task_type.intValue == 17 && token.length >10)//参团
                {
                    //人员资格再次调整为参团可开团，开团与参团过的均不可参。即一个团成立后，该团内所有人均不可再次参团，除团长以外的成员可进入APP开团。同时参团仅限从未在衣服注册过的用户参与
                    if(self.roll == 0)
                    {
                        //正常被引导且没有开过团
                        if(self.fighStatus.intValue == 1 || self.fighStatus.intValue == -1)
                        {
                            if (self.orderCount == 1)
                            {
                                //开过一次团且开团完成
                                if(self.orderStatus.intValue == 1)
                                {
                                    continue;
                                }else{
                                    //参团完成
                                    if(self.offered.intValue == 1)
                                    {
                                        continue;
                                    }

                                }
                            }else if(self.orderCount > 1){
                                continue;
                            }else if (self.orderCount == 0)
                            {
                                //参团完成
                                if(self.offered.intValue == 1)
                                {
                                    continue;
                                }
                            }
                        }
                        else{
                            continue;
                        }
                        
                    }else if(self.roll != 1)
                    {
                        continue;
                    }
                }
                else if(model.task_type.intValue == 18 && token.length >10)//开团
                {
                    //只有1次开团机会
                    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:USER_TOKEN];
                    if(self.mondytype != Mondytype_YES && token.length >10)
                    {
                        if(self.orderCount == 1)
                        {
                            //开过一次团且开团完成
                            if(self.orderStatus.intValue == 1)
                            {
                                continue;
                            }
                        }else if(self.orderCount > 1){
                            continue;
                        }
                    }else{
                        continue;
                    }
                }
                else if(model.task_type.intValue == 23)//千元红包雨
                {
                    //如果是疯狂星期一且没有红包雨任务 则红包雨任务隐藏
                    if(self.mondytype != Mondytype_YES && self.today_ref ==1)
                    {
                        //标记红包雨任务出现
                        NSDate *date = [NSDate date];
                        [[NSUserDefaults standardUserDefaults] setObject:date forKey:GUIDEORDER];
                    }else{
                        continue;
                    }
                }
                else if(model.task_type.intValue == 26)//红包抽余额
                {
                    //如果没有抽红包资格就没有去抽奖这个任务
                    if(!redmoney)
                    {
                        continue;
                    }
                }
                else if(model.task_type.intValue == 28)//超级0元购
                {
                    if(self.mondytype == Mondytype_YES)
                    {
                        continue;
                    }
                }

                if([model.task_class intValue] == 1)//必做
                {
                    [self.dayMustTaskList addObject:model];
                }
                else if ([model.task_class intValue] == 2)//额外
                {
                    [self.dayExtraTasklist addObject:model];
                }
                else if (model.task_class.intValue == 6)//超级惊喜(夺宝+拼团)
                {
                    [self.FabulousTaskList addObject:model];
                }
                else if([model.task_class intValue] == 3)//每月惊喜任务
                {
                    if(model.task_type.intValue == 24)
                    {
                        self.mondytype == Mondytype_NO?[MonthArray addObject:model]:nil;
                    }else
                        [self.surpriseTaskList addObject:model];
                    
                }else if ([model.task_class intValue] == 4)//惊喜提现任务
                {
                    if (model.task_type.intValue == 6)//购买赢提现
                    {
                        self.mondytype == Mondytype_NO?[self.surTixianTaskList addObject:model]:nil;
                    }else{
                        [self.surTixianTaskList addObject:model];
                    }
                }
            }

            //任务优先级 疯狂星期一 >拼团购 >每月惊喜 >购买赢提现
            //疯狂星期一出现的时候，拼团购、每月惊喜任务、千元红包雨任务、购买赢提现任务隐藏
            //拼团购出现的时候，每月惊喜任务隐藏
            for(TaskModel *surmodel in self.FabulousTaskList)
            {
                if(surmodel.task_type.intValue == 18 && self.mondytype != Mondytype_YES)
                {
                    self.isPingtuan = YES;
                    break;
                }
            }
            //将每月的惊喜任务放到超级惊喜任务栏第一个
            if(MonthArray.count && !self.isPingtuan && self.mondytype != Mondytype_YES)
            {
                [MonthArray addObjectsFromArray:self.FabulousTaskList];
                [self.FabulousTaskList removeAllObjects];
                [self.FabulousTaskList addObjectsFromArray:MonthArray];
            }
            
            //完成的任务列表数据
            for(TaskModel * model in _finishtaskList)
            {
                if([model.task_class intValue] == 1)
                {
                    if(model.task_type.intValue == 16)
                    {
                        [self.dayMustFinsishList addObject:model];
                    }else if (model.task_type.intValue == 15)
                    {
                        self.point_status>0?[self.dayMustFinsishList addObject:model]:nil;
                    }else{
                        [self.dayMustFinsishList addObject:model];
                    }
                }else if ([model.task_class intValue] == 2)
                {
                    [self.dayExtraFinishlist addObject:model];
                }else if (model.task_class.intValue == 6)//夺宝+拼团
                {
                    if(model.task_type.intValue == 17)//参团
                    {
                        [self.FabulousFinishlist addObject:model];
                    }else if (model.task_type.intValue == 18)//开团
                    {
                        [self.FabulousFinishlist addObject:model];
                    }
                    else{
                        [self.FabulousFinishlist addObject:model];
                    }
                }else if ([model.task_class intValue] == 4)//惊喜提现
                {
                    if(model.task_type.intValue == 16)
                    {
                        [self.surTixianFinishlist addObject:model];
                    }else if (model.task_type.intValue == 15)
                    {
                        self.point_status>0?[self.surTixianFinishlist addObject:model]:nil;
                    }else{
                        [self.surTixianFinishlist addObject:model];
                    }
                }
                else if ([model.task_class intValue] != 3 && [model.task_class intValue] != 4)
                {
                    [self.surFinishTaskList addObject:model];
                }

            }
        }

        //明天任务
        if([responseObject[@"tomorrowTaskList"] count])
        {
            [_tomorrowTaskList removeAllObjects];
            
            for(NSDictionary *tomorrowDic in responseObject[@"tomorrowTaskList"])
            {
                TaskModel *model = [[TaskModel alloc]init];
                model.index = [NSString stringWithFormat:@"%@",tomorrowDic[@"index"]];
                model.num = [NSString stringWithFormat:@"%@",tomorrowDic[@"num"]];
                model.t_id = [NSString stringWithFormat:@"%@",tomorrowDic[@"t_id"]];
                model.task_class = [NSString stringWithFormat:@"%@",tomorrowDic[@"task_class"]];
                model.task_type = [NSString stringWithFormat:@"%@",tomorrowDic[@"task_type"]];
                model.value = [NSString stringWithFormat:@"%@",tomorrowDic[@"value"]];
                [self getTitle_image:model];
                [_tomorrowTaskList addObject:model];
            }
        }

        //总任务列表
        if([responseObject[@"taskList"] count])
        {
            _dataArray = responseObject[@"taskList"];
            
            for(NSDictionary *dic in responseObject[@"taskList"])
            {
                SignModel *model = [[SignModel alloc]init];
                
                model.condition =[NSString stringWithFormat:@"%@",dic[@"condition"]];
                model.t_id =[NSString stringWithFormat:@"%@",dic[@"t_id"]];
                model.t_name =[NSString stringWithFormat:@"%@",dic[@"t_name"]];
                model.type_id =[NSString stringWithFormat:@"%@",dic[@"type_id"]];
                model.value =[NSString stringWithFormat:@"%@",dic[@"value"]];
                model.more = [NSString stringWithFormat:@"%@",dic[@"more"]];
                
                [_MydataArray addObject:model];
            }
        }
    }
    
    [_MytableView reloadData];
}

#pragma mark 获取当天必做任务数、额外任务数、惊喜提现任务数
- (void)getTodayTaskCount
{
    self.musttaskCount = 0;
    self.extrataskCount = 0;
    self.tixiantaskCount = 0;
    
    for(NSDictionary *dic in _noFinishTasklist)
    {
        NSString *taskclass = [NSString stringWithFormat:@"%@",dic[@"task_class"]];

        if(taskclass.intValue == 1)
        {
            self.musttaskCount ++;
        }else if (taskclass.intValue == 2)
        {
            self.extrataskCount ++;
        }else if (taskclass.intValue == 4)
        {
            self.tixiantaskCount ++;
        }
    }
}

- (void)insertMondayTask:(NSString*)value
{
    Suprisemodel = [[TaskModel alloc]init];
    Suprisemodel.index = @"";
    Suprisemodel.num = @"";
    Suprisemodel.t_id = @"";
    Suprisemodel.task_class = @"3";
    Suprisemodel.task_type = @"999";
    Suprisemodel.value = value;
    Suprisemodel.icon = @"";
    Suprisemodel.isfinish = NO;
    [self getTitle_image:Suprisemodel];

    [self.FabulousTaskList addObject:Suprisemodel];
}

#pragma mark 完成任务数据请求
- (void)finishtaskHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@signIn2_0/userTaskList?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    MyLog(@"%d",[Signmanager SignManarer].task_isfinish);
    
    if(token ==nil || [token isEqual:[NSNull null]])//没登录
    {
        [self taskListHttp];
        return;
        
    }

    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil){

            //保存存储的数据
            [NSObject saveResponseData:responseObject toPath:url];
            [self finishtaskListGetData:responseObject];
            [Signmanager SignManarer].task_isfinish = NO;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        id responseObject = [NSObject loadResponseWithPath:url];
        [self finishtaskListGetData:responseObject];
    }];
}

//完成任务列表数据
- (void)finishtaskListGetData:(NSDictionary *)responseObject
{
    NSString *statu=responseObject[@"status"];
    
    if(statu.intValue==1)
    {
        self.day = [NSString stringWithFormat:@"%@",responseObject[@"day"]];
        
        [_finishtaskList removeAllObjects];
        [_soonFinishList removeAllObjects];
        [self.dayMustFinsishList removeAllObjects];
        [self.dayExtraFinishlist removeAllObjects];
        [self.surFinishTaskList removeAllObjects];
        [self.FabulousFinishlist removeAllObjects];
        [self.surTixianFinishlist removeAllObjects];
        
        self.musttaskFtinishCount = 0;
        self.extrataskFtinishCount = 0;
        self.tixiantaskFtinishCount = 0;
        
        if([responseObject[@"taskList"] count] )
        {
            [Signmanager SignManarer].signIn_status = [NSString stringWithFormat:@"%@",responseObject[@"signIn_status"]];
            
            for(NSDictionary *finishdic in responseObject[@"taskList"])
            {
                TaskModel *model = [[TaskModel alloc]init];
                model.index = [NSString stringWithFormat:@"%@",finishdic[@"index_id"]];
                model.num = [NSString stringWithFormat:@"%@",finishdic[@"num"]];
                model.t_id = [NSString stringWithFormat:@"%@",finishdic[@"t_id"]];
                model.task_class = [NSString stringWithFormat:@"%@",finishdic[@"task_class"]];
                model.task_type = [NSString stringWithFormat:@"%@",finishdic[@"task_type"]];
                model.value = [NSString stringWithFormat:@"%@",finishdic[@"value"]];
                model.status = [NSString stringWithFormat:@"%@",finishdic[@"status"]];
                
                if(model.task_class.intValue == 1)
                {
                    self.musttaskFtinishCount ++;
                }else if (model.task_class.intValue == 2)
                {
                    self.extrataskFtinishCount ++;
                }else if (model.task_class.intValue == 4)
                {
                    self.tixiantaskFtinishCount ++;
                }
                [_soonFinishList addObject:model];
                if(model.status.intValue == 0)
                {
                    model.isfinish = YES;
                    [_finishtaskList addObject:model];
                }
            }
        }
    }
    else if (statu.intValue==10030)
    {
        [_finishtaskList removeAllObjects];
        [self.dayMustFinsishList removeAllObjects];
        [self.dayExtraFinishlist removeAllObjects];
        [self.surFinishTaskList removeAllObjects];
        [self.FabulousFinishlist removeAllObjects];
        [self.surTixianFinishlist removeAllObjects];
        
        //刷新主界面
        for(int j=0;j<3;j++)
        {
            UILabel *countlab = (UILabel*)[self.view viewWithTag:400000+j];
            if(j==0)
            {
                countlab.text = @"0.00";
            }else if (j==1)
            {
                countlab.text = @"0";
            }else if (j==2)
            {
                countlab.text = @"0";
            }
        }
    }
    else{
        [MBProgressHUD show:responseObject[@"message"] icon:nil view:self.view];
    }
    
    [self taskListHttp];    //列表数据
}
#pragma mark 签到详情
- (void)requestHttp
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
                [NSObject saveResponseData:responseObject toPath:url];
        
                //刷新主界面
                [self refreshMainUI:responseObject];
            
            }else if (statu.intValue == 10030)
            {
                //顶置框
                [self setExtraTopView:0 Count_money:0];
                if(token != nil)//设备被挤掉重新登录
                {
                    [userdefaul removeObjectForKey:USER_TOKEN];
                }
            }
            else {
                //顶置框
                [self setExtraTopView:0 Count_money:0];
            }
        }
        
        [self finishtaskHttp];  //完成任务列表
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
    
        id responseObject = [NSObject loadResponseWithPath:url];
        [self refreshMainUI:responseObject];
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"网络连接失败，请检查网络设置~" Controller:self];
    }];
    
}

//获取衣豆
- (void)httpGetData
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr1 = [NSString stringWithFormat:@"%@wallet/myWallet?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL1 = [MyMD5 authkey:urlStr1];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1) {
                
                self.yidouCount = [[NSString stringWithFormat:@"%@",responseObject[@"peas"]] intValue];
                if(self.yidouCount >= 5)
                {
                    [self fabousHttp:NO];
                }else{
                    //衣豆不足提示
                    [self setTaskPopMindView:Task_yiduNoenough_type Value:nil Title:nil Rewardvalue:_reward_value Rewardnum:0];
                }
            } else {
                //衣豆不足提示
                [self setTaskPopMindView:Task_yiduNoenough_type Value:nil Title:nil Rewardvalue:_reward_value Rewardnum:0];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
}

#pragma mark 为好友点赞
- (void)fabousHttp:(BOOL)isfirst
{
    kWeakSelf(self);
    [TaskSignModel fabousHttpSuccess:isfirst :^(id data) {
    
        TaskSignModel *model = data;
        if(model.status == 1)
        {
            if(isfirst)
            {
                [self setTaskPopMindView:Task_jizanFinish_type Value:nil Title:_reward_type Rewardvalue:_reward_value Rewardnum:0];
                self.point_status = 1;
                [self finishtaskHttp];  //完成任务列表
            }else{
                //点赞成功
                [self setTaskPopMindView:Task_jizanSuccess_type Value:nil Title:nil Rewardvalue:_reward_value Rewardnum:0];
            }
        
            [self requestHttp];
        }else if (model.status == 20001)
        {
            
        }
        else{
            
            NavgationbarView *nv = [[NavgationbarView alloc] init];
            [nv showLable:@"点赞失败" Controller:weakself];
        }
    }];

}

#pragma mark 提现额度分享链接
- (void)httpGetTixianShare
{
    NSString *URL= [NSString stringWithFormat:@"%@paperwork/paperwork.json",[NSObject baseURLStr_Upy]];
    NSURL *httpUrl=[NSURL URLWithString:URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpUrl];
    request.timeoutInterval = 10;
    request.HTTPMethod = @"GET";
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            
            NSArray *valueArray = [_task_value componentsSeparatedByString:@","];
            NSString *datastr = @"";
            
            if(valueArray.count)
            {
                sharLink = [NSString stringWithFormat:@"%@",valueArray[0]];
            
                if(sharLink.length>0)
                {
                    NSArray *dataarr = [sharLink componentsSeparatedByString:@"="];
                    if(dataarr.count == 2)
                    {
                        datastr = dataarr[1];
                    }
                }
            }
            if(responseObject[datastr] != nil)
            {
                tixianShare_title = [NSString stringWithFormat:@"%@",responseObject[datastr][@"title"]];
                tixianShare_discription = [NSString stringWithFormat:@"%@",responseObject[datastr][@"text"]];
                tixianShare_pic = [NSString stringWithFormat:@"%@",responseObject[datastr][@"icon"]];
                _shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],tixianShare_pic]]]];
            }
            
            if([sharLink isEqualToString:@"share=spellGroup"])//拼团
            {
                [TaskSignModel IndiaHttpR_code:^(id data) {//获取拼团团号
                    TaskSignModel *model = data;
                    if(model.data != nil && model.status == 1){
                        tixianShare_link = [NSString stringWithFormat:@"%@view/activity/pack.html?realm=%@&r_code=%@",[NSObject baseURLStr_H5],[user objectForKey:USER_ID],model.data];
                    }else{
                        
                        tixianShare_link = [NSString stringWithFormat:@"%@view/activity/pack.html?realm=%@",[NSObject baseURLStr_H5],[user objectForKey:USER_ID]];
                    }
                    [self gotoShare:tixianShare_title Dis:tixianShare_discription Link:tixianShare_link];
                }];
            }else if ([sharLink isEqualToString:@"share=h5money"])//H5赚钱任务
            {
                tixianShare_link = [NSString stringWithFormat:@"%@view/activity/mission.html?realm=%@",[NSObject baseURLStr_H5],[user objectForKey:USER_ID]];
                
                tixianShare_title = [NSString stringWithFormat:@"%@",responseObject[@"wxcx_share_links"][@"title"]];
                tixianShare_pic = [NSString stringWithFormat:@"%@/%@",[NSObject baseURLStr_XCX_Upy],responseObject[@"wxcx_share_links"][@"icon"]];
                _shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[NSObject baseURLStr_XCX_Upy],tixianShare_pic]]]];
                
                [self gotoShare:tixianShare_title Dis:tixianShare_discription Link:tixianShare_link];
            
            }else if ([sharLink isEqualToString:@"share=indiana"])//1分夺宝
            {
                kWeakSelf(self);
                [TaskSignModel IndiaHttpShopcode:nil :^(id data) {
                    TaskSignModel *model = data;
                    if(model.link != nil)
                    {
                        [weakself gotoShare:tixianShare_title Dis:tixianShare_discription Link:model.link];
                    }else{
                        [MBProgressHUD show:model.message icon:nil view:self.view];
                    }
                }];
            }else if([sharLink isEqualToString:@"share=link"]){//随机商品分享
                isTixian_share = YES;
                [self httpGetRandShopWithType:@"分享赢提现额度" Daytag:1 fanxian:NO];
        
            }//随机商品
            else{
                isTixian_share = YES;
                [self httpGetRandShopWithType:@"分享赢提现额度" Daytag:1 fanxian:NO];
            }
        }
    }
}

#pragma mark 分享赢提现额度
- (void)gotoShare:(NSString*)title Dis:(NSString*)discription Link:(NSString*)link
{
    if(title != nil && discription !=nil && link !=nil)
    {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:title forKey:TIXIAN_SHARE_TITLE];
        [user setObject:discription forKey:TIXIAN_SHARE_DISCRIPTION];
        [user setObject:link forKey:QR_LINK];
        
    }else{
        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        [mentionview showLable:@"数据异常" Controller:self];
        return ;
    }
    isTixian_share = YES;
    self.shareType = @"分享赢提现额度";
    [self goshare];
}

#pragma mark 获取随机分享商品
- (void)httpGetRandShopWithType:(NSString *)myType Daytag:(int)daytag fanxian:(BOOL)isfanxian
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *realm = [ud objectForKey:USER_ID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlStr;
    
    NSString *shoptypestr;
    
    NSArray *valuearr = [_task_value componentsSeparatedByString:@","];
    NSString *value;
    if(valuearr.count)
    {
        value = valuearr[0];
    }
    
    if(value.length>0)
    {
        //实惠类商品
       
        urlStr = [NSString stringWithFormat:@"%@shop/shareShop?token=%@&version=%@&realm=%@&getShop=true&hobby=20&%@",[NSObject baseURLStr], token,VERSION, realm ,value];
        shoptypestr = @"正价商品";
        
    }else{
        
        //实惠类商品
        urlStr = [NSString stringWithFormat:@"%@shop/shareShop?token=%@&version=%@&realm=%@&getShop=true&hobby=20",[NSObject baseURLStr], token,VERSION, realm];
        shoptypestr = @"正价商品";
    }
    
    NSString *URL = [MyMD5 authkey:urlStr];
    
    [MBProgressHUD showMessage:@"分享加载中，稍等哟~" afterDeleay:0 WithView:self.view];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (responseObject!=nil) {
            
            MyLog(@"responseObject = %@",responseObject);
            
            if ([responseObject[@"status"] intValue] == 1) {
                
                if(![shoptypestr isEqualToString:@"正价商品"])//0元购商品
                {
                    
                    NSArray * shoparr =responseObject[@"Pshop"][@"shop_list"];
                    
                    if(shoparr.count)
                    {
                        int dex = arc4random() % shoparr.count;
                        
                        NSDictionary *shopdic  = shoparr[dex];
                        
                        NSString *sharepic;
                        NSString *sharelink;
                        NSString *shareprice;
                        
                        if(shopdic !=NULL || shopdic!=nil)
                        {
                            if(shopdic[@"four_pic"])
                            {
                                //获取供应商编号
                                
                                NSMutableString *code ;
                                NSString *supcode  ;
                                
                                if(shopdic[@"shop_code"])
                                {
                                    code = [NSMutableString stringWithString:shopdic[@"shop_code"]];
                                    supcode  = [code substringWithRange:NSMakeRange(1, 3)];
                                }
                                
                                sharepic = [NSString stringWithFormat:@"%@/%@/%@",supcode,code,shopdic[@"four_pic"]];
                                [DataManager sharedManager].key = code;
                            }
                        }
                        
                        if(responseObject[@"link"])
                        {
                            sharelink = [NSString stringWithFormat:@"%@",responseObject[@"link"]];
                            if(isfanxian)
                            {
                                sharelink = [NSString stringWithFormat:@"%@%@",sharelink,@"share=true"];
                            }
                        }
                        
                        if(responseObject[@"price"])
                        {
                            shareprice = responseObject[@"price"];
                        }
                        
                        MyLog(@"sharepic=%@ sharelink=%@ shareprice=%@",sharepic,sharelink,shareprice)
                    [self httpGetShareImageWithPrice:responseObject[@"price"] QRLink:sharelink sharePicUrl:sharepic type:myType];
                    }
                    
                }else{//正价商品
                    
                    NSString *QrLink = responseObject[@"QrLink"];
                    if(isfanxian)
                    {
                        QrLink = [NSString stringWithFormat:@"%@%@",QrLink,@"share=true"];
                    }

                    NSString *prce = [NSString stringWithFormat:@"%.1f", [responseObject[@"shop"][@"shop_se_price"] floatValue]*0.5];
                    NSString *app_shop_group_price = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"wxcx_shop_group_price"]];
                    [DataManager sharedManager].app_value = app_shop_group_price.floatValue;
                    NSNumber *shop_se_price = (NSNumber*)prce;
                    NSString *four_pic = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"four_pic"]];
                    NSString *shop_name = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"shop_name"]];
                    NSString *brand = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"supp_label"]];
                    
                    NSArray *picArr ;
                    if(![four_pic isEqual:[NSNull null]] && ![four_pic isEqualToString:@"null"])
                    {
                        picArr = [four_pic componentsSeparatedByString:@","];
                    }else{
                        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                        [mentionview showLable:@"数据异常" Controller:self];
                        
                        return ;
                    }
                    NSString *pic = [picArr lastObject];
                    NSString *shop_code = responseObject[@"shop"][@"shop_code"];
                    NSString *sup_code  = [shop_code substringWithRange:NSMakeRange(1, 3)];
                    NSString *share_pic = [NSString stringWithFormat:@"%@/%@/%@", sup_code, shop_code, pic];
                    [DataManager sharedManager].key = shop_code;
                    
                    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
                    if(shop_code.length > 10)
                    {
                        [userdefaul setObject:shop_code forKey:SHOP_CODE];
                    }
                    if(QrLink.length > 10)
                    {
                        [userdefaul setObject:QrLink forKey:QR_LINK];
                    }
                    if(![shop_name isEqual:[NSNull null]] && ![shop_name isEqualToString:@"null"] && shop_name != nil)
                    {
                        [userdefaul setObject:shop_name forKey:SHOP_NAME];
                    }
                    if(![brand isEqual:[NSNull null]] && ![brand isEqualToString:@"null"] && brand != nil)
                    {
                        [userdefaul setObject:brand forKey:SHOP_BRAND];
                    }
                    if(shop_se_price > 0)
                    {
                        [userdefaul setObject:shop_se_price forKey:SHOP_PRICE];
                    }
                    if(![app_shop_group_price isEqual:[NSNull null]] && ![app_shop_group_price isEqualToString:@"null"] && app_shop_group_price != nil)
                    {
                        [userdefaul setObject:app_shop_group_price forKey:@"app_shop_group_price"];
                    }
                    [TypeShareModel getTypeCodeWithShop_code:shop_code success:^(TypeShareModel *data) {
                        
                        if(data.status == 1 && data.type2 != nil)
                        {
                            [userdefaul setObject:[NSString stringWithFormat:@"%@",data.type2] forKey:SHOP_TYPE2];
                            self.shareType = nil;
                            [self httpGetShareImageWithPrice:shop_se_price QRLink:QrLink sharePicUrl:share_pic type:myType];
                        }
                        
                    }];
                }
                
            }else{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                [MBProgressHUD show:@"数据异常，请稍后" icon:nil view:self.view];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

#pragma mark 分享搭配购
- (void)httpCollocationShopWithType:(NSString *)myType Daytag:(int)daytag
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *realm = [userdefaul objectForKey:USER_ID];
    
    NSString *url=[NSString stringWithFormat:@"%@collocationShop/getLink?version=%@&realm=%@",[NSObject baseURLStr],VERSION,realm];
    
    NSString *URL=[MyMD5 authkey:url];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            MyLog(@"responseObject = %@   %@", responseObject,responseObject[@"message"]);
            NSString *statue = responseObject[@"status"];
            
            if(statue.intValue == 1)
            {
                //获取搭配商品编号
                if (responseObject!=nil) {
                    NSString *statu=responseObject[@"status"];
                    NSString *message=responseObject[@"message"];
                    
                    if(statu.intValue==1)//请求成功
                    {
                        
                        if(responseObject[@"code"] !=nil)
                        {
                            NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
                            NSString *qlink = [NSString stringWithFormat:@"%@",responseObject[@"link"]];
                            
                            NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
                            [userdefaul setObject:qlink forKey:QR_LINK];
                            
                            [self CollocationshopRequest:code WithQrlink:qlink WithType:myType];
                        }
                    }else{
                        
                        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                        [mentionview showLable:message Controller:self];
                        
                    }
                }
            }
            
            
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

#pragma mark 详情
- (void)CollocationshopRequest:(NSString*)collocationCode WithQrlink:(NSString*)qlink WithType:(NSString*)type
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url=[NSString stringWithFormat:@"%@/collocationShop/queryUnLogin?version=%@&code=%@",[NSObject baseURLStr],VERSION,collocationCode];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"分享加载中，稍等哟~" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                
                if(responseObject[@"shop"] !=nil)
                {
                    NSString* collocation_name = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"collocation_name"]];
                    NSString* collocation_pic = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"collocation_pic"]];
                    
                    _shopData = responseObject[@"shop"][@"collocation_shop"];
                    
                    if(_shopData.count == 0)
                    {
                        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                        [mentionview showLable:@"数据获取异常" Controller:self];
                        
                        return ;
                    }
                    if(_isWeixin_share == YES)//如果是微信
                    {

                        //配置分享平台信息
                        AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                        [app shardk];
                        
                        UIImage *shopimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],collocation_pic]]]];
                        if(shopimage == nil)
                        {
                            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                            [mentionview showLable:@"数据获取异常" Controller:self];
                            
                            return ;
                        }
                        
                        int shareCount = [[[NSUserDefaults standardUserDefaults] objectForKey:ShareCount] intValue];
                        self.taskValue = shareCount %2==0?1:2;
                        
                        if(isWeixinFriend)//分享链接
                        {
                            NSDictionary *dic = _shopData[0];
                            NSString *shopcode = [NSString stringWithFormat:@"%@",dic[@"shop_code"]];
                            CGFloat price = [dic[@"shop_se_price"] floatValue];
                            
                            NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
                            [userdefaul setObject:[NSString stringWithFormat:@"%.2f",price] forKey:SHOP_PRICE];
                            
                            [TypeShareModel getTypeCodeWithShop_code:shopcode success:^(TypeShareModel *data) {
                                if(data.status == 1 && data.type2 != nil)
                                {
                                    SqliteManager *manager = [SqliteManager sharedManager];
                                    TypeTagItem *item = [manager getSuppLabelItemForId:data.supp_label_id];
                                    if(item != nil)
                                    {
                                        NSString *brand = item.class_name;
                                        if(brand.length)
                                        {
                                            [userdefaul setObject:[NSString stringWithFormat:@"%@",brand] forKey:SHOP_BRAND];
                                        }
                                    }
                                    
                                    [userdefaul setObject:[NSString stringWithFormat:@"%@",data.type2] forKey:SHOP_TYPE2];
                                }else{
                                    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                                    [mentionview showLable:@"数据获取异常" Controller:self];
                                    
                                    return ;
                                }
                            }];
                            _shareImage = shopimage;
                            self.shareImageStr = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],collocation_pic];
                            self.shareType = nil;
                        }else{
                            //直接创建二维码图像
                            UIImage *qrpicimage = [QRCodeGenerator qrImageForString:qlink imageSize:165];
                            
                            NSData *data = UIImagePNGRepresentation(qrpicimage);
                            NSString *st = [NSString stringWithFormat:@"%@/Documents/abc.png", NSHomeDirectory()];
                            
                            [data writeToFile:st atomically:YES];
                            
                            UIImage *shopImage = [YFDPImageView dpImageWidthImage:shopimage datas:_shopData];
                            ProduceImage *pi = [[ProduceImage alloc] init];
                            UIImage *newimg = [pi getImage:shopImage withQRCodeImage:qrpicimage withText:@"Collocationdetail" withPrice:nil WithTitle:collocation_name];
                            MyLog(@"newimg = %@",newimg);

                            _shareImage = newimg;
                            self.shareImageStr = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],collocation_pic];
                        }
                        
                        if(_shareImage)
                        {
                            isTixian_share = NO;
                        
                            [self goshare];
                        }

                    }else{
                        
                        [self shareRandShopWithPrice:nil QRLink:qlink sharePicUrl:collocation_pic type:type];
                    }
                }
            }
            else{
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];
    
}

#pragma mark 签到网络请求
- (void)SignHttp:(NSString*)myType
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    
    NSString *url;
    
    NSString *index_id = _index_id;
    NSString *day = self.day;
    
    url=[NSString stringWithFormat:@"%@signIn2_0/signIning?token=%@&version=%@&index_id=%@&day=%@",[NSObject baseURLStr],token,VERSION,index_id,day];
    
    if([myType isEqualToString:DAILY_TASK_DOUBLE])//余额翻倍时获取时间
    {
        url=[NSString stringWithFormat:@"%@signIn2_0/signIning?token=%@&version=%@&index_id=%@&day=%@&retime=true&share=true",[NSObject baseURLStr],token,VERSION,index_id,day];
    }
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        //        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *messsage=responseObject[@"message"];
            _changeTable = responseObject[@"changeTable"];
            
            if(statu.intValue==1)
            {
                if(myType !=nil)
                {
                    //刷新数据
                    [self creatData];
                    
                    //删除加购物车记数统计 分享次数
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    
                    [user removeObjectForKey:TASK_SHARE_SHOPCOUNT];
                    
                    [Signmanager SignManarer].addShopCart = 0;
                    [Signmanager SignManarer].shareShopCart = 0;
                    
                    if(!_SharePopview)
                    {
                        if([myType isEqualToString:DAILY_TASK_DOUBLE])
                        {
                            if([responseObject[@"t_time"] doubleValue] >0)
                            {
                                //保存余额翻倍时间
                                [userdefaul setObject:responseObject[@"s_time"] forKey:DOUBLE_S_TIME];
                                [DataManager sharedManager].isOligible = YES;
                                [DataManager sharedManager].isOpen = NO;
                                [DataManager sharedManager].endDate = ((NSNumber *)responseObject[@"t_time"]).longLongValue;
                                
                                [self setTaskPopMindView:Task_double_type Value:nil Title:nil Rewardvalue:_reward_value Rewardnum:(int)_rewardNumber];
                            }
                            
                        }else if ([myType isEqualToString:DAILY_JIFEN_GOLD])
                        {
                            [GoldCouponModel getGoldCoupons:@"twofoldnessGold" success:^(id data) {
                                GoldCouponModel *goldmodel = data;
                                GoldModel *model= goldmodel.twofoldnessGold;
                                if(goldmodel.status == 1){
                                    
                                    if(model.end_date !=0)
                                    {
                                        [GoldCouponsManager goldcpManager].gold_end_date = model.end_date;
                                        [GoldCouponsManager goldcpManager].gold_id = model.gid;
                                        [GoldCouponsManager goldcpManager].gold_is_open = YES;
                                    }else{
                                        [GoldCouponsManager goldcpManager].gold_is_open = NO;
                                    }
                                    
                                    UIImageView *imageview = (UIImageView*)[self.view viewWithTag:500001];
                                    imageview.image = [UIImage imageNamed:@"newtask_jingbi"];
                                    [imageview shakeStatus:YES];
                                    
                                    [self setTaskPopMindView:Task_goldcupons_type Value:nil Title:nil Rewardvalue:_reward_value Rewardnum:(int)_rewardNumber];
                                }
                                else{
                                    [GoldCouponsManager goldcpManager].gold_is_open = NO;
                                }
                                
                            }];
                            
                        }else if ([myType isEqualToString:DAILY_YOUHUI_GOLDCOUPONS])
                        {
                            [GoldCouponModel getGoldCoupons:@"CpGold" success:^(id data) {
                                GoldCouponModel *goldmodel = data;
                                GoldcpModel *model = goldmodel.CpGold;
                                if(goldmodel.status == 1){
                                    
                                    if(model.end_date !=0)
                                    {
                                        [GoldCouponsManager goldcpManager].is_open = YES ;
                                        [GoldCouponsManager goldcpManager].goldcp_end_date = model.end_date;
                                        [GoldCouponsManager goldcpManager].c_last_time = model.c_last_time;
                                        [GoldCouponsManager goldcpManager].c_price = model.c_price;
                                        [GoldCouponsManager goldcpManager].is_use = model.is_use;
                                        [GoldCouponsManager goldcpManager].c_id = model.c_id;
                                    }else{
                                        [GoldCouponsManager goldcpManager].is_open = NO;
                                    }
                                    
                                    UIImageView *imageview = (UIImageView*)[self.view viewWithTag:500002];
                                    imageview.image = [UIImage imageNamed:@"newtask_jingquan"];
                                    [imageview shakeStatus:YES];
                                    
                                    [self setTaskPopMindView:Task_goldticket_type Value:nil Title:nil Rewardvalue:_reward_value Rewardnum:(int)_rewardNumber];
                                }
                                else{
                                    [GoldCouponsManager goldcpManager].is_open = NO;
                                }
                                
                            }];
                        
                        }else{
                            [self setTaskPopMindView:Task_shreSucess_type Value:nil Title:nil Rewardvalue:_reward_value Rewardnum:(int)_rewardNumber];
                        }
                    }
                }
                
            }
            else{
                
                NavgationbarView *alertview=[[NavgationbarView alloc] init];
                [alertview showLable:messsage Controller:self];
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [MBProgressHUD hideHUDForView:self.view];
        
    }];
    
    
}

#pragma mark 判断用户是否绑定过手机
- (void)httpFindPhone:(TaskModel*)model Success:(void(^)())success
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@user/queryPhone?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                if ([responseObject[@"bool"] boolValue]== YES) { // 绑定过手机
                    
                    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
                    NSString *unionid = [userdefaul objectForKey:UNION_ID];
                    
                    if(unionid == nil)
                    {
                        [self shareSdkWithAutohorWithTypeGetOpenID:model dictionary:nil Success:^{
                            if(success)
                            {
                                success();
                            }
                        }];
                        
                    }else{
                        if(success)
                        {
                            success();
                        }
                    }
                    
                } else { //没有绑定过手机
                    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"为了您的账户安全，请先绑定手机" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"确认", nil];
                    [alter show];
                    
                    return ;
                    
                }
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
}

#pragma mark 获取夺宝的参与号码
- (void)getincode:(NSInteger)type //1夺宝 2拼团夺宝
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *pay_type = [userdefaul objectForKey:PAY_TYPE];
    NSString *order_code = [userdefaul objectForKey:PAY_ORDERCODE];
    NSString *pay_num = [userdefaul objectForKey:PAY_NUM];
    
    NSString *url;
    if (pay_num.intValue>=2) {
        url=[NSString stringWithFormat:@"%@treasures/getPayCodeList?version=%@&token=%@&g_code=%@&pay_type=%@",[NSObject baseURLStr_Pay],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],order_code,pay_type];
    }else
        url=[NSString stringWithFormat:@"%@treasures/getPayCode?version=%@&token=%@&order_code=%@&pay_type=%@",[NSObject baseURLStr_Pay],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],order_code,pay_type];
    
    NSString *URL=[MyMD5 authkey:url];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            MyLog(@"responseObject = %@   %@", responseObject,responseObject[@"message"]);
            NSString *statue = responseObject[@"status"];
            
            if(statue.intValue == 1)
            {
                //参与号码
                NSString* in_code = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
                NSMutableString *newcodes = [NSMutableString string];
                if(in_code.length)
                {
                    NSArray *codes = [in_code componentsSeparatedByString:@","];
                    for(int i=0;i<(codes.count<2?codes.count:2);i++){
                        [newcodes appendString:codes[i]];
                        [newcodes appendString:@","];
                    }
                }
                
                if(type == 1)
                {
                    [self setTaskPopMindView:Task_duobao_type Value:nil Title:newcodes Rewardvalue:_reward_value Rewardnum:(int)_rewardNumber];
                }else if (type == 2)
                {
                    [self setTaskPopMindView:Task_duobao_kaijiang Value:nil Title:newcodes Rewardvalue:_reward_value Rewardnum:(int)_rewardNumber];
                }
            }
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark 获取是否是A类用户
- (void)getGradeSuccess:(void (^)())success {
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@wallet/getGrade?version=%@&token=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]];
    
    NSString *URL=[MyMD5 authkey:url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            NSString *statue = responseObject[@"status"];
            if(statue.intValue == 1)
            {
                if([responseObject[@"grade"] intValue]==1)
                {
                    if (success) {
                        success();
                    }
                }else{
//                    [self finishOrderPopview];
                }
            }else{
//                [self finishOrderPopview];
            }
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)shareSdkWithAutohorWithTypeGetOpenID:(TaskModel*)model dictionary:(NSDictionary *)dic Success:(void(^)())success{
    
    //判断设备是否安装微信
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]){
        
    }else{
        
        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        [mentionview showLable:@"亲,安装微信授权后才能做任务" Controller:self];
        return;
    }

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate shardk];
    
    // 取消授权
    [ShareSDK cancelAuthWithType:ShareTypeWeixiFav];
    
    // 开始授权
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
    [app setIsAllowWebAuthorize:YES];
    
    [ShareSDK getUserInfoWithType:ShareTypeWeixiFav
                      authOptions:authOptions
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               
                               if (result)
                               {
                            
                                   NSDictionary *uniondic = (NSDictionary *)[userInfo sourceData];
                                   
                                   if(uniondic[@"unionid"] !=nil)
                                   {
                                       NSString *unionid = [NSString stringWithFormat:@"%@",uniondic[@"unionid"]];
                                       NSString *wx_openid = [userInfo uid];
                                       [self saveunionid:unionid Openid:wx_openid Model:model Success:^{
                                           if(success)
                                           {
                                               success();
                                           }
                                       }];
                                   }
                                   
                               }else{
                                   [MBProgressHUD show:@"赚钱小任务必须微信授权后才可以做" icon:nil view:self.view];
                               }
                               
                           }];
    
}

#pragma mark 修改用户信息 将微信授权unionid传给后台
-(void)saveunionid:(NSString*)unionid Openid:(NSString*)wx_openid Model:(TaskModel*)model Success:(void(^)())success
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@user/update_userinfo?version=%@&token=%@&unionid=%@&wx_openid=%@",[NSObject baseURLStr],VERSION,token,unionid,wx_openid];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                MyLog(@"上传成功");
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setObject:unionid forKey:UNION_ID];
                
                if(success)
                {
                    success();
                }
                
                [MBProgressHUD show:@"授权成功" icon:nil view:self.view];
            }
            else{
                [MBProgressHUD show:responseObject[@"message"] icon:nil view:self.view];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //网络连接失败");
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"保存失败,请重试!" Controller:self];
        [[Animation shareAnimation] stopAnimationAt:self.view];
    }];
    
}
#pragma mark 拼团夺宝是否参团
- (void)guideIndianaHttp
{
    //拼团夺宝新用户从H5引导过来自动跳转到相应的拼团详情页
    kWeakSelf(self);
    [GuideIndianaModel guideIndianaDataSuccess:^(id data) {
        GuideIndianaModel *model = data;
        if(model.status == 1 && model.shareData != nil)
        {
            NSString *statues = [NSString stringWithFormat:@"%@",model.shareData[@"status"]];
            if(statues.intValue == 0)//0默认未参团，1已参团
            {
                [weakself checkPhoneAndUniond:model.shareData];
            }
        }
    }];
}
- (void)checkPhoneAndUniond:(NSDictionary*)shareData
{
    //先检测是否绑定手机
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if([user objectForKey:USER_PHONE] !=nil && [user objectForKey:UNION_ID] != nil)
    {
        [self gotoFightIndiana:shareData];
    }
}
- (void)gotoFightIndiana:(NSDictionary*)shareData
{
    FightIndianaDetailViewController *india = [[FightIndianaDetailViewController alloc]init];
    india.shop_code = [NSString stringWithFormat:@"%@",shareData[@"shop_code"]];
    india.tuserId = [NSString stringWithFormat:@"%@",shareData[@"sup_user_id"]];
    india.indiaType = YES;
    india.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:india animated:YES];
}

- (NSString*)taskrawardHttp:(NSString*)strtype
{
    NSString *textstr = @"";
    
    NSString *URL= [NSString stringWithFormat:@"%@paperwork/paperwork.json",[NSObject baseURLStr_Upy]];
    NSURL *httpUrl=[NSURL URLWithString:URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpUrl];
    request.timeoutInterval = 3;
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
           if (responseObject[@"myjlfbrwjlwa"] != nil && [strtype isEqualToString:@"奖励翻倍"]){
                if(responseObject[@"myjlfbrwjlwa"][@"text"] != nil)
                {
                    NSString *str0 = responseObject[@"myjlfbrwjlwa"][@"text"];
                    textstr = str0;
                }
           }else if (responseObject[@"fxqd"] != nil && [strtype isEqualToString:@"集赞"])
           {
               NSString *str0 = responseObject[@"fxqd"][@"text"];
               textstr = str0;
           }

        }
    }
    
    return textstr;
}

//开团数据
- (void)fightGrouphttpData:(void(^)(NSString *n_status))n_statusBlock
{
    NSString *urlStr1 = [NSString stringWithFormat:@"%@order/queryByRoll?version=%@&token=%@&type=%zd",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],[DataManager sharedManager].opengroup];
    NSString *URL1 = [MyMD5 authkey:urlStr1];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1)
            {
                NSArray *data = responseObject[@"data"];
                
                if (data.count) {
                    for (NSDictionary *dic in data)
                    {
                        NSString *n_status = dic[@"n_status"];
                        
                        if(n_statusBlock)
                        {
                            n_statusBlock(n_status);
                        }
                        
                        break;
                    }
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

#pragma mark *************************分享部分**********************
- (void)beginshareStatue
{
    NSString *todaystatue = _reward_type;
    if([todaystatue isEqualToString:DAILY_TASK_DOUBLE])
    {
        [self beginShareTitlePopView];
    }else{
        [self creatExtrabonusView];
    }
}
#pragma mark 奖励弹框
- (void)creatExtrabonusView
{
//    TixianSharePopview * tixianPopview = [[TixianSharePopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    __weak TixianSharePopview *view = tixianPopview;
//    view.tapHideMindBlock = ^{
//        [view remindViewHiden];
//    };
//    kWeakSelf(self);
//    view.weixinBlock = ^{
//        MyLog(@"微信分享");
//        _isWeixin_share = YES;
//        isWeixinFriend = YES;
//
//        if([weakself.tasktype isEqualToString:@"搭配购"])
//        {
//            weakself.shareType = @"搭配购";
//            [weakself httpCollocationShopWithType:nil Daytag:1];
//        }else{
//            [weakself xjiangShare];
//        }
//    };
//
//    view.friendBlock = ^{
//        MyLog(@"朋友圈分享");
//        _isWeixin_share = YES;
//        isWeixinFriend = NO;
//        if([weakself.tasktype isEqualToString:@"搭配购"])
//        {
//            weakself.shareType = @"搭配购";
//            [weakself httpCollocationShopWithType:nil Daytag:1];
//        }else{
//            [weakself xjiangShare];
//        }
//    };
//
//    [self.view addSubview:tixianPopview];
    
    MyLog(@"微信分享");
    _isWeixin_share = YES;
    isWeixinFriend = YES;
    
    if([self.tasktype isEqualToString:@"搭配购"])
    {
        self.shareType = @"搭配购";
        [self httpCollocationShopWithType:nil Daytag:1];
    }else{
        [self xjiangShare];
    }
}

- (void)xjiangShare
{
    NSArray *valueArray = [_task_value componentsSeparatedByString:@","];
    if(valueArray.count)
    {
        sharLink = [NSString stringWithFormat:@"%@",valueArray[0]];
    }
    //9块9拼团 赚钱任务页 1分抽奖
    isxjiang_share = YES;
    if([sharLink hasPrefix:@"share=spellGroup"] || [sharLink hasPrefix:@"share=h5money"] || [sharLink hasPrefix:@"share=indiana"])
    {
        [self httpGetTixianShare];
    }else{
        [self httpGetRandShopWithType:nil Daytag:1 fanxian:NO];
    }

}

#pragma mark 新分享赢提现
- (void)creatTixianPopview
{
    TixianSharePopview * tixianPopview = [[TixianSharePopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    __weak TixianSharePopview *view = tixianPopview;
    view.tapHideMindBlock = ^{
        [view remindViewHiden];
    };
    
    kWeakSelf(self);
    view.weixinBlock = ^{
        MyLog(@"微信分享");
        _isWeixin_share = YES;
        isWeixinFriend = YES;
        newShareTixian = YES;
        
        if([weakself.tasktype isEqualToString:@"搭配购"])
        {
            [weakself httpCollocationShopWithType:@"分享随机商品" Daytag:1];
        }else{

            [weakself xjiangShare];
        }
    };
    
    view.friendBlock = ^{
        MyLog(@"朋友圈分享");
        _isWeixin_share = YES;
        isWeixinFriend = NO;
        newShareTixian = YES;
        
        if([weakself.tasktype isEqualToString:@"搭配购"])
        {
            [weakself httpCollocationShopWithType:@"分享随机商品" Daytag:1];
        }else{

            [weakself xjiangShare];
        }
    };
    
    [self.view addSubview:tixianPopview];
}
#pragma mark 分享前文字提示弹框
- (void)beginShareTitlePopView
{
    NSString *todaystatue = _reward_type;

    _SharePopview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    
    _SharePopview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _SharePopview.userInteractionEnabled = YES;
    
    CGFloat invitcodeYY = (kScreenHeight - ZOOM6(680))/2;
    
    //弹框内容
    _ShareInvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(120), invitcodeYY, kScreenWidth-ZOOM(120)*2, ZOOM6(680))];
    [_SharePopview addSubview:_ShareInvitationCodeView];
    
    CGFloat imgHeigh = IMGSIZEH(@"-congratulation");
    
    _SharebackView = [[UIView alloc]initWithFrame:CGRectMake(0,imgHeigh/2, kScreenWidth-ZOOM(120)*2, CGRectGetHeight(_ShareInvitationCodeView.frame)-imgHeigh/2)];
    _SharebackView.backgroundColor=[UIColor whiteColor];
    _SharebackView.layer.cornerRadius=5;
    _SharebackView.clipsToBounds = YES;
    [_ShareInvitationCodeView addSubview:_SharebackView];
    
    //title
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_SharebackView.frame), ZOOM6(80))];
    titlelabel.text = @"分享时尚赢现金";
    
    if([todaystatue isEqualToString:DAILY_TASK_DOUBLE])
    {
        titlelabel.text = @"余额翻倍特权说明";
    }
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.backgroundColor = tarbarrossred;
    titlelabel.font = [UIFont systemFontOfSize:ZOOM6(40)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    [_SharebackView addSubview:titlelabel];
    
    
    //关闭按钮
    CGFloat btnwidth = IMGSIZEW(@"qiandao_icon_close");
    
    _Sharecanclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _Sharecanclebtn.frame=CGRectMake(CGRectGetWidth(_SharebackView.frame)-btnwidth-ZOOM6(20), ZOOM6(20), btnwidth, btnwidth);
    [_Sharecanclebtn setImage:[UIImage imageNamed:@"qiandao_icon_close"] forState:UIControlStateNormal];
    _Sharecanclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    _Sharecanclebtn.layer.cornerRadius=btnwidth/2;
    [_Sharecanclebtn addTarget:self action:@selector(SharetapClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_SharebackView addSubview:_Sharecanclebtn];
    
    
    int count =2;
    CGFloat discriptionlabelHeigh = ZOOM6(100);
    if([todaystatue isEqualToString:DAILY_TASK_DOUBLE])
    {
        count = 1;
        discriptionlabelHeigh = ZOOM6(200);
    }
    for(int i =0;i<count;i++)
    {
        UILabel *discriptionlabel = [[UILabel alloc]init];
        discriptionlabel.frame = CGRectMake(ZOOM6(30), CGRectGetMaxY(titlelabel.frame)+ZOOM6(60)+discriptionlabelHeigh*i, CGRectGetWidth(_SharebackView.frame)-2*ZOOM6(30), discriptionlabelHeigh);
        discriptionlabel.numberOfLines = 0;
        discriptionlabel.textColor = RGBCOLOR_I(125, 125, 125);
        discriptionlabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
        if(i==0)
        {
            discriptionlabel.text = @"1.分享后成功注册的小伙伴将会成功你的粉丝.";
            if([todaystatue isEqualToString:DAILY_TASK_DOUBLE])
            {
                discriptionlabel.text = @"分享成功后,您可以获得开启余额翻倍特权,余额在24小时内变成原来的2倍,可直接用于购物,24小时后余额变为原来的金额.";
            }
        }else{
            discriptionlabel.text = @"2.粉丝每次从app下单,你将可以从衣蝠得到商品价格10%的现金奖励.";
        }
        
        [_SharebackView addSubview:discriptionlabel];
    }
    
    
    [_ShareInvitationCodeView addSubview:[self creatShareView:_SharebackView]];
    
    [self.view addSubview:_SharePopview];
    
    _ShareInvitationCodeView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _ShareInvitationCodeView.alpha = 0.5;
    
    _SharePopview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _SharePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        _ShareInvitationCodeView.transform = CGAffineTransformMakeScale(1, 1);
        _ShareInvitationCodeView.alpha = 1;
        
    } completion:^(BOOL finish) {
        
    }];
    
}

#pragma mark 赚钱小秘密
- (void)gosecret:(UITapGestureRecognizer*)tap
{
    [self gosecret];
}

- (void)gosecret
{
    TFMakeMoneySecretViewController *mmVC = [[TFMakeMoneySecretViewController alloc] init];
    mmVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mmVC animated:YES];
}


-(void)SharetapClick
{
    [_Sharecanclebtn removeFromSuperview];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _SharePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        _ShareInvitationCodeView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        _ShareInvitationCodeView.alpha = 0;
        
    } completion:^(BOOL finish) {
        
        [_SharePopview removeFromSuperview];
        _SharePopview = nil;
    }];
    
}

#pragma mark 分享平台
- (UIView*)creatShareView:(UIView*)view
{
    CGFloat with = CGRectGetWidth(view.frame);
    
    UIView *shareview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame)-ZOOM6(200), with, ZOOM6(200))];
    
//    CGFloat titleYY =0;
    //分享平台
    for (int i=0; i<2; i++) {
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        shareBtn.frame = CGRectMake(ZOOM6(200)*i+(with-ZOOM6(300))/2,ZOOM6(20), ZOOM6(100), ZOOM6(100));
        shareBtn.tag = 9000+i;
        shareBtn.tintColor = [UIColor clearColor];
    
        [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        
//        titleYY = CGRectGetMaxY(shareBtn.frame);
        if (i==0) {
            
            //判断设备是否安装微信
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                
                //判断是否有微信
                
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"朋友圈-1"] forState:UIControlStateNormal];
                
            }else {
                
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                
            }
            
        }else if (i==1){
            
            //判断设备是否安装QQ
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
            {
                //判断是否有qq
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
            }else{
                
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
            }
            
        }
        
        [shareview addSubview:shareBtn];
        
    }
    
    UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(0, ZOOM6(120), with, ZOOM6(60))];
    titlelab.font = [UIFont systemFontOfSize:ZOOM6(30)];
    titlelab.textColor = RGBCOLOR_I(168, 168, 168);
    titlelab.textAlignment = NSTextAlignmentCenter;
    titlelab.text = @"分享完成赚钱任务";
    [shareview addSubview:titlelab];
    
    return shareview;
    
}

#pragma mark 选择分享的平台
-(void)shareClick:(UIButton*)sender
{
    [MobClick event:QIANDAO_SHARE];
    
    if(sender.tag == 9000)
    {
        _isWeixin_share = YES;
    }else{
        _isWeixin_share = NO;
    }
    
    [self SharetapClick];
    
    [UIView animateWithDuration:0.6 animations:^{
        
    } completion:^(BOOL finished) {
        
        NSString *type = sender.titleLabel.text;
        
        if([self.tasktype isEqualToString:@"搭配购"])
        {
            [self httpCollocationShopWithType:type Daytag:1];
        }else{
            [self httpGetRandShopWithType:type Daytag:1 fanxian:NO];
        }
        
    }];
    
    
}

#pragma mark &&&&&&&&&&&&&&&&&&&&&&&&&&小程序分享
- (void)miniSharewithTypeisShop:(BOOL)isshop Tixian:(BOOL)istixian Sharelink:(NSString*)link
{
    MiniShareManager *minishare = [MiniShareManager share];
    minishare.delegate = self;
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *realm = [user objectForKey:USER_ID];
    NSString *image = @""; NSString *title = @"";
    NSString *path  = [NSString stringWithFormat:@"/pages/shouye/redHongBao?shouYePage=ThreePage&isShareFlag=true&user_id=%@",realm];
    if(isshop)//随机商品
    {
        NSString *shopprice =[user objectForKey:SHOP_PRICE];
        NSString *shop_brand = [user objectForKey:SHOP_BRAND];
        NSString *shop_code = [user objectForKey:SHOP_CODE];
        NSString *shop_name = [user objectForKey:SHOP_NAME];
        NSString *app_shop_group_price = [user objectForKey:@"app_shop_group_price"];
        if(shop_brand == nil || [shop_brand isEqualToString:@"(null)"] || [shop_brand isEqual:[NSNull null]])
        {
            shop_brand = @"衣蝠";
        }
        NSString *type2 = [user objectForKey:SHOP_TYPE2];
        
        image = [NSString stringWithFormat:@"%@!450",self.shareImageStr];
        title = [minishare newtaskrawardHttp:type2 Price:shopprice Brand:shop_brand];
        path = [NSString stringWithFormat:@"/pages/shouye/detail/detail?shop_code=%@&user_id=%@",shop_code,realm];
        
        //合成图片
        ProduceImage *pi = [[ProduceImage alloc] init];
        UIImage *baseImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image]]];
        UIImage *zhezhaoImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/heboImg/shareCanvas_price.png"]]]];
        UIImage *afterImage = [pi getShareImage:zhezhaoImg WithBaseImg:baseImg WithPrice:app_shop_group_price];
        NSData *imageData = UIImageJPEGRepresentation(afterImage,0.8f);
        
        title= [NSString stringWithFormat:@"点击购买👆【%@】今日特价%.1f元！",shop_name,[app_shop_group_price floatValue]];
        [minishare shareAppImageWithType:MINIShareTypeWeixiSession Image:imageData Title:title Discription:nil WithSharePath:path];
    }else{//夺宝 任务页
        title = tixianShare_title;
        image = [NSString stringWithFormat:@"%@!450",tixianShare_pic];
        
        if([sharLink isEqualToString:@"share=h5money"])//H5赚钱任务
        {
            NSString *user_id = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
            path  = [NSString stringWithFormat:@"/pages/shouye/redHongBao?shouYePage=ThreePage&isShareFlag=true&user_id=%@",user_id];
            
        }else if ([sharLink isEqualToString:@"share=indiana"])//1分夺宝
        {
            NSString *qrlink = [user objectForKey:QR_LINK];
            NSString *shopcode = @"";
            if(qrlink.length >10)
            {
                NSArray *arr = [qrlink componentsSeparatedByString:@"shop_code="];
                if(arr.count >= 2)
                {
                    shopcode = arr[1];
                }
            }
            path = [NSString stringWithFormat:@"/pages/shouye/detail/centsIndianaDetail/centsDetail?shop_code=%@&user_id=%@",shopcode,realm];
        }else{//搭配购
            
            NSString *shopprice =[user objectForKey:SHOP_PRICE];
            NSString *shop_brand = [user objectForKey:SHOP_BRAND];
            if(shop_brand == nil || [shop_brand isEqualToString:@"(null)"] || [shop_brand isEqual:[NSNull null]])
            {
                shop_brand = @"衣蝠";
            }
            NSString *type2 = [user objectForKey:SHOP_TYPE2];
            
            //搭配编号
            NSString *qrlink = [user objectForKey:QR_LINK];
            NSString *code = @"";
            if(qrlink.length >10)
            {
                NSArray *arr = [qrlink componentsSeparatedByString:@"code="];
                if(arr.count >= 2)
                {
                    code = arr[1];
                }
            }
            
            image = [NSString stringWithFormat:@"%@!280",self.shareImageStr];
            title = [minishare newtaskrawardHttp:type2 Price:shopprice Brand:shop_brand];
            path = [NSString stringWithFormat:@"/pages/shouye/detail/collocationDetail/collocationDetail?code=%@&user_id=%@",code,realm];
        }
        [minishare shareAppWithType:MINIShareTypeWeixiSession Image:image Title:title Discription:nil WithSharePath:path];
    }
}
//小程序分享回调
- (void)MinihareManagerStatus:(MINISHARESTATE)shareStatus withType:(NSString *)type
{
    NSString *sstt = @"";
    switch (shareStatus) {
        case MINISTATE_SUCCESS:
            [self shareStatus:STATE_SUCCESS withType:@"任务分享"];
            break;
        case MINISTATE_FAILED:
            sstt = @"分享失败";
            break;
        case MINISTATE_CANCEL:
            sstt = @"分享取消";
            break;
        default:
            break;
    }
    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
    [mentionview showLable:sstt Controller:self];
}

#pragma mark 配置分享平台信息
- (void)goshare
{
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app shardk];
    
    DShareManager *ds = [DShareManager share];
    ds.delegate = self;
    ds.taskValue = self.taskValue;
    
    NSString *shareType = self.shareType;
    if(_isWeixin_share == YES)//微信分享
    {
        shareType = shareType!=nil?shareType:@"任务分享";
        if(isTixian_share || isWeixinFriend)
        {
            if(sharLink != nil)
            {
                if([sharLink isEqualToString:@"share=spellGroup"])//拼团
                {
                    [ds shareAppWithType:ShareTypeWeixiSession withImageShareType:shareType withImage:_shareImage];
                }else if([sharLink isEqualToString:@"share=h5money"]){//任务页
                    [self miniSharewithTypeisShop:NO Tixian:NO Sharelink:nil];
                }else if ([sharLink isEqualToString:@"share=indiana"])//夺宝
                {
                    [self miniSharewithTypeisShop:NO Tixian:NO Sharelink:nil];
                }else if ([sharLink isEqualToString:@"share=link"]){//随机商品
                    [self miniSharewithTypeisShop:YES Tixian:YES Sharelink:nil];
                }else{
                    [self miniSharewithTypeisShop:YES Tixian:YES Sharelink:nil];
                }
            }else{//搭配购
                [self miniSharewithTypeisShop:NO Tixian:NO Sharelink:nil];
            }
            
        }else{
            
            [ds shareAppWithType:ShareTypeWeixiTimeline withImageShareType:shareType withImage:_shareImage];
        }
        
    }else{//QQ分享
        [ds shareAppWithType:ShareTypeQQSpace withImageShareType:shareType withImage:_shareImage];
    }
}

- (void)httpGetShareImageWithPrice:(NSNumber *)shop_price QRLink:(NSString *)qrLink sharePicUrl:(NSString *)picUrl type:(NSString *)myType
{

    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], picUrl];
    
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSData *imgData = UIImagePNGRepresentation(responseObject);
            self.shareRandShopImage = [UIImage imageWithData:imgData];
            
            [self shareRandShopWithPrice:shop_price QRLink:qrLink sharePicUrl:picUrl type:myType];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

- (void)shareRandShopWithPrice:(NSNumber *)shop_price QRLink:(NSString *)qrLink sharePicUrl:(NSString *)picUrl type:(NSString *)myType
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]])
    {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate shardk];

        UIImage *newimg ;
        if(_isWeixin_share == YES)
        {
            if(isTixian_share || isWeixinFriend)
            {
                newimg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],picUrl]]]];
                self.shareImageStr = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],picUrl];
            }else{
            
                int shareCount = [[[NSUserDefaults standardUserDefaults] objectForKey:ShareCount] intValue];
                self.taskValue = shareCount %2==0?1:2;

//                self.taskValue = arc4random()%2+1;
                if(self.taskValue == 1 && !isWeixinFriend)//分享图片
                {
                    UIImage *QRImage = [QRCodeGenerator qrImageForString:qrLink imageSize:160];
                    ProduceImage *pi = [[ProduceImage alloc] init];
                    newimg = [pi getImage:self.shareRandShopImage withQRCodeImage:QRImage withText:myType withPrice:[NSString stringWithFormat:@"%@",shop_price] WithTitle:nil];
                    
                }else{//分享链接
                    newimg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],picUrl]]]];
                    
                    self.shareImageStr = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],picUrl];
                }
            }
            
        }else{//分享链接
            newimg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],picUrl]]]];
            self.shareImageStr = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],picUrl];
        }
        
        _shareImage = newimg;
        
        if(_shareImage)
        {
            [MBProgressHUD hideHUDForView:self.view];
            isTixian_share = [myType isEqualToString:@"分享赢提现额度"]?YES:NO;
            [self performSelector:@selector(goshare) withObject:self afterDelay:0.1];
        }
        
    } else {
        
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"没有安装微信" Controller:self];
    }
}


- (void)shareStatus:(SHARESTATE)shareStatus withType:(NSString *)type
{
    NavgationbarView *nv = [[NavgationbarView alloc]init];
    if (shareStatus) {//分享成功
        
        if(isTixian_share == YES && !isxjiang_share)
        {
            [self tixianShareSuccess:type];
        }else if (newShareTixian == YES)
        {
            [nv showLable:@"分享成功" Controller:self];
        }
        else{
            
            [nv showLable:@"分享成功" Controller:self];
            if([Signmanager SignManarer].shareShopCart >= 0)
            {
                NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                NSString *sharecount = [user objectForKey:TASK_SHARE_SHOPCOUNT];
                
                if(sharecount.intValue  >= [Signmanager SignManarer].shareShopCart)
                {
                    //分享成功后签到
                    [self SignHttp:type];
                    
                }
                else if (sharecount.intValue  < [Signmanager SignManarer].shareShopCart)
                {
                    
                    NSString *index_id = [Signmanager SignManarer].index_id;
                    NSString *day = self.day;
                    
                    int rewardCount = (int)_rewardNumber; //分多少次奖励
                    if(rewardCount >1)//多次奖励
                    {
                        [TaskSignModel getTaskHttp:index_id Day:day Success:^(id data) {
                            
                            TaskSignModel *model = data;
                            if(model.status == 1)
                            {
                                [self setTaskPopMindView:Task_shareShop_type Value:nil Title:nil Rewardvalue:_reward_value Rewardnum:(int)_rewardNumber];
                                
                                //标记此任务完成
                                [Signmanager SignManarer].task_isfinish = YES;
                                
                                [self requestHttp];
                            }
                        }];
                        
                    }else{
                        [self setTaskPopMindView:Task_shareShop_type Value:nil Title:nil Rewardvalue:_reward_value Rewardnum:(int)_rewardNumber];
                    }
                }
                
            }
            else{
                //分享成功后签到
                [self SignHttp:type];
            }
        }
        isxjiang_share = NO;
    }
}
- (void)DShareManagerStatus:(SHARESTATE)shareStatus withType:(NSString *)type
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    
//    if ([type isEqualToString:DAILY_TASK_BUQIAN]||[type isEqualToString:DAILY_TASK_ZERO]||[type isEqualToString:DAILY_TASK_YOUHUI]||[type isEqualToString:DAILY_TASK_JIFEN]||[type isEqualToString:DAILY_TASK_XIANJING]||[type isEqualToString:DAILY_TASK_STORE]||[type isEqualToString:DAILY_TASK_DOUBLE] ||[type isEqualToString:DAILY_JIFEN_GOLD] ||[type isEqualToString:DAILY_YOUHUI_GOLDCOUPONS])
    if(type)
    {
        [self shareStatus:shareStatus withType:type];
//        if (shareStatus == 1) {//分享成功
//
//            if(isTixian_share == YES && !isxjiang_share)
//            {
//                [self tixianShareSuccess:type];
//            }else{
//
//                [nv showLable:@"分享成功" Controller:self];
//                if([Signmanager SignManarer].shareShopCart >= 0)
//                {
//                    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//                    NSString *sharecount = [user objectForKey:TASK_SHARE_SHOPCOUNT];
//
//                    if(sharecount.intValue  >= [Signmanager SignManarer].shareShopCart)
//                    {
//                        //分享成功后签到
//                        [self SignHttp:type];
//
//                    }
//                    else if (sharecount.intValue  < [Signmanager SignManarer].shareShopCart)
//                    {
//
//                        NSString *index_id = [Signmanager SignManarer].index_id;
//                        NSString *day = self.day;
//
//                        int rewardCount = (int)_rewardNumber; //分多少次奖励
//                        if(rewardCount >1)//多次奖励
//                        {
//                            [TaskSignModel getTaskHttp:index_id Day:day Success:^(id data) {
//
//                                TaskSignModel *model = data;
//                                if(model.status == 1)
//                                {
//                                    [self setTaskPopMindView:Task_shareShop_type Value:nil Title:nil Rewardvalue:_reward_value Rewardnum:(int)_rewardNumber];
//
//                                    //标记此任务完成
//                                    [Signmanager SignManarer].task_isfinish = YES;
//
//                                    [self requestHttp];
//                                }
//                            }];
//
//                        }else{
//                            [self setTaskPopMindView:Task_shareShop_type Value:nil Title:nil Rewardvalue:_reward_value Rewardnum:(int)_rewardNumber];
//                        }
//                    }
//
//                }
//                else{
//                    //分享成功后签到
//                    [self SignHttp:type];
//                }
//            }
//            isxjiang_share = NO;
//        }
//        else if (shareStatus == 2) {
//            if(isTixian_share == YES && !isxjiang_share)
//            {
//                [self tixianShareSuccess:type];
//            }else{
//                [nv showLable:@"分享失败" Controller:self];
//            }
//            isxjiang_share = NO;
//        }
//        else if (shareStatus == 3) {
//            if(isTixian_share == YES && !isxjiang_share)
//            {
//                [self tixianShareSuccess:type];
//            }else{
//                [nv showLable:@"分享取消" Controller:self];
//            }
//            isxjiang_share = NO;
//        }
        
    }
}

#pragma mark 提现分享成功
- (void)tixianShareSuccess:(NSString*)shareType
{
    NavgationbarView *nv = [[NavgationbarView alloc]init];
    [Signmanager SignManarer].shareTixianCount ++;
    
    if([Signmanager SignManarer].shareTixianCount == [Signmanager SignManarer].everyShareCount)
    {
        //分享成功后签到
        if(!newShareTixian){
            kWeakSelf(self);
            [TaskSignModel getTaskHttp:self.index_id Day:self.day Success:^(id data) {
                
                TaskSignModel *model = data;
                if(model.status == 1)
                {
                    [Signmanager SignManarer].shareTixianCount = 0;
                    [Signmanager SignManarer].AlreadyFinishCount --;
                    
                    NSString *message = @"";
                    NSInteger money = [Signmanager SignManarer].everyShareRaward;
                    if([Signmanager SignManarer].AlreadyFinishCount <= 0)
                    {
                        message = [NSString stringWithFormat:@"任务完成,%zd元现金已存入你的余额",money];
                    }else{
                        
                        message = [NSString stringWithFormat:@"分享成功，再分享%zd次即可得提现现金",[Signmanager SignManarer].everyShareCount-[Signmanager SignManarer].shareTixianCount];

                    }
                    [nv showLable:message Controller:weakself];
                    [self requestHttp];  //刷新完成任务列表数据
                }else{
                    [Signmanager SignManarer].shareTixianCount --;
                }
                
                [textrabonusview shareData];
            }];
        }
        
    }else{
        
//        NSString *message = [NSString stringWithFormat:@"分享成功，再分享%zd次即可赢得\n%zd元提现现金，继续努力",[Signmanager SignManarer].everyShareCount-[Signmanager SignManarer].shareTixianCount,[Signmanager SignManarer].everyShareRaward];
        NSString *message = [NSString stringWithFormat:@"分享成功，再分享%zd次即可得提现现金",[Signmanager SignManarer].everyShareCount-[Signmanager SignManarer].shareTixianCount];
        [nv showLable:message Controller:self];
        [textrabonusview shareData];
    }
}
- (void)tixianSuccess
{
    
}
#pragma mark *************************tableviewdelegate**********************
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView ==_MytableView)
    {
        if (section == 0)
        {
            return (self.FabulousTaskList.count +self.FabulousFinishlist.count)>0?((kScreenWidth-10*2)*0.143 + ZOOM6(60)):0.01;
        }else if (section == 1){
            CGFloat heigh = (kScreenWidth-10*2)*0.142 + ZOOM6(60);
            
            return (self.surFinishTaskList.count + self.surpriseTaskList.count)>0?heigh:0.01;

        } else if (section == 2)
        {
            return (self.dayMustTaskList.count +self.dayMustFinsishList.count)>0?((kScreenWidth-10*2)*0.143 + ZOOM6(60)):0.01;
           
        }else if (section == 3)
        {
            CGFloat heigh = (kScreenWidth-10*2)*0.196 + ZOOM6(60);
            return (self.surTixianTaskList.count + self.surTixianFinishlist.count)>0?heigh:0.01;
        }else if (section == 4)
        {
            return (self.dayExtraTasklist.count +self.dayExtraFinishlist.count)>0?((kScreenWidth-10*2)*0.143 + ZOOM6(60)):0.01;
        }
        else{
            return (kScreenWidth-10*2)*0.143 + ZOOM6(60);
        }
        return 0.01;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView ==_MytableView)
    {
        if (section == 0)
        {
            return (self.FabulousTaskList.count +self.FabulousFinishlist.count)>0?((kScreenWidth-10*2)*0.059):0.01;
        }else if (section == 1)
        {
             return (self.surpriseTaskList.count +self.surFinishTaskList.count)>0?((kScreenWidth-10*2)*0.059):0.01;
        }else if (section == 2)
        {
            return (self.dayMustTaskList.count +self.dayMustFinsishList.count)>0?((kScreenWidth-10*2)*0.059):0.01;
            
        }else if (section == 3)
        {
            return (self.surTixianTaskList.count +self.surTixianFinishlist.count)>0?((kScreenWidth-10*2)*0.059):0.01;
        }else if (section == 4){
            return (self.dayExtraTasklist.count +self.dayExtraFinishlist.count)>0?((kScreenWidth-10*2)*0.059):0.01;
        }
        else{
            return (kScreenWidth-10*2)*0.059;
        }
        return 0.01;

    }
    return 0.01;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView ==_DiscriptableView)
    {
        NSString *content = _discreptionList[indexPath.row];
        
        CGFloat Heigh = [self getRowHeight:content fontSize:ZOOM(45)];
        
        return Heigh+ZOOM(8*3.4);

    }else if (tableView ==_MytableView)
    {
        if(indexPath.section == 5)
        {
            return 250;
        }
        return 65;
    }
    return 0;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView ==_MytableView)
    {
        
        CGFloat imgWith = kScreenWidth-8.5*2;
        CGFloat imgHeigh = imgWith*0.143;
        NSString *imagestr = @"";
        if(section==0)
        {
            imgHeigh = imgWith*0.143;
        }else if (section==1)
        {
            imgHeigh = imgWith*0.143;
            imagestr = @"每月惊喜任务";
            
        }else if (section == 3)
        {
            imgHeigh = imgWith*0.196;
            imagestr = @"new_惊喜任务";
        }
        UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, imgHeigh +ZOOM6(60))];
        headview.backgroundColor = [UIColor clearColor];
        headview.clipsToBounds = YES;
    
        UIImageView * headimage = [[UIImageView alloc]initWithFrame:CGRectMake(9, ZOOM6(60), imgWith,imgHeigh)];
        headimage.contentMode = UIViewContentModeScaleToFill;
        headimage.clipsToBounds = YES;
        headimage.layer.masksToBounds = YES;
        
        if (section==0)
        {
            headimage.frame = CGRectMake(8.5, ZOOM6(60), imgWith,imgHeigh);
            headimage.image = (self.FabulousTaskList.count +self.FabulousFinishlist.count)>0?[UIImage imageNamed:@"超级惊喜任务"]:nil;
            
        }else if (section==1)
        {
            headimage.frame = CGRectMake(8.5, ZOOM6(60), imgWith,imgHeigh);
            headimage.image = [UIImage imageNamed:imagestr];
            
        }else if (section==2)
        {
            headimage.image = (self.dayMustTaskList.count +self.dayMustFinsishList.count)>0?[UIImage imageNamed:@"task_muat-do"]:nil;
            
        }else if (section==3)
        {
            headimage.frame = CGRectMake(8.5, ZOOM6(60), imgWith,imgHeigh);
            headimage.image = [UIImage imageNamed:imagestr];

        }else if (section==4)
        {
            headimage.image = (self.dayExtraTasklist.count +self.dayExtraFinishlist.count)>0?[UIImage imageNamed:@"task_extra"]:nil;
        }else if (section == 5){
            headimage.image = [UIImage imageNamed:@"task_tomorrow"];
        }
        
        [headview addSubview:headimage];
        
        return headview;
    }else if (tableView ==_DiscriptableView){
        return nil;
    }
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(tableView == _MytableView)
    {
        UIView *foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, (kScreenWidth-10*2)*0.059)];
        foot.backgroundColor = [UIColor clearColor];
        
        UIImageView *footimg = [[UIImageView alloc]initWithFrame:CGRectMake(9, 0, CGRectGetWidth(foot.frame)-2*8.5, CGRectGetHeight(foot.frame))];
        footimg.contentMode = UIViewContentModeScaleToFill;
        footimg.image = [UIImage imageNamed:@"new_01"];
        [foot addSubview:footimg];
       
        if (section==0)
        {
            foot.frame = (self.FabulousTaskList.count +self.FabulousFinishlist.count)>0?CGRectMake(0, 0, kScreenWidth, (kScreenWidth-10*2)*0.059):CGRectMake(0, 0, kScreenWidth, 0);
            footimg.frame = (self.FabulousTaskList.count +self.FabulousTaskList.count)>0?CGRectMake(9, 0, CGRectGetWidth(foot.frame)-2*8.5, CGRectGetHeight(foot.frame)):CGRectMake(9, 0, CGRectGetWidth(foot.frame)-2*8.5, 0);
        }else if (section==1)
        {
            foot.frame = (self.surpriseTaskList.count +self.surFinishTaskList.count)>0?CGRectMake(0, 0, kScreenWidth, (kScreenWidth-10*2)*0.059):CGRectMake(0, 0, kScreenWidth, 0);
            footimg.image = (self.surpriseTaskList.count +self.surFinishTaskList.count)>0?[UIImage imageNamed:@"new_01"]:nil;
        }
        else if (section==2)
        {
            foot.frame = (self.dayMustTaskList.count +self.dayMustFinsishList.count)>0?CGRectMake(0, 0, kScreenWidth, (kScreenWidth-10*2)*0.059):CGRectMake(0, 0, kScreenWidth, 0);
            footimg.image = (self.dayMustTaskList.count +self.dayMustFinsishList.count)>0?[UIImage imageNamed:@"new_01"]:nil;
            
        }else if (section==3)
        {
            foot.frame = (self.surTixianTaskList.count +self.surTixianFinishlist.count)>0?CGRectMake(0, 0, kScreenWidth, (kScreenWidth-10*2)*0.059):CGRectMake(0, 0, kScreenWidth, 0);
            footimg.image = (self.surTixianTaskList.count +self.surTixianFinishlist.count)>0?[UIImage imageNamed:@"new_01"]:nil;
        }else if (section == 4){
            foot.frame = (self.dayExtraTasklist.count +self.dayExtraFinishlist.count)>0?CGRectMake(0, 0, kScreenWidth, (kScreenWidth-10*2)*0.059):CGRectMake(0, 0, kScreenWidth, 0);
            footimg.frame = (self.dayExtraTasklist.count +self.dayExtraFinishlist.count)>0?CGRectMake(9, 0, CGRectGetWidth(foot.frame)-2*8.5, CGRectGetHeight(foot.frame)):CGRectMake(9, 0, CGRectGetWidth(foot.frame)-2*8.5, 0);
        }
        
        return foot;
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView ==_DiscriptableView)
    {
        return 1;
    }else if(tableView ==_MytableView)
    {
        return 6;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView ==_DiscriptableView)
    {
        return _discreptionList.count;
    }else if (tableView ==_MytableView)
    {
        if (section == 0)
        {
            return self.FabulousTaskList.count +self.FabulousFinishlist.count;
            
        }if(section == 1)
        {
            return self.surpriseTaskList.count +self.surFinishTaskList.count;
        }else if (section == 2)
        {
            return self.dayMustTaskList.count  +self.dayMustFinsishList.count;
        
        }else if (section == 3)
        {
            return self.surTixianTaskList.count +self.surTixianFinishlist.count;
        }else if (section == 4)
        {
            return self.dayExtraTasklist.count +self.dayExtraFinishlist.count;
        }else if (section == 5){
            return 1;
        }

        return 5;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _DiscriptableView)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"q-%d",(int)indexPath.row+1]];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@",_discreptionList[indexPath.row]];
        
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.textColor=kTextColor;
        cell.textLabel.font = [UIFont systemFontOfSize:ZOOM(45)];

        return cell;
        
    }else if(tableView ==_MytableView){
        
        if(indexPath.section < 5)
        {
            static NSString *identifier=@"TaskCell";
            TaskTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
            if(!cell)
            {
                cell=[[TaskTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            }
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.titlelable.textColor = RGBCOLOR_I(125, 125, 125);
            cell.titlelable.font = [UIFont systemFontOfSize:ZOOM6(28)];
            cell.mondaytype = self.mondytype;
            
            cell.titlelable.text = @"";
            cell.priceLab.text = @"";
            
            cell.moreimage.hidden = NO;
            cell.priceLab.hidden = YES;
            cell.extraLab.hidden = YES;
            cell.finisgImg.hidden = YES;
            cell.buyImage.hidden = YES;
            
            cell.backgroundColor = [UIColor clearColor];
            
            cell.baseView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_04"]];
            
            cell.backView.userInteractionEnabled = YES;
            cell.backView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
            cell.backView.layer.cornerRadius = 5;
            
            cell.priceLab.textColor = tarbarrossred;
            cell.moreimage.image = [UIImage imageNamed:@"task-icon_go"];
            
            TaskModel *taskModel = [[TaskModel alloc]init];
            
            if (indexPath.section == 0)
            {
                cell.priceLab.hidden = NO;
                if(indexPath.row < self.FabulousTaskList.count)
                {
                    if(self.FabulousTaskList.count)
                    {
                        taskModel = self.FabulousTaskList[indexPath.row];
                    }
                }else{
                    if(self.FabulousFinishlist.count)
                    {
                        taskModel = self.FabulousFinishlist[indexPath.row-self.FabulousTaskList.count];
                    }
                }
            }if (indexPath.section == 1)
            {
                cell.priceLab.hidden = NO;
                if(indexPath.row < self.surpriseTaskList.count)
                {
                    if(self.surpriseTaskList.count)
                    {
                        taskModel = self.surpriseTaskList[indexPath.row];
                    }
                }else{
                    if(self.surFinishTaskList.count)
                    {
                        taskModel = self.surFinishTaskList[indexPath.row - self.surpriseTaskList.count];
                    }
                }
                
            }
            else if(indexPath.section == 3)
            {
                cell.priceLab.hidden = NO;
                if(indexPath.row < self.surTixianTaskList.count)
                {
                    if(self.surTixianTaskList.count)
                    {
                        taskModel = self.surTixianTaskList[indexPath.row];
                    }
                }else{
                    if(self.surTixianFinishlist.count)
                    {
                        taskModel = self.surTixianFinishlist[indexPath.row - self.surTixianTaskList.count];
                    }
                }

            }else if (indexPath.section == 2)
            {
                if(indexPath.row < self.dayMustTaskList.count)
                {
                    if(self.dayMustTaskList.count)
                    {
                        if(indexPath.row == 0)
                        {
                            cell.buyImage.hidden = NO;
                            [cell.buyImage shakeStatus:YES];
                            cell.buyImage.frame = CGRectMake(63, 0, 168, 23);
                            cell.buyImage.image = [UIImage imageNamed:@"pop_必做任务"];
                        }
                        taskModel = self.dayMustTaskList[indexPath.row];
                    }
                }else{
                    if(self.dayMustFinsishList.count)
                    {
                        taskModel = self.dayMustFinsishList[indexPath.row - self.dayMustTaskList.count];
                    }
                }

            }else if (indexPath.section == 4){
                cell.priceLab.hidden = NO;
                if(indexPath.row < self.dayExtraTasklist.count)
                {
                    if(self.dayExtraTasklist.count)
                    {
                        taskModel = self.dayExtraTasklist[indexPath.row];
                    }
                }else{
                    if(self.dayExtraFinishlist.count)
                    {
                        taskModel = self.dayExtraFinishlist[indexPath.row-self.dayExtraTasklist.count];
                    }
                }
            }
            
            if(taskModel.task_type.intValue == 6 || taskModel.task_type.intValue == 9 || taskModel.task_type.intValue == 999 ||taskModel.task_type.intValue == 24)
            {
                if(taskModel.isfinish == NO)
                {
                    cell.buyImage.hidden = NO;
                    [cell.buyImage shakeStatus:YES];
                }else{
                    [cell.buyImage shakeStatus:NO];
                }
            }
            
            cell.fxqd = self.fxqd.floatValue>0?self.fxqd:@"5";
            cell.orderStatus = self.orderStatus.intValue;
            [cell refreshData:taskModel Data:_motaskDataArray ValueData:self.shopGroupList];
            return cell;
        }
        else
        {
            TomorrowTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TomorrowCell"];
            if(!cell)
            {
                cell=[[TomorrowTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TomorrowCell"];
            }
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            
            cell.baseView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_04"]];
            
            [cell refreshData:_tomorrowTaskList];
            return cell;
        }
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _DiscriptableView)
    {
        return;
    }
    
    [self selectTaskIndexPath:indexPath];
    
}

- (void)selectTaskIndexPath:(NSIndexPath *)indexPath
{
    //没登录先去登录
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:USER_TOKEN];
    if(token.length > 10)
    {
        
    }else{
        [self loginSuccess:^{
            
        }];
        return;
    }
    
    //从第三日开始买了会员才能做任务
    if(whetherTask !=NULL && ![whetherTask isEqual:[NSNull null]] && whetherTask.intValue == 0){
        [self setVitalityPopMindView:BecomeMember_task];
        return;
    }
    
    if (indexPath.section == 0)
    {
        if(indexPath.row < self.FabulousTaskList.count)
        {
            if(self.FabulousTaskList.count)
            {
                PubtaskModel = self.FabulousTaskList[indexPath.row];
            }
        }else{
            if(self.FabulousFinishlist.count)
            {
                PubtaskModel = self.FabulousFinishlist[indexPath.row-self.FabulousTaskList.count];
            }
        }
    }if (indexPath.section == 1)
    {
        if(indexPath.row < self.surpriseTaskList.count)
        {
            if(self.surpriseTaskList.count)
            {
                PubtaskModel = self.surpriseTaskList[indexPath.row];
            }
        }else{
            if(self.surFinishTaskList.count)
            {
                PubtaskModel = self.surFinishTaskList[indexPath.row - self.surpriseTaskList.count];
            }
        }
        
        self.day = PubtaskModel.task_type.intValue==6?0:self.day;
    }
    else if(indexPath.section == 3)
    {
        if(indexPath.row < self.surTixianTaskList.count)
        {
            if(self.surTixianTaskList.count)
            {
                PubtaskModel = self.surTixianTaskList[indexPath.row];
            }
        }else{
            if(self.surTixianFinishlist.count)
            {
                PubtaskModel = self.surTixianFinishlist[indexPath.row - self.surTixianTaskList.count];
            }
        }
        
        self.day = PubtaskModel.task_type.intValue==6?0:self.day;
        
    }else if (indexPath.section == 2)
    {
        if(indexPath.row < self.dayMustTaskList.count )
        {
            if(self.dayMustTaskList.count)
            {
                PubtaskModel = self.dayMustTaskList[indexPath.row];
            }
        }else{
            if(self.dayMustFinsishList.count)
            {
                PubtaskModel = self.dayMustFinsishList[indexPath.row - self.dayMustTaskList.count];
            }
        }
    }else if (indexPath.section == 4){
        if(indexPath.row < self.dayExtraTasklist.count)
        {
            if(self.dayExtraTasklist.count)
            {
                PubtaskModel = self.dayExtraTasklist[indexPath.row];
            }
        }else{
            if(self.dayExtraFinishlist.count)
            {
                PubtaskModel = self.dayExtraFinishlist[indexPath.row-self.dayExtraTasklist.count];
            }
        }
    }
    //此任务不可在app完成
    if(PubtaskModel.task_h5.intValue == 4)
    {
        return;
    }

    //必须完成必做任务后才能做其他任务 (不包含参团任务和为好友点赞任务以及疯狂新衣节；购买X件商品；购买赢提现，超级0元购等所有购买任务）
//    BOOL mustTaskFinish =[self mustTaskFinisStatue];
//    if(!mustTaskFinish && indexPath.section != 2 && PubtaskModel.task_type.intValue != 17 && PubtaskModel.task_type.intValue != 15 && PubtaskModel.task_type.intValue != 6 && PubtaskModel.task_type.intValue != 24 && PubtaskModel.task_type.intValue != 999 && PubtaskModel.task_type.intValue != 28 && PubtaskModel.task_type.intValue != 29 && PubtaskModel.task_type.intValue != 30 && PubtaskModel.task_type.intValue != 31 && PubtaskModel.task_type.intValue != 32)
//    {
//        NavgationbarView *mentionview = [NavgationbarView shared];
//        [mentionview showLable:@"请先完成必做任务才能做其他任务哦。" Controller:self];
//
//        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:2];
//        [self.MytableView scrollToRowAtIndexPath:scrollIndexPath
//                                atScrollPosition:UITableViewScrollPositionTop animated:YES];
//        return;
//    }
    
    if(indexPath.section != 5)
    {
        int tasktype = PubtaskModel.task_type.intValue;
        if(PubtaskModel.isfinish == NO)
        {
            if (PubtaskModel.task_type.intValue == 5)//浏览分钟数任务
            {
                if([[NSUserDefaults standardUserDefaults]boolForKey:@"is_read"] == NO)
                {
                    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:PubtaskModel];
                    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"liulanModel"];
                    
                    [self rewardType:PubtaskModel];
                    [self goFinishTask:PubtaskModel];
                    
                }else{
                    
                    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"liulanModel"];
                    TaskModel *oldmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
                    
                    if(![oldmodel.index isEqualToString:PubtaskModel.index])
                    {
                        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"is_newTask"];
                    }else{
                        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"is_newTask"];
                    }
                    
                    [self rewardType:oldmodel];
                    [self goFinishTask:oldmodel];
                }
            }
            else{
                [self rewardType:PubtaskModel];
                [self goFinishTask:PubtaskModel];
            }
            
            //将点过的任务放在一个数组里
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:PubtaskModel.index forKey:PubtaskModel.t_name];
            [self.selectTaskList addObject:dic];
            
            //查看这个任务之前是否有点过
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            if([[user objectForKey:TASK_LIULAN_LASTTIME] intValue] != [PubtaskModel.index intValue])
            {
                [user removeObjectForKey:TASK_LIULAN_SHOPCOUNT];
            }
            [user setObject:PubtaskModel.index forKey:TASK_LIULAN_LASTTIME];
            
        }else{
            if(tasktype == 1 || tasktype == 2|| tasktype == 4 || tasktype == 5 || tasktype == 9 || tasktype ==11 || tasktype ==12 || tasktype ==16 || tasktype ==17 || tasktype ==18 || tasktype ==20)
            {
                [self finishReadygo:PubtaskModel];
            }
        }
    }
}
#pragma mark 必做任务是否做完
- (BOOL)mustTaskFinisStatue
{
    BOOL isFinish = (self.musttaskCount - self.musttaskFtinishCount)<= 0;
    return isFinish;
}

#pragma mark 额外任务是否做完
- (BOOL)extraTaskFinisStatue
{
    BOOL isFinish = (self.extrataskCount - self.extrataskFtinishCount) <= 0;
    return isFinish;
}

#pragma mark 提现任务是否做完
- (BOOL)tixianTaskFinishStatue
{
    BOOL isFinish = (self.tixiantaskCount - self.tixiantaskFtinishCount) <= 0;
    return isFinish;
}
#pragma mark ********************uialterviewdelegate**************
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        MyLog(@"去绑定手机");
        BoundPhoneVC *tovc = [[BoundPhoneVC alloc] init];
        tovc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tovc animated:YES];
    }
}

#pragma mark *************************任务点击事件**********************
-(void)goFinishTask:(TaskModel*)model
{
    //先检测是否绑定手机
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if([user objectForKey:USER_PHONE]==nil)
    {
        kWeakSelf(self);
        [self httpFindPhone:model Success:^{
            [weakself redygo:model];
        }];
    }else
    {
        if([user objectForKey:UNION_ID] == nil)
        {
            kWeakSelf(self);
            [weakself shareSdkWithAutohorWithTypeGetOpenID:model dictionary:nil Success:^{
                [weakself redygo:model];
            }];
        }else{
            [self redygo:model];
        }
    }
}
#pragma mark 未完成任务点击事件界面跳转
- (void)redygo:(TaskModel*)model
{
    NSString *tasktype = model.task_type;
    NSString *rewardnum = model.num;
    
    NSMutableString *value = [NSMutableString stringWithFormat:@"%@",model.value];
    NSArray *valueArr = [value componentsSeparatedByString:@","];

    NSString *liulanCount = @"1";
    if(valueArr.count >= 2)
    {
        liulanCount = valueArr[1];
        if(valueArr.count > 2 && (model.task_type.intValue == 7 || model.task_type.intValue == 8))
        {
            self.taskValue =  [valueArr[2] intValue];
        }else if(model.task_type.intValue == 19){
            liulanCount = valueArr[1];
            self.taskValue = 2;
        }else if(model.task_type.intValue == 20)
        {
            liulanCount = valueArr[1];
            self.taskValue = 2;
        }
    }else if (valueArr.count == 1)
    {
        liulanCount = valueArr[0];
        self.taskValue = 2;
    }
    
    NSString *ss;
    if(tasktype.intValue == 5)
    {
        ss = model.app_name;
        if(ss.length < 1)
        {
            ss = @"浏览完成~";
        }
    }

    self.tasktype = @"";
    
    switch (tasktype.intValue) {
        case 0://开店
            
            [self gostore];
            break;
        case 1://邀请好友
            
            [self goyaoqing:NO];
            break;
        case 2://夺宝
            [Signmanager SignManarer].indianaShareRaward = _task_value;
            [self goduobao:TreasuresType_Shop];
            break;
        case 3://加X购物车
            
            [Signmanager SignManarer].day = self.day;
            [Signmanager SignManarer].addShopCart = liulanCount.intValue;
            
            [self addCart];
            break;
        case 4://浏览X件商品(原强制浏览+新版搭配)
            
            [self liulan:model];
            
            break;
        case 5://浏览集合几分钟
            
            [self setTaskPopMindView:Task_liulan_gouwushop Value:liulanCount Title:ss Rewardvalue:[Signmanager SignManarer].liulan_rewardvalue Rewardnum:rewardnum.intValue];
            
            break;
        case 6://购买X件商品
            
            if(model.task_class.intValue == 1 || model.task_class.intValue == 2 || model.task_class.intValue == 4)//1必做任务 2额外任务 4惊喜提现任务
            {
                [DataManager sharedManager].Buy_Task = YES;
                [DataManager sharedManager].Finish_Buy_task = YES;
                [self setTaskPopMindView:Task_goumai_type Value:nil Title:ss Rewardvalue:_reward_value Rewardnum:(int)_rewardNumber];
            }
           
            break;
        case 7://分享商品
            
            [Signmanager SignManarer].shareShopCart = liulanCount.intValue;
            
            [self beginshareStatue];
            
            break;
        case 701://分享商品（余额翻倍）
            
            [self beginShareTitlePopView];
            break;
        case 702://分享商品（积分升级）
            
            [self beginshareStatue];
            break;
        case 703://分享商品（优惠券升级）
            
            [self beginshareStatue];
            break;
        case 8://分享搭配购
            
            self.tasktype = @"搭配购";
            [self beginshareStatue];
            
            break;
        case 801://分享搭配购（余额翻倍）
            
            [self beginShareTitlePopView];
            break;
        case 802://分享搭配购（积分升级）
            
            [self beginshareStatue];
            break;
        case 803://分享搭配购（优惠券升级）
            
            [self beginshareStatue];
            break;
           
        case 9://免单
            
            [self freeorder:model];

            break;
            
        case 10://设置喜好
            [self settingHobby:model];
            break;
            
        case 11://去精选推荐挑美衣
            [self gotoRecommend];
            break;
        case 12://浏览X条热门穿搭
            [self gotoTopic:NO];
            break;
        case 13://分享一件品质美衣
            [self gotoShareMieyi:0];
            break;
        case 14://分享-条热门穿搭
            [self gotoShareMieyi:1];
            break;
        case 15://为好友继续点赞
            if(self.isGratis)
            {
                [self fabousHttp:NO];
            }else{
                [self setTaskPopMindView:Task_jizanOver_type Value:nil Title:nil Rewardvalue:nil Rewardnum:0];
            }
            
            break;
        case 16://分享集赞
            
            [self goFabous:YES];
            break;
            
        case 18://去拼团
            
            [self goFight:1];
            break;
        case 17://参团
            
            [self goFight:2];
            break;
        case 19://浏览提现
            
            [Signmanager SignManarer].everyLiulanRaward = self.reward_value.intValue;
            [Signmanager SignManarer].liulanFinishCount = model.num.integerValue;
            [Signmanager SignManarer].everyLinlanCount = liulanCount.integerValue;
            [self finishTixianCount:model];
            [self liulan:model];
            
            break;
            
        case 20://分享提现
            
            //分享提现埋点
            [YFShareModel getShareModelWithKey:@"fxytx" type:StatisticalTypeTixianClick tabType:StatistiaclTabTypeShareTixian success:nil];

            [Signmanager SignManarer].everyShareRaward = self.reward_value.intValue;
            [Signmanager SignManarer].takFinishCount = model.num.integerValue;
            [Signmanager SignManarer].everyShareCount = liulanCount.integerValue;
            [self finishTixianCount:model];
            [self creatIndianaPopView];
            
            break;
        case 21://一元夺宝
            
            [self goduobao:TreasuresType_edu];
            break;
        case 23://千元红包雨
            
//            [[DataManager sharedManager] RawardRedPopView:RawardRed_order_open];
            [self setTaskPopMindView:Task_ThousandYunRed Value:nil Title:ss Rewardvalue:_reward_value Rewardnum:(int)_rewardNumber];
            break;
        case 22://拼团夺宝
            
            [self goduobao:TreasuresType_GroupShop];
            break;
        case 24://惊喜任务购买X件商品
            
//            [self setTaskPopMindView:Task_supprise_type Value:nil Title:ss Rewardvalue:_reward_value Rewardnum:(int)_rewardNumber];
            
            [self setTaskPopMindView:Task_DoubleActiveRule Value:nil Title:ss Rewardvalue:_reward_value Rewardnum:(int)_rewardNumber];
            break;
        case 25://新分享现赢提现
            
            [self creatTixianPopview];
            break;
        case 26://幸运转盘
            [self goLuck:YES];
            break;
        case 27://余额抽奖
            [self goLuck:NO];
            break;
        case 28://超级0元购
            
            [self zero_shoppingPopview];
            
            break;
        case 30://超级分享日
            
            [self CFInviteFriends:NO];
            
            break;

        case 31://好友提成
            
            [self CFInviteFriends:NO];
            
            break;
        case 32://分享赚钱任务页
            [self CFInviteFriends:YES];
            
            break;
        case 999://疯狂星期一
            self.LotteryNumber>0?[self addtixian]:[self setFreeOrderPopMindView:CrazyMonday_activity];
            
            break;
            
        default:
            break;
    }

}
#pragma mark 超级分享日 好友提成
- (void)CFInviteFriends:(BOOL)isShareMakeMoney
{
    CFInviteFriendsRewardVC *friend = [[CFInviteFriendsRewardVC alloc]init];
    friend.hidesBottomBarWhenPushed = YES;
    friend.isShareMakeMoney = isShareMakeMoney;
    [self.navigationController pushViewController:friend animated:YES];
}
#pragma mark 超级0元购弹框
- (void)zero_shoppingPopview
{
    [DataManager sharedManager].Buy_Task = YES;
    [DataManager sharedManager].Finish_Buy_task = YES;
    [self setVitalityPopMindView:Super_redZeroShopping];
}
#pragma mark 提现任务还剩多少次完成
- (void)finishTixianCount:(TaskModel*)currentModel
{
    if(currentModel.task_type.intValue == 19)//浏览赢提现
    {
        [Signmanager SignManarer].liulanAlreadyCount = currentModel.num.intValue;
    }else if (currentModel.task_type.intValue == 20)//分享赢提现
    {
        [Signmanager SignManarer].AlreadyFinishCount = currentModel.num.integerValue;
    }

    for(TaskModel * model in _soonFinishList)//在已完成的列表里面找
    {
        if(model.index.intValue == currentModel.index.intValue)
        {
            if(currentModel.task_type.intValue == 19)//浏览赢提现
            {
                [Signmanager SignManarer].liulanAlreadyCount = model.status.integerValue;
            }else if (currentModel.task_type.intValue == 20)//分享赢提现
            {
                [Signmanager SignManarer].AlreadyFinishCount=model.status.integerValue;
            }
            
            break;
        }
    }
}
#pragma mark 完成任务跳转事件
- (void)finishReadygo:(TaskModel*)model
{
    NSString *tasktype = model.task_type;
    
    switch (tasktype.intValue) {
        case 1://邀请好友
            
            [self goyaoqing:NO];
            
            break;
        case 2://夺宝
            
            [self goduobao:TreasuresType_Shop];
            break;

        case 4://浏览X件商品(原强制浏览+新版搭配)
            
            [self liulan:model];
            
            break;
        case 5://浏览集合几分钟
            
            [self liulanDapei:model];
            
            break;
        case 9:
            [self freeorder:model];
            break;
        case 11:
            
            [self mentionView];
            break;
        case 12:
            [self gotoTopic:YES];
            break;
        case 13://分享一件品质美衣
            [self gotoShareMieyi:0];
            break;
        case 14://分享-条热门穿搭
            [self gotoShareMieyi:1];
            break;
        case 16://继续分享集赞
            
            [self goFabous:NO];
            break;
        case 18://开团详情
            
            [self goFightDetail:1];
            break;
        case 17://参团详情
            
            [self goFightDetail:2];
            break;
        case 20://分享赢提现
//            [self shareTixianMention];
            break;
        case 21://一元夺宝
            
            [self goduobao:TreasuresType_edu];
            break;

        default:
            break;
    }

}

- (void)mentionView
{
    //查看精选推荐浏览时间（今天浏览完就不能在浏览）
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDate *record = [user objectForKey:FINISHRECOMMENDPOPDATE];
    if(![[MyMD5 compareDate:record] isEqualToString:@"今天"] || record==nil )
    {
        [self gotoRecommend];
    }else{
        [MBProgressHUD show:@"已经完成今天的精选推荐了哦~" icon:nil view:self.view];
    }
}
//分享赢提现到上限后提示
- (void)shareTixianMention
{
    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
    [mentionview showLable:@"今日的分享次数已达上线，明天再来吧~" Controller:self];
}
//去抽奖或余额抽提现
- (void)goLuck:(BOOL)isRed
{
    LuckdrawViewController *luck = [[LuckdrawViewController alloc]init];
    luck.hidesBottomBarWhenPushed = YES;
    if(isRed)
    {
        luck.is_OrderRedLuck = [[[NSUserDefaults standardUserDefaults]objectForKey:@"RedMoneyLeastNum"] integerValue] ? YES : NO;
        luck.is_comefromeRed = YES;
    }
    [self.navigationController pushViewController:luck animated:YES];
}
//去开店
- (void)gostore
{
    //跳转到小店去开店
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user setObject:@"2" forKey:isShowNoviceTaskView6];
    
    Mtarbar.selectedIndex=0;
    
    [self.navigationController popToRootViewControllerAnimated:NO];
}
//去夺宝
- (void)goduobao:(TreasuresType)type
{
    //埋点
    [YFShareModel getShareModelWithKey:@"duobao" type:StatisticalTypeIndianaTask tabType:StatisticalTabTypeIndiana success:nil];

    ContendTreasuresAreaVC *contend = [[ContendTreasuresAreaVC alloc]init];
    contend.type = type;
    contend.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:contend animated:YES];
}
//去拼团 1拼团 2参团
- (void)goFight:(NSInteger)opengroup
{
//    [self fightGrouphttpData];
    
    [DataManager sharedManager].opengroup = opengroup;
    [[DataManager sharedManager].fightData removeAllObjects];
    [DataManager sharedManager].fightStatus = (opengroup==2 && self.fighStatus.length>=8)?self.fighStatus:nil;
    
    if(opengroup == 2)
    {
        if(self.offered.intValue == 2)//可参团
        {
            FightgroupsViewController *vc = [[FightgroupsViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [self goFightDetail:2];
        }
    }else{
//        [self fightGrouphttpData:^(NSString *n_status) {
//            
//            if(n_status.intValue == 0)//0人数没满
//            {
//                GroupBuyDetailVC *vc = [[GroupBuyDetailVC alloc] init];
//                [self.navigationController pushViewController:vc animated:YES];
//            }else if(n_status.intValue == 1){//1人满了待付款
//                GroupBuyDetailVC *vc = [[GroupBuyDetailVC alloc] init];
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//        }];
        
        if(self.orderCount == 0)
        {
            FightgroupsViewController *vc = [[FightgroupsViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            [DataManager sharedManager].opengroutSuccess=self.orderStatus.intValue==1?3:2;
            
            GroupBuyDetailVC *vc = [[GroupBuyDetailVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
//拼团详情 1拼团 2参团
- (void)goFightDetail:(NSInteger)opengroup
{
    if(opengroup == 1)//开团
    {
        [DataManager sharedManager].opengroutSuccess=self.orderStatus.intValue==1?3:2;
    }else{//参团
        
        [DataManager sharedManager].opengroutSuccess=5;
        [DataManager sharedManager].fightStatus = self.fighStatus.length>=8 ? self.fighStatus : nil;
    }
    
    [DataManager sharedManager].opengroup = opengroup;
    GroupBuyDetailVC *vc = [[GroupBuyDetailVC alloc] init];
    vc.offered = self.offered.integerValue;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//邀请好友
- (void)goyaoqing:(BOOL)isinvit
{  
    SelectShareTypeViewController *sharetype = [[SelectShareTypeViewController alloc]init];
    sharetype.ISInvit = isinvit;
    sharetype.TaskFinishBlock = ^{//分享成功弹框
        
        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        [mentionview showLable:@"分享成功" Controller:self];
    };
    sharetype.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sharetype animated:YES];
}
//加购物车
- (void)addCart
{
   [self setTaskPopMindView:Task_addCart_type Value:nil Title:nil Rewardvalue:_reward_value Rewardnum:(int)_rewardNumber];
}
//去免单
- (void)freeorder:(TaskModel*)model
{
    FashionBuyInfoVC *vc = [[FashionBuyInfoVC alloc]init];
    if([model.value intValue] == 1)
    {
        vc.fashionType = 1;
    }else if([model.value intValue] == 2){
        vc.fashionType = 2;
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//设置喜好
- (void)settingHobby:(TaskModel*)model
{
    SelectHobbyViewController *hobby = [[SelectHobbyViewController alloc]init];
    hobby.submitHobbySuccess = ^{
        [self hobbySuccess];
    };
    hobby.index = _index_id;
    hobby.day = self.day;
    hobby.rewardType = _reward_type;
    hobby.rewardValue = _reward_value;
    hobby.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hobby animated:YES];
}
//热卖
- (void)goremai
{
    TaskCollectionVC *vc = [[TaskCollectionVC alloc]init];
    vc.typeID = [NSNumber numberWithInt:6];
    vc.typeName = @"热卖";
    vc.title = @"热卖";
    vc.is_jingxi = YES;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//疯狂星期一活动详情页
- (void)CrazyMonday
{
    CrazyMondayActivityVC *activity = [[CrazyMondayActivityVC alloc]init];
    activity.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:activity animated:YES];
    
}
//去精选推荐挑美衣
- (void)gotoRecommend
{
    [DataManager sharedManager].isRecommendTask = YES;
    [DataManager sharedManager].isFinishRecommendTask = YES;
    Mtarbar.selectedIndex=0;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

//浏览X条热门穿搭
- (void)gotoTopic:(BOOL)isfinish
{
    HotOutfitViewController *hot = [[HotOutfitViewController alloc]init];
    hot.hidesBottomBarWhenPushed = YES;
    hot.isFinish = isfinish;
    hot.isLiulan = YES;
    [self.navigationController pushViewController:hot animated:YES];
}

//分享邀请好友集赞
- (void)goFabous:(BOOL)isFirist
{
    //埋点
    [YFShareModel getShareModelWithKey:@"point" type:StatisticalTypeShareFriend tabType:StatisticalTabTypeLikeCollect success:nil];
    
    CollecLikeTaskVC *vc = [[CollecLikeTaskVC alloc]init];
    vc.isFiristInvit = isFirist;
    vc.TaskFinishBlock = ^{
        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        [mentionview showLable:@"分享成功" Controller:self];
    };
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)gotoShareMieyi:(NSInteger)type//type=0 美衣 1穿搭
{
    SelectShareTypeViewController *sharetype = [[SelectShareTypeViewController alloc]init];
    sharetype.selectShareType = type;
    sharetype.hideSegment = YES;
    kWeakSelf(self);
    sharetype.TaskFinishBlock = ^{//分享成功弹框
       
        [weakself setTaskPopMindView:Task_shreSucess_type Value:nil Title:nil Rewardvalue:_reward_value Rewardnum:(int)_rewardNumber];
    };
    sharetype.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sharetype animated:YES];

}
//购买几件商品
- (void)shoppinggo:(TaskModel*)model
{
    NSString *value1 = @"";
    
    NSMutableString *valuestr = [NSMutableString stringWithFormat:@"%@",model.value];
    NSArray *valueArr = [valuestr componentsSeparatedByString:@","];
    if(valueArr.count >= 2)
    {
        value1 = valueArr[0];
    }else{
        value1 = valueArr[0];
    }
    if(self.mondytype == Mondytype_YES)
    {
        value1 = [DataManager sharedManager].mondayValue;
    }
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
        testVC.isFinish = model.isfinish;
        testVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:testVC animated:YES];
    }else if ([value1 isEqualToString:@"collection=csss_shop"])//专题
    {
        TFCollocationViewController *subVC = [[TFCollocationViewController alloc] init];
        subVC.page = 0;
        subVC.typeName = @"专题";
        subVC.typeID = [NSNumber numberWithInt:2];
        subVC.isFinish = model.isfinish;
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
        
        SearchTypeViewController *searchShopping = [[SearchTypeViewController alloc]init];
        searchShopping.is_pushCome = YES;
        searchShopping.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:searchShopping animated:YES];

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
//浏览几件商品
- (void)liulan:(TaskModel*)model
{
    NSMutableString *value = [NSMutableString stringWithFormat:@"%@",model.value];
    NSArray *valueArr = [value componentsSeparatedByString:@","];
    NSString *valueStr = @"0";
    NSString *liulanCount = @"1";
    if(valueArr.count >= 2)
    {
        valueStr = valueArr[0];
        liulanCount = valueArr[1];
    }else
    {
        valueStr = valueArr[0];
    }

    //浏览赢提现的时候  传YES
    BOOL isTiXian = false;

    if(model.task_type.intValue == 19)//浏览赢现金额度
    {
        liulanCount = [NSString stringWithFormat:@"%d",model.num.intValue*liulanCount.intValue];
        isTiXian = YES;
    }

    [Signmanager SignManarer].liulanShopCount = liulanCount.intValue;
//    [Signmanager SignManarer].liulan_taskvalue = [self remindTost:valueStr];
    [Signmanager SignManarer].liulan_taskvalue = model.app_name;
    
    if([valueStr isEqualToString:@"collection=shop_activity"])//活动商品
    {
        TFActivityShopVC *vc = [[TFActivityShopVC alloc]init];
        vc.isTiXian = isTiXian;

        if(!model.isfinish)
        {
            vc.index = _index_id;
            vc.day = _day;
            vc.rewardCount = _rewardNumber;
            vc.rewardType = _reward_type;
            vc.rewardValue = _reward_value;
            vc.randomNum = liulanCount.intValue;
            vc.liulanCount = liulanCount.intValue;
        }
        vc.bannerImage = [self getIconFromShopGroupList:model];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([valueStr isEqualToString:@"collection=collocation_shop"])//新版搭配
    {
        TFLedBrowseCollocationShopVC *vc = [[TFLedBrowseCollocationShopVC alloc]init];
        vc.isTiXian = isTiXian;

        if(!model.isfinish)
        {
            vc.randomNum = liulanCount.intValue;
            vc.liulanCount = liulanCount.intValue;
            vc.index = _index_id;
            vc.day = self.day;
            vc.rewardCount = _rewardNumber;
            vc.rewardType = _reward_type;
            vc.rewardValue = _reward_value;
        }

        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([valueStr hasPrefix:@"type2"])//小外套 连衣裙
    {
        [self OpenDb];
        
        NSMutableString *shopcode = [NSMutableString stringWithFormat:@"%@",valueStr];
        NSArray *typeArr = [shopcode componentsSeparatedByString:@"="];
        NSString *idStr = [typeArr lastObject];
        
        NSDictionary *type2Dic = [self FindNameForTPYEDB:idStr];
        
        NSString *ID = type2Dic[@"id"];
        NSString *title = type2Dic[@"name"];
        if(idStr.intValue == 11 && ID==nil)
        {
            ID = @"11";
            title = @"短外套";
        }
        
        if (ID != nil) {
            
            TFSearchViewController *svc = [[TFSearchViewController alloc] init];
            svc.parentID = ID;
            svc.shopTitle = title;
            svc .bannerImage = [self getIconFromShopGroupList:model];;
            svc.isTiXian = isTiXian;

            if(!model.isfinish)
            {
                svc.randomNum = liulanCount.intValue;
                svc.index = _index_id;
                svc.day = self.day;
                svc.rewardCount = _rewardNumber;
                svc.rewardType = _reward_type;
                svc.rewardValue = _reward_value;
                svc.isbrowse = YES;
                svc.shopTitle = @"浏览有奖";
                svc.isCrazy = YES;
            }
            svc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:svc animated:YES];
        }
    }else if ([valueStr hasPrefix:@"favorite"] || [valueStr hasPrefix:@"fix_price"] ||[valueStr hasPrefix:@"style"] || [valueStr rangeOfString:@"tag_info"].length>0 || [valueStr hasPrefix:@"type1"])//筛选
    {
        TFScreenViewController *screen = [[TFScreenViewController alloc]init];
        screen.muStr = valueStr;
        screen.index = 1;
        screen.titleText = model.app_name.length>0?model.app_name:@"筛选结果";
        screen.comefrom = @"任务";
        screen.isTiXian = isTiXian;

        if([valueStr hasPrefix:@"type1"])
        {
            NSArray *arr = [valueStr componentsSeparatedByString:@"="];
            if(arr.count>=2)
            {
                screen.index = 4;
                screen.type1 = arr[1];
                screen.type_name = model.app_name;
            }
        }

        if(!model.isfinish)
        {
            screen.randomNum = liulanCount.intValue;
            screen.indexid = _index_id;
            screen.day = self.day;
            screen.rewardCount = _rewardNumber;
            screen.rewardType = _reward_type;
            screen.rewardValue = _reward_value;
            screen.isbrowse = YES;
            screen.titleText = @"浏览有奖";
        }

        screen.bannerImage = [self getIconFromShopGroupList:model];
        screen.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:screen animated:YES];
    }
    else if([valueStr isEqualToString:@"type_name=热卖&notType=true"] || [valueStr isEqualToString:@"collection=shop_home"])//热卖
    {
        TaskCollectionVC *vc = [[TaskCollectionVC alloc]init];
        vc.typeID = [NSNumber numberWithInt:6];
        vc.typeName = @"热卖";
        vc.title = @"热卖";
        vc.hidesBottomBarWhenPushed = YES;
        vc.bannerImage = [self getIconFromShopGroupList:model];
        
        NSMutableDictionary *Browsedic = [NSMutableDictionary dictionary];
        [Browsedic setObject:_dataArray forKey:@"data"];
        [Browsedic setObject:_motaskIDList forKey:@"motaskList"];
        [Browsedic setObject:_finishtaskList forKey:@"finishtaskList"];
        [Browsedic setObject:[NSString stringWithFormat:@"%d",1]forKey:@"selectSigntag"];
        if(!model.isfinish)
        {
            vc.rewardType = _reward_type;//3优惠卷//4积分//5现金
            vc.rewardValue = _reward_value;
            vc.Browsedic = Browsedic;
            vc.index = _index_id;
            vc.day = self.day;
            vc.rewardCount = _rewardNumber;
            vc.bannerImage = [self getIconFromShopGroupList:model];
            vc.isbrowse = YES;
            //何波加的
            vc.randomNum = liulanCount.intValue;
        }

        [self.navigationController pushViewController:vc animated:YES];
    }else if([valueStr hasPrefix:@"share=myq"])//show社区
    {
        HotOutfitViewController *hot = [[HotOutfitViewController alloc]init];
        hot.hidesBottomBarWhenPushed = YES;
        hot.isLiulan = YES;
        hot.isTiXian = isTiXian;
        hot.index = _index_id;
        hot.day = self.day;
        [self.navigationController pushViewController:hot animated:YES];
    }
    else//原强制浏览
    {
        NSString *broseCount = liulanCount;
        NSString *rewardtype = _reward_type;
        [self goLedBrowse:rewardtype BroseCount:broseCount.intValue Index:_index_id Day:self.day Taskmodel:model];
    }
}

- (NSString*)getIconFromShopGroupList:(TaskModel*)model
{
    NSString *icostr = @"";
    for(NSDictionary *shopdic in self.shopGroupList)
    {
        if([model.icon isEqualToString:[NSString stringWithFormat:@"%@",shopdic[@"id"]]])
        {
//            icostr = [NSString stringWithFormat:@"%@",shopdic[@"banner"]];
            icostr = shopdic[@"banner"];
        }
    }
    return icostr;
}
//浏览分钟数
- (void)liulanDapei:(TaskModel*)model
{
    
    NSString *value1 = @"";
    NSString *value2 = @"1";
    
    NSMutableString *valuestr = [NSMutableString stringWithFormat:@"%@",model.value];
    NSArray *valueArr = [valuestr componentsSeparatedByString:@","];
    if(valueArr.count >= 2)
    {
        value1 = valueArr[0];
        value2 = valueArr[1];
    }else{
        value1 = valueArr[0];
    }
    
    if([value1 hasPrefix:@"type1"])
    {
        NSString *ss = [value1 substringFromIndex:6];
        NSString *name = @"";
        NSString *title = @"";
        switch (ss.intValue) {
            case 0:
                name = @"搭配购";
                title = @"【时尚搭配】";
                break;
            case 1:
                name = @"外套";
                title = @"【甜心的外套】";
                break;
            case 2:

                name = @"上衣";
                title = @"【宝宝的上衣】";
                break;
            case 3:

                name = @"裙子";
                title = @"【仙女的裙子】";
                break;
            case 4:

                name = @"裤子";
                title = @"【萌妹的裤子】";
                break;
            case 5:

                name = @"";
                title = @"";
                break;
            case 6:

                name = @"热卖";
                title = @"【最热销单品】";
                break;
            case 7:

                name = @"套装";
                title = @"【女王的套装】";
                break;
            case 8:

                name = @"上新";
                title = @"【潮流新品】";
                break;
  
                
            default:
                break;
        }
        
        if(ss.intValue == 0)//搭配购
        {
            TFCollocationViewController *testVC = [[TFCollocationViewController alloc] init];
            testVC.typeName = @"搭配";
            testVC.pushType = PushTypeSign;
            testVC.isFinish = model.isfinish;
            testVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:testVC animated:YES];
        }else{//热卖
            TaskCollectionVC *vc = [[TaskCollectionVC alloc]init];
            vc.typeID = [NSNumber numberWithInt:ss.intValue];
            vc.typeName = name;
            vc.bannerImage = [self getIconFromShopGroupList:model];
            vc.title = title;
            vc.isbrowse = YES;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else if ([value1 isEqualToString:@"collection=shop_activity"])//活动商品
    {
        TFActivityShopVC *vc = [[TFActivityShopVC alloc]init];
        vc.isLiulan = YES;
        vc.bannerImage = [self getIconFromShopGroupList:model];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([value1 isEqualToString:@"collection=collocation_shop"])//搭配购
    {
        TFCollocationViewController *testVC = [[TFCollocationViewController alloc] init];
        testVC.typeName = @"搭配";
        testVC.pushType = PushTypeSign;
        testVC.isFinish = model.isfinish;
        testVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:testVC animated:YES];
    }else if ([value1 isEqualToString:@"collection=csss_shop"])//专题
    {
        
        TFCollocationViewController *subVC = [[TFCollocationViewController alloc] init];
        subVC.page = 0;
        subVC.typeName = @"专题";
        subVC.typeID = [NSNumber numberWithInt:2];
        subVC.isFinish = model.isfinish;
        subVC.pushType = PushTypeSign;
        subVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:subVC animated:YES];

    }
    else if ([value1 hasPrefix:@"type2"])
    {
        [self OpenDb];
        
        NSMutableString *shopcode = [NSMutableString stringWithFormat:@"%@",value1];
        NSArray *typeArr = [shopcode componentsSeparatedByString:@"="];
        NSString *idStr = [typeArr lastObject];
        
        NSDictionary *type2Dic = [self FindNameForTPYEDB:idStr];
    
        NSString *ID = type2Dic[@"id"];
        NSString *title = type2Dic[@"name"];
        
        if (ID != nil) {
            
            TFSearchViewController *svc = [[TFSearchViewController alloc] init];
            svc.parentID = ID;
            svc.shopTitle = title;
            svc.isCrazy = YES;
            svc.bannerImage = [self getIconFromShopGroupList:model];
            svc.isliulan = model.isfinish==NO?YES:NO;
            svc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:svc animated:YES];
        }
    }else if ([value1 isEqualToString:@"collection=shopping_page"])//购物界面
    {
        SearchTypeViewController *searchShopping = [[SearchTypeViewController alloc]init];
        searchShopping.is_pushCome = YES;
        searchShopping.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:searchShopping animated:YES];

    }else if([value1 isEqualToString:@"type_name=热卖&notType=true"])//热卖
    {
        TaskCollectionVC *vc = [[TaskCollectionVC alloc]init];
        vc.typeID = [NSNumber numberWithInt:6];
        vc.typeName = @"热卖";
        vc.title = @"热卖";
        vc.isbrowse = YES;
        vc.hidesBottomBarWhenPushed = YES;
        vc.bannerImage = [self getIconFromShopGroupList:model];
        [self.navigationController pushViewController:vc animated:YES];
    
    }else if ([value1 isEqualToString:@"share=myq"])//SHOW社区
    {
        TFIntimateCircleVC *circle = [[TFIntimateCircleVC alloc]init];
        circle.is_pushCome = YES;
        circle.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:circle animated:YES];
        
    }
    else{//其它合集(通勤名媛)
       
        TFScreenViewController *screen = [[TFScreenViewController alloc]init];
        screen.muStr = value1;
        screen.index = 1;
        screen.comefrom = @"任务";
        screen.isliulan = model.isfinish==NO?YES:NO;
        NSString *namestr = [NSString stringWithFormat:@"%@",model.app_name];
        screen.titleText = namestr;
        screen.bannerImage = [self getIconFromShopGroupList:model];
        screen.hidesBottomBarWhenPushed=YES;
        
        if([value1 hasPrefix:@"type1"])
        {
            NSArray *arr = [value1 componentsSeparatedByString:@"="];
            if(arr.count>=2)
            {
                screen.index = 4;
                screen.type1 = arr[1];
                screen.type_name = model.app_name;
            }
        }

        [self.navigationController pushViewController:screen animated:YES];
    }
    
    if (_Taskmytimer==nil && model.isfinish ==NO) {
        
//        self.mentionCount = value2.intValue*60;
//        self.second = 0;
//        self.minute = value2.intValue;
//        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"is_read"];
        
//        _Taskmytimer = [NSTimer weakTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethod1:) userInfo:model.t_name repeats:YES];
//        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
//        [runLoop addTimer:_Taskmytimer forMode:NSDefaultRunLoopMode];
        
        
//        taskmanager = [TaskTimerManager taskTimerManager];
//        taskmanager.selectTaskList = self.selectTaskList;
//        taskmanager.noFinishTasklist = self.noFinishTasklist;
//        taskmanager.motaskDataArray = _motaskDataArray;
        
        BOOL is_read = [[NSUserDefaults standardUserDefaults] boolForKey:@"is_read"];
        
        if(is_read)
        {
            self.second = [Signmanager SignManarer].now_second;
            self.minute = [Signmanager SignManarer].now_minute;
            self.mentionCount = self.minute*60;
            
        }else{
            taskmanager = [TaskTimerManager taskTimerManager];
            taskmanager.selectTaskList = self.selectTaskList;
            taskmanager.noFinishTasklist = self.noFinishTasklist;
            taskmanager.motaskDataArray = _motaskDataArray;
            
            self.second = 0;
            self.minute = value2.intValue;
            self.mentionCount = value2.intValue*60;
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"is_read"];
            [taskmanager goFinsihTaskTimer:model.t_name Count:self.mentionCount Second:self.second Minute:self.minute Day:self.day];
        }
        
        kWeakSelf(self);
        taskmanager.liulanFinishBlock = ^(BOOL Popup){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakself creatData];//刷新界面
                [Signmanager SignManarer].task_isfinish = YES;//标记此任务完成
            });
        };
    }
}
- (void)finishPopupView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _reward_type = [Signmanager SignManarer].liulan_rewardtype;
        [self setTaskPopMindView:Task_liulanFinish Value:nil Title:nil Rewardvalue:[Signmanager SignManarer].liulan_rewardvalue Rewardnum:(int)[Signmanager SignManarer].liulan_rewardnumber];
        
        [self creatData];//刷新界面
        [Signmanager SignManarer].task_isfinish = YES;//标记此任务完成
    });
}
#pragma mark 浏览多长时间倒计时
- (void)timerFireMethod1:(NSTimer*)timer
{
    id object = timer.userInfo;
    
    self.second--;
    if (self.second==-1 && self.minute >0)
    {
        self.second=59;
        self.minute--;
    }
    
    if (self.second<=0 && self.minute==0) {
        [_Taskmytimer invalidate];
        _Taskmytimer = nil;
        
        NSMutableDictionary *dic= [self getCustomTask:object];
        NSString *index_id = [dic objectForKey:@"index"];
        NSString *day = self.day;
        
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"is_read"];
        [TaskSignModel getTaskHttp:index_id Day:day Success:^(id data) {
            TaskSignModel *model = data;
            if(model.status == 1)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self creatData];//刷新界面
                    
                    _reward_type = [Signmanager SignManarer].liulan_rewardtype;
                    [self setTaskPopMindView:Task_liulanFinish Value:nil Title:nil Rewardvalue:[Signmanager SignManarer].liulan_rewardvalue Rewardnum:(int)[Signmanager SignManarer].liulan_rewardnumber];
                    
                });
                
                //标记此任务完成
                [Signmanager SignManarer].task_isfinish = YES;
                [self finishtaskHttp];
            }
        }];
    }
    
    if(self.minute >=0 && self.second >=0)
    {
        [Signmanager SignManarer].now_minute = self.minute;
        [Signmanager SignManarer].now_second = self.second;
    }
}

#pragma mark 打开数据库
-(BOOL)OpenDb
{
    if(AttrcontactDB)
    {
        return YES;
    }
    
    BOOL result=NO;
    
    /*根据路径创建数据库并创建一个表contact(id nametext addresstext phonetext)*/
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    
    _databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"attr.db"]];
    
    //    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //    if ([filemgr fileExistsAtPath:_databasePath] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        if (sqlite3_open(dbpath, &AttrcontactDB)==SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt;
            
            sql_stmt="CREATE TABLE IF NOT EXISTS ATTDB(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT,PHONE TEXT)";
            
            if (sqlite3_exec(AttrcontactDB, sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK)
            {
                
                result= YES;
            }
        }
        else
        {
            result= NO;
        }
    }
    
    return result;
}

#pragma mark 查询数据库
-(NSDictionary *)FindNameForTPYEDB:(NSString *)findStr
{
    //    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
    if([self OpenDb])
    {
        const char *dbpath = [_databasePath UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT id,name,address,phone,ico,sequence,isshow,groupflag from TYPDB where id=\"%@\"",findStr];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    NSString *ID= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    NSString *name = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    NSString *ico = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                    NSString *sequence = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                    NSString *isShow = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                    NSString *groupflag = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                    
                    [mudic setValue:ID forKey:@"id"];
                    [mudic setValue:name forKey:@"name"];
                    [mudic setValue:ico forKey:@"ico"];
                    [mudic setValue:sequence forKey:@"sequence"];
                    [mudic setValue:isShow forKey:@"isShow"];
                    [mudic setValue:groupflag forKey:@"groupFlag"];
                    
                    break;
                    
                }
                
                sqlite3_finalize(statement);
            }
            sqlite3_close(AttrcontactDB);
        }
        
    }
    
    return mudic;
}

#pragma mark 强制浏览
- (void)goLedBrowse:(NSString*)rewordType BroseCount:(int)randomNum Index:(NSString*)index Day:(NSString*)day Taskmodel:(TaskModel*)model
{
    NSMutableDictionary *Browsedic = [NSMutableDictionary dictionary];
    [Browsedic setObject:_dataArray forKey:@"data"];
    [Browsedic setObject:_motaskIDList forKey:@"motaskList"];
    [Browsedic setObject:_finishtaskList forKey:@"finishtaskList"];
    [Browsedic setObject:[NSString stringWithFormat:@"%d",1]forKey:@"selectSigntag"];
    
    TFLedBrowseShopViewController *lbVC = [[TFLedBrowseShopViewController alloc] init];
    lbVC.isTiXian = model.task_type.intValue == 19;
    if(!model.isfinish)
    {
        lbVC.rewardType = rewordType;//3优惠卷//4积分//5现金
        lbVC.rewardValue = _reward_value;
        lbVC.Browsedic = Browsedic;
        lbVC.index = index;
        lbVC.day = day;
        lbVC.rewardCount = _rewardNumber;
        lbVC.bannerImage = [self getIconFromShopGroupList:model];
        lbVC.isbrowse = YES;
        //何波加的
        lbVC.randomNum = randomNum;
        [lbVC setBrowseFinishBlock:^{ /**< 完成强制浏览 */
            
        } browseFail:^{ /**< 未完成强制浏览 */
            
        }];
    }
    lbVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lbVC animated:YES];
}

#pragma mark 任务名称
- (void)getTitle_image:(TaskModel*)model
{
    NSString *tasktype = model.task_type;
    NSString *imagestr = @"task_icon_Unknown";
    NSString *namestr = @"未知任务";
    NSString *name = @"";
    
    NSMutableString *value = [NSMutableString stringWithFormat:@"%@",model.value];
    NSArray *valueArr = [value componentsSeparatedByString:@","];
    NSString *valueStr = @"0";
    NSString *Count = @"0";
    if(valueArr.count == 1)
    {
        valueStr = valueArr[0];
        Count = valueArr[0];
        
    }else if (valueArr.count >= 2)
    {
        valueStr = valueArr[0];
        Count = valueArr[1];
    }
    
    if([Count intValue] == 0)
    {
        Count = @"1";
    }
    switch (tasktype.intValue) {
        case 0:
            imagestr = @"newtask_icon_shop";//开店
            namestr = @"去开店";
            name = namestr;
            
            break;
        case 1:
            imagestr = @"icon_yaoqinghaoyou";//邀请好友
            namestr = @"邀请好友";
            name = namestr;
            
            break;
        case 2:
            imagestr = @"newtask_icon_duobao";//夺宝
            namestr = @"去抽奖";
            name = namestr;
            
            break;
        case 3:
            imagestr = @"newtask_icon_gouwuche";//加X购物车
            namestr = [NSString stringWithFormat:@"加%d件商品到购物车",[Count intValue]];
            name = @"加购物车";
            break;
        case 4:
            imagestr = @"newtask_icon_liulan";//浏览商品(原强制浏览)
            if(model.app_name == nil)
            {
                model.app_name = @"未知商品";
            }
            namestr = [NSString stringWithFormat:@"浏览%d件【%@】",[Count intValue],model.app_name];
            if([valueStr hasPrefix:@"collection=collocation_shop"])
            {
                namestr = [NSString stringWithFormat:@"浏览%d套【%@】",[Count intValue],model.app_name];
            }
            break;
        case 5:
            imagestr = @"newtask_icon_liulan";//浏览集合
            if(model.app_name == nil)
            {
                model.app_name = @"未知商品";
            }
            namestr = [NSString stringWithFormat:@"浏览【%@】%d分钟",model.app_name,[Count intValue]];
            name = namestr;
            break;
        case 6:
            if(model.app_name == nil)
            {
                 namestr = [NSString stringWithFormat:@"购买%d件商品",[Count intValue]];
            }else{
                if([model.app_name containsString:@"奖励翻倍"])
                {
                    namestr = [NSString stringWithFormat:@"%@",model.app_name];
                }else if([model.app_name hasSuffix:@"商品"])
                {
                    namestr = [NSString stringWithFormat:@"购买%d件%@",[Count intValue],model.app_name];
                }else{
                    namestr = [NSString stringWithFormat:@"购买%d件%@商品",[Count intValue],model.app_name];
                }
            }
            namestr = model.task_class.intValue==4?@"购买赢提现":namestr;
            imagestr = @"newtask_icon_goumai";//购买X商品
            name = @"购买几件商品";

            break;
        case 7:
            imagestr = @"newtask_icon_fenxiang";//分享x件商品
//            namestr = [NSString stringWithFormat:@"分享%d件商品",[Count intValue]];
            if(model.app_name == nil)
            {
                model.app_name = @"未知商品";
            }
            if([valueStr hasPrefix:@"share=indiana"] || [valueStr hasPrefix:@"share=h5money"] || [valueStr hasPrefix:@"share=spellGroup"])
            {
                namestr = [NSString stringWithFormat:@"%@",model.app_name];
            }else{
                namestr = [NSString stringWithFormat:@"分享%d件【%@】",[Count intValue],model.app_name];
            }
            
            name = @"分享几件商品";
            break;
        case 701:
            imagestr = @"newtask_icon_yuefanbei";//分享商品（余额翻倍）
            namestr = @"分享商品余额翻倍";
            name = namestr;
            break;
        case 702:
            imagestr = @"newtask_icon_jinbi-";//分享商品（积分升级）
            namestr = @"分享商品积分升级为金币";
            name = namestr;
            break;
        case 703:
            imagestr = @"newtask_icon_jinquanquan";//分享商品（优惠券升级）
            namestr = @"分享商品优惠券升级为金券";
            name = namestr;
            break;
        case 8:
            imagestr = @"newtask_icon_fenxiang";//分享搭配购
            namestr = @"分享1套【时尚搭配】";
            name = namestr;
            
            break;
        case 801:
            imagestr = @"newtask_icon_yuefanbei";//分享搭配购（余额翻倍）
            namestr = @"分享商品余额翻倍";
            name = namestr;
            
            break;
        case 802:
            imagestr = @"newtask_icon_jinbi-";//分享搭配购（积分升级）
            namestr = @"分享商品积分升级为金币";
            name = namestr;
            
            break;
        case 803:
            imagestr = @"newtask_icon_jinquanquan";//分享搭配购（优惠券升级）
            namestr = @"分享商品优惠券升级为金券";
            name = namestr;
            
            break;
        case 9:
            imagestr = @"newtask_icon_miandan";//免单
            namestr = @"你时尚我买单!";
            name = namestr;
            
            break;
        case 10:
            imagestr = @"newtask_icon_xihao";//设置喜好
            namestr = @"设置我的喜好";
            name = namestr;
            break;
            
        case 11:
            imagestr = @"newtask_icon_meiyi";//精选推荐
            namestr = @"去精选推荐挑选美衣";
            name = namestr;
            
            break;
        case 12:
            imagestr = @"newtask_icon_liulan";//穿搭
            namestr = [NSString stringWithFormat:@"浏览%d条热门穿搭",[Count intValue]];
            name = namestr;

            break;
        case 13:
            imagestr = @"newtask_icon_fenxiang";//分享一件品质美衣
            namestr = @"分享一件品质美衣";
            name = namestr;
            
            break;
        case 14:
            imagestr = @"newtask_icon_fenxiang";//分享一条热门穿搭话题
            namestr = @"分享一条热门穿搭话题";
            name = namestr;
            break;
        case 15:
            imagestr = @"task_icon_jizan";//分享一件品质美衣
            namestr = @"继续为好友点赞";
            name = namestr;
            
            break;
        case 16:
            imagestr = @"task_icon_jizan";//分享一件品质美衣
            namestr = model.task_class.intValue==4?@"集赞赢提现":@"分享邀请好友集赞";
            name = namestr;
            
            //分享集赞获得的奖励
            if(self.fxqd == nil)
            {
                NSString *fxqd = [self taskrawardHttp:@"集赞"];
                self.fxqd = [fxqd floatValue]>0?fxqd:@"5";
            }

            break;
        case 18:
            imagestr = @"task_icon_pintuan";//开团
            namestr = @"去拼团";
            name = namestr;
            
            break;
            
        case 17:
            imagestr = @"task_icon_pintuan";//参团
            namestr = @"我参与的超级拼团";
            name = namestr;
            
            break;
        case 19:
            imagestr = @"newtask_icon_liulan";//浏览10件
            namestr = @"浏览赢提现";
            name = namestr;
            
            break;
        case 20:
            imagestr = @"newtask_icon_fenxiang";//分享10件
            namestr = @"分享赢提现";
            name = namestr;
            break;
        case 21:
            imagestr = @"newtask_icon_duobao";//夺宝赢提现
            namestr = @"抽奖赢提现";
            name = namestr;

            break;
        case 22:
            imagestr = @"newtask_icon_duobao";//拼团夺宝
            namestr = @"超级0元团";
            name = namestr;

            break;
        case 23:
            imagestr = @"task_icon_honbaoyu";//千元红包雨
            namestr = @"千元红包雨";
            name = namestr;
            break;
        case 24:
            namestr = [self taskrawardHttp:@"奖励翻倍"];
            imagestr = @"icon_fandouble";//购买X商品
            name = @"购买几件商品";
        
            break;
        case 25:
            imagestr = @"newtask_icon_fenxiang";//分享x件商品
            namestr = @"分享赢提现";
            name = namestr;
            break;
        case 26:
            imagestr = @"icon_choujiang";//去抽奖
            namestr = @"幸运转盘";
            name = namestr;
            break;
            
        case 27:
            imagestr = @"icon_choujiang";//余额抽提现
            namestr = @"余额抽提现";
            name = namestr;
            break;
        case 28:
            imagestr = @"icon_0yuangou";//超级0元购
            namestr = @"超级0元购";
            name = namestr;
            break;
        case 30:
            imagestr = @"icon_fenxiangri";//超级分享日
            namestr = model.app_name?model.app_name:@"超级分享日";
            
            name = namestr;
            break;
        case 31:
            imagestr = @"icon_yaoqinghaoyou";//好友赢提现
            namestr = model.app_name?model.app_name:@"好友赢提现";
            name = namestr;
            break;
        case 32:
            imagestr = @"icon_yaoqinghaoyou";//分享赚钱任务页
            namestr = model.app_name?model.app_name:@"分享赚钱任务页";
            name = namestr;
            break;

        case 999://疯狂星期一
            imagestr = @"monday_icon_xinyijie";
            namestr = @"疯狂新衣节";
            name = @"疯狂新衣节";
            break;
            
        default:
            break;
    }
    
    model.imagestr = imagestr;
    model.t_name = namestr;
    model.name = name;
}

#pragma mark 奖励类型
- (void)rewardType:(TaskModel*)model
{
    NSString *t_id = model.t_id;
    NSString *task_id = @"";
    NSString *type_id = @"";
    NSString *value   = @"";
    
    for(NSDictionary *taskdic in _motaskDataArray)
    {
        task_id = [NSString stringWithFormat:@"%@",taskdic[@"t_id"]];
        if([t_id isEqualToString:task_id])
        {
            type_id = [NSString stringWithFormat:@"%@",taskdic[@"type_id"]];
            value   = [NSString stringWithFormat:@"%@",taskdic[@"value"]];
            
            [self getRewardtype:type_id RewardValue:value TaskModel:model];

            break;
        }
    }
}

- (void)getRewardtype:(NSString*)type_id RewardValue:(NSString*)value TaskModel:(TaskModel*)model
{
    NSString *namestr = @"";
    
    switch (type_id.intValue) {
        case 1://补签卡
            namestr = DAILY_TASK_BUQIAN;
            
            break;
        case 2://0元疯抢
            namestr = DAILY_TASK_ZERO;
            break;
        case 3://优惠券
            namestr = DAILY_TASK_YOUHUI;
        
            break;
        case 4://积分
            namestr = DAILY_TASK_JIFEN;
            
            break;
        case 5://现金
            namestr = DAILY_TASK_XIANJING;
            
            break;
        case 6://开店奖励
            namestr = DAILY_TASK_STORE;
            
            break;
        case 7://夺宝
            namestr = DAILY_TASK_DUOBAO;
            
            break;
        case 8://余额翻倍
            namestr = DAILY_TASK_DOUBLE;
            
            break;
        case 9://积分升级金币
            namestr = DAILY_JIFEN_GOLD;
            
            break;
        case 10://优惠券升级金券
            namestr = DAILY_YOUHUI_GOLDCOUPONS;
            
            break;
        case 11:
            namestr = DAILY_TASK_YIDOU;
            
            break;
            
        case 12:
            namestr = DAILY_TASK_TIXIAN;
            
            break;
   
        default:
            break;
    }
    
    if(model.task_type.intValue == 3)//加购物车
    {
        [Signmanager SignManarer].reward_type = namestr;
        [Signmanager SignManarer].reward_value = value;
        [Signmanager SignManarer].rewardNumber = [model.num intValue];//分几次奖励
        [Signmanager SignManarer].index_id = model.index;//任务下标
        [Signmanager SignManarer].task_value = model.value;//任务值
    }else if (model.task_type.intValue == 1 || model.task_type.intValue == 16)//邀请好友
    {
        _reward_type = namestr;
        _reward_value = value;
        _rewardNumber = [model.num intValue];
        
        [Signmanager SignManarer].share_day = self.day;
        [Signmanager SignManarer].share_indexid = model.index;

    }else if (model.task_type.intValue == 5 )
    {
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"is_read"] == NO)
        {
            [Signmanager SignManarer].liulan_rewardvalue = value;
            [Signmanager SignManarer].liulan_rewardtype = namestr;
            [Signmanager SignManarer].liulan_rewardnumber = [model.num intValue];
        }
    }else if (model.task_type.intValue == 12)
    {
        [Signmanager SignManarer].topic_day = self.day;
        [Signmanager SignManarer].topic_indexid = model.index;
        [Signmanager SignManarer].topic_type = namestr;
        [Signmanager SignManarer].topic_value = value;
        [Signmanager SignManarer].topic_liulanNumber = model.value.integerValue; // 需要浏览几次
        [Signmanager SignManarer].topic_rewardNumber = [model.num intValue];    //分几次奖励
    }else if (model.task_type.intValue == 11)
    {
        [Signmanager SignManarer].reward_type = namestr;
        [Signmanager SignManarer].reward_value = value;
        [Signmanager SignManarer].recommend_day = self.day;
        [Signmanager SignManarer].recommend_indexid = model.index;
    }else if (model.task_type.intValue == 13 || model.task_type.intValue == 14)
    {
        _reward_type = namestr;
        _reward_value = value;
        _rewardNumber = [model.num intValue];

        [Signmanager SignManarer].share_day = self.day;
        [Signmanager SignManarer].share_indexid = model.index;
    }else if (model.task_type.intValue == 17 || model.task_type.intValue == 18)
    {
        [Signmanager SignManarer].fight_day = self.day;
        [Signmanager SignManarer].fight_indexid = model.index;
    }
    else{
        _reward_type = namestr;
        _reward_value = value;
        _rewardNumber = [model.num intValue];
        _index_id = model.index;
        _task_value = model.value;
    }
}

#pragma mark 获取当前正在完成的任务
- (NSMutableDictionary*)getCustomTask:(NSString*)task_type
{
    NSString *index = @"";
    NSString *task_value = @"";
    NSString *rewardNumber = @"";
    NSString *reward_value = @"";
    
    for(NSDictionary *dic in self.selectTaskList)
    {
        NSString *index_id = [dic objectForKey:task_type];
        for(NSDictionary *taskdic in _noFinishTasklist)
        {
            NSString *ind = [NSString stringWithFormat:@"%@",taskdic[@"index"]];
            
            if([ind isEqualToString:index_id])
            {
                index = taskdic[@"index"];
                task_value = taskdic[@"value"];//任务值
                rewardNumber = taskdic[@"num"];//分几次奖励
                
                NSString *t_id = [NSString stringWithFormat:@"%@",taskdic[@"t_id"]];
                NSString *task_id = @"";
//                NSString *type_id = @"";
                NSString *value   = @"";
                
                for(NSDictionary *taskdic in _motaskDataArray)
                {
                    task_id = [NSString stringWithFormat:@"%@",taskdic[@"t_id"]];
                    if([t_id isEqualToString:task_id])
                    {
//                        type_id = [NSString stringWithFormat:@"%@",taskdic[@"type_id"]];
                        value   = [NSString stringWithFormat:@"%@",taskdic[@"value"]];
                        
                        reward_value = value;

                        break;
                    }
                }

                break;
            }
        }
    }

    NSMutableDictionary *taskdic = [NSMutableDictionary dictionary];
    [taskdic setObject:index forKey:@"index"];
    [taskdic setObject:task_value forKey:@"task_value"];
    [taskdic setObject:rewardNumber forKey:@"rewardNumber"];
    [taskdic setObject:reward_value forKey:@"reward_value"];
    
    return taskdic;
}

#pragma mark *************************开店**********************
#pragma mark 完成任务后弹框(旧的)
-(void)creatSharePopView:(NSString*)str
{
    _SharePopview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    
    _SharePopview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _SharePopview.userInteractionEnabled = YES;
    UITapGestureRecognizer *dismistap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissclick:)];
    [_SharePopview addGestureRecognizer:dismistap];
    
    CGFloat spaceHeigh = 0;
    CGFloat invitcodeYY = ZOOM(420);
    if([str isEqualToString:DAILY_TASK_XIANJING])
    {
        spaceHeigh = ZOOM(50*3.4);
        invitcodeYY = ZOOM(420) - spaceHeigh/2;
    }else if ([str isEqualToString:DAILY_EXTRA_BONUS])
    {
        spaceHeigh = ZOOM6(60);
        invitcodeYY = ZOOM(450) - spaceHeigh/2;
        if(iPhone6plus)
        {
            invitcodeYY = ZOOM(480) - spaceHeigh/2;
        }
    }
    else if ([str isEqualToString:DAILY_TASK_STORE])
    {
        invitcodeYY = (kScreenHeight - ZOOM6(880))/2;
    }
    
    //弹框内容
    _ShareInvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(120), invitcodeYY, kScreenWidth-ZOOM(120)*2, kScreenHeight-invitcodeYY*2)];
    [_SharePopview addSubview:_ShareInvitationCodeView];
    
    
    //关闭按钮
    CGFloat btnwidth = IMGSIZEW(@"icon_close1");
    
    _Sharecanclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _Sharecanclebtn.frame=CGRectMake(CGRectGetWidth(_ShareInvitationCodeView.frame)-btnwidth, 0, btnwidth, btnwidth);
    [_Sharecanclebtn setImage:[UIImage imageNamed:@"icon_close1"] forState:UIControlStateNormal];
    _Sharecanclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    _Sharecanclebtn.layer.cornerRadius=btnwidth/2;
    [_Sharecanclebtn addTarget:self action:@selector(SharetapClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGFloat imgHeigh = IMGSIZEH(@"-congratulation");
    
    if([str isEqualToString:DAILY_EXTRA_BONUS] || [str isEqualToString:DAILY_TASK_STORE])
    {
        _SharebackView = [[UIView alloc]initWithFrame:CGRectMake(0,imgHeigh/2, kScreenWidth-ZOOM(120)*2, CGRectGetHeight(_ShareInvitationCodeView.frame)-imgHeigh/2)];
        _SharebackView.backgroundColor=[UIColor whiteColor];
        _SharebackView.layer.cornerRadius=5;
        _SharebackView.clipsToBounds = YES;
        [_ShareInvitationCodeView addSubview:_SharebackView];
        
        
        _SharetitleImg = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(_ShareInvitationCodeView.frame)-imgHeigh*3)/2, 0, imgHeigh*3, imgHeigh)];
        _SharetitleImg.image = [UIImage imageNamed:@"-congratulation"];
        [_ShareInvitationCodeView addSubview:_SharetitleImg];
        
    }
    
    //弹框内容
    [self creatshare:str];
    
    [self.view addSubview:_SharePopview];
    
    _ShareInvitationCodeView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _ShareInvitationCodeView.alpha = 0.5;
    
    _SharePopview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _SharePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        _ShareInvitationCodeView.transform = CGAffineTransformMakeScale(1, 1);
        _ShareInvitationCodeView.alpha = 1;
        
    } completion:^(BOOL finish) {
        
    }];
    
}

- (void)creatshare:(NSString*)typestr
{
    CGFloat headimageW = IMGSIZEW(@"qiandao_3yuan");;
    CGFloat headimageH = IMGSIZEH(@"qiandao_3yuan");
    CGFloat headimageY = ZOOM(30*3.4);
    if([typestr isEqualToString:DAILY_TASK_DUOBAO])
    {
        headimageY = ZOOM(50*3.4);
    }
    
    CGFloat titlelagHeigh = 20;
    if([typestr isEqualToString:DAILY_TASK_STORE])
    {
        titlelagHeigh = 0;
        headimageY = ZOOM6(60);
    }
    
    
    UIImageView *headimage = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(_SharebackView.frame)-headimageW)/2, headimageY, headimageW, headimageH)];
    headimage.image = [UIImage imageNamed:@"get-head"];
    [_SharebackView addSubview:headimage];
    
    
    UILabel *titlelab1 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(headimage.frame)+titlelagHeigh, CGRectGetWidth(_SharebackView.frame)-40, ZOOM(20*3.4))];
    titlelab1.textColor = tarbarrossred;
    titlelab1.textAlignment = NSTextAlignmentCenter;
    titlelab1.font = [UIFont systemFontOfSize:ZOOM(51)];
    
    UILabel *titlelab2 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(titlelab1.frame), CGRectGetWidth(_SharebackView.frame)-40, ZOOM(40*3.4))];
    titlelab2.textColor = tarbarrossred;
    titlelab2.textAlignment = NSTextAlignmentCenter;
    titlelab2.font = [UIFont systemFontOfSize:ZOOM6(28)];
    
    if([typestr isEqualToString:DAILY_TASK_DOUBLE])
    {
        titlelab2.font = [UIFont systemFontOfSize:ZOOM6(28)];
    }else if ([typestr isEqualToString:DAILY_EXTRA_BONUS])
    {
        
        titlelab1.frame = CGRectMake(20, ZOOM(30*3.4),CGRectGetWidth(_SharebackView.frame)-2*20,ZOOM(40*3.4));
        
        headimage.frame = CGRectMake((CGRectGetWidth(_SharebackView.frame)-headimageW)/2, CGRectGetMaxY(titlelab1.frame)+20,headimageW, headimageH);
        
        titlelab2.frame = CGRectMake(20, CGRectGetMaxY(headimage.frame)+ZOOM6(40),CGRectGetWidth(titlelab1.frame), ZOOM6(40));
        titlelab2.font = [UIFont systemFontOfSize:ZOOM6(30)];
    }
    
    titlelab2.textColor = kTextColor;
    titlelab2.numberOfLines = 0;
    
    //按钮
    CGFloat gobtnWidth = (CGRectGetWidth(_SharebackView.frame)-2*30-20)/2;
    CGFloat gobtnHeigh = ZOOM(36*3.4);
    
    
    CGFloat spaceHeigh = 0;
    
    for(int k =0;k<2;k++)
    {
        UIButton *gobtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        gobtn.frame = CGRectMake(30+(gobtnWidth+20)*k, CGRectGetMaxY(titlelab2.frame)+ZOOM6(20) +spaceHeigh, gobtnWidth, gobtnHeigh);
        gobtn.backgroundColor = tarbarrossred;
        gobtn.clipsToBounds = YES;
        gobtn.tag = 8888+k;
        gobtn.layer.cornerRadius = 5;
        [gobtn setTintColor:[UIColor whiteColor]];
        
        
        [self buttontitle:typestr button:gobtn Image:headimage Lab1:titlelab1 Lab2:titlelab2];
        
        gobtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(51)];
        [gobtn addTarget:self action:@selector(goClick:) forControlEvents:UIControlEventTouchUpInside];
        [_SharebackView addSubview:gobtn];
    }
    
    [_SharebackView addSubview:titlelab1];
    [_SharebackView addSubview:titlelab2];
}

- (void)buttontitle:(NSString*)type button:(UIButton*)mybtn Image:(UIImageView*)headimage Lab1:(UILabel*)lab1 Lab2:(UILabel*)lab2
{
    
    NSString *value = @"1";
    MyLog(@"value = %@",value);
    mybtn.hidden = NO;
    
     if ([type isEqualToString:DAILY_TASK_STORE])//开店
    {
        if(mybtn.tag == 8889)
        {
            [mybtn setTitle:@"查余额" forState:UIControlStateNormal];
            mybtn.backgroundColor = [UIColor clearColor];
            mybtn.tintColor = tarbarrossred;
            mybtn.layer.borderColor = tarbarrossred.CGColor;
            mybtn.layer.borderWidth=1;
        }else{
            [mybtn setTitle:@"买买买" forState:UIControlStateNormal];
        }
        
        headimage.image = [UIImage imageNamed:@"money_0"];
        lab1.text = @"开店成功";
        if(_Myvalue !=nil)
        {
            value = _Myvalue;
        }
        
        lab2.text = [NSString stringWithFormat:@"%@",@"开店现金奖励已经存入余额，立即开启余额翻3倍特权，购买美衣更实惠喔~"];
        [self creatDoubleView];
        
        //余额翻倍倍数
        [DataManager sharedManager].twofoldness = [value integerValue];
        
    }
    else if ([type isEqualToString:DAILY_EXTRA_BONUS])
    {
        
        headimage.image = [UIImage imageNamed:@"money_0"];
        
        lab1.numberOfLines = 0;
        lab1.text = [NSString stringWithFormat:@"分享获得\n%@元额外奖励哦~",self.bonusMoney];
        
        lab2.text = @"再接再厉,领取下一轮大奖喔~";
        lab2.textAlignment = NSTextAlignmentCenter;
        
        if(mybtn.tag == 8888)
        {
            [mybtn setTitle:@"查看奖励" forState:UIControlStateNormal];
            mybtn.backgroundColor = [UIColor clearColor];
            mybtn.tintColor = tarbarrossred;
            mybtn.layer.borderColor = tarbarrossred.CGColor;
            mybtn.layer.borderWidth=1;
            
        }else{
            [mybtn setTitle:@"买买买~" forState:UIControlStateNormal];
        }
        
    }
}

#pragma mark 弹框消失
-(void)dismissclick:(UITapGestureRecognizer*)tap
{
    [self SharetapClick];
}

#pragma mark 翻倍视图
- (void)creatDoubleView
{
    UIView *doubleView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_ShareInvitationCodeView.frame)-ZOOM6(240), CGRectGetWidth(_ShareInvitationCodeView.frame), ZOOM6(180))];
    doubleView.backgroundColor = RGBCOLOR_I(255, 248, 223);
    [_ShareInvitationCodeView addSubview:doubleView];
    
    UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(0, ZOOM6(40), CGRectGetWidth(doubleView.frame), ZOOM6(30))];
    titlelable.text = @"您已获得24小时余额翻倍特权";
    titlelable.font = [UIFont systemFontOfSize:ZOOM6(30)];
    titlelable.textColor = RGBCOLOR_I(255, 170, 0);
    titlelable.textAlignment = NSTextAlignmentCenter;
    [doubleView addSubview:titlelable];
    
    UIButton *goDoublebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    goDoublebtn.frame = CGRectMake((doubleView.frame.size.width-ZOOM6(240))/2, CGRectGetMaxY(titlelable.frame)+ZOOM6(12), ZOOM6(240), ZOOM6(60));
    goDoublebtn.layer.borderWidth = 1;
    goDoublebtn.layer.borderColor = RGBCOLOR_I(255, 170, 0).CGColor;
    goDoublebtn.layer.cornerRadius = ZOOM6(60)/2;
    
    [goDoublebtn addTarget:self action:@selector(godouble) forControlEvents:UIControlEventTouchUpInside];
    [doubleView addSubview:goDoublebtn];
    
    UILabel *btnlable = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), ZOOM6(10), ZOOM6(160), ZOOM6(40))];
    btnlable.text = @"立即开启";
    btnlable.textColor = RGBCOLOR_I(255, 170, 0);
    btnlable.font = [UIFont systemFontOfSize:ZOOM6(30)];
    btnlable.textAlignment = NSTextAlignmentCenter;
    [goDoublebtn addSubview:btnlable];
    
    UIImageView *btnImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btnlable.frame), ZOOM6(10), ZOOM6(40), ZOOM6(40))];
    btnImage.image = [UIImage imageNamed:@"icon_go_yellow"];
    [goDoublebtn addSubview:btnImage];
    
    
    UIImageView *baseImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_ShareInvitationCodeView.frame)-ZOOM6(60), CGRectGetWidth(doubleView.frame), ZOOM6(60))];
    baseImg.image = [UIImage imageNamed:@"fanbei_bg"];
    [_ShareInvitationCodeView addSubview:baseImg];
    
    _storetimelable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(baseImg.frame), CGRectGetHeight(baseImg.frame))];
    _storetimelable.text = @" ";
    _storetimelable.textAlignment = NSTextAlignmentCenter;
    _storetimelable.textColor = [UIColor whiteColor];
    _storetimelable.font = [UIFont systemFontOfSize:ZOOM6(24)];
    [baseImg addSubview:_storetimelable];
}

#pragma mark 开启余额翻倍
- (void)godouble
{
    [self doubleSuccessEntrance:1];
    [self SharetapClick];
}

- (void)doubleSuccessEntrance:(int)entrance
{
    if(RemindView.RemindBtn.selected == NO)
    {
        [DoubleModel getDoubleEntrance:entrance Sucess:^(id data) {
            DoubleModel *model = data;
            if(model.status == 1)
            {
                MyLog(@"开启成功");
                RemindView.RemindBtn.selected=YES;
                [DataManager sharedManager].isOpen = YES;
                
                YFDoubleSucessVC *vc = [[YFDoubleSucessVC alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                MyLog(@"开启失败");
                RemindView.RemindBtn.selected=NO;
                [DataManager sharedManager].isOpen = NO;
                
            }
        }];
    }
    
}

#pragma mark 余额翻倍倒计时
- (void)timerFireMethod:(NSTimer*)timer
{
    NSString *nowtime = timer.userInfo;
    
    if(nowtime !=nil)
    {
        _timeCount ++;
    }
    
    NSString *endtime = [NSString stringWithFormat:@"%lld",[DataManager sharedManager].endDate];
    
    NSArray*timeArray= [MyMD5 timeCountDown:_mytimer Nowtime:nowtime Endtime:endtime Count:_timeCount];
    
    NSString *timestr;
    if(timeArray.count)
    {
        
        if([timeArray[0] intValue]==0&&[timeArray[1] intValue]==0
           &&[timeArray[2] intValue]==0&&[timeArray[3] intValue]==0)
        {
            [self requestHttp];
            timestr = [NSString stringWithFormat:@"距余额翻倍结束还剩: %@ 时 %@ 分 %@ 秒",@"0",@"0",@"0"];
            
            [DataManager sharedManager].isOligible = NO;
            [DataManager sharedManager].isOpen = NO;
            
            
            [UIView animateWithDuration:0.5 animations:^{
                
                RemindView.frame =CGRectMake(0, -100, kScreenWidth, 30);
                
                
            } completion:^(BOOL finish) {
                
                RemindView.hidden = YES;
                
            }];
            
        }else{
            timestr = [NSString stringWithFormat:@"距余额翻倍结束还剩: %@ 时 %@ 分 %@ 秒",timeArray[1],timeArray[2],timeArray[3]];
        }
    }
    
    _storetimelable.text = timestr;
    RemindView.RemindLabel.text = timestr;
}

#pragma mark 弹框点击事件
- (void)goClick:(UIButton*)sender
{
    if(sender.tag == 8889)
    {
        NSString *title = sender.titleLabel.text;
        
        if ([title isEqualToString:@"查看余额"] || [title isEqualToString:@"查余额"])
        {
            MyLog(@"钱包");
            TFMyWalletViewController *wallet = [[TFMyWalletViewController alloc]init];
            wallet.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:wallet animated:YES];
            
        }else if ([title isEqualToString:@"买买买~"])
        {
            Mtarbar.selectedIndex=0;
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
        
        [self SharetapClick];
        
    }else if (sender.tag == 8888)
    {
        
        NSString *title = sender.titleLabel.text;
        
        if ([title isEqualToString:@"买买买"])
        {
            Mtarbar.selectedIndex=0;
            [self.navigationController popToRootViewControllerAnimated:NO];
        }else if ([title isEqualToString:@"查看奖励"])
        {
            
//            [self goFabous:NO];
            [self CFInviteFriends:NO];
        }
    }
    
    [self SharetapClick];
}

#pragma mark 文字高度
-(CGFloat)getRowHeight:(NSString *)text fontSize:(CGFloat)fontSize
{
    CGFloat height = 0;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(CGRectGetWidth(_DiscriptableView.frame) - 70, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    else{
        return height;
    }
    return height;
}

- (NSString*)remindTost:(NSString*)str
{
    NSString *toststr = @"";
    
    if([str hasPrefix:@"type1=0"])
    {
        toststr = @"【时尚搭配】";
        
    }else if ([str hasPrefix:@"type1=1"])
    {
        toststr = @"【甜心的外套】";
        
    }else if ([str hasPrefix:@"type1=2"])
    {
        toststr = @"【宝宝的上衣】";
        
    }else if ([str hasPrefix:@"type1=3"])
    {
        toststr = @"【仙女的裙子】";
        
    }else if ([str hasPrefix:@"type1=4"])
    {
        toststr = @"【萌妹的裤子】";
        
    }else if ([str hasPrefix:@"type1=5"])
    {
        toststr = @"特卖板块";
        
    }else if ([str hasPrefix:@"type1=6"])
    {
        toststr = @"【最热销单品】";
        
    }else if ([str hasPrefix:@"type1=7"])
    {
        toststr = @"【女王的套装】";
        
    }else if ([str hasPrefix:@"type1=8"])
    {
        toststr = @"【潮流新品】";
    }
    else if ([str hasPrefix:@"type2=11"])
    {
        toststr = @"【帅气外套】";
        
    }else if ([str hasPrefix:@"type2=23"])
    {
        toststr = @"【气质美裙】";
        
    }else if ([str hasPrefix:@"fix_price=20"])
    {
        toststr = @"【超值特惠】";
        
    }else if ([str hasPrefix:@"fix_price=22"])
    {
        toststr = @"【流行趋势】";
        
    }else if ([str hasPrefix:@"favorite=29"])
    {
        toststr = @"【甜美韩系】";
        
    }else if ([str hasPrefix:@"favorite=30"])
    {
        toststr = @"【欧美潮范】";
        
    }else if ([str hasPrefix:@"occasion=24"])
    {
        toststr = @"【上班族必备】";
        
    }else if ([str hasPrefix:@"style=105"])
    {
        toststr = @"【萌系可爱风】";
        
    }else if ([str hasPrefix:@"style=103"])
    {
        toststr = @"【简约通勤】";
        
    }else if ([str hasPrefix:@"style=112"])
    {
        toststr = @"【运动休闲】";
        
    }else if ([str hasPrefix:@"style=750"])
    {
        toststr = @"【经典百搭】";
        
    }else if ([str hasPrefix:@"style=102"])
    {
        toststr = @"【文艺复古】";
        
    }else if ([str isEqualToString:@"collection=shop_activity"])
    {
        toststr = @"【超值活动商品】";
    }
    else if ([str hasPrefix:@"collection=collocation_shop"])
    {
         toststr = @"【时尚搭配】";
    }else if ([str hasPrefix:@"collection=browse_shop"])
    {
        toststr = @"【最热销单品】";
    }
  
    return [NSString stringWithFormat:@"%@",toststr];
       
}

- (void)back:(UIButton*)sender
{
    NSDate *todayisFirstBack = [[NSUserDefaults standardUserDefaults] objectForKey:@"todayisFirstBack"];
    if(![[MyMD5 compareDate:todayisFirstBack] isEqualToString:@"今天"] || todayisFirstBack==nil)
    {
        if(self.dayExtraTasklist.count > 0)
        {
            //滑动至额外任务为顶部
            NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:4];
            [self.MytableView scrollToRowAtIndexPath:scrollIndexPath
                                    atScrollPosition:UITableViewScrollPositionTop animated:YES];

            [self setTaskPopMindView:Task_noFinish_mention Value:nil Title:nil Rewardvalue:nil Rewardnum:0];
            NSDate *nowdate = [NSDate date];
            [[NSUserDefaults standardUserDefaults] setObject:nowdate forKey:@"todayisFirstBack"];
            
            return;
        }
    }
    
    if([self.comeFrom isEqualToString:@"商品详情"])
    {
        if(self.navigationController.viewControllers.count >= 3)
        {
            [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count-3] animated:YES];
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YFLaunchViewDisappear object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"toTask_tixian" object:nil];
    
    NSLog(@"释放了");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (NSMutableArray *)dayMustTaskList {
    if (nil == _dayMustTaskList) {
        _dayMustTaskList=[NSMutableArray array];
    }
    return _dayMustTaskList;
}
- (NSMutableArray *)dayExtraTasklist {
    if (nil == _dayExtraTasklist) {
        _dayExtraTasklist=[NSMutableArray array];
    }
    return _dayExtraTasklist;
}
- (NSMutableArray *)surpriseTaskList {
    if (nil == _surpriseTaskList) {
        _surpriseTaskList=[NSMutableArray array];
    }
    return _surpriseTaskList;
}
- (NSMutableArray *)dayMustFinsishList {
    if (nil == _dayMustFinsishList) {
        _dayMustFinsishList=[NSMutableArray array];
    }
    return _dayMustFinsishList;
}

- (NSMutableArray *)dayExtraFinishlist {
    if (nil == _dayExtraFinishlist) {
        _dayExtraFinishlist=[NSMutableArray array];
    }
    return _dayExtraFinishlist;
}
- (NSMutableArray *)surFinishTaskList {
    if (nil == _surFinishTaskList) {
        _surFinishTaskList=[NSMutableArray array];
    }
    return _surFinishTaskList;
}
- (NSMutableArray *)FabulousTaskList
{
    if(nil == _FabulousTaskList)
    {
        _FabulousTaskList = [NSMutableArray array];
    }
    return _FabulousTaskList;
}
- (NSMutableArray *)FabulousFinishlist
{
    if(nil == _FabulousFinishlist)
    {
        _FabulousFinishlist = [NSMutableArray array];
    }
    return _FabulousFinishlist;
}
- (NSMutableArray *)selectTaskList
{
    if(nil == _selectTaskList)
    {
        _selectTaskList = [NSMutableArray array];
    }
    return _selectTaskList;
}

- (NSMutableArray *)shopGroupList
{
    if(nil == _shopGroupList)
    {
        _shopGroupList = [NSMutableArray array];
    }
    return _shopGroupList;
}
- (NSMutableArray *)surTixianFinishlist
{
    if(_surTixianFinishlist == nil)
    {
        _surTixianFinishlist = [NSMutableArray array];
    }
    return _surTixianFinishlist;
}
- (NSMutableArray *)surTixianTaskList
{
    if(_surTixianTaskList == nil)
    {
        _surTixianTaskList = [NSMutableArray array];
    }
    return _surTixianTaskList;
}

@end
