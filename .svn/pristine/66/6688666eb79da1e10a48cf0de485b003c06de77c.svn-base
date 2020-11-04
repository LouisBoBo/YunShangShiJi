//
//  TaskSignModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/10/19.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TaskSignModel.h"

@implementation TaskSignModel

+(void)getTaskHttp:(NSString*)index_id Day:(NSString*)day Success:(void(^)(id data))success
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"signIn2_0/signIning?token=%@&version=%@&index_id=%@&day=%@",token,VERSION,index_id,day];
    
    [self getDataResponsePath:path success:success];
}

+(void)fabousHttpSuccess:(BOOL)isFirst :(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"point/pointOfPraise?token=%@&version=%@&isFirst=%d",token,VERSION,isFirst];
    
    [self getDataResponsePath:path success:success];
}

+(void)popupHttpSuccess:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"point/changePopup?token=%@&version=%@",token,VERSION];
    
    [self getDataResponsePath:path success:success];
}

+(void)fightStatusSuccess:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"/fightTeam/changeStatus?token=%@&version=%@",token,VERSION];
    
    [self getDataResponsePath:path success:success];
}

+(void)fightinitialSuccess:(NSString*)roll_code :(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"order/getRollInit?token=%@&version=%@&roll_code=%@",token,VERSION,roll_code];
    
    [self getDataResponsePath:path success:success];
}

//分享赢提现-夺宝的链接
+(void)IndiaHttpShopcode:(NSString*)shopcode :(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"/shop/getIndianaLink?token=%@&version=%@",token,VERSION];
    if(shopcode != nil)
    {
        path = [NSString stringWithFormat:@"/shop/getIndianaLink?token=%@&version=%@&shop_code=%@",token,VERSION,shopcode];
    }
    
    [self getDataResponsePath:path success:success];
}
+(void)IndiaHttpR_code:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"order/getRandRoll?token=%@&version=%@",token,VERSION];
    
    [self getDataResponsePath:path success:success];
}

+(void)TomorrowTaskTrailer:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"signIn2_0/queryNextTask?token=%@&version=%@",token,VERSION];
    
    [self getDataResponsePath:path success:success];
}
+(void)clockInHttp:(NSString*)curyearAndMonth :(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"clockIn/queryList?token=%@&version=%@&date=%@",token,VERSION,curyearAndMonth];
    
    [self getDataResponsePath:path success:success];
}
@end
