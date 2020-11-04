//
//  RCTokenModel.m
//  YunShangShiJi
//
//  Created by zgl on 16/5/30.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "RCTokenModel.h"
#import "GlobalTool.h"

@implementation RCTokenModel

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[RCModel mappingWithKey:@"data"],
          @"data",nil];
    return mapping;
}

+ (void)getRCTokenModelSuccess:(void (^)(id))success {
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"user/getRongyunToken?token=%@&version=%@",token,VERSION];
    [self getDataResponsePath:path success:success];
}

@end

@implementation RCModel

@end