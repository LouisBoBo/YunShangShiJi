//
//  Signmanager.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/8/23.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "Signmanager.h"

@implementation Signmanager

+ (Signmanager *)SignManarer {
    static Signmanager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        assert(sharedManager != nil);
    });
    return sharedManager;
}

@end
