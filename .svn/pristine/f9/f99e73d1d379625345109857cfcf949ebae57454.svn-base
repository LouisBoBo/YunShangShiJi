//
//  ShopLikeModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/14.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "ShopLikeModel.h"

@implementation ShopLikeModel
+(void)getShopLike:(NSString*)shopcode Success:(void(^)(id data))success
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"like/addLike?token=%@&version=%@&shop_code=%@",token,VERSION,shopcode];
    [self getDataResponsePath:path success:success];

}
+(void)getShopDisLike:(NSString*)shopcode Success:(void(^)(id data))success
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"like/delLike?token=%@&version=%@&shop_code=%@",token,VERSION,shopcode];
    [self getDataResponsePath:path success:success];
}
@end
