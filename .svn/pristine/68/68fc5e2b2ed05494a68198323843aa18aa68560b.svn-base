//
//  VitalityModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2016/11/18.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "VitalityModel.h"

@implementation VitalityModel
+(void)getVitality:(void(^)(id data))success
{
    if([DataManager sharedManager].grade==1){
        
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
        NSString *urlStr = [NSString stringWithFormat:@"user/delUserType?token=%@&version=%@",token,VERSION];
        [self getDataResponsePath:urlStr success:success];
    }
}

+(void)posguide:(void(^)(id data))success
{
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"user/delUserType?token=%@&version=%@",token,VERSION];
    [self getDataResponsePath:urlStr success:success];
    
}
@end
