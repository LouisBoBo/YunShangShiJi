//
//  vipInfoModel.m
//  YunShangShiJi
//
//  Created by hebo on 2019/6/21.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "vipInfoModel.h"

@implementation vipInfoModel
+ (void)Getvip_userInfoDataSuccess:(NSString*)shop_code T:(NSInteger)t Page:(NSInteger)page3 Success:(void (^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"userVipCard/vipBuyShopInfo?token=%@&version=%@&shop_code=%@&t=%zd&page3=%zd",token,VERSION,shop_code,t,page3];
    [self getDataResponsePath:path success:success];
}

+ (void)addUserVipOrderSuccess:(void(^)(id))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"userVipCard/userIsVip?token=%@&version=%@",token,VERSION];
    [self getDataResponsePath:path success:success];
}
@end
