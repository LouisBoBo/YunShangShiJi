//
//  LaunchModel.m
//  YunShangShiJi
//
//  Created by zgl on 16/7/12.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "LaunchModel.h"

@implementation LaunchModel

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[LaunchImgModel mappingWithKey:@"data"],@"data",nil];
    return mapping;
}

+ (void)getLaunchModelWithSuccess:(void (^)(LaunchModel *))success {
    NSString *path = [NSString stringWithFormat:@"initiateApp/queryStartPage?version=%@",VERSION];
    [self getDataResponsePath:path success:success];
}

@end


@implementation LaunchImgModel

@end