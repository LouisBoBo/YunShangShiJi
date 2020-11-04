//
//  SpecialShopDetailViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/25.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "SpecialShopDetailViewController.h"
#import "GlobalTool.h"
#import "MultiTextView.h"
#import "AFNetworking.h"
#import "DShareManager.h"
#import "MyMD5.h"
#import "HTTPTarbarNum.h"
#import "CommentTableViewCell.h"
#import "CommenModel.h"
#import "NavgationbarView.h"
#import "SizeandColorTableViewCell.h"


#import "OrderDetailViewController.h"
#import "AffirmOrderViewController.h"
#import "AddAdressViewController.h"
#import <sqlite3.h>
#import "UserInfo.h"
#import "QRCodeGenerator.h"
#import "TFMakeMoneySecretViewController.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "ShopDetailModel.h"
#import "UIViewController+KNSemiModal.h"
#import "NavgationbarView.h"
#import "AppDelegate.h"
#import "NavgationbarView.h"
//#import "ChatViewController.h"
#import "RobotManager.h"
#import "TFStartScoreView.h"
#import "ImageTableViewCell.h"
#import "MymineViewController.h"

#import "TFShareRewardDetailVC.h"
#import "TypeShareModel.h"
#import "TFCommentModel.h"
#import "TFAddCommentModel.h"
#import "TFSuppCommentModel.h"

#import "OneCommentCell.h"
#import "TwoCommentCell.h"
#import "ThreeCommentCell.h"
#import "FourCommentCell.h"
#import "FiveCommentCell.h"
#import "SixCommentCell.h"
#import "ShareShopModel.h"
#import "ProduceImage.h"
#import "LoginViewController.h"
#import "ShopStoreViewController.h"
#import "RemenComtCollectionViewCell.h"
#import "PreferredMoreTableViewCell.h"
#import "LuckdrawViewController.h"

#import "FullScreenScrollView.h"
#import "TFLoginView.h"
#import "PopoverView.h"
#import "KWPopoverView.h"
#import "ShopCarCountModel.h"
#import "OneYuanModel.h"
#import "ShopDetailViewModel.h"

#import "TFNoviceTaskView.h"
#import "TFDailyTaskView.h"
#import "IntelligenceViewController.h"
#import "TFMyWalletViewController.h"
#import "math.h"
#import "YFShareModel.h"
#import "YFShopCarView.h"
#import "ShopCarModel.h"
#import "ShopCarManager.h"
#import "BrowseRemindView.h"
#import "NewSigninViewController.h"
#import "TFIndianaRecordViewController.h"
#import "TFMyCardViewController.h"
#import "HYJIntelgralDetalViewController.h"
#import "ShareAnimationView.h"
#import "SlideRemindView.h"
#import "UIView+Animation.h"
#import "ShareImageModel.h"
#import "GoldCouponsManager.h"
#import "DataManager.h"
#import "Signmanager.h"
#import "FinishTaskPopview.h"
#import "MakeMoneyViewController.h"
#import "TaskSignModel.h"
#import "ActivityShopOrderVC.h"
#import "TFShoppingViewController.h"
#import "NewShoppingCartViewController.h"
#import "BrandMakerDetailVC.h"
#import "ChangeSpecialShopPopview.h"
#import "OrderTableViewController.h"
#import "HKPieChartView.h"
#import "VitalityTaskPopview.h"
#import "CollecLikeTaskVC.h"
#import "VitalityTaskPopview.h"
#import "ShopDetailSecretViewController.h"
#import "Tools.h"
#import "BindingManager.h"
#import "MiniShareManager.h"
#define SIZE [[UIScreen mainScreen] bounds].size
#define NavigationHeight 44.0f
#define StatusTableHeight 20.0f
#define TableBarHeight 49.0f
#define handViewWidth 10

#define OPENCENTERX kScreenWidth*0.718
#define DIVIDWIDTH kScreenWidth*0.718*0.25
#define COLORBTN_WITH (kApplicationWidth-(40+(ZOOM(50)*2)))/5
#define SHAREMODELVIEW_HEIGH ZOOM6(500)
#define ONEYUANSHAREMODELVIEW_HEIGH ZOOM6(400)
#define SEVEN 604800000

#define NumbermarkTag @"NumbermarkTag"
#define NowmarkDate @"NowmarkDate"
#define YesmarkDate @"YesmarkDate"

@interface SpecialShopDetailViewController ()<DShareManagerDelegate,UISearchBarDelegate, TFScreeningBackgroundDelegate,MiniShareManagerDelegate>

@property (nonatomic ,strong) ShopStoreViewController  *shopStoreVC;
@property (nonatomic, strong)FullScreenScrollView *imgFullScrollView;
@property (nonatomic, assign)BOOL browseFlag;
@property (nonatomic, strong)UIImage *shareRandShopImage;
@property (nonatomic, strong) YFShopCarView *carBtn; //购物车
@property (nonatomic, strong) UIButton *buyBtn;      //购买按钮
@property (nonatomic, assign)NSInteger pubCartcount;  //购物车数量
@property (nonatomic, strong)ShopCarModel *shopCarModel;//购物车数据
@property (nonatomic, copy)NSString* shop_core;//此商品可用的积分
@property (strong, nonatomic) ShareAnimationView *aView; //分享动画
@property (strong, nonatomic) ShopDetailModel *cartAndbuyModel; //加购物车、购买的商品
@property (nonatomic, strong) UIView *speedProgressView;
@property (nonatomic, strong) HKPieChartView *pieChartView;
@property (nonatomic, strong) UIView *cellHeadView;
@property (nonatomic, strong) UIView *cellMoreView;
@property (nonatomic, strong) VitalityTaskPopview * vitaliview;

@property (nonatomic, strong) NSString *current_date;
@property (nonatomic, assign) BOOL isNewbie;       //是否是新用户
@property (nonatomic, strong) NSString *returnOneText; //拼团疯抢
@property (nonatomic, strong) NSString *app_shop_group_price; //疯抢价
@property (nonatomic, strong) NSMutableArray *atrrListArray;
@property (nonatomic, strong) NSMutableArray *attrDataArray;
@property (nonatomic, strong) NSMutableArray *comobDataArray;
@property (nonatomic, strong) NSMutableArray *selectIDarray;

@property (nonatomic, strong) ShopDetailViewModel *viewmodel;
@property (nonatomic, assign) CGFloat shop_deduction;  //折扣率
@property (nonatomic, strong) NSString *maxType;       //最高会员等级
@end

@implementation SpecialShopDetailViewController
{
    //计时器 天 时 分 秒
    NSString *_day;
    NSString *_hour;
    NSString *_min;
    NSString *_sec;
    int pubtime;
    int pubtime2;
    
    //详情 评价
    UIView *_headView;
    UIView *_footView;
    
    UILabel *_statelab;
    
    ShopDetailModel *_ShopModel;
    
    //好评率
    NSString *_praise_count;
    NSArray *_SizeArray;
    NSArray *_sizeArr;
    NSMutableString *_sizestring;
    
    
    //记录是否是第一次进来
    NSInteger _comeCount;
    
    //分享的模态视图
    UIView *_shareModelview;
    UIImageView *_shareBigimgview;
    
    //模态视图
    UIView *_modelview;
    //关掉模态视图按钮
    UIButton *_button;
    //模态视图图像
    UIImageView *_modelimage;
    //购买数量
    UILabel *_numlable;
    //选中的色
    NSString *_selectColor;
    NSString *_selectColorID;
    //选中的尺码
    NSString *_selectSize;
    NSString *_selectSizeID;
    
    //选中商品的名称 价格
    NSString *_selectName;
    NSString *_selectPrice;
    
    UIView *_MobleView;
    //记录数组元素多少个
    int _temp;
    //购买按钮
    UIButton *contactButton;
    //返回按钮
    UIButton *_backbtn;
    //购物车按钮
    UIButton *_shopcartbtn;
    
    UILabel *_sharelable;
    //分享按钮
    UIButton *_sharebtn;
    UILabel *_titlelable;
    
    //记录图片原有的位置
    CGRect _oldframe;
    BOOL _istouch;
    
    UIPageControl *_pageview;
    
    UIView *_view;
    
    UIImageView *_shopimage;
    UIImageView *_siimage;
    UIImageView *_screenBtnimg;
    
    //大图片数据源
//    NSMutableArray *_ImageDataArray;
    
    //评论当前页数
    NSInteger  _pagecount;
    
    //评论总页数
    NSInteger  _tatalpage;
    
    //回到顶部按钮
    UIButton *_UpBtn;
    
    //tableview的footview
    UIView *_tableFootView;
    
    CALayer *_layer;
    
    //商品链接
    NSString *_shareShopurl;
    
    
    UIScrollView *_MYmyineScrolllview;
    
    //记录加入购物车商品是否有图片
    BOOL _isImage;
    
    ShareShopModel *_shareModel;
    
    NSString *_sharePrice;
    
    NSDictionary *_shareshopdic;

    //数据库
    const char *_sql_stmt;
    
    UIView *_headview;
    
    //记录上一次点击的tag值
    NSInteger _btnTag;
    
    
    NSInteger _noviceTimerCount_5;
    NSTimer *_noviceTimer_5;
    
    UIAlertView *_shopDetailAlterView;
    

    NSTimer *_dailyTimer_1;
    NSTimer *_dailyTimer_2;
    NSTimer *_timerFire;
    
    //++++++++++++++++++添加++++++++++++
    CGPoint openPointCenter;
    
    NSInteger _sharenumber;
    NSInteger _sharefailnumber;
    
    NSString *_newimage;
    
    NSString *_headimageurl;
    
    NSMutableArray *_dataDictionaryArray;
    
    UIButton *_okbutton;//确定按钮
    
    NSTimer *_liketimer;
    UIImageView *_likeview;
    
    NSString *_shopmessage;
    
    ActivityShopOrderVC *_publicaffirm;
    
    UIStatusBarStyle _currentStatusBarStyle;
    
    UIView *_promptview;//加购物车成功立即结算弹框
    UILabel *_daojishilab;//倒计时
    NSInteger _cutdowntime;
    
    
    UIView *_Popview;
    UIImageView *_InvitationCodeView;
    UILabel *_lowlable;

    int _todayCount;
    BOOL _isMove;
    
    NSTimer *_mytimer;
    
    int _shareCount;
    
    NSString *_isCart;
    
    NSTimer *_affterTimer;
    //分享弹框
    UIView *_SharePopview;
    UIView *_ShareInvitationCodeView;
    UIView *_SharebackView;
    UIButton *_Sharecanclebtn; //弹框关闭按钮
    UIImageView *_SharetitleImg;//分享弹框的头
    NSString *_shareType;       //分享类型
    UIImage *_shareImage;       //分享图片
    UILabel *_timelable;
    UILabel *_storetimelable;   //开店倒计时
    
    NSString *_shop_group_price; //组团价格
    NSString *_shop_se_price;    //购买价格
    NSDictionary *_shopDic;
    BOOL _isFrist;
    BOOL _isRedMoney;            //是否有悬浮红包
    BOOL _isRedCount;            //是否有抽奖次数
    BOOL _isMonday;              //是否疯狂星期一
    BOOL _is_oneLuck_share;      //1元购分享
    CGFloat _rowHeigh;
    
    UIImageView *qdnImgView;
    UIImageView *qdaImgView;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [DataManager sharedManager].outAppStatistics=@"商品详情页";
    
    _currentStatusBarStyle = UIStatusBarStyleLightContent;
    NSString *path = NSHomeDirectory();//主目录
    
    _todayCount = 0;
    _isImage = NO;
    _isMove = NO;
    _isFrist = NO;
    _comeCount = 0;
    _pagecount = 1;
    _sharenumber = 0;
    _sharefailnumber = 0;

    _viewmodel = [[ShopDetailViewModel alloc] init];
    _sequenceArray = [NSMutableArray array];
    _sequenceDictionary = [[NSMutableDictionary alloc]init];
    _tagNameArray = [NSMutableArray array];
    _IDArray = [NSMutableArray array];
    _dataDictionaryArray = [NSMutableArray array];
    _returnOneText = @"拼团疯抢";
    
    self.Headimage.frame=CGRectMake(0, self.Headimage.frame.origin.y, kApplicationWidth, kApplicationHeight-180);
    self.backview.hidden=YES;
    
    [self createUI];
    
    [self creatBIGView];
    
    [self creatSectionView];
    
    if ([self.stringtype isEqualToString:@"活动商品"])
    {
        [self creatActiveFootView];
    }else{
        [self creatFootView];
    }
    
    //监听购物车通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backdetailview:) name:@"backdetailview" object:nil];
    
    //监听普通分享失败通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShopDetailsharefail:) name:@"ShopDetailsharefail" object:nil];

    //监听智能分享成功通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sharesuccess:) name:@"Intelligencesharesuccess" object:nil];
    
    //监听智能分享失败通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sharefail:) name:@"Intelligencesharefail" object:nil];

    //监听新用户身份改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zeroOrderChange:) name:@"zeroOrderChange" object:nil];
    
    [self dataInit];

    //商品详情
    [self requestHttp];
    
    //商品属性及库存分类查询
    [self requestShopHttp];
    
}

- (void)zeroOrderChange:(NSNotification*)note
{
    //商品详情
    [self requestHttp];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    if(self.searchBtn.selected == YES)
    {
        self.screenBtn.selected = NO;
    }
    
    [self.searchBar resignFirstResponder];
    
    self.contentBackgroundView.center = CGPointMake(openPointCenter.x-OPENCENTERX, openPointCenter.y);
    
    [self.searchRightView removeFromSuperview];
    [self.screenView removeFromSuperview];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [MBProgressHUD hideHUDForView:self.view];
    
    [TFStatisticsClickVM StatisticshandleDataWithClickType:@"跳出商品页" success:nil failure:nil];
    
    [self dismissShareView];
}
-(void)viewWillAppear:(BOOL)animated
{
    //新版1元购出现后 没有疯狂星期一购买 没有活动商品
    
    if([self.stringtype isEqualToString:@"活动商品"] || [self.stringtype isEqualToString:@"签到领现金"])
    {
        self.stringtype = @"";
    }
    
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:_currentStatusBarStyle];
    
    _sizestring = [NSMutableString stringWithCapacity:10000000000];
    _sharenumber = 0;
    [self getShopCartFromDB:YES];
    
    NSString *time = [[NSUserDefaults standardUserDefaults] objectForKey:ShareAnimationTime];
    NSString *currTime = [MyMD5 getCurrTimeString:@"year-month-day"];
    if (time == nil || ![time isEqualToString:currTime]) {
        [_aView animationStart:YES];
    } else {
        [_aView animationStart:NO];
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if( self.commentDataArray.count < 2)
    {
        [self HotcommentHttp];
    }

    [[UIApplication sharedApplication] setStatusBarStyle
     :_currentStatusBarStyle];
    //保存所有看过的商品信息
    [self AddmystepsHttp];
    [self getNewBie];
    
    if([self.stringtype isEqualToString:@"签到领现金"] || [self.stringtype isEqualToString:@"活动商品"])
    {
        if(self.browseCount==0)
        {
            //记录蒙层弹出时间（每天只弹一次）
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSDate *record = [user objectForKey:BROWSEDATE];
            
            if(![[MyMD5 compareDate:record] isEqualToString:@"今天"] || record==nil )
            {
                SlideRemindView *slideRemind = [[SlideRemindView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) Type:nil];
                if(!self.is_group)
                {
                    [self.view addSubview:slideRemind];
                    
                    __weak SlideRemindView *sRemind = slideRemind;
                    
                    sRemind.disapperBlock = ^{
                        [sRemind remindViewHiden];
                        
                        [self creatSlideView];
                    };
                    
                    NSDate *date = [NSDate date];
                    [user setObject:date forKey:BROWSEDATE];
                }
            }else{
                [self creatSlideView];
            }
            
        }else if(self.browseCount > 0)
        {
            [self creatSlideView];
        }
    }else{
        
        //记录提示弹框弹出时间（每天只弹一次）
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSDate *record = [user objectForKey:RAWARDPROMPT];
        if((![[MyMD5 compareDate:record] isEqualToString:@"今天"] || record==nil ) && _isMonday){
            [self setVitalityPopMindView:Detail_Prompt_raward];
            NSDate *date = [NSDate date];
            [user setObject:date forKey:RAWARDPROMPT];
            
        }
    }
    
    if([DataManager sharedManager].InvitationSuccess == YES)
    {
        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        [mentionview showLable:@"分享成功" Controller:self];
        [DataManager sharedManager].InvitationSuccess = NO;
    }
    [TFStatisticsClickVM StatisticshandleDataWithClickType:@"到达商品页" success:nil failure:nil];

}
#pragma mark ******************购买成功奖励弹框***********************
- (void)setVitalityPopMindView:(VitalityType)type
{
    self.vitaliview = [[VitalityTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) VitalityType:type valityGrade:0 YidouCount:0];
    __weak VitalityTaskPopview *view = self.vitaliview;
    view.tapHideMindBlock = ^{
        [view remindViewHiden];
    };
    
    kWeakSelf(self);
    view.leftHideMindBlock = ^(NSString*title){
    
        if(type == Super_zeroShopping)
        {
            [weakself gocontact:contactButton];
        }else if (type == Detail_comeBack)
        {
            MakeMoneyViewController *vc = [[MakeMoneyViewController alloc] init];
            vc.comeFrom = @"商品详情";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    
    view.rightHideMindBlock = ^(NSString*title)
    {
    };
    
    [self.view addSubview:self.vitaliview];
}

- (void)dataInit
{
    _noviceTimerCount_5 = MY_MINUTE*0.5;
}
#pragma mark **********************UI界面*************************
- (void)creatSlideView
{
    if(self.SlideView)
    {
        return;
    }
    CGFloat imageWidth = IMAGEW(@"hover_xunbao");
    CGFloat imageHeigh = IMAGEH(@"hover_xunbao");
    
    self.SlideView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth+imageWidth, (kScreenHeight-imageHeigh)/2, imageWidth, imageHeigh)];
    self.SlideView.image = [UIImage imageNamed:@"hover_xunbao"];
    if(!self.is_group && self.browseCount !=-1 && !self.isFight)
    {
        [self.view addSubview:self.SlideView];
    }
    [UIView animateWithDuration:0.5 animations:^{
        
        self.SlideView.frame =CGRectMake(kScreenWidth-imageWidth, (kScreenHeight-imageHeigh)/2, imageWidth, imageHeigh);
    }];
    
}
#pragma mark 创建导航条
-(void)creatHeadview
{
    for (UIView *view in self.contentBackgroundView.subviews) {
        if (view.tag == 3838) {
            return;
        }
    }
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.image = [UIImage imageNamed:@"zhezhao"];
    
    headview.tag = 3838;
    
    [self.view addSubview:headview];
    
    
    headview.userInteractionEnabled=YES;
    
    _backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _backbtn.frame=CGRectMake(-10, Height_NavBar-57, 80, 44);
    _backbtn.centerY = View_CenterY(headview);
    [_backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [_backbtn setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
    [_backbtn setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateHighlighted];
    
    [self.view addSubview:_backbtn];
    
    
    _titlelable =[[UILabel alloc]init];
    _titlelable.frame=CGRectMake(0, 0, 300, 40);
    _titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    _titlelable.text=@"商品详情";
    _titlelable.alpha = 0;
    _titlelable.textColor=[UIColor blackColor];
    _titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:_titlelable];
    
    
    CGFloat scale = 2;
    CGFloat imagescale = 1;
    
    //喜欢
    _sharebtn=[[UIButton alloc]init];
    _sharebtn.frame =CGRectMake(kApplicationWidth-SE(19)-IMGSIZEW(@"icon_xihuan")-ZOOM(30), 20, IMGSIZEW(@"icon_xihuan")*scale, IMGSIZEH(@"icon_xihuan")*scale);
    _sharebtn.centerY = headview.frame.size.height/2+10;
    
    _sharebtn.backgroundColor = [UIColor clearColor];
    [_sharebtn addTarget:self action:@selector(likeclick:) forControlEvents:UIControlEventTouchUpInside];
    
    _siimage = [[UIImageView alloc]initWithFrame:CGRectMake((_sharebtn.frame.size.width-IMGSIZEW(@"icon_xihuan")*imagescale)/2, 13, IMGSIZEW(@"icon_xihuan")*imagescale, IMGSIZEH(@"icon_xihuan")*imagescale)];
    _siimage.image = [UIImage imageNamed:@"icon_xihuan"];
    
    [_sharebtn addSubview:_siimage];
    
    [self.view addSubview:_sharebtn];
    
    
    //购物车
    _shopcartbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _shopcartbtn.frame=CGRectMake(_sharebtn.frame.origin.x-SE(37.5)-IMGSIZEW(@"icon_fenxiang")+ZOOM(40), 18, IMGSIZEW(@"icon_gouwuche")*scale, IMGSIZEH(@"icon_gouwuche")*scale);
    _shopcartbtn.backgroundColor = [UIColor clearColor];
    
    [_shopcartbtn addTarget:self action:@selector(cartclick:) forControlEvents:UIControlEventTouchUpInside];
    
    _shopimage= [[UIImageView alloc]initWithFrame:CGRectMake((_shopcartbtn.frame.size.width-IMGSIZEW(@"icon_gouwuche")*imagescale)/2, 13, IMGSIZEW(@"icon_gouwuche"), IMGSIZEH(@"icon_gouwuche"))];
    _shopimage.image = [UIImage imageNamed:@"icon_gouwuche"];
    
    //    [_shopcartbtn addSubview:_shopimage];
    
    
    //购物车角标
    self.marklable=[[UILabel alloc]initWithFrame:CGRectMake(15, -5, 16, 16)];
    self.marklable.backgroundColor=tarbarrossred;
    
    //    self.marklable.text=[NSString stringWithFormat:@"%d",_ShopModel.cart_count.intValue];
    self.marklable.clipsToBounds=YES;
    self.marklable.layer.cornerRadius=8;
    self.marklable.textColor=[UIColor whiteColor];
    self.marklable.textAlignment=NSTextAlignmentCenter;
    self.marklable.font=[UIFont systemFontOfSize:10];
    //    [_shopimage addSubview:self.marklable];
    
    //    if(_ShopModel.cart_count.intValue>0)
    //    {
    //        self.marklable.hidden=NO;
    //    }else{
    //        self.marklable.hidden=YES;
    //    }
    
    [self.view addSubview:_shopcartbtn];
    
//    UIButton *totopbtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    totopbtn.frame=CGRectMake(60, 0, kApplicationWidth-160, 40);
//    [totopbtn addTarget:self action:@selector(upToTop:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [headview addSubview:totopbtn];
    
}
- (void)creatTableFootView
{
    _tableFootView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight-Height_NavBar+kUnderStatusBarStartY-50)];
//    _tableFootView.backgroundColor = tarbarrossred;
    
    [self footViewAddChildView];
}

#pragma mark 创建tableheadview视图
-(void)creatBIGView
{
    UIView *view=(UIView*)[self.view viewWithTag:3838];
    if(view)
    {
        [view removeFromSuperview];
        
        for(UIView *vv in view.subviews)
        {
            [vv removeFromSuperview];
        }
    }
    
    //购物车角标
    self.marklable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
    self.marklable.backgroundColor=[UIColor yellowColor];
    self.marklable.clipsToBounds=YES;
    self.marklable.layer.cornerRadius=8;
    self.marklable.textColor=[UIColor blackColor];
    self.marklable.textAlignment=NSTextAlignmentCenter;
    self.marklable.font=[UIFont systemFontOfSize:8];
    
    //    CGFloat imgheigh=900*kApplicationWidth/600;
    //    self.Headimage.frame=CGRectMake(0, self.Headimage.frame.origin.y, kApplicationWidth, imgheigh);
    //
    //    CGFloat headimageYY=CGRectGetMaxY(self.Headimage.frame);
    //    self.backview.frame=CGRectMake(0, headimageYY, kApplicationWidth, self.backview.frame.size.height);
    
    //    //商品名
    //    CGFloat shopnameHeigh = ZOOM(15*3.375);
    //
    //    if(self.shopname !=nil)
    //    {
    //        shopnameHeigh = [self getRowHeight:_ShopModel.shop_name fontSize:ZOOM(15*3.375)];
    //    }
    //    self.shopname.frame = CGRectMake(ZOOM(42), ZOOM6(20),kScreenWidth - 2*ZOOM(42), shopnameHeigh);
    //
    //    self.shopname.text = [self exchangeTextWihtString:_ShopModel.shop_name];
    //    self.shopname.textColor = RGBCOLOR_I(62, 62, 62);
    //    self.shopname.numberOfLines = 0;
    //    self.shopname.font = [UIFont systemFontOfSize:ZOOM(15*3.375)];
    
    //    if([self.typestring isEqualToString:@"兑换"])
    //    {
    //        CGFloat olldpriceY = CGRectGetMaxY(self.shopname.frame);
    //
    //        //实价
    //        self.se_price.text=[NSString stringWithFormat:@"%@分",_ShopModel.shop_se_price];
    //
    //        //原价
    //        self.oldprice.frame=CGRectMake(ZOOM(67), olldpriceY+ZOOM(69), self.oldprice.frame.size.width, self.oldprice.frame.size.height);
    //
    //        self.oldprice.text=[NSString stringWithFormat:@"%@分",_ShopModel.shop_price];
    //
    //    }else{
    //
    //        CGFloat olldpriceY = CGRectGetMaxY(self.shopname.frame);
    //
    //        //出售价
    //
    //        self.se_price.frame=CGRectMake(_shopname.frame.origin.x, olldpriceY+ZOOM(10*3.4), self.se_price.frame.size.width, ZOOM(18*3.4));
    //
    //        self.se_price.text=[NSString stringWithFormat:@"￥%.1f",[_ShopModel.shop_se_price floatValue]];
    //        self.se_price.font = [UIFont systemFontOfSize:ZOOM(18*3.4)];
    //
    //        [self.se_price setFont:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM(18*3.4)]];
    //        self.se_price.textColor = tarbarrossred;
    //
    //        UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM(19*3.4)];
    //
    //        NSDictionary *attributes1 = @{NSFontAttributeName:font};
    //        CGSize se_price_textSize = [self.se_price.text boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes1 context:nil].size;
    //        self.se_price.frame=CGRectMake(_shopname.frame.origin.x, self.se_price.frame.origin.y, se_price_textSize.width, self.se_price.frame.size.height);
    //
    //        CGFloat sepriceX = CGRectGetMaxX(self.se_price.frame);
    //
    //        //原价
    //        self.oldprice.frame=CGRectMake(sepriceX , olldpriceY+ZOOM(10*3.4)+ZOOM(5*3.4), self.oldprice.frame.size.width, ZOOM(12*3.4));
    //
    //        self.oldprice.text=[NSString stringWithFormat:@"￥%.1f",[_ShopModel.shop_price floatValue]];
    //        if([self.stringtype isEqualToString:@"活动商品"] || [self.typeName isEqualToString:@"热卖"])
    //        {
    //            self.oldprice.frame=CGRectMake(sepriceX , olldpriceY+ZOOM(10*3.4)+ZOOM(3*3.4), self.oldprice.frame.size.width, ZOOM(12*3.4));
    //             self.oldprice.text=[NSString stringWithFormat:@"淘宝价￥%.1f",[_ShopModel.shop_price floatValue]];
    //        }
    //
    //        self.oldprice.font = [UIFont systemFontOfSize:ZOOM(12*3.4)];
    //        self.oldprice.textColor = RGBCOLOR_I(168, 168, 168);
    //
    //        NSDictionary *attributes2 = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(13*3.4)]};
    //        CGSize textSize = [self.oldprice.text boundingRectWithSize:CGSizeMake(150, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes2 context:nil].size;
    //
    //        self.oldprice.frame = CGRectMake(sepriceX, self.oldprice.frame.origin.y, textSize.width, self.oldprice.frame.size.height);
    //
    //        self.priceline.frame=CGRectMake(sepriceX+2,self.oldprice.frame.origin.y + self.oldprice.frame.size.height/2, textSize.width-4, self.priceline.frame.size.height);
    //
    //        //新增2017-2-13
    //        if(![self.stringtype isEqualToString:@"活动商品"])
    //        {
    //            self.shopname.textAlignment = NSTextAlignmentCenter;
    //
    //            CGFloat se_priceX = (kScreenWidth - self.se_price.frame.size.width-self.oldprice.frame.size.width)/2;
    //
    //            self.se_price.frame=CGRectMake(se_priceX, olldpriceY+ZOOM(10*3.4), self.se_price.frame.size.width, ZOOM(18*3.4));
    //            self.oldprice.frame = CGRectMake(CGRectGetMaxX(self.se_price.frame), self.oldprice.frame.origin.y, textSize.width, self.oldprice.frame.size.height);
    //            self.priceline.frame=CGRectMake(CGRectGetMaxX(self.se_price.frame)+2,self.oldprice.frame.origin.y + self.oldprice.frame.size.height/2, textSize.width-4, self.priceline.frame.size.height);
    //        }
    //
    //        //回佣
    //        self.huiyong.hidden=YES;
    //        for(int i =0;i<2;i++)
    //        {
    //
    //            UIView *view = (UIView*)[self.view viewWithTag:1919+i];
    //            UIView *imgview = (UIView*)[self.view viewWithTag:2929+i];
    //            [view removeFromSuperview];
    //            [imgview removeFromSuperview];
    //
    //            UILabel *discountlable =[[UILabel alloc]init];
    //            discountlable.tag=1919+i;
    //            discountlable.font = [UIFont systemFontOfSize:ZOOM(44)];
    //            [self.backview addSubview:discountlable];
    //
    //            if([self.stringtype isEqualToString:@"活动商品"] || [self.typeName isEqualToString:@"热卖"])
    //            {
    //                if(i==0)
    //                {
    //                    discountlable.frame=CGRectMake(CGRectGetMaxX(self.oldprice.frame)+ZOOM6(50), CGRectGetMinY(self.se_price.frame), ZOOM6(120), CGRectGetHeight(self.se_price.frame));
    //                    discountlable.textAlignment =NSTextAlignmentCenter;
    //                    discountlable.backgroundColor = tarbarrossred;
    //                    discountlable.textColor = [UIColor whiteColor];
    //                    discountlable.clipsToBounds = YES;
    //                    discountlable.layer.cornerRadius = 2;
    //                    CGFloat scal = (([_ShopModel.shop_se_price floatValue]/[_ShopModel.shop_price floatValue]))*10;
    //                    discountlable.text = [NSString stringWithFormat:@"%.1f折",scal];
    //
    //                }else if (i==1)
    //                {
    //                    discountlable.frame=CGRectMake(CGRectGetMaxX(self.oldprice.frame)+ZOOM6(180),CGRectGetMinY(self.oldprice.frame), ZOOM6(200), CGRectGetHeight(self.oldprice.frame));
    //                    discountlable.textColor = tarbarrossred;
    //                    discountlable.textAlignment =NSTextAlignmentLeft;
    //                    discountlable.text = [NSString stringWithFormat:@"立省%.1f元",[_ShopModel.shop_price floatValue] - [_ShopModel.shop_se_price floatValue] ];
    //                }
    //
    //            }
    //        }
    //
    //    }
    
    //    //分享的用户
    //    CGFloat sharelableYY = CGRectGetMaxY(self.se_price.frame);
    //    [self.lableline1 removeFromSuperview];
    //    self.lableline1 = [[UILabel alloc]init];
    //    self.lableline1.frame = CGRectMake(0, sharelableYY+10, kApplicationWidth, 1);
    //    self.lableline1.backgroundColor = kBackgroundColor;
    //    [self.backview addSubview:self.lableline1];
    //
    //    CGFloat lineY = CGRectGetMaxY(self.lableline1.frame);
    //
    //    //供应商
    //    [self.ManufacturerLab removeFromSuperview];
    //    self.ManufacturerLab = nil;
    //
    //    self.ManufacturerLab = [[UILabel alloc] init];
    //    self.ManufacturerLab.layer.borderWidth = 0.5;
    //    self.ManufacturerLab.layer.cornerRadius=3;
    //    self.ManufacturerLab.layer.borderColor = tarbarrossred.CGColor;
    //    self.ManufacturerLab.textColor = tarbarrossred;
    //    self.ManufacturerLab.textAlignment = NSTextAlignmentLeft;
    //    self.ManufacturerLab.font = [UIFont systemFontOfSize:ZOOM6(26)];
    //    self.ManufacturerLab.text = [NSString stringWithFormat:@"   %@制造商出品",self.content1];
    //    self.ManufacturerLab.userInteractionEnabled = YES;
    //    UITapGestureRecognizer *manufactap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Manufacturer)];
    //    [self.ManufacturerLab addGestureRecognizer:manufactap];
    //
    //    CGFloat manufactureWith = [self getRowWidth:self.ManufacturerLab.text fontSize:ZOOM6(28)];
    //    self.ManufacturerLab.frame =CGRectMake((kScreenWidth-manufactureWith-ZOOM6(30))/2, CGRectGetMaxY(self.lableline1.frame)+ZOOM6(17), manufactureWith+ZOOM6(30), ZOOM6(46));
    //
    //    UIImageView *goimg = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.ManufacturerLab.frame)-ZOOM6(40),(CGRectGetHeight(self.ManufacturerLab.frame)-ZOOM6(24))/2, ZOOM6(24), ZOOM6(24))];
    //    goimg.image = [UIImage imageNamed:@"shop-go-"];
    //    [self.ManufacturerLab addSubview:goimg];
    //
    //    if(self.content1.length >0 && ![self.content1 isEqualToString:@"(null)"])
    //    {
    //        lineY += ZOOM6(80);
    //        self.backview.userInteractionEnabled = YES;
    //        [self.backview addSubview:self.ManufacturerLab];
    //    }
    //
    //    CGFloat discriptionlabHeigh = (kScreenWidth)/4.2;
    //    [self.fwcnview removeFromSuperview];
    //    self.fwcnview = [[UIImageView alloc]init];
    //    self.fwcnview.frame = CGRectMake(0, lineY, kScreenWidth, discriptionlabHeigh);
    //    self.fwcnview.image = [UIImage imageNamed:@"fuwuchengnuo"];
    //    [self.backview addSubview:self.fwcnview];
    //
    //
    //    lineY +=discriptionlabHeigh;
    //
    //    self.backview.frame = CGRectMake(0, self.backview.frame.origin.y, self.backview.frame.size.width, CGRectGetMaxY(self.fwcnview.frame));
    //    CGFloat backviewYY=CGRectGetMaxY(self.backview.frame);
    //
    //    self.Myscrollview.frame=CGRectMake(0, self.Myscrollview.frame.origin.y, kApplicationWidth, backviewYY);
    
    //    self.Myscrollview.backgroundColor=[UIColor whiteColor];
    
    [self creatBigTableview];
    
    [self creatHeadview];
    
    
    if (([[[NSUserDefaults standardUserDefaults]objectForKey:@"RedMoneyLeastNum"] integerValue]!=-1 || [[NSUserDefaults standardUserDefaults]objectForKey:USER_TOKEN] ==nil) && !self.isFight)
    [self httpGetRedMoneyLeastNum];
}

/**
 获取当天还有多少次抽奖机会
 */
- (void)httpGetRedMoneyLeastNum {
    kSelfWeak;
    [[APIClient sharedManager]netWorkGeneralRequestWithApi:@"order/getOrderRaffleNum?" caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
        if (response.status == 1) {
            
            _isRedCount = [[NSString stringWithFormat:@"%@",data[@"data"]] integerValue] >0?YES:NO;
            [[NSUserDefaults standardUserDefaults]setObject:data[@"data"] forKey:@"RedMoneyLeastNum"];
            [[NSUserDefaults standardUserDefaults]setObject:data[@"n"] forKey:@"RedMoneyAllNum"];
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",data[@"money"]] forKey:@"RedMoneyRaward"];
            
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"RedMoneyLeastNum"] integerValue]!=-1){
                _isRedMoney = YES;
                
//                [[DataManager sharedManager] taskListHttp:26 Success:^{
//                    [weakSelf creatRedMoneyAlertView];
//                }];

            }else{
                [self.redMoneybtn removeFromSuperview];
            }
            
        }else if (response.status == 10030)
        {
//            [weakSelf creatRedMoneyAlertView];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)creatRedMoneyAlertView {
    
    [self.view addSubview:self.redMoneybtn];
    [self.view bringSubviewToFront:self.redMoneybtn];
}

- (UIButton*)redMoneybtn
{
    if(_redMoneybtn == nil)
    {
        _redMoneybtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_redMoneybtn setImage:[UIImage imageNamed:@"余额抽奖红包"] forState:UIControlStateNormal];
        [_redMoneybtn setImage:[UIImage imageNamed:@"余额抽奖红包"] forState:UIControlStateNormal|UIControlStateHighlighted];
        [_redMoneybtn addTarget:self action:@selector(redViewClick) forControlEvents:UIControlEventTouchUpInside];
        _redMoneybtn.frame = CGRectMake(kScreenWidth-ZOOM6(168)-ZOOM6(20),kScreenHeight-ZOOM6(500), ZOOM6(168), ZOOM6(178));
    }
    return _redMoneybtn;
}

- (void)redViewClick {
   
    kWeakSelf(self);
    [self loginSuccess:^{
        [weakself httpGetRedMoneyLeastNum];//登录成功后重新刷新红包抽奖是否有资格
        
        [[BindingManager BindingManarer] checkPhoneAndUnionID:YES Success:^{
            [weakself gotoLuck];
        }];
        [BindingManager BindingManarer].BindingSuccessBlock = ^{
            
            [weakself gotoLuck];
        };
        
    }];
}
- (void)gotoLuck
{
    LuckdrawViewController *vc = [[LuckdrawViewController alloc]init];
//    vc.is_OrderRedLuck = _isRedCount;
    vc.is_comefromeRed = YES;
    vc.is_OrderRedLuck = [[[NSUserDefaults standardUserDefaults]objectForKey:@"RedMoneyLeastNum"] integerValue] ? YES : NO;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)refreshBigImageview
{
    //大图
    if(! _ShopModel.def_pic)
    {
        CGFloat imgheigh=900*kApplicationWidth/600;
        
        UIImageView *defaultimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IMGSIZEW(@"iconfont-icon 拷贝副本"), IMGSIZEH(@"iconfont-icon 拷贝副本"))];
        defaultimg.center=CGPointMake(self.Headimage.frame.size.width/2, imgheigh/2);
        defaultimg.tag=3737;
        defaultimg.image=[UIImage imageNamed:@"iconfont-icon 拷贝副本"];
        
        [self.Headimage addSubview:defaultimg];
        
    }else
    {
        UIImageView *defaultimg=(UIImageView*)[self.view viewWithTag:3737];
        [defaultimg removeFromSuperview];
        
        NSString *st = [DataManager sharedManager].img_rate>0?[NSString stringWithFormat:@"!%d",(int)[DataManager sharedManager].img_rate]:@"!450";
        
//        if (kDevice_Is_iPhone6Plus) {
//            st = @"!450";
//        } else {
//            st = @"!382";
//        }
        
        
        if(_ShopModel.def_pic)
        {
            
            NSMutableString *code = [NSMutableString stringWithString:_ShopModel.shop_code];
            
            NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
            MyLog(@"supcode =%@",supcode);
            
            _newimage = [NSString stringWithFormat:@"%@/%@/%@",supcode,_ShopModel.shop_code,_ShopModel.def_pic];
            MyLog(@"newurl = %@",_newimage);
            
        }
        
//        NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],_newimage,st]];
        
        NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],_newimage]];
        __block float d = 0;
        __block BOOL isDownlaod = NO;
        
        CGFloat imgheigh=900*kApplicationWidth/600;
        
        self.Headimage.frame=CGRectMake(0, self.Headimage.frame.origin.y, kApplicationWidth, imgheigh);
        kSelfWeak;
        [self.Headimage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            d = (float)receivedSize/expectedSize;
            isDownlaod = YES;
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image != nil && isDownlaod == YES) {
                weakSelf.Headimage.alpha = 0;
                [UIView animateWithDuration:0.5 animations:^{
                    weakSelf.Headimage.alpha = 1;
                } completion:^(BOOL finished) {
                }];
            } else if (image != nil && isDownlaod == NO) {
                
                weakSelf.Headimage.image = image;
            }
        }];
        
        //给Headimage 添加手势
        if(imgUrl)
        {
            self.Headimage.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTouch:)];
            _headimageurl = _newimage;
            [self.Headimage addGestureRecognizer:tap];
        }
        
        //分享赚多少钱
        if(![self.stringtype isEqualToString:@"活动商品"] && [_ShopModel.shop_se_price floatValue] >0)
        {
            UIImageView *shareMoneyImage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-ZOOM6(210), ZOOM6(300), ZOOM6(210), ZOOM6(60))];
            shareMoneyImage.image = [UIImage imageNamed:@"圆角矩形-45"];
            shareMoneyImage.userInteractionEnabled=YES;
            [self.view addSubview:self.shareMoneyImage = shareMoneyImage];
            [self.view bringSubviewToFront:shareMoneyImage];
            
            UILabel *moneylabel = [[UILabel alloc]initWithFrame:CGRectMake(0, -ZOOM6(3), CGRectGetWidth(shareMoneyImage.frame), CGRectGetHeight(shareMoneyImage.frame))];
//            moneylabel.text = [NSString stringWithFormat:@"分享赚%.1f元",[_ShopModel.shop_se_price floatValue]*0.1];
            moneylabel.text = @"分享赢50元";
            moneylabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
            moneylabel.textColor = [UIColor whiteColor];
            moneylabel.textAlignment = NSTextAlignmentCenter;
            [shareMoneyImage addSubview:moneylabel];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(normalShare)];
            [shareMoneyImage addGestureRecognizer:tap];
        }
        
        CGFloat headimageYY=CGRectGetMaxY(self.Headimage.frame);
        self.backview.frame=CGRectMake(0, headimageYY, kApplicationWidth, self.backview.frame.size.height);
        
        //7天倒计时
        self.headCountdownImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.Headimage.frame)-ZOOM6(60), kScreenWidth, ZOOM6(60))];
        self.headCountdownImg.image = [UIImage imageNamed:@"001_cuttime"];
        [self.Headimage addSubview:self.headCountdownImg];
        self.headCountdownImg.hidden = YES;
        
        UIImageView *timeImg = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(20), ZOOM6(10), ZOOM6(40), ZOOM6(40))];
        
        timeImg.image = [UIImage imageNamed:@"shop-icon_daojishi-"];
        [self.headCountdownImg addSubview:timeImg];
        
        self.headCountLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeImg.frame)+ZOOM6(10), ZOOM6(10), kScreenWidth-CGRectGetMaxX(timeImg.frame)-2*ZOOM6(10), ZOOM6(40))];
        self.headCountLab.text = @"";
        self.headCountLab.textColor = [UIColor whiteColor];
        self.headCountLab.font = [UIFont systemFontOfSize:ZOOM6(30)];
        [self.headCountdownImg addSubview:self.headCountLab];
        
        if([self.stringtype isEqualToString:@"活动商品"] || [self.typeName isEqualToString:@"热卖"])
        {
            [self.headCountdownImg removeFromSuperview];
            [self.soldShopView removeFromSuperview];
            
            self.soldShopView = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.Headimage.frame)-ZOOM6(370), CGRectGetHeight(self.Headimage.frame)-ZOOM6(60), ZOOM6(370), ZOOM6(60))];
            
            self.soldShopView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5f];
            self.soldShopView.textAlignment = NSTextAlignmentCenter;
            self.soldShopView.font = [UIFont systemFontOfSize:ZOOM6(30)];
            self.soldShopView.textColor = RGBCOLOR_I(255, 63, 139);
            
            NSString *soldstr = [NSString stringWithFormat:@"已售%@件",_virtual_sales];
            int y = (arc4random() % 22) + 3;
            NSString *onlystr = [NSString stringWithFormat:@"仅剩%d件",y];
            self.soldShopView.text = [NSString stringWithFormat:@"%@/%@",soldstr,onlystr];
            
            NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc] initWithString:self.soldShopView.text];
            [mutable addAttribute:NSForegroundColorAttributeName value:RGBCOLOR_I(255, 255, 255) range:NSMakeRange(0, soldstr.length+1)];
            [self.soldShopView setAttributedText:mutable];
            
//            [self.Headimage addSubview:self.soldShopView];
            
        }
    }
    
    //评论数
    if(_ShopModel.eva_count.intValue>0)
    {
        UIButton *commentbtn=(UIButton*)[_headView viewWithTag:1002];
        NSString *str =[NSString stringWithFormat:@"评论(%d)",_ShopModel.eva_count.intValue];
        [commentbtn setTitle:str forState:UIControlStateNormal];
        
    }
    
    //商品名
    CGFloat shopnameHeigh = ZOOM(15*3.375);
    
    if(self.shopname !=nil)
    {
        shopnameHeigh = [self getRowHeight:_ShopModel.shop_name fontSize:ZOOM(15*3.375)];
    }
    self.shopname.frame = CGRectMake(ZOOM(42), ZOOM6(20),kScreenWidth - 2*ZOOM(42), shopnameHeigh);
    self.shopname.text = [self exchangeTextWihtString:_ShopModel.shop_name];
    self.shopname.textColor = RGBCOLOR_I(62, 62, 62);
    self.shopname.numberOfLines = 0;
    self.shopname.font = [UIFont systemFontOfSize:ZOOM(15*3.375)];
    
    CGFloat olldpriceY = CGRectGetMaxY(self.shopname.frame);
    //出售价
    self.se_price.frame=CGRectMake(_shopname.frame.origin.x, olldpriceY+ZOOM(8*3.4), self.se_price.frame.size.width, ZOOM(18*3.4));
    
//    self.se_price.text=[NSString stringWithFormat:@"￥%.1f",[self.stringtype isEqualToString:@"活动商品"]?[_ShopModel.shop_se_price floatValue]:[_ShopModel.shop_se_price floatValue]*0.9];
    
    CGFloat shop_se_price = [_ShopModel.shop_se_price floatValue]-[DataManager sharedManager].one_not_use_price>0?([_ShopModel.shop_se_price floatValue]-[DataManager sharedManager].one_not_use_price):0;
//    if([DataManager sharedManager].is_OneYuan)
//    {
//        shop_se_price = (self.isNewbie)?0:self.app_shop_group_price.floatValue;
//    }
    self.se_price.text=[NSString stringWithFormat:@"￥%.1f",[self.stringtype isEqualToString:@"活动商品"]?[_ShopModel.shop_se_price floatValue]:shop_se_price];
    self.se_price.text= [NSString stringWithFormat:@"￥%.1f",[self.viewmodel get_discount_price:_ShopModel.shop_se_price.floatValue DiscountMoney:[DataManager sharedManager].one_not_use_price MaxViptype:self.maxType Shop_deduction:self.shop_deduction]];
    if([self.stringtype isEqualToString:@"活动商品"] && !self.isNOFightgroups)
    {
        self.se_price.text=[NSString stringWithFormat:@"￥%.2f",[_ShopModel.shop_group_price floatValue]];
    }
    self.se_price.font = [UIFont systemFontOfSize:ZOOM6(36)];
    
    [self.se_price setFont:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(36)]];
    self.se_price.textColor = [UIColor redColor];
    
    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(40)];
    
    NSDictionary *attributes1 = @{NSFontAttributeName:font};
    CGSize se_price_textSize = [self.se_price.text boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes1 context:nil].size;
    self.se_price.frame=CGRectMake(_shopname.frame.origin.x, self.se_price.frame.origin.y, se_price_textSize.width, self.se_price.frame.size.height);
    
    CGFloat sepriceX = CGRectGetMaxX(self.se_price.frame)+ZOOM6(10);
    
    //原价
    self.oldprice.frame=CGRectMake(sepriceX , olldpriceY+ZOOM(13*3.4), self.oldprice.frame.size.width, ZOOM(12*3.4));
    self.oldprice.text=[NSString stringWithFormat:@"￥%.1f",[_ShopModel.shop_price floatValue]];
    
//    if([self.stringtype isEqualToString:@"活动商品"] || [self.typeName isEqualToString:@"热卖"])
//    {
//        self.oldprice.frame=CGRectMake(sepriceX , olldpriceY+ZOOM(10*3.4)+ZOOM(3*3.4), self.oldprice.frame.size.width, ZOOM(12*3.4));
////        self.oldprice.text=[NSString stringWithFormat:@"专柜价￥%.1f",[_ShopModel.shop_price floatValue]];
//
//        self.oldprice.text=[NSString stringWithFormat:@"原价￥%.1f",[_ShopModel.shop_price floatValue]-[DataManager sharedManager].OneYuan_count];
//    }else
//    CGFloat myMoney= [_ShopModel.shop_se_price floatValue]-[DataManager sharedManager].OneYuan_count>0?([_ShopModel.shop_se_price floatValue]-[DataManager sharedManager].OneYuan_count):0;
    
//    if ([DataManager sharedManager].is_OneYuan)
//    {
//        self.oldprice.text=[NSString stringWithFormat:@"原价￥%.1f",[_ShopModel.shop_se_price floatValue]];
//    }
//    else{
//        self.oldprice.text=[NSString stringWithFormat:@"原价￥%.1f",[_ShopModel.shop_price floatValue]];
//    }
    
    self.oldprice.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(30)];
//    self.oldprice.textColor = RGBCOLOR_I(168, 168, 168);
    self.oldprice.textColor = tarbarrossred;
    
    NSDictionary *attributes2 = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM6(30)]};
    CGSize textSize = [self.oldprice.text boundingRectWithSize:CGSizeMake(150, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes2 context:nil].size;
    
    self.oldprice.frame = CGRectMake(sepriceX, self.oldprice.frame.origin.y, textSize.width+ZOOM6(10), self.oldprice.frame.size.height);
    
    self.priceline.hidden = YES; self.priceline.frame=CGRectMake(sepriceX+2,self.oldprice.frame.origin.y + self.oldprice.frame.size.height/2, textSize.width-4, self.priceline.frame.size.height);
    
    
    //新增2017-2-13
//    if(![self.stringtype isEqualToString:@"活动商品"] && ![self.typeName isEqualToString:@"热卖"])
    {
//        self.shopname.textAlignment = NSTextAlignmentCenter;
//        
//        CGFloat se_priceX = (kScreenWidth - self.se_price.frame.size.width-self.oldprice.frame.size.width)/2;
//        
//        self.se_price.frame=CGRectMake(se_priceX, olldpriceY+ZOOM(10*3.4), self.se_price.frame.size.width, ZOOM(18*3.4));
//        self.oldprice.frame = CGRectMake(CGRectGetMaxX(self.se_price.frame), self.oldprice.frame.origin.y, textSize.width, self.oldprice.frame.size.height);
//        self.priceline.frame=CGRectMake(CGRectGetMaxX(self.se_price.frame)+2,self.oldprice.frame.origin.y + self.oldprice.frame.size.height/2, textSize.width-4, self.priceline.frame.size.height);
        
//        //折扣
//        [self.discountlable removeFromSuperview];
//        UILabel *discountlable =[[UILabel alloc]init];
//        discountlable.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(20)];;
//        discountlable.frame=CGRectMake(CGRectGetMaxX(self.oldprice.frame)+ZOOM6(10), CGRectGetMinY(self.se_price.frame), ZOOM6(70), CGRectGetHeight(self.se_price.frame));
//        discountlable.textAlignment =NSTextAlignmentCenter;
//        discountlable.backgroundColor = RGBCOLOR_I(252, 19, 41);
//        discountlable.textColor = [UIColor whiteColor];
//        discountlable.clipsToBounds = YES;
//        discountlable.layer.cornerRadius = 2;
//        CGFloat scal = ((([_ShopModel.shop_se_price floatValue])/[_ShopModel.shop_price floatValue]))*10;
//        discountlable.text = [NSString stringWithFormat:@"%.1f折",scal];
//        [self.backview addSubview:self.discountlable= discountlable];
//
        CGFloat reduceMoney = [DataManager sharedManager].one_not_use_price > _ShopModel.shop_se_price.floatValue ? _ShopModel.shop_se_price.floatValue :[DataManager sharedManager].one_not_use_price;
        CGFloat discountMoney = _ShopModel.shop_se_price.floatValue *self.shop_deduction < reduceMoney ? _ShopModel.shop_se_price.floatValue *self.shop_deduction : reduceMoney;
        
        //余额抵扣
        [self.DeductibleBtn removeFromSuperview];
        self.DeductibleBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.DeductibleBtn.frame = CGRectMake(CGRectGetMaxX(self.oldprice.frame)+ZOOM6(10), CGRectGetMinY(self.se_price.frame)-ZOOM6(4), ZOOM6(240), CGRectGetHeight(self.se_price.frame)+ZOOM6(8));
        [self.DeductibleBtn setBackgroundImage:[UIImage imageNamed:@"bg_yedk"] forState:UIControlStateNormal];
        [self.DeductibleBtn setTitle:[NSString stringWithFormat:@"已抵扣%.1f元", discountMoney] forState:UIControlStateNormal];
        [self.DeductibleBtn setTintColor:[UIColor whiteColor]];
        self.DeductibleBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(26)];
        [self.DeductibleBtn addTarget:self action:@selector(Deductibleclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backview addSubview:self.DeductibleBtn];
        
        [self.dikouimage removeFromSuperview];
        self.dikouimage = [[UIButton alloc]init];
    self.dikouimage.frame=CGRectMake(CGRectGetMaxX(self.DeductibleBtn.frame)+ZOOM6(10), CGRectGetMinY(self.se_price.frame), ZOOM6(40), ZOOM6(40));
        [self.dikouimage setBackgroundImage:[UIImage imageNamed:@"shop_wenhao_red"] forState:UIControlStateNormal];
        [self.dikouimage addTarget:self action:@selector(Deductibleclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backview addSubview:self.dikouimage];
    }
    
    //回佣
    self.huiyong.hidden=YES;
    for(int i =0;i<2;i++)
    {
        UIView *view = (UIView*)[self.view viewWithTag:1919+i];
        UIView *imgview = (UIView*)[self.view viewWithTag:2929+i];
        [view removeFromSuperview];
        [imgview removeFromSuperview];
        
        UILabel *discountlable =[[UILabel alloc]init];
        discountlable.tag=1919+i;
        discountlable.font = [UIFont systemFontOfSize:ZOOM6(30)];
        [self.backview addSubview:discountlable];
        
//        if([self.stringtype isEqualToString:@"活动商品"] || [self.typeName isEqualToString:@"热卖"])
//        {
//            if(i==0)
//            {
//                discountlable.frame=CGRectMake(CGRectGetMaxX(self.oldprice.frame)+ZOOM6(50), CGRectGetMinY(self.se_price.frame), ZOOM6(120), CGRectGetHeight(self.se_price.frame));
//                discountlable.textAlignment =NSTextAlignmentCenter;
//                discountlable.backgroundColor = tarbarrossred;
//                discountlable.textColor = [UIColor whiteColor];
//                discountlable.clipsToBounds = YES;
//                discountlable.layer.cornerRadius = 2;
//                CGFloat scal = (([_ShopModel.shop_se_price floatValue]/[_ShopModel.shop_price floatValue]))*10;
//                if([self.stringtype isEqualToString:@"活动商品"] && !self.isNOFightgroups)
//                {
//                    scal = (([_ShopModel.shop_group_price floatValue]/[_ShopModel.shop_price floatValue]))*10;
//                    scal = scal <0.1?0.1:scal;
//                }
//                discountlable.text = [NSString stringWithFormat:@"%.1f折",scal];
//
//            }else if (i==1)
//            {
//                discountlable.frame=CGRectMake(CGRectGetMaxX(self.oldprice.frame)+ZOOM6(180),CGRectGetMinY(self.oldprice.frame), ZOOM6(200), CGRectGetHeight(self.oldprice.frame));
//                discountlable.textColor = tarbarrossred;
//                discountlable.textAlignment =NSTextAlignmentLeft;
//                discountlable.text = [NSString stringWithFormat:@"立省%.1f元",[_ShopModel.shop_price floatValue] - [_ShopModel.shop_se_price floatValue] ];
//                if([self.stringtype isEqualToString:@"活动商品"] && !self.isNOFightgroups)
//                {
//                    discountlable.text = [NSString stringWithFormat:@"立省%.1f元",[_ShopModel.shop_price floatValue] - [_ShopModel.shop_group_price floatValue] ];
//                }
//            }
//        }
    }
    
    //分享的用户
    CGFloat sharelableYY = CGRectGetMaxY(self.se_price.frame);
    [self.lableline1 removeFromSuperview];
    self.lableline1 = [[UILabel alloc]init];
    self.lableline1.frame = CGRectMake(0, sharelableYY+10, kApplicationWidth, 1);
    self.lableline1.backgroundColor = kBackgroundColor;
    [self.backview addSubview:self.lableline1];
    
    CGFloat lineY = CGRectGetMaxY(self.lableline1.frame);
    
    //供应商
    [self.ManufacturerImage removeFromSuperview];
    self.ManufacturerImage = nil;
    self.ManufacturerImage = [[UIImageView alloc]init];
    self.ManufacturerImage.frame = CGRectMake(ZOOM6(20), CGRectGetMaxY(self.lableline1.frame)+ZOOM6(20), ZOOM6(160), ZOOM6(160));
    self.ManufacturerImage.clipsToBounds = YES;
    self.ManufacturerImage.layer.cornerRadius = 3;
    self.ManufacturerImage.backgroundColor = [UIColor whiteColor];
    self.ManufacturerImage.contentMode = UIViewContentModeScaleAspectFit;
    
    SqliteManager *manager = [SqliteManager sharedManager];
    NSArray *brandDataArray = [[manager getAllForBrandsItem]copy];
    for(TypeTagItem *branditem in brandDataArray)
    {
        if(branditem.ID.intValue == self.suppstr.intValue){
            
            NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],branditem.icon]];
            
            [self.ManufacturerImage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
            break ;
        }
    }
    
    [self.ManufacturerLab removeFromSuperview];
    self.ManufacturerLab = nil;
    self.ManufacturerLab = [[UILabel alloc] init];
    self.ManufacturerLab.layer.borderWidth = 0;
    self.ManufacturerLab.layer.cornerRadius=3;
    self.ManufacturerLab.layer.borderColor = tarbarrossred.CGColor;
    self.ManufacturerLab.textColor = tarbarrossred;
    self.ManufacturerLab.textAlignment = NSTextAlignmentLeft;
    self.ManufacturerLab.font = [UIFont systemFontOfSize:ZOOM6(24)];
    self.ManufacturerLab.text = [NSString stringWithFormat:@"%@",self.content1];
    self.ManufacturerLab.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *manufactap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Manufacturer)];
    [self.ManufacturerLab addGestureRecognizer:manufactap];
    
    CGFloat manufactureWith = [self getRowWidth:self.ManufacturerLab.text fontSize:ZOOM6(28)];
    self.ManufacturerLab.frame =CGRectMake(CGRectGetMaxX(self.ManufacturerImage.frame)+ZOOM6(20), CGRectGetMaxY(self.lableline1.frame)+ZOOM6(20), manufactureWith+ZOOM6(30), ZOOM6(160));
    
    [self.ManufacturerBtn removeFromSuperview];
    self.ManufacturerBtn = nil;
    CGFloat btnwidth = [self getRowWidth:self.content1 fontSize:ZOOM6(28)] + ZOOM6(80);
    self.ManufacturerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ManufacturerBtn.frame = CGRectMake((kScreenWidth-btnwidth)/2, CGRectGetMaxY(self.lableline1.frame)+ZOOM6(20), btnwidth, ZOOM6(60));
    self.ManufacturerBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(24)];
    [self.ManufacturerBtn setTitleColor:RGBCOLOR_I(125, 125, 125) forState:UIControlStateNormal];
    [self.ManufacturerBtn setImage:[UIImage imageNamed:@"shop-go-"] forState:UIControlStateNormal];
    [self.ManufacturerBtn setTitle:self.content1 forState:UIControlStateNormal];
    [self.ManufacturerBtn setTitleColor:tarbarrossred forState:UIControlStateNormal];
    self.ManufacturerBtn.layer.borderWidth = 1;
    self.ManufacturerBtn.layer.borderColor = tarbarrossred.CGColor;
    self.ManufacturerBtn.layer.cornerRadius = 5;
    [self.ManufacturerBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [self.ManufacturerBtn setImageEdgeInsets:UIEdgeInsetsMake(0, btnwidth-ZOOM6(50), 0, 0)];
    [self.ManufacturerBtn addTarget:self action:@selector(Manufacturer) forControlEvents:UIControlEventTouchUpInside];
    
//    UIImageView *goimg = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.ManufacturerLab.frame)-ZOOM6(40),(CGRectGetHeight(self.ManufacturerLab.frame)-ZOOM6(24))/2, ZOOM6(24), ZOOM6(24))];
//    goimg.image = [UIImage imageNamed:@"shop-go-"];
//    [self.ManufacturerLab addSubview:goimg];
    
    if(self.content1.length >0 && ![self.content1 isEqualToString:@"(null)"] && ![self.content1 isEqualToString:@"<null>"])
    {
        lineY += ZOOM6(100);
        self.backview.userInteractionEnabled = YES;
//        [self.backview addSubview:self.ManufacturerLab];
//        [self.backview addSubview:self.ManufacturerImage];
        [self.backview addSubview:self.ManufacturerBtn];
    }
    
    CGFloat discriptionlabHeigh = (kScreenWidth)/4.2;
    [self.fwcnview removeFromSuperview];
    self.fwcnview = [[UIImageView alloc]init];
    self.fwcnview.frame = CGRectMake(0, lineY, kScreenWidth, discriptionlabHeigh);
    self.fwcnview.image = [UIImage imageNamed:@"服务承诺fwcn"];
    [self.backview addSubview:self.fwcnview];
    
    
//    lineY +=discriptionlabHeigh;
    
    self.backview.frame = CGRectMake(0, self.backview.frame.origin.y, self.backview.frame.size.width, CGRectGetMaxY(self.fwcnview.frame));
    CGFloat backviewYY=CGRectGetMaxY(self.backview.frame);
    
    self.Myscrollview.frame=CGRectMake(0, self.Myscrollview.frame.origin.y, kApplicationWidth, backviewYY);
    self.Myscrollview.backgroundColor=[UIColor whiteColor];
    self.MyBigtableview.tableHeaderView = self.Myscrollview;
}
#pragma mark 创建tableview section 视图
-(void)creatSectionView
{
    //详情 尺码 评价
    UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 40)];
    headview.backgroundColor=[UIColor whiteColor];
    
    
    UILabel *linelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 39, kApplicationWidth, 1)];
    linelable.backgroundColor=kBackgroundColor;
//    [headview addSubview:linelable];
    
    
    NSString *comstr=[NSString stringWithFormat:@"评论(%d)",_ShopModel.eva_count.intValue];
//    NSArray *titleArr=@[@"商品详情",@"参数",comstr];
    NSArray *titleArr=@[@"商品详情"];
    CGFloat btnwidh=kApplicationWidth/titleArr.count;
    for(int i=0;i<titleArr.count;i++)
    {
        //按钮
        UIButton * stateBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        stateBtn.frame=CGRectMake(btnwidh*i, 0, btnwidh, 40);
        [stateBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [stateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        stateBtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(45)];
        stateBtn.tag = 1000+i;
        [stateBtn addTarget:self action:@selector(butclick:) forControlEvents:UIControlEventTouchUpInside];
        //        [stateBtn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [headview addSubview:stateBtn];
        
        UILabel *linelable=[[UILabel alloc]initWithFrame:CGRectMake(kApplicationWidth/3 *(i+1), 10, 1, 20)];
        linelable.backgroundColor=kBackgroundColor;
//        [headview addSubview:linelable];
        
        //状态条
        _statelab=[[UILabel alloc]initWithFrame:CGRectMake(btnwidh*i, 35, btnwidh, 5)];
        _statelab.backgroundColor=[UIColor clearColor];
        _statelab.tag=2000+i;
        [headview addSubview:_statelab];
        
        //设置进来时选中的按键
        
        
        if(0==i)
        {
            [stateBtn setTitleColor:tarbarrossred forState:UIControlStateNormal];;
            stateBtn.selected=YES;
            self.slectbtn=stateBtn;
            _btnTag = 1000;
            self.BigDataArray =[NSMutableArray arrayWithArray:self.dataArr];
        }
        
    }
    
    _headView=headview;
    
}

#pragma mark 创建列表视图
-(void)creatBigTableview
{
    for (UIView *view in self.contentBackgroundView.subviews) {
        if (view == self.MyBigtableview) {
            return;
        }
    }
    CGFloat viewHeigh = kIOSVersions >= 11 ? -Height_StatusBar:0;
    self.MyBigtableview = [[UITableView alloc]initWithFrame:CGRectMake(0, viewHeigh, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY-50-viewHeigh) style:UITableViewStylePlain];
   
    self.MyBigtableview.delegate=self;
    self.MyBigtableview.dataSource=self;
    self.MyBigtableview.scrollsToTop = NO;
    self.MyBigtableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.Myscrollview.frame=CGRectMake(0, 0, self.Myscrollview.frame.size.width, self.Myscrollview.frame.size.height+5);
    
    [self.MyBigtableview setTranslatesAutoresizingMaskIntoConstraints:YES];
    
//    self.MyBigtableview.estimatedRowHeight = 60;
    self.Myscrollview.clipsToBounds = YES;
    self.Myscrollview.scrollsToTop=NO;
    self.MyBigtableview.tableHeaderView = self.Myscrollview;
    self.MyBigtableview.tableFooterView=_tableFootView;
    [self.view addSubview:self.MyBigtableview];
    
    [self.MyBigtableview registerNib:[UINib nibWithNibName:@"ImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"imagecell"];
    [self.MyBigtableview registerNib:[UINib nibWithNibName:@"OneCommentCell" bundle:nil] forCellReuseIdentifier:@"ONECOMMENTCELL"];
    [self.MyBigtableview registerNib:[UINib nibWithNibName:@"TwoCommentCell" bundle:nil] forCellReuseIdentifier:@"TWOCOMMENTCELL"];
    [self.MyBigtableview registerNib:[UINib nibWithNibName:@"ThreeCommentCell" bundle:nil] forCellReuseIdentifier:@"THREECOMMENTCELL"];
    [self.MyBigtableview registerNib:[UINib nibWithNibName:@"FourCommentCell" bundle:nil] forCellReuseIdentifier:@"FOURCOMMENTCELL"];
    [self.MyBigtableview registerNib:[UINib nibWithNibName:@"FiveCommentCell" bundle:nil] forCellReuseIdentifier:@"FIVECOMMENTCELL"];
    [self.MyBigtableview registerNib:[UINib nibWithNibName:@"SixCommentCell" bundle:nil] forCellReuseIdentifier:@"SIXCOMMENTCELL"];
    [self.MyBigtableview registerNib:[UINib nibWithNibName:@"PreferredMoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"PreferredCell"];
#pragma ******************去掉左滑搜索******************
    
    [self.view bringSubviewToFront:self.screenBtn];
}
- (void)dismissPromptview
{
    if (!_promptview) {
        return;
    }
    [UIView animateWithDuration:1.0 animations:^{
        
        
        _promptview.frame = CGRectMake(0, kApplicationHeight+30+kUnderStatusBarStartY, kApplicationWidth, 40);
        
    } completion:^(BOOL finished) {
        
        [_promptview removeFromSuperview];
        _promptview = nil;
        
    }];
}
#pragma mark 创建普通商品脚底视图
-(void)creatFootView
{
    
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-55+kUnderStatusBarStartY, kApplicationWidth, 55)];
    footView.backgroundColor=[UIColor whiteColor];
    footView.tag = 8181;
    
    [self.view addSubview:footView];
    [self.view bringSubviewToFront:footView];
    
    NSArray *arr=[NSArray array];
    int count = 2;
   
    if(_isMonday == YES)
    {
        arr = @[@"购买即赢千元大奖"];
        count = 1;
    }else if ([DataManager sharedManager].is_OneYuan)
    {
        if(self.isNewbie)
        {
            arr=@[@"0元购买",@"单独购买"];
        }else{
            arr=@[@"单独购买"];
        }
        
        count = 1;
    }
    else{
        arr = @[@"立即购买"];
        count = 1;
    }
    
    
    CGFloat btnwith = ZOOM6(140);
    CGFloat Tbtnwith = ZOOM6(190);
    
    //客服
    for(int i=0;i<count;i++)
    {
        if (i == count-1) {

            CGFloat wt =Tbtnwith;

            UIButton *shopbtn= [[UIButton alloc]init];
            shopbtn = [[UIButton alloc] initWithFrame:CGRectMake(Tbtnwith*i,0, wt, 55)];
            shopbtn.tintColor=[UIColor blackColor];
            shopbtn.tag=4000+i;
            
            [footView addSubview:shopbtn];
            
            UIImageView *shopimageview=[[UIImageView alloc] init];
            UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, self.isNOFightgroups?Tbtnwith:Tbtnwith, 20)];
            titlelable.textAlignment=NSTextAlignmentCenter;
            titlelable.font=[UIFont systemFontOfSize:ZOOM(34)];
            titlelable.textColor=kTextColor;
            [shopbtn addSubview:shopimageview];
            [shopbtn addSubview:titlelable];
            
            shopimageview.frame=CGRectMake((titlelable.frame.size.width-IMGSIZEW(@"lianxikefu-black"))/2, 8, IMGSIZEW(@"lianxikefu-black"), IMGSIZEH(@"lianxikefu-black"));
            shopimageview.image=[UIImage imageNamed:@"lianxikefu-black"];
            shopimageview.contentMode=UIViewContentModeScaleAspectFit;
            
            titlelable.text=@"客服";
            self.likebtn=shopbtn;
            self.likeImageView = shopimageview;
            
            [shopbtn addTarget:self action:@selector(kefulick:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            UIButton *shopbtn= [[UIButton alloc]init];
            if(i<2)
            {
                if(self.isNOFightgroups == YES)
                {
                    shopbtn.frame=CGRectMake(Tbtnwith*i,0, Tbtnwith, 55);
                }else
                    shopbtn.frame=CGRectMake(btnwith*i,0, btnwith, 55);
            }else{
                shopbtn.frame=CGRectMake(Tbtnwith*i,0, Tbtnwith, 55);
            }
            shopbtn.tintColor=[UIColor blackColor];
            shopbtn.tag=4000+i;
            
            [footView addSubview:shopbtn];
            
            UIImageView *shopimageview=[[UIImageView alloc] init];
            UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, self.isNOFightgroups?Tbtnwith:btnwith, 20)];
            titlelable.textAlignment=NSTextAlignmentCenter;
            titlelable.font=[UIFont systemFontOfSize:ZOOM(34)];
            titlelable.textColor=kTextColor;
            [shopbtn addSubview:shopimageview];
            [shopbtn addSubview:titlelable];
            if(i==0)
            {
                shopimageview.frame=CGRectMake((titlelable.frame.size.width-IMGSIZEW(@"lianxikefu-black"))/2, 8, IMGSIZEW(@"lianxikefu-black"), IMGSIZEH(@"lianxikefu-black"));
                shopimageview.image=[UIImage imageNamed:@"lianxikefu-black"];
                shopimageview.contentMode=UIViewContentModeScaleAspectFit;

                titlelable.text=@"客服";
                self.likebtn=shopbtn;
                self.likeImageView = shopimageview;
                
                [shopbtn addTarget:self action:@selector(kefulick:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    
    //加购物车 购买
    CGFloat shopbtnwidh=(kApplicationWidth-Tbtnwith)/2;
    for(int i=0;i<arr.count;i++)
    {
        UIButton *contactbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        if(_isMonday == YES || ![DataManager sharedManager].is_OneYuan || [DataManager sharedManager].is_OneYuan)
        {
            contactbtn.frame=CGRectMake(Tbtnwith, 0, kApplicationWidth-Tbtnwith, 55);
        }else{
            contactbtn.frame=CGRectMake(kApplicationWidth-shopbtnwidh*i-shopbtnwidh, 0, shopbtnwidh, 55);
        }
        
        contactbtn.tintColor=tarbarrossred;
        contactbtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM6(32)];
//        contactbtn.tag=3001-i;
        
        contactbtn.titleLabel.numberOfLines = 0;
        contactbtn.tag = 3001+i;
        NSString *pubstr = @"";
        if(i==0)
        {
            if(_isMonday == YES)
            {
                [contactbtn setTitle:@"购买即赢千元大奖" forState:UIControlStateNormal];
            }else if(![DataManager sharedManager].is_OneYuan)
            {
                pubstr = [NSString stringWithFormat:@"  ￥%.1f",[_ShopModel.shop_se_price floatValue]];
                if(_ShopModel.shop_se_price.floatValue > 0)
                {
                    [contactbtn setTitle:[NSString stringWithFormat:@"  ￥%.1f\n立即购买",[_ShopModel.shop_se_price floatValue]-[DataManager sharedManager].OneYuan_count] forState:UIControlStateNormal];
                }else{
                    [contactbtn setTitle:[NSString stringWithFormat:@"  ￥%.1f\n立即购买",[_ShopModel.shop_se_price floatValue]] forState:UIControlStateNormal];
                }
                contactbtn.backgroundColor=RGBCOLOR_I(255, 156, 197);
                contactbtn.tintColor=tarbarrossred;
                
            }else if([DataManager sharedManager].is_OneYuan)
            {
                pubstr = [NSString stringWithFormat:@"  ￥%.1f",[_ShopModel.shop_se_price floatValue]];
                CGFloat rewardMoney = _ShopModel.shop_se_price.floatValue*0.5 > 50?50:_ShopModel.shop_se_price.floatValue*0.5;
                if(_ShopModel.shop_se_price.floatValue > 0)
                {
                    CGFloat mymoney = [self.viewmodel get_discount_price:_ShopModel.shop_se_price.floatValue DiscountMoney:[DataManager sharedManager].one_not_use_price MaxViptype:self.maxType Shop_deduction:self.shop_deduction];
                    
                    if(mymoney > 0)
                    {
                        [contactbtn setTitle:[NSString stringWithFormat:@"  ￥%.1f\n 赚￥%.1f",mymoney,rewardMoney] forState:UIControlStateNormal];
                    }else{
                        [contactbtn setTitle:[NSString stringWithFormat:@"  ￥%.1f\n 赚￥%.1f",0.0,rewardMoney] forState:UIControlStateNormal];
                    }
                    
                }else{
                    [contactbtn setTitle:[NSString stringWithFormat:@" ￥%.1f\n 赚￥%.1f",[_ShopModel.shop_se_price floatValue],rewardMoney] forState:UIControlStateNormal];
                }
                contactbtn.backgroundColor=RGBCOLOR_I(255, 156, 197);
                contactbtn.tintColor=[UIColor whiteColor];
            }
            else{
                pubstr = [NSString stringWithFormat:@"  ￥%.2f",[_ShopModel.shop_group_price floatValue]];
                if(self.isNewbie)
                {
                    [contactbtn setTitle:[NSString stringWithFormat:@"  ￥%.1f\n%.0f元购买",0.0,0.0] forState:UIControlStateNormal];
                }else{                    
                    [contactbtn setTitle:[NSString stringWithFormat:@"  ￥%.1f\n %@",self.app_shop_group_price.floatValue,self.returnOneText] forState:UIControlStateNormal];
                }
                
                contactbtn.tintColor=tarbarrossred;
            }
        }else{
            
            pubstr = [NSString stringWithFormat:@"  ￥%.1f",[_ShopModel.shop_se_price floatValue]];
            CGFloat rewardMoney = _ShopModel.shop_se_price.floatValue*0.5 > 50?50:_ShopModel.shop_se_price.floatValue*0.5;
            if(_ShopModel.shop_se_price.floatValue > 0)
            {
                CGFloat mymoney = [_ShopModel.shop_se_price floatValue]-[DataManager sharedManager].one_not_use_price;
                
                if(mymoney > 0)
                {
                    [contactbtn setTitle:[NSString stringWithFormat:@"  ￥%.1f\n 赚￥%.1f",mymoney,rewardMoney] forState:UIControlStateNormal];
                }else{
                    [contactbtn setTitle:[NSString stringWithFormat:@"  ￥%.1f\n 赚￥%.1f",0.0,rewardMoney] forState:UIControlStateNormal];
                }
                
            }else{
                [contactbtn setTitle:[NSString stringWithFormat:@" ￥%.1f\n 赚￥%.1f",[_ShopModel.shop_se_price floatValue],rewardMoney] forState:UIControlStateNormal];
            }
            contactbtn.backgroundColor=RGBCOLOR_I(255, 156, 197);
            contactbtn.tintColor=[UIColor whiteColor];
        }
        
        if(self.is_group == NO && pubstr.length >0)
        {
            NSString *pricestr = pubstr;
            
            NSMutableAttributedString *mut = [[NSMutableAttributedString alloc]initWithString:contactbtn.titleLabel.text];
            [mut addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(38)] range:NSMakeRange(0, pricestr.length)];
            [contactbtn.titleLabel setAttributedText:mut];
        }
        
        [contactbtn addTarget:self action:@selector(contactClick:) forControlEvents:UIControlEventTouchUpInside];
        if(i==0)
        {
            contactbtn.backgroundColor=tarbarrossred;
            contactbtn.tintColor=[UIColor whiteColor];
        }else{
            contactbtn.tintColor=tarbarrossred;
        }
        
        [footView addSubview:contactbtn];
    }

    //分割线
    UILabel *butlable1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Tbtnwith, 1)];
    butlable1.backgroundColor=kBackgroundColor;
    
    UILabel *butlable2=[[UILabel alloc]init];
    UILabel *butlable3=[[UILabel alloc]init];
    butlable2.backgroundColor=kBackgroundColor;
    butlable3.backgroundColor=kBackgroundColor;
    
    butlable2.frame = CGRectMake(Tbtnwith, 0, 1, 55);
        
    [footView addSubview:butlable1];
    [footView addSubview:butlable2];
    [footView addSubview:butlable3];
    
    
    int cart2= (int)[ShopCarManager sharedManager].p_count ;
    if(cart2>0)
        //    if(_ShopModel.cart_count.intValue > 0)
    {
        //关闭定时器
        [_mytimer invalidate];
        _mytimer = nil;
        _isMove = NO;
        
        [self addpop:@"商品详情"];
    }
    
}

-(void)creatActiveFootView
{
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-55+kUnderStatusBarStartY, kApplicationWidth, 55)];
    footView.backgroundColor=[UIColor whiteColor];
    footView.tag = 8181;
    
    [self.view addSubview:footView];
    [self.view bringSubviewToFront:footView];
    
    NSString *zerosstt = @"";
    if(!self.isFight)
    {
        zerosstt = @"0元购全返";
    }

    NSArray *arr=[NSArray array];
    int count = 2;
    if ([self.stringtype isEqualToString:@"活动商品"])
    {
        if(self.isNOFightgroups == YES)
        {
            arr= zerosstt.length?@[zerosstt]:@[@"立即购买"];
            count = 1;
        }else{
            arr=@[@"10人成团",@"单独购买"];
            count = 1;
        }
    }
    else{
        NSString *sstt = _isMonday?@"购买即赢千元大奖":@"立即购买";
        arr=@[zerosstt.length?zerosstt:sstt,@"加入购物车"];
    }
    CGFloat btnwith = ZOOM6(140);
    CGFloat Tbtnwith = ZOOM6(190);
    
    //喜欢 购物车
    for(int i=0;i<count;i++)
    {
        if (i == count-1) {

            CGFloat wt =[self.stringtype isEqualToString:@"活动商品"]?Tbtnwith:btnwith;

//            if(self.isNOFightgroups == YES)
//            {
//                _carBtn = [[YFShopCarView alloc] initWithFrame:CGRectMake(Tbtnwith*i,0, wt, 55)];
//            }else{
//                _carBtn = [[YFShopCarView alloc] initWithFrame:CGRectMake(btnwith*i,0, wt, 55)];
//            }
//
//            _carBtn.tag = 4000+i;
//            _carBtn.markNumber = _pubCartcount;
//
//            kSelfWeak;
//            _carBtn.btnClick = ^(YFShopCarView *view){
//                [weakSelf shopClick:(UIButton *)view];
//            };
//            [footView addSubview:_carBtn];
            
            UIButton *shopbtn= [[UIButton alloc]init];
            if(self.isNOFightgroups == YES)
            {
                shopbtn = [[UIButton alloc] initWithFrame:CGRectMake(Tbtnwith*i,0, wt, 55)];
            }else{
                shopbtn = [[UIButton alloc] initWithFrame:CGRectMake(Tbtnwith*i,0, wt, 55)];
            }
            
            shopbtn.tintColor=[UIColor blackColor];
            shopbtn.tag=4000+i;
            
            [footView addSubview:shopbtn];
            
            UIImageView *shopimageview=[[UIImageView alloc] init];
            UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, self.isNOFightgroups?Tbtnwith:Tbtnwith, 20)];
            titlelable.textAlignment=NSTextAlignmentCenter;
            titlelable.font=[UIFont systemFontOfSize:ZOOM(34)];
            titlelable.textColor=kTextColor;
            [shopbtn addSubview:shopimageview];
            [shopbtn addSubview:titlelable];
           
            shopimageview.frame=CGRectMake((titlelable.frame.size.width-IMGSIZEW(@"lianxikefu-black"))/2, 8, IMGSIZEW(@"lianxikefu-black"), IMGSIZEH(@"lianxikefu-black"));
            shopimageview.image=[UIImage imageNamed:@"lianxikefu-black"];
            shopimageview.contentMode=UIViewContentModeScaleAspectFit;
            
            titlelable.text=@"客服";
            self.likebtn=shopbtn;
            self.likeImageView = shopimageview;
            
            [shopbtn addTarget:self action:@selector(kefulick:) forControlEvents:UIControlEventTouchUpInside];
            
        } else {
        
            UIButton *shopbtn= [[UIButton alloc]init];
            if(i<2)
            {
                if(self.isNOFightgroups == YES)
                {
                    shopbtn.frame=CGRectMake(Tbtnwith*i,0, Tbtnwith, 55);
                }else
                    shopbtn.frame=CGRectMake(btnwith*i,0, btnwith, 55);
            }else{
                shopbtn.frame=CGRectMake(Tbtnwith*i,0, Tbtnwith, 55);
            }
            shopbtn.tintColor=[UIColor blackColor];
            shopbtn.tag=4000+i;
            
            [footView addSubview:shopbtn];
            
            UIImageView *shopimageview=[[UIImageView alloc] init];
            UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, self.isNOFightgroups?Tbtnwith:btnwith, 20)];
            titlelable.textAlignment=NSTextAlignmentCenter;
            titlelable.font=[UIFont systemFontOfSize:ZOOM(34)];
            titlelable.textColor=kTextColor;
            [shopbtn addSubview:shopimageview];
            [shopbtn addSubview:titlelable];
            if(i==0)
            {
                shopimageview.frame=CGRectMake((titlelable.frame.size.width-IMGSIZEW(@"lianxikefu-black"))/2, 8, IMGSIZEW(@"lianxikefu-black"), IMGSIZEH(@"lianxikefu-black"));
                shopimageview.image=[UIImage imageNamed:@"lianxikefu-black"];
                shopimageview.contentMode=UIViewContentModeScaleAspectFit;
                
                titlelable.text=@"客服";
                self.likebtn=shopbtn;
                self.likeImageView = shopimageview;
                
                [shopbtn addTarget:self action:@selector(kefulick:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    
    //加购物车 购买
    CGFloat shopbtnwidh=(kApplicationWidth-btnwith*2)/2;
    CGFloat shopbtnwidh2 = shopbtnwidh*0.6;
    CGFloat shopbtnwidh1 = shopbtnwidh*1.4;
    if([self.stringtype isEqualToString:@"活动商品"])
    {
        shopbtnwidh=(kApplicationWidth - Tbtnwith)/2;
        if(self.isNOFightgroups == YES)
        {
            shopbtnwidh=kApplicationWidth - Tbtnwith*2;
        }
    }
    
    for(int i=0;i<arr.count;i++)
    {
        UIButton *contactbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        if(self.isNOFightgroups == YES)
        {
            contactbtn.frame=CGRectMake(Tbtnwith, 0, kApplicationWidth-Tbtnwith, 55);
        }else{
            contactbtn.frame=CGRectMake(kApplicationWidth-shopbtnwidh*i-shopbtnwidh, 0, shopbtnwidh, 55);
        }
        contactbtn.tintColor=tarbarrossred;
        contactbtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM6(30)];
        contactbtn.tag=3001-i;
        if([self.stringtype isEqualToString:@"活动商品"])
        {
            contactbtn.titleLabel.numberOfLines = 0;
            contactbtn.tag = 3001+i;
            NSString *pubstr = @"";
            if(i==0)
            {
                if(self.isNOFightgroups == YES)
                {
                    [contactbtn setTitle:@"0元购全返" forState:UIControlStateNormal];
                }else{
                    pubstr = [NSString stringWithFormat:@"   ￥%.2f",[_ShopModel.shop_group_price floatValue]];
                    [contactbtn setTitle:[NSString stringWithFormat:@"   ￥%.2f\n%@人成团",[_ShopModel.shop_group_price floatValue],[Signmanager SignManarer].rnum] forState:UIControlStateNormal];
                }
                
            }else{
                pubstr = [NSString stringWithFormat:@"   ￥%.1f",[_ShopModel.shop_se_price floatValue]];
                [contactbtn setTitle:[NSString stringWithFormat:@"   ￥%.1f\n单独购买",[_ShopModel.shop_se_price floatValue]] forState:UIControlStateNormal];
                contactbtn.backgroundColor=RGBCOLOR_I(255, 156, 197);
                contactbtn.tintColor=[UIColor whiteColor];
            }
            
            if(self.is_group == NO && pubstr.length >0)
            {
                NSString *pricestr = pubstr;
                
                NSMutableAttributedString *mut = [[NSMutableAttributedString alloc]initWithString:contactbtn.titleLabel.text];
                [mut addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:ZOOM6(24)] range:NSMakeRange(0, pricestr.length)];
                [contactbtn.titleLabel setAttributedText:mut];
            }
            
        }else{
            if(i==0)
            {
                shopbtnwidh = shopbtnwidh1;
                contactbtn.frame=CGRectMake(kApplicationWidth-shopbtnwidh1*i-shopbtnwidh1, 0, shopbtnwidh1, 55);
                
                [contactbtn setTitle:arr[i] forState:UIControlStateNormal];
                if([contactbtn.titleLabel.text isEqualToString:@"0元购全返"])
                {
                    [contactbtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(36)]];
                }
                self.buyBtn = contactbtn;
            }else{
                contactbtn.frame=CGRectMake(kApplicationWidth-shopbtnwidh1*i-shopbtnwidh2, 0, shopbtnwidh2, 55);
                [contactbtn setImage:[UIImage imageNamed:@"icon_jiagouwuche"] forState:UIControlStateNormal];
            }
        }
        
        [contactbtn addTarget:self action:@selector(contactClick:) forControlEvents:UIControlEventTouchUpInside];
        if(i==0)
        {
            contactbtn.backgroundColor=tarbarrossred;
            contactbtn.tintColor=[UIColor whiteColor];
        }
        
        [footView addSubview:contactbtn];
    }
    
    //分割线
    UILabel *butlable1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth-shopbtnwidh, 1)];
    butlable1.backgroundColor=kBackgroundColor;
    
    UILabel *butlable2=[[UILabel alloc]init];
    UILabel *butlable3=[[UILabel alloc]init];
    butlable2.backgroundColor=kBackgroundColor;
    butlable3.backgroundColor=kBackgroundColor;
    
    if([self.stringtype isEqualToString:@"活动商品"])
    {
        if(!self.isNOFightgroups)
        {
            butlable1.frame = CGRectMake(0, 0, Tbtnwith, 1);
        }else{
            butlable1.frame = CGRectMake(0, 0, Tbtnwith, 1);
        }
        butlable2.frame = CGRectMake(Tbtnwith, 0, 1, btnwith);
    }else{
        butlable2.frame = CGRectMake(btnwith, 1, 1, btnwith);
        butlable3.frame = CGRectMake(btnwith*2, 1, 1, btnwith);
    }
    
    [footView addSubview:butlable1];
    [footView addSubview:butlable2];
    [footView addSubview:butlable3];
    
    int cart2= (int)[ShopCarManager sharedManager].p_count ;
    if(cart2>0)
        //    if(_ShopModel.cart_count.intValue > 0)
    {
        //关闭定时器
        [_mytimer invalidate];
        _mytimer = nil;
        _isMove = NO;
        
        [self addpop:@"商品详情"];
    }
}



#pragma mark 分享视图
- (void)creatShareModelView:(NSString*)imageurl
{
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY)];
    backview.tag=9797;
    
    [self.view addSubview:backview];
    
    _shareModelview = [[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight+30, kApplicationWidth, SHAREMODELVIEW_HEIGH)];
    _shareModelview.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_shareModelview];
    
    //生活图片
    _shareBigimgview = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-ZOOM6(570))/2, -ZOOM6(900), ZOOM6(570), ZOOM6(800))];
    
    if([imageurl hasPrefix:@"http"])
    {
        [_shareBigimgview sd_setImageWithURL:[NSURL URLWithString:imageurl]];
    }else{
        _shareBigimgview.image = [UIImage imageNamed:imageurl];
    }
    
    UIView *shareBaseView = [[UIView alloc]initWithFrame:CGRectMake(0,ZOOM6(60), kScreenWidth, SHAREMODELVIEW_HEIGH+kUnderStatusBarStartY)];
    shareBaseView.backgroundColor = [UIColor whiteColor];
    [_shareModelview addSubview:shareBaseView];
    
    //奖励文字
    CGFloat titlelable1Y = ZOOM(20);
    UILabel *titlelable1 = [[UILabel alloc]initWithFrame:CGRectMake(10, titlelable1Y, kApplicationWidth-20, 30)];
    titlelable1.frame=CGRectMake(0, titlelable1Y+ZOOM(20), kScreenWidth-2*ZOOM(20), 40);
    titlelable1.textAlignment = NSTextAlignmentCenter;
    titlelable1.font = [UIFont systemFontOfSize:ZOOM6(36)];
    titlelable1.textColor = RGBCOLOR_I(125, 125, 125);
    titlelable1.clipsToBounds=YES;
    
    if(!_is_oneLuck_share)
    {
        titlelable1.text = @"分享美衣赢50元提现额度";
        
        NSMutableAttributedString *noteStr ;
        if(titlelable1.text)
        {
            noteStr = [[NSMutableAttributedString alloc]initWithString:titlelable1.text];
        }
        NSString *str = [NSString stringWithFormat:@"%@元",@"50"];
        
        [noteStr addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(5, str.length)];
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:ZOOM6(56)] range:NSMakeRange(5, str.length-1)];
        [titlelable1 setAttributedText:noteStr];
    }else{
        if(self.isNewbie)
        {
            titlelable1.text = @"分享至任意微信群后即可0元购买";
        }else{
            titlelable1.text = [NSString stringWithFormat:@"分享至任意微信群后即可%.1f元购买",self.app_shop_group_price.floatValue];
        }
    }
    
    
    //赚钱小秘密
    UIButton *SecretBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    if(_is_oneLuck_share)
    {
        SecretBtn.frame = CGRectMake(CGRectGetMaxX(titlelable1.frame)-ZOOM6(120), CGRectGetMinY(titlelable1.frame)-ZOOM(20), 50, CGRectGetHeight(titlelable1.frame)+ZOOM(40));
    }else{
        SecretBtn.frame = CGRectMake(CGRectGetMaxX(titlelable1.frame)-ZOOM6(120), CGRectGetMinY(titlelable1.frame)-ZOOM(10), 50, CGRectGetHeight(titlelable1.frame)+ZOOM(40));
    }
    
    [SecretBtn addTarget:self action:@selector(moretap) forControlEvents:UIControlEventTouchUpInside];
    
    [shareBaseView addSubview:titlelable1];
    if(!_is_oneLuck_share)
    {
        [self.view addSubview:_shareBigimgview];
    
        [shareBaseView addSubview:SecretBtn];
    }

    CGFloat imageHeigh = 20;
    UIImageView *secretImage = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(SecretBtn.frame)-imageHeigh)/2, (CGRectGetHeight(SecretBtn.frame)-imageHeigh)/2, imageHeigh, imageHeigh)];
    secretImage.image = [UIImage imageNamed:@"shop_wenhao_red"];
    [SecretBtn addSubview:secretImage];
    
//    记录弹出时间（每天只弹一次）
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDate *record = [user objectForKey:SECRETDATE];
    if([[MyMD5 compareDate:record] isEqualToString:@"昨天"] || record==nil )
    {
        qdnImgView = secretImage;
        qdaImgView = [[UIImageView alloc] initWithFrame:secretImage.frame];
        qdaImgView.image = [UIImage imageNamed:@"shop_wenhao"];
        qdaImgView.layer.opacity = 0;
        [SecretBtn addSubview:qdaImgView];
        
        [qdnImgView opacityStatus:YES time:2 fromValue:1 toValue:0];
        [qdaImgView opacityStatus:YES time:2 fromValue:0 toValue:1];
        
    }
    NSArray *titleArray = @[@"微信群",@"朋友圈",@"QQ空间"];
    CGFloat dismissbtnYY =0;
    //分享平台
    for (int i=0; i<3; i++) {
        
        CGFloat space = (kScreenWidth - ZOOM6(300) -ZOOM6(90)*2)/2;
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        shareBtn.frame = CGRectMake((space+ZOOM6(100))*i+ZOOM6(90),CGRectGetMaxY(titlelable1.frame)+ZOOM6(40), ZOOM6(100), ZOOM6(100));
        shareBtn.frame = CGRectMake((kScreenWidth-ZOOM6(420))/2, CGRectGetMaxY(titlelable1.frame)+ZOOM6(50), ZOOM6(420), ZOOM6(88));
        shareBtn.tag = 9000+i;
        [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *sharetitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(shareBtn.frame)-20, CGRectGetMaxY(shareBtn.frame)+ZOOM6(10), CGRectGetWidth(shareBtn.frame)+40, 0)];
        sharetitle.text = titleArray[i];
        sharetitle.textColor = RGBCOLOR_I(168, 168, 168);
        sharetitle.font = [UIFont systemFontOfSize:ZOOM6(24)];
        sharetitle.textAlignment = NSTextAlignmentCenter;
        
        dismissbtnYY = CGRectGetMaxY(sharetitle.frame);
        
        if (i==0) {//微信好友
            
            //判断设备是否安装微信
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                
                //判断是否有微信
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"分享到微信群"] forState:UIControlStateNormal];
                
            }else {
                
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                sharetitle.hidden = YES;
                
            }
            
        }else if (i==1){//微信朋友圈
            
            //判断设备是否安装微信
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                
                //判断是否有微信
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"朋友圈-1"] forState:UIControlStateNormal];
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                sharetitle.hidden = YES;
                
            }else {
                
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                sharetitle.hidden = YES;
                
            }
        }else{//QQ空间
            
            
            //判断设备是否安装QQ
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
            {
                //判断是否有qq
                
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"qq空间-1"] forState:UIControlStateNormal];
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                sharetitle.hidden = YES;
                
            }else{
                
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                sharetitle.hidden = YES;
            }
            
        }
//        [shareBaseView addSubview:sharetitle];
        [shareBaseView addSubview:shareBtn];
        
    }
    
    
    //取消按钮
    UIButton *dismissbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dismissbtn.frame = CGRectMake(ZOOM6(90), dismissbtnYY+ZOOM6(50), kScreenWidth-ZOOM6(90)*2, ZOOM6(80));
    dismissbtn.layer.borderColor = RGBCOLOR_I(125, 125, 125).CGColor;
    dismissbtn.layer.borderWidth = 1;
    dismissbtn.layer.cornerRadius = 5;
    [dismissbtn setTitleColor:RGBCOLOR_I(125, 125, 125) forState:UIControlStateNormal];
    dismissbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    [dismissbtn setTitle:@"取消" forState:UIControlStateNormal];
    [dismissbtn addTarget:self action:@selector(dismissShareView) forControlEvents:UIControlEventTouchUpInside];
    [shareBaseView addSubview:dismissbtn];
    
    backview.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        backview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        _shareModelview.frame=CGRectMake(0, kApplicationHeight-SHAREMODELVIEW_HEIGH+kUnderStatusBarStartY, kApplicationWidth, SHAREMODELVIEW_HEIGH);
        
        _shareBigimgview.frame=CGRectMake(_shareBigimgview.frame.origin.x, ZOOM6(60), _shareBigimgview.frame.size.width, _shareBigimgview.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        
    }];
}

#pragma mark 分享视图
- (void)creatOneYuanShareModelView:(NSString*)imageurl
{
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY)];
    backview.tag=9797;

    [self.view addSubview:backview];

    _shareModelview = [[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight+30, kApplicationWidth, ONEYUANSHAREMODELVIEW_HEIGH)];
    _shareModelview.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_shareModelview];

    //生活图片
    _shareBigimgview = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-ZOOM6(570))/2, -ZOOM6(700), ZOOM6(570), ZOOM6(600))];

    if([imageurl hasPrefix:@"http"])
    {
        [_shareBigimgview sd_setImageWithURL:[NSURL URLWithString:imageurl]];
    }else{
        _shareBigimgview.image = [UIImage imageNamed:imageurl];
    }

    UIView *shareBaseView = [[UIView alloc]initWithFrame:CGRectMake(0,ZOOM6(60), kScreenWidth, ONEYUANSHAREMODELVIEW_HEIGH+kUnderStatusBarStartY)];
    shareBaseView.backgroundColor = [UIColor whiteColor];
    [_shareModelview addSubview:shareBaseView];

    //奖励文字
    CGFloat titlelable1Y = ZOOM(20);
    UILabel *titlelable1 = [[UILabel alloc]initWithFrame:CGRectMake(10, titlelable1Y, kApplicationWidth-20, 30)];
    titlelable1.frame=CGRectMake(0, titlelable1Y+ZOOM(20), kScreenWidth-2*ZOOM(20), 40);
    titlelable1.textAlignment = NSTextAlignmentCenter;
    titlelable1.font = [UIFont systemFontOfSize:ZOOM6(36)];
    titlelable1.textColor = RGBCOLOR_I(125, 125, 125);
    titlelable1.clipsToBounds=YES;

    if(self.isNewbie)
    {
        titlelable1.text = @"分享至任意微信群后即可0元购买";
    }else{
        titlelable1.text = [NSString stringWithFormat:@"分享至任意微信群后即可%.1f元购买",self.app_shop_group_price.floatValue];
    }
    [shareBaseView addSubview:titlelable1];
    
//    CGFloat imageHeigh = 20;
//    UIImageView *secretImage = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(SecretBtn.frame)-imageHeigh)/2, (CGRectGetHeight(SecretBtn.frame)-imageHeigh)/2, imageHeigh, imageHeigh)];
//    secretImage.image = [UIImage imageNamed:@"shop_wenhao_red"];
//    [SecretBtn addSubview:secretImage];

    //    记录弹出时间（每天只弹一次）
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSDate *record = [user objectForKey:SECRETDATE];
//    if([[MyMD5 compareDate:record] isEqualToString:@"昨天"] || record==nil )
//    {
//        qdnImgView = secretImage;
//        qdaImgView = [[UIImageView alloc] initWithFrame:secretImage.frame];
//        qdaImgView.image = [UIImage imageNamed:@"shop_wenhao"];
//        qdaImgView.layer.opacity = 0;
//        [SecretBtn addSubview:qdaImgView];
//
//        [qdnImgView opacityStatus:YES time:2 fromValue:1 toValue:0];
//        [qdaImgView opacityStatus:YES time:2 fromValue:0 toValue:1];
//
//    }
    NSArray *titleArray = @[@"微信群",@"朋友圈",@"QQ空间"];
    CGFloat dismissbtnYY =0;
    //分享平台
    for (int i=0; i<3; i++) {

        CGFloat space = (kScreenWidth - ZOOM6(300) -ZOOM6(90)*2)/2;

        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        shareBtn.frame = CGRectMake((space+ZOOM6(100))*i+ZOOM6(90),CGRectGetMaxY(titlelable1.frame)+ZOOM6(40), ZOOM6(100), ZOOM6(100));
        shareBtn.frame = CGRectMake((kScreenWidth-ZOOM6(420))/2, CGRectGetMaxY(titlelable1.frame)+ZOOM6(50), ZOOM6(420), ZOOM6(88));
        shareBtn.tag = 9000+i;
        [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];

        UILabel *sharetitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(shareBtn.frame)-20, CGRectGetMaxY(shareBtn.frame)+ZOOM6(10), CGRectGetWidth(shareBtn.frame)+40, 0)];
        sharetitle.text = titleArray[i];
        sharetitle.textColor = RGBCOLOR_I(168, 168, 168);
        sharetitle.font = [UIFont systemFontOfSize:ZOOM6(24)];
        sharetitle.textAlignment = NSTextAlignmentCenter;

        dismissbtnYY = CGRectGetMaxY(sharetitle.frame);

        if (i==0) {//微信好友

            //判断设备是否安装微信

            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {

                //判断是否有微信
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"分享到微信群"] forState:UIControlStateNormal];

            }else {

                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                sharetitle.hidden = YES;

            }

        }else if (i==1){//微信朋友圈

            //判断设备是否安装微信

            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {

                //判断是否有微信
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"朋友圈-1"] forState:UIControlStateNormal];
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                sharetitle.hidden = YES;

            }else {

                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                sharetitle.hidden = YES;

            }
        }else{//QQ空间


            //判断设备是否安装QQ

            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
            {
                //判断是否有qq

                [shareBtn setBackgroundImage:[UIImage imageNamed:@"qq空间-1"] forState:UIControlStateNormal];
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                sharetitle.hidden = YES;

            }else{

                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                sharetitle.hidden = YES;
            }

        }
        //        [shareBaseView addSubview:sharetitle];
        [shareBaseView addSubview:shareBtn];

    }

    //取消按钮
    UIButton *dismissbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissbtn.frame = CGRectMake(kScreenWidth - ZOOM6(70), ZOOM6(20), ZOOM6(50), ZOOM6(50));
//    dismissbtn.layer.borderColor = RGBCOLOR_I(125, 125, 125).CGColor;
//    dismissbtn.layer.borderWidth = 1;
//    dismissbtn.layer.cornerRadius = 5;
    [dismissbtn setTitleColor:RGBCOLOR_I(125, 125, 125) forState:UIControlStateNormal];
    dismissbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
//    [dismissbtn setTitle:@"取消" forState:UIControlStateNormal];
    [dismissbtn setImage:[UIImage imageNamed:@"TFWXWithdrawals_weixintixian_close_icon"] forState:UIControlStateNormal];
    [dismissbtn addTarget:self action:@selector(dismissShareView) forControlEvents:UIControlEventTouchUpInside];
    [shareBaseView addSubview:dismissbtn];

    backview.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0];

    [UIView animateWithDuration:0.5 animations:^{

        backview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];

        _shareModelview.frame=CGRectMake(0, kApplicationHeight-ONEYUANSHAREMODELVIEW_HEIGH+kUnderStatusBarStartY, kApplicationWidth, ONEYUANSHAREMODELVIEW_HEIGH);

        _shareBigimgview.frame=CGRectMake(_shareBigimgview.frame.origin.x, ZOOM6(60), _shareBigimgview.frame.size.width, _shareBigimgview.frame.size.height);

    } completion:^(BOOL finished) {


    }];
}


#pragma mark 进度条
- (UIView*)speedProgressView
{
    if(!_speedProgressView && self.pArray.count)
    {
        _speedProgressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(200))];
        UILabel *goodComment=[[UILabel alloc]initWithFrame:CGRectMake(0, ZOOM6(35), kScreenWidth, ZOOM6(30))];
        goodComment.text=@"商品好评率";
        goodComment.textColor = kTitleColor;
        goodComment.textAlignment = NSTextAlignmentCenter;
        goodComment.font=[UIFont systemFontOfSize:ZOOM6(30)];
        [_speedProgressView addSubview:goodComment];
        
        UILabel *linelab = [[UILabel alloc]initWithFrame:CGRectMake(0, ZOOM6(100), kScreenWidth, 1)];
        linelab.backgroundColor = RGBCOLOR_I(229, 229, 229);
        [_speedProgressView addSubview:linelab];
        
        NSArray *typearr=@[@"没有色差",@"版型好看",@"做工不错",@"性价比高"];
        
        CGFloat bckwith = (self.view.frame.size.width)/4;
        CGFloat width = ZOOM6(160);
        for(int i =0; i <4 ; i++)
        {
            HKPieChartView *pieChartView = [[HKPieChartView alloc]initWithFrame:CGRectMake((bckwith - width)/2+i*bckwith, ZOOM6(140), width, width)];
            [pieChartView updatePercent:[self.pArray[i] floatValue] animation:YES];
            [_speedProgressView addSubview:pieChartView];
            
            UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(i*bckwith, CGRectGetMaxY(pieChartView.frame)+ZOOM6(20), bckwith, ZOOM6(40))];
            titlelab.font=[UIFont systemFontOfSize:ZOOM(46)];
            titlelab.textAlignment = NSTextAlignmentCenter;
            titlelab.text = typearr[i];
            titlelab.textColor=kTextColor;
            [_speedProgressView addSubview:titlelab];
        }
    }
    return _speedProgressView;
}
- (UILabel*)codelable
{
    if(_codelable == nil)
    {
        _codelable = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(50), ZOOM6(40), kScreenWidth-2*ZOOM(50), ZOOM6(50))];
        _codelable.text = [NSString stringWithFormat:@"商品编号: %@",_ShopModel.shop_code];
        _codelable.font = [UIFont systemFontOfSize:ZOOM6(28)];
        _codelable.textColor = RGBCOLOR_I(62, 62, 62);
    }
    return _codelable;
}
- (UIImageView*)footimage
{
    if(_footimage == nil)
    {
        _footimage = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, kApplicationWidth, (kApplicationWidth)*230/108)];
        
        [_footimage sd_setImageWithURL:[NSURL URLWithString:@"https://yssj668.b0.upaiyun.com/system/shop_details.png"]];
    }
    return _footimage;
}
- (void)createUI
{
    self.leftBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, StatusTableHeight, OPENCENTERX+2, kScreenHeight-StatusTableHeight)];
    self.leftBackgroundView.backgroundColor = RGBCOLOR_I(22,22,22);
    [self.leftBackgroundView removeFromSuperview];
    
    self.contentBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.contentBackgroundView.backgroundColor = RGBCOLOR_I(22,22,22);

    [self.contentBackgroundView removeFromSuperview];
    
    //    self.searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //    self.searchBtn.frame=CGRectMake(kApplicationWidth-42, kApplicationHeight-130, 32, 32);
    //    [self.searchBtn setImage:[UIImage imageNamed:@"详情_search"] forState:UIControlStateNormal];
    //    [self.searchBtn addTarget:self action:@selector(TFSearchClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)footViewAddChildView
{
    _tableFootView.clipsToBounds = YES;
    self.shopStoreVC = [[ShopStoreViewController alloc] init];
    self.shopStoreVC.isHeadView = NO;
    self.shopStoreVC.isFootView = NO;
    self.shopStoreVC.isVseron = YES;
    
    [self.shopStoreVC.view setFrame:CGRectMake(0, -NavigationHeight-StatusTableHeight, CGRectGetWidth(_tableFootView.frame), CGRectGetHeight(_tableFootView.frame))];
    self.shopStoreVC.view.backgroundColor = [UIColor clearColor];
    self.shopStoreVC.slidePageScrollView.pageTabBar.index = (int)self.currPage;
    [self addChildViewController:_shopStoreVC];
    [_tableFootView addSubview:self.shopStoreVC.view];
    
    self.shopStoreVC.slidePageScrollView.tyDelegate = self;
    
    [self.MyBigtableview reloadData];
}

#pragma mark - TYSlidePageScrollViewDelegate

- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView verticalScrollViewDidScroll:(UIScrollView *)pageScrollView
{
//    UIView *footview =(UIView*)[self.view viewWithTag:8181];
    
    CGPoint translation = [pageScrollView.panGestureRecognizer translationInView:pageScrollView.superview];
    int i=0;
    
    if(translation.x == 0)
    {
        if (translation.y > 0 )//下滑
        {
            //滑到底部
            if(i==0 && pageScrollView.contentOffset.y <= 0)
            {
                [UIView animateWithDuration:1 animations:^{
                    
                    [self scrollTableToFoot:NO];
                } completion:^(BOOL finished) {
                    
//                    footview.hidden = NO;
                    _promptview.hidden = NO;
                }];
                
                i++;
            }
        }else{//上滑
            //滑到顶部
            if(i == 0)
            {
                CGFloat viewHeigh = kIOSVersions >= 11 ? -Height_StatusBar :0;
                [UIView animateWithDuration:0.5 animations:^{
                    
                    self.MyBigtableview.contentOffset = CGPointMake(0, self.MyBigtableview.contentSize.height-_tableFootView.frame.size.height-Height_NavBar+viewHeigh);

                }];
            
                i++;
            }
        }
    }
}

#pragma mark **********************网络请求*************************
#pragma mark 网络请求
-(void)requestHttp
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    
    manager.requestSerializer.timeoutInterval = 10;
    
    
    NSString *url;
    if(token == nil)
    {
        url=[NSString stringWithFormat:@"%@shop/queryUnLogin?version=%@&code=%@",[NSObject baseURLStr],VERSION,self.shop_code];
        if(self.theme_id!=nil)
        {
            url=[NSString stringWithFormat:@"%@shop/queryUnLogin?version=%@&code=%@&theme_id=%@",[NSObject baseURLStr],VERSION,self.shop_code,self.theme_id];
        }
    }else{
        
        url=[NSString stringWithFormat:@"%@shop/query?version=%@&code=%@&token=%@",[NSObject baseURLStr],VERSION,self.shop_code,token];
        if(self.theme_id!=nil)
        {
            url=[NSString stringWithFormat:@"%@shop/query?version=%@&code=%@&token=%@&theme_id=%@",[NSObject baseURLStr],VERSION,self.shop_code,token,self.theme_id];
        }
    }
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] CreateAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        //商品请求 = %@",responseObject);
        
        //        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            if([message isEqualToString:@"该商品已经下架啦!"])
            {
                _shopmessage = message;
            }
            
            _praise_count=responseObject[@"praise_count"];
            
            _shareshopdic = responseObject[@"share_shop"];
            
            _shopDic = responseObject[@"shop"];
            
            if(statu.intValue==1)//请求成功
            {
                
                [[Animation shareAnimation] stopAnimationAt:self.view];
                
                _comeCount +=1;
                
                ShopDetailModel *model=[[ShopDetailModel alloc]init];
                
                if(![_shopDic isEqual:[NSNull null]])
                {
                    model.actual_sales=[NSString stringWithFormat:@"%@",_shopDic[@"actual_sales"]];
                    model.clicks=_shopDic[@"clicks"];
                    model.content=_shopDic[@"content"];
                    model.def_pic=[NSString stringWithFormat:@"%@",_shopDic[@"def_pic"]];
                    model.shop_id=_shopDic[@"id"];
                    model.invertory_num=_shopDic[@"invertory_num"];
                    model.is_hot=_shopDic[@"is_hot"];
                    model.is_new=_shopDic[@"is_new"];
                    model.kickback=_shopDic[@"kickback"];
                    model.love_num=_shopDic[@"love_num"];
                    model.remark=_shopDic[@"remark"];
                    model.shop_code=_shopDic[@"shop_code"];
                    model.shop_discount_time=_shopDic[@"shop_discount_time"];
                    model.shop_name=_shopDic[@"shop_name"];
                    model.shop_pic=_shopDic[@"shop_pic"];
                    model.shop_price=_shopDic[@"shop_price"];
                    model.shop_up_time=_shopDic[@"shop_up_time"];
                    model.supp_id=_shopDic[@"supp_id"];
                    model.four_pic=_shopDic[@"four_pic"];
                    
                    model.cart_count=responseObject[@"cart_count"];
                    model.like_id=responseObject[@"like_id"];
                    model.color_count=responseObject[@"color_count"];
                    model.cost_count=responseObject[@"cost_count"];
                    model.type_count=responseObject[@"type_count"];
                    model.work_count=responseObject[@"work_count"];
                    model.start_count=responseObject[@"star_count"];
                    model.eva_count=responseObject[@"eva_count"];
                    model.zeroOrderNum=[NSString stringWithFormat:@"%@",responseObject[@"zeroOrderNum"]];
                    
                    model.shop_tag=responseObject[@"shop"][@"shop_tag"];
                    
                    model.audit_time = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"audit_time"]];
                    
                    model.collocation_code = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"collocation_code"]];
                    model.shop_group_price = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"roll_price"]];
                    model.stuff = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"stuff"]];
                    model.ingredient = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"ingredient"]];
                    model.ID = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
                    model.supp_label=[NSString stringWithFormat:@"%@",responseObject[@"shop"][@"supp_label"]];
                    
                    self.currPage = [_shopDic[@"type1"] intValue];
                    self.virtual_sales = _shopDic[@"virtual_sales"];
                    self.suppstr = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"supp_label_id"]];
                    self.content1 = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"supp_label"]];
                    self.app_shop_group_price = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"app_shop_group_price"]];
                    _shop_group_price = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"roll_price"]];
                    
                    _shop_se_price = [NSString stringWithFormat:@"%f",[_shopDic[@"shop_se_price"] floatValue]];
                    model.shop_se_price=[NSString stringWithFormat:@"%f",[_shopDic[@"shop_se_price"] floatValue]];
                    
                    _ShopModel=model;
                }
                
                _ShopModel.c_time = [NSString stringWithFormat:@"%@",responseObject[@"c_time"]];
                _ShopModel.s_time = [NSString stringWithFormat:@"%@",responseObject[@"s_time"]];
                
                NSString *attr_Data = responseObject[@"attr_data"];
                
                [userdefaul setObject:attr_Data forKey:ATTR_DATA];
                
                NSMutableString *str=[NSMutableString stringWithFormat:@"%@",_shopDic[@"shop_attr"]];
                
                NSArray *arr=[str componentsSeparatedByString:@"_"];
                self.sizeArray =[NSMutableArray arrayWithArray:arr];
                
                self.attrDataArray = [NSMutableArray arrayWithArray:arr];
                
                if([responseObject[@"attrList"]count])
                {
                    _dataDictionaryArray = [NSMutableArray arrayWithArray:responseObject[@"attrList"]];
                }
                if(![model.zeroOrderNum isEqualToString:@"(null)"] && model.zeroOrderNum !=nil)
                {
                    self.isNewbie = NO;//没有0元购
                }
                
                NSString * OneText = [NSString stringWithFormat:@"%@",responseObject[@"returnOneText"]];
                if(![OneText isEqualToString:@"(null)"] && OneText !=nil)
                {
                    self.returnOneText = OneText;
                }
                
                //创建视图 第二次进来的时候只创建tableview
                if(_comeCount<2)
                {
                    if (_isFrist) {
                        _isFrist = NO;
                    } else {

                        [self refreshBigImageview];
                        [self getNewBie];
                        [self getOneYuanCount];
                        
                        if([_dataDictionaryArray count])
                        {
                            [self creatModleData];
                        }
                    }
                }else if (self.isNewbie)//如果是新用户刷新
                {
                    [self getNewBie];
                }
                
                self.backview.hidden=NO;
                
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                NSArray *likearr = [user objectForKey:@"user_like"];
                
                BOOL result = [likearr containsObject:_ShopModel.shop_code];
                if(result == NO)
                {
                    _siimage.image=[UIImage imageNamed:@"icon_xihuan"];
                    self.likebtn.selected=NO;
                }else{
                    
                    _siimage.image=[UIImage imageNamed:@"icon_xihuan_sel"];
                    self.likebtn.selected=YES;
                }
            }
            else if(statu.intValue == 10030){//没登录状态
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                
                LoginViewController *login=[[LoginViewController alloc]init];
                login.loginStatue = @"10030";
                login.tag = 1000;
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }else if (statu.intValue == 2)
            {
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
            }
            else{
                
                [self creatHeadview];
                
                self.backview.hidden=YES;
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
                
                
                //                [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(jump) userInfo:nil repeats:NO];
                [self performSelector:@selector(jump) withObject:nil afterDelay:1.5f];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //[MBProgressHUD hideHUDForView:self.view];
        
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络连接失败,请检查网络设置~" Controller:self];
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
    }];
}

//获取是否新老用户
-(void)getNewBie
{
//    [TypeShareModel getNewbieHTTP:^(TypeShareModel *data) {
//        TypeShareModel *model = data;
//        if(model.status == 1)
//        {
//            self.current_date = [NSString stringWithFormat:@"%@",data.current_date];
//            if([self.current_date hasPrefix:@"newbie"])
//            {
//                self.isNewbie = YES;
//                [self refreshBigImageview];
//                if ([self.stringtype isEqualToString:@"活动商品"])
//                {
//                    [self creatActiveFootView];
//                }else{
//                    [self creatFootView];
//                }
//            }
//        }
    
        
        [self refreshBigImageview];
        if ([self.stringtype isEqualToString:@"活动商品"])
        {
            [self creatActiveFootView];
        }else{
            [self creatFootView];
        }
        
//    }];
}

//可抵扣的余额
- (void)getOneYuanCount
{
    kWeakSelf(self);
    [OneYuanModel GetOneYuanCountSuccess:^(id data) {
        OneYuanModel *oneModel = data;
        if(oneModel.status == 1)
        {
//            OneYuanDataModel *dataModel = oneModel.data;
            
            [DataManager sharedManager].OneYuan_count = oneModel.order_price;
            [DataManager sharedManager].one_not_use_price = oneModel.one_not_use_price;
            
            weakself.shop_deduction = [oneModel.shop_deduction floatValue];
            
            [ShopDetailViewModel addUserVipOrderSuccess:^(id data) {
                ShopDetailViewModel *viewmodel = data;
                
                if(viewmodel.status == 1)
                {
                    weakself.maxType = viewmodel.maxType;
                }
                
                [weakself refreshBigImageview];
                
                if ([weakself.stringtype isEqualToString:@"活动商品"])
                {
                    [weakself creatActiveFootView];
                }else{
                    [weakself creatFootView];
                }
            }];
        }
    }];
}
#pragma mark 网络请求
-(void)markrequestHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    if(token == nil)
    {
        url=[NSString stringWithFormat:@"%@shop/queryUnLogin?version=%@&code=%@",[NSObject baseURLStr],VERSION,self.shop_code];
    }else{
        
        url=[NSString stringWithFormat:@"%@shop/query?version=%@&code=%@&token=%@",[NSObject baseURLStr],VERSION,self.shop_code,token];
        
    }
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] CreateAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        //        responseObject = [NSDictionary changeType:responseObject];
        MyLog(@"responseObject = %@",responseObject);
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            NSDictionary *dic=responseObject[@"shop"];
            
            if(statu.intValue==1)//请求成功
            {
                
                if(![dic isEqual:[NSNull null]])
                {
                    
                    _ShopModel.cart_count=responseObject[@"cart_count"];
                    _carBtn.markNumber = [responseObject[@"cart_count"] integerValue];
                    _pubCartcount = _carBtn.markNumber;
                }
                
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //[MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
    }];
}
#pragma mark //保存所有看过的商品信息
-(void)AddmystepsHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSString *realm = [userdefaul objectForKey:USER_REALM];
    
    url=[NSString stringWithFormat:@"%@mySteps/addSteps?version=%@&token=%@&shop_code=%@&realm=%@",[NSObject baseURLStr],VERSION,token,self.shop_code,realm];
    
    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    //    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //[MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        //
        //        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            if(statu.intValue==1)//请求成功
            {
                
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //[MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
    }];
    
}

#pragma mark 商品属性及库存分类查询
-(void)requestShopHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    url=[NSString stringWithFormat:@"%@shop/queryAttr?version=%@&shop_code=%@",[NSObject baseURLStr],VERSION,self.shop_code];
    
    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    //        [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //[MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        //        responseObject = [NSDictionary changeType:responseObject];
        MyLog(@" stocktype = %@",responseObject);
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            if(statu.intValue==1)//请求成功
            {
                for(NSDictionary *dic in responseObject[@"stocktype"])
                {
                    ShopDetailModel *tpyemodel=[[ShopDetailModel alloc] init];
                    
                    tpyemodel.color_size=dic[@"color_size"];
                    tpyemodel.stock_type_id=dic[@"id"];
                    tpyemodel.stock=dic[@"stock"];
                    tpyemodel.pic=dic[@"pic"];
                    tpyemodel.shop_se_price=dic[@"price"];
                    tpyemodel.original_price=dic[@"original_price"];
                    tpyemodel.shop_name=dic[@"shop_name"];
                    tpyemodel.kickback=dic[@"kickback"];
                    tpyemodel.core=dic[@"core"];
                    tpyemodel.group_price = [NSString stringWithFormat:@"%@",dic[@"group_price"]];
                    
                    [self.stocktypeArray addObject:tpyemodel];
                }
                
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //[MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            //            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            //            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
    }];
}

#pragma mark 优先点评网络请求
-(void)HotcommentHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *rows = _pagecount == 1? @"10": @"10";
    
    url=[NSString stringWithFormat:@"%@shopComment/selCommentByShop?version=%@&shop_code=%@&token=%@&page=%d&pager.order=%@&rows=%@&is_real=-1",[NSObject baseURLStr],VERSION,self.shop_code,token,(int)_pagecount, @"desc", rows];
    
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.MyBigtableview footerEndRefreshing];
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1 && [responseObject[@"comments"] count]) {
                TFCommentModel *NModel = [[TFCommentModel alloc] init];
                NModel.cellType = 7;
                [self.commentDataArray addObject:NModel];
                
                TFCommentModel *NOModel = [[TFCommentModel alloc] init];
                NOModel.cellType = 8;
                [self.commentDataArray addObject:NOModel];
                
                for (NSDictionary *comments in responseObject[@"comments"]) {
                    
                    NSDictionary *dic = comments;
                    
                    TFCommentModel *cModel = [[TFCommentModel alloc] init];
                    [cModel setValuesForKeysWithDictionary:dic];
                    cModel.ID = dic[@"id"];
                    
                    if (cModel.commentModel.isComment == NO&&cModel.suppCommentModel.isComment == NO&&cModel.suppEndCommentModel.isComment == NO) {
                        //
                        cModel.cellType = 1; //评
                    }
                    if (cModel.commentModel.isComment == NO&&cModel.suppCommentModel.isComment == YES&&cModel.suppEndCommentModel.isComment == NO) {
                        cModel.cellType = 2; //评+回
                    }
                    if (cModel.commentModel.isComment == YES&&cModel.suppCommentModel.isComment == NO&&cModel.suppEndCommentModel.isComment == NO) {
                        cModel.cellType = 3; //评+追
                    }
                    if (cModel.commentModel.isComment == YES&&cModel.suppCommentModel.isComment == YES&&cModel.suppEndCommentModel.isComment == NO) {
                        cModel.cellType = 4; //评+回+追
                    }
                    if (cModel.commentModel.isComment == YES&&cModel.suppCommentModel.isComment==NO&&cModel.suppEndCommentModel.isComment == YES) {
                        cModel.cellType = 5; //评+追+回
                    }
                    if (cModel.commentModel.isComment == YES&&cModel.suppCommentModel.isComment == YES&&cModel.suppEndCommentModel.isComment == YES) {
                        cModel.cellType = 6; //评+回+追＋回
                    }
                    
                    [self.commentDataArray addObject:cModel];
                }
                [self commentHttp];

            } else {
                [self commentHttp];
                [[Animation shareAnimation] stopAnimationAt:self.view];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.MyBigtableview footerEndRefreshing];
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        [self.MyBigtableview reloadData];
    }];
}

#pragma mark 评论网络请求
-(void)commentHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/xml",nil];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *rows = _pagecount == 1? @"10": @"10";
    
    url=[NSString stringWithFormat:@"%@shopComment/selCommentByShop?version=%@&shop_code=%@&token=%@&page=%d&pager.order=%@&rows=%@",[NSObject baseURLStr],VERSION,self.shop_code,token,(int)_pagecount, @"desc", rows];
    
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.MyBigtableview footerEndRefreshing];
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1 && [responseObject[@"comments"] count]) {
                
                if (_pagecount == 1) {
                    if(!self.commentDataArray.count)
                    {
                        TFCommentModel *NOModel = [[TFCommentModel alloc] init];
                        NOModel.cellType = 7;
                        [self.commentDataArray addObject:NOModel];
                    }
                    
                    TFCommentModel *NOModel1 = [[TFCommentModel alloc] init];
                    NOModel1.cellType = 9;
                    [self.commentDataArray addObject:NOModel1];
                }
                
                for (NSDictionary *comments in responseObject[@"comments"]) {
                    
                    NSDictionary *dic = comments;
                    
                    if(![responseObject[@"pager"] isEqual:[NSNull null]] )
                    {
                        NSString *str =[NSString stringWithFormat:@"%@",responseObject[@"pager"][@"pageCount"]];
                        
                        _tatalpage = str.intValue;
                    } else{
                        _tatalpage = 1 ;
                    }
                    
                    TFCommentModel *cModel = [[TFCommentModel alloc] init];
                    [cModel setValuesForKeysWithDictionary:dic];
                    cModel.ID = dic[@"id"];
                    
                    if (cModel.commentModel.isComment == NO&&cModel.suppCommentModel.isComment == NO&&cModel.suppEndCommentModel.isComment == NO) {
                        //
                        cModel.cellType = 1; //评
                    }
                    if (cModel.commentModel.isComment == NO&&cModel.suppCommentModel.isComment == YES&&cModel.suppEndCommentModel.isComment == NO) {
                        cModel.cellType = 2; //评+回
                    }
                    if (cModel.commentModel.isComment == YES&&cModel.suppCommentModel.isComment == NO&&cModel.suppEndCommentModel.isComment == NO) {
                        cModel.cellType = 3; //评+追
                    }
                    if (cModel.commentModel.isComment == YES&&cModel.suppCommentModel.isComment == YES&&cModel.suppEndCommentModel.isComment == NO) {
                        cModel.cellType = 4; //评+回+追
                    }
                    if (cModel.commentModel.isComment == YES&&cModel.suppCommentModel.isComment==NO&&cModel.suppEndCommentModel.isComment == YES) {
                        cModel.cellType = 5; //评+追+回
                    }
                    if (cModel.commentModel.isComment == YES&&cModel.suppCommentModel.isComment == YES&&cModel.suppEndCommentModel.isComment == YES) {
                        cModel.cellType = 6; //评+回+追＋回
                    }
                    
                    [self.commentDataArray addObject:cModel];
                }
                
                [self.MyBigtableview reloadData];
            } else {
                
                if(!self.commentDataArray.count)
                {
                    TFCommentModel *NOModel = [[TFCommentModel alloc] init];
                    NOModel.cellType = 7;
                    [self.commentDataArray addObject:NOModel];
                }

                [self.MyBigtableview reloadData];
                [[Animation shareAnimation] stopAnimationAt:self.view];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"operation: %@", operation.responseString);

        [self.MyBigtableview footerEndRefreshing];
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
//            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
//            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
        if(!self.commentDataArray.count)
        {
            TFCommentModel *NOModel = [[TFCommentModel alloc] init];
            NOModel.cellType = 7;
            [self.commentDataArray addObject:NOModel];
        }
        [self.MyBigtableview reloadData];
    }];
}

#pragma mark 普通分享成功后调用接口
-(void)ShareSuccessHttp
{
    MyLog(@"okokokoko*******");
    if(_shareCount >0)
    {
        return;
        
    }else{
        
        _shareCount ++;
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
        
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        NSString *token=[user objectForKey:USER_TOKEN];
        
        NSString *url=[NSString stringWithFormat:@"%@shareShop/add?version=%@&token=%@&code=%@",[NSObject baseURLStr],VERSION,token,_ShopModel.shop_code];
        
        NSString *URL=[MyMD5 authkey:url];
        
        [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            //            responseObject = [NSDictionary changeType:responseObject];
            if (responseObject!=nil) {
                NSString *str=responseObject[@"status"];
                
                if(str.intValue==1)
                {
                    _comeCount = 0;
                    _isFrist = YES;
                    [self requestHttp];
                }
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            //网络连接失败");
            //        [MBProgressHUD hideHUDForView:self.view];
            [[Animation shareAnimation] stopAnimationAt:self.view];
            
            if ([error code] == kCFURLErrorTimedOut) {
                [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
            }else{
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
            }
        }];
        
        
    }
    
    
}

#pragma mark 加喜欢
-(void)likerequestHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    //
    int weekday = [self getweekday];
    MyLog(@"weekday is %d",weekday);
    
    url=[NSString stringWithFormat:@"%@like/addLike?version=%@&shop_code=%@&token=%@&show=%d",[NSObject baseURLStr],VERSION,self.shop_code,token,weekday];
    
    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    //[[Animation shareAnimation] createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.likebtn.userInteractionEnabled = YES;
        
        //        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            if(statu.intValue==1)//请求成功
            {
                NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[MyMD5 getCurrTimeString:@"year-month-day"], @"year-month-day", nil];
                [[NSUserDefaults standardUserDefaults] setObject:currDic[@"year-month-day"] forKey:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID],DailyTaskFriday]];
                
                //新加的最爱存储到本地
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                NSArray *likearr = [user objectForKey:@"user_like"];
                NSMutableArray *newlikearr = [NSMutableArray arrayWithArray:likearr];
                [newlikearr addObject:_ShopModel.shop_code];
                [user setObject:newlikearr forKey:@"user_like"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                _siimage.image=[UIImage imageNamed:@"icon_xihuan_sel"];
                self.likebtn.selected=YES;
                self.likebtn.enabled = NO;
                
                _likeview= [[UIImageView alloc]initWithFrame:CGRectMake(kApplicationWidth/2, 0, 0, 0)];
                _likeview.image=[UIImage imageNamed:@"加心效果"];
                [self.view addSubview:_likeview];
                [self.view bringSubviewToFront:_likeview];
                
                _oldframe=_likeview.frame;
                
                [UIView animateWithDuration:0.5 animations:^{
                    _likeview.center=CGPointMake(kApplicationWidth/2, kApplicationHeight/2);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.5 animations:^{
                        _likeview.frame = CGRectMake((kApplicationWidth-100)/2, (kApplicationHeight-100)/2, 100, 100);
                    }];
                }];
                
                
                _liketimer=[NSTimer weakTimerWithTimeInterval:1 target:self selector:@selector(disapper:) userInfo:nil repeats:NO];
                if (self.addLikeBlock) {
                    self.addLikeBlock();
                }
                
            }else{
                
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:@"加喜欢失败" Controller:self];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //[MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    
}

#pragma mark 取消喜欢
-(void)dislikerequestHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    
    url=[NSString stringWithFormat:@"%@like/delLike?version=%@&shop_code=%@&token=%@",[NSObject baseURLStr],VERSION,self.shop_code,token];
    
    NSString *URL=[MyMD5 authkey:url];
    //        [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    //[[Animation shareAnimation] createAnimationAt:self.view];
    
    self.likebtn.userInteractionEnabled = YES;
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=@"";
            
            if(statu.intValue==1)//请求成功
            {
                //取消的最爱存储到本地
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                NSArray *likearr = [user objectForKey:@"user_like"];
                NSMutableArray *newlikearr = [NSMutableArray arrayWithArray:likearr];
                [newlikearr removeObject:_ShopModel.shop_code];
                [user setObject:newlikearr forKey:@"user_like"];
                
                _siimage.image=[UIImage imageNamed:@"icon_xihuan"];
                self.likebtn.enabled = NO;
                self.likebtn.selected=NO;
                
                message=@"不再喜欢此宝贝";
                
                if (self.cancelLikeBlock) {
                    self.cancelLikeBlock();
                }
                
            }else{
                message=@"取消喜欢失败";
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
            
            self.likebtn.enabled = YES;
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //[MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
}
#pragma mark 签到网络请求
- (void)SignHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    
    NSString *url;
    
    url=[NSString stringWithFormat:@"%@signIn/signIning?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *messsage=responseObject[@"message"];
            
            
            if(statu.intValue==1)
            {
                if(!_SharePopview)
                {
                    
                    [self BrowsePopView];//强制浏览弹框
                    
                    //强制浏览统计
                    NSString *key = [NSString stringWithFormat:@"%lf,%ld",_currTimeCount, _browseCount];
                    [YFShareModel getShareModelWithKey:key type:StatisticalTypeForcibly tabType:StatisticalTabTypeForcibly success:nil];
                }
                
            }
            else{
                
                NavgationbarView *alertview=[[NavgationbarView alloc] init];
                [alertview showLable:messsage Controller:self];
                
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [MBProgressHUD hideHUDForView:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];
    
    
}
#pragma mark 获取商品链接请求
- (void)shopRequest:(int)tag
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *realm = [user objectForKey:USER_ID];
    NSString *token = [user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@shop/getShopLink?version=%@&shop_code=%@&realm=%@&token=%@&share=%@&getShopMessage=true",[NSObject baseURLStr],VERSION,_ShopModel.shop_code,realm,token,@"2"];
    if([self.stringtype isEqualToString:@"活动商品"])
    {
        url=[NSString stringWithFormat:@"%@shop/getShopLink?version=%@&shop_code=%@&realm=%@&token=%@&share=%@&activity=1",[NSObject baseURLStr],VERSION,_ShopModel.shop_code,realm,token,@"2"];
    }
    [DataManager sharedManager].key = _ShopModel.shop_code;
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"分享加载中，稍等哟~" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        _sharebtn.userInteractionEnabled = YES;
        
        //        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                _shareModel=[ShareShopModel alloc];
                _shareModel.shopUrl=responseObject[@"link"];
                
                _shareShopurl=@"";
                _shareShopurl=responseObject[@"link"];
                NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
            
                if(_shareShopurl)
                {
                    [userdefaul setObject:[NSString stringWithFormat:@"%@",_shareShopurl] forKey:QR_LINK];
                }
                
                NSDictionary *shopdic  = responseObject[@"shop"];
                
                if(shopdic !=NULL || shopdic!=nil)
                {
                    
                    if(shopdic[@"four_pic"])
                    {
                        
                        NSArray *imageArray = [shopdic[@"four_pic"] componentsSeparatedByString:@","];
                        
                        NSString *imgstr;
                        if(imageArray.count > 2)
                        {
                            imgstr = imageArray[2];
                            
                            _shareModel.shopImage = imageArray[2];
                            
                        }else if (imageArray.count > 0)
                        {
                            imgstr = imageArray[0];
                        }
                        
                        
                        //获取供应商编号
                        
                        NSMutableString *code ;
                        NSString *supcode  ;
                        
                        if(shopdic[@"shop_code"])
                        {
                            code = [NSMutableString stringWithString:shopdic[@"shop_code"]];
                            supcode  = [code substringWithRange:NSMakeRange(1, 3)];
                        }
                        
                        
                        [userdefaul setObject:[NSString stringWithFormat:@"%@/%@/%@",supcode,code,imgstr] forKey:SHOP_PIC];
                    }
                    
                    NSString *price = [NSString stringWithFormat:@"%f",[shopdic[@"shop_se_price"] floatValue]*0.5];
                    
                    if(price)
                    {
                        [userdefaul setObject:price forKey:SHOP_PRICE];
                    }
                    
                    NSString *name = [NSString stringWithFormat:@"%@",shopdic[@"shop_name"]];
                    if(name !=nil && ![name isEqual:[NSNull null]])
                    {
                        [userdefaul setObject:name forKey:SHOP_NAME];
                    }
                    if(self.content1 != nil && ![self.content1 isEqual:[NSNull null]])
                    {
                        [userdefaul setObject:[NSString stringWithFormat:@"%@",self.content1] forKey:SHOP_BRAND];
                    }
                }
                
                if( !_shareShopurl)
                {
                    [MBProgressHUD hideHUDForView:self.view];
                    return;
                }
                
                [TypeShareModel getTypeCodeWithShop_code:self.shop_code success:^(TypeShareModel *data) {
                    
                    if(data.status == 1)
                    {
                        [userdefaul setObject:[NSString stringWithFormat:@"%@",data.type2] forKey:SHOP_TYPE2];
                        [self gotoshare:tag];
                    }
                }];
            }
            else if(str.intValue==1050)
            {
                [MBProgressHUD hideHUDForView:self.view];
                
                UIView *backview = (UIView*)[self.view viewWithTag:9797];
                [backview removeFromSuperview];
                
                [_shareModelview removeFromSuperview];
                
                
                NSString *noteStr ;
                
                BOOL result = [self isBetweenFromHour:7 toHour:14];
                
                if( result)//早上
                {
                    noteStr = @"亲爱的，你今天上午的分享次数已经全部使用了哦,下午再来吧！接下来购物不分享也能得到现金红包哦！";
                    
                }else{
                    
                    noteStr = @"亲爱哒，今天的分享次数已经使用完了哦，明天再分享吧。接下来购物不分享也能得到现金红包哦！";
                }
                
                UIButton * shopbtn = (UIButton*)[self.view viewWithTag:4001];
                shopbtn.selected = NO;
                
                _shopDetailAlterView =[[UIAlertView alloc]initWithTitle:nil message:noteStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                
                [_shopDetailAlterView show];
                
            }
            
            else{
                [MBProgressHUD hideHUDForView:self.view];
                
//                UIButton * shopbtn = (UIButton*)[self.view viewWithTag:4001];
//                shopbtn.selected = NO;
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:@"数据异常，操作无效" Controller:self];
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        //网络连接失败");
        [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
        
    }];
    
    
}

#pragma mark **********************分享****************************
#pragma mark 普通分享失败
- (void)ShopDetailsharefail:(NSNotification*)note
{
    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
    [mentionview showLable:@"分享失败" Controller:self];
}
#pragma mark 普通分享成功
- (void)ShopDetailsharesuccess
{
    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
    [mentionview showLable:@"分享成功" Controller:self];
    
    if(_shareCount == 0)
    {
        [self ShareSuccessHttp];
        return;
    }
}
#pragma mark 智能分享成功
-(void)sharesuccess:(NSNotification*)note
{
    //商品属性及库存分类查询
    [self requestShopHttp];
}
#pragma mark 智能分享失败
- (void)sharefail:(NSNotification*)note
{
    //商品属性及库存分类查询
    [self requestShopHttp];
}
//普通分享
- (void)normalShare
{
    _is_oneLuck_share = NO;
    [self getShareImage];
}
- (void)getShareImage
{
    kWeakSelf(self);
    [self loginVerifySuccess:^{
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *imagestr = [user objectForKey:SHARE_LIFE_IMAGE];
        if(imagestr == nil)
        {
            imagestr = @"Daisy_12";
            [user setObject:@"Daisy_12" forKey:SHARE_LIFE_IMAGE];
        }
        weakself.shareMoneyImage.userInteractionEnabled = NO;
        [ShareImageModel getShareImageSuccess:^(ShareImageModel *data) {
            
            NSString *imageurl;
            if(data.status  == 1)
            {
                if(data.data !=nil)
                {
                    imageurl = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],data.data[@"pic"]];
                    
                    [user setObject:imageurl forKey:SHARE_LIFE_IMAGE];
                }
            }else{
                
                imageurl = imagestr;
            }
            if(_is_oneLuck_share)
            {
                [weakself creatOneYuanShareModelView:imageurl];
            }else{
                [weakself creatShareModelView:imageurl];
            }
            
            weakself.shareMoneyImage.userInteractionEnabled = YES;
        }];
    }];
}
- (void)httpGetShareImageWithPrice:(NSNumber *)shop_price QRLink:(NSString *)qrLink sharePicUrl:(NSString *)picUrl type:(NSString *)myType
{
    [MBProgressHUD showMessage:@"启动分享中,请稍后" afterDeleay:0 WithView:self.view];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], picUrl];
    //url = %@", url);
    
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //        responseObject = [NSDictionary changeType:responseObject];
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
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate shardk];
        
//        UIImage *QRImage =[[UIImage alloc] init];
        UIImage *QRImage = [QRCodeGenerator qrImageForString:qrLink imageSize:160];
        
        ProduceImage *pi = [[ProduceImage alloc] init];
        UIImage *newimg = [pi getImage:self.shareRandShopImage withQRCodeImage:QRImage withText:nil withPrice:[NSString stringWithFormat:@"%@",shop_price] WithTitle:nil];
        
        DShareManager *ds = [DShareManager share];
        ds.delegate = self;
        
        [ds shareAppWithType:ShareTypeWeixiTimeline withImageShareType:myType withImage:newimg];
    } else {
        
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"没有安装微信" Controller:self];
    }
}

- (void)DShareManagerStatus:(SHARESTATE)shareStatus withType:(NSString *)type
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    
    //type = %@", type);
    
    if ([type isEqualToString:DailyTaskMorningShare]||[type isEqualToString:DailyTaskAfternoonShare]) {
        if (shareStatus == 1) {
            
            
            [self httpShareSuccessWithType:type];
            
        } else if (shareStatus == 2) {
            
            [nv showLable:@"分享失败" Controller:self];
            
            
        } else if (shareStatus == 3) {
            
            //            [nv showLable:@"分享取消" Controller:self];
            
        }
    } else if ([type isEqualToString:NoviciateTask_Seven_Eight]) {
        
        if (shareStatus == 1) {
            
            
            [self httpShareSuccessWithType:type];
            
        } else if (shareStatus == 2) {
            
            //            [self dailyTaskView1];
            //            [self dailyTaskView2];
            
            [nv showLable:@"分享失败" Controller:self];
            
            
        } else if (shareStatus == 3) {
            //            [self dailyTaskView1];
            //            [self dailyTaskView2];
            
            //            [nv showLable:@"分享取消" Controller:self];
            
        }
        
    }
    
}

#pragma mark 分享成功后
-(void)httpShareSuccessWithType:(NSString *)type
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    //	NSString *realm = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_REALM]];
    NSString *token = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_TOKEN]];
    
    NSString *urlStr;
    if ([type isEqualToString:DailyTaskMorningShare]) {
        urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=7",[NSObject baseURLStr], VERSION,token];
    } else if ([type isEqualToString:DailyTaskAfternoonShare]) {
        urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=8",[NSObject baseURLStr], VERSION,token];
    } else if ([type isEqualToString:NoviciateTask_Seven_Eight]) {
        
        //150积分还是300积分???
        
        urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=18",[NSObject baseURLStr], VERSION,token];
    }
    
    NSString *URL=[MyMD5 authkey:urlStr];
    
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                [HTTPTarbarNum httpRedCount];
                if ([type isEqualToString:DailyTaskMorningShare]) {
                    int flag = [responseObject[@"flag"] intValue];
                    int num = [responseObject[@"num"] intValue];
                    
                    //                    int newFlag = [responseObject[@"newFlag"] intValue];
                    //                    int newNum = [responseObject[@"newNum"] intValue];
                    
                    if (flag == 0) {
                        [nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
                    }
                } else if ([type isEqualToString:DailyTaskAfternoonShare]) {
                    int flag = [responseObject[@"flag"] intValue];
                    int num = [responseObject[@"num"] intValue];
                    
                    //                    int newFlag = [responseObject[@"newFlag"] intValue];
                    //                    int newNum = [responseObject[@"newNum"] intValue];
                    
                    if (flag == 0) {
                        [nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
                    }
                } else if ([type isEqualToString:NoviciateTask_Seven_Eight]) {
                    
                    int newFlag = [responseObject[@"newFlag"] intValue];
                    int newNum = [responseObject[@"newNum"] intValue];
                    
                    if (newFlag == 0) {
                        [nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", newNum] Controller:self];
                    }
                    
                    //                    [self dailyTaskView1];
                    //                    [self dailyTaskView2];
                }
                
                [self ShareSuccessHttp];
            } else {
                [nv showLable:responseObject[@"message"] Controller:self];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //网络连接失败");
    }];
    
}
#pragma mark 选择分享的平台
-(void)shareClick:(UIButton*)sender
{
    if(sender.selected == NO)
    {
        UIView *backview = (UIView*)[self.view viewWithTag:9797];
        
        if(_shareModelview)
        {
            
            [UIView animateWithDuration:0.5 animations:^{
                
                backview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
                
                _shareModelview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, SHAREMODELVIEW_HEIGH);
                
                _shareBigimgview.frame=CGRectMake(_shareBigimgview.frame.origin.x, -ZOOM6(900),_shareBigimgview.frame.size.width , _shareBigimgview.frame.size.height);
                
            } completion:^(BOOL finished) {
                
                [backview removeFromSuperview];
                
                [_shareModelview removeFromSuperview];
                
                int tag = (int)sender.tag;
                //获取商品链接
                [self shopRequest:tag];
                
                
            }];
            
        }else{
            
            [backview removeFromSuperview];
        }
        
        sender.selected = YES;
    }
}


//小程序分享回调
- (void)MinihareManagerStatus:(MINISHARESTATE)shareStatus withType:(NSString *)type
{
    NSString *sstt = @"";
    switch (shareStatus) {
        case MINISTATE_SUCCESS:
            [self ShopDetailsharesuccess];
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
    if(shareStatus != MINISTATE_SUCCESS)
    {
        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        [mentionview showLable:sstt Controller:self];
    }
}
-(void)gotoshare:(int)sharetag
{
    _shareCount = 0;
    
    //配置分享平台信息
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app shardk];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *shop_pic=[user objectForKey:SHOP_PIC];
    NSString *shopprice =[user objectForKey:SHOP_PRICE];
    NSString *qrlink = [user objectForKey:QR_LINK];
    NSString *shop_name = [user objectForKey:SHOP_NAME];
    NSString *shop_brand = [user objectForKey:SHOP_BRAND];
    NSString *realm = [user objectForKey:USER_ID];
    if(shop_brand == nil || [shop_brand isEqualToString:@"(null)"] || [shop_brand isEqual:[NSNull null]])
    {
        shop_brand = @"衣蝠";
    }
    NSString *type2 = [user objectForKey:SHOP_TYPE2];
    kSelfWeak;
    [DShareManager share].detailBlock = ^{
        [weakSelf ShopDetailsharesuccess];
    };
    
    if(sharetag==9000)//微信好友
    {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//            UIImage *shopimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],shop_pic]]]];
//            [MBProgressHUD hideHUDForView:self.view];
//
//            [[DShareManager share] shareAppWithType:ShareTypeWeixiSession View:nil Image:shopimage WithShareType:@"detail"];
//
//        });
    
        
        MiniShareManager *minishare = [MiniShareManager share];
        
        NSString *image = [NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],shop_pic];
//        NSString *title = [minishare taskrawardHttp:type2 Price:shopprice Brand:shop_brand];
        
        NSString *path  = [NSString stringWithFormat:@"/pages/shouye/detail/detail?shop_code=%@&user_id=%@",_ShopModel.shop_code,realm];

        NSString *type2 = [user objectForKey:SHOP_TYPE2];
        type2 = ![type2 isEqualToString:@"(null)"]?type2:@"ZARA";
        
        NSString *title = [NSString stringWithFormat:@"快来%.1f元抢【%@】专柜价%.2f元！",[self.app_shop_group_price floatValue],_ShopModel.shop_name,[_ShopModel.shop_se_price floatValue]];
    
        minishare.delegate = self;
        [minishare shareAppWithType:MINIShareTypeWeixiSession Image:image Title:title Discription:nil WithSharePath:path];
        
        kWeakSelf(self);
        minishare.MinishareSuccess = ^{
            if([DataManager sharedManager].is_OneYuan && _is_oneLuck_share)
            {
                [weakSelf colorAndsizeModelview:YES];
            }
        };
        
    }else if (sharetag==9001)//微信朋友圈
    {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            UIImage *shopimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],shop_pic]]]];
            if(shopimage == nil)
            {
                NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                [mentionview showLable:@"数据获取异常" Controller:self];
                
                return ;
            }
            
            [MBProgressHUD hideHUDForView:self.view];
            
            //    直接创建二维码图像
            UIImage *qrpicimage = [QRCodeGenerator qrImageForString:qrlink imageSize:165];
            
            NSData *data = UIImagePNGRepresentation(qrpicimage);
            NSString *st = [NSString stringWithFormat:@"%@/Documents/abc.png", NSHomeDirectory()];
            
            //st = %@", st);
            
            [data writeToFile:st atomically:YES];
            
            
            ProduceImage *pi = [[ProduceImage alloc] init];
            UIImage *newimg = [pi getImage:shopimage withQRCodeImage:qrpicimage withText:@"detail" withPrice:shopprice WithTitle:nil];
            MyLog(@"newimg = %@",newimg);
            
            int shareCount = [[user objectForKey:ShareCount] intValue];
            int shareType = shareCount %2==0?1:2;
            UIImage *pubImage;
            if(shareType == 1)
            {
                pubImage = newimg;
            }else{
                pubImage = shopimage;
            }
            [DShareManager share].taskValue = shareType;
            [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:pubImage WithShareType:@"detail"];
        });
        
        
        
    }else if (sharetag==9002)//QQ空间
    {
        [MBProgressHUD hideHUDForView:self.view];
        
        [[DShareManager share] shareAppWithType:ShareTypeQQSpace View:nil Image:nil WithShareType:@"detail"];
    }
    
    
    if(_shareModelview )
    {
        
        UIView *backview = (UIView*)[self.view viewWithTag:9797];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            backview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
            
            _shareModelview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, SHAREMODELVIEW_HEIGH);
            
            _shareBigimgview.frame=CGRectMake(_shareBigimgview.frame.origin.x, -ZOOM6(900),_shareBigimgview.frame.size.width , _shareBigimgview.frame.size.height);
            
        } completion:^(BOOL finished) {
            [backview removeFromSuperview];
            [_shareModelview removeFromSuperview];
        }];
        
        
        //        UIButton * shopbtn = (UIButton*)[self.view viewWithTag:4001];
        //        shopbtn.selected = NO;
    }
}
- (void)disapperShare
{
    [_sharebtn becomeFirstResponder];
    
    UIView *backview = (UIView*)[self.view viewWithTag:9797];
    
    if(_shareModelview)
    {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            backview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
            
            _shareModelview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, SHAREMODELVIEW_HEIGH);
            
            _shareBigimgview.frame=CGRectMake(_shareBigimgview.frame.origin.x, -ZOOM6(900),_shareBigimgview.frame.size.width , _shareBigimgview.frame.size.height);
            
        } completion:^(BOOL finished) {
            
            [backview removeFromSuperview];
            
            [_shareModelview removeFromSuperview];
        }];
        
    }else{
        
        [backview removeFromSuperview];
    }
    
    MyLog(@"fjsfj");
    
}
-(void)share
{
    [self loginVerifySuccess:^{
        
        [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:nil Title:nil WithShareType:@"detail"];
    }];
}
#pragma mark 联系客服
-(void)kefulick:(UIButton*)sender
{
    kSelfWeak;
    [self loginVerifySuccess:^{
        MyLog(@"联系客服");
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString* suppid = [user objectForKey:PTEID];
        [weakSelf Message:suppid];
    }];
}


- (IBAction)share:(id)sender {
    //    [[DShareManager share] shareList];
    
    NavgationbarView *mentionview=[[NavgationbarView alloc]init];
    [mentionview showLable:@"支付成功,3秒后自动分享到朋友圈" Controller:self];
    [self performSelector:@selector(share) withObject:nil afterDelay:4.0f];
}

#pragma mark **********************弹框****************************
#pragma mark 余额抵扣
- (void)Deductibleclick:(UIButton*)sender
{
    kWeakSelf(self);
    VitalityTaskPopview* vitaliview = [[VitalityTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) VitalityType:Detail_Deductible valityGrade:0 YidouCount:0];
    __weak VitalityTaskPopview *view = vitaliview;
    
    vitaliview.oneYuanDiKou = [DataManager sharedManager].OneYuan_count;
    view.rightHideMindBlock = ^(NSString*title){
        TFMyWalletViewController *wallet = [[TFMyWalletViewController alloc]init];
        wallet.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:wallet animated:YES];
    };
    view.leftHideMindBlock = ^(NSString*title){
        MakeMoneyViewController *makemoney = [[MakeMoneyViewController alloc]init];
        makemoney.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:makemoney animated:YES];
    };
    [weakself.view addSubview:vitaliview];
}
#pragma mark 制造商弹框
- (void)Manufacturer
{
    BrandMakerDetailVC *view=[BrandMakerDetailVC new];
    SqliteManager *manager = [SqliteManager sharedManager];
    TypeTagItem *item = [manager getSuppLabelItemForId:self.suppstr];
    view.shopItem=item;
    [self.navigationController pushViewController:view animated:YES];
}
#pragma mark 加购物车成功提示弹框
- (void)creatTishiview
{
    _promptview = [[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight+40+kUnderStatusBarStartY, kApplicationWidth, 40)];
    _promptview.backgroundColor = [UIColor blackColor];
    _promptview.alpha = 0.9;
    _promptview.userInteractionEnabled = YES;
    [self.view addSubview:_promptview];
    [self.view bringSubviewToFront:_promptview];
    
    UITapGestureRecognizer *carttap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cartgo:)];
    [_promptview addGestureRecognizer:carttap];
    
    
    UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_promptview.frame)-150, 40)];
    titlelable.text = @" 商品将保留30分钟";
    titlelable.font = [UIFont systemFontOfSize:ZOOM(47)];
    titlelable.textColor = [UIColor whiteColor];
    [_promptview addSubview:titlelable];
    
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-20-10, 10, 20, 20)];
    image.image = [UIImage imageNamed:@"shop-go-"];
    [_promptview addSubview:image];
    
    UILabel *settlementlable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-30-80, 0, 80, 40)];
    settlementlable.text = @"立即结算";
    settlementlable.font = [UIFont systemFontOfSize:ZOOM(47)];
    settlementlable.textColor = tarbarrossred;
    [_promptview addSubview:settlementlable];
    
}
#pragma mark 强制浏览弹框
- (void)BrowsePopView
{
    NSArray *mostList = self.Browsedic[@"motaskList"];
    NSArray *finishList = self.Browsedic[@"finishtaskList"];
    NSArray *dataArray = self.Browsedic[@"data"];
    int slecttag = [self.Browsedic[@"selectSigntag"] intValue];
    
    BrowseRemindView *remindView = [[BrowseRemindView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andrewordType:self.rewardType MotaskList:mostList FinishList:finishList DataArray:dataArray SelectTag:slecttag];
    
    __weak BrowseRemindView *mindview = remindView;
    
    //左边按钮
    mindview.leftHideMindBlock = ^(NSString *title){
        
        if ([title isEqualToString:@"查余额"])
        {
            MyLog(@"钱包");
            TFMyWalletViewController *wallet = [[TFMyWalletViewController alloc]init];
            wallet.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:wallet animated:YES];
            
        }
        else if ([title isEqualToString:@"开启特权"])
        {
            
            //            [self doubleSuccessEntrance:1];
            
        }else if([title isEqualToString:@"知道了"])
        {
            
            [DataManager sharedManager].isOpen = YES;
            
            Mtarbar.selectedIndex=0;
            [self.navigationController popToRootViewControllerAnimated:NO];
            
        }
        
        [remindView remindViewHiden];
    };
    
    //右边按钮
    mindview.rightHideMindBlock = ^(NSString *title){
        
        if ([title isEqualToString:@"去小店"])
        {
            Mtarbar.selectedIndex=0;
        }
        else if ([title isEqualToString:@"赚积分"])
        {
            NewSigninViewController *newSign = [[NewSigninViewController alloc]init];
            newSign.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:newSign animated:YES];
            
        }
        else if ([title isEqualToString:@"查看余额"])
        {
            MyLog(@"钱包");
            TFMyWalletViewController *wallet = [[TFMyWalletViewController alloc]init];
            wallet.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:wallet animated:YES];
            
        }else if ([title isEqualToString:@"查看积分"])
        {
            
            HYJIntelgralDetalViewController *vc = [[HYJIntelgralDetalViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.index = 0;
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else if ([title isEqualToString:@"查看卡券"])
        {
            
            TFMyCardViewController *tmvc = [[TFMyCardViewController alloc] init];
            tmvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:tmvc animated:YES];
            
        }
        
        [remindView remindViewHiden];
    };
    
    mindview.tapHideMindBlock = ^{
        
        [remindView remindViewHiden];
    };
    
    [self.view addSubview:remindView];
    
}
#pragma mark 颜色尺码选择框
- (void)colorAndsizeModelview:(BOOL)miniShareSuccess
{
    NSString *shop_group_price = @"";
    
    shop_group_price = [NSString stringWithFormat:@"%.1f",[self.viewmodel get_discount_price:_ShopModel.shop_se_price.floatValue DiscountMoney:[DataManager sharedManager].one_not_use_price MaxViptype:self.maxType Shop_deduction:self.shop_deduction]];
    
    _ShopModel.app_shop_group_price = shop_group_price;
    
    ChangeSpecialShopPopview* shopPopview = [[ChangeSpecialShopPopview alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) ShopModel:_ShopModel];
    shopPopview.isNewbie = self.isNewbie;
    if([self.stringtype isEqualToString:@"活动商品"] && self.tag == 3001)
    {
        shopPopview.tag = 989898;
    }
    
    if([self.stringtype isEqualToString:@"活动商品"])
    {
        shopPopview.isActive = YES;
    }
    if([DataManager sharedManager].is_OneYuan)
    {
        shopPopview.miniShareSuccess = miniShareSuccess;
    }
     __weak ChangeSpecialShopPopview *view = shopPopview;
    view.okChangeBlock = ^(ShopDetailModel* changepmodel)
    {
        self.cartAndbuyModel = changepmodel;
        if (self.tag==3000 || self.tag == 5858)//加入购物车
        {
            ShopCarModel *cartModel = [ShopCarManager isExistsWithType:ShopCarTypeCar shopCode:changepmodel.shop_code andStid:changepmodel.stock_type_id];
            
            if(cartModel)//此商品编号的库存ID已经加过一件
            {
                NSInteger num = cartModel.shop_num + [self.cartAndbuyModel.shop_num integerValue];
                if(num <= 2) {
                    
                    [self insertToDB:changepmodel.stock_type_id withKickback:changepmodel.kickback andOriginal_price:_ShopModel.original_price andID:@(cartModel.ID).stringValue Color:changepmodel.shop_color Size:changepmodel.shop_size Num:changepmodel.shop_num.integerValue expired:cartModel.expired];
                }else{
                    
                    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                    [mentionview showLable:@"抱歉,数量有限,最多只能购买两件噢!" Controller:self];
                }
                
            }else{
                
                //获取购物车ID
                [self getshopCartID:changepmodel.stock_type_id withKickback:changepmodel.kickback andOriginal_price:_ShopModel.original_price Color:changepmodel.shop_color Size:changepmodel.shop_size Num:changepmodel.shop_num.integerValue];
            }
            
        }else{//购买
            
            [MobClick event:SHOP_QUEDING];
            
            _ShopModel.shop_color = changepmodel.shop_color;
            _ShopModel.shop_size = changepmodel.shop_size;
            _ShopModel.shop_other = changepmodel.shop_other;
            _ShopModel.stock_type_id=changepmodel.stock_type_id;
            _ShopModel.original_price=changepmodel.original_price;
            _ShopModel.shop_num =changepmodel.shop_num;
            
            if(_is_oneLuck_share)
            {
                [self performSelector:@selector(fightpay) withObject:self afterDelay:0.5];
            }else{
                NSMutableArray *shopArray = [NSMutableArray array];
                [shopArray addObject:changepmodel];
                
                OrderTableViewController *view = [[OrderTableViewController alloc]init];
                view.hidesBottomBarWhenPushed=YES;
                view.sortArray = shopArray;
                view.isSpecialOrder = YES;
                view.haveType=NO;
                view.isTM = YES;
                view.affirmOrder=^{
                    [self changeTabbarCartNum];
                };
                [self.navigationController pushViewController:view animated:YES];
            }
            
            
            if(self.imgFullScrollView)
            {
                [UIView animateWithDuration:0.5 animations:^{
                    
                    self.imgFullScrollView.alpha=0;
                    
                } completion:^(BOOL finished) {
                    
                    [self.imgFullScrollView removeFromSuperview];
                    
                }];
            }
        }
    };
        
    [self.view addSubview:shopPopview];
}

- (void)togoAffirm:(NSString*)se_price Num:(NSString*)num ReductionPrice:(NSString*)ReductionPrice
{
    AffirmOrderViewController *affirm=[[AffirmOrderViewController alloc]init];
    affirm.affirmType=OneYuanType;
    
    _ShopModel.shop_num = @"1";
    
    //何波修改2017-6-30
    affirm.selectPrice = [NSString stringWithFormat:@"%.2f",[DataManager sharedManager].app_value];
    affirm.shareReductionPrice = ReductionPrice;
    _ShopModel.shop_num = num;
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:_ShopModel];
    
    UIImageView *headimg=(UIImageView*)[_modelview viewWithTag:3579];
    affirm.headimage.image=headimg.image;
    
    UILabel *pricelable=(UILabel*)[_modelview viewWithTag:8765];
    affirm.isNewbie = self.isNewbie;
    affirm.price=pricelable.text;
    affirm.order_code=self.order_code;
    affirm.shopmodel=_ShopModel;
    affirm.color=_ShopModel.shop_color;
    affirm.size=_ShopModel.shop_size;
    affirm.number=_ShopModel.shop_num;
    affirm.selectName=_selectName;
    affirm.selectPrice=[NSString stringWithFormat:@"%.2f",self.isNewbie?0:[DataManager sharedManager].app_value];
    affirm.selectColorID=[NSString stringWithFormat:@"%@",_selectColorID];
    affirm.selectSizeID=[NSString stringWithFormat:@"%@",_selectSizeID];
    affirm.stocktypeArray=self.stocktypeArray;
    affirm.JifenshopArray=self.JifenshopArray;
    affirm.four_pic=_ShopModel.four_pic;
    
    
    [self.navigationController pushViewController:affirm animated:YES];
}

#pragma mark 签到任务弹框
- (void)setTaskPopMindView:(TaskPopType)type
{
    FinishTaskPopview * bonusview = [[FinishTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) TaskType:type TaskValue:nil Title:nil RewardValue:self.rewardValue RewardNumber:(int)self.rewardCount  Rewardtype:self.rewardType];
    
    __weak FinishTaskPopview *view = bonusview;
    view.tapHideMindBlock = ^{
        [view remindViewHiden];
    };
    
    view.leftHideMindBlock = ^(NSString*title){
        MyLog(@"左");
        [self gotovc:title Tasktype:type];
    };
    
    view.rightHideMindBlock = ^(NSString*title){
        MyLog(@"右");
        [self gotovc:title Tasktype:type];
    };
    
    [self.view addSubview:bonusview];
    
}

#pragma mark **********************数据库****************************
- (void)closeDB
{
    if (AttrcontactDB) {
        sqlite3_close(AttrcontactDB);
        AttrcontactDB = 0x00;
    }
}
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
            
            sql_stmt=_sql_stmt;
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

#pragma mark - 查询TAG表-- 数据库查找数据
- (NSArray *)hoboFindDataForTAGDB:(NSArray *)findStr
{
    
    [_tagNameArray removeAllObjects];
    [_sequenceArray removeAllObjects];
    [_IDArray removeAllObjects];
    
    MyLog(@"findStr =  %@",findStr);
    
    for(int i = 0;i<findStr.count;i++)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if([self OpenDb])
        {
            const char *dbpath = [_databasePath UTF8String];
            sqlite3_stmt *statement;
            
            if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
            {
                NSString *querySQL = [NSString stringWithFormat:@"SELECT name,address,phone,ico,sequence,ename from TAGDB where id=\"%@\"",findStr[i]];
                const char *query_stmt = [querySQL UTF8String];
                
                if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    
                    while (sqlite3_step(statement) == SQLITE_ROW)
                    {
                        
                        NSString *name = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                        NSString *parterid = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                        
                        MyLog(@" parterid=%@, name = %@ ",parterid, name);
                        
                        if(name !=nil && parterid !=nil)
                        {
                
                            NSString *sequence =[self sequenceFindDataForTAGDB:parterid];
                            MyLog(@"sequence=%@",sequence);
                            if(sequence)
                            {
                                [dic setObject:name forKey:sequence];
                                [_IDArray addObject:sequence];
                                [_sequenceArray addObject:dic];
                            }
                            
                            [_tagNameArray addObject:name];
                        }
                        
                    }
                }
                
                sqlite3_close(AttrcontactDB);
            }
        }
    }
    
    MyLog(@"_IDArray = %@ ",_IDArray);
    MyLog(@"_sequenceArray = %@ ",_sequenceArray);
    
    
    return _tagNameArray;
}

- (NSString *)sequenceFindDataForTAGDB:(NSString *)findStr
{
    
    [_tagNameArray removeAllObjects];
    
    MyLog(@"findStr =  %@",findStr);
    
    
    if([self OpenDb])
    {
        const char *dbpath = [_databasePath UTF8String];
        sqlite3_stmt *statement;
        
        if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT name,address,phone,ico,sequence,ename from TAGDB where id=\"%@\"",findStr];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    
                    NSString *sequence = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                    
                    MyLog(@" sequence=%@,",sequence);
                    
                    if(sequence !=nil )
                    {
                        return sequence;
                    }
                    
                }
            }
            
            sqlite3_close(AttrcontactDB);
        }
    }
    
    
    return 0;
}


#pragma mark **********************购物车****************************
#pragma mark 获取购物车ID
-(void)getshopCartID:(NSString*)typeid withKickback:(NSString*)shopkickback andOriginal_price:(NSString *)original_price Color:(NSString*)shopcolor Size:(NSString*)shopsize Num:(NSInteger)shopnum
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    
    NSString *url=[NSString stringWithFormat:@"%@shopCart/getCartData?num=%@&version=%@&token=%@",[NSObject baseURLStr],@"1",VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                NSString *ID = responseObject[@"id"];
               
                [self insertToDB:typeid withKickback:shopkickback andOriginal_price:original_price andID:ID Color:shopcolor Size:shopsize Num:shopnum expired:NO];
            }else{
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:@"添加商品失败" Controller:self];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];

}
#pragma mark 同步数据到数据库
-(void)insertToDB:(NSString*)typeid withKickback:(NSString*)shopkickback andOriginal_price:(NSString *)original_price andID:(NSString*)ID Color:(NSString*)shopcolor Size:(NSString*)shopsize Num:(NSInteger)shopnum expired:(BOOL)expired
{

    _shopCarModel = [ShopCarModel new];
    _shopCarModel.ID = ID.integerValue;
    _shopCarModel.paired_code = _ShopModel.collocation_code;
    _shopCarModel.shop_code = _ShopModel.shop_code;
    _shopCarModel.shop_name = _ShopModel.shop_name;
    _shopCarModel.stock_type_id = [typeid integerValue];
    _shopCarModel.supp_id = [_ShopModel.supp_id integerValue];
    _shopCarModel.def_pic = self.cartAndbuyModel.pic;
    _shopCarModel.color = shopcolor;
    _shopCarModel.size = shopsize;
    _shopCarModel.shop_num = shopnum;
    _shopCarModel.shop_price = [self.cartAndbuyModel.shop_price floatValue];
    _shopCarModel.shop_se_price = [self.cartAndbuyModel.shop_se_price floatValue];
    _shopCarModel.original_price = [original_price floatValue];
    _shopCarModel.kickback = [shopkickback floatValue];
    _shopCarModel.date_time = [NSDate date].timeIntervalSince1970;
    _shopCarModel.expired = NO;
    _shopCarModel.supp_label = self.content1;
    _shopCarModel.stock = self.cartAndbuyModel.stock.intValue;
    
    BOOL isSuc = [ShopCarManager insertToDB:_shopCarModel];
    if (!isSuc) {
        NSLog(@"大于20件");
    }
    
    //加购物车成功之后的方法
    [self cartReady];
    
    //发送请求同步数据到后台
//    if(!expired||[ShopCarManager sharedManager].p_count != 19)
    if(!expired)
        //加购物车请求
        [self addshopcartHttp:typeid withKickback:shopkickback andOriginal_price:original_price];

}
#pragma mark 加入购物车网络请求
-(void)addshopcartHttp:(NSString*)typeid withKickback:(NSString*)shopkickback andOriginal_price:(NSString *)original_price
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString*token=[user objectForKey:USER_TOKEN];
    NSString *storecode=[user objectForKey:STORE_CODE];
    NSString *userid = [user objectForKey:USER_ID];
//    NSString *selectpic = [user objectForKey:SELECT_PHOTO];
    
    if(original_price == nil || [original_price isEqual:[NSNull null]] ||[original_price isEqualToString:@"<null>"])
    {
        original_price = @"0";
    }
    
//    if(selectpic == nil)
//    {
//        selectpic = _ShopModel.def_pic;
//    }
    
    //特殊字符处理
    self.content1 = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)self.content1 ,NULL ,CFSTR("!*'();:@&=+$,/?%#[]") ,kCFStringEncodingUTF8));
    NSString *ID = [NSString stringWithFormat:@"%ld",_shopCarModel.ID];
    
    NSString *url=[NSString stringWithFormat:@"%@shopCart/add?version=%@&token=%@&shop_code=%@&size=%@&color=%@&shop_num=%@&shop_name=%@&shop_price=%@&shop_se_price=%@&def_pic=%@&stock_type_id=%@&store_code=%@&supp_id=%@&kickback=%@&original_price=%d&user_id=%@&id=%@&supp_label=%@",[NSObject baseURLStr],VERSION,token,_ShopModel.shop_code,self.cartAndbuyModel.shop_size,self.cartAndbuyModel.shop_color,self.cartAndbuyModel.shop_num,_ShopModel.shop_name,self.cartAndbuyModel.shop_price,self.cartAndbuyModel.shop_se_price,self.cartAndbuyModel.pic,typeid,storecode,_ShopModel.supp_id,shopkickback,[original_price intValue],userid,ID,self.content1];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         _okbutton.enabled = YES;
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            if([Signmanager SignManarer].addShopCart > 0)
            {
            
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                
                NSString *count = [user objectForKey:TASK_ADD_SHOPCART];
                
                count = [NSString stringWithFormat:@"%d",count.intValue+self.cartAndbuyModel.shop_num.intValue];
                [user setObject:count forKey:TASK_ADD_SHOPCART];
                
                NSString *index_id = [Signmanager SignManarer].index_id;
                NSString *day = [Signmanager SignManarer].day;
                if(count.intValue >= [Signmanager SignManarer].addShopCart)
                {
                    [TaskSignModel getTaskHttp:index_id Day:day Success:^(id data) {
                        TaskSignModel *model = data;
                        if(model.status == 1)
                        {
                            [user removeObjectForKey:TASK_ADD_SHOPCART];
                            [self setTaskPopMindView:Task_addCartSuccess];
                            
                            //标记此任务完成
                            [Signmanager SignManarer].task_isfinish = YES;
                        }
                    }];
                    
                }
                else if (count.intValue < [Signmanager SignManarer].addShopCart){
                    
                    [self setTaskPopMindView:Task_addingCart_type];
                
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
         _okbutton.enabled = YES;
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
    }];
    
    
}

- (void)changeTabbarCartNum:(NSString*)typeid
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString*token=[user objectForKey:USER_TOKEN];
   
    NSString *ID = [NSString stringWithFormat:@"%ld",_shopCarModel.ID];
    
    NSString * url=[NSString stringWithFormat:@"%@shopCart/update?version=%@&token=%@&id=%@&size=%@&color=%@&shop_num=%@&stock_type_id=%@",[NSObject baseURLStr],VERSION,token,ID,_selectSize,_selectColor,self.cartAndbuyModel.shop_num,typeid];
    
    NSString *URL=[MyMD5 authkey:url];
    
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        _okbutton.enabled = YES;
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
           
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        _okbutton.enabled = YES;
        //[MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
    }];
    

}
#pragma mark 加购物车成功
- (void)cartReady
{
    NavgationbarView *mentionview=[[NavgationbarView alloc]init];
    [mentionview showLable:@"添加商品成功" Controller:self];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"RFTCart"];//用于刷新tabbar的购物车

    int cart2= (int)[ShopCarManager sharedManager].p_count ;
    if(cart2>0)
    {
        //购物车商品数量加1
        _carBtn.isAnimation = YES;
        _carBtn.markNumber = cart2;
        _pubCartcount = _carBtn.markNumber;
        
        //tarbar上面购物车的数量
        [Mtarbar showBadgeOnItemIndex:3];
        [Mtarbar changeBadgeNumOnItemIndex:3 withNum:[NSString stringWithFormat:@"%d",cart2]];
    }
    
    [self performSelector:@selector(addpop:) withObject:nil afterDelay:0.5];
    
    if (self.addShopCartBlock) {
        self.addShopCartBlock();
    }
    
    if(self.imgFullScrollView)
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            self.imgFullScrollView.alpha=0;
            
        } completion:^(BOOL finished) {
            
            [self.imgFullScrollView removeFromSuperview];
            
        }];
        
    }

}
- (void)addCarAnimation {
    _carBtn.isAnimation = NO;
    [_carBtn animationCar];
}

- (void)addpop:(NSString*)type
{
    if(![type isEqualToString:@"商品详情"])
    {
        //加购物车成功提示框
        [self addCarAnimation];
    }
    
    pubtime = 0;
    
    if(_isMove == NO)
    {
        _isMove = YES;
    }
    //加购物车成功倒计时
    [self loadTime];
    
    [self performSelector:@selector(userinrerYES) withObject:nil afterDelay:0.5];
    
}

- (void)userinrerYES
{
    //加入购物车按钮可点
    UIButton *buyBtn = (UIButton*)[self.view viewWithTag:3000];
    buyBtn.userInteractionEnabled = YES;
}



- (void)imageTouch:(UITapGestureRecognizer*)tap
{
    MyLog(@"ok");
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],_headimageurl]];
    
    NSMutableArray *imgViewArr = [NSMutableArray array];
    if(imgUrl)
    {
        [imgViewArr addObject:imgUrl];
    }
    
    if(imgViewArr.count)
    {
        [self scaleView:imgViewArr];
    }
    
}

- (void)cartgo:(UITapGestureRecognizer*)tap
{
    [TFStatisticsClickVM handleDataWithPageType:nil withClickType:@"商品详情页加购物车弹窗后立即结算" success:^(id data, Response *response) {
    } failure:^(NSError *error) {
    }];
    
    [MobClick event:SHOP_GOUWUCHE];
    
    [self loginVerifySuccess:^{
        
        NewShoppingCartViewController *shoppingcart =[[NewShoppingCartViewController alloc]init];
        shoppingcart.ShopCart_Type = ShopCart_NormalType;
        [self.navigationController pushViewController:shoppingcart animated:YES];
    }];
}

- (void)loadTime {
    pubtime2 = (int)[ShopCarManager sharedManager].p_deadline;
    if (_mytimer==nil) {
        _mytimer = [NSTimer weakTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod1:) userInfo:nil repeats:YES];
    }
    
}
#pragma mark 加购物车成功倒计时
- (void)timerFireMethod1:(NSTimer*)time
{
    if(pubtime2 > 0) {
        int min = pubtime2/60;
        int sec = pubtime2%60;
        _carBtn.time = [NSString stringWithFormat:@"%02d:%02d",min,sec];
        pubtime2--;
    } else {
        [_mytimer invalidate];
        _mytimer = nil;
        _carBtn.time = @"00:00";
        _isMove = NO;
        [self getShopCartFromDB:NO];
    }
}
//本地获取购物车数量
- (void)getShopCartFromDB:(BOOL)isTime
{
    
    int cart1= (int)[ShopCarManager sharedManager].p_count ;
    if(cart1>0)
    {
        _carBtn.markNumber = cart1;
        _pubCartcount = _carBtn.markNumber;
        if(cart1>0)
        {
            [self loadTime];
        }else{
            if(_isMove == YES)
            {
                _isMove = NO;
            }
            
            //关闭定时器
            [_mytimer invalidate];
            _mytimer = nil;
            _carBtn.time = @"";
            //            _carBtn.markNumber = 0;
            [self dismissPromptview];
            
        }
        
        if (isTime) {
            
            pubtime = 0;
        } else {
            [self dismissPromptview];
            
            [_mytimer invalidate];
            _mytimer = nil;
        }
        
    }else{
        if(_isMove == YES)
        {
            _isMove = NO;
        }
        
        //关闭定时器
        [_mytimer invalidate];
        _mytimer = nil;
        _carBtn.time = @"";
        _carBtn.markNumber = 0;
        
        [self dismissPromptview];
        
    }
}

-(void)creatPopView
{
    _Popview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight-100)];
    
    _Popview.backgroundColor = [UIColor clearColor];
    _Popview.userInteractionEnabled = YES;
    
    CGFloat codeviewYY = CGRectGetMaxY(self.Headimage.frame) + CGRectGetMinY(self.se_price.frame) - ZOOM6(200);
    _InvitationCodeView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-ZOOM6(40)-ZOOM6(540),codeviewYY, ZOOM6(540), ZOOM6(200))];
    _InvitationCodeView.image = [UIImage imageNamed:@"shuomingkuang-"];
    _InvitationCodeView.layer.cornerRadius=5;
    _InvitationCodeView.clipsToBounds = YES;
    _InvitationCodeView.userInteractionEnabled = YES;
    [_Popview addSubview:_InvitationCodeView];
    
    [self.MyBigtableview addSubview:_Popview];
    
    MyLog(@"111%d", [GoldCouponsManager goldcpManager].gold_is_open)
    MyLog(@"222%d", [GoldCouponsManager goldcpManager].is_open)

    
    for(int i=0;i<3;i++)
    {
        if(i<2)
        {
            UILabel *tishilab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), ZOOM6(15)+ZOOM6(50)*i,CGRectGetWidth(_InvitationCodeView.frame)-30-2*ZOOM6(10), ZOOM6(50))];
            tishilab.textColor = tarbarrossred;
            
            NSString *sstt = @"";
            int DeductiblePrice = 0;
            if(i==0)
            {
                //抵扣来自 抵用劵 余额翻倍 金币 金券
                tishilab.text = [NSString stringWithFormat:@"自己购买抵扣%d元",[_ShopModel.kickback intValue]];
                sstt = @"自己购买抵扣";
                DeductiblePrice = [_ShopModel.kickback intValue];
                
                if([DataManager sharedManager].isOpen == YES)//余额翻倍
                {
                    tishilab.text = [NSString stringWithFormat:@"抵用劵+余额翻倍抵%d元",[_ShopModel.kickback intValue]+6];
                    sstt = @"抵用劵+余额翻倍抵";
                    DeductiblePrice = [_ShopModel.kickback intValue]+6;
                    
                }
                if ([GoldCouponsManager goldcpManager].gold_is_open == YES)//金币
                {
                    tishilab.text = [NSString stringWithFormat:@"抵用劵+金币抵%d元",[_ShopModel.kickback intValue]+6];
                    sstt = @"抵用劵+金币抵";
                    DeductiblePrice = [_ShopModel.kickback intValue]+6;
                    
                }
                if ([GoldCouponsManager goldcpManager].is_open == YES)//金券
                {
                    CGFloat cpPrice = [GoldCouponsManager goldcpManager].c_price;
                
                    tishilab.text = [NSString stringWithFormat:@"抵用劵+金券抵%d元",[_ShopModel.kickback intValue]+(int)cpPrice];
                    sstt = @"抵用劵+金券抵";
                    DeductiblePrice = [_ShopModel.kickback intValue]+(int)cpPrice;
                    
                }
                if ([DataManager sharedManager].isOpen == YES &&[GoldCouponsManager goldcpManager].gold_is_open == YES)//金币+余额翻倍
                {
                    tishilab.text = [NSString stringWithFormat:@"组合优惠最高抵扣%d元",[_ShopModel.kickback intValue]+6+6];
                    sstt = @"组合优惠最高抵扣";
                    DeductiblePrice = [_ShopModel.kickback intValue]+6+6;
                }
                if ([DataManager sharedManager].isOpen == YES &&[GoldCouponsManager goldcpManager].is_open == YES)//金券+余额翻
                {
                    CGFloat cpPrice = [GoldCouponsManager goldcpManager].c_price;
                    tishilab.text = [NSString stringWithFormat:@"组合优惠最高抵扣%d元",[_ShopModel.kickback intValue]+6+(int)cpPrice];
                    sstt = @"组合优惠最高抵扣";
                    DeductiblePrice = [_ShopModel.kickback intValue]+6+(int)cpPrice;
                }
                 if ([GoldCouponsManager goldcpManager].gold_is_open == YES && [GoldCouponsManager goldcpManager].is_open == YES)//金币+金券
                {
                    CGFloat cpPrice = [GoldCouponsManager goldcpManager].c_price;
                    tishilab.text = [NSString stringWithFormat:@"组合优惠最高抵扣%d元",[_ShopModel.kickback intValue]+6+(int)cpPrice];
                    sstt = @"组合优惠最高抵扣";
                    DeductiblePrice = [_ShopModel.kickback intValue]+6+(int)cpPrice;
                    
                }
                if ([GoldCouponsManager goldcpManager].gold_is_open == YES && [GoldCouponsManager goldcpManager].is_open == YES && [DataManager sharedManager].isOpen == YES)//金币+金券+余额翻倍
                {
                    CGFloat cpPrice = [GoldCouponsManager goldcpManager].c_price;
                    tishilab.text = [NSString stringWithFormat:@"组合优惠最高抵扣%d元",[_ShopModel.kickback intValue]+6+6+(int)cpPrice];
                    sstt = @"组合优惠最高抵扣";
                    DeductiblePrice = [_ShopModel.kickback intValue]+6+6+(int)cpPrice;
                }

                
                NSMutableAttributedString *noteStr ;
                if(tishilab.text)
                {
                    noteStr = [[NSMutableAttributedString alloc]initWithString:tishilab.text];
                }
                
                [noteStr addAttribute:NSForegroundColorAttributeName value:kTextColor range:NSMakeRange(0, sstt.length)];
                [tishilab setAttributedText:noteStr];
                
//                NSString *kickback = [NSString stringWithFormat:@"%d",[_ShopModel.kickback intValue]];
                NSString *lowstr = [NSString stringWithFormat:@"低至%.1f元",[_ShopModel.shop_se_price floatValue] -DeductiblePrice];
                if([_ShopModel.shop_se_price floatValue] -DeductiblePrice < 0 )
                {
                    lowstr = @"低至0.01元";
                }
                
                CGFloat tislabWith = [self getRowWidth:tishilab.text fontSize:ZOOM6(28)];
                CGFloat lowlabWith = [self getRowWidth:lowstr fontSize:ZOOM6(28)];
                
                _lowlable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_InvitationCodeView.frame)+tislabWith+ZOOM6(28), CGRectGetMinY(_InvitationCodeView.frame)+tishilab.frame.origin.y+ZOOM6(5), lowlabWith, ZOOM6(40))];
                _lowlable.text = lowstr;
                _lowlable.font = [UIFont systemFontOfSize:ZOOM6(26)];
                _lowlable.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:1];
                _lowlable.textColor = [UIColor whiteColor];
                [_Popview addSubview:_lowlable];
                
            }else{
                tishilab.text = [NSString stringWithFormat:@"分享给朋友购买奖励%.1f元",[_ShopModel.shop_se_price floatValue]*0.1];
                
                NSMutableAttributedString *noteStr ;
                if(tishilab.text)
                {
                    noteStr = [[NSMutableAttributedString alloc]initWithString:tishilab.text];
                }
                
                tishilab.alpha = 0.8;
                [noteStr addAttribute:NSForegroundColorAttributeName value:kTextColor range:NSMakeRange(0, 9)];
                [tishilab setAttributedText:noteStr];

            }
            tishilab.font = [UIFont systemFontOfSize:ZOOM6(28)];
            [_InvitationCodeView addSubview:tishilab];
            
        }else{
            
            CGFloat tislabWith = [self getRowWidth:@"了解更多" fontSize:ZOOM6(30)];
            
            UILabel *tishilab2 = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), ZOOM6(50)*i,CGRectGetWidth(_InvitationCodeView.frame)-30-2*ZOOM6(10), ZOOM6(80))];
            tishilab2.text = [NSString stringWithFormat:@"了解更多"];
            tishilab2.textColor = tarbarrossred;
            tishilab2.font = [UIFont systemFontOfSize:ZOOM6(30)];
            tishilab2.userInteractionEnabled = YES;
            [_InvitationCodeView addSubview:tishilab2];
            
            UIImageView *moreimg = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(tishilab2.frame)+tislabWith, tishilab2.frame.origin.y+(ZOOM6(80)-ZOOM6(30))/2, ZOOM6(30), ZOOM6(30))];
            moreimg.image = [UIImage imageNamed:@"shop-go-"];
            [_InvitationCodeView addSubview:moreimg];
            
            UITapGestureRecognizer *moretap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moretap:)];
            [tishilab2 addGestureRecognizer:moretap];
        }
    }
    
    UIButton *dismisbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dismisbtn.frame = CGRectMake(CGRectGetWidth(_InvitationCodeView.frame)-30, 0, 30, 30);
    dismisbtn.userInteractionEnabled=YES;
    dismisbtn.clipsToBounds = YES;
    [dismisbtn addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [_InvitationCodeView addSubview:dismisbtn];
    
    UIImageView *closeImg = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(dismisbtn.frame)-ZOOM6(30))/2, 10, ZOOM6(30), ZOOM6(30))];
    closeImg.image = [UIImage imageNamed:@"shop_close-"];
    [dismisbtn addSubview:closeImg];
    
    
    _InvitationCodeView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    _lowlable.transform = CGAffineTransformMakeScale(0.6, 0.6);
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _InvitationCodeView.transform = CGAffineTransformMakeScale(1, 1);
        _lowlable.transform = CGAffineTransformMakeScale(1, 1);
        _InvitationCodeView.alpha = 1;
        
    } completion:^(BOOL finish) {
        
    }];
    
}
#pragma mark 了解更多
- (void)moretap
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDate *record = [user objectForKey:SECRETDATE];
    if([[MyMD5 compareDate:record] isEqualToString:@"昨天"] || record==nil )
    {
        [qdnImgView opacityStatus:NO time:2 fromValue:0 toValue:1];
        [qdaImgView opacityStatus:NO time:2 fromValue:0 toValue:1];
        [user setObject:[NSDate date] forKey:SECRETDATE];
    }
    
    ShopDetailSecretViewController *secret = [[ShopDetailSecretViewController alloc]init];
    secret.shop_code = _ShopModel.shop_code;
    secret.stringtype = self.stringtype;
    [self.navigationController pushViewController:secret animated:YES];
    
//    CollecLikeTaskVC *taskvc = [[CollecLikeTaskVC alloc]init];
//    taskvc.TaskFinishBlock = ^{
//        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
//        [mentionview showLable:@"分享成功" Controller:self];
//    };
//    [self.navigationController pushViewController:taskvc animated:YES];
}

- (void)moretap:(UITapGestureRecognizer*)tap
{
    TFMakeMoneySecretViewController *mmVC = [[TFMakeMoneySecretViewController alloc] init];
    [self.navigationController pushViewController:mmVC animated:YES];

}
- (void)dismiss:(UIButton*)sender
{
    [self tapClick];
}

-(void)tapClick
{
    [_lowlable removeFromSuperview];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
        _Popview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        _InvitationCodeView.transform = CGAffineTransformMakeScale(0.25, 0.25);

        _lowlable.alpha = 0;
        
    } completion:^(BOOL finish) {
        
        [_Popview removeFromSuperview];
        
        NSString *string = [[NSUserDefaults standardUserDefaults]objectForKey:NumbermarkTag];
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",[string intValue]+1] forKey:NumbermarkTag];
    }];
    
}


- (void)dismissShareView
{
    _is_oneLuck_share = NO;
    [self disapperShare];
}

#pragma mark 数据源

- (void)creatModleData
{
    //tableviewheadview
    [self.dataArr removeAllObjects];
    [self.colorArray removeAllObjects];
    
    //获取供应商编号
    NSMutableString *code = [NSMutableString stringWithString:_ShopModel.shop_code];
    NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
    
    //详情数据源
    NSArray *array = [_ShopModel.shop_pic componentsSeparatedByString:@","];
    self.dataArr=[NSMutableArray arrayWithArray:array];
    
    NSMutableArray *imageArray=[NSMutableArray array];
    for(int i=0;i<self.dataArr.count;i++)
    {
        NSString *str =self.dataArr[i];
        
        if([str rangeOfString:@"realShot"].location !=NSNotFound)
        {
            continue;
        }
    
        if([str rangeOfString:@"reveal"].location !=NSNotFound ||
           [str rangeOfString:@"detail"].location !=NSNotFound ||
           [str rangeOfString:@"real"].location !=NSNotFound)//_roaldSearchText
        {
            //yes");
            
            MyLog(@"str = %@",str);
            
            //            [imageArray addObject:str];
            
            
            //修改后的图片地址
            NSArray *comArr = [NSArray array];
            NSString *pubstr ;
            
            if([str rangeOfString:@"reveal"].location !=NSNotFound)
            {
                comArr = [str componentsSeparatedByString:@"reveal"];
                pubstr = @"reveal";
                
            }else if ([str rangeOfString:@"detail"].location !=NSNotFound)
            {
                comArr = [str componentsSeparatedByString:@"detail"];
                pubstr = @"detail";
                
            }else if ([str rangeOfString:@"real"].location !=NSNotFound){
                
                comArr = [str componentsSeparatedByString:@"real"];
                pubstr = @"real";
                
            }
            
            if(comArr.count > 0)
            {
                NSString *comstr = [NSString stringWithFormat:@"%@/%@/%@%@",supcode,_ShopModel.shop_code,pubstr,comArr[1]];
                
                MyLog(@"comstr =%@",comstr);
                
                [imageArray addObject:comstr];
            }
            
            
        }
    }
    self.dataArr = imageArray;
//    [self.MyBigtableview reloadData];
    
    //尺码数据源 从数据库中查询
    NSMutableArray *sizearr=[NSMutableArray array];

//    [self OpenDb];
    
    NSMutableString *newsizestring = [[NSMutableString alloc]init];
    
    for(int i=0;i<self.sizeArray.count;i++)
    {
        NSArray *arr=[self.sizeArray[i] componentsSeparatedByString:@","];
        MyLog(@"arr = %@",arr);
        if(arr.count)
        {
            
            NSString *str=[NSString stringWithFormat:@"%@",arr[0]];
            if([str isEqualToString:@"0"])//色
            {
                for(int j=1;j<arr.count;j++)
                {
                    for(NSDictionary *colordic in _dataDictionaryArray)
                    {
                        if(colordic)
                        {
                            if([colordic[@"id"] isEqualToString:arr[j]])
                            {
                            
                                NSMutableDictionary *dic =[NSMutableDictionary dictionary];
                                
                                NSString *addressField = colordic[@"attr_name"];
                                
                                MyLog(@"addressField = %@",addressField);
                                
                                [dic setObject:arr[j] forKey:addressField];
                                
                                [self.stock_colorArray addObject:dic];
                                
                                [self.colorArray addObject:addressField];
                            }
                        
                        }
                    }
                    
                    
                    
                }
                
            }
            
            
            if([str isEqualToString:@"501"])//尺码
            {
                if(sizearr.count)
                {
                    [sizearr removeAllObjects];
                    
                    [newsizestring appendString:@";"];
                    
                }
                
                for(int j=1;j<arr.count;j++)
                {
                    MyLog(@"str******* = %@",arr[j]);
                    
                    for(NSDictionary *sizedic in _dataDictionaryArray)
                    {
                        if(sizedic)
                        {
                            if([sizedic[@"id"] isEqualToString:arr[j]])
                            {
                                
                                NSString *addressField = sizedic[@"attr_name"];
                                
                                NSMutableDictionary *dic =[NSMutableDictionary dictionary];
                                [dic setObject:arr[j] forKey:addressField];
                                
                                [self.stock_sizeArray addObject:dic];
                                
                                MyLog(@"addressField = %@",addressField);
                                
                                [newsizestring appendString:addressField];
                                if(addressField.length >0)
                                {
                                    [newsizestring appendString:@","];
                                }
                                [sizearr addObject:addressField];

                            }
                            
                        }
                    }
                    
                }
                
                
            }else{
                
            }
            
        }
    }
    
    if(newsizestring.length>0)
    {
        NSArray *brr=[newsizestring componentsSeparatedByString:@";"];
        
        NSMutableArray *crr = [NSMutableArray arrayWithArray:brr];
        
        NSMutableArray *indexs = [NSMutableArray array];
        for(int i =0;i<crr.count;i++)
        {
            NSArray *drr = [crr[i] componentsSeparatedByString:@","];
            if(drr.count >2)
            {
                
            }else{
                
                [indexs addObject:crr[i]];
            }
            
        }
        
        [crr removeObjectsInArray:indexs];
        
        _SizeArray =[NSMutableArray arrayWithArray:crr];
        self.SizeDataArray=[NSMutableArray arrayWithArray:crr];
    }

    NSMutableArray *textsizeArray = [NSMutableArray array];
    NSMutableArray *dataArr=[NSMutableArray array];
    for (int j=0;j<_SizeArray.count;j++) {
        
        NSMutableString *ss=[NSMutableString stringWithString:_SizeArray[j]];
        
        NSArray *brr=[ss componentsSeparatedByString:@","];
        NSMutableArray *size=[NSMutableArray arrayWithArray:brr];
        
        
        if(size.count>5)
        {
            for(int i=0;i<4;i++)
            {
                [size removeObjectAtIndex:1];
            }
            
            [dataArr addObject:size];
            
        }else{
            
            for(int i =0;i<size.count;i++)
            {
                [size removeObjectAtIndex:1];
            }
            
            [dataArr addObject:size];
        }
        
    }

    for(NSArray *arr in dataArr)
    {
        if(arr.count >1)
        {
            NSMutableString *sss=[NSMutableString string];
            for(int j=0 ;j<arr.count;j++)
            {
                [sss appendString:arr[j]];
                [sss appendString:@","];
            }
            [textsizeArray addObject:sss];
        }
    }
    
    for (int j=0;j<_SizeArray.count;j++) {
        
        NSMutableString *ss=[NSMutableString stringWithString:_SizeArray[j]];
        
        NSString *cccc ;
        if(ss.length>1)
        {
            cccc = [ss substringToIndex:[ss length] - 1];
        }
        
        NSArray *brr=[cccc componentsSeparatedByString:@","];
        NSMutableArray *size=[NSMutableArray arrayWithArray:brr];
        
        
        if(size.count > 5)
        {
            if(textsizeArray.count)
            {
                for(NSString *str in textsizeArray)
                {
                    [self.SizeDataArray addObject:str];
                }
                
            }
            
            return;
        }
        
        MyLog(@"self.SizeDataArray = %@",self.SizeDataArray);
    }

    self.ShopTagView = [self creatTagView:0];
    self.TagViewHeigh = self.ShopTagView.frame.size.height;
    
    [self.MyBigtableview reloadData];
}


#pragma mark 查找此商品所选择分类属性
-(void)findBtnAttr
{
    NSLog(@"idex=%d",index);
    
    NSMutableString *stocktypeIDstring=[[NSMutableString alloc]init];
    
    for(int i =0;i<self.atrrListArray.count;i++)
    {
        [_selectIDarray removeAllObjects];
        
        NSMutableString *attrstr = self.atrrListArray[i];
        
        NSArray *attrArr = [attrstr componentsSeparatedByString:@";"];
        
        
        for(int j=0;j<attrArr.count-1;j++)
        {
            
            NSString *ttt=attrArr[j];
            NSArray *brr= [ttt componentsSeparatedByString:@","];
            
            for(int k=1;k<brr.count-1;k++)
            {
                
                UIButton *button=(UIButton*)[_modelview viewWithTag:2000*(j+i+1)*(i+1)+k];
                NSLog(@"but.tag==================%d",button.tag);
                
                if(button.selected==YES)
                {
                    NSLog(@"button.text = %@",button.titleLabel.text);
                    
                    //查找商品分类id
                    
                    NSString *selectcolorID = brr[k];
                    [_selectIDarray addObject:selectcolorID];
                    
                }
                
            }
        }
        
        NSLog(@"_selectIDarray =%@",_selectIDarray);
        
        if(_selectIDarray.count)
        {
            NSString *stocktypeID=[self changestock:9875+i];
            
            if(stocktypeID)
            {
                [stocktypeIDstring appendString:stocktypeID];
                [stocktypeIDstring appendString:@","];
            }
        }
        
    }
    
    NSLog(@"stocktypeIDstring = %@",stocktypeIDstring);
    if(stocktypeIDstring.length>0)
    {
        _ShopModel.stock_type_id = [stocktypeIDstring substringToIndex:[stocktypeIDstring length]-1];
    }
    NSLog(@"_ShopModel.stock_type_id=%@",_ShopModel.stock_type_id);
    
    
    //判断套餐是否有库存
    [self getCombostock];
    
    
}

#pragma mark 商品库存
-(NSString*)changestock:(int)tag
{
    
    NSString *stockstring =@"0";
    NSString *stocktypeID =@"0";
    
    if(_selectIDarray.count)
    {
        NSMutableString *typeidString=[[NSMutableString alloc]init];
        
        for(int j=0;j<_selectIDarray.count;j++)
        {
            NSString *str =_selectIDarray[j];
            
            if(str)
            {
                [typeidString appendString:str];
                if(j!=_selectIDarray.count-1)
                {
                    [typeidString appendString:@":"];
                }
            }
            
        }
        
        
        NSLog(@"typeidString is %@",typeidString);
        
        NSMutableArray *stockarr=[NSMutableArray array];
        stockarr=[NSMutableArray arrayWithArray:self.stocktypeArray];
        
        NSLog(@"stockarr = %@",stockarr);
        for(int i=0;i<stockarr.count;i++)
        {
            
            ShopDetailModel *model=stockarr[i];
            if([model.color_size isEqualToString:typeidString])
            {
                
                NSLog(@"model.stock =%@",model.stock);
                //商品名称
                UILabel *namelabel=(UILabel*)[_modelview viewWithTag:4321];
                //                namelabel.text=[NSString stringWithFormat:@"%@",_ShopModel.shop_name];
                namelabel.text = [self exchangeTextWihtString:_ShopModel.shop_name];
                _selectName=namelabel.text;
                
                //商品价格
                UILabel *pricelable=(UILabel*)[_modelview viewWithTag:8765];
//                pricelable.text=[NSString stringWithFormat:@"￥%.2f",[_combo_price floatValue]];
                
                
                pricelable.textColor=tarbarrossred;
                pricelable.font =[UIFont systemFontOfSize:15];
                _selectPrice=[NSString stringWithFormat:@"%.2f",[model.shop_se_price floatValue]];
                
                //商品库存
                UILabel *stocklable=(UILabel*)[_modelview viewWithTag:tag];
                stocklable.text=[NSString stringWithFormat:@"现有库存%@件",model.stock];
                stockstring=[NSString stringWithFormat:@"%@",model.stock];
                
                stocktypeID = [NSString stringWithFormat:@"%@",model.stock_type_id];
                
            }else{
                
                UILabel *stocklable=(UILabel*)[_modelview viewWithTag:tag];
                stocklable.text=[NSString stringWithFormat:@"现有库存%@件",stockstring];
            }
        }
        
    }
    
    return stocktypeID;
}

#pragma mark 根据id找名称
-(NSString*)findNamefromID:(NSString*)ID
{
    NSLog(@"self.stock_colorArray =%@",self.stock_colorArray);
    
    
    NSString *stringName;
    for(NSDictionary*dic in self.stock_colorArray)
    {
        
        if([ID isEqualToString:dic[@"id"]])
        {
            stringName = dic[@"attr_name"];
        }
    }
    
    NSLog(@"stringName=%@",stringName);
    
    return stringName;
}
-(void)getCombostock
{
    
   
        NSLog(@"_selectIDarray=%@",self.atrrListArray);
        
        for(int i=0;i<self.atrrListArray.count;i++)
        {
            
            UILabel *stocklable =(UILabel*)[_modelview viewWithTag:9875+i];
            NSLog(@"stocklable is %@",stocklable.text);
            
            if([stocklable.text isEqualToString:@"现有库存0件"])
            {
                UIButton *button=(UIButton*)[_modelview viewWithTag:9191];
                button.userInteractionEnabled=NO;
                button.alpha=0.4;
                
                return;
                
            }
            else{
                
                UIButton *button=(UIButton*)[_modelview viewWithTag:9191];
                button.userInteractionEnabled=YES;
                button.alpha=1;
                
            }
        }
}

#pragma mark **********************UitableView********************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView!=self.searchTableView) {
        return 1;
    } else
        return self.searchDataArr.count;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView!=self.searchTableView) {
        return _headView;
    } else {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 25)];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = RGBCOLOR_I(167,167,167);
        label.backgroundColor = RGBCOLOR_I(22,22,22);
        label.font = kFont6px(32);
        if (self.searchCateArr.count>section) {
            NSDictionary *tmpdic = self.searchCateArr[section];
            label.text = [NSString stringWithFormat:@"    %@",tmpdic[@"name"]];
        }
        return label;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView!=self.searchTableView) {
        if(self.slectbtn.tag==1000)
        {
            return self.dataArr.count+2;
            
        }else if (self.slectbtn.tag==1001)
        {
//            return self.SizeDataArray.count +2;
            return 3;
        }else{
            return self.commentDataArray.count;
        }
    } else
        return [self.searchDataArr[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView!=self.searchTableView) {
        return 40;
    } else
        return ZOOM(80);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    if (tableView!=self.searchTableView) {
        
        if(self.slectbtn.tag==1000)
        {
            if(indexPath.row==0)
            {
                return 0;
            }else if (indexPath.row <self.dataArr.count+1)
            {
                return kApplicationWidth*900/600;
//                return UITableViewAutomaticDimension;
            }
            else{
                _rowHeigh =self.TagViewHeigh;
                return _rowHeigh;
            }
            
            return kApplicationWidth*900/600;
            
        }else if (self.slectbtn.tag==1001)
        {
            
            if(indexPath.row == 0)
            {
                return ZOOM6(90);
            }else if (indexPath.row == 1)
            {
                return self.TagViewHeigh;
            }else{
                
                return ((kApplicationWidth)*230/108);
            }
            
        }else  {
            
            TFCommentModel *cModel = [self.commentDataArray objectAtIndex:indexPath.row];
            
            if (cModel.cellType == 7)
            {
                return ZOOM6(400);
            }
            if (cModel.cellType == 8 || cModel.cellType == 9)
            {
                return 50;
            }
            if (cModel.cellType == 1) {
                
                return [tableView fd_heightForCellWithIdentifier:@"ONECOMMENTCELL" cacheByIndexPath:indexPath configuration:^(OneCommentCell *cell) {
                    [weakSelf configureOneCell:cell atIndexPath:indexPath];
                }];
                
            } else if (cModel.cellType == 2) {
                
                return [tableView fd_heightForCellWithIdentifier:@"TWOCOMMENTCELL" cacheByIndexPath:indexPath configuration:^(TwoCommentCell *cell) {
                    [weakSelf configureTwoCell:cell atIndexPath:indexPath];
                }];
                
                
            } else if (cModel.cellType == 3) {
                
                return [tableView fd_heightForCellWithIdentifier:@"THREECOMMENTCELL" cacheByIndexPath:indexPath configuration:^(ThreeCommentCell *cell) {
                    [weakSelf configureThreeCell:cell atIndexPath:indexPath];
                }];
                
            } else if (cModel.cellType == 4) {
                
                return [tableView fd_heightForCellWithIdentifier:@"FOURCOMMENTCELL" cacheByIndexPath:indexPath configuration:^(FourCommentCell *cell) {
                    [weakSelf configureFourCell:cell atIndexPath:indexPath];
                }];
                
            } else if (cModel.cellType == 5) {
            
                return [tableView fd_heightForCellWithIdentifier:@"FIVECOMMENTCELL" cacheByIndexPath:indexPath configuration:^(FiveCommentCell *cell) {
                    [weakSelf configureFiveCell:cell atIndexPath:indexPath];
                }];
                
            } else if (cModel.cellType == 6) {
                
                return [tableView fd_heightForCellWithIdentifier:@"SIXCOMMENTCELL" cacheByIndexPath:indexPath configuration:^(SixCommentCell *cell) {
                    [weakSelf configureSixCell:cell atIndexPath:indexPath];
                }];
                
            }
            
            return 44+100;
        }
        
        return 40;

    } else
        return ZOOM(150);
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.slectbtn.tag==1000)
    {
        if(indexPath.row == self.dataArr.count-1 && !self.browseFlag)
        {
            self.browseFlag = YES; /**< 是否出现过 */
            if (self.browseCountBlock) {
                NSString *index_id = self.index_id;
                NSString *day = self.index_day;
                
                if (self.showGetMoneyWindow) {//浏览最后一次
                    [TaskSignModel getTaskHttp:index_id Day:day Success:^(id data) {
                        TaskSignModel *model = data;
                        if(model.status == 1)
                        {
                            [self pubclicLiulan];
                            //标记此任务完成
                            [Signmanager SignManarer].task_isfinish = YES;
                        }
                    }];
                }
                else {
                    
                    int rewardCount = (int)self.rewardCount; //分多少次奖励
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    NSString *count = [user objectForKey:TASK_LIULAN_SHOPCOUNT];
                    if(rewardCount >1)//多次奖励
                    {
                        if([self.rewardType isEqualToString:@"提现额度"])
                        {
                            [self publicTixianEdu];
                        }else{
                            [TaskSignModel getTaskHttp:index_id Day:day Success:^(id data) {
                                
                                TaskSignModel *model = data;
                                if(model.status == 1)
                                {
                                    [user setObject:[NSString stringWithFormat:@"%d",count.intValue+1] forKey:TASK_LIULAN_SHOPCOUNT];
                                    
                                    if (count.intValue +1 < [Signmanager SignManarer].liulanShopCount)
                                    {
                                        NSString *money = [self getRewad_type:self.rewardValue];
                                        [MBProgressHUD show:[NSString stringWithFormat:@"浏览完成,奖励%@",money] icon:nil view:nil];
                                    }else{
                                        [self pubclicLiulan];
                                    }
                                    
                                    //标记此任务完成
                                    [Signmanager SignManarer].task_isfinish = YES;
                                }
                            }];
                        }
                        
                    } else{
                        
                        if([self.rewardType isEqualToString:@"提现额度"])
                        {
                            [self publicTixianEdu];
                        }else{
                            [user setObject:[NSString stringWithFormat:@"%d",count.intValue+1] forKey:TASK_LIULAN_SHOPCOUNT];
                            
                            if([Signmanager SignManarer].liulanShopCount > 0)
                            {
                                if([Signmanager SignManarer].liulanShopCount <= count.intValue +1)
                                {
                                    [TaskSignModel getTaskHttp:index_id Day:day Success:^(id data) {
                                        TaskSignModel *model = data;
                                        if(model.status == 1)
                                        {
                                            [self pubclicLiulan];
                                            //标记此任务完成
                                            [Signmanager SignManarer].task_isfinish = YES;
                                        }
                                    }];
                                    
                                }else{
                                    [MBProgressHUD show:[NSString stringWithFormat:@"再浏览%d件可完成任务喔~",(int)[Signmanager SignManarer].liulanShopCount - count.intValue -1] icon:nil view:nil];
                                }
                            }
                            else{
                                [MBProgressHUD show:@"签到奖励不在这里哟~去其他页面看看吧" icon:nil view:nil];
                            }

                        }
                    }
                }
                
                self.browseCountBlock();
                
                CGFloat imageWidth = IMAGEW(@"hover_xunbao");
                CGFloat imageHeigh = IMAGEH(@"hover_xunbao");
                
                [UIView animateWithDuration:0.5 animations:^{
                    
                    self.SlideView.frame =CGRectMake(kScreenWidth+imageWidth, (kScreenHeight-imageHeigh)/2, imageWidth, imageHeigh);
                }];
                
            }
        }
    }else if(self.slectbtn.tag == 1002 && self.commentDataArray.count)
    {
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
}
- (void)publicTixianEdu
{
    if([Signmanager SignManarer].liulanAlreadyCount <= 0)//此浏览任务已经完成
    {
        return;
    }
    [Signmanager SignManarer].liulanTixianCount ++;
    NSString *index_id = self.index_id;
    NSString *day = self.index_day;
    
    NavgationbarView *mentionview = [NavgationbarView alloc];
    if([Signmanager SignManarer].liulanTixianCount == [Signmanager SignManarer].everyLinlanCount)
    {
        [TaskSignModel getTaskHttp:index_id Day:day Success:^(id data) {
            
            TaskSignModel *model = data;
            if(model.status == 1)
            {
                [Signmanager SignManarer].liulanTixianCount = 0;
                [Signmanager SignManarer].liulanAlreadyCount --;
                
                if([Signmanager SignManarer].liulanAlreadyCount <= 0)
                {
                    [self setTaskPopMindView:Task_liulan_tixian];//任务完成
                }else{
                    
                    NSString *money = [NSString stringWithFormat:@"%zd",[Signmanager SignManarer].everyLiulanRaward];
                    int count = (int)[Signmanager SignManarer].everyLinlanCount;
                    NSString *message = [NSString stringWithFormat:@"%@元提现现金已经发放，到账时间为3-5个工作日，请耐心等待。再次浏览%d次\n可再得%@元提现现金，继续努力！",money,count,money];
                    
                    [mentionview showLable:message Controller:self];
                }
            }else{
                [Signmanager SignManarer].liulanTixianCount --;
            }
        }];
    }else {
        NSInteger nextcount = [Signmanager SignManarer].everyLinlanCount - [Signmanager SignManarer].liulanTixianCount;
        
        NSString *message = [NSString stringWithFormat:@"再浏览%zd件可完成任务哦~",nextcount];
        [mentionview showLable:message Controller:self];
    }
}
- (void)pubclicLiulan
{
    if(!_SharePopview)
    {
        if([self.rewardType isEqualToString:@"提现额度"])
        {
            [self setTaskPopMindView:Task_liulan_tixian];
        }else{
            [self setTaskPopMindView:Task_dapeiFinish_type];
        }
        
        //强制浏览统计
        NSString *key = [NSString stringWithFormat:@"%lf,%ld",_currTimeCount, _browseCount];
        [YFShareModel getShareModelWithKey:key type:StatisticalTypeForcibly tabType:StatisticalTabTypeForcibly success:nil];
    }
}
#pragma mark - 获取cell
- (OneCommentCell*)getOneCell
{
    OneCommentCell *cell = [self.MyBigtableview dequeueReusableCellWithIdentifier:@"ONECOMMENTCELL"];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OneCommentCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (TwoCommentCell *)getTwoCell
{
    TwoCommentCell *cell = [self.MyBigtableview dequeueReusableCellWithIdentifier:@"TWOCOMMENTCELL"];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TwoCommentCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (ThreeCommentCell *)getThreeCell
{
    ThreeCommentCell *cell = [self.MyBigtableview dequeueReusableCellWithIdentifier:@"THREECOMMENTCELL"];
    return cell;
}

- (FourCommentCell *)getFourCell
{
    FourCommentCell *cell = [self.MyBigtableview dequeueReusableCellWithIdentifier:@"FOURCOMMENTCELL"];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FourCommentCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (FiveCommentCell *)getFiveCell
{
    FiveCommentCell *cell = [self.MyBigtableview dequeueReusableCellWithIdentifier:@"FIVECOMMENTCELL"];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FiveCommentCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (SixCommentCell *)getSixCell
{
    SixCommentCell *cell = [self.MyBigtableview dequeueReusableCellWithIdentifier:@"SIXCOMMENTCELL"];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SixCommentCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

#pragma mark - 配置cell
- (void)configureOneCell:(OneCommentCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    TFCommentModel *cModel = [self.commentDataArray objectAtIndex:indexPath.row];
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    [cell receiveDataModel:cModel];
}

- (void)configureTwoCell:(TwoCommentCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    TFCommentModel *cModel = [self.commentDataArray objectAtIndex:indexPath.row];
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    [cell receiveDataModel:cModel];
}

- (void)configureThreeCell:(ThreeCommentCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    TFCommentModel *cModel = [self.commentDataArray objectAtIndex:indexPath.row];
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    [cell receiveDataModel:cModel];
}

- (void)configureFourCell:(FourCommentCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    TFCommentModel *cModel = [self.commentDataArray objectAtIndex:indexPath.row];
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    [cell receiveDataModel:cModel];
}

- (void)configureFiveCell:(FiveCommentCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    TFCommentModel *cModel = [self.commentDataArray objectAtIndex:indexPath.row];
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    [cell receiveDataModel:cModel];
}

- (void)configureSixCell:(SixCommentCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    TFCommentModel *cModel = [self.commentDataArray objectAtIndex:indexPath.row];
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    [cell receiveDataModel:cModel];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView!=self.searchTableView) {
        if(self.slectbtn.tag == 1000)
        {
            if(indexPath.row <self.dataArr.count+1)
            {
                if (indexPath.row == 0)return ;
                NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],self.dataArr[indexPath.row-1]]];
                
                NSMutableArray *imgViewArr = [NSMutableArray array];
                if(imgUrl)
                {
                    [imgViewArr addObject:imgUrl];
                }
                
                if(imgViewArr.count)
                {
                    [self scaleView:imgViewArr];
                }
            }
        }
    } else {
        NSDictionary *dic = [self.searchDataArr[indexPath.section] objectAtIndex:indexPath.row];
        
        NSString *ID = dic[@"id"];
        //ID = %@",ID);
        NSString *title = dic[@"name"];
        //title = %@",title);
        
        TFSearchViewController *svc = [[TFSearchViewController alloc] init];
        svc.parentID = ID;
        svc.shopTitle = title;
        svc.typeName = self.typeName;
        svc.typeID = self.typeID;
        svc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:svc animated:YES];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.view bringSubviewToFront:self.screenBtn];
    
    if (tableView!=self.searchTableView) {
        if(self.slectbtn.tag==1000)//详情
        {
            self.MyBigtableview.separatorStyle = UITableViewCellSelectionStyleNone;
            ImageTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"imagecell"];
            if(!cell)
            {
                cell=[[ImageTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"imagecell"];
            }
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.defaultImage.center = cell.bigimage.center;
            
            if(indexPath.row==0)
            {
                
                cell.defaultImage.hidden = YES;
                
                UIView *headvvvv=(UIView*)[cell.contentView viewWithTag:8766];
                [headvvvv removeFromSuperview];
                
                UIView *headvvvv1=(UIView*)[cell.contentView viewWithTag:8777];
                [headvvvv1 removeFromSuperview];
                
                UILabel *headview=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 0)];
                headview.backgroundColor=[UIColor whiteColor];
                if(self.dataArr.count>0)
                {
                    headview.text=@"商品细节";
                    headview.tag=8766;
                    headview.textAlignment=NSTextAlignmentCenter;
                    headview.textColor=kTextGreyColor;
                    
                }
                
                [cell.contentView addSubview:headview];
                
            }else if(indexPath.row <self.dataArr.count+1){
                
                UIView *headvvvv=(UIView*)[cell.contentView viewWithTag:8766];
                [headvvvv removeFromSuperview];
                
                UIView *headvvvv1=(UIView*)[cell.contentView viewWithTag:8777];
                [headvvvv1 removeFromSuperview];
                
                if(self.dataArr.count)
                {
                
                    NSString *st = [DataManager sharedManager].img_rate>0?[NSString stringWithFormat:@"!%d",(int)[DataManager sharedManager].img_rate]:@"!450";
                    
//                    if (kDevice_Is_iPhone6Plus) {
//                        st = @"!450";
//                    } else {
//                        st = @"!382";
//                    }
                    
//                    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],self.dataArr[indexPath.row-1],st]];
                    
                    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],self.dataArr[indexPath.row-1]]];
                    __block float d = 0;
                    __block BOOL isDownlaod = NO;
                    kWeakSelf(cell);
                    [cell.bigimage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                        d = (float)receivedSize/expectedSize;
                        isDownlaod = YES;
                        
                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                        weakcell.defaultImage.hidden = YES;
                        
                        if (image != nil && isDownlaod == YES) {
                            weakcell.bigimage.alpha = 0;
                            [UIView animateWithDuration:0.5 animations:^{
                                weakcell.bigimage.alpha = 1;
                            } completion:^(BOOL finished) {
                            }];
                        } else if (image != nil && isDownlaod == NO) {
                            
                            weakcell.defaultImage.hidden = YES;
                            
                            weakcell.bigimage.image = image;
                        }
                    }];
                }
                
//                [cell.bigimage mas_makeConstraints:^(MASConstraintMaker *make){
//                    make.left.equalTo(cell.contentView.mas_left);
//                    make.top.equalTo(cell.contentView.mas_top);
//                    make.width.mas_equalTo(kScreenWidth);
//                    make.bottom.equalTo(cell.contentView.mas_bottom);
//                    make.height.mas_equalTo(cell.bigimage.width).multipliedBy(1.5);// 高/宽 == 0.5
//                }];
            }
            else{
                
                self.ShopTagView.frame = CGRectMake(0,0, CGRectGetWidth(self.ShopTagView.frame), CGRectGetHeight(self.ShopTagView.frame));
                
                [cell.contentView addSubview:self.ShopTagView];
            }
            
            return cell;
            
        }else if (self.slectbtn.tag==1001)//参数
        {
            self.MyBigtableview.separatorStyle = UITableViewCellSelectionStyleNone;
            
            if(indexPath.row == 0 || indexPath.row == 1)
            {
                SizeandColorTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SizeCell"];
                if(!cell)
                {
                    cell=[[SizeandColorTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SizeCell"];
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentView.backgroundColor = [UIColor whiteColor];
                cell.lable1.text=@"";
                cell.lable2.text=@"";
                cell.lable3.text=@"";
                cell.lable4.text=@"";
                cell.lable5.text=@"";
                
                if(indexPath.row ==0 )
                {
                    cell.backgroundColor = kBackgroundColor;
                    [cell.contentView addSubview:self.codelable];
                    
                }else if (indexPath.row == 1){
                    
                    self.ShopTagView.frame = CGRectMake(0, 0, CGRectGetWidth(self.ShopTagView.frame), CGRectGetHeight(self.ShopTagView.frame));
                    [cell.contentView addSubview:self.ShopTagView];
                }
                
                return cell;
            }else
            {
                ImageTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"imagecell"];
                if(!cell)
                {
                    cell=[[ImageTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"imagecell"];
                }
                
                [cell.bigimage sd_setImageWithURL:[NSURL URLWithString:@"https://yssj668.b0.upaiyun.com/system/shop_details.png"]];
                
                return cell;
                //                cell.backgroundColor = [UIColor clearColor];
                //                [cell.contentView addSubview:self.footimage];
            }
            
        } else if(self.slectbtn.tag == 1002)//评论
        {
//            self.MyBigtableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            if(self.commentDataArray.count > 0)
            {
                TFCommentModel *cModel;
                cModel = [self.commentDataArray objectAtIndex:indexPath.row];
            
                if (cModel.cellType == 1) {
                    
                    OneCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ONECOMMENTCELL" forIndexPath:indexPath];
                    //        [cell receiveDataModel:cModel];
                
                    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
                        [cell setSeparatorInset:UIEdgeInsetsZero];
                    }
                    
                    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
                        [cell setLayoutMargins:UIEdgeInsetsZero];
                    }

                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    [self configureOneCell:cell atIndexPath:indexPath];
                    return cell;
                    
                }
                else if (cModel.cellType == 2) {  //评+回
                    
                    TwoCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TWOCOMMENTCELL" forIndexPath:indexPath];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    //        [cell receiveDataModel:cModel];
                    [self configureTwoCell:cell atIndexPath:indexPath];
                    return cell;
                    
                } else if (cModel.cellType == 3) {
                    
                    ThreeCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THREECOMMENTCELL" forIndexPath:indexPath];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    //        [cell receiveDataModel:cModel];
                    [self configureThreeCell:cell atIndexPath:indexPath];
                    return cell;
                    
                    
                } else if (cModel.cellType == 4) {
                    
                    FourCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FOURCOMMENTCELL" forIndexPath:indexPath];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    //        [cell receiveDataModel:cModel];
                    [self configureFourCell:cell atIndexPath:indexPath];
                    return cell;
                    
                } else if (cModel.cellType == 5) {
                    
                    FiveCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FIVECOMMENTCELL" forIndexPath:indexPath];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    //        [cell receiveDataModel:cModel];
                    [self configureFiveCell:cell atIndexPath:indexPath];
                    return cell;
                    
                } else if (cModel.cellType == 6) {
                    
                    SixCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SIXCOMMENTCELL" forIndexPath:indexPath];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    //        [cell receiveDataModel:cModel];
                    [self configureSixCell:cell atIndexPath:indexPath];
                    return cell;
                }else if (cModel.cellType == 7)
                {
//                    self.MyBigtableview.separatorStyle = UITableViewCellSelectionStyleNone;
                    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
                    if(!cell)
                    {
                        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    [self.speedProgressView removeFromSuperview];
                    self.speedProgressView = nil;
                    
                    CGFloat colorp = 100;
                    CGFloat typep = 100;
                    CGFloat workp = 100;
                    CGFloat costp = 100;
                    if(_ShopModel.color_count > 0)
                    {
                        colorp=([_ShopModel.color_count doubleValue]/[_ShopModel.eva_count  doubleValue])*100;
                    }
                    if(_ShopModel.type_count > 0 )
                    {
                        typep =([_ShopModel.type_count doubleValue]/[_ShopModel.eva_count  doubleValue])*100;
                    }
                    if(_ShopModel.work_count > 0)
                    {
                        workp =([_ShopModel.work_count doubleValue]/[_ShopModel.eva_count  doubleValue])*100;
                    }
                    if(_ShopModel.cost_count > 0)
                    {
                        costp =([_ShopModel.cost_count doubleValue]/[_ShopModel.eva_count  doubleValue])*100;
                    }
                    [self.pArray addObject:[NSString stringWithFormat:@"%.0f",colorp>100?100:colorp]];
                    [self.pArray addObject:[NSString stringWithFormat:@"%.0f",typep>100?100:typep]];
                    [self.pArray addObject:[NSString stringWithFormat:@"%.0f",workp>100?100:workp]];
                    [self.pArray addObject:[NSString stringWithFormat:@"%.0f",costp>100?100:costp]];
                    
                    [cell.contentView addSubview:self.speedProgressView];
                    
                    return cell;
                }
                else if (cModel.cellType == 8)//优先点评
                {
//                    self.MyBigtableview.separatorStyle = UITableViewCellSelectionStyleNone;
                    
                    PreferredMoreTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PreferredCell"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    [cell refreshTitle:@"优选点评"];
                    return cell;

                    
                }else if (cModel.cellType == 9)//更多点评
                {
//                    self.MyBigtableview.separatorStyle = UITableViewCellSelectionStyleNone;
                
                    PreferredMoreTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PreferredCell"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    [cell refreshTitle:@"更多点评"];
                    return cell;
                }
                
            }
        }
        
        return nil;
        
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLID"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLID"];
            cell.backgroundColor = RGBCOLOR_I(22,22,22);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(ZOOM(62), (CGRectGetHeight(cell.frame)-ZOOM(100))/2, ZOOM(67), ZOOM(100))];
            iv.tag = 500;
            //        iv.contentMode = UIViewContentModeScaleAspectFit;
            [cell.contentView addSubview:iv];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(iv.frame.origin.x+iv.frame.size.width+ZOOM(62), 0, ZOOM(300), CGRectGetHeight(cell.frame))];
            titleLabel.tag = 501;
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.font = kFont6px(34);
            [cell.contentView addSubview:titleLabel];
            
            UIImageView *iiv = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.frame.size.width-ZOOM(62)-ZOOM(27), (CGRectGetHeight(cell.frame)-ZOOM(55))/2, ZOOM(27), ZOOM(55))];
            iiv.image = [UIImage imageNamed:@"搜索更多"];
            iiv.contentMode = UIViewContentModeScaleAspectFit;
            [cell.contentView addSubview:iiv];
        }
        UIImageView *iv = (UIImageView *)[cell.contentView viewWithTag:500];
        UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:501];
        NSDictionary *dic = [self.searchDataArr[indexPath.section] objectAtIndex:indexPath.row];
        //    iv.image = [UIImage imageNamed:dic[@"name"]];
        
        [iv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy], dic[@"ico"]]]];
        
        titleLabel.text = dic[@"name"];
        return cell;
        
    }
    
    return 0;
}

#pragma mark ************************其它共用***************************
// 让tableview滑动到顶部
-(void)UpScroll:(id)sender{
    
    UIView *headview=(UIView*)[self.view viewWithTag:3838];
    headview.backgroundColor=[UIColor clearColor];
    
    [self.MyBigtableview setContentOffset:CGPointMake(0,0) animated:YES];
}

-(void)upToTop:(UIButton*)sender
{
    [self.MyBigtableview setContentOffset:CGPointMake(0,0) animated:YES];
}
//回到顶部按钮
- (void)upToTop
{
    
    _UpBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _UpBtn.frame = CGRectMake(kScreenWidth-40, kScreenHeight-100, 30, 30);
    [_UpBtn setBackgroundImage:[UIImage imageNamed:@"组-2"] forState:UIControlStateNormal];
    
    [_UpBtn.layer setMasksToBounds:YES];
    _UpBtn.alpha=0.9;
    [_UpBtn.layer setCornerRadius:15.0];
    [self.view addSubview:_UpBtn];
    [_UpBtn addTarget:self action:@selector(UpScroll:) forControlEvents:UIControlEventTouchUpInside];
    [_UpBtn setHidden:YES];
}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        //json解析失败:%@",err);
        return nil;
    }
    return dic;
}

- (CGFloat)getCellHeight:(UITableViewCell*)cell
{
    [cell layoutIfNeeded];
    [cell updateConstraintsIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}
#pragma mark 加购物车 购买
-(void)buttonClick:(UIButton*)sender
{
    kSelfWeak;
    [self loginVerifySuccess:^{
        
        kSelfStrong;
        if(sender.tag == 5858)//加入购物车
        {
            [MobClick event:SHOP_ADDGOUWUCHE];
    
            [self colorAndsizeModelview:NO];
        }else{//购买
            [self colorAndsizeModelview:NO];
        }
        
        if(strongSelf.SizeDataArray.count)
        {
            
            CGFloat YY=0;
            
            if(FiveAndFiveInch)
            {
                YY=300;
            }
            else if(FourAndSevenInch)
            {
                YY=300;
            }else if (FourInch)
            {
                YY=180;
            }
            
            else{
                
                YY=110;
            }
            
            [UIView animateWithDuration:0.1 animations:^{
                strongSelf -> _modelview.frame=CGRectMake(0, YY, kApplicationWidth, kApplicationHeight-YY+20);
                
            } completion:^(BOOL finished) {
                
                
            }];
            
//            [strongSelf presentSemiView:_modelview];
            
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"系统繁忙,请稍后再试" Controller:strongSelf];
            
        }

        strongSelf.tag = sender.tag;
    }];
}

#pragma mark 跳转到登录界面
- (void)ToLogin :(NSInteger)tag
{
    LoginViewController *login=[[LoginViewController alloc]init];
    login.tag = tag;
    login.loginStatue=@"toBack";
    login.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:login animated:YES];
}

- (float)widthCoefficient:(float)width
{
    if (ThreeAndFiveInch) {
        return width*1;
    } else if (FourInch) {
        return width*1;
    } else if (FourAndSevenInch) {
        return width*1.172;
    } else if (FiveAndFiveInch) {
        return width*1.294;
    } else {
        return width*1;
    }
}

- (NSString *)exchangeTextWihtString:(NSString *)text
{
    if ([text rangeOfString:@"】"].location != NSNotFound){
        NSArray *arr = [text componentsSeparatedByString:@"】"];
        NSString *textStr;
        if (arr.count == 2) {
            textStr = [NSString stringWithFormat:@"%@%@】", arr[1], arr[0]];
        }
        return textStr;
    }
    return text;
}
#pragma mark 获取是星期几
-(int)getweekday
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit |NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:now];
    
    //-----------weekday is %d",(int)[comps weekday]);//在这里需要注意的是：星期日是数字1，星期一时数字2，以此类推。。。
    int weekday = 0;
    if([comps weekday])
    {
        weekday = (int)[comps weekday]-1;
    }
   
    return weekday;
}

- (NSArray *)getArrayFindFromArray:(NSArray *)sourceArr withKey:(NSString *)key
{
    NSMutableArray *muArr = [NSMutableArray array];
    for (NSDictionary *dic in sourceArr) {
        [muArr addObject:dic[key]];
    }
    return muArr;
}
- (NSArray *)sortTheTitleFromArray:(NSArray *)arr
{
    NSMutableArray *muArr = [NSMutableArray arrayWithArray:arr];
    
    for (int i = 0; i<muArr.count-1; i++) {
        for (int j = 0; j<muArr.count-i-1; j++) {
            NSDictionary *dic = muArr[j];
            NSDictionary *dic2 = muArr[j+1];
            
            if ([dic[@"sequence"] intValue]>[dic2[@"sequence"] intValue]) {
                [muArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    
    return muArr;
}

-(void)backdetailview:(NSNotification*)note
{
    [self markrequestHttp];
}

-(CGFloat)getRowHeight:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat height = 0;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(kScreenWidth-2*ZOOM(40), 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    return height;
}

-(CGFloat)getRowWidth:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat width = 0;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(kScreenWidth, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        width=rect.size.width;
        
    }
    
    return width;
}

- (void)gotovc:(NSString*)title Tasktype:(TaskPopType)type
{
    if ([title isEqualToString:@"任务列表"])
    {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[MakeMoneyViewController class]]){
                [self.navigationController popToViewController:controller animated:YES];
                return;
            }
        }

    }else if ([title isEqualToString:@"去结算"])
    {
        NewShoppingCartViewController *shoppingcart =[[NewShoppingCartViewController alloc]init];
        shoppingcart.ShopCart_Type = ShopCart_NormalType;
        [self.navigationController pushViewController:shoppingcart animated:YES];

    }else if ([title hasPrefix:@"买买买"])
    {
        if(type != Task_dapeiFinish_type)
        {
            [Mtarbar selectedToIndexViewController:0];
        }
    }else if ([title hasPrefix:@"一键做下个任务"]){
       
        [[NextTaskManager taskManager] bakeToMakemoneyVC];
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

- (void)setShoppingVCIndex:(NSInteger)currIndex
{
    UINavigationController *shopNC = Mtarbar.viewControllers[1];
    TFShoppingViewController *shopVC = [[shopNC viewControllers] firstObject];
    shopVC.currPageViewController = currIndex;
    Mtarbar.selectedIndex = 0;
}

#pragma mark 点击商品图片缩放效果
- (void)scaleView:(NSMutableArray*)imgViewArr
{
    self.imgFullScrollView = [[FullScreenScrollView alloc] initWithPicutreArray:imgViewArr withCurrentPage:1];
    
    
    self.imgFullScrollView.backgroundColor = kBackgroundColor;
    
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-ZOOM(150)+20, kApplicationWidth, ZOOM(150))];
    
    footView.backgroundColor = [UIColor whiteColor];
    [self.imgFullScrollView addSubview:footView];
    
    NSArray *titleArray = @[@"加入购物车"];
    if([self.stringtype isEqualToString:@"活动商品"])
    {
        titleArray =@[@"0元购全返"];
    }
    for (int i=0; i<titleArray.count; i++) {
        UIButton *imgbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        imgbtn.frame = CGRectMake((kApplicationWidth-ZOOM(100*3.4)*titleArray.count)/2+ZOOM(100*3.4)*i, (CGRectGetHeight(footView.frame)-ZOOM(120))*0.5, ZOOM(100*3.4), ZOOM(120));
        
        imgbtn.backgroundColor = tarbarrossred;
        imgbtn.tag = 5858+i;
        if([self.stringtype isEqualToString:@"活动商品"])
        {
            imgbtn.tag = 5859;
        }
        imgbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(57)];
        [imgbtn setTintColor:[UIColor whiteColor]];
        [imgbtn setTitle:titleArray[i] forState:UIControlStateNormal];
        [imgbtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [footView addSubview:imgbtn];
        
    }
    
    self.imgFullScrollView.alpha = 0;
    
    [self.view addSubview:self.imgFullScrollView];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.imgFullScrollView.frame=CGRectMake(0,0, kApplicationWidth,kApplicationHeight+kUnderStatusBarStartY);
        
        self.imgFullScrollView.alpha=1;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)jump
{
    LoginViewController *login=[[LoginViewController alloc]init];
    
    login.tag=1000;
    [self.navigationController pushViewController:login animated:YES];
}

- (UIView*)creatTagView:(CGFloat)YY
{
    if(self.ShopTagView == nil)
    {
        UIView *baseview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        baseview.tag = 8777;
        baseview.backgroundColor = [UIColor whiteColor];
        
        //***************尺码
        CGFloat sizeimgWith = ZOOM6(76)*2.9;
        UIImageView *sizeimg = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(baseview.frame)-sizeimgWith)/2,ZOOM6(50), sizeimgWith, ZOOM6(76))];
        sizeimg.image = [UIImage imageNamed:@"chimacankao"];
        [baseview addSubview:sizeimg];
        
        UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(50), CGRectGetMaxY(sizeimg.frame), kApplicationWidth-ZOOM(50)*2, 60)];
        titlelable.text = @"温馨提示:手工平铺测量,因测量方式不同,实物会有1-3CM的误差,属于正常范围。";
        titlelable.numberOfLines = 0;
        titlelable.font = [UIFont systemFontOfSize:ZOOM6(24)];
        titlelable.textColor = RGBCOLOR_I(168, 168, 168);
        [baseview addSubview:titlelable];
        
        //尺码参数
        UIView *sizeview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titlelable.frame), kScreenWidth, self.SizeDataArray.count*ZOOM6(60))];
        
        MyLog(@"self.SizeDataArray = %@",self.SizeDataArray);
        for(int i =0;i<self.SizeDataArray.count;i++)
        {
            UIView *sview = [[UIView alloc]initWithFrame:CGRectMake(0, ZOOM6(60)*i, kScreenWidth, ZOOM6(60))];
            if(i==0)
            {
                sview.backgroundColor = RGBCOLOR_I(168, 168, 168);
            }
            else if(i %2 ==0)
            {
                sview.backgroundColor = RGBCOLOR_I(246, 246, 246);
            }
            
            NSString *sizestr = self.SizeDataArray[i];
            NSArray *brr = [sizestr componentsSeparatedByString:@","];
            
            for(int j=0;j<brr.count;j++)
            {
                CGFloat slableHeigh = (kScreenWidth-2*ZOOM(50))/5;
                UILabel *slable = [[UILabel alloc]initWithFrame:CGRectMake(slableHeigh*j+ZOOM(50), 0, slableHeigh, CGRectGetHeight(sview.frame))];
                slable.font = [UIFont systemFontOfSize:ZOOM6(24)];
                slable.text = brr[j];
                
                
                if(i==0)
                {
                    slable.textColor = [UIColor whiteColor];
                    if(j!=0)
                    {
                        slable.textAlignment = NSTextAlignmentCenter;
                    }
                    
                }else{
                    if(j==0)
                    {
                        slable.textColor = kTextColor;
                    }else{
                        slable.textColor = kTitleColor;
                        slable.textAlignment = NSTextAlignmentCenter;
                    }
                }
                
                if(j<=6)
                {
                    [sview addSubview:slable];
                }
            }
            [sizeview addSubview:sview];
        }
        
        [baseview addSubview:sizeview];
        
        
        //***************标签
        UIView *tagView =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sizeview.frame), kApplicationWidth, 0)];
        [baseview addSubview:tagView];
        
        UIImageView *sizeimage = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(50), ZOOM6(30)+CGRectGetMinY(tagView.frame), kScreenWidth-2*ZOOM(50), (kScreenWidth-2*ZOOM(50))/2.5)];
        sizeimage.image = [UIImage imageNamed:@"chimabiao"];
        if(YY >0)
        {
            sizeimage.frame = CGRectMake(ZOOM(50), YY, kScreenWidth-2*ZOOM(50), 0);
        }
        [tagView addSubview:sizeimage];
        
        //获取商品标签的数据
        NSMutableString *tagstring;
        if(_ShopModel.shop_tag !=nil)
        {
            tagstring = [NSMutableString stringWithString:_ShopModel.shop_tag];
        }
        NSArray *tagArray = [tagstring componentsSeparatedByString:@","];
        //通过ID查询名称
        NSArray *nameArr = [self hoboFindDataForTAGDB:tagArray];
        
        MyLog(@"nameArr = %@",nameArr);
        
        //面料成分含量
        NSString *mainstuff = @"";
        NSString *mainingredient = @"";
        NSArray *stuffArr = @[@"10",@"25"];
        NSMutableArray *stuffnameArr = [NSMutableArray array];
        NSMutableDictionary *stuffdictionary = [NSMutableDictionary dictionary];
        
        NSArray *afterarray = @[@"1",@"8,9,11",@"4",@"7",@"5",@"2",@"3",@"6",@"12",@"13,14,15",@"16",@"",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24"];
        
        NSMutableArray *titlenameArray = [NSMutableArray array];
        for(int j =0;j<afterarray.count;j++)
        {
            for(NSDictionary *dic in _sequenceArray)
            {
                NSMutableString *sequenceid = [NSMutableString stringWithString:afterarray[j]];
                
                NSArray *sequenceArr =[NSArray array];
                if(sequenceid)
                {
                    sequenceArr =[sequenceid componentsSeparatedByString:@","];
                }
                MyLog(@"sequenceArr=%@",sequenceArr);
                
                for(int k =0 ;k<sequenceArr.count;k++)
                {
                    NSString *title = [dic objectForKey:sequenceArr[k]];
                    
                    if(title !=nil)
                    {
                        [titlenameArray addObject:title];
                        break;
                    }
                }
                
                if(j == afterarray.count-1)
                {
                    for(int h =0;h<stuffArr.count;h++)
                    {
                        NSString *title = [dic objectForKey:stuffArr[h]];
                        
                        if(title !=nil)
                        {
                            if(h==0)
                            {
                                [stuffdictionary setObject:@"主面料成分含量" forKey:title];
                            }else{
                                [stuffdictionary setObject:@"羽绒服充绒量" forKey:title];
                            }
                            [stuffnameArr addObject:title];
                        }
                    }
                }
            }
        }
        
        CGFloat tagimageWith = ZOOM6(76)*2.9;
        CGFloat tagimageHeigh = 0;
        CGFloat taimageYY =0;
        if(titlenameArray.count>0)
        {
            taimageYY = CGRectGetMaxY(sizeimage.frame)+ZOOM6(50);
            tagimageHeigh = ZOOM6(76);
        }else{
            taimageYY = CGRectGetMaxY(sizeimage.frame);
            tagimageHeigh = 0;
        }
        
        UIImageView *tagimage = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(tagView.frame)-tagimageWith)/2, taimageYY, tagimageWith, tagimageHeigh)];
        
        tagimage.image = [UIImage imageNamed:@"shangpinbiaoqian"];
        
        [tagView addSubview:tagimage];
        
        UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 0)];
        [tagView addSubview:backview];
        
        UIButton *colorbtn;
        
        int xx =0;
        int yy =0;
        CGFloat btnwidh=(kApplicationWidth-(30+(ZOOM(50)*2)))/4;
        CGFloat heigh = 30;
        
        CGFloat titleViewYY = CGRectGetMaxY(tagimage.frame);
        
        if([stuffnameArr count])
        {
            mainstuff = stuffnameArr.count==2?stuffnameArr[1]:stuffnameArr[0];
            NSString *strr = [stuffdictionary objectForKey:mainstuff];
            mainingredient =stuffnameArr.count==2?@"羽绒服充绒量":strr;
        }
        
        for(int j=0;j<titlenameArray.count;j++)
        {
            xx = j%4;
            yy = j/4;
            
            if(mainingredient.length>0){
                xx = j%4-1;
                yy = j/4+1;
                
                if(j==0)
                {
                    xx = 3;
                    yy = 0;
                    
                    UILabel *FabricLabel = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(50), titleViewYY+15, btnwidh*3+10*2, heigh)];
                    FabricLabel.text = [NSString stringWithFormat:@"%@:%@",mainingredient,mainstuff];
                    
                    FabricLabel.textAlignment = NSTextAlignmentCenter;
                    FabricLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
                    FabricLabel.textColor = tarbarrossred;
                    FabricLabel.layer.borderWidth = 0.5;
                    FabricLabel.layer.cornerRadius = 5;
                    FabricLabel.layer.borderColor = tarbarrossred.CGColor;
                    [backview addSubview:FabricLabel];
                    
                }else if (j<5)
                {
                    xx = j-1;
                    yy = 1;
                }else{
                    if(j%4==0)
                    {
                        xx = 3;
                        yy -=1;
                    }
                }
                
            }
            
            colorbtn=[[UIButton alloc]init];
            
            colorbtn.frame=CGRectMake(ZOOM(50)+(btnwidh+10)*xx, titleViewYY+15+(heigh+10)*yy, btnwidh, heigh);
            
            [colorbtn setTitle:titlenameArray[j] forState:UIControlStateNormal];
            
            colorbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(46)];
            [colorbtn setTitleColor:tarbarrossred forState:UIControlStateNormal];
            
            colorbtn.layer.borderWidth=0.5;
            colorbtn.layer.borderColor=tarbarrossred.CGColor;
            colorbtn.tintColor=tarbarrossred;
            colorbtn.layer.cornerRadius = 5;
            colorbtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(46)];
            
            [backview addSubview:colorbtn];
        }
        
        //    NSString *text = @"亲爱哒，衣蝠平台所售女装皆对接具有原创设计能力的厂家。每一件美衣均为平台买手实衣认证。款式、材料都经过买手严格筛选，最终可以呈现在您的面前。衣蝠致力于为用户提供最时尚最具性价比的女装。";
        CGFloat discriptionlabHeigh = 0;
        
        UIImageView *discriptionlab = [[UIImageView alloc]init];
        if(titlenameArray.count>0)
        {
            discriptionlab.frame = CGRectMake(0, CGRectGetMaxY(colorbtn.frame)+ZOOM6(60), kScreenWidth, discriptionlabHeigh);
        }else{
            discriptionlab.frame = CGRectMake(0, titleViewYY+ZOOM6(40), kScreenWidth, discriptionlabHeigh);
        }
        
        discriptionlab.image = [UIImage imageNamed:@"fwcn"];
        
        CGFloat spacewith = 0;
        if(self.slectbtn.tag==1000)
        {
            [backview addSubview:discriptionlab];
            spacewith = -20;
        }else if (self.slectbtn.tag==1001)
        {
            spacewith = -20;
        }
        
        backview.frame=CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(discriptionlab.frame)+spacewith);
        
        tagView.frame = CGRectMake(0, 5, kApplicationWidth, backview.frame.size.height);
        
        baseview.frame=CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(tagView.frame));
        if(baseview.frame.size.height > 0)
        {
            return baseview;
        }
    }
    return 0;
}

#pragma mark 点击评论图片
-(void)imageclick:(UITapGestureRecognizer*)tap
{
    //创建底视图
    UIView *photoview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY)];
    photoview.tag=8888;
    photoview.backgroundColor=[UIColor blackColor];
    
    //获得图片数据源
    CommenModel *model= self.commentDataArray[tap.view.tag/10000-1];
    NSArray *imageArray=[model.pic componentsSeparatedByString:@","];
    
    //图片加在photoscrollview上
    self.photoscrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, (kApplicationHeight-300)/2, kApplicationWidth, 300)];
    self.photoscrollview.pagingEnabled=YES;
    self.photoscrollview.delegate=self;
    self.photoscrollview.contentSize=CGSizeMake(imageArray.count*kApplicationWidth, 0);
    
    if(kScreenWidth==320)
    {
        _pageview=[[UIPageControl alloc]initWithFrame:CGRectMake(0, kScreenHeight-30, kScreenWidth, 25)];
    }else{
        _pageview=[[UIPageControl alloc]initWithFrame:CGRectMake(0, kScreenHeight-40, kScreenWidth-50, 25)];
        
    }
    _pageview.numberOfPages=imageArray.count;
    _pageview.currentPage=tap.view.tag%10000;
    _pageview.userInteractionEnabled = NO;
    [photoview addSubview:_pageview];
    
    self.photoscrollview.contentOffset=CGPointMake(_pageview.currentPage*kApplicationWidth, 0);
    
    
    for(int i=0;i<imageArray.count;i++)
    {
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(kApplicationWidth*i, 0, kApplicationWidth, 300)];
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PHOTOhttp,imageArray[i]]]];
        image.tag=111+i;
        [self.photoscrollview addSubview:image];
        
        UITapGestureRecognizer *imagetap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(commonimgClick:)];
        [image addGestureRecognizer:imagetap];
        image.userInteractionEnabled=YES;
    }
    
    [photoview addSubview:self.photoscrollview];
    [self.view addSubview:photoview];
    
    //    将当前view放到首层
    [self.view bringSubviewToFront:photoview];
}

-(void)commonimgClick:(UITapGestureRecognizer*)imagetap
{
    UIView *view=(UIView*)[self.view viewWithTag:8888];
    
    [UIView animateWithDuration:0.5 animations:^{
        [view removeFromSuperview];
        
    }];
}

#pragma mark 详情 尺码 评价
-(void)butclick:(UIButton*)sender
{
    [self.view bringSubviewToFront:self.screenBtn];
    
    if (_btnTag == sender.tag) return ;
    _btnTag = sender.tag;
    [self.MyBigtableview registerNib:[UINib nibWithNibName:@"SizeandColorTableViewCell" bundle:nil] forCellReuseIdentifier:@"SizeCell"];
    
    UIView *view1=(UIView*)[self.view viewWithTag:8766];
    
    if(view1)
    {
        [view1 removeFromSuperview];
        
        for(UIView *vv in view1.subviews)
        {
            [vv removeFromSuperview];
        }
    }
    
    for(int i=0;i<3;i++)
    {
        UIButton *btn=(UIButton*)[self.view viewWithTag:1000+i];
        UILabel *lable=(UILabel*)[self.view viewWithTag:2000+i];
        if(i+1000==sender.tag)
        {
            [btn setTitleColor:tarbarrossred forState:UIControlStateNormal];
            btn.backgroundColor=[UIColor clearColor];
            
            if(i==0)
            {
                [self.MyBigtableview removeFooter];
                
            }else if (i==1)
            {
                [MobClick event:SHOP_CANSHU];
                [self.MyBigtableview removeFooter];
                
            }else if (i==2)
            {
                [MobClick event:SHOP_PINGJIA];
                
                kWeakSelf(self);
                [self.MyBigtableview addFooterWithCallback:^{
                    
                    _pagecount++;
                    
                    [weakself commentHttp];
                }];
            }
            
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            lable.backgroundColor=[UIColor clearColor];
        }
        
    }
    
    self.slectbtn.selected=NO;
    sender.selected=YES;
    self.slectbtn=sender;
    self.MyBigtableview.tableFooterView=_tableFootView;
    
    //加footview
    _footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 0)];
    
    if(self.slectbtn.tag==1000)
    {
        self.MyBigtableview.tableFooterView=_tableFootView;
    }
    else if (self.slectbtn.tag==1001)
    {
        _footView.frame = CGRectMake(_footView.frame.origin.x, _footView.frame.origin.y, _footView.frame.size.width, 0);
        self.MyBigtableview.tableFooterView=_footView;
    }else{

        CGFloat heigh = self.MyBigtableview.contentSize.height  -_footView.frame.size.height - self.Myscrollview.frame.size.height;
        if(heigh > kApplicationHeight-120)
        {
            _footView.frame = CGRectMake(_footView.frame.origin.x, _footView.frame.origin.y, _footView.frame.size.width, 0);
        }else{
            _footView.frame = CGRectMake(_footView.frame.origin.x, _footView.frame.origin.y, _footView.frame.size.width, kApplicationHeight-heigh);
        }
        self.MyBigtableview.tableFooterView= _footView;
    }
        
    CGFloat temH = self.MyBigtableview.tableHeaderView.frame.size.height;
    self.MyBigtableview.contentOffset = CGPointMake(0, temH - 40 - 30 + 8);

    if(self.slectbtn.tag==1000 || self.slectbtn.tag==1001)
    {
        [self.MyBigtableview reloadData];
    }else{
        
        [self.MyBigtableview reloadData];
    }
    
}

#pragma mark 购物车 联系卖家
-(void)shopClick:(UIButton*)sender
{
    kSelfWeak;
    [self loginVerifySuccess:^{
        
        if(sender.tag==4000 || sender.tag ==4001)
        {
    
            [TFStatisticsClickVM handleDataWithPageType:nil withClickType:@"商品详情页购物车" success:^(id data, Response *response) {
            } failure:^(NSError *error) {
            }];
            
            [MobClick event:SHOP_GOUWUCHE];
            
            NewShoppingCartViewController *shoppingcart =[[NewShoppingCartViewController alloc]init];
            shoppingcart.ShopCart_Type = ShopCart_NormalType;
            [self.navigationController pushViewController:shoppingcart animated:YES];
            
        }else{
            
            if(sender.selected == NO)
            {
                NSString *currTime = [MyMD5 getCurrTimeString:@"year-month-day"];
                [[NSUserDefaults standardUserDefaults] setObject:currTime forKey:ShareAnimationTime];
                [_aView animationStart:NO];
                
                //                [weakSelf creatShareModelView];
                
                [weakSelf getShareImage];
                
                sender.selected = YES;
            }
            
        }
    }];
}
#pragma mark 加入购物车 立即购买
-(void)contactClick:(UIButton*)sender
{
    if(sender.tag != 3000)//购买
    {
        //商品详情页点击购买按钮弹出0元购任务弹窗的需求（白色弹窗），现在需求修改为：
        //1.新手任务第一天，每次点击购买按钮都弹出
        //2.新手任务第二天，前两次点击购买按钮，弹出
        //3.其余新手任务期间，点击购买按钮，每天只弹一次
        //4.老用户 弹窗弹出规则不变
        //记录超级0元购弹出时间（每天只弹一次）
        
        if(sender.tag == 3002)//单独购买
        {
            [self gocontact:sender];
        }else{//1元购 或者0元购 疯狂星期一购 活动商品
            if(_isMonday == YES)
            {
                [self gocontact:sender];
            }else if ([self.stringtype isEqualToString:@"活动商品"] && !self.isNOFightgroups)
            {
                [self gocontact:sender];
            }
            else{
                if(self.isNewbie)
                {
//                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//                    BOOL record = YES;
//
//                    if([self.current_date isEqualToString:@"newbie01"])//第一天
//                    {
//                        record = NO;
//                    }else if ([self.current_date isEqualToString:@"newbie02"])//第二天
//                    {
//                        NSString *shoppingupcount = [user objectForKey:SUPPERERROSHOPPINGUPCOUNT];
//                        if(shoppingupcount.intValue < 2)
//                        {
//                            record = NO;
//                            [user setObject:[NSString stringWithFormat:@"%d",shoppingupcount.intValue+1] forKey:SUPPERERROSHOPPINGUPCOUNT];
//                        }else{
//                            record = YES;
//                        }
//                    }else{//其它一天一次
//
//                        NSDate *recorddate = [user objectForKey:SUPPERERROSHOPPINGEVERYUPCOUNT];
//                        if(![[MyMD5 compareDate:recorddate] isEqualToString:@"今天"] || recorddate==nil )
//                        {
//                            record = NO;
//                            [user setObject:[NSDate date] forKey:SUPPERERROSHOPPINGEVERYUPCOUNT];
//                        }else{
//                            record = YES;
//                        }
//                    }
                    
//                    if(!record && !self.isFight)
//                    {
//                        [self setVitalityPopMindView:Super_zeroShopping];
//
//                    }else{
//                        [self gocontact:sender];
//                    }
                    
                    [self gocontact:sender];
                }else{
                    [self gocontact:sender];
                }
            }
        }
    }
    else{//购买
        [self gocontact:sender];
    }
}

- (void)gocontact:(UIButton*)sender
{
    kSelfWeak;
    [self loginVerifySuccess:^{
    
        kSelfStrong;
        strongSelf.tag=sender.tag;
        
        if(sender.tag==3000)//加入购物车
        {
            if([sender.titleLabel.text isEqualToString:@"加入购物车"])
            {
                [MobClick event:SHOP_ADDGOUWUCHE];
            }
        }else if (sender.tag >=3001)//立即购买");
        {
            [MobClick event:SHOP_GOUMAI];
        }
        
        if(strongSelf.SizeDataArray.count || self.sizeArray.count)
        {
            if([self.stringtype isEqualToString:@"活动商品"])
            {
                if(self.tag == 3001 && !self.isFight && !self.isNOFightgroups)
                {
                    NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                    [mentionview showLable:@"只能从赚钱任务页参与活动哦~" Controller:strongSelf];
                    return;
                    
                }else{
                    [strongSelf colorAndsizeModelview:NO];
                }
            }else{
                if(_isMonday == YES)//疯狂星期一
                {
                    [strongSelf colorAndsizeModelview:NO];
                }else if (![DataManager sharedManager].is_OneYuan)//单独购买
                {
                    [strongSelf colorAndsizeModelview:NO];
                }
                else{
                    if(sender.tag == 3002)//单独购买
                    {
                        _is_oneLuck_share = NO;
                        [strongSelf colorAndsizeModelview:NO];
                    }else{//1元购
                        _is_oneLuck_share = YES;
//                        [strongSelf getShareImage];
                        [strongSelf colorAndsizeModelview:NO];

                    }
                }
            }
            
            CGFloat YY=0;
            
            if(FiveAndFiveInch)
            {
                YY=300;
            }
            else if(FourAndSevenInch)
            {
                YY=300;
            }else if (FourInch)
            {
                YY=180;
            }
            
            else{
                
                YY=110;
            }
            
            [UIView animateWithDuration:0.1 animations:^{
                
                
                strongSelf -> _modelview.frame=CGRectMake(0, YY, kApplicationWidth, kApplicationHeight-YY+20);
                
            } completion:^(BOOL finished) {
                
                
            }];
            
//            [self presentSemiView:_modelview];
            
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"系统繁忙,请稍后再试" Controller:strongSelf];
        }
        
    }];

}
//差掉模态视图
-(void)deletebtn:(UIButton *)sender
{
    [UIView animateWithDuration:0.1 animations:^{
        
        _modelview.frame=CGRectMake(0, kApplicationHeight+100, kApplicationWidth, kApplicationHeight-180);
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark 聊天
-(void)Message:(NSString*)suppid
{
    //    suppid = @"915";
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    suppid = [user objectForKey:PTEID];
    
    // begin 赵官林 2016.5.26
    [self messageWithSuppid:suppid title:nil model:_ShopModel detailType:@"" imageurl:nil];
    
    if([self.stringtype isEqualToString:@"活动商品"])
    {
        [self messageWithSuppid:suppid title:nil model:_ShopModel detailType:@"活动商品" imageurl:nil];
        [Signmanager SignManarer].detailtypestr = @"活动商品";
    }
    // end
}
#pragma mark 下单
- (void)gotoorder:(UIViewController*)controller
{
    [self.navigationController pushViewController:_publicaffirm animated:YES];
}
#pragma mark 拼团下单
-(void)fightpay
{
    [self.fightDataArray removeAllObjects];
    
    _ShopModel.app_shop_group_price = self.app_shop_group_price;
    [self.fightDataArray addObject:_ShopModel];
    
    NSMutableArray *shopArray=[NSMutableArray array];
    NSMutableString *shopCodes=[NSMutableString string];
    
    CGFloat allResavePrice=0,allPrice = 0;
    for(int i=0 ;i<self.fightDataArray.count;i++){
        ShopDetailModel *model=self.fightDataArray[i];
        
        [shopCodes appendFormat:@"%@,",model.shop_code];
        [shopArray addObject:model];
        allPrice += model.shop_se_price.floatValue;

    }
    allResavePrice = allPrice - [Signmanager SignManarer].DPPAYPRICE.floatValue ;
    if(shopArray.count){
        
        OrderTableViewController *view = [[OrderTableViewController alloc]init];
        view.hidesBottomBarWhenPushed=YES;
        view.orderBuyType = OrderType_GroupBuy;
        view.sortArray = shopArray;
        view.allResavePrice=allResavePrice;
        view.isFight = YES;
        view.isTM = YES;
        view.isSpecialOrder = YES;
       
        [self.navigationController pushViewController:view animated:YES];
    }
}

- (void)popback
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 返回界面
-(void)back:(UIButton*)sender
{
    if(self.isFight && [DataManager sharedManager].fightData.count == 1)//是拼团购
    {
        if(self.FightBackBlock)
        {
            self.FightBackBlock();
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
//    //如果不是1元购直接返回上一界面
//    if([DataManager sharedManager].is_OneYuan)
//    {
//        [self.navigationController popViewControllerAnimated:YES];
//    }else{
//        [self setVitalityPopMindView:Detail_comeBack];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark 进入购物车界面
-(void)cartclick:(UIButton*)sender
{
    [MobClick event:SHOP_GOUWUCHE];
    MyLog(@"联系客服");
    kSelfWeak;
    [self loginVerifySuccess:^{
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString* suppid = [user objectForKey:PTEID];
        [weakSelf Message:suppid];
    }];
}
#pragma mark 加喜欢
-(void)likeclick:(UIButton*)sender
{
    [MobClick event:SHOP_XIHUAN];
    kSelfWeak;
    [self loginVerifySuccess:^{
        
        if(weakSelf.likebtn.selected==NO)//加喜欢
        {
            weakSelf.likebtn.userInteractionEnabled = NO;
            [weakSelf likerequestHttp];
        } else {//取消喜欢
            weakSelf.likebtn.userInteractionEnabled = NO;
            [weakSelf dislikerequestHttp];
        }
    }];
}

#pragma mark 加心消失
-(void)disapper:(NSTimer*)timer
{
    [self disapperlike];
}
- (void)disapperlike
{
    //    UIImageView *view=(UIImageView *)[self.view viewWithTag:9998];
    
    [UIView animateWithDuration:0.5 animations:^{
        _likeview.frame=CGRectMake((kApplicationWidth-40)/2, (kApplicationHeight-40)/2, 40, 40);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            [_likeview removeFromSuperview];
            
            
        } completion:^(BOOL finished) {
            
        }];
        self.likebtn.enabled = YES;
        
    }];
    
}

#pragma mark scrollviewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //当视图在滑动时购买按钮不能点
    UIButton *buyBtn = (UIButton*)[self.view viewWithTag:3000];
    buyBtn.userInteractionEnabled = NO;
    
    if (scrollView!=self.searchTableView) {
        
        if(scrollView==self.MyBigtableview)
        {
            //让导航条渐变色
            UIImageView *headview=(UIImageView*)[self.view viewWithTag:3838];
            
            if(scrollView.contentOffset.y > 50 ){
                
                
                [_backbtn setImage:[UIImage imageNamed:@"icon_fanhui_black"] forState:UIControlStateNormal];
                
//                _siimage.image = [UIImage imageNamed:@"lianxikefu-black"];
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                NSArray *likearr = [user objectForKey:@"user_like"];
                BOOL result = [likearr containsObject:_ShopModel.shop_code];
                if(result == NO)
                {
                    _siimage.image=[UIImage imageNamed:@"icon_xihuan"];
                    self.likebtn.selected=NO;
                }else{
                    
                    _siimage.image=[UIImage imageNamed:@"icon_xihuan_sel"];
                    self.likebtn.selected=YES;
                }
                
                _shopimage.image = [UIImage imageNamed:@"icon_gouwuche_black"];
                _screenBtnimg.image = [UIImage imageNamed:@"detial_shaixuan"];
                
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
                _currentStatusBarStyle = UIStatusBarStyleDefault;
                
                headview.image = [UIImage imageNamed:@""];
                headview.backgroundColor = [UIColor whiteColor];
                headview.alpha = scrollView.contentOffset.y/ZOOM(450*3.4);
                _titlelable.alpha = headview.alpha;
            }else{
                
                [_backbtn setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
                
//                _siimage.image = [UIImage imageNamed:@"shop_lxkf-"];
                _shopimage.image = [UIImage imageNamed:@"icon_gouwuche"];
                _screenBtnimg.image = [UIImage imageNamed:@"detial_shaixuan_white"];
                
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                _currentStatusBarStyle = UIStatusBarStyleLightContent;
                headview.backgroundColor = [UIColor clearColor];
                headview.image = [UIImage imageNamed:@"zhezhao"];
                
                [UIView animateWithDuration:1.0 animations:^{
                    
                    headview.alpha = 1;
                    _titlelable.alpha = 0;
                    
                } completion:^(BOOL finished) {
                    
                    
                }];
            }
            
            //sectionview顶置
//            CGFloat sectionHeaderHeight = 64;
            CGFloat sectionHeaderHeight = Height_NavBar;
            if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0) {
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            }
            else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
                scrollView.contentInset = UIEdgeInsetsMake(sectionHeaderHeight, 0, 0, 0);
            }
            
            
        }
        
        
        
#pragma mark scrollview滑动到 3000 _UpBtn显示
        
        //scrollview滑动一半
        CGPoint contentOffsetPoint = self.MyBigtableview.contentOffset;
        if (contentOffsetPoint.y == 3000  || contentOffsetPoint.y > 3000 ) {
            
            [_UpBtn setHidden:NO];
            
        }else{
            
            [_UpBtn setHidden:YES];
            
        }
        
//        CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
        
//        UIView *footview = (UIView *)[self.view viewWithTag:8181];
//        footview.clipsToBounds =YES;
//        footview.userInteractionEnabled=YES;
        
//        //上滑隐藏footview 下滑显示
//        if(translation.y>0)
//        {
//            
//            
//            [UIView animateWithDuration:0.3 animations:^{
//                
//                footview.frame=CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 50);
//                
//                if (_promptview) {
//                    _promptview.frame = CGRectMake(0, kApplicationHeight-50-40+kUnderStatusBarStartY, kApplicationWidth, 40);
//                }
//                
//            } completion:^(BOOL finished) {
//                
//            }];
//            
//        }else if(translation.y<0){
//            
//            [UIView animateWithDuration:0.3 animations:^{
//                
//                footview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, footview.frame.size.height);
//                if (_promptview) {
//                    _promptview.frame = CGRectMake(0, kApplicationHeight+30+kUnderStatusBarStartY, kApplicationWidth, 40);
//                }
//            } completion:^(BOOL finished) {
//                
//                
//            }];
//            
//            
//        }else{
//            
//            footview.hidden=NO;
//            _promptview.hidden = NO;
//            
//        }
        
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //删除加购物车动画
    for (CALayer *calye in _modelview.layer.sublayers) {
        calye.frame = CGRectMake(0, 0, 0, 0);
    }
    
    //    UIImageView *view=(UIImageView *)[self.view viewWithTag:9998];
    if(_likeview)
    {
        [UIView animateWithDuration:1 animations:^{
            _likeview.frame=CGRectMake((kApplicationWidth-40)/2, (kApplicationHeight-40)/2, 40, 40);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 animations:^{
                [_likeview removeFromSuperview];
            }];
        }];
        
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _InvitationCodeView.alpha = 0.3;
        
    } completion:^(BOOL finished) {
        
    }];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if(!decelerate){
        
        //当视图不滑动时购买按钮可点
        UIButton *buyBtn = (UIButton*)[self.view viewWithTag:3000];
        buyBtn.userInteractionEnabled = YES;
        
        //这里写上停止时要执行的代码
        
        if (scrollView!=self.searchTableView) {
            
//            UIView *footview = (UIView *)[self.view viewWithTag:8181];
//            footview.clipsToBounds =YES;
//            footview.userInteractionEnabled=YES;
//            
//            [UIView animateWithDuration:0.3 animations:^{
//                
//                if (_promptview) {
//                    _promptview.frame = CGRectMake(0, kApplicationHeight-50-40+kUnderStatusBarStartY, kApplicationWidth, 40);
//                }
//                
//                footview.frame=CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 50);
//                _InvitationCodeView.alpha = 1;
//            } completion:^(BOOL finished) {
//                
//                
//            }];
            
            CGPoint offset = scrollView.contentOffset;
            
            CGRect bounds = scrollView.bounds;
            
            CGSize size = scrollView.contentSize;
            
            UIEdgeInsets inset = scrollView.contentInset;
            
            CGFloat currentOffset = offset.y + bounds.size.height - inset.bottom;
            
            CGFloat maximumOffset = size.height;
            
            
            CGFloat currentOffsetNew = [[NSString stringWithFormat:@"%.f",currentOffset] floatValue];
            CGFloat maximumOffsetNew = [[NSString stringWithFormat:@"%.f",maximumOffset] floatValue];
            
            CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
            //当currentOffset与maximumOffset的值相等时，说明scrollview已经滑到底部了。也可以根据这两个值的差来让他做点其他的什么事情
            
            if(currentOffsetNew +_tableFootView.frame.size.height >= maximumOffsetNew && translation.y < 0)
            {
                if(self.slectbtn.tag==1000)
                {
                    CGFloat viewHeigh = kIOSVersions >= 11 ? -Height_StatusBar :0;
                    [UIView animateWithDuration:0.5 animations:^{
                        
                        self.MyBigtableview.contentOffset = CGPointMake(0, self.MyBigtableview.contentSize.height-_tableFootView.frame.size.height-Height_NavBar+viewHeigh);
                        
                    } completion:^(BOOL finished) {
                        
                    }];
                }
            }
        }
    }
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //删除加购物车动画
    for (CALayer *calye in _modelview.layer.sublayers) {
        calye.frame = CGRectMake(0, 0, 0, 0);
    }
    
    //当视图不滑动时购买按钮可点
    UIButton *buyBtn = (UIButton*)[self.view viewWithTag:3000];
    buyBtn.userInteractionEnabled = YES;
    
    //滑动停止
    if (scrollView!=self.searchTableView) {
        
//        UIView *footview = (UIView *)[self.view viewWithTag:8181];
//        footview.clipsToBounds =YES;
//        footview.userInteractionEnabled=YES;
//        
//        [UIView animateWithDuration:0.3 animations:^{
//            
//            if (_promptview) {
//                _promptview.frame = CGRectMake(0, kApplicationHeight-50-40+kUnderStatusBarStartY, kApplicationWidth, 40);
//            }
//            
//            footview.frame=CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 50);
//            
//            _InvitationCodeView.alpha = 1;
//        } completion:^(BOOL finished) {
//        
//        }];
        
        if(!_tableFootView)
        {
            
            CGPoint offset = scrollView.contentOffset;
            
            CGRect bounds = scrollView.bounds;
            
            CGSize size = scrollView.contentSize;
            
            UIEdgeInsets inset = scrollView.contentInset;
            
            CGFloat currentOffset = offset.y + bounds.size.height - inset.bottom;
            
            CGFloat maximumOffset = size.height;
            
            CGFloat currentOffsetNew = [[NSString stringWithFormat:@"%.f",currentOffset] floatValue];
            CGFloat maximumOffsetNew = [[NSString stringWithFormat:@"%.f",maximumOffset] floatValue];
            
            //当currentOffset与maximumOffset的值相等时，说明scrollview已经滑到底部了。也可以根据这两个值的差来让他做点其他的什么事情
            
            if(currentOffsetNew > maximumOffsetNew  || currentOffsetNew == maximumOffsetNew)
            {
                //-----我要刷新数据-----"
                
                if(self.slectbtn.tag==1000)
                {
                    [self creatTableFootView];
                    
//                                [self footViewAddChildView];
                    
                    self.MyBigtableview.tableFooterView= _tableFootView;
                    
                    int index = 0;
                    for (NSDictionary *dic in self.shopStoreVC.typeIndexArr) {
                        if ([dic[@"id"] intValue] == self.currPage) {
                            index = [dic[@"index"] intValue];
                            break;
                        }
                    }
                    [self.shopStoreVC.slidePageScrollView scrollToPageIndex:index animated:NO];
                    [self.shopStoreVC.slidePageScrollView.pageTabBar switchToPageIndex:index];
                    
                    [UIView animateWithDuration:0.5 animations:^{
                        
//                        self.MyBigtableview.contentOffset = CGPointMake(0, self.MyBigtableview.tableFooterView.frame.origin.y-kApplicationHeight+kUnderStatusBarStartY+_tableFootView.frame.size.height-40+100);
                        self.MyBigtableview.contentOffset = CGPointMake(0, self.MyBigtableview.contentSize.height-_tableFootView.frame.size.height-60);
                        
                    } completion:^(BOOL finished) {
                        
                    }];
                }
            }
        }
    }
}

#pragma mark  - 滑到最底部
- (void)scrollTableToFoot:(BOOL)animated
{
    NSInteger s = [self.MyBigtableview numberOfSections];  //有多少组
    if (s<1) return;  //无数据时不执行 要不会crash
    NSInteger r = [self.MyBigtableview numberOfRowsInSection:s-1]; //最后一组有多少行
    if (r<1) return;
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];  //取最后一行数据
    [self.MyBigtableview scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated]; //滚动到最后一行
}
- (NSString*)getRewad_type:(NSString*)rewardvalue
{
    NSString *str = @"";
    if([self.rewardType isEqualToString:DAILY_TASK_JIFEN])
    {
        str = [NSString stringWithFormat:@"%.0f积分",[rewardvalue floatValue]];
    }else if ([self.rewardType isEqualToString:DAILY_TASK_XIANJING])
    {
        str = [NSString stringWithFormat:@"%.2f元",[rewardvalue floatValue]];
    }else if ([self.rewardType isEqualToString:DAILY_TASK_YOUHUI])
    {
        str = [NSString stringWithFormat:@"%.0f元优惠劵",[rewardvalue floatValue]];
        
    }
    return str;
}

#pragma mark 判断某个时间是否在7~14点
- (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour
{
    NSDate *date7 = [self getCustomDateWithHour:7];
    NSDate *date14 = [self getCustomDateWithHour:14];
    
    NSDate *currentDate = [NSDate date];
    
    if ([currentDate compare:date7]==NSOrderedDescending && [currentDate compare:date14]==NSOrderedAscending)
    {
        //该时间在 %d:00-%d:00 之间！", fromHour, toHour);
        return YES;
    }
    return NO;
}

/**
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 */
- (NSDate *)getCustomDateWithHour:(NSInteger)hour
{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [resultCalendar dateFromComponents:resultComps];
}

-(void)okbtn
{
    UIView *view =(UIView*)[self.view viewWithTag:8888];
    [view removeFromSuperview];
}

-(void)viewDidLayoutSubviews
{
    if ([self.MyBigtableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.MyBigtableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.MyBigtableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.MyBigtableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
- (void)dealloc
{
    [_noviceTimer_5 invalidate];
    [_dailyTimer_1 invalidate];
    [_dailyTimer_2 invalidate];
    [_liketimer invalidate];
    [_mytimer invalidate];
    [_timerFire invalidate];
    
    _noviceTimer_5 = nil;
    _dailyTimer_1 = nil;
    _dailyTimer_2 = nil;
    _liketimer = nil;
    _mytimer = nil;
    _timerFire = nil;
    
    [_tableFootView removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.shopStoreVC.slidePageScrollView.tyDelegate = nil;
    [self.shopStoreVC willMoveToParentViewController:nil];
    [self.shopStoreVC.view removeFromSuperview];
    [self.shopStoreVC removeFromParentViewController];
    NSLog(@"%@释放了",[self class]);
}

#pragma mark ********************* 懒加载 *********************
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    
    return _dataArr;
}

- (NSMutableArray *)sizeArray
{
    if (_sizeArray == nil) {
        _sizeArray = [[NSMutableArray alloc] init];
    }
    
    return _sizeArray;
}

- (NSMutableArray *)SizeDataArray
{
    if (_SizeDataArray == nil) {
        _SizeDataArray = [[NSMutableArray alloc] init];
    }
    
    return _SizeDataArray;
}

- (NSMutableArray *)colorArray
{
    if (_colorArray == nil) {
        _colorArray = [[NSMutableArray alloc] init];
    }
    
    return _colorArray;
}

- (NSMutableArray *)commentArray
{
    if (_commentArray == nil) {
        _commentArray = [[NSMutableArray alloc] init];
    }
    
    return _commentArray;
}

- (NSMutableArray *)stock_id_nameArray
{
    if (_tagNameArray == nil) {
        _tagNameArray = [[NSMutableArray alloc] init];
    }
    
    return _tagNameArray;
}
- (NSMutableArray *)commentDataArray
{
    if (_commentDataArray == nil) {
        _commentDataArray = [[NSMutableArray alloc] init];
    }
    
    return _commentDataArray;
}
- (NSMutableArray *)stocktypeArray
{
    if (_stocktypeArray == nil) {
        _stocktypeArray = [[NSMutableArray alloc] init];
    }
    
    return _stocktypeArray;
}

- (NSMutableArray *)stock_colorArray
{
    if (_stock_colorArray == nil) {
        _stock_colorArray = [[NSMutableArray alloc] init];
    }
    
    return _stock_colorArray;
}

- (NSMutableArray *)stock_sizeArray
{
    if (_stock_sizeArray == nil) {
        _stock_sizeArray = [[NSMutableArray alloc] init];
    }
    
    return _stock_sizeArray;
}

- (NSMutableArray *)JifenshopArray
{
    if (_JifenshopArray == nil) {
        _JifenshopArray = [[NSMutableArray alloc] init];
    }
    
    return _JifenshopArray;
}
- (NSMutableArray *)DeliverArray
{
    if (_DeliverArray == nil) {
        _DeliverArray = [[NSMutableArray alloc] init];
    }
    
    return _DeliverArray;
}

- (NSMutableArray *)ImageArray
{
    if (_ImageArray == nil) {
        _ImageArray = [[NSMutableArray alloc] init];
    }
    
    return _ImageArray;
}

- (NSMutableArray *)ImageDataArray
{
    if (_ImageDataArray == nil) {
        _ImageDataArray = [[NSMutableArray alloc] init];
    }
    
    return _ImageDataArray;
}

- (NSMutableArray *)ImageHeighArray
{
    if (_ImageHeighArray == nil) {
        _ImageHeighArray = [[NSMutableArray alloc] init];
    }
    
    return _ImageHeighArray;
}

- (NSMutableArray *)BigDataArray
{
    if (_BigDataArray == nil) {
        _BigDataArray = [[NSMutableArray alloc] init];
    }
    
    return _BigDataArray;
}

- (NSMutableArray *)shopAirveIDArr
{
    if (_shopAirveIDArr == nil) {
        _shopAirveIDArr = [[NSMutableArray alloc] init];
    }
    
    return _shopAirveIDArr;
}

- (NSMutableArray *)shopDirvelArr
{
    if (_shopDirvelArr == nil) {
        _shopDirvelArr = [[NSMutableArray alloc] init];
    }
    
    return _shopDirvelArr;
}

- (NSMutableArray *)searchDataArr
{
    if (_searchDataArr == nil) {
        _searchDataArr = [[NSMutableArray alloc] init];
    }
    return _searchDataArr;
}

- (NSMutableArray *)searchCateArr {
    if (_searchCateArr == nil) {
        _searchCateArr = [[NSMutableArray alloc] init];
    }
    return _searchCateArr;
}

- (NSMutableArray *)screenDataArr {
    if (_screenDataArr == nil) {
        _screenDataArr = [[NSMutableArray alloc] init];
    }
    return _screenDataArr;
}

- (NSMutableArray *)screenCateArr {
    if (_screenCateArr == nil) {
        _screenCateArr = [[NSMutableArray alloc] init];
    }
    return _screenCateArr;
}

- (NSMutableArray *)pArray
{
    if(_pArray == nil)
    {
        _pArray = [NSMutableArray array];
    }
    return _pArray;
}

- (NSMutableArray *)fightDataArray
{
    if(_fightDataArray == nil)
    {
        _fightDataArray = [NSMutableArray array];
    }
    return _fightDataArray;
}
- (NSMutableArray *)atrrListArray
{
    if(_atrrListArray == nil)
    {
        _atrrListArray = [NSMutableArray array];
    }
    return _atrrListArray;
}
- (NSMutableArray *)comobDataArray
{
    if(_comobDataArray == nil)
    {
        _comobDataArray = [[NSMutableArray alloc] init];
    }
    
    return _comobDataArray;
}
- (NSMutableArray *)attrDataArray
{
    if(_attrDataArray == nil){
        _attrDataArray = [NSMutableArray array];
    }
    return _attrDataArray;
}
- (NSMutableArray *)selectIDarray
{
    if(_selectIDarray == nil)
    {
        _selectIDarray = [NSMutableArray array];
    }
    return _selectIDarray;
}
@end
