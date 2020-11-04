//
//  YFUserModel.m
//  YunShangShiJi
//
//  Created by zgl on 16/5/31.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YFUserModel.h"
#import "GlobalTool.h"

@implementation YFUserModel

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[YFUserInfoModel mappingWithKey:@"userinfo"],@"userinfo",nil];
    return mapping;
}

+ (void)getUserInfoWithUserId:(NSString *)userId success:(void (^)(id))success {
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"user/query_userinfo?token=%@&version=%@&User_id=%@",token,VERSION,userId];
    [self getDataResponsePath:path success:success];
}

@end
