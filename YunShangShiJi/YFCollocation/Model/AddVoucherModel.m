//
//  AddVoucherModel.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/17.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "AddVoucherModel.h"

@implementation AddVoucherModel

+ (void)getAddVoucherModelWithToken:(NSString *)token success:(void (^)(id))success {
    NSString *path = [NSString stringWithFormat:@"coupon/addVoucher?token=%@&version=%@",token,VERSION];
    [self getDataResponsePath:path success:success];
}

@end
