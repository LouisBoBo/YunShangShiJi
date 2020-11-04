//
//  CitysModel.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/21.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "StateModel.h"

@implementation StateModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

- (NSMutableArray *)CITIES
{
    if (_CITIES == nil) {
        _CITIES = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in self.cities) {
            CityModel *model = [[CityModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            model.ID = dic[@"id"];
            [_CITIES addObject:model];
        }
    }
    return _CITIES;
}
@end
