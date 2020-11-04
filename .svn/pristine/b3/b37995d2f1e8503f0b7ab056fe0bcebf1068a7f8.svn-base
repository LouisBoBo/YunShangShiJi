//
//  LuckModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2016/12/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "LuckModel.h"

@implementation LuckModel
+(void)getLuckHttpRedMoney:(BOOL)redMoney Success:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"wallet/doRaffle?token=%@&version=%@",token,VERSION];
    if(redMoney)
    {
        path = [NSString stringWithFormat:@"order/doRaffle?token=%@&version=%@",token,VERSION];
    }
    [self getDataResponsePath:path success:success];

}

+(void)getLuckHttpRedCount:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"wallet/getRaffleNum?token=%@&version=%@",token,VERSION];
    [self getDataResponsePath:path success:success];

}
+(void)getLuckHttpLotteryDraw:(NSString*)orderCode FirstGroup:(NSInteger)firstGroup Success:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *apistr = firstGroup > 0 ? @"order/lotteryDraw2" : @"order/lotteryDraw";
    NSString *path = [NSString stringWithFormat:@"%@?token=%@&version=%@&order_code=%@",apistr,token,VERSION,orderCode];
    
    [self getDataResponsePath:path success:success];
}
+(void)getLuckHttpOrNotPrize:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"order/getOrderRaffleOrNotPrize?token=%@&version=%@",token,VERSION];
    [self getDataResponsePath:path success:success];
}

+(void)getLuckHttpLuckDraw:(BOOL)Prize orderCode:(NSString*)orderCode FirstGroup:(NSInteger)firstGroup Success:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *apistr = firstGroup > 0 ? @"order/luckDraw2" : @"order/luckDraw";
    NSString *path = [NSString stringWithFormat:@"%@?token=%@&version=%@&order_code=%@&whether_prize=%d",apistr,token,VERSION,orderCode,Prize?0:1];
    [self getDataResponsePath:path success:success];
}
@end
