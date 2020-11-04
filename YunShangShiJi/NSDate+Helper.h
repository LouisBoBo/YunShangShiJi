//
//  NSDate+Helper.h
//  YunShangShiJi
//
//  Created by zgl on 16/7/8.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Helper)

/// 系统当前时间
+ (void)systemCurrentTime:(void (^)(long long time))block;

@end
