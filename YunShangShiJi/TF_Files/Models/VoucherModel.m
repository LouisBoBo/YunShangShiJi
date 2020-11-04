//
//  VoucherModel.m
//  YunShangShiJi
//
//  Created by zgl on 16/5/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "VoucherModel.h"

@implementation VoucherModel

- (instancetype)init
{
    if (self = [super init]) {
        _usedNum = 0;
    }
    return self;
}

//自定义排序方法
-(NSComparisonResult)comparePerson:(VoucherModel *)model
{
    NSComparisonResult result = [[NSNumber numberWithInt:model.price] compare:[NSNumber numberWithInt:self.price]];//注意:基本数据类型要进行数据转换

    return result;
}



@end
