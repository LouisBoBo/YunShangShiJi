//
//  OneYuanModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2018/3/18.
//  Copyright © 2018年 ios-1. All rights reserved.
//

#import "OneYuanModel.h"

@implementation OneYuanModel
+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[OneYuanDataModel mappingWithKey:@"data"],@"data",nil];
    return mapping;
}

+ (void)GetOneYuanDataSuccess:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"/cfg/on_off_3_7?token=%@&version=%@",token,VERSION];
    [self getDataResponsePath:path success:success];
}

+ (void)GetOneYuanCountSuccess:(void (^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"order/getZeroOrderDeductible?token=%@&version=%@",token,VERSION];
    [self getDataResponsePath:path success:success];
}

+ (void)GetOneYuanFinishOrder_code:(NSString*)order_code Success:(void (^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"order/updateOrderOneFrom?token=%@&version=%@&order_code=%@",token,VERSION,order_code];
    [self getDataResponsePath:path success:success];
}

+ (void)GetCouponDataSuccess:(void(^)(id data))success;
{
    NSString *path = [NSString stringWithFormat:@"/coupon/getRollCoupon?version=%@",VERSION];
    [self getDataResponsePath:path success:success];
}

+ (void)getNewUserOrderSucceww:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"order/getNewUserOrder?token=%@&version=%@",token,VERSION];
    [self getDataResponsePath:path success:success];
}

@end

@implementation OneYuanDataModel

@end
