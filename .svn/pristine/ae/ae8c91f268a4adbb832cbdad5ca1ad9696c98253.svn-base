//
//  ShouYeShopStoreViewController.m
//  YunShangShiJi
//
//  Created by hebo on 2019/1/23.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "ShouYeShopStoreViewController.h"
#import "LoginViewController.h"
#import "ShopDetailViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "GlobalTool.h"
#import "ShuXingModel.h"
#import "ShopModel.h"
#import "ShopDetailModel.h"
#import "MyMD5.h"
#import "WaterFLayout.h"
#import <sqlite3.h>
#import "BaseDBManager.h"
#import "NavgationbarView.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "SRRefreshView.h"
#import "ScreenViewController.h"
#import "CycleScrollView.h"
#import "TFLoginView.h"
#import "InvitCodeViewController.h"
//#import "ChatListViewController.h"
#import "H5activityViewController.h"
#import "BrandMakerDetailVC.h"
#import "RedHongBaoHeadView.h"
#pragma mark - 唐飞
/***********************/

#import "TFHomeViewController.h"
#import "TFScreeningBackgroundView.h"
#import "TFSearchViewController.h"
#import "ShopthreeViewController.h"
#import "WaterFlowCell.h"
#import "TFScreenViewController.h"
#import "CustomTitleView.h"
#import "HeadReusableView.h"
#import "ProduceImage.h"
#import "QRCodeGenerator.h"
#import "WaterFallHeader.h"
#import "ScrollView_public.h"
#import "TFPublicClass.h"
/**********************/
#import "AppDelegate.h"
#import "DShareManager.h"
#import "ProduceImage.h"
#import "TFNoviceTaskView.h"
#import "TFDailyTaskView.h"

#import "MySearchDisplayController.h"
#import "TFWithdrawCashViewController.h"
#import "FMDBSearchManager.h"
#import "TFFeedBackViewController.h"
#import "WTFAlertView.h"
#import "RedXuanfuHongBao.h"
#import "TixianRedHongbao.h"
#import "hongBaoModel.h"
@interface ShouYeShopStoreViewController ()<TFScreeningBackgroundDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UIAlertViewDelegate,UIScrollViewDelegate,UITableViewDataSource, UITableViewDelegate, collectionViewCustomDelegate, DShareManagerDelegate>
{
    //商品分类数据源
    NSMutableArray *_shopDirvelArr;
    //商品分类ID
    NSMutableArray *_shopAirveIDArr;
    
    //轮播视图数据源
    NSMutableArray *_topImageArr;
    //热图数据源
    NSMutableArray *_hotImageArr;
    
    //商品分类图片
    NSDictionary *_imageDic;
    //一级目录商品分类数据源
    NSMutableArray *_dirvelImageArr;
    const char *_sql_stmt;
    CGPoint openPointCenter;
    CGPoint closePointCenter;
    NSInteger _versionCount;
    
    //新手任务4
    NSTimer *_noviceTimer_4;
    NSInteger _noviceTimerCount_4;
    
    //新手任务5
    NSInteger _noviceTimerCount_5;
    NSTimer *_noviceTimer_5;
    
    NSInteger _noviceTimerCount_11;
    NSTimer *_noviceTimer_11;
    
    //周末
    NSTimer *_dailyTaskTimer_0;
    NSInteger _dailyTimerCount_0;
    
    //每日任务周1，周2，周3，周4，周5
    NSTimer *_dailyTaskTimer_34567;
    NSInteger _dailyTaskTimerCount_34567;
    
    NSMutableArray *_sequenceArray;
    
    CGFloat _oldPointY;
    
}

@property (nonatomic , retain) CycleScrollView           *mainScorllView;

@property (nonatomic, strong ) ScrollView_public         *myBigScrollView; // Banner轮播视图

@property (nonatomic, strong ) TFScreeningBackgroundView *screeningScrollView; // 筛选视图
@property (nonatomic, strong ) UIView                    *searchRightView;
@property (nonatomic, strong ) UISearchBar               *searchBar;
@property (nonatomic, strong ) MySearchDisplayController *searchDisp;
@property (nonatomic, strong ) UITableView               *searchTableView;
@property (nonatomic, strong ) NSMutableArray            *searchDataArr;

@property (nonatomic, strong ) NSMutableArray            *searchResultDataArr;
@property (nonatomic, strong ) NSMutableArray            *searchHistoryDataArr;
@property (nonatomic, strong ) NSMutableArray            *searchCateArr;
@property (nonatomic, strong ) NSMutableArray            *screenDataArr;
@property (nonatomic, strong ) NSMutableArray            *screenCateArr;
@property (nonatomic, copy   ) NSString                  *searchText;

@property (nonatomic, strong ) UIButton                  *searchBtn;
@property (nonatomic, strong ) UIButton                  *screenBtn;
@property (nonatomic, strong ) UILabel                   *titleLabel;
@property (nonatomic, strong ) UIView                    *whiteView;

@property (nonatomic, assign ) int                       index;
@property (nonatomic, assign ) CGFloat                   headHeight;
@property (nonatomic, assign ) CGFloat                   bigImgHeight;
@property (nonatomic, assign ) CGFloat                   smallImgHeight;
@property (nonatomic, assign ) CGFloat                   titleHeight;
@property (nonatomic, assign ) CGFloat                   lineHeight;

@property (nonatomic, assign ) BOOL                      isOpen;
@property (nonatomic, assign ) BOOL                      httpFailure;
@property (nonatomic, assign ) BOOL                      isScreenAnimationFinished;
@property (nonatomic, assign ) BOOL                      isFirst;
@property (nonatomic, assign ) BOOL                      isFirstComming;

@property (nonatomic, strong ) UIImageView               *navigationView;
@property (nonatomic, strong ) UIScrollView              *hotScrollView;
@property (nonatomic, strong ) UIView                    *leftHandView;

@property (nonatomic, strong ) UIImage                   *shareRandShopImage;
@property (nonatomic, strong ) UIImage                   *shareAppImg;

@property (nonatomic, strong ) TFNoviceTaskView          *noviceTaskView;
@property (nonatomic, strong ) TFDailyTaskView           *dailyTsakView;
@property (nonatomic, assign ) NSInteger                 searchStatus;//搜索框的状态
@property (nonatomic, strong ) RedXuanfuHongBao          *hongbaoview;
@property (nonatomic, strong ) NSTimer *mytimer;
@property (nonatomic, assign) double ElastTime;
@property (nonatomic, strong) TixianRedHongbao * redhongbaoview;
@end

@implementation ShouYeShopStoreViewController

#pragma mark  最新框架 000000000000000000000000000000000000000000000000000000000000000
- (void)dealloc {
    self.slidePageScrollView.tyDataSource = nil;
    self.slidePageScrollView.tyDelegate = nil;
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof CollectionViewController *viewController, NSUInteger idx, BOOL * _Nonnull stop) {
        viewController.customDelegate=nil;
        [viewController willMoveToParentViewController:nil];
        [viewController.view removeFromSuperview];
        [viewController removeFromParentViewController];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.view.backgroundColor = RGBCOLOR_I(240, 240, 240);
    _hostDataArray = [NSMutableArray array];
    _sequenceArray = [NSMutableArray array];
    
    [self dataInit];
    
    [self createUI];
    
    [self RedhongBao];
//    [self xuanfuHongBaoView];
    
    [_slidePageScrollView reloadData];
    
    if (self.isHeadView == YES) {
        
        //        [self httpGetVoucherCards];
    }
    
}

- (void)goToMyShop:(NSTimer *)timer
{
    int week = [timer.userInfo intValue];
    
    NSString *myType;
    NSString *index;
    switch (week) {
        case 2: {
            index = @"4_2";
            myType = DailyTaskMonday;
        }
            break;
        case 3: {
            index = @"5_2";
            myType = DailyTaskTuesday;
        }
            break;
        case 4: {
            index = @"6_2";
            myType = DailyTaskWednesday;
        }
            break;
        case 5: {
            index = @"7_2";
            myType = DailyTaskThursday;
        }
            break;
        case 6:{
            index = @"8_2";
            myType = DailyTaskFriday;
        }
            break;
        default:
            break;
    }
    
    
    _dailyTaskTimerCount_34567--;
    
    // week: %d = %@,_dailyTaskTimerCount_34567 = %d",week, myType,(int)_dailyTaskTimerCount_34567);
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    //获取当前时间
    NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[MyMD5 getCurrTimeString:@"year-month-day"], @"year-month-day", nil];
    
    if (_dailyTaskTimerCount_34567==0) {
        
        [_dailyTaskTimer_34567 invalidate];
        
        self.dailyTsakView = [[TFDailyTaskView alloc] init];
        [self.dailyTsakView returnClick:^(NSInteger type) {
            
            //存本地
            [ud setObject:currDic[@"year-month-day"] forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],myType]];
            
            
            
            if (week!=6) {
                NSMutableArray *viewControllerArr = [NSMutableArray arrayWithArray:Mtarbar.viewControllers];
                UINavigationController *tfnc = (UINavigationController *)[viewControllerArr firstObject];
                
                TFHomeViewController *tfhmVC = (TFHomeViewController *)[tfnc.viewControllers firstObject];
                tfhmVC.type = myType;
                tfhmVC.fromType = DailyTaskGoShop;
                
                [self viewBackToInitState];
                
                Mtarbar.selectedIndex = 0;
            }
            
            
        } withCloseBlock:^(NSInteger type) {
            [ud setObject:currDic[@"year-month-day"] forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],myType]];
        }];
        [self.dailyTsakView showWithType:index];
    }
    
}

- (void)dailyTaskView34567
{
    int week = [[MyMD5 getCurrTimeString:@"week"] intValue];
    
    NSString *type;
    
    switch (week) {
            
        case 2: {
            type = DailyTaskMonday;
        }
            break;
        case 3: {
            type = DailyTaskTuesday;
        }
            break;
        case 4: {
            type = DailyTaskWednesday;
        }
            
            break;
        case 5: {
            type = DailyTaskThursday;
        }
            
            break;
        case 6:{
            type = DailyTaskFriday;
        }
        default:
            break;
    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *hobby = [ud objectForKey:USER_HOBBY];
    
    if (token!=nil && week<=6&&week>=2&&_dailyTaskTimerCount_34567!=0&&hobby.length!=0) {
        NSDictionary *oldDic;
        //        if (week!=6) {
        //周一周二周三周四 条件是下午分享已经完成的情况下
        oldDic = [ud objectForKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskAfternoonShare]];
        //        } else if (week == 6){
        //周五
        
        //        }
        //获取当前时间
        NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[MyMD5 getCurrTimeString:@"year-month-day"], @"year-month-day", nil];
        
        //
        NSString *oldString = [ud objectForKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],type]];
        //        if (week!=6) {
        if (oldDic!=nil&&[oldDic[@"year-month-day"] isEqualToString:currDic[@"year-month-day"]]) { //下午分享成功过
            //今天是否完成这个任务
            if ((oldString == nil)||(oldString!=nil&&![oldString isEqualToString:currDic[@"year-month-day"]])) {
                
                if ([_dailyTaskTimer_34567 isValid]) {
                    [_dailyTaskTimer_34567 invalidate];
                }
                
                //_dailyTaskTimer_34567");
                
                _dailyTaskTimer_34567 = [NSTimer weakTimerWithTimeInterval:MY_SEC target:self selector:@selector(goToMyShop:) userInfo:[NSNumber numberWithInt:week] repeats:YES];
            }
        }
    }
}

- (void)shareRandShopWithPrice:(NSNumber *)shop_price QRLink:(NSString *)qrLink sharePicUrl:(NSString *)picUrl type:(NSString *)myType
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate shardk];
        
        UIImage *QRImage =[[UIImage alloc] init];
        QRImage = [QRCodeGenerator qrImageForString:qrLink imageSize:160];
        
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

- (void)httpGetShareImageWithPrice:(NSNumber *)shop_price QRLink:(NSString *)qrLink sharePicUrl:(NSString *)picUrl type:(NSString *)myType
{
    [MBProgressHUD showMessage:@"启动分享中,请稍后" afterDeleay:0 WithView:self.view];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], picUrl];
    //url = %@", url);
    
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        responseObject = [NSDictionary changeType:responseObject];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (responseObject!=nil) {
            NSData *imgData = UIImagePNGRepresentation(responseObject);
            self.shareRandShopImage = [UIImage imageWithData:imgData];
            
            [self shareRandShopWithPrice:shop_price QRLink:qrLink sharePicUrl:picUrl type:myType];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

- (void)httpGetRandShopWithType:(NSString *)myType
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *realm = [ud objectForKey:USER_REALM];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@shop/shareShop?token=%@&version=%@&realm=%@",[NSObject baseURLStr], token,VERSION, realm];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //分享商品 = %@", responseObject);
        //        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                NSString *QrLink = responseObject[@"QrLink"];
                NSNumber *shop_se_price = responseObject[@"shop"][@"shop_se_price"];
                NSString *four_pic = responseObject[@"shop"][@"four_pic"];
                NSArray *picArr = [four_pic componentsSeparatedByString:@","];
                
                NSString *pic = [picArr lastObject];
                NSString *shop_code = responseObject[@"shop"][@"shop_code"];
                NSString *sup_code  = [shop_code substringWithRange:NSMakeRange(1, 3)];
                NSString *share_pic = [NSString stringWithFormat:@"%@/%@/%@", sup_code, shop_code, pic];
                
                [self httpGetShareImageWithPrice:shop_se_price QRLink:QrLink sharePicUrl:share_pic type:myType];
                
            }else
                [MBProgressHUD showError:responseObject[@"message"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
/*
 - (void)httpGetVoucherCards
 {
 
 NSString *token = [TFPublicClass getTokenFromLocal];
 
 if (token == nil) {
 return;
 }
 
 AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
 NSString *urlStr = [NSString stringWithFormat:@"%@coupon/addVoucher?token=%@&version=%@", [NSObject baseURLStr], token, VERSION];
 NSString *URL = [MyMD5 authkey:urlStr];
 
 [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
 
 MyLog("res: %@", responseObject);
 //        responseObject = [NSDictionary changeType:responseObject];
 if (responseObject!=nil) {
 if ([responseObject[@"status"] intValue] == 1) {
 
 if (responseObject[@"num"]!=nil) {
 int num = [responseObject[@"num"] intValue];
 
 NSInteger isRedCards = 0;
 
 if (num == 0) {
 
 isRedCards = 1;
 
 } else {
 
 isRedCards = 2;
 
 }
 
 [self redCadsDisplay:isRedCards];
 }
 
 
 } else {
 
 }
 
 }
 
 
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 
 }];
 
 }
 
 - (void)redCadsDisplay:(NSInteger)isRedCards
 {
 NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
 NSString *token = [ud objectForKey:USER_TOKEN];
 NSString *oldDate = [ud objectForKey:RedCash];
 NSString *currDate = [NSString stringWithFormat:@"%@%@", USER_ID, [MyMD5 getCurrTimeString:@"year-month-day"]];
 
 //    MyLog(@"token: %@", token);
 //    MyLog(@"oldDate: %@", oldDate);
 //    MyLog(@"currDate: %@", currDate);
 
 if (token == nil) {
 return;
 }
 
 if (oldDate == nil || ![oldDate isEqualToString:currDate]) {
 
 //        [ud setObject:currDate forKey:RedCash];
 
 if (isRedCards == 1) {
 [self popWTFAlertView:@[@"30", @"20", @"20", @"10"]];
 } else if (isRedCards == 2) {
 [self popWTFAlertView:@[@"15", @"10", @"5"]];
 }
 }
 
 }
 */

- (void)dailyTaskView0
{
    
    int week = [[MyMD5 getCurrTimeString:@"week"] intValue];
    
    NSString *type;
    
    switch (week) {
            
        case 7: {
            type = DailyTaskAddNewShop;
        }
            break;
        case 8: {
            type = DailyTaskAddNewShop;
        }
            break;
        default:
            break;
    }
    
    if (week == 7||week == 8) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *token = [ud objectForKey:USER_TOKEN];
        NSString *hobby = [ud objectForKey:USER_HOBBY];
        //hobby : %@",hobby);
        if (token!=nil&&hobby!=nil&&hobby.length!=0&&_dailyTimerCount_0!=0) {
            NSString *oldDic = [ud objectForKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskAddNewShop]];
            
            NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[MyMD5 getCurrTimeString:@"year-month-day"], @"year-month-day", nil];
            
            //%@-%@ %@", currDic,[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskAddNewShop],oldDic);
            
            if (oldDic == nil||![oldDic isEqualToString:currDic[@"year-month-day"]]) { //判断不是同一天
                
                if ([_dailyTaskTimer_0 isValid]) {
                    [_dailyTaskTimer_0 invalidate];
                }
                _dailyTaskTimer_0 = [NSTimer weakTimerWithTimeInterval:MY_SEC target:self selector:@selector(timeGoMyStoreSee) userInfo:nil repeats:YES];
            }
        }
    }
}

- (void)timeGoMyStoreSee
{
    _dailyTimerCount_0--;
    
    //_dailyTimerCount_0 = %d",(int)_dailyTimerCount_0);
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[MyMD5 getCurrTimeString:@"year-month-day"], @"year-month-day", nil];
    
    if (_dailyTimerCount_0 == 0) {
        [_dailyTaskTimer_0 invalidate];
        self.dailyTsakView = [[TFDailyTaskView alloc] init];
        [self.dailyTsakView returnClick:^(NSInteger type) {
            
            [ud setObject:currDic[@"year-month-day"] forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskAddNewShop]];
            
            [self viewBackToInitState];
            
            Mtarbar.selectedIndex = 0;
            
        } withCloseBlock:^(NSInteger type) {
            
            [ud setObject:currDic[@"year-month-day"] forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskAddNewShop]];
            
            
        }];
        [self.dailyTsakView showWithType:@"1"];
    }
    
}

#pragma mark 获取当前版本
- (NSString*)getVersion
{
    NSString *version = [NSString stringWithFormat:@"V%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    //version = %@", version);
    
    return version;
}

- (void)exitApplication {
    
    AppDelegate *app =  (AppDelegate*)[UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
    //exit(0);
    
}



- (void)createUI
{
    // 正文背景
    [self createContentBackgroundView];
    // 正文商品
    [self addSlidePageScrollView];
    // 导航栏
//    [self creatNavigationbar];
    [self creatNavagationView];
    
    // 头部热推系列
    [self addHeaderView];
    // 底部视图
    [self addFooterView];
    // 商品类型导航条
    [self addTabPageMenu];
    
    [self createLeftHandleView];
    
    [self creatDataAnimation:YES];
}

- (void)createContentBackgroundView
{
    CGFloat spaceHeigh = (_isNewProduction || _isShouYeThree)?0:50;
    self.contentBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height)];
    self.contentBackgroundView.backgroundColor = RGBCOLOR_I(240, 240, 240);
    [self.view addSubview:self.contentBackgroundView];
}

- (void)addSearchRightView
{
    
    //    for (UIView *view in self.contentBackgroundView.subviews) {
    //        if (view == self.searchRightView) {
    //            [self.contentBackgroundView bringSubviewToFront:self.searchRightView];
    //            return;
    //        }
    //    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    NSArray *subViewsArr = window.subviews;
    __block BOOL bl = NO;
    [subViewsArr enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        if (view == self.searchRightView) {
            [window bringSubviewToFront:self.searchRightView];
            bl = YES;
            return;
            *stop = YES;
        }
    }];
    
    if (bl == NO) {
        self.searchRightView = [[UIView alloc] initWithFrame:CGRectMake(OPENCENTERX, StatusTableHeight, kScreenWidth-OPENCENTERX, kScreenHeight-StatusTableHeight)];
        self.searchRightView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0];
        [window addSubview:self.searchRightView];
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGRClick:)];
        [self.searchRightView addGestureRecognizer:tapGR];
        
        UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGRClick:)];
        [self.searchRightView addGestureRecognizer:panGR];
        
        UISwipeGestureRecognizer *swipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGRClick:)];
        swipeGR.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.searchRightView addGestureRecognizer:swipeGR];
        
        [window bringSubviewToFront:self.searchRightView];
    }
    
    
}

- (void)createLeftHandleView
{
    self.leftHandView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, handViewWidth, self.contentBackgroundView.frame.size.height)];
    //    self.leftHandView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    openPointCenter = CGPointMake(self.view.center.x+OPENCENTERX,
                                  self.contentBackgroundView.center.y);
    
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGRClick:)];
    [self.leftHandView addGestureRecognizer:panGR];
    [self.contentBackgroundView addSubview:self.leftHandView];
    
}

- (void)createLeftBackgroundView
{
    self.leftBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, StatusTableHeight, OPENCENTERX+2, kScreenHeight-StatusTableHeight)];
    self.leftBackgroundView.backgroundColor = RGBCOLOR_I(22,22,22);
    [self createSearch];
    [self.view addSubview:self.leftBackgroundView];
}

- (void)createSearch
{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(ZOOM(30), 0, self.leftBackgroundView.frame.size.width-ZOOM(30)*2-2, 44)];
    self.searchBar.barTintColor = RGBCOLOR_I(22,22,22);
    //    [self.searchBar becomeFirstResponder];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.delegate = self;
    
    
    self.searchStatus = 0;
    
    //    self.searchBar.returnKeyType = UIReturnKeySearch;
    
    for (UIView *searchBarSubview in [self.searchBar subviews]) {
        if ([searchBarSubview conformsToProtocol:@protocol(UITextInputTraits)]) {
            // Before iOS 7.0
            @try {
                [(UITextField *)searchBarSubview setReturnKeyType:UIReturnKeySearch];
                //[(UITextField *)searchBarSubview setKeyboardAppearance:UIKeyboardAppearanceAlert];
            }
            @catch (NSException * e) {
                // ignore exception
                //exception.name = %@", e.name);
                
            }
        } else {
            // iOS 7.0
            for(UIView *subSubView in [searchBarSubview subviews]) {
                if([subSubView conformsToProtocol:@protocol(UITextInputTraits)]) {
                    @try {
                        [(UITextField *)subSubView setReturnKeyType:UIReturnKeyDone];
                        //[(UITextField *)searchBarSubview setKeyboardAppearance:UIKeyboardAppearanceAlert];
                    }
                    @catch (NSException * e) {
                        // ignore exception
                        //exception.name = %@", e.name);
                        
                    }
                }
            }
        }
    }
    
    [self.leftBackgroundView addSubview:self.searchBar];
    
    self.searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.leftBackgroundView.frame.size.width, self.leftBackgroundView.frame.size.height-(self.searchBar.frame.size.height))];
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    self.searchTableView.scrollsToTop = NO;
    self.searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchTableView.backgroundColor = RGBCOLOR_I(22,22,22);
    [self.leftBackgroundView addSubview:self.searchTableView];
    
    //    //设置成表格
    //    self.searchDisp = [[MySearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    //    //可以监控搜索条文字发生改变
    //    self.searchDisp.delegate = self;
    //    //为自己自动创建的表格的代理
    //    self.searchDisp.searchResultsDataSource =self;
    //    self.searchDisp.searchResultsDelegate = self;
    
    UISwipeGestureRecognizer *swipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGRClick:)];
    swipeGR.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.searchTableView addGestureRecognizer:swipeGR];
    [self createTableData];
}

- (void)createTableData
{
    self.searchCateArr = [NSMutableArray arrayWithArray:[self FindDataForTPYEDB:@"0"]];
    //    //searchCateArr = %@", self.searchDataArr);
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (NSDictionary *tmpDic in self.searchCateArr) {
        if ([tmpDic[@"name"] isEqualToString:@"特卖"] || [tmpDic[@"name"] isEqualToString:@"热卖"] ) {
            [tmpArr addObject:tmpDic];
        }
    }
    [self.searchCateArr removeObjectsInArray:tmpArr];
    
    if (self.searchCateArr.count!=0) {
        NSArray *idArr = [self getArrayFindFromArray:self.searchCateArr withKey:@"id"];
        for (NSString *s in idArr) {
            NSArray *arr = [self FindDataForTPYEDB:s];
            [self.searchDataArr addObject:arr];
        }
    }
    
}

- (void)dataInit
{
    self.isFirst = YES;
    _versionCount = 0;
    
    self.nCurrPage = 1;
    self.bigImgHeight = ZOOM6(300);
    self.smallImgHeight = 0;
    self.titleHeight = kZoom6pt(0);
    self.lineHeight = 0;
    
    _topImageArr = [NSMutableArray array];
    _hotImageArr = [NSMutableArray array];
    _shopAirveIDArr = [NSMutableArray array];
    _shopDirvelArr = [NSMutableArray array];
    _dirvelImageArr = [NSMutableArray array];
    
    _noviceTimerCount_4 = 5;
    _noviceTimerCount_5 = 5;
    _noviceTimerCount_11 = 60;
    
    _dailyTimerCount_0 = 5;
    _dailyTaskTimerCount_34567 = 5;
    
}

- (void)creatDataAnimation:(BOOL)bl
{
//    NSArray *type0 = [self FindDataForTPYEDB:@"0"];
//    if(type0.count)
//    {
//        NSArray *sortArr = [self sortTheTitleFromArray:type0];
//        //        //sortArr = %@", sortArr);
//        int i = 0;
//        for (NSDictionary *dic in sortArr) {
//            if ([dic[@"isShow"] intValue] == 1) {
//                [_shopAirveIDArr addObject:dic[@"id"]];
//                [_shopDirvelArr addObject:dic[@"name"]];
//                [_dirvelImageArr addObject:dic[@"ico"]];
//
//                NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
//                [dicc setValue:dic[@"id"] forKey:@"id"];
//                [dicc setValue:dic[@"name"] forKey:@"name"];
//                [dicc setValue:[NSNumber numberWithInt:i] forKey:@"index"];
//                i++;
//                [self.typeIndexArr addObject:dicc];
//            }
//        }
//    }

    [_shopAirveIDArr addObject:@"6"];
    [_shopDirvelArr addObject:@"新人钜惠"];
    [_dirvelImageArr addObject:@"shop/type/kuzi.png,shop/type/kuzi1.png"];
    
    for (int i = 0; i<_shopAirveIDArr.count; i++) {
        [self addCollectionViewWithPage:i withTypeName:_shopDirvelArr[i] withtTypeID:_shopAirveIDArr[i]];
    }
    [self.nTitleView refreshTitleViewUI:_shopDirvelArr withImgNames:_dirvelImageArr];
    
    RedHongBaoHeadView *hongheadview = [[RedHongBaoHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, CGRectGetHeight(self.nheadView.frame))];
    kWeakSelf(self);
    hongheadview.lingHongBaoBlock = ^(CGFloat coupon) {
        TFWithdrawCashViewController *cash = [[TFWithdrawCashViewController alloc]init];
        cash.isLingHongBao = YES;
        cash.coupon = coupon;
        [weakself.navigationController pushViewController:cash animated:YES];
    };
    [self.nheadView addSubview:hongheadview];
    
    
//    if (bl) {
//
//        [self httpSlideImageRequestWithAnimation:YES];
//
//        [self HostrequestHttp];
//    }
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

- (NSArray *)getArrayFindFromArray:(NSArray *)sourceArr withKey:(NSString *)key
{
    NSMutableArray *muArr = [NSMutableArray array];
    for (NSDictionary *dic in sourceArr) {
        [muArr addObject:dic[key]];
    }
    return muArr;
}

- (void)creatNavagationView
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"新人钜惠";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
//-(void)creatNavigationbar
//{
//    self.navigationController.navigationBar.hidden=YES;
//
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, StatusTableHeight)];
//    view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:view];
//
//    self.navigationView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, NavigationHeight)];
//
//    //    self.navigationView.layer.shadowColor = [[UIColor blackColor] CGColor];
//    //    self.navigationView.layer.shadowOffset = CGSizeMake(0, 0.5);
//    //    self.navigationView.layer.shadowOpacity = 0.3;
//    //    self.navigationView.layer.shadowRadius = 1;
//
//    self.navigationView.backgroundColor=[UIColor whiteColor];
//    [self.contentBackgroundView addSubview:self.navigationView];
//    self.navigationView.userInteractionEnabled=YES;
//
//    //    UIButton *meicou=[UIButton buttonWithType:UIButtonTypeRoundedRect];                           //    meicou.frame=CGRectMake((kApplicationWidth-80)/2, 0, 80, 40);
//    //    [meicou setTitle:@"衣蝠" forState:UIControlStateNormal];
//    //    meicou.tintColor = COLOR_ROSERED;
//    //    meicou.titleLabel.font = [UIFont systemFontOfSize:ZOOM(57)];
//
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((kApplicationWidth-100)*0.5, 0, 100, NavigationHeight)];
//    titleLabel.text = @"购物";
//    titleLabel.font = kNavTitleFontSize;
//    titleLabel.textColor = RGBCOLOR_I(68, 68, 68);
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    [self.navigationView addSubview:_titleLabel = titleLabel];
//
//
//    //    UIImageView *liv = [[UIImageView alloc] initWithFrame:CGRectMake(kApplicationWidth-30, 9, 20, 20)];
//    //    liv.image = [UIImage imageNamed:@"筛选"];
//    //    liv.contentMode=UIViewContentModeScaleAspectFit;
//    //    liv.userInteractionEnabled = YES;
//    //    [self.navigationView addSubview:liv];
//
//    self.searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    self.searchBtn.frame=CGRectMake(5, 0, NavigationHeight*42/38, NavigationHeight);
//    //    self.searchBtn.backgroundColor = [UIColor yellowColor];
//    [self.searchBtn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
//    //    [self.searchBtn setImage:[UIImage imageNamed:@"首页_搜索_选中"] forState:UIControlStateHighlighted];
//    [self.searchBtn addTarget:self action:@selector(TFSearchClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationView addSubview:self.searchBtn];
//
//    self.screenBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    self.screenBtn.backgroundColor = [UIColor whiteColor];
//    self.screenBtn.frame=CGRectMake(kApplicationWidth-NavigationHeight*37/40-5, 0, NavigationHeight*37/40, NavigationHeight);
//    //    self.screenBtn.backgroundColor = [UIColor yellowColor];
//    [self.navigationView addSubview:self.screenBtn];
//    [self.screenBtn setImage:[UIImage imageNamed:@"icon_shaixuan"] forState:UIControlStateNormal];
//    //    [self.screenBtn setImage:[UIImage imageNamed:@"首页_筛选_选中"] forState:UIControlStateHighlighted];
//    [self.screenBtn setImage:[UIImage imageNamed:@"icon_closed"] forState:UIControlStateSelected];
//    [self.screenBtn addTarget:self action:@selector(TFScreenClick:) forControlEvents:UIControlEventTouchUpInside];
//
//    //    UIImageView *riv= [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 23, 23)];
//    //    riv.image = [UIImage imageNamed:@"搜索"];
//    //    riv.contentMode=UIViewContentModeScaleAspectFit;
//    //    riv.userInteractionEnabled = YES;
//    //    [self.navigationView addSubview:riv];
//
//}

- (void)addSlidePageScrollView
{
    CGRect frame = CGRectMake(0, Height_NavBar, CGRectGetWidth(self.contentBackgroundView.frame), CGRectGetHeight(self.contentBackgroundView.frame)-(Height_NavBar));
    TYSlidePageScrollView *slidePageScrollView = [[TYSlidePageScrollView alloc]initWithFrame:frame];
    slidePageScrollView.pageTabBarIsStopOnTop = YES;
    slidePageScrollView.tyDataSource = self;
    slidePageScrollView.tyDelegate = self;
    slidePageScrollView.backgroundColor = RGBCOLOR_I(240, 240, 240);
    [self.contentBackgroundView addSubview:slidePageScrollView];
    _slidePageScrollView = slidePageScrollView;
}

- (void)addHeaderView
{
    self.nheadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), self.bigImgHeight+self.smallImgHeight+self.lineHeight)];
    
    self.hotScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.bigImgHeight, CGRectGetWidth(_slidePageScrollView.frame), self.smallImgHeight)];
    self.hotScrollView.backgroundColor = [UIColor whiteColor];
    self.hotScrollView.scrollsToTop = NO;
    self.hotScrollView.showsHorizontalScrollIndicator = NO;
    
    [self.nheadView addSubview:self.hotScrollView];
    
    _slidePageScrollView.headerView = _isHeadView?self.nheadView:nil;
    
}

- (void)addTabPageMenu
{
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), self.titleHeight);
    
    self.nTitleView = [CustomTitleView scrollWithFrame:frame withTag:0 withIndex:0 withButtonNames:_shopDirvelArr withImage:_dirvelImageArr];
    self.nTitleView.backColor = [UIColor whiteColor];
    
    int page = (int)[_slidePageScrollView curPageIndex];
    self.nTitleView.index = page;
    
    _slidePageScrollView.pageTabBar = self.nTitleView;
}

- (void)addFooterView
{
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(_slidePageScrollView.frame), 0);
    
    UIView *footerView = [[UIView alloc]initWithFrame:frame];
    footerView.backgroundColor = [UIColor yellowColor];
    _slidePageScrollView.footerView = _isFootView?footerView:nil;;
}

- (void)addCollectionViewWithPage:(NSInteger)page withTypeName:(NSString *)typeName withtTypeID:(NSNumber *)typeID
{
    
    CollectionViewController *collectionVC = [[CollectionViewController alloc] init];
    collectionVC.page = page;
    collectionVC.typeName = typeName;
    collectionVC.typeID = typeID;
    collectionVC.fromType = @"新人钜惠";
    collectionVC.headHeight = self.bigImgHeight+self.smallImgHeight+self.lineHeight+self.titleHeight;
    
    [self addChildViewController:collectionVC];
}


- (NSInteger)numberOfPageViewOnSlidePageScrollView
{
    return self.childViewControllers.count;
}

- (UIScrollView *)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageVerticalScrollViewForIndex:(NSInteger)index
{
    CollectionViewController *collectionVC = self.childViewControllers[index];
    collectionVC.isHeadView = self.isHeadView;
    if (self.isHeadView) {
        collectionVC.customDelegate = self;
    }
    return collectionVC.collectionView;
}

- (void)collectionViewPullDownRefreshWithIndex:(int)index
{
    [self httpSlideImageRequestWithAnimation:NO];
}

-(void)httpSlideImageRequestWithAnimation:(BOOL)bl
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token= [userdefaul objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@shop/queryOption?version=%@",[NSObject baseURLStr],VERSION];
    
    NSString *URL=[MyMD5 authkey:urlStr];
    
    
    if (bl) {
        //        [[Animation shareAnimation] createAnimationAt:self.view];
    }
    
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        responseObject = [NSDictionary changeType:responseObject];
        self.isFirst = NO;
        NSString *statu=responseObject[@"status"];
        
        //        //轮播和热图res = %@",responseObject);
        
        if(statu.intValue==1)
        {
            [_topImageArr removeAllObjects];
            [_hotImageArr removeAllObjects];
            
            NSArray *arr=responseObject[@"centShops"];
            
            for(NSDictionary *dic in arr)
            {
                ShopDetailModel *model=[[ShopDetailModel alloc]init];
                
                model.ID=dic[@"id"];
                model.remark=dic[@"remark"];
                model.shop_code=dic[@"shop_code"];
                model.shop_name=dic[@"shop_name"];
                model.type=dic[@"type"];
                model.def_pic=dic[@"url"];
                
                [_hotImageArr addObject:model];
            }
            
            //轮播图
            NSArray *brr=responseObject[@"topShops"];
            
            for(NSDictionary *dic in brr)
            {
                ShopDetailModel *model=[[ShopDetailModel alloc]init];
                
                model.ID=dic[@"id"];
                model.remark=dic[@"remark"];
                model.shop_code=dic[@"shop_code"];
                model.shop_name=dic[@"shop_name"];
                model.type=dic[@"type"];
                model.def_pic=dic[@"url"];
                model.option_type=dic[@"option_type"];
                
                [_topImageArr addObject:model];
                
            }
            
//            if(_topImageArr.count)
//            {
//
//                [self refreshTopShops];
//            }
//            if(_hotImageArr.count)
//            {
//
//                [self refreshCentShops];
//
//            }
            
            [[Animation shareAnimation] stopAnimationAt:self.view];
            
            if (self.isVseron == NO && _versionCount == 0) {
                
                _versionCount ++ ;
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
        
        self.isFirst = NO;
    }];
}

- (void)httpScreeningRequest:(NSArray *)arr
{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *version = VERSION;
    
    
    NSMutableString *muStr = [NSMutableString string];
    for (NSDictionary *dic in arr) {
        [muStr appendString:@"&"];
        [muStr appendString:dic[@"cate"]];
        [muStr appendString:@"="];
        [muStr appendString:dic[@"chac"]];
    }
    
    NSString *type1=[_typeIndexArr[_slidePageScrollView.pageTabBar.index]objectForKey:@"id"];
    NSString *type_name=[_typeIndexArr[_slidePageScrollView.pageTabBar.index]objectForKey:@"name"];
    // %@ %@ %@",_typeIndexArr,type1, type_name);
    
    if (type1 == nil) {
        type1 = @"6";
        type_name = @"热卖";
    }
    
    
    NSString *urlStr;
    if(token != nil){
        urlStr = [NSString stringWithFormat:@"%@shop/queryCondition?&pager.curPage=1&pager.pageSize=10&token=%@&version=%@%@&type1=%@&type_name=%@",[NSObject baseURLStr],token,VERSION,muStr,type1,type_name];
    }else
        urlStr = [NSString stringWithFormat:@"%@shop/queryConUnLogin?&pager.curPage=1&pager.pageSize=10&version=%@%@&type1=%@&type_name=%@",[NSObject baseURLStr],VERSION,muStr,type1,type_name];
    
    NSString *URL = [MyMD5 authkey:urlStr];
    //URL = %@", URL);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        responseObject = [NSDictionary changeType:responseObject];
        [MBProgressHUD hideHUDForView:self.screeningScrollView];
        //res = %@",responseObject);
        if ([responseObject[@"status"] intValue] == 1) {
            [MBProgressHUD showSuccess:@"筛选成功"];
            NSArray *dataArr = responseObject[@"listShop"];
            NSMutableArray *muArr = [NSMutableArray array];
            for (NSDictionary *dic in dataArr) {
                ShopDetailModel *sModel = [[ShopDetailModel alloc] init];
                [sModel setValuesForKeysWithDictionary:dic];
                [muArr addObject:sModel];
            }
            
            
            
            TFScreenViewController *svc = [[TFScreenViewController alloc] init];
            svc.receiveArray = muArr;
            svc.muStr = muStr;
            svc.index = 2;
            svc.type1=type1;
            svc.type_name=type_name;
            svc.titleText = @"筛选结果";
            //            svc.view.backgroundColor = [UIColor whiteColor];
            svc.hidesBottomBarWhenPushed=YES;
            
            self.titleLabel.text = @"购物";
            [self.navigationController pushViewController:svc animated:YES];
            
        } else {
            [MBProgressHUD showError:responseObject[@"message"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.screeningScrollView];
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
}


#pragma mark - +++++++++++++数据库DB++++++++++

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
    
    
    return YES;
}


// 查询三级分类
-(NSString*)FindDataForTypeDB:(NSString *)findStr
{
    NSString *typestring=findStr;
    
    if([self OpenDb])
    {
        const char *dbpath = [_databasePath UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT id,name,phone,groupflag from TYPDB where name=\"%@\"",findStr];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
                    
                    NSString *ID= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    NSString *name = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    
                    MyLog(@"id=%@ name=%@",ID,name);
                    
                    [dic setObject:ID forKey:name];
                    
                    typestring = ID;
                    
                }
                
                sqlite3_finalize(statement);
            }
            sqlite3_close(AttrcontactDB);
        }
    }
    return typestring;
}


-(NSArray *)FindDataForTPYEDB:(NSString *)findStr
{
    [_sequenceArray removeAllObjects];
    
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    if([self OpenDb])
    {
        const char *dbpath = [_databasePath UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT id,name,address,phone,ico,sequence,isshow,groupflag from TYPDB where address=\"%@\"",findStr];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
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
                    
                    if(sequence)
                    {
                        [_sequenceArray addObject:sequence];
                    }
                    
                    
                    [muArr addObject:mudic];
                    
                }
                
                
                
                sqlite3_finalize(statement);
            }
            sqlite3_close(AttrcontactDB);
        }
        [self closeDB];
    }
    
    //按sequence从小到大排序
    NSComparator cmptr = ^(id obj1, id obj2){
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
    //排序后数组
    NSArray *afterarray = [_sequenceArray sortedArrayUsingComparator:cmptr];
    
    MyLog(@"afterarray = %@",afterarray);
    
    NSMutableArray *newmuarry = [NSMutableArray array];
    
    for(int k = 0;k<afterarray.count;k++)
    {
        for(NSDictionary *dic in muArr)
        {
            if([dic[@"sequence"] isEqualToString:afterarray[k]])
            {
                [newmuarry addObject:dic];
                break;
            }
        }
    }
    
    return newmuarry;
}

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
                    //                    [muArr addObject:mudic];
                    
                    break;
                    
                }
                
                sqlite3_finalize(statement);
            }
            sqlite3_close(AttrcontactDB);
        }
        
    }
    
    //muDic = %@", mudic);
    
    return mudic;
}


-(NSArray *)FindDataForTAGDB:(NSString *)findStr
{
    
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    if([self OpenDb])
    {
        const char *dbpath = [_databasePath UTF8String];
        sqlite3_stmt *statement;
        
        if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT id,name,phone,ico,sequence,ename from TAGDB where address=\"%@\"",findStr];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
                    NSString *ID = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    NSString *name = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    NSString *isShow = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                    NSString *icon = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                    NSString *sequence = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                    NSString *ename = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                    //                    //sequence = %@", sequence);
                    [mudic setValue:ID forKey:@"id"];
                    [mudic setValue:name forKey:@"name"];
                    [mudic setValue:isShow forKey:@"isShow"];
                    [mudic setValue:icon forKey:@"icon"];
                    [mudic setValue:sequence forKey:@"sequence"];
                    [mudic setValue:ename forKey:@"ename"];
                    
                    [muArr addObject:mudic];
                }
                
                sqlite3_finalize(statement);
            }
            sqlite3_close(AttrcontactDB);
        }
        
        
        
    }
    return muArr;
}

-(void)refreshTopShops
{
    NSMutableArray *viewsArray = [NSMutableArray array];
    if(_topImageArr.count)
    {
        for (UIView *view in self.myBigScrollView.subviews) {
            [view removeFromSuperview];
        }
        
        
        for (int i = 0; i < _topImageArr.count; i++) {
            ShopDetailModel *model=_topImageArr[i];
            
            NSString *imgUrlStr = [NSString stringWithFormat:@"%@%@!560",[NSObject baseURLStr_Upy],model.def_pic];
            //            MyLog(@"imgUrlStr = %@", imgUrlStr);
            
            [viewsArray addObject:imgUrlStr];
        }
        
        //添加轮播图
        self.myBigScrollView = [[ScrollView_public alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, self.bigImgHeight) pictures:viewsArray animationDuration:5 contentMode_style:Fill_contentModestyle Haveshiping:NO];
        
        self.myBigScrollView.pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"Carousel_Selected"];
        self.myBigScrollView.pageControl.pageIndicatorImage = [UIImage imageNamed:@"Carousel_normal"];
        
        [self.nheadView addSubview:self.myBigScrollView];
        
        self.myBigScrollView.scrollview.scrollsToTop = NO;
        NSArray *tmpArr = _topImageArr;
        //        __weak ShopStoreViewController *shopStore = self;
        kSelfWeak;
        self.myBigScrollView.getTapClickPage = ^(NSInteger page){
            kSelfStrong;
            ShopDetailModel *model = strongSelf->_topImageArr[page];
            if(model.option_type.intValue == 1)//商品详情
            {
                ShopDetailModel *model=tmpArr[page];
                ShopDetailViewController *detail=[[ShopDetailViewController alloc]initWithNibName:@"ShopDetailViewController" bundle:nil];
                detail.shop_code=model.shop_code;
                detail.hidesBottomBarWhenPushed=YES;
                [weakSelf.navigationController pushViewController:detail animated:YES];
            }else if (model.option_type.intValue == 2)//邀请码
            {
                NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
                NSString *token = [userdefaul objectForKey:USER_TOKEN];
                
                if(token == nil) {
                    [weakSelf ToLoginView];
                } else{
                    
                    InvitCodeViewController *invit =[[InvitCodeViewController alloc]init];
                    invit.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:invit animated:YES];
                }
                
            }else if (model.option_type.intValue == 3)//消息盒子
            {
                
                NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
                NSString *token = [userdefaul objectForKey:USER_TOKEN];
                
                if(token == nil) {
                    [weakSelf ToLoginView];
                } else{
                    // begin 赵官林 2016.5.26 跳转到消息列表
                    [weakSelf presentChatList];
                    // end
                }
            }else if (model.option_type.intValue == 4)//签到页
            {
                Mtarbar.selectedIndex = 2;
            }else if (model.option_type.intValue == 5)//H5活动页
            {
                ShopDetailModel *model=tmpArr[page];
                
                if(model.shop_code !=nil || ![model.shop_code isEqual:[NSNull null]]){
                    
                    H5activityViewController *h5vc = [[H5activityViewController alloc]init];
                    h5vc.H5url = model.shop_code;
                    h5vc.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:h5vc animated:YES];
                }
                
            }
            
        };
        
        
    } else {
//        [self httpSlideImageRequestWithAnimation:YES];
    }
}

- (void)ToLogin :(NSInteger)tag
{
    LoginViewController *login=[[LoginViewController alloc]init];
    login.tag = tag;
    login.loginStatue=@"toBack";
    login.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:login animated:YES];
}

- (void)ToLoginView
{
    TFLoginView *tf = [[TFLoginView alloc] initWithHeadImage:nil contentText:nil upButtonTitle:nil downButtonTitle:nil];
    [tf show];
    
    tf.upBlock = ^() { //注册
        //上键");
        
        [self ToLogin:2000];
    };
    
    tf.downBlock = ^() {// 登录
        //下键");
        
        [self ToLogin:1000];
    };
}


-(void)refreshCentShops
{
    
    CGFloat Magin = 10;
    CGFloat W = self.smallImgHeight-Magin*2;
    if(_hotImageArr.count)
    {
        for (UIView *view in self.hotScrollView.subviews) {
            [view removeFromSuperview];
        }
        
        self.hotScrollView.contentSize = CGSizeMake(_hotImageArr.count*(Magin+W)+Magin, self.smallImgHeight);
        
        for(int i = 0; i<_hotImageArr.count; i++)
        {
            CGFloat x = Magin+W*i+i*Magin;
            
            ShopDetailModel *model=_hotImageArr[i];
            
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(x, Magin, W, W)];
            iv.userInteractionEnabled = YES;
            NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],model.def_pic]];
            //            //广告图 = %@%@!280", [NSObject baseURLStr_Upy],model.def_pic);
            
            __block float d = 0;
            __block BOOL isDownlaod = NO;
            kWeakSelf(iv);
            [iv sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                d = (float)receivedSize/expectedSize;
                isDownlaod = YES;
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image != nil && isDownlaod == YES) {
                    weakiv.alpha = 0;
                    [UIView animateWithDuration:0.5 animations:^{
                        weakiv.alpha = 1;
                    } completion:^(BOOL finished) {
                        
                    }];
                } else if (image != nil && isDownlaod == NO) {
                    weakiv.image = image;
                }
            }];
            
            
            
            [self.hotScrollView addSubview:iv];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame  = iv.frame;
            btn.tag = 100+i;
            btn.backgroundColor=[UIColor clearColor];
            [btn addTarget:self action:@selector(hotBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.hotScrollView addSubview:btn];
        }
    } else {
//        [self httpSlideImageRequestWithAnimation:YES];
    }
}

- (void)panGRClick:(UIPanGestureRecognizer *)sender {
    
    CGPoint translation = [sender translationInView:self.contentBackgroundView];
    
    if (translation.x>=0) {
        self.isOpen = YES;
    } else {
        self.isOpen = NO;
    }
    
    CGFloat x = translation.x+self.contentBackgroundView.center.x;
    CGFloat y = self.contentBackgroundView.center.y;
    
    if (x<self.view.center.x) {
        x = self.view.center.x;
    }
    
    if (x>openPointCenter.x) {
        
        [self mainViewStatusToRight];
        
    } else {
        
        self.contentBackgroundView.center = CGPointMake(x, y);
        Mtarbar.tabBar.center=CGPointMake(x, Mtarbar.tabBar.center.y);
        
    }
    if(sender.state == UIGestureRecognizerStateEnded)
    {
        if ((x > openPointCenter.x-DIVIDWIDTH)&&self.isOpen) {
            [UIView animateKeyframesWithDuration:0.3 delay:0.1 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
                self.searchBtn.selected = YES;
                
                [self mainViewStatusToRight];
                
                [self addSearchRightView];
                
                
            } completion:nil];
        } else if ((x <= openPointCenter.x-DIVIDWIDTH)&&self.isOpen){
            
            [UIView animateKeyframesWithDuration:0.3 delay:0.1 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
                self.searchBtn.selected = NO;
                [self.searchRightView removeFromSuperview];
                [self.searchBar resignFirstResponder];
                
                [self mainViewStatusNormal];
                
                [self.searchRightView removeFromSuperview];
                
            } completion:nil];
        }
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        CGFloat xx = 0.0618*OPENCENTERX;
        if (translation.x<-xx) {
            self.searchBtn.selected = NO;
            [self.searchRightView removeFromSuperview];
            [self.searchBar resignFirstResponder];
            [self.searchRightView removeFromSuperview];
            [UIView animateWithDuration:0.2 animations:^{
                
                [self mainViewStatusNormal];
                
            }];
            
        }
    } else if (sender.state == UIGestureRecognizerStateBegan) {
        
    }
    
    [sender setTranslation:CGPointZero inView:self.contentBackgroundView];
}



- (void)TapGRClick:(UITapGestureRecognizer *)sender
{
    
    self.searchBtn.selected = NO;
    [self.searchRightView removeFromSuperview];
    [self.searchBar resignFirstResponder];
    [UIView animateKeyframesWithDuration:0.2 delay:0.1 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
        
        [self mainViewStatusNormal];
        
    } completion:nil];
    
}

- (void)swipeGRClick:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        self.searchBtn.selected = NO;
        [self.searchRightView removeFromSuperview];
        [self.searchBar resignFirstResponder];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            [self mainViewStatusNormal];
        }];
    }
}

- (void)hotBtnClick:(UIButton *)sender
{
    //    ShopDetailModel *model=_hotImageArr[sender.tag-100];
    //    ShopDetailViewController *detail=[[ShopDetailViewController alloc]initWithNibName:@"ShopDetailViewController" bundle:nil];
    //    detail.shop_code=model.shop_code;
    //    detail.hidesBottomBarWhenPushed=YES;
    //    [self.navigationController pushViewController:detail animated:YES];
    
    
    ShopDetailModel *model = _hostDataArray[sender.tag-100];
    NSString *shopcode = model.shop_code;
    
    //shop_code: %@", shopcode);
    
    if ([shopcode hasPrefix:@"type2"]) {
        NSArray *typeArr = [shopcode componentsSeparatedByString:@"="];
        NSString *idStr = [typeArr lastObject];
        //        //id = %@", idStr);
        NSDictionary *type2Dic = [self FindNameForTPYEDB:idStr];
        //        //type2Dic = %@", type2Dic);
        
        NSString *ID = type2Dic[@"id"];
        NSString *title = type2Dic[@"name"];
        
        
        //ID = %@, title = %@", ID, title);
        
        if (ID != nil) {
            NSNumber *type1=[_typeIndexArr[_slidePageScrollView.pageTabBar.index]objectForKey:@"id"];
            NSString *type_name=[_typeIndexArr[_slidePageScrollView.pageTabBar.index]objectForKey:@"name"];
            
            TFSearchViewController *svc = [[TFSearchViewController alloc] init];
            svc.parentID = ID;
            svc.shopTitle = title;
            
            svc.typeID = type1;
            svc.typeName = type_name;
            
            svc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:svc animated:YES];
        }
    }
    else {
        TFScreenViewController *screen = [[TFScreenViewController alloc]init];
        screen.muStr = shopcode;
        //        screen.titleText = model.shop_name;
        screen.index = 1;
        screen.titleText = @"筛选结果";
        screen.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:screen animated:YES];
    }
    
}


-(void)TFSearchClick:(UIButton*)sender
{
    
    [MobClick event:SHOP_SOUSUO];
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        
        [UIView animateWithDuration:0.5 animations:^{
            [self mainViewStatusToRight];
        } completion:^(BOOL finished) {
            [self addSearchRightView];
        }];
        
        if (self.searchDataArr.count == 0) {
            [self createTableData];
        }
        
        [self.searchTableView reloadData];
        
    } else {
        
        [self.searchRightView removeFromSuperview];
        [self.searchBar resignFirstResponder];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [self mainViewStatusNormal];
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)TFScreenClick:(UIButton*)sender
{
    [MobClick event:SHOP_SAIXUAN];
    if (self.isScreenAnimationFinished == YES) {
        return;
    }
    
    [self contentBackgroundViewStatusWithNormal];
    
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        self.isScreenAnimationFinished = NO;
        if (self.screenCateArr.count == 0) {
            NSArray *categoryFindArr = [self FindDataForTAGDB:@"0"];
            
            NSArray *sortArr = [self sortTheTitleFromArray:categoryFindArr];
            
            NSMutableArray *categoryArr = [NSMutableArray array];
            for (NSDictionary *dic in sortArr) {
                if ([dic[@"isShow"] intValue] == 1) {
                    [categoryArr addObject:dic];
                }
            }
            
            [self.screenCateArr addObjectsFromArray:categoryArr];
        }
        
        MyLog(@"+++screenCateArr: %@", self.screenCateArr);
        
        if (self.screenDataArr.count == 0) {
            NSMutableArray *muCharArr = [[NSMutableArray alloc] init];
            if (self.screenCateArr.count!=0) {
                NSArray *idArr = [self getArrayFindFromArray:self.screenCateArr withKey:@"id"];
                for (NSString *s in idArr) {
                    NSArray *arr = [self FindDataForTAGDB:s];
                    NSMutableArray *charMuArr = [NSMutableArray array];
                    for (NSDictionary *dic in arr) {
                        if ([dic[@"isShow"] intValue] == 1) {
                            [charMuArr addObject:dic];
                        }
                    }
                    [muCharArr addObject:charMuArr];
                }
            }
            
            [self.screenDataArr addObjectsFromArray:muCharArr];
        }
        
        
        if (self.screenCateArr.count!=0 && self.screenCateArr.count!=0) {
            self.screeningScrollView = [[TFScreeningBackgroundView alloc] initWithFrame:CGRectMake(0, NavigationHeight-(self.contentBackgroundView.frame.size.height-NavigationHeight), kScreenWidth, self.contentBackgroundView.frame.size.height-NavigationHeight)];
            self.screeningScrollView.backgroundColor = [UIColor whiteColor];
            
            //            //screenCateArr = %@", self.screenCateArr);
            //            //screenDataArr = %@", self.screenDataArr);
            
            self.screeningScrollView.categoryArr = self.screenCateArr;
            self.screeningScrollView.charArr = self.screenDataArr;
            
            self.screeningScrollView.titleFontSize = ZOOM(48);
            self.screeningScrollView.btnH = ZOOM(100);
            self.screeningScrollView.btnFontSize  = ZOOM(44);
            self.screeningScrollView.v_Margin = ZOOM(41);
            self.screeningScrollView.headH = ZOOM(80);
            self.screeningScrollView.lrMargin = ZOOM(50);
            self.screeningScrollView.h_Margin = ZOOM(32);
            self.screeningScrollView.cate_v_Margin = ZOOM(50);
            self.screeningScrollView.delegate = self;
            [self.contentBackgroundView addSubview:self.screeningScrollView];
            [self.contentBackgroundView bringSubviewToFront:self.navigationView];
            
            self.isScreenAnimationFinished = YES;
            self.titleLabel.text = @"筛选";
            [UIView animateWithDuration:0.35 animations:^{
                self.screeningScrollView.frame = CGRectMake(0, NavigationHeight, kScreenWidth, self.contentBackgroundView.frame.size.height-NavigationHeight);
            } completion:^(BOOL finished) {
                Mtarbar.tabBar.hidden=YES;
                self.isScreenAnimationFinished = NO;
                
            }];
        }
    } else {
        
        self.isScreenAnimationFinished = NO;
        Mtarbar.tabBar.hidden=NO;
        
        self.isScreenAnimationFinished = YES;
        self.titleLabel.text = @"购物";
        [UIView animateWithDuration:0.35 animations:^{
            self.screeningScrollView.frame = CGRectMake(0, NavigationHeight-(self.contentBackgroundView.frame.size.height-NavigationHeight), kScreenWidth, self.contentBackgroundView.frame.size.height-NavigationHeight);
        } completion:^(BOOL finished) {
            [self.screeningScrollView removeFromSuperview];
            self.isScreenAnimationFinished = NO;
            
        }];
    }
}
- (void)selectBtnEnd:(TFScreeningBackgroundView *)screeningBackgroundView withChooseArray:(NSArray *)chooseArray
{
    [MobClick event:SHOP_TIJIAO];
    
    //chooseArray = %@",chooseArray);
    if (chooseArray.count!=0) {
        [self httpScreeningRequest:chooseArray];
        [MBProgressHUD showMessage:@"正在筛选" toView:self.screeningScrollView];
    } else {
        [MBProgressHUD showError:@"亲,请至少选择一项吧"];
    }
    
}

#pragma mark - 搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    //添加搜索的文本到历史
    SearchItem *item = [[SearchItem alloc] init];
    item.searchText = searchBar.text;
    BOOL bl = NO;
    FMDBSearchManager *manager = [FMDBSearchManager sharedManager];
    NSArray *itemArray = [manager getAllSearchItem];
    for (SearchItem *itemTemp in itemArray) {
        if ([itemTemp.searchText isEqualToString:searchBar.text]) {
            bl = YES;
        }
    } if (bl == NO) {
        [manager addSearchItem:item];
    }
    
    //开始搜索 = %@",searchBar.text);
    
    
    NSString *typeID = [self FindDataForTypeDB:searchBar.text];
    
    self.searchBtn.selected = YES;
    //    self.screenBtn.selected = NO;
    [self.searchBar resignFirstResponder];
    
    
    TFScreenViewController *svc = [[TFScreenViewController alloc] init];
    svc.index = 0;
    if ([typeID isEqualToString:searchBar.text]) {
        svc.muStr = searchBar.text;
    } else { //类型
        //        svc.type2 = typeID;
        svc.muStr = searchBar.text;
        
    }
    svc.titleText = self.searchBar.text;
    svc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:svc animated:YES];
    
}


- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //self.searchText = %@", self.searchText);
    //搜索当前输入文字: %@", text);
    
    return YES;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    //self.searchText = %@", self.searchText);
    //开始搜索");
    
    if (self.searchText.length == 0) {
#pragma mark - 是否保留搜索纪录
        //        self.searchStatus = 1;
        //        [self.searchTableView reloadData];
    }
    
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    //self.searchText = %@", self.searchText);
    //结束搜索");
    
    self.searchStatus = 0; //默认状态
    [self.searchTableView reloadData];
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //self.searchText = %@", self.searchText);
    //搜索框文字: %@", searchText);
    self.searchText = searchText;
    if (self.searchText.length == 0) {
#pragma mark - 是否保留搜索纪录
        //        self.searchStatus = 1;
        //        [self.searchTableView reloadData];
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.searchStatus == 0) {
        return self.searchDataArr.count;
    } else if (self.searchStatus == 1) {
        return 1;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.searchStatus == 0) {
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
    } else if (self.searchStatus == 1) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 25)];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = RGBCOLOR_I(167,167,167);
        label.backgroundColor = RGBCOLOR_I(22,22,22);
        label.font = kFont6px(32);
        label.text = [NSString stringWithFormat:@"    %@",@"历史搜索"];
        //        if (self.searchCateArr.count>section) {
        //            NSDictionary *tmpdic = self.searchCateArr[section];
        //            label.text = [NSString stringWithFormat:@"    %@",tmpdic[@"name"]];
        //        }
        return label;
        
    }
    
    return 0;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchStatus == 0) {
        return [self.searchDataArr[section] count];
    } else if (self.searchStatus == 1) {
        return self.searchHistoryDataArr.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return ZOOM(80);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchStatus == 0) {
        return ZOOM(150);
    } else if (self.searchStatus == 1) {
        return ZOOM(100);
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchStatus == 0) {
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
        
        MyLog(@"self.searchDataArr = %@",self.searchDataArr);
        
        NSDictionary *dic = [self.searchDataArr[indexPath.section] objectAtIndex:indexPath.row];
        //    iv.image = [UIImage imageNamed:dic[@"name"]];
        
        [iv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy], dic[@"ico"]]]];
        
        titleLabel.text = dic[@"name"];
        return cell;
    } else if (self.searchStatus == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLHISID"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLHISID"];
            cell.backgroundColor = RGBCOLOR_I(22,22,22);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.searchTableView.frame), CGRectGetHeight(cell.frame))];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:ZOOM(50)];
            label.textColor = [UIColor whiteColor];
            label.tag = 200;
            [cell.contentView addSubview:label];
        }
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:200];
        SearchItem *item = self.searchHistoryDataArr[indexPath.row];
        label.text = item.searchText;
        
        if (indexPath.row == self.searchHistoryDataArr.count-1) {
            label.textColor = COLOR_ROSERED;
        } else {
            label.textColor = [UIColor whiteColor];
        }
        
        return cell;
    }
    return 0;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.searchBar resignFirstResponder];
    
    if (self.searchStatus == 0) {
        NSDictionary *dic = [self.searchDataArr[indexPath.section] objectAtIndex:indexPath.row];
        
        NSString *ID = dic[@"id"];
        //ID = %@",ID);
        NSString *title = dic[@"name"];
        //title = %@",title);
        
        NSNumber *type1=[_typeIndexArr[_slidePageScrollView.pageTabBar.index]objectForKey:@"id"];
        NSString *type_name=[_typeIndexArr[_slidePageScrollView.pageTabBar.index]objectForKey:@"name"];
        
        TFSearchViewController *svc = [[TFSearchViewController alloc] init];
        svc.parentID = ID;
        svc.shopTitle = title;
        
        svc.typeID = type1;
        svc.typeName = type_name;
        
        svc.hidesBottomBarWhenPushed=YES;
        
        [self.navigationController pushViewController:svc animated:YES];
    } else if (self.searchStatus == 1) {
        if (indexPath.row!=self.searchHistoryDataArr.count-1) {
            //
            SearchItem *item = self.searchHistoryDataArr[indexPath.row];
            self.searchBar.text = item.searchText;
            [self searchBarSearchButtonClicked:self.searchBar];
        } else {
            FMDBSearchManager *manager = [FMDBSearchManager sharedManager];
            [manager deleteSearchDB];
            
            [self.searchHistoryDataArr removeAllObjects];
            [self.searchTableView reloadData];
        }
    }
}
-(void)popWTFAlertView:(NSArray *)titleArray
{
    WTFAlertView *alert = [WTFAlertView GlodeBottomView];
    alert.titleArray = titleArray;
    
    //    [alert show];
}
#pragma mark - view将要出现
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"GouwuPage"];
    
    if (self.httpFailure) {
        [self creatDataAnimation:YES];
        [_slidePageScrollView reloadData];
    }
    
    //新手任务
    if (self.isHeadView == YES) {
        //%d = %d", self.searchBtn.selected, self.screenBtn.selected);
        
        if (self.screenBtn.selected) {
            self.titleLabel.text = @"筛选";
            Myview.hidden = YES;
            Mtarbar.tabBar.hidden=YES;
        }
        
        //搜索历史纪录
        [self.searchHistoryDataArr removeAllObjects];
        FMDBSearchManager *manager = [FMDBSearchManager sharedManager];
        NSArray *array = [manager getAllSearchItem];
        //逆序添加
        for (NSInteger i = array.count-1; i >= 0; i--) {
            SearchItem *item = array[i];
            [self.searchHistoryDataArr addObject:item];
        }
        if (array.count!=0) {
            SearchItem *item = [[SearchItem alloc] init];
            item.searchText = @"清空搜索纪录";
            [self.searchHistoryDataArr addObject:item];
        }
        
//        [self noviceTaskView5];     //衣服首页，5秒；弹1未完成，已登录未开店
        
        //        [self noviceTaskView4];     //衣服首页，5秒；弹1未完成，未登录，登录后不出现
        
//        [self noviceTaskView11];    //去吐槽
        
        //        [self dailyTaskView0];      //衣服首页：5秒；已登录（变更为周六周日提醒）
        
        //        [self dailyTaskView34567];  //衣服首页:5秒；已登录已开店  (周一，周二，周三)
        //衣服首页；5秒；已登录已开店 (周四，周五)
        
        NSUserDefaults *stand = [NSUserDefaults standardUserDefaults];
        NSString *searchstr = [stand objectForKey:@"suaixuansousuo"];
        
        if([searchstr isEqualToString:@"筛选搜索"])
        {
            if(self.isScreenAnimationFinished == NO)
            {
                if(self.screenBtn.selected == YES)
                {
                    Myview.hidden = YES;
                    Mtarbar.tabBar.hidden=YES;
                } else{
                    Myview.hidden = NO;
                    Mtarbar.tabBar.hidden=NO;
                }
            }
            
            [stand setObject:@"" forKey:@"suaixuansousuo"];
        }
    }
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if([DataManager sharedManager].is_OneYuan == NO)
    {
        Mtarbar.tabBar.hidden = YES;
    }
    if(self.isFirstComming){
        [self RedhongBao];
    }
    self.isFirstComming = true;
}
#pragma mark - view将要消失
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"GouwuPage"];
    
    [_noviceTimer_4 invalidate];
    [_noviceTimer_5 invalidate];
    [_noviceTimer_11 invalidate];
    [_dailyTaskTimer_0 invalidate];
    [_dailyTaskTimer_34567 invalidate];
    
    [self.mytimer invalidate];
    [self.redhongbaoview remindViewDisapper];
    [self.redhongbaoview removeFromSuperview];
}

#pragma mark - view已经消失
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.searchBar.text = nil;
    self.searchStatus = 0;
    self.searchText = nil;
    [self.searchBar resignFirstResponder];
    [self contentBackgroundViewStatusWithNormal];
    [self.searchRightView removeFromSuperview];
}

/**
 设置相机图片分辨率
 self.session.sessionPreset = AVCaptureSessionPreset640x480
 */

#pragma mark - view状态归位
- (void)viewBackToInitState
{
    self.searchBar.text = nil;
    self.searchStatus = 0;
    self.searchText = nil;
    [self.searchBar resignFirstResponder];
    
    self.searchBtn.selected = NO;
    self.screenBtn.selected = NO;
    
    [self contentBackgroundViewStatusWithNormal];
    
    [self.searchRightView removeFromSuperview];
    [self.screeningScrollView removeFromSuperview];

}

- (NSMutableArray *)typeIndexArr
{
    if (_typeIndexArr == nil) {
        _typeIndexArr = [[NSMutableArray alloc] init];
    }
    return _typeIndexArr;
}

- (NSMutableArray *)searchDataArr
{
    if (_searchDataArr == nil) {
        _searchDataArr = [[NSMutableArray alloc] init];
    }
    return _searchDataArr;
}

- (NSMutableArray *)searchResultDataArr
{
    if (_searchResultDataArr == nil) {
        _searchResultDataArr = [[NSMutableArray alloc] init];
    }
    return _searchResultDataArr;
}

- (NSMutableArray *)searchHistoryDataArr
{
    if (_searchHistoryDataArr == nil) {
        _searchHistoryDataArr = [[NSMutableArray alloc] init];
    }
    return _searchHistoryDataArr;
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



#pragma mark 热卖推荐网络请求
-(void)HostrequestHttp
{
    [_hostDataArray removeAllObjects];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    url=[NSString stringWithFormat:@"%@shop/queryOption?version=%@&type=2",[NSObject baseURLStr],VERSION];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                NSArray *arr = responseObject[@"centShops"];
                
                if(arr.count)
                {
                    for(NSDictionary *dic in arr)
                    {
                        ShopDetailModel *model = [[ShopDetailModel alloc]init];
                        
                        model.shop_id = [NSString stringWithFormat:@"%@",dic[@"id"]];
                        model.remark = [NSString stringWithFormat:@"%@",dic[@"remark"]];
                        model.shop_code = [NSString stringWithFormat:@"%@",dic[@"shop_code"]];
                        model.shop_name = [NSString stringWithFormat:@"%@",dic[@"shop_name"]];
                        model.type = [NSString stringWithFormat:@"%@",dic[@"type"]];
                        model.pic = [NSString stringWithFormat:@"%@",dic[@"url"]];
                        
                        [_hostDataArray addObject:model];
                        
                    }
                    
                }
                
            }else{
                
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        } else{
            //            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            //            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
}

- (void)httpGetShareImage
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], USER_SHARE_APP];
    //url = %@", url);
    
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSData *imgData = UIImagePNGRepresentation(responseObject);
            self.shareAppImg = [UIImage imageWithData:imgData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
    }];
    
}


-(void)httpTestToken
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@loginRecord/lastLogin?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            int status=[responseObject[@"status"] intValue];
            if(status == 10030)   //检测成功
            {
                LoginViewController *login=[[LoginViewController alloc]init];
                
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            } else if (status == 1) {
                [self createUI];
                [_slidePageScrollView reloadData];
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

#pragma mark ------------------4-------------------

- (void)mainViewStatusNormal
{
    [self contentBackgroundViewStatusWithNormal];
}

- (void)mainViewStatusToRight
{
    [self contentBackgroundViewStatusToRight];
}

- (void)contentBackgroundViewStatusWithNormal
{
    self.contentBackgroundView.center = CGPointMake(openPointCenter.x-OPENCENTERX,openPointCenter.y);
}

- (void)contentBackgroundViewStatusToRight
{
    self.contentBackgroundView.center = openPointCenter;
    //    self.contentBackgroundView.frame = CGRectMake(OPENCENTERX, StatusTableHeight, kScreenWidth, self.contentBackgroundView.frame.size.height);
}

- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView verticalScrollViewDidScroll:(UIScrollView *)pageScrollView
{
    if (pageScrollView.contentSize.height <= CGRectGetHeight(pageScrollView.bounds)-49-(self.bigImgHeight+self.smallImgHeight+self.lineHeight+self.titleHeight)) {
        return;
    } else if (pageScrollView.panGestureRecognizer.state == UIGestureRecognizerStateChanged){
        CGFloat nowPanOffsetY = [pageScrollView.panGestureRecognizer translationInView:pageScrollView.superview].y;
        CGFloat diffPanOffsetY = nowPanOffsetY - _oldPointY;
        
        //        MyLog(@"diffPanOffsetY: %f", diffPanOffsetY);
        if (ABS(diffPanOffsetY) > 30) {
            
            if (diffPanOffsetY <0) {
                
            } else {
                
            }
        }
        _oldPointY = nowPanOffsetY;
        
    }
}

- (void)slidePageScrollView:(TYSlidePageScrollView *)slidePageScrollView pageTabBarScrollOffset:(CGFloat)offset state:(TYPageTabBarState)state
{
    if (state == TYPageTabBarStateStopOnTop) {
        //
    }
}

- (void)collectionViewWithScrollViewWillBeginDragging:(UIScrollView *)scrollView index:(int)index
{
    
    _oldPointY = [scrollView.panGestureRecognizer translationInView:scrollView.superview].y;
}

- (void)collectionViewWithScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate index:(int)index
{
    
    _oldPointY = 0;
    if (decelerate == NO) {
        
    } else{
        
    }
    
}

/**
 新人红包
 */
- (void)RedhongBao
{
    kWeakSelf(self);
    [hongBaoModel GetDataSuccess:^(id  _Nonnull data) {
        hongBaoModel *model = data;
        if(model.status == 1)
        {
            NSNumber* homePage3FirstTime = model.data[@"homePage3FirstTime"];
            NSNumber* homePage3ElastTime = model.data[@"homePage3ElasticFrame"];
            self.ElastTime = [homePage3ElastTime doubleValue];
            
            //第一次弹出时间
            [weakself performSelector:@selector(creatRedHongBaoview) withObject:nil afterDelay:homePage3FirstTime.doubleValue];
        }
    }];
}
- (void)creatRedHongBaoview
{
    self.redhongbaoview = [[TixianRedHongbao alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width,kScreen_Height) Nextpop:self.ElastTime];
    kWeakSelf(self);
    self.redhongbaoview.lingHongBaoBlock = ^(BOOL isNewUser) {
        
        MakeMoneyViewController *vc = [[MakeMoneyViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    
    self.redhongbaoview.closeHongBaoBlack = ^(double lastTime) {
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
        if(token.length >10)
        {
            return ;
        }
        
        //倒计时
        weakself.mytimer= [NSTimer weakTimerWithTimeInterval:weakself.ElastTime target:weakself selector:@selector(creatRedHongBaoview) userInfo:nil repeats:YES];
    };
    [self.view addSubview:self.redhongbaoview];
}

/**
 悬浮红包
 */
- (void)xuanfuHongBaoView
{
    self.hongbaoview = [[RedXuanfuHongBao alloc]initWithFrame:CGRectMake(kScreen_Width-78, kScreen_Height-(kTabBarHeight+ZOOM6(100)), 70,70) isShouYeThree:YES];
    kWeakSelf(self);
    
    self.hongbaoview.lingHongBaoBlock = ^(BOOL isNewUser) {
        
        MakeMoneyViewController *vc = [[MakeMoneyViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:vc animated:YES];
        
    };
    [self.contentBackgroundView addSubview:self.hongbaoview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
