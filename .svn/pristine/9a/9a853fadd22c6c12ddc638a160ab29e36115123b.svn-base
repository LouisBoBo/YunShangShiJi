//
//  AddShopModel.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/20.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "AddShopModel.h"

@implementation AddShopModel

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[DPShopModel mappingWithKey:@"stocktype"],@"stocktype",nil];
    return mapping;
}

+ (void)getAddShopModelWithShopCodes:(NSString *)shopCodes success:(void (^)(id))success {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"shop/queryStockAttr?token=%@&version=%@&shop_code=%@&find=true",token,VERSION,shopCodes];
    [self getDataResponsePath:path success:success];
}

@end


@implementation DPShopModel

- (instancetype)init {
    if (self = [super init]) {
        _isSelect = YES;
        _colorIndex = 0;
        _sizeIndex = 0;
        _shopNumber = 1;
    }
    return self;
}

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:@"sID",@"id",nil];
    return mapping;
}

@end