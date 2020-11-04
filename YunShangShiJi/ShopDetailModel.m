//
//  ShopDetailModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/29.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "ShopDetailModel.h"

@implementation ShopDetailModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.shopsArray=[NSMutableArray array];
    }
    return self;
}
-(NSMutableArray *)priceArray
{
    if (_priceArray==nil) {
        _priceArray = [NSMutableArray array];
    }
    return _priceArray;
}
-(NSMutableArray *)usedNunArray
{
    if (_usedNunArray==nil) {
        _usedNunArray = [NSMutableArray array];
    }
    return _usedNunArray;
}
@end
