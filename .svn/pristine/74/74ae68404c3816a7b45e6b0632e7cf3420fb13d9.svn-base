//
//  APIClient.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/5.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Response.h"
#import "Urls.h"
@interface APIClient : NSObject


//单例自行实例化
+ (APIClient *)sharedManager;

/**
 *  无参数通用请求 (只token)
 *
 *  @param api          <#api description#>
 *  @param caches       <#caches description#>
 *  @param timeInterval <#timeInterval description#>
 *  @param isToken      <#isToken description#>
 *  @param success      <#success description#>
 *  @param failure      <#failure description#>
 */
- (void)netWorkGeneralRequestWithApi:(NSString *)api caches:(BOOL)caches cachesTimeInterval:(NSTimeInterval)timeInterval token:(BOOL)isToken success:(void (^)(id data,Response *response))success failure:(void(^)(NSError *error))failure;

//有参数通用请求 (token和parameter)
- (void)netWorkGeneralRequestWithApi:(NSString *)api parameter:(NSDictionary *)parameter caches:(BOOL)caches cachesTimeInterval:(NSTimeInterval)timeInterval token:(BOOL)isToken success:(void (^)(id data,Response *response))success failure:(void(^)(NSError *error))failure;
/**
 *  获取购物list数据
 */

- (void)netWorkGetHomePageListWithFromType:(NSString *)fromType pageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum  typeID:(NSNumber *)typeID typeName:(NSString *)typeName success:(void (^)(id data,Response *response))success failure:(void(^)(NSError *error)) failure;

- (void)netWorkGetHomePageListWithFromType:(NSString *)fromType pageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum  typeID:(NSNumber *)typeID typeName:(NSString *)typeName Sort:(NSString*)sort success:(void (^)(id data,Response *response))success failure:(void(^)(NSError *error)) failure;
/**
 *  强制浏览list数据
 */
- (void)netWorkGetBrowsePageListWithPageSize:(NSInteger)pageSize pageNum:(NSInteger)pageNum success:(void (^)(id data,Response *response))success failure:(void(^)(NSError *error))failure;

/**
 *  强制浏览list排序数据
 */
- (void)netWorkGetBrowsePageListWithPageSize:(NSInteger)pageSize Sort:(NSString*)sort pageNum:(NSInteger)pageNum success:(void (^)(id data,Response *response))success failure:(void(^)(NSError *error))failure;
/*
 界面跳出统计 时长统计 2017-4-17
 */
- (void)StatisticsnetWorkGeneralRequestWithApi:(NSString *)api parameter:(NSDictionary *)parameter caches:(BOOL)caches cachesTimeInterval:(NSTimeInterval)timeInterval token:(BOOL)isToken success:(void (^)(id data,Response *response))success failure:(void(^)(NSError *error))failure;
/**
 获取用户余额抵扣
 */
- (void)netWorkGetBrowsePageListWithReduceMoneysuccess:(void (^)(id data,Response *response))success failure:(void(^)(NSError *error))failure;
@end
