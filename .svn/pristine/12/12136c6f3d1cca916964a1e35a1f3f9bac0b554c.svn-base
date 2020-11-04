//
//  MemberModel.m
//  YunShangShiJi
//
//  Created by hebo on 2019/5/27.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "MemberModel.h"
#import "vipDataModel.h"
#import "uservipDataModel.h"
@implementation MemberModel
+ (void)getVipData:(NSInteger)jupm Success:(void(^)(id))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"userVipType/queryByVipList?token=%@&version=%@&jump=%zd",token,VERSION,jupm];
    [self getDataResponsePath:path success:success];
}

+ (void)addUserVipCard:(NSInteger)vipcount VipType:(NSInteger)viptype Success:(void(^)(id))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"userVipCard/addUserVipCard?token=%@&version=%@&vip_count=%zd&vip_type=%zd",token,VERSION,vipcount,viptype];
    [self getDataResponsePath:path success:success];
}
+ (void)addUserVipOrder:(NSString*)vipcode Success:(void(^)(id))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"wxpaycx/wapUinifiedOrderList?token=%@&version=%@&vip_code=%@",token,VERSION,vipcode];
    [self getDataResponsePath:path success:success];
}
+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[vipDataModel mappingWithKey:@"vipdata"],@"viplist",[uservipDataModel mappingWithKey:@"uservipdata"],@"userVipList",nil];
    return mapping;
}

@end
