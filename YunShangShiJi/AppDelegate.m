//
//  AppDelegate.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/9.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarController.h"
#import "ShopStoreViewController.h"
#import "MainStoreViewController.h"
#import "TFCircleViewController.h"
//#import "ChatListViewController.h"
#import "YFTestChatViewController.h"
#import "SqliteManager.h"

#import "MymineViewController.h"
#import "GlobalTool.h"
#import "ShopDetailViewController.h"
#import "DShareManager.h"
#import "NavgationbarView.h"
#import "BuySuccessViewController.h"
//#import "ComboShopDetailViewController.h"
#import "TFAccountDetailsViewController.h"
#import "CollocationVC.h"
#import "CollocationDetailViewController.h"
#import "MyOrderViewController.h"
#import "AftersaleViewController.h"
#import "SearchTypeViewController.h"
#import "NewShoppingCartViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/TencentOAuth.h>
//#import <RennSDK/RennSDK.h>
#import "WeiboSDK.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
//APP端签名相关头文件
#import "payRequsestHandler.h"
#import <QuartzCore/QuartzCore.h>
#import <AdSupport/AdSupport.h>
#import "TFWelcomeView.h"

#import "SearchTypeViewController.h"
#import "TFHomeViewController.h"
#import "TFSalePurchaseViewController.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "HYJGuideView.h"
#import "MobClick.h"
#import "UMessage.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"
#import "Signmanager.h"

#import "ValueObserver.h"
#import "HTTPTarbarNum.h"
#import "OneYuanModel.h"
#import "AppDelegate+LibConfig.h"

#import "TFShoppingViewController.h"
#import "YFLaunchView.h"
#import "YFShareModel.h"
#import "ShopCarManager.h"
#import "FunsaddModel.h"
#import "FunsSuspensionView.h"
#import "GoldCouponsManager.h"
#import "LuckdrawViewController.h"
//#import "CouponsManager.h"
#import "YiFuUserInfoManager.h"
#import "TFRequest.h"
#import "MessageCenterVC.h"
#import "TFIntimateCircleVC.h"
#import "ShopDislikeModel.h"
#import "RawardRedPopview.h"
#import "LoginViewController.h"
#import "TopicPublicModel.h"
#import "CFActivityDetailToPayVC.h"
#import "IndianaDetailViewController.h"
#import "OneIndianaDetailViewController.h"
#import "FightIndianaDetailViewController.h"
//#define kbus_tag_data  @"06426938DF8F9E75BAEFDAB1848D0896"
//#define ktype_tag_data @"D0A6E628157E321E336BE557C400F0EC"//@"1"
//#define ktag_data      @"465BADBE9899C83C4D775AFD0D087C2A"
//#define ktype_data     @"55610F14C8B224A4735D48FD46AF1893"
//#define ksupp_label_data @"6C4BDC015FD89CD5C2C972E466B5E85E"//@"1"
#define kbus_tag_data  @"1"
#define ktype_tag_data @"1"//@"1"
#define ktag_data      @"1"
#define ktype_data     @"1"
#define ksupp_label_data @"1"//@"1"
#define khot_tag @"1"

#define SSKeychain_Service      @"com.yunShangshiji"
#define SSKeychain_Account_UUID @"UUID"


#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


@interface AppDelegate ()

{
    NSTimer *connectionTimer;  //timer对象
    
    const char *_sql_stmt;
    
    NSInteger _indexfour;
    NSInteger _indexone;
    NSInteger _time;
    
}

@property (nonatomic, strong) FunsSuspensionView *FunsView;

@property (nonatomic, strong)ValueObserver *kvo;

@property (nonatomic, assign)BOOL isFaild;

@property (nonatomic, strong)UILocalNotification *localNotification;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [AFAppDotNetAPIClient sharedClient];
    
    [YiFuUserInfoManager shareInstance];
    
    MyLog(@"Home: %@", NSHomeDirectory());
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    @try { //捕捉异常的代码
      
        UIViewController* vc = [[UIViewController alloc] initWithNibName:nil bundle:nil];
        self.window.rootViewController = vc;
        
        // begin 赵官林 2016.5.25
        // 统一导航栏样式
        [self setNavigationBarStyle];
        // end
        
        IsRongCloub = NO;//融云环信切换
        
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"isFirst"]) {
            [self writeToFile];
        } else{
            //同步数据到数据库
            [self httpSortRequest];
        }
        
//        [self httpIsOpen];
        
        [self weixinArgumentHttp];
        
        [self httpGetSwitch];
        
        [self httpUserLoginType];
        [self httpUserLoginToWeiXin];
        [self httpShareUrlIP];
        //获取环信客服ID
        [self getPTEID];
                
        TFShoppingViewController *mainstore = [[TFShoppingViewController alloc] init];
//        [mainstore initWithFiristGo];
        UINavigationController *mainstoreNav=[[UINavigationController alloc]initWithRootViewController:mainstore];
        
        SearchTypeViewController *shopstore1= [[SearchTypeViewController alloc] init];
        UINavigationController *shopstoreNav=[[UINavigationController alloc]initWithRootViewController:shopstore1];
        
//        TFIntimateCircleVC *inCircleVC = [[TFIntimateCircleVC alloc] init];
//        UINavigationController *CartNav=[[UINavigationController alloc]initWithRootViewController:inCircleVC];

//        NewShoppingCartViewController *shopcart=[[NewShoppingCartViewController alloc]init];
//        shopcart.ShopCart_Type = ShopCart_TarbarType;
//        UINavigationController *homeSignNav=[[UINavigationController alloc]initWithRootViewController:shopcart];
        
//        MakeMoneyViewController *money = [[MakeMoneyViewController alloc]init];
//        money.MakeMoney_Type = MakeMoney_NTarbarType;
//        UINavigationController *homeSignNav=[[UINavigationController alloc]initWithRootViewController:money];
        
        MymineViewController *mymine=[[MymineViewController alloc]init];
        UINavigationController *mymineNav=[[UINavigationController alloc]initWithRootViewController:mymine];
        
        MyTabBarController *mytabar=[[MyTabBarController alloc]init];
        mytabar.viewControllers=@[mainstoreNav,shopstoreNav,mymineNav];

        mytabar.selectedIndex = 0;
        
        mytabar.delegate = self;
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        
        if ([ud objectForKey:@"isFirst"]) {
            
            Mtarbar=mytabar;
            self.window.rootViewController = Mtarbar;
            [YFLaunchView show];//隐藏广告页
        } else {
//            TFWelcomeView *tv = [[TFWelcomeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//            [self.window addSubview:tv];
//
//            tv.welcomeBlock = ^() {
//
//                Mtarbar=mytabar;
//                self.window.rootViewController = Mtarbar;
//
//                [ud setBool:YES forKey:@"isFirst"];
//                [ud synchronize];
//            };
            
            Mtarbar=mytabar;
            self.window.rootViewController = Mtarbar;
            [ud setBool:YES forKey:@"isFirst"];
            
//            [YFLaunchView update];
        }
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]!=nil) {
            [HTTPTarbarNum httpRedCount];
            [HTTPTarbarNum httpGetUserGrade];
            
            [self httpGetMisson];
            
        }
        
        //注册环信的appKey 注册微信appKey
        [self weixinRegist:application didFinishLaunchingWithOptions:launchOptions];
        
        //友盟推送
        [self UMPUSH:launchOptions];
        
        // 同步购物车数据
        [ShopCarManager loadDataNetwork];
        
        [self applicationStartingMethod:launchOptions];
        
        //获取设备唯一标识符
        NSString *UUID =[self uuid];
        [ud setObject:UUID forKey:USER_UUID];
        
        ValueObserver *kvo = [ValueObserver shareValueObserver];
        self.kvo = kvo;
        gKVO = self.kvo;
        
        //将后台推送消息数量为0
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        
        self.mentionCount = 0;
    
    }
    @catch (NSException *exception) {
        
        // 捕获到的异常exception
        UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"当前网络不好,数据获取异常" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alterview show];
    }
    @finally {
        // 结果处理
    }
    
    
    return YES;
}
#pragma mark ***************环信/微信/APNS/友盟统计 注册**********************
- (void)weixinRegist:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    NSString *str =@"52yifu.com";
    NSString *url = [NSString stringWithFormat:@"%@",[NSObject baseURLStr]];
    NSRange range =[url rangeOfString:str];

    if(range.length>0)//外环境
    {
        //向微信注册
        [WXApi registerApp:@"wx8c5fe3e40669c535" enableMTA:NO];
    } else{
    
        //向微信注册
        [WXApi registerApp:@"wxbb9728502635a425" enableMTA:NO];
    }
    
        
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound |
        UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];

    }
    else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }

    //友盟统计注册
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    [MobClick startWithAppkey:@"5656d6d467e58ea3060005e2" reportPolicy:BATCH   channelId:@"nil"];
}


#pragma mark ************************网络部分***************************
//后台加入一个配置入口，能随时切换“正常登录”（手机号、QQ、微信、微博）和只用微信授权登录
- (void)httpUserLoginType{
    
    NSString *apistr = [NSString stringWithFormat:@"user/getChStatus?appVersion=%@&",[self getVersion]];
    [[APIClient sharedManager]netWorkGeneralRequestWithApi:apistr caches:NO cachesTimeInterval:0 token:NO success:^(id data, Response *response) {
        if (response.status == 1) {
            NSNumber *dataNumber = data[@"data"];
            if (kUnNilAndNULL(dataNumber)) {
                [[NSUserDefaults standardUserDefaults] setObject:dataNumber forKey:USER_LoginType];
            }else
                [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:USER_LoginType];

        }
    } failure:^(NSError *error) {
        
    }];
}
//分享域名动态处理
- (void)httpShareUrlIP{
    [[APIClient sharedManager]netWorkGeneralRequestWithApi:@"cfg/getdomain?" caches:NO cachesTimeInterval:0 token:NO success:^(id data, Response *response) {
        if (response.status == 1) {
            NSString *domain = data[@"domain"];
            if (domain) {
                [[NSUserDefaults standardUserDefaults] setObject:domain forKey:@"ShareUrlIP"];
            }
        }
    } failure:^(NSError *error) {

    }];
}

#pragma mark 启动激活记录
- (void)httpStartActiva
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    NSString *IDFA =  [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString *UUID = [self uuid];
    [userdefaul setObject:UUID forKey:USER_UUID];
    [userdefaul setObject:IDFA forKey:USER_IDFA];
    [userdefaul synchronize];
    
    if([token isEqualToString:@"(null)"] || [token isEqual:[NSNull null]] || [token isEqualToString:@"<null>"])
    {
        token =@"";
    }
    
    int num = 0;
    if(token.length > 10)
    {
        //今天登录的次数
        NSDate *date = [NSDate date];
        
        NSString *tt = [NSString stringWithFormat:@"%@",date];
        
        NSString *mt = [[NSUserDefaults standardUserDefaults]objectForKey:NowDate];
        
        if(![tt isEqualToString:mt])
        {
            //是否到了第二天
            num = [self isTodayorTomorrow];
        }
        
    }
    
    NSString *url;
    if(token!=nil&&token.length!=0&&![token isEqualToString:@"null"]&&![token isEqual:[NSNull null]]){
        
        url=[NSString stringWithFormat:@"%@startActiva/add?version=%@&type=7&imei=%@&token=%@&num=%d&idfa=%@",[NSObject baseURLStr],VERSION, UUID,token,num,IDFA];
    }else
        url=[NSString stringWithFormat:@"%@startActiva/add?version=%@&type=7&imei=%@&idfa=%@",[NSObject baseURLStr],VERSION,UUID,IDFA];
    
    NSString *URL=[MyMD5 authkey:url];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            if(responseObject !=nil || ![responseObject isEqual:[NSNull null]])
            {
                int status = [responseObject[@"status"] intValue];
                if (status == 1) {

                    //搭配购 折扣
                    if (responseObject[@"dpZheKou"]!=nil) {
                        [userdefaul setObject:responseObject[@"dpZheKou"] forKey:@"dpZheKou"];
                    }else
                        [userdefaul setObject:@"0.95" forKey:@"dpZheKou"];

                    if (responseObject[@"flag"]!=nil) {
                        NSNumber *flag = responseObject[@"flag"];
                        if ([flag intValue] == 0) {
                            
                            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                            //获取当前时间
                            NSString *currStr = [MyMD5 getCurrTimeString:@"year-month-day"];
                            NSString *oldStr = [ud objectForKey:NoviciateTaskOne];
                            
                            if (oldStr == nil || ![oldStr isEqualToString:currStr]) {
                                [userdefaul setBool:YES forKey:UserUUIDFlag];
                            } else {
                                [userdefaul setBool:NO forKey:UserUUIDFlag];
                            }
                        } else {
                            [userdefaul setBool:NO forKey:UserUUIDFlag];
                        }
                    }
                    
                    if(responseObject[@"twofoldness"] !=nil && ![responseObject[@"twofoldness"] isEqual:[NSNull null]]){
                        [userdefaul setObject:responseObject[@"twofoldness"] forKey:TWOFLODNESS];
                    }
                    
                    //引导弹框倒计时
                    if(responseObject[@"halve"] != nil && ![responseObject[@"halve"] isEqual:[NSNull null]])
                    {
                        [DataManager sharedManager].halve = ((NSNumber*)responseObject[@"halve"]).longLongValue;
                    }else{
                        [DataManager sharedManager].halve = 120000;
                    }

                    //分享满多少次给一次机会
                    if(responseObject[@"shareToNum"] != nil && ![responseObject[@"shareToNum"] isEqual:[NSNull null]])
                    {
                        [DataManager sharedManager].shareToNum = ((NSNumber*)responseObject[@"shareToNum"]).longLongValue;
                        if([DataManager sharedManager].shareToNum == 0)
                        {
                            [DataManager sharedManager].shareToNum = 5;
                        }
                    }else{
                        [DataManager sharedManager].shareToNum = 5;
                    }
                    
                    //当天分享次数上限
                    if(responseObject[@"shareToDayNum"] != nil && ![responseObject[@"shareToDayNum"] isEqual:[NSNull null]])
                    {
                        [DataManager sharedManager].shareToDayNum = ((NSNumber*)responseObject[@"shareToDayNum"]).longLongValue;
                        
                        if([DataManager sharedManager].shareToDayNum == 0)
                        {
                            [DataManager sharedManager].shareToDayNum = 200;
                        }

                    }else{
                        [DataManager sharedManager].shareToDayNum = 200;
                    }
                    
                    //H5赚钱金额
                    NSString *h5money = [NSString stringWithFormat:@"%@",responseObject[@"h5money"]];
                    [DataManager sharedManager].h5money = h5money.floatValue;
                    
                }
                [MyMD5 changeMemberPriceRate];
                
                NSString *ordertoken = [NSString stringWithFormat:@"%@",responseObject[@"orderToken"]];
                
                if (ordertoken!=nil && ![ordertoken isEqualToString:@"<null>"] && ordertoken.length > 0) {
                    
                    [[NSUserDefaults standardUserDefaults]setObject:ordertoken forKey:ORDER_TOKEN];
                }
                
            }
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark 请求用户加喜欢的商品
- (void)getUserLikeHttp
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    if(token == nil)//如果没有登录就不请求
    {
        return;
    }
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSString *url=[NSString stringWithFormat:@"%@like/ selLikeShopCodes?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {
            NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
            if([responseObject[@"codes"] count] > 0)
            {
               
                [userdefaul removeObjectForKey:@"user_like"];
                [userdefaul setObject:responseObject[@"codes"] forKey:@"user_like"];
            }else{
                [userdefaul removeObjectForKey:@"user_like"];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

- (void)httpGetMisson
{
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"RFTCart"];//用于刷新tabbar的购物车
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@wallet/getIntegral?token=%@&version=%@",[NSObject baseURLStr],token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                NSArray *fulFillArr = responseObject[@"fulfill"];
                if ([fulFillArr containsObject:@"18"]) {
                    [ud setBool:NO forKey:NoviciateTask_18_FLAG];
                } else {
                    [ud setBool:YES forKey:NoviciateTask_18_FLAG];
                }
                
                if ([fulFillArr containsObject:@"22"]) {
                    [ud setBool:NO forKey:NoviciateTask_22_FLAG];
                } else {
                    [ud setBool:YES forKey:NoviciateTask_22_FLAG];
                }
                
                if ([fulFillArr containsObject:@"23"]) {
                    [ud setBool:NO forKey:NoviciateTask_23_FLAG];
                } else {
                    [ud setBool:YES forKey:NoviciateTask_23_FLAG];
                }
                
                if ([fulFillArr containsObject:@"24"]) {
                    [ud setBool:NO forKey:NoviciateTask_24_FLAG];
                } else {
                    [ud setBool:YES forKey:NoviciateTask_24_FLAG];
                }
                
            
            } else {
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

#pragma mark  手机是否开店
-(void)httpIsOpen
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSString *url=[NSString stringWithFormat:@"%@ad/isOpen?version=%@&imei=%@",[NSObject baseURLStr],VERSION,[self uuid]];
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if ([responseObject[@"status"] intValue] == 1) {
            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"isOpen"] forKey:Phone_isOpen];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)httpRedCount
{
    NSString *url=[NSString stringWithFormat:@"%@user/finCount?version=%@&token=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]];
    NSString *URL=[MyMD5 authkey:url];
    
    NSURL *httpUrl=[NSURL URLWithString:URL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpUrl];
    request.timeoutInterval = 3;
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        responseObject = [NSDictionary changeType:responseObject];
        if ([responseObject[@"status"] intValue] == 1) {
            
            NSString *H5count = [NSString stringWithFormat:@"%@",responseObject[@"H5Count"]];
            
            if ([responseObject[@"finCount"]integerValue]==0) {
                [Mtarbar hideBadgeOnItemIndex:4];
            } else if ([responseObject[@"finCount"]integerValue]>0) {
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"%@fourIndex",[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID]]]isEqualToString:[MyMD5 getCurrTimeString:@"year-month-day"]]) {
                    [Mtarbar hideBadgeOnItemIndex:4];
                }else
                    [Mtarbar showBadgeOnItemIndex:4];
                
                _indexfour = [responseObject[@"finCount"] intValue];
            }
            if(H5count !=nil && ![H5count isEqualToString:@"<null>"]&& [H5count integerValue]>0)
            {
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                NSString * nowDate = [ud objectForKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],MARK_STORE]];
                
                if (![nowDate isEqualToString:[MyMD5 getCurrTimeString:@"year-month-day"]]) {
                    [Mtarbar showBadgeOnItemIndex:0];
                    [Mtarbar changeBadgeNumOnItemIndex:0 withNum:H5count];
                    _indexone = [H5count intValue];
                }
                
            }
            
            int count = (int)_indexone + (int)_indexfour;
            
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",count] forKey:USER_AllCount];
            
            [UIApplication sharedApplication].applicationIconBadgeNumber = count;
        }else{
            
            [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:USER_AllCount];
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }
        
    }
    
}

#pragma mark 获取项目版本
- (void)httpVersionsRequest
{
    NSString *url=[NSString stringWithFormat:@"%@getVersion?version=%@&type=2",[NSObject baseURLStr],VERSION];
    NSString *URL=[MyMD5 authkey:url];
    
    NSURL *httpUrl=[NSURL URLWithString:URL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpUrl];
    request.timeoutInterval = 3;
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        responseObject = [NSDictionary changeType:responseObject];
        if ([responseObject[@"status"] intValue] == 1) {
            
            NSString *version_no = [NSString stringWithFormat:@"%@",responseObject[@"version_no"]];
            NSString *versionmsg = [NSString stringWithFormat:@"%@",responseObject[@"msg"]];
            NSString *getversion =[self getVersion];
            
            NSString *httpVer ;//服务器版本
            NSString *getVer ;//工程版本
            
            if(version_no !=nil && ![version_no isEqualToString:@"<null>"] && version_no.length > 0)
            {
                httpVer = [version_no substringFromIndex:1];
                [DataManager sharedManager].version = httpVer;
            }
            
            if(getversion !=nil && ![getversion isEqualToString:@"<null>"] && getversion.length > 0)
            {
                getVer = [getversion substringFromIndex:1];
            }
            
            if ([httpVer compare:getVer options:NSNumericSearch] ==NSOrderedDescending)
            {
                MyLog(@"%@ is bigger",httpVer);//服务器版本 也就是APPstore要更新到的新版本
                
                if([responseObject[@"is_update"] intValue]==1)
                {
                    self.isQiangGeng = YES;
                }else if ([responseObject[@"is_update"] intValue]==0)
                {
                    self.isQiangGeng = NO;
                }
                
                if([versionmsg length] > 0)
                {
                    self.msg = [NSString stringWithFormat:@"%@",responseObject[@"msg"]];
                }
                
                if([version_no length] > 0)
                {
                    self.version_no = [NSString stringWithFormat:@"%@",responseObject[@"version_no"]];
                }
                
                self.isUpdata = YES;
                if(versionmsg) {
                    self.versionmsg = versionmsg;
                }
                
            } else {
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                NSString *show_flag = [ud objectForKey:UserShowValue];
                //show_flag = %@", show_flag);
                
                if ([show_flag isEqual:[NSNull null]]|| show_flag  == nil) {
                    show_flag = @"1";
                    [ud setObject:show_flag forKey:UserShowValue];
                    [ud setBool:NO forKey:UserShowFlag];
                    //%@ = %d" ,show_flag, [[ud objectForKey:UserShowFlag] intValue]);
                } else {
                    NSInteger show_flag_value = [show_flag integerValue];
                    show_flag_value++;
                    if (show_flag_value == 2) { //版本更新第二次启动
                        [ud setBool:YES forKey:UserShowFlag];
                    } else {
                        
                        if ([[ud objectForKey:UserShowFlag] intValue] == 1) { //上次因为其他原因没有弹出
                            [ud setBool:YES forKey:UserShowFlag];
                        } else {
                            [ud setBool:NO forKey:UserShowFlag];
                        }
                    }
                    NSString *show_flag_temp = [NSString stringWithFormat:@"%ld", (long)show_flag_value];
                    [ud setObject:show_flag_temp forKey:UserShowValue];
                    //%@ = %d" ,show_flag_temp, [[ud objectForKey:UserShowFlag] intValue]);
                    
                }
                
                self.isUpdata = NO;
            }
            
        }
        
    }
    
}

- (void)httpGetSwitch
{
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_user_getSwitch caches:NO cachesTimeInterval:0*TFMinute token:NO success:^(id data, Response *response) {
        if (response.status == 1) {
            NSNumber *dataNumber = data[@"data"];
            if (kUnNilAndNULL(dataNumber)) {
                [[NSUserDefaults standardUserDefaults] setObject:dataNumber forKey:USER_GetSwitch];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)httpUserLoginToWeiXin {
    [[APIClient sharedManager]netWorkGeneralRequestWithApi:@"user/getChannelStatus?" caches:NO cachesTimeInterval:0 token:NO success:^(id data, Response *response) {
        if (response.status == 1) {
            //1，授权    2，不授权
            NSNumber *dataNumber = data[@"data"];
            if (kUnNilAndNULL(dataNumber)) {
                [[NSUserDefaults standardUserDefaults] setObject:dataNumber forKey:USER_LoginToWeiXin];
            }else
                [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:2] forKey:USER_LoginToWeiXin];
            
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark 获取微信支付参数
- (void)weixinArgumentHttp
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    NSString *UUID = [self uuid];
    [userdefaul setObject:UUID forKey:USER_UUID];
    [userdefaul synchronize];
    
    NSString *url;
    if(token!=nil || ![token isEqualToString:@"(null)"]){
        
        url=[NSString stringWithFormat:@"%@wxpay/getData?version=%@&token=%@",[NSObject baseURLStr_Pay],VERSION,token];
    }
    
    NSString *URL=[MyMD5 authkey:url];
    NSURL *httpUrl=[NSURL URLWithString:URL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpUrl];
    request.timeoutInterval = 3;
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        responseObject = [NSDictionary changeType:responseObject];
        if(responseObject !=nil || ![responseObject isEqual:[NSNull null]])
        {
            
            int status = [responseObject[@"status"] intValue];
            
            if (status == 1) {
                
                if(responseObject[@"AppSecret"])
                {
                    [userdefaul setObject:responseObject[@"AppSecret"] forKey:APP_SECRET];
                }
                    
                if(responseObject[@"appID"])
                {
                    [userdefaul setObject:responseObject[@"appID"] forKey:APP_ID];
                    self.takeoutPay.delegate=self;
                    
                    //向微信注册
                    if([responseObject[@"appID"] isEqualToString:@"wx8c5fe3e40669c535"])
                    {
                        [WXApi registerApp:@"wx8c5fe3e40669c535" enableMTA:NO];
                    }else{
                        [WXApi registerApp:@"wxbb9728502635a425" enableMTA:NO];
                    }
                }
                
                NSString * mchID = [NSString stringWithFormat:@"%@",responseObject[@"mchID"]];
                if(mchID!=nil && ![mchID isEqualToString:@"<null>"] && mchID.length >0 )
                {
                    [userdefaul setObject:responseObject[@"mchID"] forKey:MCH_ID];
                }
                
                NSString *key = [NSString stringWithFormat:@"%@",responseObject[@"key"]];
                if(key!=nil && ![key isEqualToString:@"<null>"] && key.length > 0)
                {
                    [userdefaul setObject:responseObject[@"key"] forKey:PARTNER_ID];
                }
            }
            
            
            NSString *ordertoken = [NSString stringWithFormat:@"%@",responseObject[@"orderToken"]];
            if (ordertoken!=nil && ![ordertoken isEqual:[NSNull null]])
            {
                [[NSUserDefaults standardUserDefaults]setObject:ordertoken forKey:ORDER_TOKEN];
            }
            
        }
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
        
        //        responseObject = [NSDictionary changeType:responseObject];
        
        int status = [responseObject[@"status"] intValue];
        
        if (status == 1) {
            
            if(responseObject !=nil && responseObject !=NULL)
            {
                if (![responseObject[@"price"] isEqual:[NSNull null]]) {
                    [userdefaul setObject:responseObject[@"price"] forKey:PAY_ALI_PRICE];
                }
                if(responseObject[@"ali_public_key"]!=nil && ![responseObject[@"ali_public_key"] isEqualToString:@"<null>"])
                {
                    [userdefaul setObject:responseObject[@"ali_public_key"] forKey:PAY_ALI_PUBLIC_KEY];
                }
                
                if(responseObject[@"partner"]!=nil && ![responseObject[@"partner"] isEqualToString:@"<null>"])
                {
                    [userdefaul setObject:responseObject[@"partner"] forKey:PAY_PARTNER];
                }
                
                if(responseObject[@"pay_url"]!=nil && ![responseObject[@"pay_url"] isEqualToString:@"<null>"])
                {
                    [userdefaul setObject:responseObject[@"pay_url"] forKey:PAY_URL];
                }
                
                if(responseObject[@"private_key"] && ![responseObject[@"private_key"] isEqualToString:@"<null>"])
                {
                    [userdefaul setObject:responseObject[@"private_key"] forKey:PAY_PRIVATE_KEY];
                }
                
                if(responseObject[@"seller"] && ![responseObject[@"seller"] isEqualToString:@"<null>"])
                {
                    [userdefaul setObject:responseObject[@"seller"] forKey:PAY_SELLER];
                }
                
                if(responseObject[@"sign_type"] && ![responseObject[@"sign_type"] isEqualToString:@"<null>"])
                {
                    [userdefaul setObject:responseObject[@"sign_type"] forKey:PAY_SIGN_TYPE];
                }
                
            }
        }
        
    }
}

//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{
//    NSLog(@"url=%@",url);
//    if ([url.host isEqualToString:@"safepay"]) {
//        //跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService]
//         processOrderWithPaymentResult:url
//         standbyCallback:^(NSDictionary *resultDic) {
//
//             [self payFinished:resultDic];
//
//         }];
//    }
//    return YES;
//}
#pragma mark 获取是否是疯狂星期一
-(void)httpGetMonday
{
    //是否有疯狂星期一的任务
    [TopicPublicModel GetisMandayDataSuccess:^(id data) {
        
        TopicPublicModel *model = data;
        if(model.status == 1)
        {
            [DataManager sharedManager].IS_Monday = model.isMonday==1?YES:NO;
            
            if(model.sup_day==1 || model.fri_win==1)
            {
                [DataManager sharedManager].is_friendShare_day = YES;
            }
            
            [DataManager sharedManager].is_SuperZeroShop = model.zero_buy==1?YES:NO;
            [DataManager sharedManager].is_rawardDouble = model.monthly==1?YES:NO;
            [DataManager sharedManager].is_thousandYunRed = model.red_rain==1?YES:NO;
        }
    }];
}

#pragma mark 获取是否是1元购
- (void)httpGetOneYuan
{
    [OneYuanModel GetOneYuanDataSuccess:^(id data) {
        
        OneYuanModel *model = data;
        OneYuanDataModel *dataModel = model.data;
        if(model.status == 1)
        {
            [DataManager sharedManager].is_OneYuan = dataModel.app_status ==0?YES:NO;
            [DataManager sharedManager].app_every = dataModel.app_every;
            [DataManager sharedManager].app_zero = dataModel.app_zero;
        }
    }];
}

#pragma mark 获取是否有红包抽奖资格
- (void)httpGetRedMoney
{
    [[APIClient sharedManager]netWorkGeneralRequestWithApi:@"order/getOrderRaffleNum?" caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
        if (response.status == 1) {
            if([data[@"data"] integerValue] < 0)
            {
                [DataManager sharedManager].is_RedMoney = NO;
            }else{
                [DataManager sharedManager].is_RedMoney = YES;
                
                [[NSUserDefaults standardUserDefaults]setObject:data[@"data"] forKey:@"RedMoneyLeastNum"];
            }
        }else{
            [DataManager sharedManager].is_RedMoney = NO;
        }
    } failure:^(NSError *error) {
        [DataManager sharedManager].is_RedMoney = NO;
    }];
}

#pragma mark 获取赚钱页是否隐藏
- (void)httpMakeMoneyShow
{
    NSString *apistr = [NSString stringWithFormat:@"cfg/getlandingPage8778?appVersion=%@&",[DataManager sharedManager].appversion];

    [[APIClient sharedManager]netWorkGeneralRequestWithApi:apistr caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
        if (response.status == 1) {
            if([data[@"data"] integerValue] == 1)//data 0不隐藏 1隐藏
            {
                [DataManager sharedManager].is_MakeMoneyHiden = YES;
            }
        }
    } failure:^(NSError *error) {

    }];
}
#pragma mark 商品属性，分类，标签网络请求
-(void)httpSortRequest
{
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *type_data     = [userdefaul objectForKey:TYPE_DATA];
    NSString *tag_data      = [userdefaul objectForKey:TAG_DATA];
    NSString *type_tag_data = [userdefaul objectForKey:TYPE_TAG_DATA];
    NSString *supp_label_data = [userdefaul objectForKey:@"supp_label_data"];
    NSString *hot_tag = [userdefaul objectForKey:@"friend_circle_tag"];
    
    if((!type_data))
    {
        type_data =ktype_data;
    }
    if ((!tag_data))
    {
        tag_data = ktag_data;
    }
    if(!type_tag_data||type_tag_data.length==0)
    {
        type_tag_data = ktype_tag_data;
    }
    if (!supp_label_data||supp_label_data.length==0) {
        supp_label_data = ksupp_label_data;
    }
    if (!hot_tag||hot_tag.length==0) {
        hot_tag = khot_tag;
    }
    
    NSString *url=[NSString stringWithFormat:@"%@shop/queryTA?version=%@&type_data=%@&tag_data=%@&type_tag_data=%@&bool=true&supp_label_data=%@&friend_circle_tag_data=%@",[NSObject baseURLStr],VERSION,type_data,tag_data,type_tag_data,supp_label_data,hot_tag];
    
//    NSString *url=[NSString stringWithFormat:@"%@shop/queryTA?version=%@&type_data=%@&tag_data=%@&type_tag_data=%@&bool=true&supp_label_data=%@&friend_circle_tag_data=%@",[NSObject baseURLStr],VERSION,@"",@"",@"",@"",@""];

    
    NSString *URL=[MyMD5 authkey:url];
    NSURL *httpUrl=[NSURL URLWithString:URL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpUrl];
    request.timeoutInterval = 3;
    NSError *error = nil;
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];

    if (data) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        MyLog(@"\n*****************\nresponseObject: %@ \n*****************\n", responseObject);
        
        responseObject = [NSDictionary changeType:responseObject];
        if(responseObject !=nil || ![responseObject isEqual:[NSNull null]])
        {
            NSString *statu=responseObject[@"status"];
            NSString *type_data1=[NSString stringWithFormat:@"%@",responseObject[@"type_data"]];
            NSString *attr_data1=[NSString stringWithFormat:@"%@",responseObject[@"attr_data"]];
            NSString *tag_data1=[NSString stringWithFormat:@"%@",responseObject[@"tag_data"]];
            NSString *type_tag_data1=[NSString stringWithFormat:@"%@",responseObject[@"type_tag_data"]];
            NSString *supp_label_data=[NSString stringWithFormat:@"%@",responseObject[@"supp_label_data"]];
            NSString *friend_circle_tag_data=[NSString stringWithFormat:@"%@",responseObject[@"friend_circle_tag_data"]];

            if(statu.intValue==1)
            {

                //签到商品集合
                if([responseObject[@"shopGroupList"] count])
                {
                    [self deleteTable:@"shopGroupList"];

                    [self inserttype_tagIntoDB:responseObject[@"shopGroupList"] Type:@"shopGroupList"];

                }

                //热门标签
                
                if (![responseObject[@"friend_circle_tag"] isEqual:[NSNull null]]&&
                    ![responseObject[@"friend_circle_tag"] isEqual:[NSNull null]] && responseObject[@"friend_circle_tag"]!=nil) {
                    if([responseObject[@"friend_circle_tag"] count])
                    {
                        [self deleteTable:@"HotTagData"];
                        
                        BOOL result = [self inserttype_tagIntoDB:responseObject[@"friend_circle_tag"] Type:@"friend_circle_tag"];
                        result==YES?[userdefaul setObject:friend_circle_tag_data forKey:@"friend_circle_tag_data"]:nil;
                    }
                }
            
                //品牌分类
                if (![responseObject[@"supp_label"] isEqual:[NSNull null]]&&
                    ![responseObject[@"supp_label"] isEqual:[NSNull null]] && responseObject[@"supp_label"]!=nil) {
                    if([responseObject[@"supp_label"] count])
                    {
                        [self deleteTable:@"BRANDSDATA"];
                        
                        BOOL result = [self inserttype_tagIntoDB:responseObject[@"supp_label"] Type:@"supplabel"];
                        result==YES?[userdefaul setObject:supp_label_data forKey:@"supp_label_data"]:nil;
                    }
                }
                
                //商品分类
                if (![responseObject[@"type_data"] isEqual:[NSNull null]]&&
                    ![responseObject[@"shop_type"] isEqual:[NSNull null]] && responseObject[@"shop_type"]!=nil) {
                    if([responseObject[@"shop_type"] count])
                    {
                   
                        [self deleteTable:@"TYPDB"];
                        
                        BOOL result = [self inserttype_tagIntoDB:responseObject[@"shop_type"] Type:@"shop_type"];
                        result==YES?[userdefaul setObject:type_data1 forKey:TYPE_DATA]:nil;
                    }
                }
                
                //商品属性
                if (![responseObject[@"shop_attr"] isEqual:[NSNull null]] && responseObject[@"shop_attr"]!=nil) {
                    if([responseObject[@"shop_attr"]count])
                    {
                        [self deleteTable:@"ATTDB"];
                        
                        BOOL result = [self inserttype_tagIntoDB:responseObject[@"shop_attr"] Type:@"shop_attr"];
                        result==YES?[userdefaul setObject:attr_data1 forKey:ATTR_DATA]:nil;
                    }
                }
                
                //分类标签
                if (![responseObject[@"type_data"] isEqual:[NSNull null]] &&
                    ![responseObject[@"type_tag"] isEqual:[NSNull null]] && responseObject[@"type_tag"]!=nil)
                {
                    if([responseObject[@"type_tag"]count])
                    {
                        [self deleteTable:@"TYPE_TAGDB"];
                        
                        BOOL result = [self inserttype_tagIntoDB:responseObject[@"type_tag"] Type:@"type_tag"];
                        
                        result==YES?[userdefaul setObject:type_tag_data1 forKey:TYPE_TAG_DATA]:nil;
                    }
                }

                //商品标签
                if (![responseObject[@"tag_data"] isEqual:[NSNull null]] &&
                    ![responseObject[@"shop_tag"] isEqual:[NSNull null]] && responseObject[@"shop_tag"]!=nil) {
                    if([responseObject[@"shop_tag"]count])
                    {
                        [self deleteTable:@"TAGDB"];
                        
                        BOOL result = [self inserttype_tagIntoDB:responseObject[@"shop_tag"] Type:@"shop_tag"];
                        
                        result==YES?[userdefaul setObject:tag_data1 forKey:TAG_DATA]:nil;
                    }
                }
                
             }
        }
        
    } else {
        self.isFaild = YES;
        MyLog(@"%@",error);
    }
}

#pragma mark 获取客服ID
- (void)getPTEID
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:USER_TOKEN];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    url=[NSString stringWithFormat:@"%@user/getCustomerService?version=%@&token=%@&type=2",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            if(statu.intValue==1)//请求成功
            {
                NSString* pteid = [NSString stringWithFormat:@"%@",responseObject[@"id"]];
                
                if(pteid.length>0)
                {
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    [user setObject:pteid forKey:PTEID];
                    
                }else{
                    
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    [user setObject:@"915" forKey:PTEID];
                    
                }
                
            }else{
                
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setObject:@"915" forKey:PTEID];
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:@"915" forKey:PTEID];
    }];
    
    
}

#pragma mark  推送统计
-(void)PushStatisticsCodetype:(NSString*)codetype Messageid:(NSString*)message_id
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSString *url=[NSString stringWithFormat:@"%@initiateApp/pushMsgDataCount?version=%@&code_type=%@&message_id=%@",[NSObject baseURLStr],VERSION,codetype,message_id];
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if ([responseObject[@"status"] intValue] == 1) {
            MyLog(@"点击***********成功");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)getVitalityGradeHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];

    NSString *url=[NSString stringWithFormat:@"%@vitality/v.json",[NSObject baseURLStr_Upy]];
    manager.requestSerializer.cachePolicy=NSURLRequestReloadIgnoringLocalAndRemoteCacheData;

    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        MyLog(@"responseObject: %@", responseObject);
        
        NSDictionary *dic=responseObject;
        NSMutableArray*valuesArr = [NSMutableArray array];

        NSArray *keyArr = [[dic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
       
        [keyArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [valuesArr addObject:responseObject[obj]];
        }];
        
        NSMutableArray *gradeKeyValueArr=[NSMutableArray array];
        [valuesArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *arr = [(NSString *)obj componentsSeparatedByString:@","];
            
            if ([arr[0]rangeOfString:@"-"].location==NSNotFound) {
                [gradeKeyValueArr addObject:[NSString stringWithFormat:@"%@,%@",arr[0],arr[1]]];
            }else
                [gradeKeyValueArr addObject:[NSString stringWithFormat:@"%@,%@",[arr[0] substringToIndex:[arr[0] rangeOfString:@"-"].location],arr[1]]];
        }];
        [[NSUserDefaults standardUserDefaults]setObject:gradeKeyValueArr forKey:@"gradeKeyValue"];

        MyLog(@" %@ gradeKeyValue: %@",keyArr, [[NSUserDefaults standardUserDefaults]objectForKey:@"gradeKeyValue"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"error: %@", error);
        
    }];
}
//商品详情图片压缩比
- (void)getShopProportion
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSString *url=[NSString stringWithFormat:@"%@shop/getImgRate?version=%@",[NSObject baseURLStr],VERSION];
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        if ([responseObject[@"status"] intValue] == 1) {
            if(responseObject[@"img_rate"] != nil)
            {
                 [DataManager sharedManager].img_rate = [responseObject[@"img_rate"] intValue];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark ************************数据库处理***************************
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

#pragma mark 完整的数据库插入
- (BOOL)inserttype_tagIntoDB:(NSArray*)dataArr Type:(NSString*)str;
{
    BOOL result = NO;
    
    if ([self OpenDb])
    {
        //检测表是否存在
        sqlite3_stmt *statement = nil;
        char *sqlChar = "Select Count(rowid) From sqlite_master Where tbl_name=\"DocFile\"";
        if (sqlite3_prepare_v2(AttrcontactDB, sqlChar, -1, &statement, NULL) != SQLITE_OK)
        {
            //Error:failed to Select Count(rowid) From sqlite_master Where tbl_name=\"DocFile\"");
            sqlite3_finalize(statement);
            [self closeDB];
            return result;
        }
        
        BOOL isExist = NO;
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int count = sqlite3_column_int(statement, 0);
            if (count > 1) {
                isExist = YES;
            }
        }
        sqlite3_finalize(statement);
        
        //不存在则创建表
        if (!isExist) {
            sqlite3_stmt *statement2 = nil;
            char *sqlChar2 = "Create Table If Not Exists DocFile (myId Integer Primary Key, id int default 0, title varchar default \"\", directory varchar default \"\", fileUrl varchar default \"\")";
            if (sqlite3_prepare_v2(AttrcontactDB, sqlChar2, -1, &statement2, NULL) != SQLITE_OK) {
                //Error:failed to Create Table If Not Exists DocFile");
                sqlite3_finalize(statement2);
                [self closeDB];
                return result;
            }
            if (sqlite3_step(statement2) != SQLITE_DONE) {
                //Create Table If Not Exists DocFile failed");
            }
            
            sqlite3_finalize(statement2);
        }
        
        //清除数据
        char *emptySql = "Delete From DocFile";
        int status = sqlite3_exec(AttrcontactDB, emptySql, NULL, NULL, NULL);
        if (status != SQLITE_OK) {
            //清除本地文件表失败");
            [self closeDB];
            return result;
        }
        
        const char *dbpath = [_databasePath UTF8String];


        //插入数据
        if ([str isEqualToString:@"shopGroupList"]) {//签到商品集合

            // {"id":2,"value":"type1=2","icon":"sign_in/icon/20170808t4j8F0F3.png","app_name":"美丽上衣"},
            for(NSDictionary *dic in dataArr) {
                if(dic !=nil || ![dic isEqual:[NSNull null]]) {
                    if (sqlite3_open(dbpath, & AttrcontactDB)==SQLITE_OK) {

                        _sql_stmt = "CREATE TABLE IF NOT EXISTS shopGroupList(ID INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,value TEXT,icon TEXT,banner TEXT)";
                        _type_id=[NSString stringWithFormat:@"%@",dic[@"id"]];
                        _type_tag_class_name=[NSString stringWithFormat:@"%@",dic[@"app_name"]];
                        _tag_show=[NSString stringWithFormat:@"%@",dic[@"value"]];
                        _type_tag_type=[NSString stringWithFormat:@"%@",dic[@"icon"]];
                        _type_ico=[NSString stringWithFormat:@"%@",dic[@"banner"]];
                        char *errMsg;

                        if (sqlite3_exec(AttrcontactDB, _sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK)                        {
                        }

                        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO shopGroupList (ID,name,value,icon,banner) VALUES(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",
                                               _type_id,
                                               _type_tag_class_name,
                                               _tag_show,
                                               _type_tag_type,
                                               _type_ico
                                               ];
                        const char *insert_stmt = [insertSQL UTF8String];
                        sqlite3_prepare_v2(AttrcontactDB, insert_stmt, -1, &statement, NULL);
                        if (sqlite3_step(statement)==SQLITE_DONE) {

                        }
                        else{

                        }
                        sqlite3_finalize(statement);
                        sqlite3_close(AttrcontactDB);
                    }
                }
            }


        }else
        if([str isEqualToString:@"friend_circle_tag"]){//热门标签
            for(NSDictionary *dic in dataArr)
            {
                if(dic !=nil || ![dic isEqual:[NSNull null]])
                {
                    
                    if (sqlite3_open(dbpath, & AttrcontactDB)==SQLITE_OK) {
                        
                        _sql_stmt = "CREATE TABLE IF NOT EXISTS HotTagData(ID INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,isShow TEXT,type TEXT,sort TEXT)";
                        _type_id=[NSString stringWithFormat:@"%@",dic[@"id"]];
                        _type_tag_class_name=[NSString stringWithFormat:@"%@",dic[@"name"]];
                        _tag_show=[NSString stringWithFormat:@"%@",dic[@"is_show"]];
                        _type_tag_type=[NSString stringWithFormat:@"%@",dic[@"type"]];
                        _type_tag_sort=[NSString stringWithFormat:@"%@",dic[@"sort"]];
                        char *errMsg;
                        
                        if (sqlite3_exec(AttrcontactDB, _sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK)
                        {
                            
                            //__________");
                        }
                        
                        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO HotTagData (ID,name,isShow,type,sort) VALUES(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",
                                               _type_id,
                                               _type_tag_class_name,
                                               _tag_show,
                                               _type_tag_type,
                                               _type_tag_sort
                                               ];
                        const char *insert_stmt = [insertSQL UTF8String];
                        sqlite3_prepare_v2(AttrcontactDB, insert_stmt, -1, &statement, NULL);
                        if (sqlite3_step(statement)==SQLITE_DONE) {
                            
                        }
                        else
                        {
                            
                        }
                        sqlite3_finalize(statement);
                        sqlite3_close(AttrcontactDB);
                    }
                }
            }
        }else
        if([str isEqualToString:@"supplabel"]){
            for(NSDictionary *dic in dataArr)
            {
                if(dic !=nil || ![dic isEqual:[NSNull null]])
                {
                    
                    if (sqlite3_open(dbpath, & AttrcontactDB)==SQLITE_OK) {
                        
//                        _sql_stmt = "CREATE TABLE IF NOT EXISTS BRANDSDATA(ID INTEGER PRIMARY KEY AUTOINCREMENT,addtime TEXT,icon TEXT,pic TEXT,name TEXT,remark TEXT,sort TEXT)";
                        _sql_stmt = "CREATE TABLE IF NOT EXISTS BRANDSDATA(ID INTEGER PRIMARY KEY AUTOINCREMENT,addtime TEXT,icon TEXT,pic TEXT,name TEXT,sort TEXT,remark TEXT,type TEXT)";

                        _type_id=[NSString stringWithFormat:@"%@",dic[@"id"]];
                        _type_tag_is_new=[NSString stringWithFormat:@"%@",dic[@"add_time"]];
                        _type_ico=[NSString stringWithFormat:@"%@",dic[@"icon"]];
                        _type_tag_pic=[NSString stringWithFormat:@"%@",dic[@"pic"]];
                        _type_tag_class_name=[NSString stringWithFormat:@"%@",dic[@"name"]];
                        _type_sequence=[NSString stringWithFormat:@"%@",dic[@"type"]];
                        //去掉转义字符\"
                        NSString *responseString = [NSString stringWithString:dic[@"remark"]];
                        responseString = [responseString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                        _type_tag_type=responseString;
                        _type_tag_sort=[NSString stringWithFormat:@"%@",dic[@"sort"]];
                        char *errMsg;
                        
                        if (sqlite3_exec(AttrcontactDB, _sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK)
                        {
                            
                            //__________");
                        }
                        
//                        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO BRANDSDATA (ID,addtime,icon,pic,name,remark,sort) VALUES(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",_type_id,_type_tag_is_new,_type_ico,_type_tag_pic,_type_tag_class_name,_type_tag_type,_type_tag_sort];
                        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO BRANDSDATA (ID,addtime,icon,pic,name,sort,remark,type) VALUES(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",_type_id,_type_tag_is_new,_type_ico,_type_tag_pic,_type_tag_class_name,_type_tag_sort,_type_tag_type,_type_sequence];

                        const char *insert_stmt = [insertSQL UTF8String];
                        sqlite3_prepare_v2(AttrcontactDB, insert_stmt, -1, &statement, NULL);
                        if (sqlite3_step(statement)==SQLITE_DONE) {
                            
                        }
                        else
                        {
                            
                        }
                        sqlite3_finalize(statement);
                        sqlite3_close(AttrcontactDB);
                    }
                }
            }
        }else
        if([str isEqualToString:@"shop_tag"])//标签表
        {
            for(NSDictionary *dic2 in dataArr)
            {
                if(dic2 !=nil || ![dic2 isEqual:[NSNull null]])
                {
                    _tag_name=[NSString stringWithFormat:@"%@",dic2[@"tag_name"]];
                    _tag_id=[NSString stringWithFormat:@"%@",dic2[@"id"]];
                    _tag_show=[NSString stringWithFormat:@"%@",dic2[@"is_show"]];
                    _tag_parent_id=[NSString stringWithFormat:@"%@",dic2[@"parent_id"]];
                    _tag_ico=[NSString stringWithFormat:@"%@",dic2[@"ico"]];
                    _tag_sequence=[NSString stringWithFormat:@"%@",dic2[@"sequence"]];
                    _tag_e_name=[NSString stringWithFormat:@"%@",dic2[@"e_name"]];
                   
                    if (sqlite3_open(dbpath, & AttrcontactDB)==SQLITE_OK) {
                        
                        _sql_stmt = "CREATE TABLE IF NOT EXISTS TAGDB(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT,PHONE TEXT,ICO TEXT,SEQUENCE TEXT,ENAME TEXT)";
                        
                        char *errMsg;
                        
                        
                        if (sqlite3_exec(AttrcontactDB, _sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK)
                        {
                            
                            //__________");
                        }
                        
                        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO TAGDB (ID,name,address,phone,ico,sequence,ename) VALUES(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",_tag_id,_tag_name,_tag_parent_id,_tag_show,_tag_ico, _tag_sequence,_tag_e_name];
                        const char *insert_stmt = [insertSQL UTF8String];
                        sqlite3_prepare_v2(AttrcontactDB, insert_stmt, -1, &statement, NULL);
                        if (sqlite3_step(statement)==SQLITE_DONE) {
                            
                        }
                        else
                        {
                            
                        }
                        sqlite3_finalize(statement);
                        sqlite3_close(AttrcontactDB);
                    }
                }
            }
        }else if ([str isEqualToString:@"type_tag"])//新分类标签表
        {
            for(NSDictionary *dic in dataArr)
            {
                if(dic !=nil || ![dic isEqual:[NSNull null]])
                {
                    _type_tag_id = [NSString stringWithFormat:@"%@",dic[@"id"]];
                    _type_tag_class_name = [NSString stringWithFormat:@"%@",dic[@"class_name"]];
                    _type_tag_sort  = [NSString stringWithFormat:@"%@",dic[@"sort"]];
                    _type_tag_pic   = [NSString stringWithFormat:@"%@",dic[@"pic"]];
                    _type_tag_type  = [NSString stringWithFormat:@"%@",dic[@"type"]];
                    _type_tag_is_hot   = [NSString stringWithFormat:@"%@",dic[@"is_hot"]];
                    _type_tag_is_new= [NSString stringWithFormat:@"%@",dic[@"is_new"]];
                    _class_type=[NSString stringWithFormat:@"%@",dic[@"class_type"]];
                    
                    if (sqlite3_open(dbpath, & AttrcontactDB)==SQLITE_OK) {
                        
                        _sql_stmt = "CREATE TABLE IF NOT EXISTS TYPE_TAGDB(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, SORT TEXT,PIC TEXT,ISHOT TEXT,ISNEW TEXT,TYPE TEXT,CLASSTYPE TEXT)";
                        
                        char *errMsg;
                        
                        if (sqlite3_exec(AttrcontactDB, _sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK)
                        {
                            
                            //__________");
                        }
                        
                        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO TYPE_TAGDB (ID,name,sort,pic,ishot,isnew,type,classtype) VALUES(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",_type_tag_id,_type_tag_class_name,_type_tag_sort,_type_tag_pic,_type_tag_is_hot, _type_tag_is_new,_type_tag_type,_class_type];
                        const char *insert_stmt = [insertSQL UTF8String];
                        sqlite3_prepare_v2(AttrcontactDB, insert_stmt, -1, &statement, NULL);
                        if (sqlite3_step(statement)==SQLITE_DONE) {
                            
                        }
                        else
                        {
                            
                        }
                        sqlite3_finalize(statement);
                        sqlite3_close(AttrcontactDB);
                    }
                }
            }
        }else if ([str isEqualToString:@"shop_attr"])//商品属性
        {
            for(NSDictionary *dic in dataArr)
            {
                if(dic !=nil || ![dic isEqual:[NSNull null]])
                {
                    _shuxing_id=[NSString stringWithFormat:@"%@",dic[@"id"]];
                    _attr_name=[NSString stringWithFormat:@"%@",dic[@"attr_name"]];
                    _attr_Parent_id=[NSString stringWithFormat:@"%@",dic[@"parent_id"]];
                    _is_show=[NSString stringWithFormat:@"%@",dic[@"sequence"]];
                    
                    if (sqlite3_open(dbpath, & AttrcontactDB)==SQLITE_OK) {
                        
                        _sql_stmt = "CREATE TABLE IF NOT EXISTS ATTDB(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT,PHONE TEXT)";
                        char *errMsg;
                        
                        
                        if (sqlite3_exec(AttrcontactDB, _sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK)
                        {
                            
                            //__________");
                        }
                        
                        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO ATTDB (ID,name,address,phone) VALUES(\"%@\",\"%@\",\"%@\",\"%@\")",_shuxing_id,_attr_name,_attr_Parent_id,_is_show];
                        const char *insert_stmt = [insertSQL UTF8String];
                        sqlite3_prepare_v2(AttrcontactDB, insert_stmt, -1, &statement, NULL);
                        if (sqlite3_step(statement)==SQLITE_DONE) {
                            
                        }
                        else
                        {
                            
                        }
                        sqlite3_finalize(statement);
                        sqlite3_close(AttrcontactDB);
                    }
                }
            }
        }else if ([str isEqualToString:@"shop_type"])//商品分类
        {
            for(NSDictionary *dic1 in dataArr)
            {
                if(dic1 !=nil || ![dic1 isEqual:[NSNull null]])
                {
                    NSLog(@"responseObject=%@",dic1[@"type_name"]);
//                    if(![dic1[@"type_name"] isEqualToString:@"外套"])
                    {
                        _dir_level=[NSString stringWithFormat:@"%@",dic1[@"dir_level"]];
                        _type_id=[NSString stringWithFormat:@"%@",dic1[@"id"]];
                        _type_parent_id=[NSString stringWithFormat:@"%@",dic1[@"parent_id"]];
                        _type_name=[NSString stringWithFormat:@"%@",dic1[@"type_name"]];
                        _type_ico=[NSString stringWithFormat:@"%@",dic1[@"ico"]];
                        _type_is_show=[NSString stringWithFormat:@"%@",dic1[@"is_show"]];
                        _type_sequence = [NSString stringWithFormat:@"%@",dic1[@"sequence"]];
                        _type_group_flag = [NSString stringWithFormat:@"%@",dic1[@"group_flag"]];
                        
                        if (sqlite3_open(dbpath, & AttrcontactDB)==SQLITE_OK) {
                            
                            _sql_stmt = "CREATE TABLE IF NOT EXISTS TYPDB(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT,PHONE TEXT,ICO TEXT,SEQUENCE TEXT,ISSHOW TEXT,GROUPFLAG TEXT)";
                            char *errMsg;
                            
                            if (sqlite3_exec(AttrcontactDB, _sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK)
                            {
                                
                                //__________");
                            }
                            
                            NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO TYPDB (ID,name,address,phone,ico,sequence,isshow,groupflag) VALUES(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",_type_id,_type_name,_type_parent_id,_dir_level,_type_ico,_type_sequence,_type_is_show,_type_group_flag];
                            
                            const char *insert_stmt = [insertSQL UTF8String];
                            sqlite3_prepare_v2(AttrcontactDB, insert_stmt, -1, &statement, NULL);
                            if (sqlite3_step(statement)==SQLITE_DONE) {
                                
                            }
                            else
                            {
                                
                            }
                            sqlite3_finalize(statement);
                            sqlite3_close(AttrcontactDB);
                        }

                    }
                }
            }
        }
        
        result = YES;
        [self closeDB];
    }
    
    return result;
}

#pragma mark 删除数据库
-(void)deleteTable:(NSString*)tableName
{
    
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
            
            char *errorMsg;
            //删除表
            NSString * str = [NSString stringWithFormat:@"DROP TABLE %@",tableName];
            
            const  char* sqlStatement  = [str UTF8String];
            int returnCode  =  sqlite3_exec(AttrcontactDB,  sqlStatement,  NULL,  NULL,  &errorMsg);
            if(returnCode!=SQLITE_OK)  {
                　　fprintf(stderr,
                          "Error  in  dropping  table  stocks.  Error:  %s",  errorMsg);
            }
            
        }
        
    }
}

#pragma mark 查找数据库
-(NSDictionary *)FindNameForTPYEDB:(NSString *)findStr
{
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
                    
                    
                    if(ID !=nil || ![ID isEqualToString:@"<null>"])
                    {
                        [mudic setValue:ID forKey:@"id"];
                    }
                    
                    if(name !=nil || ![name isEqualToString:@"<null>"])
                    {
                        [mudic setValue:name forKey:@"name"];
                    }
                    
                    if(ico !=nil || ![ico isEqualToString:@"<null>"])
                    {
                        [mudic setValue:ico forKey:@"ico"];
                    }
                    
                    
                    if(sequence !=nil || ![sequence isEqualToString:@"<null>"])
                    {
                        [mudic setValue:sequence forKey:@"sequence"];
                    }
                    
                    
                    if(isShow !=nil || ![isShow isEqualToString:@"<null>"])
                    {
                        [mudic setValue:isShow forKey:@"isShow"];
                    }
                    
                    
                    if(groupflag !=nil || ![groupflag isEqualToString:@"<null>"])
                    {
                        [mudic setValue:groupflag forKey:@"groupFlag"];
                    }
                    
                    break;
                    
                }
                
                sqlite3_finalize(statement);
            }
            sqlite3_close(AttrcontactDB);
        }
        
    }
    
    return mudic;
}

#pragma mark *****************支付回调*******************
#pragma mark 支付宝支付结果
-(void)payFinished:(NSDictionary*)result
{
    switch([[result objectForKey:@"resultStatus"] integerValue]){
            
        case 9000://操作成功
        {
            [self gotobuySuccess];
        }
            break;
        case 4000://系统异常
        {
            [self gotobuyfail];
        }
            break;
        default:
            [self gotobuyfail];
            break;
    }
    
}

#pragma mark 微信支付结果回调
-(void) onResp:(BaseResp*)resp
{
    //0成功 -1错误 -2取消
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];

        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                //支付成功－PaySuccess，retcode = %d", resp.errCode);
                [self gotobuySuccess];
                break;

            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                //错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);

                [self gotobuyfail];

                break;
        }
    }
    
    
}
-(void)gotobuySuccess
{
    //注册通知
    
    NSNotification *notification=[NSNotification notificationWithName:@"buysuccess" object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

- (void)gotobuyfail
{
    MyLog(@"支付失败");
    
    NSNotification *notification=[NSNotification notificationWithName:@"buyfail" object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}


#pragma mark ************************分享部分***************************
#pragma mark 分享
- (void)shardk
{
    [ShareSDK registerApp:@"692d2b7c818a"];//字符串api20为您的ShareSDK的AppKey

    //添加新浪微博应用 注册网址 http://open.weibo.com
    //注册应用时就必须在高级信息里填写回调页地址


    [ShareSDK connectSinaWeiboWithAppKey:@"1893870278"
                               appSecret:@"0fbafbea8a04dcc09af7f641827f2e1f"
                             redirectUri:@"http://www.baidu.com"];


    NSString *str =@"52yifu.com";
    NSString *url = [NSString stringWithFormat:@"%@",[NSObject baseURLStr]];
    NSRange range =[url rangeOfString:str];

    if(range.length>0)//外环境
    {
        [ShareSDK connectWeChatWithAppId:@"wx8c5fe3e40669c535"
                               appSecret:@"10d080a714d768427242e9b091d33959"
                               wechatCls:[WXApi class]];
    }else{
        [ShareSDK connectWeChatWithAppId:@"wxbb9728502635a425"
                               appSecret:@"d4624c36b6795d1d99dcf0547af5443d"
                               wechatCls:[WXApi class]];
    }


    [ShareSDK connectQQWithQZoneAppKey:@"1104724623"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];

    [ShareSDK connectQZoneWithAppKey:@"1104724623"
                           appSecret:@"VpAQVytFGidSRx6l"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];

    //导入QQ互联和QQ好友分享需要的外部库类型，如果不需要QQ空间SSO和QQ好友分享可以不调用此方法
    [ShareSDK importQQClass:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];
    
    
}

#pragma mark 分享成功回调统计分享次数
- (void)shareSuccess
{
    NSString *key = nil;
    if ([DataManager sharedManager].shareTabType == StatisticalTabTypeShop) {
        key = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
    } else {
        key = [DataManager sharedManager].key;
    }
    [YFShareModel getShareModelWithKey:key type:[DataManager sharedManager].shareType tabType:[DataManager sharedManager].shareTabType success:^(YFShareModel *data) {
        if (data.status == 1) {
        }
    }];
    //统计完清空
    [DataManager sharedManager].key = nil;
    [DataManager sharedManager].shareType = 0;
    [DataManager sharedManager].shareTabType = 0;
    
}

#pragma mark ************************推送跳转***************************
#pragma mark 友盟推送
- (void)UMPUSH:(NSDictionary*)launchOptions
{
    
    [UMessage startWithAppkey:@"5656d6d467e58ea3060005e2" launchOptions:launchOptions];
    [UMessage registerForRemoteNotifications];
    
    [UMessage setLogEnabled:YES];
    
}

#pragma mark 推送消息相关界面跳转
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    MyLog(@"userInfo: %@", userInfo);
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    
    completionHandler(UIBackgroundFetchResultNewData);
    
    //关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    
    [UMessage didReceiveRemoteNotification:userInfo];
    
    //接收到推送--------:%@", userInfo/*推送内容*/);
    
    if(application.applicationState == UIApplicationStateActive)
    {
        if ([userInfo[@"open_type"] integerValue]==6)
        {
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSInteger num = [user integerForKey:@"TOPICMESSAGE"];
            [user setInteger:num+1 forKey:@"TOPICMESSAGE"];
        }
    
        //夺宝开奖中奖信息
        if([userInfo[@"open_type"] integerValue]==2 && [userInfo[@"is_list"] integerValue]==9)
        {
            [[DataManager sharedManager] getduobaoStatueHttp];
        }
        return;
    }
   
    if([userInfo[@"open_type"] integerValue]==1)
    {
        
    }else if ([userInfo[@"open_type"] integerValue]==2)//APP指定页面
    {
        if ([userInfo[@"is_list"] integerValue]==1)//筛选列表页
        {
            MyLog(@"列表");
            
            NSString *shopcode = userInfo[@"keyword"];
            
            if ([shopcode hasPrefix:@"type2"]) {//按ID筛选
                
                NSArray *typeArr = [shopcode componentsSeparatedByString:@"="];
                NSString *idStr = [typeArr lastObject];
                
                NSDictionary *type2Dic = [self FindNameForTPYEDB:idStr];
                
                NSString *ID = type2Dic[@"id"];
                NSString *title = type2Dic[@"name"];
                
                TFSearchViewController *svc = [[TFSearchViewController alloc] init];
                svc.parentID = ID;
                svc.shopTitle = title;
                
                svc.hidesBottomBarWhenPushed=YES;
                
                Mtarbar.selectedIndex=0;
                UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[0];
                nv.navigationBarHidden = YES;
                [nv pushViewController:svc animated:YES];
                
            }
            else {//按属性筛选
                
                TFScreenViewController *screen = [[TFScreenViewController alloc]init];
                screen.muStr = shopcode;
                
                screen.index = 1;
                screen.titleText = @"筛选结果";
                screen.hidesBottomBarWhenPushed=YES;
                
                Mtarbar.selectedIndex=0;
                UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[0];
                nv.navigationBarHidden = YES;
                [nv pushViewController:screen animated:YES];
                
            }
        
        }else if ([userInfo[@"is_list"] integerValue]==2)//商品详情页
        {
            MyLog(@"详情");
            if([userInfo[@"shop_type"] integerValue] == 1)//普通商品详情页
            {
                ShopDetailViewController *detail=[[ShopDetailViewController alloc] init];
                
                detail.shop_code = userInfo[@"keyword"];
                
                detail.hidesBottomBarWhenPushed=YES;
                
                Mtarbar.selectedIndex=0;
                UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[0];
                nv.navigationBarHidden = YES;
                [nv pushViewController:detail animated:YES];
                
            }else if([userInfo[@"shop_type"] integerValue] == 2){//套餐商品详情页
                
//                ComboShopDetailViewController *detail=[[ComboShopDetailViewController alloc] init];
//                
//                detail.shop_code = userInfo[@"keyword"];
//                
//                detail.hidesBottomBarWhenPushed=YES;
//                
//                Mtarbar.selectedIndex=0;
//                UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[0];
//                nv.navigationBarHidden = YES;
//                [nv pushViewController:detail animated:YES];
            }else if ([userInfo[@"shop_type"] integerValue] == 3)//搭配详情页
            {
                CollocationDetailViewController *collcationVC =[[CollocationDetailViewController alloc]init];
                collcationVC.collocationCode = userInfo[@"keyword"];
                collcationVC.shopCodes = nil;
                collcationVC.collcationModel = nil;
                collcationVC.hidesBottomBarWhenPushed= YES;
                
                Mtarbar.selectedIndex=0;
                UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[0];
                nv.navigationBarHidden = YES;
                [nv pushViewController:collcationVC animated:YES];
                
            }
        }else if ([userInfo[@"is_list"] integerValue]==3)//搜索
        {
            NSString *shopcode = userInfo[@"keyword"];
            
            if ([shopcode hasPrefix:@"type2"]) {//按ID筛选
                
                NSArray *typeArr = [shopcode componentsSeparatedByString:@"="];
                NSString *idStr = [typeArr lastObject];
                
                NSDictionary *type2Dic = [self FindNameForTPYEDB:idStr];
                
                NSString *ID = type2Dic[@"id"];
                NSString *title = type2Dic[@"name"];
                
                TFSearchViewController *svc = [[TFSearchViewController alloc] init];
                svc.parentID = ID;
                svc.shopTitle = title;
                
                svc.hidesBottomBarWhenPushed=YES;
                
                Mtarbar.selectedIndex=0;
                UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[0];
                nv.navigationBarHidden = YES;
                [nv pushViewController:svc animated:YES];
            }
    }else if ([userInfo[@"is_list"] integerValue]==4)//消息盒子
        {
            
//            ChatListViewController *chatlist=[[ChatListViewController alloc]init];
//
//            chatlist.hidesBottomBarWhenPushed=YES;
//
//            Mtarbar.selectedIndex=4;
//            UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[4];
//            nv.navigationBarHidden = YES;
//
//            [nv presentViewController:chatlist animated:YES completion:^{
//
//            }];
            
        }else if ([userInfo[@"is_list"] integerValue]==5)//返现列表
        {
            
            TFAccountDetailsViewController *account = [[TFAccountDetailsViewController alloc]init];
            account.hidesBottomBarWhenPushed = YES;
            account.comefrom = @"消息推送";
            
            Mtarbar.selectedIndex=4;
            UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[4];
            nv.navigationBarHidden = YES;
            
            NSString *keyword = userInfo[@"keyword"];
            if(keyword.intValue == 1)
            {
                account.Toaccount = keyword;
                
            }else if (keyword.intValue == 2)
            {
                account.isfrozen = keyword;
            }
            
            [nv loginSuccess:^{
                
                [nv pushViewController:account animated:YES];
            }];
        }else if ([userInfo[@"is_list"] integerValue]==6)//退款列表
        {
            TFAccountDetailsViewController *account = [[TFAccountDetailsViewController alloc]init];
            account.hidesBottomBarWhenPushed = YES;
            account.comefrom = @"退款推送";
            
            Mtarbar.selectedIndex=4;
            UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[4];
            nv.navigationBarHidden = YES;
            
            [nv loginSuccess:^{
                
                [nv pushViewController:account animated:YES];
            }];

        }else if ([userInfo[@"is_list"] integerValue]==7)//待付款列表页
        {
            MyOrderViewController *myorder=[[MyOrderViewController alloc]init];
            myorder.tag=1000;
            myorder.status1=[NSString stringWithFormat:@"%zd",(myorder.tag+1)%1000];
            myorder.hidesBottomBarWhenPushed=YES;
           
            Mtarbar.selectedIndex=4;
            UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[4];
            nv.navigationBarHidden = YES;
            
            [nv loginSuccess:^{
                [nv pushViewController:myorder animated:YES];
            }];
        }else if ([userInfo[@"is_list"] integerValue]==8)//退款售后列表页面
        {
            AftersaleViewController *after=[[AftersaleViewController alloc]init];
            after.hidesBottomBarWhenPushed=YES;
            
            Mtarbar.selectedIndex=4;
            UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[4];
            nv.navigationBarHidden = YES;
            
            [nv loginSuccess:^{
                [nv pushViewController:after animated:YES];
            }];

        }else if ([userInfo[@"is_list"] integerValue]==9)//夺宝详情页
        {
            Mtarbar.selectedIndex=0;
            UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[0];
            nv.navigationBarHidden = YES;
            
            if([userInfo[@"shop_type"] integerValue] == 1)//普通商品
            {
            }else if ([userInfo[@"shop_type"] integerValue] == 2)//套餐商品
            {
            }else if ([userInfo[@"shop_type"] integerValue] == 3)//一分夺宝
            {
                IndianaDetailViewController *shopdetail=[[IndianaDetailViewController alloc]init];
                shopdetail.hidesBottomBarWhenPushed=YES;
                shopdetail.shop_code = userInfo[@"keyword"];;
                
                [nv loginSuccess:^{
                    [nv pushViewController:shopdetail animated:YES];
                }];

            }else if ([userInfo[@"shop_type"] integerValue] == 4)//一元夺宝
            {
                OneIndianaDetailViewController *shopdetail=[[OneIndianaDetailViewController alloc]init];
                shopdetail.hidesBottomBarWhenPushed=YES;
                shopdetail.shop_code = userInfo[@"keyword"];;
                
                [nv loginSuccess:^{
                    [nv pushViewController:shopdetail animated:YES];
                }];

            }else if ([userInfo[@"shop_type"] integerValue] == 5)//拼团夺宝
            {
                FightIndianaDetailViewController *shopdetail=[[FightIndianaDetailViewController alloc]init];
                shopdetail.hidesBottomBarWhenPushed=YES;
                NSArray *strarr = [userInfo[@"keyword"] componentsSeparatedByString:@","];
                if(strarr.count >= 2)
                {
                    shopdetail.shop_code = strarr[0];
                    shopdetail.issue_code = strarr[1];
                }
                [nv loginSuccess:^{
                    [nv pushViewController:shopdetail animated:YES];
                }];
            }
           
        }else if ([userInfo[@"is_list"] integerValue]==0)//首页
        {
            
        }
        else{
            LuckdrawViewController *luck=[[LuckdrawViewController alloc] init];
            luck.hidesBottomBarWhenPushed=YES;
            Mtarbar.selectedIndex=0;
            UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[2];
            nv.navigationBarHidden = YES;
            [nv pushViewController:luck animated:YES];
        }
    }
    else if ([userInfo[@"open_type"] integerValue]==3)//直接进衣蝠主页
    {
        Mtarbar.selectedIndex=0;
    }
    else if ([userInfo[@"open_type"] integerValue]==4)//直接进签到
    {
        Mtarbar.selectedIndex=2;
    }else if ([userInfo[@"open_type"] integerValue]==5)//个人中心
    {
        Mtarbar.selectedIndex=4;
    }else if ([userInfo[@"open_type"] integerValue]==6)//话题消息
    {
        
        MessageCenterVC *message=[[MessageCenterVC alloc]init];
        message.hidesBottomBarWhenPushed=YES;
        
        Mtarbar.selectedIndex=4;
        UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[4];
        nv.navigationBarHidden = YES;
        [nv pushViewController:message animated:YES];
    }
    
    NSString *message_id = [NSString stringWithFormat:@"%@",userInfo[@"message_id"]];
    if(message_id.length >0 && ![message_id isEqual:[NSNull null]] && ![message_id isEqualToString:@"(null)"])
    {
        //有message_id就调用推送统计接口
        
        NSString *time = [[NSUserDefaults standardUserDefaults] objectForKey:PushOpenTime];
        NSString *currTime = [MyMD5 getCurrTimeString:@"year-month-day"];
        if (time == nil || ![time isEqualToString:currTime])//初次打开
        {
            [self PushStatisticsCodetype:@"3" Messageid:message_id];
        }else{
            [self PushStatisticsCodetype:@"2" Messageid:message_id];
        }
    }
}
#pragma mark ************************环信相关***************************
#pragma mark 注册环信回调
- (void)didRegisterNewAccount:(NSString *)username
                     password:(NSString *)password
                        error:(EMError *)error
{
    MyLog(@"注册环信回调");
}

#pragma mark 登录环信回调
- (void)didLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
    MyLog(@"登录环信回调");
}

- (void)didFetchMessage:(EMMessage *)aMessage error:(EMError *)error
{
    //userinfo===%@",aMessage.messageBodies);
}
#pragma mark 退出登录回调
- (void)didLogoffWithError:(EMError *)error
{
    MyLog(@"退出登录回调");
}

#pragma mark ************************其它方法***************************

- (BOOL)copyMissingFile:(NSString *)sourcePath toPath:(NSString *)toPath
{
    BOOL retVal = YES; // If the file already exists, we'll return success…
    NSString * finalLocation = [toPath stringByAppendingPathComponent:[sourcePath lastPathComponent]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:finalLocation])
    {
        retVal = [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:finalLocation error:NULL];
    }
    return retVal;
}

- (void)createFolder:(NSString *)createDir
{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:createDir isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:createDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

#pragma mark 获取工程版本
- (NSString*)getVersion
{
    NSString *version = [NSString stringWithFormat:@"V%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    [DataManager sharedManager].appversion = version;
    return version;
}

#pragma mark 获取设备唯一标识符
-(NSString*)uuid {
    
    NSString *machineID = [SSKeychain passwordForService:SSKeychain_Service account:SSKeychain_Account_UUID error:nil];
    if (machineID.length==0) {
        CFUUIDRef puuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        machineID = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);
        [SSKeychain setPassword:machineID forService:SSKeychain_Service account:SSKeychain_Account_UUID error:nil];
    }
    return machineID;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    //    //viewController = %@", viewController);
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    UINavigationController *nv = (UINavigationController *)viewController;
    
    if ([nv.viewControllers[0] isKindOfClass:[MymineViewController class]]||[nv.viewControllers[0] isKindOfClass:[NewShoppingCartViewController class]]) {
        if (token!=nil) {
            
            return YES;
        }
        return NO;
    }
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //    MyLog(@"tabBar.index = %d", (int)tabBarController.selectedIndex);
}

//如果发生错误反馈信息给开发者
void UncaughtExceptionHandler(NSException *exception) {
    /**
     *  获取异常崩溃信息
     */
    NSArray *callStack = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *content = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[callStack componentsJoinedByString:@"\n"]];
    
    /**
     *  把异常崩溃信息发送至开发者邮件
     */
    NSMutableString *mailUrl = [NSMutableString string];
    [mailUrl appendString:@"mailto:137024642@qq.com"];
    [mailUrl appendString:@"?subject=程序异常崩溃，请配合发送异常报告，谢谢合作！"];
    [mailUrl appendFormat:@"&body=%@", content];
    // 打开地址
    NSString *mailPath = [mailUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailPath]];
}

- (int)isTodayorTomorrow
{
    NSDate *date = [NSDate date];
    
    NSString *mt = [[NSUserDefaults standardUserDefaults]objectForKey:NowDate];
    
    NSString *daystr = [MyMD5 compareDate:mt];
    
    if ([daystr isEqualToString:@"今天"])
    {
        
        NSString *string = [[NSUserDefaults standardUserDefaults]objectForKey:NumberCount];
        
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",[string intValue]+1] forKey:NumberCount];
        
        return string.intValue+1;
        
    }else{
        
        [[NSUserDefaults standardUserDefaults]setObject:date forKey:NowDate];
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",1] forKey:NumberCount];
        
        return 1;
    }
    
    return 0;
}


//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [alter show];
}

-(void)writeToFile
{
    //文件类型
    NSString * docPath = [[NSBundle mainBundle] pathForResource:@"attr" ofType:@"db"];
    
    // 沙盒Documents目录
    NSString * appDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    
    // 沙盒Library目录
    //    NSString * appDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    //appLib Library/Caches目录
    //    NSString *appLib = [appDir stringByAppendingString:@"/Caches"];
    
    BOOL filesPresent = [self copyMissingFile:docPath toPath:appDir];
    if (filesPresent) {
        //OK");
    }
    else
    {
        //NO");
    }
    
    // 创建文件夹
    //    NSString *createDir = [NSHomeDirectory() stringByAppendingString:@"/test"];
    //    [self createFolder:createDir];
    
    // 把文件拷贝到Test目录
    BOOL filesPresent1 = [self copyMissingFile:docPath toPath:appDir];
    if (filesPresent1) {
        //OK");
    }
    else
    {
        //NO");
    }
    
}

#pragma mark ************************系统方法***************************
#pragma mark 注册成功将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSString *deviceTokenStr = [[[[deviceToken description]
                                  stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                 stringByReplacingOccurrencesOfString: @">" withString: @""]
                                stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    if(deviceTokenStr) {
        NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
        [userdefaul setObject:deviceTokenStr forKey:DECICETOKEN];
    }
    
    MyLog(@"deviceTokenStr=%@",deviceTokenStr);
    
    [UMessage registerDeviceToken:deviceToken];
}

// 注册deviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{

}

//系统方法
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSString *s = [NSString stringWithFormat:@"This is a smiley \ue415 %C face",0xE05A];
    //11----%@",s);
    
    //关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    
    [UMessage didReceiveRemoteNotification:userInfo];
    
}

//系统方法
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    // 融云推送消息跳转
    NSLog(@"------------------------------->\n%@------------------------------->",notification.userInfo);
    NSDictionary *dict = [notification.userInfo objectForKey:@"rc"];
    if (nil != dict) {
        YFTestChatViewController *listVC = [[YFTestChatViewController alloc] init];
        Mtarbar.selectedIndex=4;
        UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[4];
        [nv presentViewController:[[UINavigationController alloc] initWithRootViewController:listVC] animated:YES completion:nil];
    }
    
    
//    [self doLocalNotifition:YES timeInterval:10];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[[NSUserDefaults standardUserDefaults]objectForKey:USER_AllCount] integerValue]];
    
    //重新请求数据设置角标
    //    [self httpRedCount];
        
    [[ImageSizeManager shareManager] save];
    
    MyLog(@"[DataManager sharedManager].outAppStatistics = %@",[DataManager sharedManager].outAppStatistics);
    
    [TFStatisticsClickVM handleDataWithPageType:@"跳出APP统计" withClickType:[DataManager sharedManager].outAppStatistics success:nil failure:nil];
 
//    [self doLocalNotifition:NO timeInterval:0];
    
    [self httpUseAppTimeInterval];
}

/**
 App 单次使用时长
 */
- (void)httpUseAppTimeInterval
{
    NSTimeInterval currTimeInterval = [NSDate timeIntervalSince1970WithDate];
    NSTimeInterval diffTimeInterval = ABS(currTimeInterval- [[DataManager sharedManager] beginYiFuApp]);
    NSDictionary *parameter = @{@"type": @"1",
                                @"value": [NSNumber numberWithDouble:(int)diffTimeInterval],
                                @"channel": [NSObject baseDataStatisticsChannel]};
    
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_apptimeStartistice_getCount parameter:parameter caches:NO cachesTimeInterval:0*TFSecond token:YES success:^(id data, Response *response) {
        
        MyLog(@"data: %@", data);
        
    } failure:^(NSError *error) {
        MyLog(@"error: %@", error);
        
    }];
    
    [ShopDislikeModel apptimeStartistice:diffTimeInterval/1000 Success:^(id data) {
        ShopDislikeModel *model = data;
        if(model.status == 1)
        {
            
        }
    }];
}

- (void)test
{
    MyLog(@"okokokokok");
}

#pragma 结束进程
- (void)applicationWillTerminate:(UIApplication *)application
{
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"is_read"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isFightSuccessShow"];
    
    NSArray *recommentdata = [[NSUserDefaults standardUserDefaults]objectForKey:RECOMMENDBROWSEDATA];
    if(recommentdata.count)
    {
        //将不喜欢的商品返回后台
        NSString *shopcodes = [recommentdata componentsJoinedByString:@","];
        [ShopDislikeModel getShopDisLike:shopcodes Success:^(id data) {
            
            ShopDislikeModel *model = data;
            if(model.status == 1)
            {
                MyLog(@"删除成功");            }

        }];
        
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:RECOMMENDBROWSEDATA];
    }

}

#pragma mark 退出程序
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [[NSUserDefaults standardUserDefaults] setObject:@([NSDate date].timeIntervalSince1970) forKey:YFLaunchViewDisappearTime];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isFightSuccessShow"];

    [self removeNotification];
    
    // 在这里调用退出方法
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    long long backTime = [[[NSUserDefaults standardUserDefaults] objectForKey:YFLaunchViewDisappearTime] longLongValue];
    long long nowTime = [NSDate date].timeIntervalSince1970;
    if (nowTime - backTime > 60*60*6) {
        [YFLaunchView show];
    } else {
//        [YFLaunchView update];
    }
    if (IsRongCloub) {
        [UIViewController loginRongCloub];
    }
    
    /// 同步购物车数据
    [ShopCarManager loadDataNetwork];
    
}

#pragma mark 进入程序
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    //获取版本
    [self httpVersionsRequest];
    self.isComeing = YES;
    
    //赚钱任务是否隐藏
    [self httpMakeMoneyShow];
    
    //App启动激活记录
    [self httpStartActiva];
    
    //获取用户加喜欢商品
    [self getUserLikeHttp];
    
    //获取商品商品详情压缩比例
    [self getShopProportion];
    
    //获取是否是疯狂星期一
    [self httpGetMonday];
    
    //获取是否是一元购
    [self httpGetOneYuan];
    
    //获取是否有红包抽奖资格
    [self httpGetRedMoney];
    
    [self goFuns];
    
    User *currUser = [Login curLoginUser];
    MyLog(@"Home:%@\nuser: %@", NSHomeDirectory(),currUser);
    
    [self performSelector:@selector(duobaoMention) withObject:nil afterDelay:10.0];
    
    //进入APP时间
    NSString *currTime = [MyMD5 getCurrTimeString:@"year-month-day"];
    [[NSUserDefaults standardUserDefaults] setObject:currTime forKey:PushOpenTime];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isFightSuccessShow"];
    
    // 在这里调用进入方法
    [DataManager sharedManager].beginYiFuApp = [NSDate timeIntervalSince1970WithDate];
}

//夺宝开奖提示弹框
- (void)duobaoMention
{
    [[DataManager sharedManager] getduobaoStatueHttp];
}
#pragma mark 粉丝提醒框
- (void)goFuns
{
    [FunsaddModel getFunsHeadimageAndNickname:^(id data) {
        _model = data;
        if(_model.status == 1)
        {
            [self gotime:2];
        }
    }];
}
- (void)gotime:(NSInteger)count
{
    //弹窗时间为2:00—12:00期间每2分钟显示一次，12:00—00:00—2:00每隔30秒显示一次。
    BOOL result = [MyMD5 isBetweenFromHour:2 toHour:12];
    
    if(result == YES)
    {
        _time = 60*count;
    }else{
        _time = 15*count;
    }
    if(count == 1)
    {
        _time = 3;
    }
    
    self.funsIndex = 0;
    
    if (_mytimer==nil) {
        _mytimer = [NSTimer weakTimerWithTimeInterval:_time target:self selector:@selector(timerFireMethod1) userInfo:nil repeats:YES];
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer:_mytimer forMode:NSDefaultRunLoopMode];
    }
}
- (void)timerFireMethod1
{
//    NSLog(@"+++++++++++++++++++++++++++++++++++++++++");
    self.mentionCount ++;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *headimageurl = nil;
        NSString *nickname = nil;
        int type = 0 ;float money = 0;
        
        NSArray *barr_list = _model.barr_list;
        NSMutableString *barrstr ;
        if(barr_list.count > 0 && self.funsIndex < barr_list.count)
        {
            barrstr = [NSMutableString stringWithFormat:@"%@",barr_list[self.funsIndex]];
            
            NSArray * funsArr = [barrstr componentsSeparatedByString:@","];
            if(funsArr.count == 3||funsArr.count==4)
            {
                headimageurl = funsArr[0];
                nickname = funsArr[1];
                type = [funsArr[2] intValue];
                money = [funsArr[3] floatValue];
            }
            self.funsIndex ++;
        }
        
        [self.FunsView removeFromSuperview];
        self.FunsView = nil;
        
        self.FunsView = [[FunsSuspensionView alloc] initWithFrame:CGRectMake(ZOOM(40)-kScreenWidth, 105, ZOOM6(560), ZOOM6(70)) HeadImageUrl:headimageurl NickName:nickname UserType:type Money:money MentionCount:self.mentionCount];
        ESWeak_(self);
        UIViewController *vv = [weak_self topViewController];
        self.FunsView.funsClickBlock = ^{
            
            if(![vv isKindOfClass:[MakeMoneyViewController class]] && ![vv isKindOfClass:[LuckdrawViewController class]] && ![DataManager sharedManager].is_MakeMoneyHiden)
            {
                MakeMoneyViewController *makemoney = [[MakeMoneyViewController alloc]init];
                makemoney.hidesBottomBarWhenPushed = YES;
                [vv.navigationController pushViewController:makemoney animated:YES];
            }
        };
        
        if(([vv isKindOfClass:[MakeMoneyViewController class]] && [DataManager sharedManager].IS_Monday == YES) || [vv isKindOfClass:[CFActivityDetailToPayVC class]])
        {
            [self.FunsView removeFromSuperview];
            self.FunsView = nil;
        }else{
            [_mytimer invalidate];
            _mytimer = nil;
            
            if([vv isKindOfClass:[MakeMoneyViewController class]])
            {
                [self gotime:1];
            }else{
                [self gotime:2];
            }
            
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            [window addSubview:self.FunsView];
        }
    });
}

//获取当前的VC
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
#pragma mark 移出粉丝提醒通知
- (void)removeNotification
{
    [_mytimer invalidate];
    _mytimer = nil;
    
    [self.FunsView removeFromSuperview];
    self.FunsView = nil;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary*)options
{
    BOOL isminiShare = [[NSUserDefaults standardUserDefaults]boolForKey:@"isMiniShare"];
    if ([url.host isEqualToString:@"pay"])//微信支付回调
    {
        [WXApi handleOpenURL:url delegate:self];
    }
    else if ([url.host isEqualToString:@"safepay"])//支付宝支付回调
    {
        [[AlipaySDK defaultService]
         processOrderWithPaymentResult:url
         standbyCallback:^(NSDictionary *resultDic) {
             
             [self payFinished:resultDic];
             
         }];
    }
    else{
        if(isminiShare)//是微信SDK
        {
            MiniShareManager *minishare = [MiniShareManager share];
            [WXApi handleOpenURL:url delegate:minishare];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isMiniShare"];
        }else{//是友盟SDK
            [ShareSDK handleOpenURL:url
                         wxDelegate:self];
        }
    }
    return YES;
}
//此方法已经废弃
//- (BOOL)application:(UIApplication *)application
//      handleOpenURL:(NSURL *)url
//{
//    if ([url.host isEqualToString:@"pay"]) {
//        [WXApi handleOpenURL:url delegate:self];
//    }else{
//        [ShareSDK handleOpenURL:url
//                     wxDelegate:self];
//    }
//
//    return YES;
//}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    //跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService]
         processOrderWithPaymentResult:url
         standbyCallback:^(NSDictionary *resultDic) {
             
             [self payFinished:resultDic];
             
         }];
    }
    else if ([url.host isEqualToString:@"pay"]) {
        [WXApi handleOpenURL:url delegate:self];
        
    }
    else if ([url.host isEqualToString:@"platformId=wechat"])//微信分享成功回调
    {
        
        return [ShareSDK handleOpenURL:url
                     sourceApplication:sourceApplication
                            annotation:annotation
                            wxDelegate:self];
    }
    else if([url.host isEqualToString:@"response_from_qq"]){
        
        return [ShareSDK handleOpenURL:url
                     sourceApplication:sourceApplication
                            annotation:annotation
                            wxDelegate:self];
        
    }else{
        
        return [ShareSDK handleOpenURL:url
                     sourceApplication:sourceApplication
                            annotation:annotation
                            wxDelegate:self];
    }
    
    return YES;
    
}

- (void)applicationStartingMethod:(NSDictionary *)launchOptions
{
    MyLog(@"launchOptions: %@", launchOptions);
    // 若用户直接启动，lauchOptions内无数据;
    
    /**<  若由其他应用程序通过openURL:启动 */
    NSURL *url = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey]; /**<则UIApplicationLaunchOptionsURLKey对应的对象为启动URL（NSURL） */
    if(url) {
        
    }
    /**< UIApplicationLaunchOptionsSourceApplicationKey对应启动的源应用程序的bundle ID (NSString)； */
    NSString *bundleId = [launchOptions objectForKey:UIApplicationLaunchOptionsSourceApplicationKey];
    if(bundleId) {
        
    }
    /**< 若由本地通知启动 */
    UILocalNotification * localNotify = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if(localNotify) {
        
    }
    /**< 若由远程通知启动(推送等) */
    NSDictionary * userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(userInfo) {
        
    }
    
}

- (void)doLocalNotifition:(BOOL)isOpen timeInterval:(NSTimeInterval)timeInterval
{
    BOOL swith = isOpen;
    if (swith==YES) {
        
        // 先移除
        [self doLocalNotifition:NO timeInterval:0];
        
        UILocalNotification * notification = [[UILocalNotification alloc] init];
        NSDate * pushDate = [NSDate dateWithTimeIntervalSinceNow:timeInterval];
        
        if (notification!=nil) {
            notification.fireDate= pushDate;
            notification.timeZone = [NSTimeZone defaultTimeZone];
            notification.repeatInterval = kCFCalendarUnitYear; //设置重复重复间隔为每年
            notification.soundName = UILocalNotificationDefaultSoundName;
            notification.alertBody = @"您有一条新的消息";
//            notification.applicationIconBadgeNumber++;
            
            //取消 推送 用的 字典  便于识别
            NSDictionary * inforDic = [NSDictionary dictionaryWithObject:@"LocalNotificationID" forKey:@"LocalNotificationID"];
            notification.userInfo =inforDic;
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
        NSLog(@"开启本地通知");
    } else if (swith == NO) {
        NSArray * array = [[UIApplication sharedApplication] scheduledLocalNotifications];
        for (UILocalNotification * loc in array) {
            if ([[loc.userInfo objectForKey:@"LocalNotificationID"] isEqualToString:@"LocalNotificationID"]) {
                [[UIApplication sharedApplication] cancelLocalNotification:loc];
            }
        }
        NSLog(@"关闭本地通知");
    }
}

#pragma mark - 禁止横屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

//退出APP
- (void)exitApplication {
    
    [UIView beginAnimations:@"exitApplication" context:nil];
    
    [UIView setAnimationDuration:0.5];
    
    [UIView setAnimationDelegate:self];
    
    // [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.view.window cache:NO];
    
    [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.window cache:NO];
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    
    //self.view.window.bounds = CGRectMake(0, 0, 0, 0);
    
    self.window.bounds = CGRectMake(0, 0, 0, 0);
    
    [UIView commitAnimations];
    
}



- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if ([animationID compare:@"exitApplication"] == 0) {
        
        exit(0);
        
    }
}
@end
