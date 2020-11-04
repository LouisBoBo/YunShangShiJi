//
//  ValueObserver.m
//  YunShangShiJi
//
//  Created by 云商 on 15/10/9.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "ValueObserver.h"
static ValueObserver *instance = nil;
@implementation ValueObserver

+ (ValueObserver *) shareValueObserver
{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[ValueObserver alloc] init];
            instance.index = [NSNumber numberWithInt:0];
            instance.detail = [NSNumber numberWithInt:0];
            instance.shopping = [NSNumber numberWithInt:0];
            instance.order = [NSNumber numberWithInt:0];
            instance.affirm = [NSNumber numberWithInt:0];
            instance.myNewSign = [NSNumber numberWithInt:0];
            instance.zeroindex = [NSNumber numberWithInt:0];
        }
    });
    return instance;
}


- (instancetype)init
{
    if (self = [super init]) {
        self.index = @0;
     }
    return self;
}


@end
