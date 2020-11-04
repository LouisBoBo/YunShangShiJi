//
//  CitysSSubModel.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/21.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "AreaModel.h"

@implementation AreaModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSMutableArray *)STREETS
{
    if (_STREETS == nil) {
        _STREETS = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in self.streets) {
            StreetModel *model = [[StreetModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            model.ID = dic[@"id"];
            [_STREETS addObject:model];
        }
    }
    return _STREETS;
}

@end
