//
//  GuideIndianaModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/9/1.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "GuideIndianaModel.h"

@implementation GuideIndianaModel
+(void)guideIndianaDataSuccess:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path=[NSString stringWithFormat:@"rollTrea/queryISG?version=%@&token=%@",VERSION,token];
    [self getDataResponsePath:path success:success];
}

+(void)changIndianaDataSuccess:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path=[NSString stringWithFormat:@"rollTrea/updateISG?version=%@&token=%@",VERSION,token];
    [self getDataResponsePath:path success:success];
}
@end
