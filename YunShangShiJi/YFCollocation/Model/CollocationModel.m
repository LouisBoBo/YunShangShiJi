//
//  CollocationModel.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/21.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "CollocationModel.h"

@implementation CollocationModel

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:@"cID",@"id",[CollocationShopModel mappingWithKey:@"collocation_shop"],@"collocation_shop", [CollocationTypeModel mappingWithKey:@"shop_type_list"],@"shop_type_list",nil];
    return mapping;
}

@end
