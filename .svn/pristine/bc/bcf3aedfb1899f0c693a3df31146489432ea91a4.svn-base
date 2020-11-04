
//
//  CartViewModel.m
//  YunShangShiJi
//
//  Created by yssj on 16/6/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "CartViewModel.h"

@implementation CartViewModel

+ (void)RejoinShopWithPaired_code:(NSString *)code Success:(void (^)(id))success {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"shopCart/reenter?version=%@&token=%@&paired_code=%@",VERSION,token,code];
    [self getDataResponsePath:urlStr success:success];
}
+ (void)RejoinShopWithID:(NSString *)code Success:(void (^)(id))success{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"shopCart/reenter?version=%@&token=%@&id=%@",VERSION,token,code];
    [self getDataResponsePath:urlStr success:success];
}
+(void)RejoinShopWithP_code:(NSString *)code Success:(void (^)(id))success{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"shopCart/reenter?version=%@&token=%@&p_code=%@",VERSION,token,code];
    [self getDataResponsePath:urlStr success:success];
}
+ (void)RejoinShopWithShopCode:(NSString *)code Success:(void (^)(id))success{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"shopCart/reenter?version=%@&token=%@&shop_code=%@",VERSION,token,code];
    [self getDataResponsePath:urlStr success:success];
}
+ (void)CheckShopListWithShopCodes:(NSString *)code Success:(void (^)(id))success{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"/shopCart/checkShopList?version=%@&token=%@&shop_codes=%@",VERSION,token,code];
    [self getDataResponsePath:urlStr success:success];
}
+ (void)CheckShopListWithP_Codes:(NSString *)code Success:(void (^)(id))success{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"/shopCart/checkShopList?version=%@&token=%@&p_codes=%@",VERSION,token,code];
    [self getDataResponsePath:urlStr success:success];
}
@end
