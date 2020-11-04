//
//  TreasureRecordsModel.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/6.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TreasureRecordsModel.h"
#import "YYModel.h"
@implementation TreasureRecordsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSMutableArray *)USER
{
    if (!_USER) {
        _USER = [NSMutableArray array];
        
        for (NSDictionary *obj in self.user) {
            
            TreasureRecordsUser *user = [[TreasureRecordsUser alloc] init];
            [user setValuesForKeysWithDictionary:obj];
            [_USER addObject:user];
        }
        
    }
    
    return _USER;
}

@end

@implementation TreasureRecordsUser

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

@end
