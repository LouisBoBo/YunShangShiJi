//
//  GoldCouponModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/10/9.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "GoldCouponModel.h"

@implementation GoldCouponModel

+ (NSMutableDictionary *)getMapping
{
    NSMutableDictionary *mapping = [NSMutableDictionary dictionaryWithObjectsAndKeys:[GoldModel mappingWithKey:@"twofoldnessGold"], @"twofoldnessGold", [GoldcpModel mappingWithKey:@"CpGold"], @"CpGold", nil];
    return mapping;
}

+(void)getGoldCoupons:(NSString*)str success:(void(^)(id data))success
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"wallet/%@?token=%@&version=%@",str,token,VERSION];
    [self getDataResponsePath:path success:success];
}

@end
