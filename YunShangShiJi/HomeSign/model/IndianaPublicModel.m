//
//  IndianaPublicModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/6/30.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "IndianaPublicModel.h"

@implementation IndianaPublicModel
+(void)saveShareStaue:(NSString*)shopcode success:(void(^)(id data))success
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"treasures/shareAdd?token=%@&version=%@&shop_code=%@",token,VERSION,shopcode];
    [self getDataResponsePath:path success:success];
}

+(void)getShareStatuesuccess:(void(^)(id data))success
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"treasures/shareQuery?token=%@&version=%@",token,VERSION];
    [self getDataResponsePath:path success:success];
}
+(void)H5getMoney:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"wallet/getZeroCount?token=%@&version=%@",token,VERSION];
    
    [self getDataResponsePath:path success:success];
}
@end
