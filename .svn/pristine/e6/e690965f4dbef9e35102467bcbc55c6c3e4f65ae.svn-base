//
//  DataManager.m
//  YunShangShiJi
//
//  Created by zgl on 16/5/28.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "DataManager.h"
#import "GlobalTool.h"
#import "RCTokenModel.h"
#import "RawardRedPopview.h"
#import "TFPayStyleViewController.h"
#import "CFActivityDetailToPayVC.h"
#import <RongIMKit/RongIMKit.h>
#import "YFShareModel.h"
#import "FinishTaskPopview.h"
#import "IndianaDetailViewController.h"
#import "OneIndianaDetailViewController.h"
#import "FightIndianaDetailViewController.h"
#import "TFShopStoreViewController.h"
#import "MakeMoneyViewController.h"
#import "VitalityTaskPopview.h"
@implementation DataManager

+ (DataManager *)sharedManager {
    static DataManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        assert(sharedManager != nil);
        sharedManager.twofoldness = 1;
    });
    return sharedManager;
}

/// 融云token更新
- (void)updateRcToken {
    __weak typeof(self) weakSelf = self;
    [RCTokenModel getRCTokenModelSuccess:^(id data) {
        RCTokenModel *model = data;
        if (model.status == 1) {
            weakSelf.userId = model.data.userId;
            weakSelf.rcToken = model.data.token;
            [[NSUserDefaults standardUserDefaults] setObject:weakSelf.rcToken forKey:RongCloub_Token];
            
            // 登录融云
            [[RCIM sharedRCIM] connectWithToken:weakSelf.rcToken success:^(NSString *userId) {
                NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
                weakSelf.isRongCloubLogin = YES;
                NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME];
                NSString *defaultPic = [[NSUserDefaults standardUserDefaults] objectForKey:USER_HEADPIC];
                if (![defaultPic hasPrefix:@"http://"]) {
                    defaultPic = [NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy],defaultPic];
                }
                RCUserInfo *user=[[RCUserInfo alloc]initWithUserId:userId name:name portrait:defaultPic];
                [RCIM sharedRCIM].currentUserInfo = user;
            } error:^(RCConnectErrorCode status) {
                NSLog(@"登陆的错误码为:%ld", (long)status);
            } tokenIncorrect:^{
                NSLog(@"token错误");
            }];
        } else {
            NSLog(@"%@",model.message);
        }
    }];

}

- (void)setVitality:(NSInteger)vitality
{
    _vitality = vitality;
    NSArray *gradeKeyValue = [[NSUserDefaults standardUserDefaults]objectForKey:@"gradeKeyValue"];
    [gradeKeyValue enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *arr=[(NSString *)obj componentsSeparatedByString:@","];
        NSString *vitalityValue = arr[0];
        
        if (vitality >= [vitalityValue integerValue]) {
            _vipGrade = idx;
        }
    }];
    
    MyLog(@"_vitality: %ld, _vipGrade: %ld, _grade: %ld",(long)_vitality, (long)_vipGrade, (long)_grade);
    
    if (_vipGrade == 0 && _grade == 1) {
        _generalA = NO;
    } else {
        _generalA = NO;
    }
}

#pragma mark - getter方法
- (NSString *)userId {
    if (nil == _userId) {
        _userId = [[NSUserDefaults standardUserDefaults] stringForKey:USER_ID];
    }
    return _userId;
}

- (NSString *)rcToken {
    if (nil == _rcToken) {
        _rcToken = [[NSUserDefaults standardUserDefaults] objectForKey:RongCloub_Token];
    }
    return _rcToken;
}

- (NSMutableArray *)fightData
{
    if(_fightData == nil)
    {
        _fightData = [NSMutableArray array];
    }
    return _fightData;
}

#pragma mark 获取夺宝开奖信息
- (void)getduobaoStatueHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSString *url=[NSString stringWithFormat:@"%@treasures/getMsg?version=%@&token=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]];

    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        NSString*status = responseObject[@"status"];
        if (responseObject !=nil && ![responseObject isEqual:[NSNull null]] && status.intValue==1){
            
            NSString *datastr = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
            NSArray *dataArr = [NSArray arrayWithObject:responseObject[@"data"]];
            if(dataArr.count && datastr.length >0)
            {
                NSString *sss = [NSString stringWithFormat:@"%@",responseObject[@"data"][0]];
                NSArray *dataArray = [sss componentsSeparatedByString:@"^"];
                if(dataArray.count >= 7)
                {
                    NSMutableString *sstt = [NSMutableString stringWithFormat:@"%@",dataArray[0]];
                    
                    //中奖类型 0：一分夺宝 1：1元夺宝 2：拼团夺宝
                    NSString *indianatype = [NSMutableString stringWithFormat:@"%@",dataArray[7]];
                    
                    if([sstt isEqualToString:@"true"])//中奖
                    {
                        [self setTaskPopMindView:Task_duobao_zongjiang Value:sss Title:dataArray[6] Rewardvalue:indianatype Rewardnum:0];
                    }else{
                        [self setTaskPopMindView:Task_duobao_kaijiang Value:sss Title:dataArray[6] Rewardvalue:indianatype Rewardnum:0];
                    }
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)setVitalityPopMindView:(VitalityType)type
{
    VitalityTaskPopview *vitaliview = [[VitalityTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) VitalityType:type valityGrade:0 YidouCount:0];
    
    __weak VitalityTaskPopview *view = vitaliview;
    
    kWeakSelf(self);
    view.tapHideMindBlock = ^{
        
    };
    view.closeMindBlock = ^{
        
    };
    view.leftHideMindBlock = ^(NSString*title){
        
    };
    
    view.rightHideMindBlock = ^(NSString*title)
    {
        [weakself gotoDuobaoDetail:nil Issuecode:nil IndianaType:@"4"];
    };
    
    UIWindow *kwindow = [UIApplication sharedApplication].keyWindow;
    [kwindow addSubview:vitaliview];
}

#pragma mark 夺宝开奖、中奖弹框
- (void)setTaskPopMindView:(TaskPopType)type Value:(NSString*)value Title:(NSString*)shopcode Rewardvalue:(NSString*)rewardValue Rewardnum:(int)num
{
    FinishTaskPopview*bonusview = [[FinishTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) TaskType:type TaskValue:value Title:shopcode RewardValue:rewardValue RewardNumber:num Rewardtype:nil];
    kWeakSelf(self);
    __weak FinishTaskPopview *view = bonusview;
    view.tapHideMindBlock = ^{
        [view remindViewHiden];
    };
    
    view.leftHideMindBlock = ^(NSString*title){
        MyLog(@"左");
        
        [weakself gotoDuobaoDetail:shopcode Issuecode:value IndianaType:rewardValue];
    };
    
    view.rightHideMindBlock = ^(NSString*title){
        MyLog(@"右");
        
        [weakself gotoDuobaoDetail:shopcode Issuecode:value IndianaType:rewardValue];
    };
    
    UIWindow *kwindow = [UIApplication sharedApplication].keyWindow;
    [kwindow addSubview:bonusview];
}

- (void)gotoDuobaoDetail:(NSString*)shop_code Issuecode:(NSString*)issue_code IndianaType:(NSString*)indiatype
{
    UIViewController *vv = [self topViewController];

    if(![vv isKindOfClass:[IndianaDetailViewController class]] && indiatype.intValue == 0)
    {
        IndianaDetailViewController *india = [[IndianaDetailViewController alloc]init];
        india.shop_code = shop_code;
        india.hidesBottomBarWhenPushed = YES;
        
        [vv loginSuccess:^{
            
            [vv.navigationController pushViewController:india animated:YES];
        }];
    }else if (![vv isKindOfClass:[OneIndianaDetailViewController class]] && indiatype.intValue == 1)
    {
        OneIndianaDetailViewController *india = [[OneIndianaDetailViewController alloc]init];
        india.shop_code = shop_code;
        india.hidesBottomBarWhenPushed = YES;
        [vv loginSuccess:^{
            
            [vv.navigationController pushViewController:india animated:YES];
        }];
    }else if (![vv isKindOfClass:[FightIndianaDetailViewController class]] && indiatype.intValue == 2)
    {
        FightIndianaDetailViewController *india = [[FightIndianaDetailViewController alloc]init];
        india.shop_code = shop_code;
        NSArray *arr = [issue_code componentsSeparatedByString:@"^"];
        if(arr.count >4)
        {
            india.issue_code = arr[3];
        }
        india.hidesBottomBarWhenPushed = YES;
        [vv loginSuccess:^{
            
            [vv.navigationController pushViewController:india animated:YES];
        }];
    }else {
        
        for(UIViewController *vc in vv.navigationController.viewControllers)
        {
            if([vc isKindOfClass:[MakeMoneyViewController class]]){
                
                [vv.navigationController popToViewController:vc animated:YES];
                return;
            }
        }

        MakeMoneyViewController *vc = [[MakeMoneyViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [vv.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark 获取是否有余额抽红包任务
- (void)taskListHttp:(NSInteger)Tasktype Success:(void(^)())redmoney_taskBlock;
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
        
        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil)
        {
            if(responseObject[@"zero_buy"] != nil)
            {
                self.is_SuperZeroShop = [responseObject[@"zero_buy"] boolValue];
            }
            
            if(responseObject[@"balance_with"] != nil)
            {
                self.is_balance_with = [responseObject[@"balance_with"] boolValue];
            }
            
            if([responseObject[@"daytaskList"] count])
            {
                for(NSDictionary *taskDic in responseObject[@"daytaskList"])
                {
                    NSString *tasktype = [NSString stringWithFormat:@"%@",taskDic[@"task_type"]];
                    if(tasktype.intValue == Tasktype)
                    {
                       
                        if(redmoney_taskBlock)
                        {
                            redmoney_taskBlock();
                        }
                        
                        break;
                    }
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

#pragma mark 获取是否有未支付的订单
- (BOOL)getOrderHttp:(BOOL)ispop;
{
    NSString *url=[NSString stringWithFormat:@"%@order/getWaitPayCount?version=%@&token=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]];
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
            NSString *status = responseObject[@"status"];
            NSString *s = [NSString stringWithFormat:@"%@",responseObject[@"s"]];
            long long time = [DataManager sharedManager].halve/1000;
            if(status.intValue==1 && s.intValue > 0)
            {
                if(ispop)
                {
                    [self performSelector:@selector(isGuidePopviewShow) withObject:self afterDelay:time];
                }
                return YES;
            }
        }
    }
    return NO;
}

- (NSString*)getPictureVerificationCode:(NSString*)phone;
{
    NSString *IMEI = [[NSUserDefaults standardUserDefaults] objectForKey:USER_UUID];
    NSString *url = [NSString stringWithFormat:@"%@vcode/getVcode?version=%@&phone=%@&imei=%@",[NSObject baseURLStr],VERSION,phone,IMEI];
    NSString *URL=[MyMD5 authkey:url];
    
    return URL;
}

- (void)getPictureVerificationCode:(NSString*)phone Success:(void(^)(NSString*url))success Fail:(void(^)(NSString*message))fail;
{
    NSString *IMEI = [[NSUserDefaults standardUserDefaults] objectForKey:USER_UUID];
    NSString *second = [self getSecond];
    NSString *url = [NSString stringWithFormat:@"%@vcode/getVcode?version=%@&phone=%@&imei=%@&%@",[NSObject baseURLStr],VERSION,phone,IMEI,second];
    NSString *URL=[MyMD5 authkey:url];
    NSURL *httpUrl=[NSURL URLWithString:URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpUrl];
    request.timeoutInterval = 3;
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
       
        responseObject = [NSDictionary changeType:responseObject];
        if(responseObject!=nil) {
            NSString *message = responseObject[@"message"];
            if(fail)
            {
                fail(message);
            }
        }else{
            if(success)
            {
                success(URL);
            }
        }
    }
}
#pragma mark 获取毫秒数
- (NSString*)getSecond{
//    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
//    [formatter setTimeStyle:NSDateFormatterMediumStyle];
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSInteger unitFlags = NSCalendarUnitMonth;
//    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
//    int second = (int)[comps second];
//    return second;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYYMMddhhmmssSSS"];
    NSString *date =  [formatter stringFromDate:[NSDate date]];
    NSString *timeLocal = [[NSString alloc] initWithFormat:@"%@", date];
    return timeLocal;
}
- (void)isGuidePopviewShow
{
    UIViewController *vv = [self topViewController];
    if([vv isKindOfClass:[TFShoppingViewController class]] )
    {
        [self guidePopview];//如果当前页是首页就直接弹出千元红包雨弹框
    }else{
        self.is_guidePopviewShow = YES;
    }
}
- (void)guidePopview
{
    //埋点
    [YFShareModel getShareModelWithKey:@"duobao" type:StatisticalTypeRedpop tabType:StatisticalTabTypeIndiana success:nil];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDate *tixianrecord = [user objectForKey:GUIDEORDER];
    NSString *token = [user objectForKey:USER_TOKEN];
    if(token.length < 10)
    {
        return;
    }
    if(![[MyMD5 compareDate:tixianrecord] isEqualToString:@"今天"] || tixianrecord==nil)
    {
        [DataManager sharedManager].is_guidePopviewShow = YES;
        [self RawardRedPopView:RawardRed_order_open];
    }
}

#pragma mark 支付成功的提示框
- (void)paySuccessMentionView
{
    [self performSelectorOnMainThread:@selector(popviewShow) withObject:nil waitUntilDone:5.0];
}

- (void)popviewShow
{
    [self setVitalityPopMindView:Task_zero_BuyFinish];
}
#pragma mark 获取衣豆减半资格
- (void)getyidouQualifications
{
    NSString *url=[NSString stringWithFormat:@"%@wallet/yiDouHalveAgo?version=%@&token=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]];
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
            NSString*status = responseObject[@"status"];
            if(status.intValue==1)
            {
    
            }
        }
    }
}
#pragma mark 抽中红包
- (void)RawardRedPopView:(RawardRedType)type
{
    RawardRedPopview *pop = [[RawardRedPopview alloc] initWithHeadImage:nil contentText:nil upButtonTitle:nil downButtonTitle:nil RawardType:type Raward:0 CashorEdu:0];
    [pop show];
    kWeakSelf(self);
    UIViewController *vv = [weakself topViewController];
    pop.headBlock = ^() //折红包
    {
        if(![vv isKindOfClass:[CFActivityDetailToPayVC class]])
        {
            CFActivityDetailToPayVC *CFActivity = [[CFActivityDetailToPayVC alloc]init];
            CFActivity.hidesBottomBarWhenPushed = YES;
            [vv.navigationController pushViewController:CFActivity animated:YES];
        }

        [self getyidouQualifications];
    };
    
    NSDate *date = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:GUIDEORDER];
}
//H5赚钱提示
- (void)remindGetH5Money
{
    if(self.h5money >=0)
    {
        UIViewController *vv = [self topViewController];
        
        NavgationbarView *mention = [NavgationbarView shared];
        [mention showLable:@"你的签到奖金已放入账户余额。继续努力做任务赚钱吧。" Controller:vv];
    }
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

@end
