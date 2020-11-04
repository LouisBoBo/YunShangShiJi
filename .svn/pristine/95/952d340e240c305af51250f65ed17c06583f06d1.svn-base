//
//  CollocationMainModel.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/21.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "CollocationMainModel.h"

@implementation CollocationMainModel

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[CollocationModel mappingWithKey:@"listShop"],@"listShop", [PagerModel mappingWithKey:@"pager"],@"pager",nil];
    return mapping;
}

+ (void)getCollocationMainModelWithPageSize:(NSInteger)pageSize curPager:(NSInteger)curPager success:(void (^)(id))success {
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]?:@"";
    NSString *path = [NSString stringWithFormat:@"collocationShop/queryShopCondition?token=%@&version=%@&pager.pageSize=%ld&pager.curPage=%ld",token,VERSION,(long)pageSize,(long)curPager];
    [self getDataResponsePath:path success:success];
}

+ (void)getCollocationMainModelWithType:(NSNumber *)type PageSize:(NSInteger)pageSize curPager:(NSInteger)curPager success:(void (^)(id))success {
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]?:@"";
    NSString *path = [NSString stringWithFormat:@"collocationShop/queryShopCondition?token=%@&version=%@&type=%@&pager.pageSize=%ld&pager.curPage=%ld",token,VERSION, type,(long)pageSize,(long)curPager];
    [self getDataResponsePath:path success:success];
}

+ (void)getLedBrowseCollocationMainModelWithPageSize:(NSInteger)pageSize curPager:(NSInteger)curPager success:(void (^)(id data))success;
{
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]?:@"";
    NSString *path = [NSString stringWithFormat:@"collocationShop/queryShopCondition?token=%@&version=%@&pager.pageSize=%ld&pager.curPage=%ld",token,VERSION,(long)pageSize,(long)curPager];
    [self getDataResponsePath:path success:success];

}

@end
