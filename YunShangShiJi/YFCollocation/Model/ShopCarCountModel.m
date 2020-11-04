//
//  ShopCarCountModel.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/22.
//  Copyright © 2016年 ios-1. All rights reserved.
//  购物车数量

#import "ShopCarCountModel.h"

@implementation ShopCarCountModel

+ (void)getShopCarCountWithSuccess:(void (^)(id))success {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"shopCart/shopCartCount?version=%@&token=%@",VERSION,token];
    [self getDataResponsePath:urlStr success:success];
}

@end
