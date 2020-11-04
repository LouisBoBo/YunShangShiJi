//
//  APIClient.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/5.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "APIClient.h"
#import "NetTool.h"

#import "GlobalTool.h"
#import "TFPublicClass.h"
#import "NSObject+TFCommon.h"
@implementation APIClient

+ (APIClient *)sharedManager{
    static APIClient *manager=nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        if (manager==nil) {
            manager=[[APIClient alloc]init];
        }
    });
    return manager;
}
- (void)callNetToolFromPath:(NSString *)path caches:(BOOL)caches cachesTimeInterval:(NSTimeInterval)timeInterval success:(void (^)(id data,Response *response))success failure:(void(^)(NSError *error)) failure
{
    
    [[NetTool shareManager] httpGetRequest:path withParameter:nil withCaches:caches withCachesTimeInterval:timeInterval withBlock:^(id data, Response *response, NSError *error) {
        if (data) {
            success(data, response);
        } else {
            failure(error);
        }
    }];
}

//公用请求
- (void)callNetToolFromApi:(NSString *)api parameter:(NSDictionary *)parameter caches:(BOOL)caches cachesTimeInterval:(NSTimeInterval)timeInterval success:(void (^)(id data,Response *response))success failure:(void(^)(NSError *error)) failure
{
    NSString *path = [NSString stringWithFormat:@"%@%@", api, [parameter getStringFromDictionaryKeysAndValues]];
    [self callNetToolFromPath:path caches:caches cachesTimeInterval:timeInterval success:success failure:failure];
}

//有参数通用请求 (token和parameter)
- (void)netWorkGeneralRequestWithApi:(NSString *)api parameter:(NSDictionary *)parameter caches:(BOOL)caches cachesTimeInterval:(NSTimeInterval)timeInterval token:(BOOL)isToken success:(void (^)(id data,Response *response))success failure:(void(^)(NSError *error))failure
{
    NSMutableDictionary *muParameter = [NSMutableDictionary dictionary];
    NSArray *allKeys = [parameter allKeys];
    if (isToken) {
        NSString *token = [TFPublicClass getTokenFromLocal];
        if (token!=nil) {
            [muParameter setObject:token forKey:@"token"];
        }
        [muParameter setObject:VERSION forKey:@"version"];
    } else {
        [muParameter setObject:VERSION forKey:@"version"];
    }

    if (allKeys.count) {
        [muParameter addEntriesFromDictionary:parameter];
    }
    [self callNetToolFromApi:api parameter:muParameter caches:caches cachesTimeInterval:timeInterval success:success failure:failure];
}
- (void)StatisticsnetWorkGeneralRequestWithApi:(NSString *)api parameter:(NSDictionary *)parameter caches:(BOOL)caches cachesTimeInterval:(NSTimeInterval)timeInterval token:(BOOL)isToken success:(void (^)(id data,Response *response))success failure:(void(^)(NSError *error))failure
{
    NSMutableDictionary *muParameter = [NSMutableDictionary dictionary];
    NSArray *allKeys = [parameter allKeys];
    if (isToken) {
        NSString *token = [TFPublicClass getTokenFromLocal];
        if (token!=nil) {
            [muParameter setObject:token forKey:@"token"];
        }
        [muParameter setObject:VERSION forKey:@"version"];
    } else {
        [muParameter setObject:VERSION forKey:@"version"];
    }
    if (allKeys.count) {
        [muParameter addEntriesFromDictionary:parameter];
    }
    [self callNetToolFromApi:api parameter:muParameter caches:caches cachesTimeInterval:timeInterval success:success failure:failure];
}

//无参数通用请求 (只token)
- (void)netWorkGeneralRequestWithApi:(NSString *)api caches:(BOOL)caches cachesTimeInterval:(NSTimeInterval)timeInterval token:(BOOL)isToken success:(void (^)(id data,Response *response))success failure:(void(^)(NSError *error))failure
{
    [self netWorkGeneralRequestWithApi:api parameter:nil caches:caches cachesTimeInterval:timeInterval token:isToken success:success failure:failure];
}

- (void)netWorkGetHomePageListWithFromType:(NSString *)fromType pageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum  typeID:(NSNumber *)typeID typeName:(NSString *)typeName Sort:(NSString*)sort success:(void (^)(id data,Response *response))success failure:(void(^)(NSError *error)) failure;
{
    NSString *token = [TFPublicClass getTokenFromLocal];
    NSString *api;
    NSDictionary *parameter = nil;
    if ([fromType isEqualToString:@"购物"]) {
        if (token) {
            api = kApi_shop_queryCondition;
            parameter = @{@"token": token,
                          @"version": VERSION,
                          @"type1":typeID,
                          @"pager.curPage": [NSNumber numberWithInteger:pageNum],
                          @"pager.pageSize": [NSNumber numberWithInteger:pageSize],
                          @"pager.sort": sort};
            
        } else {
            api = kApi_shop_queryConUnLogin;
            parameter = @{@"version": VERSION,
                          @"type1":typeID,
                          @"pager.curPage": [NSNumber numberWithInteger:pageNum],
                          @"pager.pageSize": [NSNumber numberWithInteger:pageSize],
                          @"pager.sort": sort};
        }
        
    }
    [self callNetToolFromApi:api parameter:parameter caches:YES cachesTimeInterval:TFMinute success:success failure:failure];

}
- (void)netWorkGetHomePageListWithFromType:(NSString *)fromType pageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum  typeID:(NSNumber *)typeID typeName:(NSString *)typeName success:(void (^)(id data,Response *response))success failure:(void(^)(NSError *error)) failure
{
    NSString *token = [TFPublicClass getTokenFromLocal];
    NSString *api;
    NSDictionary *parameter = nil;
    if ([fromType isEqualToString:@"购物"]) {
        if (token) {
            api = kApi_shop_queryCondition;
            parameter = @{@"token": token,
                          @"version": VERSION,
                          @"code": @"1",
                          @"type1":typeID,
                          @"type_name": typeName,
                          @"pager.curPage": [NSNumber numberWithInteger:pageNum],
                          @"pager.pageSize": [NSNumber numberWithInteger:pageSize]};
            
        } else {
            api = kApi_shop_queryConUnLogin;
            parameter = @{@"version": VERSION,
                          @"code": @"1",
                          @"type1":typeID,
                          @"type_name": typeName,
                          @"pager.curPage": [NSNumber numberWithInteger:pageNum],
                          @"pager.pageSize": [NSNumber numberWithInteger:pageSize]};
        }
        
    } else if ([fromType isEqualToString:@"店铺美衣"]) {
        api = kApi_shop_queryShop;
        parameter = @{@"token": token,
                      @"version": VERSION,
                      @"type1":typeID,
                      @"type_name": typeName,
                      @"pager.curPage": [NSNumber numberWithInteger:pageNum],
                      @"pager.pageSize": [NSNumber numberWithInteger:pageSize]};
    }else if ([fromType isEqualToString:@"我的购买"])
    {
        api = kApi_myshop_queryShop;
        parameter = @{@"token": token,
                      @"version": VERSION,
                      @"pager.curPage": [NSNumber numberWithInteger:pageNum],
                      @"pager.pageSize": [NSNumber numberWithInteger:pageSize]};

    }else if ([fromType isEqualToString:@"我的最爱"])
    {
        api = kApi_mylike_queryShop;
        parameter = @{@"token": token,
                      @"version": VERSION,
                      @"pager.curPage": [NSNumber numberWithInteger:pageNum],
                      @"pager.pageSize": [NSNumber numberWithInteger:pageSize]};
    }else if ([fromType isEqualToString:@"生活"])
    {
        api = KApi_Package_queryShop;
        parameter = @{@"p_type": @"0",
                      @"version": VERSION,
                      @"pager.order":@"desc",
                      @"pager.curPage": [NSNumber numberWithInteger:pageNum],
                      @"pager.pageSize": [NSNumber numberWithInteger:pageSize]};
    }else if ([fromType isEqualToString:@"新人钜惠"])
    {
        api = @"homePage3shop/dataShopList?";
        parameter = @{@"version": VERSION,
                      @"pager.curPage": [NSNumber numberWithInteger:pageNum],
                      @"pager.pageSize": [NSNumber numberWithInteger:pageSize]};
    }
    [self callNetToolFromApi:api parameter:parameter caches:YES cachesTimeInterval:TFMinute success:success failure:failure];
}

- (void)netWorkGetBrowsePageListWithPageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum success:(void (^)(id data,Response *response))success failure:(void(^)(NSError *error))failure
{
    NSString *token = [TFPublicClass getTokenFromLocal];
    if (token == nil) {
        return;
    }
    NSDictionary *parameter = @{@"token": token,
                                @"version": VERSION,
                                @"curPage": [NSNumber numberWithInteger:pageNum],
                                @"pageSize": [NSNumber numberWithInteger:pageSize]};
    
    [self callNetToolFromApi:kApi_shop_queryBrowseShopList parameter:parameter caches:YES cachesTimeInterval:TFMinute success:success failure:failure];
}

- (void)netWorkGetBrowsePageListWithPageSize:(NSInteger)pageSize Sort:(NSString*)sort pageNum:(NSInteger)pageNum success:(void (^)(id data,Response *response))success failure:(void(^)(NSError *error))failure;
{
    NSString *token = [TFPublicClass getTokenFromLocal];
    if (token == nil) {
        return;
    }
    
    NSDictionary *parameter = @{@"token": token,
                                @"version": VERSION,
                                @"curPage": [NSNumber numberWithInteger:pageNum],
                                @"pageSize": [NSNumber numberWithInteger:pageSize],
                                @"sort": sort};
    
    [self callNetToolFromApi:kApi_shop_queryBrowseShopList parameter:parameter caches:YES cachesTimeInterval:TFMinute success:success failure:failure];

}

- (void)netWorkGetBrowsePageListWithReduceMoneysuccess:(void (^)(id data,Response *response))success failure:(void(^)(NSError *error))failure
{
    NSString *token = [TFPublicClass getTokenFromLocal];
    if (token == nil) {
        return;
    }
    NSDictionary *parameter = @{@"token": token,
                                @"version": VERSION,};
    
    [self callNetToolFromApi:kApi_user_reduceMoney parameter:parameter caches:YES cachesTimeInterval:TFMinute success:success failure:failure];
}
@end
