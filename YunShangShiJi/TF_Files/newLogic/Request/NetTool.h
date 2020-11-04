//
//  NetTool.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/5.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Response.h"
#import "PhotoOperate.h"
@interface NetTool : NSObject

+ (NetTool *)shareManager;

#pragma 监测网络的可链接性
- (BOOL) netWorkReachabilityWithURLString:(NSString *) strUrl;
/**
 *  get请求
 *
 *  @param url     url
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)httpGetRequest:(NSString *)url withParameter:(NSDictionary *)parameter withCaches:(BOOL)caches withCachesTimeInterval:(NSTimeInterval)timeInterval withBlock:(void (^)(id data, Response *response, NSError *error))block;

/**
 *  post 请求
 *
 *  @param url       url
 *  @param parameter 输入参数
 *  @param success   成功回调
 *  @param failure   失败回调
 */
- (void)httpPostRequest:(NSString *)url withParameter:(NSDictionary *)parameter success:(void (^)(id data, Response *response))success failure:(void (^)(NSError *error))failure;



@end
