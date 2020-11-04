//
//  CartLikeModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/1/19.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "CartLikeModel.h"

@implementation CartLikeModel

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[LikeModel mappingWithKey:@"likeArray"],@"list",nil];
    return mapping;
}

+ (void)getLikeDataSuccess:(NSInteger)page Success:(void(^)(id))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"like/queryGuessLikeShop?token=%@&version=%@&curPage=%d&pageSize=10",token,VERSION,(int)page];
    [self getDataResponsePath:path success:success];
}

@end
