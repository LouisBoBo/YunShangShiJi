//
//  PictureVerificationModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/8/22.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "PictureVerificationModel.h"

@implementation PictureVerificationModel
+(void)getPictureVerificationCode:(NSString*)phone Success:(void(^)(id data))success;
{
    NSString *IMEI = [[NSUserDefaults standardUserDefaults] objectForKey:USER_UUID];
    NSString *path = [NSString stringWithFormat:@"vcode/getVcode?version=%@&phone=%@&imei=%@",VERSION,phone,IMEI];
    [self getDataResponsePath:path success:success];
}
@end
