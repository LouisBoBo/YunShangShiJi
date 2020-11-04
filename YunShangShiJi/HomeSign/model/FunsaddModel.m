//
//  FunsaddModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/9/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "FunsaddModel.h"

@implementation FunsaddModel

+ (void)getFunsHeadimageAndNickname:(void (^)(id data))success
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"slb/queryBarr?version=%@&token=%@",VERSION,token];
    [self getDataResponsePath:urlStr success:success];
}
@end
