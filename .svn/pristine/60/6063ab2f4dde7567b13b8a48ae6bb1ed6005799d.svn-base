//
//  NewPersonTask.m
//  YunShangShiJi
//
//  Created by 云商 on 16/3/12.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "NewPersonTask.h"

static NewPersonTask *npTask = nil;

@implementation NewPersonTask

+(NewPersonTask *)shareNewPersonTask
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (npTask == nil) {
            npTask = [[NewPersonTask alloc] init];
        }
    });
    return npTask;
}

@end
