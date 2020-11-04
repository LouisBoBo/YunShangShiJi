//
//  GoldCouponsManager.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/10/9.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "GoldCouponsManager.h"

@implementation GoldCouponsManager

+ (GoldCouponsManager *)goldcpManager {
    static GoldCouponsManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        assert(sharedManager != nil);
    });
    return sharedManager;
}

@end
