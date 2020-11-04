//
//  ShopCarModel.m
//  YunShangShiJi
//
//  Created by zgl on 16/8/5.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "ShopCarModel.h"

@implementation ShopCarModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _paired_code =  @"";
        _shop_code = @"";
        _shop_name =  @"";
        _def_pic =  @"";
        _color =  @"";
        _size =  @"";
        _shop_num = 0;
    }
    return self;
}

+ (LKDBHelper *)getUsingLKDBHelper {
   return [[LKDBHelper alloc] initWithDBName:[self getUserDBName]];
}

//主键
+ (NSString *)getPrimaryKey {
    return @"ID";
}

///复合主键  这个优先级最高
+ (NSArray *)getPrimaryKeyUnionArray {
    return @[@"shop_code",@"stock_type_id"];
}

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:@"ID",@"id",nil];
    return mapping;
}

@end
