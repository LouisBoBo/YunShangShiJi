//
//  CitysSubModel.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/21.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "CityModel.h"


@implementation CityModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSMutableArray *)AREAS
{
    if (_AREAS == nil) {
        _AREAS = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in self.areas) {
            AreaModel *model = [[AreaModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            model.ID = dic[@"id"];
            [_AREAS addObject:model];
        }
    }
    return _AREAS;
}

@end
