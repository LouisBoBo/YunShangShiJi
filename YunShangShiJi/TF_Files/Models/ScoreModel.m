//
//  ScoreModel.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/24.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "ScoreModel.h"

@implementation ScoreModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

- (NSMutableArray *)imgArr
{
    if (_imgArr == nil) {
        _imgArr = [[NSMutableArray alloc] init];
    }
    return _imgArr;
}

- (NSMutableArray *)imgNameArr
{
    if (_imgNameArr == nil) {
        _imgNameArr = [[NSMutableArray alloc] init];
    }
    return _imgNameArr;
}


@end
