//
//  TypeShareModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/10/12.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TypeShareModel.h"

@implementation TypeShareModel

+ (void)getTypeCodeWithShop_code:(NSString *)shop_code
                         success:(void (^)(TypeShareModel *data))success;
{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]?:@"";
    NSString *path = [NSString stringWithFormat:@"shop/queryShopType2?version=%@&token=%@&shop_code=%@",VERSION,token,shop_code];
    [self getDataResponsePath:path success:success];
}
+ (void)getNewbieHTTP:(void (^)(TypeShareModel *data))success;
{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]?:@"";
    NSString *path = [NSString stringWithFormat:@"signIn2_0/getCount?version=%@&token=%@",VERSION,token];
    [self getDataResponsePath:path success:success];
}
@end
