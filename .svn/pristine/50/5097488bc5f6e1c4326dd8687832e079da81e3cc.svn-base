//
//  memberRawardsFriends.m
//  YunShangShiJi
//
//  Created by hebo on 2019/9/16.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "memberRawardsFriends.h"
#import "rawardsFriendsModel.h"
@implementation memberRawardsFriends


+ (void)getFriendsData:(NSInteger)page Success:(void(^)(id))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"wallet/getExtremeTiChengInfo?token=%@&version=%@&page=%zd",token,VERSION,page];
    [self getDataResponsePath:path success:success];
}

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[rawardsFriendsModel mappingWithKey:@"friendsdata"],@"data",nil];
    return mapping;
}

@end
