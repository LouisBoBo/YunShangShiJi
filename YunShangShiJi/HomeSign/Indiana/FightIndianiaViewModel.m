//
//  FightIndianiaViewModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/8/31.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "FightIndianiaViewModel.h"
#import "FightIndianaRecordModel.h"
@implementation FightIndianiaViewModel

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[FightIndianaRecordModel mappingWithKey:@"data"],@"data",nil];
    return mapping;
}

+(void)acticveIndianaHttpShopCode:(NSString*)shop_code Type:(NSInteger)type ID:(NSString*)tuserId Success:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = @"";
    
    if(type == 1)
    {
        path=[NSString stringWithFormat:@"rollTrea/participation?version=%@&shop_code=%@&token=%@&type=%zd",VERSION,shop_code,token,type];
    }else{
        path=[NSString stringWithFormat:@"rollTrea/participation?version=%@&shop_code=%@&token=%@&type=%zd&tuserId=%@",VERSION,shop_code,token,type,tuserId];
    }
    
    [self getDataResponsePath:path success:success];
}

+(void)activeRecordHttpShopCode:(NSString*)shop_code Issue_code:(NSString*)issue_code Page:(NSInteger)page Success:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path=[NSString stringWithFormat:@"rollTrea/pationData?version=%@&shop_code=%@&token=%@&issue_code=%@&page=%zd&rows=10",VERSION,shop_code,token,issue_code,page];
    [self getDataResponsePath:path success:success];
}
@end
