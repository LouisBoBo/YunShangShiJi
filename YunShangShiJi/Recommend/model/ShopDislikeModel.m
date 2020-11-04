//
//  ShopDislikeModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/14.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "ShopDislikeModel.h"

@implementation ShopDislikeModel
+(void)getShopDisLike:(NSString*)shopcodes Success:(void(^)(id data))success
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSArray *arr = [shopcodes componentsSeparatedByString:@","];
    NSString *path = @"";
    if(arr.count >1)
    {
        path = [NSString stringWithFormat:@"like/delUAcc?token=%@&version=%@&shop_codes=%@",token,VERSION,shopcodes];
    }else{
        path = [NSString stringWithFormat:@"like/delUAcc?token=%@&version=%@&shop_code=%@",token,VERSION,shopcodes];
    }
    
    [self getDataResponsePath:path success:success];
}

+(void)apptimeStartistice:(int)timeInterval Success:(void(^)(id data))success
{
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *imei = [[NSUserDefaults standardUserDefaults] objectForKey:USER_UUID];
    
    NSString *path = [NSString stringWithFormat:@"apptimeStartistice/countActivation?token=%@&version=%@&timeInterval=%d&imei=%@",token,VERSION,timeInterval,imei];
    
    [self getDataResponsePath:path success:success];

}
@end
