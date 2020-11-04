//
//  HobbyModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/1/6.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "HobbyModel.h"

@implementation HobbyModel
+ (void)getDataSuccess:(void (^)(id data))success
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"shop/getUserHobbyData?token=%@&version=%@",token,VERSION];
    
    [self getDataResponsePath:path success:success];

}
@end
