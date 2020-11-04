//
//  ShareToFriendsModel.m
//  YunShangShiJi
//
//  Created by yssj on 16/7/26.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "ShareToFriendsModel.h"

@implementation ShareToFriendsModel

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[DataModel mappingWithKey:@"data"],@"data", nil];
    return mapping;
}
+ (void)getModelWithToken:(NSString *)token success:(void (^)(id))success {
    NSString *path = [NSString stringWithFormat:@"user/inviteFriend?token=%@&version=%@",token,VERSION];
    [self getDataResponsePath:path success:success];
}

@end

@implementation DataModel

@end