//
//  ShopLinkModel.m
//  YunShangShiJi
//
//  Created by zgl on 16/5/11.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "ShopLinkModel.h"

@implementation ShopLinkModel

+ (void)getShopLinkModelWithPath:(NSString *)path success:(void (^)(id data))success {
    [self getDataResponsePath:path success:success];
}

@end
