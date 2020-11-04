//
//  AFAppDotNetAPIClient.m
//  TFTestDemo
//
//  Created by 云商 on 15/10/17.
//  Copyright © 2015年 云商. All rights reserved.
//

#import "AFAppDotNetAPIClient.h"
#import "AppDelegate.h"

static NSString * const AFAppDotNetAPIBaseURLString = @"https://api.app.net/";


@implementation AFAppDotNetAPIClient

+ (instancetype)sharedClient {
    
    static AFAppDotNetAPIClient *_sharedClient = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        [_sharedClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            switch (status) {
                    
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    
                    [_sharedClient netChangeWithCurrNet:@"WWAN"];
                    
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    
                    [_sharedClient netChangeWithCurrNet:@"WLAN"];
                    
                    break;
                    
                case AFNetworkReachabilityStatusNotReachable:
                    
                    [_sharedClient netChangeWithCurrNet:@"UNNET"];
                    
                    break;
                    
                default:
                    
                    break;
                    
            }
            
        }];
        
        [_sharedClient.reachabilityManager startMonitoring];
        
    });
    
    return _sharedClient;
    
}

- (void)netChangeWithCurrNet:(NSString *)net
{
    self.netStatus = net;
    
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:netStatusNotificationCenter object:self.netStatus userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    
}


@end
