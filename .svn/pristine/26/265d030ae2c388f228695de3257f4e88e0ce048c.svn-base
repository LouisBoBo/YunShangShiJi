//
//  NetTool.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/5.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "NetTool.h"
#import "AFNetworking.h"
#import "GlobalTool.h"
#import "MyMd5.h"
@implementation NetTool
+ (NetTool *)shareManager{
    static NetTool *manager=nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
//        一次只允许一个请求
        if (manager==nil) {
            manager=[[NetTool alloc]init];
        }
    });
    return manager;
}

- (BOOL)netWorkReachabilityWithURLString:(NSString *) strUrl
{
    __block BOOL netState = NO;
    
    NSURL *baseURL = [NSURL URLWithString:strUrl];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    NSOperationQueue *operationQueue = manager.operationQueue;
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                netState = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netState = NO;
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    
    [manager.reachabilityManager startMonitoring];
    
    return netState;
}

- (void)httpPrivateGetRequest:(NSString *)url withParameter:(NSDictionary *)parameter withCaches:(BOOL)caches withCachesTimeInterval:(NSTimeInterval)timeInterval withBlock:(void (^)(id data, Response *response, NSError *error))block
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    //去掉json 返回的null
    //    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    //    response.removesKeysWithNullValues = YES;
    //    manager.responseSerializer = response;
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.requestSerializer.timeoutInterval = 5; /**< 超时设置5s */
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    /**< 暂时没用 */
    NSMutableArray *requestArray=[NSMutableArray array];
    for (NSString *request in requestArray) {
        if ([[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr],url] isEqualToString:request]) {
            return;
        }
    }
    [requestArray addObject:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr],url]];
    
    NSString *URLString = [MyMD5 authkey:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr],url]];
    [manager GET:URLString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        MyLog(@"\n===========URLString==========\n%@\n===========response===========\n%@\n", URLString, responseObject);
        
        if (block) {
            NSString *responseString=[operation responseString];
            NSData *data=[responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            jsonDic = [NSDictionary changeType:jsonDic];

            Response *responseObj=[Response yy_modelWithJSON:jsonDic];
            
            if (caches) {
                if (timeInterval) {
                    [NSObject saveTimeIntervalResponseData:jsonDic toPath:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr],url]];
                } else {
                    [NSObject saveResponseData:jsonDic toPath:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr],url]];
                }
            }
            
            block(jsonDic, responseObj, nil);
            [requestArray removeObject:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr],url]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        MyLog(@"\n===========URLString==========\n%@\n=============error============\n%@\n", URLString, error);
        if (block) {
            id jsonDic = nil;
            Response *responseObj = nil;
            if (caches) {
                jsonDic = [NSObject loadResponseWithPath:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr],url]];
                responseObj=[Response yy_modelWithJSON:jsonDic];
                responseObj.isCaches = YES;
            }
            block(jsonDic, responseObj, error);
            [requestArray removeObject:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr],url]];
        }
    }];
}

- (void)httpGetRequest:(NSString *)url withParameter:(NSDictionary *)parameter withCaches:(BOOL)caches withCachesTimeInterval:(NSTimeInterval)timeInterval withBlock:(void (^)(id data, Response *response, NSError *error))block
{
//    MyLog(@"url: %@", url);
    if (caches && timeInterval>0) {
//        MyLog(@"需要离线缓存且本地缓存");
        id responseObject = [NSObject loadTimeIntervalResponseWithPath:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr], url] withTimeInterval:timeInterval];
        if (responseObject) {
//            MyLog(@"本地缓存未过期->取缓存");
            Response *responseObj=[Response yy_modelWithJSON:responseObject];
            if (block) {
                block(responseObject, responseObj, nil);
            }
        } else {
//            MyLog(@"本地缓存已过期或者不存在->请求");
            [self httpPrivateGetRequest:url withParameter:parameter withCaches:caches withCachesTimeInterval:timeInterval withBlock:^(id data, Response *response, NSError *error) {
                block(data, response, error);
            }];
        }
    } else {
//        MyLog(@"不需要离线缓存或者不需要本地缓存->请求")
        [self httpPrivateGetRequest:url withParameter:parameter withCaches:caches withCachesTimeInterval:timeInterval withBlock:^(id data, Response *response, NSError *error) {
            block(data, response, error);
        }];
    }

}

- (void)httpPostRequest:(NSString *)url withParameter:(NSDictionary *)parameter success:(void (^)(id data, Response *response))success failure:(void (^)(NSError *error))failure
{
//    NSLog(@"........post request url:%@",url);
//    NSLog(@"........参数parameters:%@",parameter);
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.securityPolicy.allowInvalidCertificates=YES;
    
    
    
    /**< 暂时没用 */
    NSMutableArray *requestArray=[NSMutableArray array];
    for (NSString *request in requestArray) {
        if ([url isEqualToString:request]) {
            return;
        }
    }
    [requestArray addObject:url];
    
    NSString *URLString = [MyMD5 authkey:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr],url]];
    [manager POST:URLString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MyLog(@"\n===========response===========\n%@:\n%@", URLString, responseObject);
        if (success) {
            NSString *responseString=[operation responseString];
            NSData *data=[responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            Response *responseObj=[Response yy_modelWithJSON:jsonDic];
            
            success(jsonDic, responseObj);
            [requestArray removeObject:url];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
            [requestArray removeObject:url];
        }
    }];
}


@end


/**
 *
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    //去掉json 返回的null
    //AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    //response.removesKeysWithNullValues = YES;
    //manager.responseSerializer = response;

    manager.requestSerializer.timeoutInterval = 5;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    NSMutableArray *requestArray=[NSMutableArray array];
    for (NSString *request in requestArray) {
        if ([url isEqualToString:request]) {
            return;
        }
    }
    [requestArray addObject:url];

    NSString *URLString = [MyMD5 authkey:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr],url]];
    [manager GET:URLString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        MyLog(@"\n===========URLString==========\n%@\n===========response===========\n%@\n", URLString, responseObject);
        if (block) {
            NSString *responseString=[operation responseString];
            NSData *data=[responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            Response *responseObj=[Response yy_modelWithJSON:jsonDic];
            
            if (caches) {
                [NSObject saveResponseData:responseObject toPath:url];
            }
            
            
            block(jsonDic, responseObj, nil);
            [requestArray removeObject:url];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        MyLog(@"\n===========URLString==========\n%@\n=============error============\n%@\n", URLString, error);
        if (block) {
            id jsonDic = nil;
            Response *responseObj = nil;
            if (caches) {
                jsonDic = [NSObject loadResponseWithPath:url];
                responseObj=[Response yy_modelWithJSON:jsonDic];
                responseObj.isCaches = YES;
            }
            block(jsonDic, responseObj, error);
            [requestArray removeObject:url];
        }
    }];

 */
