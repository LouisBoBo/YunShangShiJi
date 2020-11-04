//
//  TopicviewModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/23.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TopicviewModel.h"
#import "TopicdetailsModel.h"
@implementation TopicviewModel
+ (NSMutableDictionary *)getMapping
{
    NSMutableDictionary *mapping = [NSMutableDictionary dictionaryWithObjectsAndKeys:[TopicdetailsModel mappingWithKey:@"data"], @"data",nil];
    return mapping;
}

+ (void)getDataTheme_id:(NSString*)theme_id Success:(void(^)(id data))sucess;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path ;
    if(token.length >10)
    {
        path = [NSString stringWithFormat:@"fc/topicDetails?&version=%@&theme_id=%@&token=%@",VERSION,theme_id,token];
    }else{
        path = [NSString stringWithFormat:@"fc/topicDetails?&version=%@&theme_id=%@",VERSION,theme_id];
    }
    [self getDataResponsePath:path success:sucess];
}
@end
