//
//  DelRedDotModel.m
//  YunShangShiJi
//
//  Created by zgl on 16/7/26.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "DelRedDotModel.h"

@implementation DelRedDotModel

+ (void)getDelRegDotWithType:(DelRedDotType)type success:(void (^)(id data))success {
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]?:@"";
    NSString *path = nil;
    switch (type) {
        case DelRedDotTypeCoupon:
            path = [NSString stringWithFormat:@"coupon/delRedDot?version=%@&token=%@",VERSION,token];
            break;
        case DelRedDotTypeWallet:
            path = [NSString stringWithFormat:@"wallet/delRedDot?version=%@&token=%@",VERSION,token];
            break;
        default:
            break;
    }
    [self getDataResponsePath:path success:success];
}

@end
