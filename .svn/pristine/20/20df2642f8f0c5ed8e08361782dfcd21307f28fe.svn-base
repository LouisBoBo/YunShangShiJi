//
//  AppDelegate+LibConfig.m
//  YunShangShiJi
//
//  Created by zgl on 16/5/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "AppDelegate+LibConfig.h"
#import "YFUserModel.h"

@implementation AppDelegate (LibConfig)

/// 统一导航条样式
- (void)setNavigationBarStyle {
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor whiteColor];
    shadow.shadowOffset = CGSizeZero;
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:kMainTitleColor,NSForegroundColorAttributeName,kNavTitleFontSize,NSFontAttributeName,shadow,NSShadowAttributeName,nil];
    [[UINavigationBar appearance] setTitleTextAttributes:dict];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
}

/// 配置融云
- (void)connectRongCloubWithKey:(NSString *)key {
    [[RCIM sharedRCIM] initWithAppKey:key];
    //设置会话列表头像和会话界面头像
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    if (iPhone6plus) {
        [RCIM sharedRCIM].globalConversationPortraitSize = CGSizeMake(56, 56);
    } else {
        [RCIM sharedRCIM].globalConversationPortraitSize = CGSizeMake(46, 46);
    }
    //导航栏文字颜色
    [RCIM sharedRCIM].globalNavigationBarTintColor = [UIColor blackColor];
    //    [RCIM sharedRCIM].portraitImageViewCornerRadius = 10;
    //设置接收消息代理
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    //开启输入状态监听
    [RCIM sharedRCIM].enableTypingStatus = YES;
    //开启发送已读回执（只支持单聊）
    [RCIM sharedRCIM].enableReadReceipt = YES;
    [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    //设置显示未注册的消息
    //如：新版本增加了某种自定义消息，但是老版本不能识别，开发者可以在旧版本中预先自定义这种未识别的消息的显示
    [RCIM sharedRCIM].showUnkownMessage = YES;
    [RCIM sharedRCIM].showUnkownMessageNotificaiton = YES;
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    if (token != nil) {
        [UIViewController loginRongCloub];
    }
}

#pragma mark - RCIMConnectionStatusDelegate
/**
 *  网络状态变化。
 *
 *  @param status 网络状态。
 */
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        [DataManager sharedManager].isRongCloubLogin = NO;
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"您的帐号在别的设备上登录，您被迫下线！"
                              delegate:self
                              cancelButtonTitle:@"知道了"
                              otherButtonTitles:nil];
        [alert show];
    } else if (status == ConnectionStatus_TOKEN_INCORRECT) {
        [DataManager sharedManager].isRongCloubLogin = NO;
    }
}

#pragma mark - RCIMReceiveMessageDelegate
/*!
 接收消息的回调方法
 
 @param message     当前接收到的消息
 @param left        还剩余的未接收的消息数，left>=0
 
 @discussion 如果您设置了IMKit消息监听之后，SDK在接收到消息时候会执行此方法（无论App处于前台或者后台）。
 其中，left为还剩余的、还未接收的消息数量。比如刚上线一口气收到多条消息时，通过此方法，您可以获取到每条消息，left会依次递减直到0。
 您可以根据left数量来优化您的App体验和性能，比如收到大量消息时等待left为0再刷新UI。
 */
- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left
{
    if ([message.content isMemberOfClass:[RCInformationNotificationMessage class]]) {
        RCInformationNotificationMessage *msg=(RCInformationNotificationMessage *)message.content;
        if ([msg.message rangeOfString:@"你已添加了"].location!=NSNotFound) {
        }
    }
}

/**
 *此方法中要提供给融云用户的信息，建议缓存到本地，然后改方法每次从您的缓存返回
 */
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
{
    //此处为了演示写了一个用户信息
    if ([@"915" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"915";
        user.name = @"客服";
        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
        return completion(user);
    }else {
        RCUserInfo *user = [[RCIM sharedRCIM] getUserInfoCache:userId];
        return completion(user);
    }
}

#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_TOKEN];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:RongCloub_Token];
    [Mtarbar.selectedViewController dismissViewControllerAnimated:YES completion:nil];
    [[RCIM sharedRCIM] logout];
}

@end
