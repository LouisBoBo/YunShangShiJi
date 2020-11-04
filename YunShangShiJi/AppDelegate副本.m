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
#import "BeautyViewController.h"
#import "ShoppingViewController.h"
#import "MymineViewController.h"
#import "LoginViewController.h"
#import "GlobalTool.h"
#import "ShopDetailViewController.h"
#import "DShareManager.h"
#import "NavgationbarView.h"
#import "BuySuccessViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <RennSDK/RennSDK.h>
#import "WeiboSDK.h"
#import "WXApi.h"

#import <AlipaySDK/AlipaySDK.h>
//APP端签名相关头文件
#import "payRequsestHandler.h"
#import <QuartzCore/QuartzCore.h>

#import "TFWelcomeView.h"

#import "TFHomeViewController.h"


#import "AFNetworking.h"
#import "MyMD5.h"
#import "HYJGuideView.h"

#import "ValueObserver.h"
@interface AppDelegate ()

{
    NSTimer *connectionTimer;  //timer对象
    
    //记录分享次数
    NSInteger _shareCount;
    
    const char *_sql_stmt;
}



@property (nonatomic, strong)ValueObserver *kvo;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    NSLog(@"NSHomeDirectory = %@", NSHomeDirectory());
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UIViewController* vc = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = vc;
    
    [self OpenDb];
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *type_data= [userdefaul objectForKey:USER_DATA];
    NSString *attr_data= [userdefaul objectForKey:ATTR_DATA];
    NSString *tag_data=[userdefaul objectForKey:TAG_DATA];
    _imageDictionary = [userdefaul objectForKey:ICOIMAGE];
    
//    if(!type_data && !attr_data && !tag_data)
//    {
//        type_data = NULL;
//        attr_data = NULL;
//        tag_data = NULL;

        //同步数据到数据库
        [self  httpSortRequest];
//    }
    

    _shareCount=0;
    
    TFHomeViewController *shopstore = [[TFHomeViewController alloc] init];
    
    
    ShopStoreViewController *mainstore=[[ShopStoreViewController alloc]init];
    mainstore.isHeadView = YES;
    UINavigationController *mainstoreNav=[[UINavigationController alloc]initWithRootViewController:mainstore];
    
    BeautyViewController *beauty=[[BeautyViewController alloc]init];
    UINavigationController *beautyNav=[[UINavigationController alloc]initWithRootViewController:beauty];
    
    ShoppingViewController *shopping=[[ShoppingViewController alloc]init];
    UINavigationController *shoppingNav=[[UINavigationController alloc]initWithRootViewController:shopping];
    
    MymineViewController *mymine=[[MymineViewController alloc]init];
    UINavigationController *mymineNav=[[UINavigationController alloc]initWithRootViewController:mymine];
    
    MyTabBarController *mytabar=[[MyTabBarController alloc]init];
    mytabar.viewControllers=@[shopstore,mainstoreNav,beautyNav,shoppingNav,mymineNav];
    mytabar.selectedIndex = 1;
    
    
    //    registerSDKWithAppKey:注册环信的appKey，详细见下面注释。
    //    apnsCertName:推送证书名(不需要加后缀)，详细见下面注释。
    
    //[[EaseMob sharedInstance] registerSDKWithAppKey:@"easemob-demo#chatdemoui" apnsCertName:@"chatdemoui"];
    
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"yssjsz#yssjchat" apnsCertName:@"YIFU_APNS"];
    
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    
    
    ///应用程序不处在后台，并且是通过推送打开应用的时候
    if (launchOptions) {
        ///获取到推送相关的信息
        NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
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
    
    //向微信注册
    [WXApi registerApp:@"wx8c5fe3e40669c535" withDescription:@"demo 2.0"];
    self.takeoutPay.delegate=self;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    if ([ud objectForKey:@"isFirst"]) {
        if (token!=nil) {
            Mtarbar=mytabar;
            self.window.rootViewController=mytabar;
            
        } else {
            //HYJ
            
            
            HYJGuideView *guide = [[HYJGuideView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            [self.window addSubview:guide];
            
            guide.loginBlock = ^(NSNumber *index){
                
                LoginViewController *login=[[LoginViewController alloc]init];
                UINavigationController *navv=[[UINavigationController alloc] initWithRootViewController:login];
                login.tag=index.integerValue;
                self.window.rootViewController=navv;
            };
            
        }
        
    } else {
        TFWelcomeView *tv = [[TFWelcomeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.window addSubview:tv];
        
        
        tv.guideView.loginBlock = ^(NSNumber *index){
            
            LoginViewController *login=[[LoginViewController alloc]init];
            UINavigationController *navv=[[UINavigationController alloc] initWithRootViewController:login];
            login.tag=index.integerValue;
            self.window.rootViewController=navv;
        };
        
        
        [ud setBool:YES forKey:@"isFirst"];
        [ud synchronize];
    }

    
    //将后台推送消息数量为0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    

    //获取设备唯一标识符
    NSString *UUID =[self uuid];
    [ud setObject:UUID forKey:USER_UUID];
    
    
//    self.kvo = [[ValueObserver alloc] init];
//
//    gKVO = self.kvo;
    
    return YES;
}

#pragma mark 分享
- (void)shardk
{
    [ShareSDK registerApp:@"692d2b7c818a"];//字符串api20为您的ShareSDK的AppKey
    
    //添加新浪微博应用 注册网址 http://open.weibo.com
    //注册应用时就必须在高级信息里填写回调页地址
    
    
    [ShareSDK connectSinaWeiboWithAppKey:@"1893870278"
                               appSecret:@"0fbafbea8a04dcc09af7f641827f2e1f"
                             redirectUri:@"http://www.baidu.com"];
    
    
    
    [ShareSDK connectWeChatWithAppId:@"wx8c5fe3e40669c535"
                           appSecret:@"10d080a714d768427242e9b091d33959"
                           wechatCls:[WXApi class]];

    
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

// 注册成功将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    
    
    NSString *deviceTokenStr = [[[[deviceToken description]
                                  stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                 stringByReplacingOccurrencesOfString: @">" withString: @""]
                                stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSLog(@"Device Token: %@", deviceTokenStr);
    
    if(deviceTokenStr)
    {
         NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
        [userdefaul setObject:deviceTokenStr forKey:DECICETOKEN];
        
    }


}

// 注册deviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
    NSLog(@"error -- %@",error);
}



#pragma mark 商品属性，分类，标签网络请求

-(void)httpSortRequest
{

    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *type_data= [userdefaul objectForKey:TYPE_DATA];
    NSString *attr_data= [userdefaul objectForKey:ATTR_DATA];
    NSString *tag_data=[userdefaul objectForKey:TAG_DATA];
    
//    if(!type_data && !attr_data && !tag_data)
//    {
//        type_data=NULL;
//        attr_data=NULL;
//        tag_data=NULL;
//    }
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@shop/queryTA?version=V1.0&type_data=%@&tag_data=%@&attr_data=%@",URLHTTP,type_data,tag_data,attr_data];
    
    NSString *URL=[MyMD5 authkey:url];
    
    NSURL *httpUrl=[NSURL URLWithString:URL];
    
    
    NSURLRequest *request=[NSURLRequest requestWithURL:httpUrl];
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if (data!=nil) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        
        
        //    NSError *error = nil;
        
        //    NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"responseObject ************* is %@",responseObject);
        NSString *statu=responseObject[@"status"];
        NSString *type_data1=responseObject[@"type_data"];
        NSString *attr_data1=responseObject[@"attr_data"];
        NSString *tag_data1=responseObject[@"tag_data"];
        
        
        
        if(statu.intValue==1)
        {
            
//<<<<<<< .mine
//            [self deleteTable:@"TYPDB"];
//            [userdefaul setObject:type_data1 forKey:TYPE_DATA];
//            //商品分类
//            for(NSDictionary *dic1 in responseObject[@"shop_type"])
//=======
            if([responseObject[@"shop_type"]count])
//>>>>>>> .r9139
            {
                
                [self deleteTable:@"TYPDB"];
                [userdefaul setObject:type_data1 forKey:TYPE_DATA];
                //商品分类
                for(NSDictionary *dic1 in responseObject[@"shop_type"])
                {
                    
                    _imageDictionary=responseObject[@"shop_type"];
                    
                    [userdefaul setObject:_imageDictionary forKey:ICOIMAGE];
                    
                    _dir_level=dic1[@"dir_level"];
                    _type_id=dic1[@"id"];
                    _type_parent_id=dic1[@"parent_id"];
                    _type_name=dic1[@"type_name"];
                    _type_ico=dic1[@"ico"];
                    _type_is_show=dic1[@"is_show"];
                    _type_sequence = dic1[@"sequence"];
                    
                    [self insertIntoDocFileWithInfo:@"type"];
                    
                }
                
            }
            
//<<<<<<< .mine
//        }
//        
//        if([responseObject[@"shop_attr"]count])
//        {
//            [self deleteTable:@"ATTDB"];
//            [userdefaul setObject:attr_data1 forKey:ATTR_DATA];
//            //商品属性
//            for(NSDictionary *dic in responseObject[@"shop_attr"])
//=======
            if([responseObject[@"shop_attr"]count])
//>>>>>>> .r9139
            {
                [self deleteTable:@"ATTDB"];
                [userdefaul setObject:attr_data1 forKey:ATTR_DATA];
                //商品属性
                for(NSDictionary *dic in responseObject[@"shop_attr"])
                {
                    
                    _shuxing_id=dic[@"id"];
                    _attr_name=dic[@"attr_name"];
                    _attr_Parent_id=dic[@"parent_id"];
                    _is_show=dic[@"is_show"];
                    
                    [self insertIntoDocFileWithInfo:@"attr"];
                }
            }
            
            if([responseObject[@"shop_tag"]count])
            {
                [self deleteTable:@"TAGDB"];
                
                [userdefaul setObject:tag_data1 forKey:TAG_DATA];
                //商品标签
                for(NSDictionary *dic2 in responseObject[@"shop_tag"])
                {
                    _tag_name=dic2[@"tag_name"];
                    _tag_id=dic2[@"id"];
                    _tag_show=dic2[@"is_show"];
                    _tag_parent_id=dic2[@"parent_id"];
                    
                    [self insertIntoDocFileWithInfo:@"tag"];
                    
                }
            }
            
            
        }
    }
 
}


#pragma mark 完整的数据库插入
- (BOOL)insertIntoDocFileWithInfo:(NSString*)str
{
    BOOL result = NO;
    
    [self OpenDb];
    
    if ([self OpenDb]) {
        
        
        //检测表是否存在
        sqlite3_stmt *statement = nil;
        char *sqlChar = "Select Count(rowid) From sqlite_master Where tbl_name=\"DocFile\"";
        if (sqlite3_prepare_v2(AttrcontactDB, sqlChar, -1, &statement, NULL) != SQLITE_OK)
        {
            NSLog(@"Error:failed to Select Count(rowid) From sqlite_master Where tbl_name=\"DocFile\"");
            sqlite3_finalize(statement);
            [self closeDB];
            return result;
        }
        
        BOOL isExist = NO;
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int count = sqlite3_column_int(statement, 0);
            if (count > 0) {
                isExist = YES;
            }
        }
        sqlite3_finalize(statement);
        
        //不存在则创建表
        if (!isExist) {
            sqlite3_stmt *statement2 = nil;
            char *sqlChar2 = "Create Table If Not Exists DocFile (myId Integer Primary Key, id int default 0, title varchar default \"\", directory varchar default \"\", fileUrl varchar default \"\")";
            if (sqlite3_prepare_v2(AttrcontactDB, sqlChar2, -1, &statement2, NULL) != SQLITE_OK) {
                NSLog(@"Error:failed to Create Table If Not Exists DocFile");
                sqlite3_finalize(statement2);
                [self closeDB];
                return result;
            }
            if (sqlite3_step(statement2) != SQLITE_DONE) {
                NSLog(@"Create Table If Not Exists DocFile failed");
            }
            
            sqlite3_finalize(statement2);
        }
        
        //清除数据
        char *emptySql = "Delete From DocFile";
        int status = sqlite3_exec(AttrcontactDB, emptySql, NULL, NULL, NULL);
        if (status != SQLITE_OK) {
            NSLog(@"清除本地文件表失败");
            [self closeDB];
            return result;
        }
        
        const char *dbpath = [_databasePath UTF8String];
        
        //插入数据
        
        if([str isEqualToString:@"type"])//分类表
        {
            if (sqlite3_open(dbpath, & AttrcontactDB)==SQLITE_OK) {
                
                _sql_stmt = "CREATE TABLE IF NOT EXISTS TYPDB(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT,PHONE TEXT,ICO TEXT,SEQUENCE TEXT,ISSHOW TEXT)";
                char *errMsg;
                
                
                if (sqlite3_exec(AttrcontactDB, _sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK)
                {
                    
                    NSLog(@"__________");
                }
                
                NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO TYPDB (ID,name,address,phone,ico,sequence,isshow) VALUES(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",_type_id,_type_name,_type_parent_id,_dir_level,_type_ico,_type_sequence,_type_is_show];
                
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
        
        if([str isEqualToString:@"attr"])//属性表
        {
            if (sqlite3_open(dbpath, & AttrcontactDB)==SQLITE_OK) {
                
                _sql_stmt = "CREATE TABLE IF NOT EXISTS ATTDB(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT,PHONE TEXT)";
                char *errMsg;
                
                
                if (sqlite3_exec(AttrcontactDB, _sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK)
                {
                    
                    NSLog(@"__________");
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
        
        if([str isEqualToString:@"tag"])//标签表
        {
//            char *errorMsg;
//           char* sqlStatement  =  "DROP TABLE TAGDB";
//            int returnCode  =  sqlite3_exec(AttrcontactDB,  sqlStatement,  NULL,  NULL,  &errorMsg);
//            if(returnCode!=SQLITE_OK)  {
//                　　fprintf(stderr,
//                          　　"Error  in  dropping  table  stocks.  Error:  %s",  errorMsg);
// 
//            }
            if (sqlite3_open(dbpath, & AttrcontactDB)==SQLITE_OK) {
                
                _sql_stmt = "CREATE TABLE IF NOT EXISTS TAGDB(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT,PHONE TEXT)";
                
                char *errMsg;
                
                
                if (sqlite3_exec(AttrcontactDB, _sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK)
                {
                    
                    NSLog(@"__________");
                }
                
                NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO TAGDB (ID,name,address,phone) VALUES(\"%@\",\"%@\",\"%@\",\"%@\")",_tag_id,_tag_name,_tag_parent_id,_tag_show];
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
        
        
        result = YES;
        [self closeDB];
    }
    
    return result;
}
-(void)deleteTable:(NSString*)tableName
{
    

    
//    _sql_stmt = "CREATE TABLE IF NOT EXISTS TAGDB(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT,PHONE TEXT)";
//    [self OpenDb];
//    
//    if ([self OpenDb]) {
//        NSLog(@"__________");
//    }
    
    
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
#pragma mark - 数据库

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


- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    if ([url.host isEqualToString:@"pay"]) {
        [WXApi handleOpenURL:url delegate:self];
    }else{
        [ShareSDK handleOpenURL:url
                            wxDelegate:self];
    }
   
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{

    NSLog(@"url is %@",url.host);
    
    //跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService]
         processOrderWithPaymentResult:url
         standbyCallback:^(NSDictionary *resultDic) {
             NSLog(@"result = %@", resultDic);
             
             if(self.takeoutPay)
             {
                 [self.takeoutPay payFinished:resultDic];
             }
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

    }
    
    return YES;

}

#pragma mark 支付宝支付结果
-(void)payFinished:(NSDictionary*)result
{
    switch([[result objectForKey:@"resultStatus"] integerValue]){
            
        case 9000://操作成功
        {
            NSLog(@"分享");
            
            [self gotobuySuccess];
            
        }
            break;
        case 4000://系统异常
        {
            
        }
            break;
    }
    
}

#pragma mark 支付结果回调
-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                
                
                [self gotobuySuccess];
                
                
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
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

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}

#pragma mark - 禁止横屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark 支付成功后分享
-(void)share
{
    [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:nil Title:nil];

}


#pragma mark 注册环信回调
- (void)didRegisterNewAccount:(NSString *)username
                     password:(NSString *)password
                        error:(EMError *)error
{
    HBLog(@"注册环信回调");
}

#pragma mark 登录环信回调
- (void)didLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
    HBLog(@"登录环信回调");
}

#pragma mark 退出登录回调
- (void)didLogoffWithError:(EMError *)error
{
    HBLog(@"退出登录回调");
}


//系统方法
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //SDK方法调用
    [[EaseMob sharedInstance] application:application didReceiveRemoteNotification:userInfo];
    NSLog(@"接收到推送--------:%@", userInfo/*推送内容*/);
}

//系统方法
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    //SDK方法调用
    [[EaseMob sharedInstance] application:application didReceiveLocalNotification:notification];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    completionHandler(UIBackgroundFetchResultNewData);
}



- (void)applicationWillResignActive:(UIApplication *)application {
    
    [[EaseMob sharedInstance] applicationWillResignActive:application];
    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
    
    HBLog(@"已经退出");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationDidBecomeActive:application];
    
    HBLog(@"已经进入");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

#pragma mark 获取设备唯一标识符
-(NSString*) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result ;
}

@end
