//
//  GuideLuckModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/6/22.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "GuideLuckModel.h"

@implementation GuideLuckModel
+(void)getGuideLuckHttpSuccess:(void(^)(id data))success
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"wallet/yiDouHalve?token=%@&version=%@",token,VERSION];
    
    [self getDataResponsePath:path success:success];
}
@end
