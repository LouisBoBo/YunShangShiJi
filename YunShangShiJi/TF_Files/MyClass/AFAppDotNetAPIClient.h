//
//  AFAppDotNetAPIClient.h
//  TFTestDemo
//
//  Created by 云商 on 15/10/17.
//  Copyright © 2015年 云商. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import <Foundation/Foundation.h>

@class AFAppDotNetAPIClient;

//全局网络监听

@interface AFAppDotNetAPIClient : AFHTTPSessionManager

@property (nonatomic, copy)NSString *netStatus;

+ (instancetype)sharedClient;


@end