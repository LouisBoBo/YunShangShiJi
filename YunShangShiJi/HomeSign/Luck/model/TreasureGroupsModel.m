
//
//  TreasureGroupsModel.m
//  YunShangShiJi
//
//  Created by YF on 2017/9/1.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TreasureGroupsModel.h"

@implementation TreasureGroupsModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.user=[NSMutableArray array];
    }
    return self;
}
-(NSMutableArray *)user
{
    if (_user==nil) {
        _user = [NSMutableArray array];
    }
    return _user;
}
@end
