//
//  ShopSaleModel.m
//  YunShangShiJi
//
//  Created by zgl on 16/8/6.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "ShopSaleModel.h"

@implementation ShopSaleModel

+ (LKDBHelper *)getUsingLKDBHelper {
    return [[LKDBHelper alloc] initWithDBName:[self getUserDBName]];
}

//主键
+ (NSString *)getPrimaryKey {
    return @"ID";
}

///复合主键  这个优先级最高
+ (NSArray *)getPrimaryKeyUnionArray {
    return @[@"p_code",@"p_s_t_id"];
}

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[SaleListModel mappingWithKey:@"shop_list"],@"shop_list",@"ID",@"id",nil];
    return mapping;
}

@end
