//
//  CollocationTypeModel.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/23.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "CollocationTypeModel.h"
#import "CollocationShopModel.h"

@implementation CollocationTypeModel

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[CollocationShopModel mappingWithKey:@"list"],@"list", nil];
    return mapping;
}
@end
