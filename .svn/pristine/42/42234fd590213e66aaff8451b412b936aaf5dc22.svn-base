//
//  PListModel.m
//  YunShangShiJi
//
//  Created by 云商 on 16/5/4.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "PListModel.h"

@implementation PListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSMutableArray *)shopList
{
    if (_shopList == nil) {
        _shopList = [NSMutableArray array];
        
        if (self.shop_list.count) {
            
            for (NSDictionary *dic in self.shop_list) {
                TFShopModel *model = [[TFShopModel alloc] init];
                model.ID = dic[@"id"];
                [model setValuesForKeysWithDictionary:dic];
                [_shopList addObject:model];
            }
        }
        
    }
    return _shopList;
}

@end
