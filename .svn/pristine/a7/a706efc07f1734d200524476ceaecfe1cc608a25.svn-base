//
//  QualificationsModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/18.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "QualificationsModel.h"

@implementation QualificationsModel
+(void)getQualificationsSuccess:(void(^)(id data))success;
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"/fc/getSA?token=%@&version=%@",token,VERSION];
    [self getDataResponsePath:path success:success];
}
@end
