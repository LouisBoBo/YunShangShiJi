//
//  hongBaoModel.m
//  YunShangShiJi
//
//  Created by hebo on 2019/12/30.
//  Copyright © 2019 ios-1. All rights reserved.
//

#import "hongBaoModel.h"

@implementation hongBaoModel
+ (void)GetDataSuccess:(void(^)(id data))success;
{
    NSString *path = [NSString stringWithFormat:@"/cfg/config_switch?version=%@",VERSION];
    [self getDataResponsePath:path success:success];
}
@end
