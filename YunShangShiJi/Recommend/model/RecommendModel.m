//
//  RecommendModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/14.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "RecommendModel.h"

@implementation RecommendModel
+ (NSMutableDictionary *)getMapping
{
    NSMutableDictionary *mapping = [NSMutableDictionary dictionaryWithObjectsAndKeys:[RecommendLikeModel mappingWithKey:@"likes"], @"likes",[ShopShareModel mappingWithKey:@"list"],@"list",@"isphone",@"bool",nil];
    return mapping;
}

+(void)getLikeData:(NSInteger)currentpage Success:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"like/qua?token=%@&version=%@&pager.curPage=%d&pager.pageSize=20",token,VERSION,(int)currentpage];
    [self getDataResponsePath:path success:success];
}

+(void)getShareData:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
//    NSString *path = [NSString stringWithFormat:@"like/queryProductsRecommendedShop?token=%@&version=%@",token,VERSION];
    NSString *path = [NSString stringWithFormat:@"like/queryProductsRecommendedShopAll?token=%@&version=%@",token,VERSION];
    [self getDataResponsePath:path success:success];

}

+(void)getPhoneData:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"user/queryPhone?token=%@&version=%@",token,VERSION];
    [self getDataResponsePath:path success:success];

}
@end
